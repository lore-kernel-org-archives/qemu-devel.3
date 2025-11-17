Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFEACEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2mY-0006bU-Iz; Mon, 17 Nov 2025 12:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2mW-0006Yz-RJ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:12:49 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2mV-0006kY-Eg
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:12:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so14688265e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 09:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763399565; x=1764004365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsnbT3j0Gpb5qxhin8xm580J8CadoBQUdRwStMHWYw8=;
 b=Cx7o6da0txeaZD8O7D+Ev8qIx9DaGzGejUQy9Zr35C8yAplWvy48WijnzxDXpA0Sz/
 iEByiwzjbd3evW8Prf8HwA0B8oHnd6cnHbKC925QTFm2c6eCdnO8IEGWVvmbQFhkNl2n
 PdiPCsnXXQ9Ilo/WIlTpGzf1Je7hGi661d1Qu0t86Pos/qhqWbTlGto/lvTkJDcTmM8S
 RnbSTFLwJZ1evGpnwVQ0d1hlLmfCHFkAWXrgfiMl7aXljJz+vVDkg9cmhdgV2GTKR7Jn
 Ex9dulwaua+9RanZX5mwY3aMlFT0lb09TeCrckYA1pjCeQFY6IVII2cdVK1cVqfUQR+S
 eJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763399565; x=1764004365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YsnbT3j0Gpb5qxhin8xm580J8CadoBQUdRwStMHWYw8=;
 b=Lg7x2msf/e7C9JgAhKMSNUF61NN1i02/pB6tRoIb3yLzbhwnorYolwJpQMa3Jtci/A
 wBAvSJ11ZGw0SgQ88uuFehW2qVtky3e38pQeD3uk9ADIWT1ODi4EyHfUHhwpTO3pKXpJ
 VrCDbLXJr5Zroiabo2UdRGRRuRa43iZ6EO6aWqB4UVLGoNbAfBJ/pz1xsHZEcBAbqtp+
 sNJFFxRUtSHW483RVF0KeCaq+Trx2blK/SrrbD8IPi+SXCt5wjQJpZlEHQI5Gqqqp5ig
 5AScxcOFOg3U7Z4qKXt60qeFCbA4O60/pSTP02WL7SHR6IixoUi0ZPAZsO2wfI7VXVI4
 RYVA==
X-Gm-Message-State: AOJu0YxZ/aug/I3B9BBwMgraVGSfUM4qlUBLFDFeRUCUK742j5dJWC12
 mc7Pj01aI7ZIiC9gb86+PBo8118q7OXxB11xCKSIPrgVQj3+YnQu6uqPX9DX7JFn3E2fhiDG/ya
 Iouwd+2b6Ig==
X-Gm-Gg: ASbGnct9nrBI3jt1RdoMtXJ2NI7ZlCxb35zlbgnYB+BV1iJXZ5xFMBtNZXZm1OA31j4
 l1fDxcOTPWF55fveDTOq1/4L6lW5rY5oQJGYybvhthUwBacZ3r6kZyrfPskvhtx7gYgXsEKLuoH
 nvFBTrpGqeOIAwHMm3z37MqgGkT8mAi1wyGj0FHL1Ppo2w+QB10WJvKvc+CIR3ApGd4joDPc4ND
 vmbnU77+ipfoSmHzybscXvb3e32+S6FKxXpKyQYP76Qwi9Qt25BHKJjCbI85ZNR3RbzF6V8dowS
 JXc+igbGTMjnfBw3OauhzpObMl6mht9wNOhuOLavHCpNpPDRZy+5yTwgxvbQbiNo8QNQxwhRJeD
 Z5GdirrNElDkHHmTlvtDycZn+ZvCKmAzAKYhxuIL8iYJd5br32KyCO+Nc3OskaE1Ib89B2Tt1QV
 7OJ3TfO/rlIiorISmL23IdPkRE/HijID7ze2//loOLnQYNrSFY+lvkn6Eb9d4K
X-Google-Smtp-Source: AGHT+IGPeZKymHnrjOzuK5zzaCNRsRtlct9fg62Qz/Lt87PmXf1rGfMxrXx0sJvi7bkVI2M5235LdA==
X-Received: by 2002:a05:600c:1f87:b0:471:9da:524c with SMTP id
 5b1f17b1804b1-4778fe69a76mr119428555e9.12.1763399565519; 
 Mon, 17 Nov 2025 09:12:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779920f2cdsm163790935e9.10.2025.11.17.09.12.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 09:12:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-10.2 v3 1/2] docs: Correct release of MIPS deprecations /
 removals
Date: Mon, 17 Nov 2025 18:12:34 +0100
Message-ID: <20251117171236.80472-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117171236.80472-1-philmd@linaro.org>
References: <20251117171236.80472-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We are going to release 10.2, not 11.0 :)

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       | 2 +-
 docs/about/removed-features.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 03e29915f0a..30ab72b2a4c 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -192,7 +192,7 @@ The ``info capture`` command is deprecated and will be removed in a future relea
 Host Architectures
 ------------------
 
-MIPS (since 11.0)
+MIPS (since 10.2)
 '''''''''''''''''
 
 MIPS is not supported by Debian 13 ("Trixie") and newer, making it hard to
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 88ea0dc4edc..a72df26dd24 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -896,7 +896,7 @@ work around the atomicity issues in system mode by running all vCPUs
 in a single thread context; in user mode atomicity was simply broken.
 From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
 
-32-bit MIPS (since 11.0)
+32-bit MIPS (since 10.2)
 ''''''''''''''''''''''''
 
 Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
-- 
2.51.0


