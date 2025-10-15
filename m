Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD4FCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v99D9-0003d6-O2; Wed, 15 Oct 2025 17:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cu-0003ZX-H9
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:54 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cr-0004zN-Lm
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:52 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b556284db11so9387a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760564326; x=1761169126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAYhbIEVnqIpv3UM3lZTlnJP6T433ZQvfgE/KFwrBAE=;
 b=EOS0cwpIz+xmqa7X7SANLJ4wiRTkQJGxcylxb9/XtcEL9Lp2fJeFWUZ5LAOKLLAoxH
 Mm4pVnxEJPozkNAIHtjsytTp+T81cyaS4Wu0Y2iYNCtzemsfBVeorsDlw0c8QP4XNgBw
 7zUiHD3kv0Fh1h9idfzCSC9CNZCtDbOxRMcPAIDfDDzCbv5+eqxXAEKfp4wMHxZ8keNo
 mDn3kbiyRSMHvE5FWAoyzkGtaqHK43gtNT68FW7IjxDz3EJUCZYelfiyGGPXcsdhG6z/
 B1V+i10te23g1HW7/HaO3tHIfn+Z09zxDRx1JJNODjs47D2zzJasRlOofQuJ92pgr4f3
 d25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760564326; x=1761169126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAYhbIEVnqIpv3UM3lZTlnJP6T433ZQvfgE/KFwrBAE=;
 b=SQp/BwoZnis254/dPFKs02CJAg0sgALNcgmVKchfN08EUeJwYTp6/75ZBkQgaQ0f5b
 laoOhvjGmXorAuhIqWnhzdaGJ4h1zHVQhw/Qdm6UWhOcYLsRo0k7jx7KNfiZo6CW7eDM
 KXK5UzIpBPSVqWSb6owrl1ODpXkuFC5DuSf1QI4+ABFXLTh0uk0aKaCtrUjqfEQ+l2H4
 Xkb1vE7azqmf7lZbgl8lUKa6NjXC1k280mV0qcp0r4L9ZFGj6X+uCvdxrOi7E7wln3as
 TTjdzkf0Fl7vTpgWCZbvXDdC0cW1O6ZvfVKb62mjK0SoqYZdWYrpRSHgq7CdQGeue9Oy
 Ntnw==
X-Gm-Message-State: AOJu0YxPYG+gX05TLGrBtozsU+H1TqZA39hCqfoQHRn1IjFoSWBJg4B2
 a/fqSOAZ5flZ+rYQDGEQ7oaA0Pt3k0VntBAN2KqBcyDP/N7QEgpN5Cyng8HP98RljVFszwiBytC
 tAXenj8Y=
X-Gm-Gg: ASbGncuoBf3enD4zEGhDcUDHOuVAkQkxCCatxrKDSFgHyE0W+lDiX3hD/urE1SUXf8C
 D6zeVNAv1RnbNnY5dHo7iRJtrnFdijiFpMLcbUjAuZgNdxKVpBHpxDAinycPITFxCYGYKKocv0F
 hI2GfHv6y98ZVBPJADHFnN+Jer9Pfng6He0so5vy0HL7w6lBOSieI03eZW3JlRF1BECzAJbBz6R
 sXd8ErW+EqbMvYlvYJ0moj8dsNboWgp77BNaF27cReZtUlaEjCWi4ggVdjJWZBI9sqfSHASN1A9
 6/A7SmXtK/pLawbL9cmR9MI4v3XnIMuhgVta9apir04fcJyc7M3zobXwADO+sx+HBCoteZCjJVK
 xTDToyGi4Yw+pPFhmYyYcVFIUaHkE4HpuSHj+goYMPC2FheA2XviP3bPEVvvQmgXqMD6QpycT+u
 U2eIAS8z3y3w==
X-Google-Smtp-Source: AGHT+IG3Fiee+q6ZsRd6DdW+tRA2GhDykmoEAWgA0fSiqmghTMpfCDeGTySsxkb1oDSTMgAcQeAxrg==
X-Received: by 2002:a17:902:f641:b0:28e:cc41:b0e1 with SMTP id
 d9443c01a7336-290273ef139mr365369485ad.36.1760564326481; 
 Wed, 15 Oct 2025 14:38:46 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm6247085ad.65.2025.10.15.14.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 14:38:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, alex.bennee@linaro.org, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 2/9] buildsys: Remove support for 32-bit MIPS hosts
Date: Wed, 15 Oct 2025 14:38:36 -0700
Message-ID: <20251015213843.14277-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015213843.14277-1-richard.henderson@linaro.org>
References: <20251015213843.14277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Stop detecting 32-bit MIPS host as supported, update the
deprecation document. See previous commit for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251009195210.33161-8-philmd@linaro.org>
---
 configure                       |  7 -------
 docs/about/deprecated.rst       | 13 +++++--------
 docs/about/removed-features.rst |  6 ++++++
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/configure b/configure
index 461b53dd60..8263f81370 100755
--- a/configure
+++ b/configure
@@ -404,8 +404,6 @@ elif check_define _ARCH_PPC ; then
 elif check_define __mips__ ; then
   if check_define __mips64 ; then
     cpu="mips64"
-  else
-    cpu="mips"
   fi
 elif check_define __s390__ ; then
   if check_define __s390x__ ; then
@@ -473,11 +471,6 @@ case "$cpu" in
     host_arch=mips
     linux_arch=mips
     ;;
-  mips*)
-    cpu=mips
-    host_arch=mips
-    linux_arch=mips
-    ;;
 
   ppc)
     host_arch=ppc
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 98361f5832..dacf2882e4 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -172,17 +172,14 @@ This argument has always been ignored.
 Host Architectures
 ------------------
 
-Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2, MIPS since 11.0
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+MIPS (since 11.0)
+'''''''''''''''''
 
-As Debian 10 ("Buster") moved into LTS the big endian 32 bit version of
-MIPS moved out of support making it hard to maintain our
-cross-compilation CI tests of the architecture. As we no longer have
-CI coverage support may bitrot away before the deprecation process
+MIPS is not supported by Debian 13 ("Trixie") and newer, making it hard to
+maintain our cross-compilation CI tests of the architecture. As we no longer
+have CI coverage support may bitrot away before the deprecation process
 completes.
 
-Likewise, MIPS is not supported by Debian 13 ("Trixie") and newer.
-
 System emulation on 32-bit x86 hosts (since 8.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index a5338e44c2..53829f59e6 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -896,6 +896,12 @@ work around the atomicity issues in system mode by running all vCPUs
 in a single thread context; in user mode atomicity was simply broken.
 From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
 
+32-bit MIPS (since 11.0)
+''''''''''''''''''''''''
+
+Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
+maintain our cross-compilation CI tests of the architecture.
+
 Guest Emulator ISAs
 -------------------
 
-- 
2.43.0


