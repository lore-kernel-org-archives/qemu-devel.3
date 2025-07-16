Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6500C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzpE-0004JP-5I; Wed, 16 Jul 2025 06:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmQ-0007x5-9w
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:33 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmK-0002UB-D3
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:29 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ae0df6f5758so1116045366b.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752663262; x=1753268062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qf+PnWdIkiphQ5QGLQu7zcsLA5/XFsdRGuwxEcxIR5A=;
 b=dZs3WEOi42YDpkMff/WQm7Wap7c5JT8Q3300yncZ7O+ixoxxKT0nDKBu76OVlmN+nS
 hrY714yfLM7SILDiwI2WUBPFgC9C2VAyVUVN0Gb6z0ZjpFahOgJSx/n+8LTFQZo4JHvI
 9ObyeU9hcdryGMiGOwTPHH5T4I/MN5mV7vI/NwkiAw+7QkbkJUE4OUDAMuCLz1rvL0V3
 UD4FQ20mYvc4i4FjuMcio1oZ1J6v7t4z8cS8LXpg8V5ztNYj+zA58tE2P+m/MwNAlTbq
 DMoMcUwg1F3S/8J/TbLfkVuJMPumcvsCeAAqXOdXNHaLBu0PuNWMrnC8OALc3XLkXV11
 VzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752663262; x=1753268062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qf+PnWdIkiphQ5QGLQu7zcsLA5/XFsdRGuwxEcxIR5A=;
 b=I4q2RmlMGjiPoMTpJfJpUM/qWF508nFLhEHZdfP5E76UPZGMItjG1KBB8KKVzBkN0I
 vKa3tqeUYhKZ2hXeL1K0yjMNOiyPaymPWJy9HBmkfIOJg9XdimMheUsBsxIV7lQo+RP0
 hB0N2+OXDNLBkwdqLAn9YmwsEcadZpxJds3S4xyXN93PobIa/88ayQ3oF0NCxedhuE24
 YG0gDnyY6vJUcP0EzT3NIY7ih4OWRONkLd74dKTsFSad48yKVbc09jHEzrjFlI9estjn
 118mgn48bDX7SoQWYp3HaNJfOIwGSH2E6hO4prliYl1VdG/WGgsJ+Ci556bksB/CW5jG
 L5UA==
X-Gm-Message-State: AOJu0YwQAQp0DVWUv2MNf1leLy0hl8H9dIJ3hJRS02LfiYr9fbAAJfzA
 yyx0UCTwxtbpCrwaSkYzppgr7kDIOGpXDWY8wpNu/xER4mTwTrfJpoXxf9MNY40L7QY=
X-Gm-Gg: ASbGncvby4Ni+SFYAiG3rG2WD4XuxHnEkeYtNYBRS2gdSYk/KuShuUAaYYc+S6WfkrR
 RZW4hD2DJvzICQFrhDeI3rXfPw4XnxYED1IYAaVaid2MnC2pqFizBH5sTsdg0J0/88NjPX09tWe
 MZh2frK9++Pvx67Kp3AGw9DqXcwcvSV0lkU0t8Z3bhz3pcHA7VV1XqCgnmThy4Hoy/5O1WpeQhE
 MMVbCI0zFoDWMTNT1LZH84kVYv/9pKxkFf2p1lEUpiNt9niyqHekYb87LPivRiNuo1QjZAQh+uf
 lSIudHvrAYf4c8gnrxagWhf+I70UgoVPU/7JL7a6664X77/nMQyPxLh3vxWD4fAzluKEtcxEHfU
 rm8hgZ5DIwPvG+OU/JRlc26U=
X-Google-Smtp-Source: AGHT+IHvYCRryBOz6lIo0dwazEA8mRCi3nA2n/hRMTPTQ+7FvSTIxvrfhtfy7xChbLMIqrNVVy1sVg==
X-Received: by 2002:a17:907:12d0:b0:ae0:cccd:3e7d with SMTP id
 a640c23a62f3a-ae9ce09465cmr118927966b.33.1752663262168; 
 Wed, 16 Jul 2025 03:54:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e82dedc0sm1165536066b.160.2025.07.16.03.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:54:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7084D5F8BD;
 Wed, 16 Jul 2025 11:54:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH 6/6] docs/about: deprecate add sparc/sparc32plus-*-user
Date: Wed, 16 Jul 2025 11:54:14 +0100
Message-ID: <20250716105414.2330204-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716105414.2330204-1-alex.bennee@linaro.org>
References: <20250716105414.2330204-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Even with a toolchain *-user is still broken. Maybe we should just
deprecate the target. I haven't deprecated for system as we have
functional tests that work and will continue to do so.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/about/deprecated.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d50645a071..c2199129d8 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -267,6 +267,14 @@ known-good implementation to test against. GCC is in the process of
 dropping their support for iwMMXt codegen. These CPU types are
 therefore deprecated in QEMU, and will be removed in a future release.
 
+``sparc`` and ``sparc32plus`` (since 10.1)
+''''''''''''''''''''''''''''''''''''''''''
+
+Without regular testing these targets have bit-rotted and even after
+scrapping together the seemingly last packaged toolchain we can't
+generate binaries that can currently be run.
+
+
 System emulator CPUs
 --------------------
 
-- 
2.47.2


