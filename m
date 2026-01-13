Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D2FD0C855
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcLY-0003BU-IV; Tue, 13 Jan 2026 06:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLV-000396-Oj
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLT-0008Rr-5O
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768302834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aI8nc+0Y3FBtb3DTLUVxBO8sB/nyzLVfQTim1m8lj6Q=;
 b=PAazTwZ5twRyPGMWIGqPdLE0bncw4lK/XfKkU+B8emZ9NsK7M/5p1wR7rnW1zu16oOTUnX
 /UfkQuI2E1dd4TBPKBOvNQcZI9Bp296nzVpOazrtEdv5VO/2P11EGHSaCpzv/XJTgWLQeF
 qhTy4GsCzQYbx2/exsgsABPEriIAqlY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-N2L907QvMpe450S9irQXGA-1; Tue, 13 Jan 2026 06:13:53 -0500
X-MC-Unique: N2L907QvMpe450S9irQXGA-1
X-Mimecast-MFC-AGG-ID: N2L907QvMpe450S9irQXGA_1768302832
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779ecc3cc8so51666945e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768302831; x=1768907631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aI8nc+0Y3FBtb3DTLUVxBO8sB/nyzLVfQTim1m8lj6Q=;
 b=UOj2opeAbWOU06rU/AuFEjWUVqsD6Zrm0YopozBEfkon/GaVaIdb8c3o7F8QEqp5Ax
 9JkR41NRv9w4SW3OHz5AIdHfFkIlo0IaMNFFnjWy0Ws71Ut73hCky27XDiL6a6kuW9ys
 iaen6kitPDctnn35z/li/cF6yiiQQyEZtEIz21UheGFmCZO87LZsP7t5f0Mmc0L+3+oN
 wpUfc3ZhA8MDMBhL5cKYBz8irnZL+I+wXSvzSC7Jp0qX6jKQWxA5lQZ+NcdtjGFVFT1Z
 6KVEDIRiHjXAO/WHc1wWZp3S3/iNcSXbVamDnc7pTNFrRf0UBN1HYVQbRuKz/jjy+Zp/
 3PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768302831; x=1768907631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aI8nc+0Y3FBtb3DTLUVxBO8sB/nyzLVfQTim1m8lj6Q=;
 b=k091/LbsJhKAqvn7Os9Z1rXtsemJnkyvqdMJ4RaekPF30ydazbURn1rsrLlHE5JIdq
 0UCUwzqP/VtciUnYxx49areNDovS5LPcuLsn2ecZ+VBFSvXxVq+WOOL9fPn1mePC8V3O
 iGbR9vSpMXvw/HMujexXwWbu87ppP1cgjFCmbSONpTWYZpftFoEVNwze3xVNoiqpeJcz
 7dA8XyVfGH5QFZoXnojBrSlvMFQbveLJsVGefSTRKjd6JCWmyFH2GV5jq7LEC4Gkvx8C
 xHPL8lUtAm4BeBDtQLVcP0A8VLR3v0NtMKbIHX4SUPtNCm/gSBxawCdRY8mcsoHBdW9h
 ABIA==
X-Gm-Message-State: AOJu0YwIetngCKVx3GFnf6r+WyXmk3tBIagvAuZuUoyGyF6hBRMRY+w+
 q2GL8A63MwUQROpa9RHey+3JvvXiEMbwJjILVEpc1qDC5hNMkgKZN+BflxTjwGdD/LM7qeqM/G1
 kZz7P3NKrrY7XvPJ8PzYz8EF0M2iW11XHFMNoaYeGrPvQRLMarXY+B86ONN5GoQMVSppCQoTgAq
 bxqK4+41SeipK3+fHKVClZr/UjZ1XplAfM/n2LGrBs
X-Gm-Gg: AY/fxX7k6dwwNZCrlGHSgUCrqLt6agaOLg1py1ddeIp0GjjwQjnSoeB3fMulgrL/Vzo
 KwKwJ4o5CUZRSbxuZV5Z4Q72VoXGruzZVyNR9n+EUf7Ly+T/Vaaoh2qYu+tV5oDvvqZx0b2IFTs
 kHaXOPN+CLuvTUrcn5hI4vRrUDmZH+RX/o+n6/rVkNHHh6HM5hvJOmfX54N+lRaqz9M09EBbTGA
 kJWETxMnfTbQmtBVEOm8DwS1OVNbTwLhLI4pCaiIkwzOhYyMD5i3CSzSlh+Vg1O6gpZ9Nmuguwd
 PA9yK7IdqYcIamtr50gOZvBc7PAOX5XYJlydtoR5lukZ/w1pvQswMh+fzoGD1vp/B3nRVRhkTBX
 Yu3S8miGYdi6G26ZKDXbnBklHim+zFnEJMLWSTnr8vsZWsnXtE76Q7uYU2rN0th0hySUlxoU/Uc
 3vaBLDKt7a/7UA8A==
X-Received: by 2002:a05:600c:8b2c:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-47d84b186b4mr221323515e9.7.1768302831448; 
 Tue, 13 Jan 2026 03:13:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZK4ASfgxJhFFBIyVhu10frPcEyB1FSdZ9Qxo/SeOq9jj5yGf4hBk6TUt9JssekFUITQ2/Ug==
X-Received: by 2002:a05:600c:8b2c:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-47d84b186b4mr221323135e9.7.1768302830902; 
 Tue, 13 Jan 2026 03:13:50 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47edc05b267sm24167105e9.15.2026.01.13.03.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:13:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 7/7] rust: Update Cargo.lock
Date: Tue, 13 Jan 2026 12:13:33 +0100
Message-ID: <20260113111333.1138160-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113111333.1138160-1-pbonzini@redhat.com>
References: <20260113111333.1138160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhao Liu <zhao1.liu@intel.com>

`cargo +nightly build` updates Cargo.lock file.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260112090900.880621-1-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 42ae857fe53..78452c3db9b 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -1,6 +1,6 @@
 # This file is automatically @generated by Cargo.
 # It is not intended for manual editing.
-version = 3
+version = 4
 
 [[package]]
 name = "anyhow"
@@ -233,6 +233,8 @@ dependencies = [
 [[package]]
 name = "probe"
 version = "0.5.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "136558b6e1ebaecc92755d0ffaf9421f519531bed30cc2ad23b22cb00965cc5e"
 
 [[package]]
 name = "proc-macro-error"
@@ -392,7 +394,6 @@ dependencies = [
  "migration",
  "qom",
  "system",
- "trace",
  "util",
 ]
 
-- 
2.52.0


