Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0BFCCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 18:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAY97-0005AO-Rq; Sun, 19 Oct 2025 14:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY95-00058w-NJ
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY91-0000ZH-Lv
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2698384978dso26385835ad.0
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760898517; x=1761503317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAYhbIEVnqIpv3UM3lZTlnJP6T433ZQvfgE/KFwrBAE=;
 b=RQfI8GmuC1/KpsGzCsTsqWLPbbbuIzgVRRdXpQHL11KsKOm0sYLAvK4ZqBui/d3qpG
 nBrfGewY1M2AJqnsoKQUXOyoXWdYw2seNzvXqS5HntidQP9nEiqBazKkwkupjRS3m0WF
 +wuhRR+Dc7etZCKrC/SmAFsdMHq6v7IC+y5p2MGOtdCcyR/KHSbGsKmVVgC6LGnOYT9g
 031ZR4Vif1X7POJiFFRgwSyJwpckrM80MOmotqq4DSz1m+jxP5XFxhRf+6jsdr9pKReF
 ybro87cECm6nKOp4eutlU3Y8Kk1AVB8HRuk0G2dQkB2A7dKPbjzGclJSyGtmmB1mDG0o
 LNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760898517; x=1761503317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAYhbIEVnqIpv3UM3lZTlnJP6T433ZQvfgE/KFwrBAE=;
 b=bSu8cgV7/YUc5aCpRCIfwBKEButMFkF1jY+cl2/3qsoor7Ey515wnBlkLnqHtX2mAs
 ba3bIDbmgjenioMg/+CxiIPDpB8cDgk9ro3dQwgIsw6lAPBUQzJr0j+KGoFnzKdyIFbn
 EPvPsQNfwTINuY+IuiOxN1oragZ3/0jFgq2V1gMaHI+Ei2lVcV1NYpWU6/eXWXdgL0yR
 WisuEuaStjPOkzYmELIQbvIpEUPayH6fkEaB+jVk/+FITemaotR2anfYjtlIlx0Punb5
 l2AW+0EYa2Ujzmuv/jfr5Q6oVEpVfnbnEojbulhdAKYtVxCIa8AALsxoYRGVh6+hE8On
 Z6NA==
X-Gm-Message-State: AOJu0YwjU4hNX6TqTe6R/adIW2hmOAM39dq3j54+KwXq+BRVhpMDFplU
 YufgO9nmz1kQqKgK8LcaPuwcLpL7VvLKVmp1hpKSbZYvA6RCSMygH2gRYIcq3vRy0r6SyNi0fd7
 g6HqXkV0=
X-Gm-Gg: ASbGncvGovPo54zottkpLxHneXiAxlshMLkhDzvTXOOOxZfMGepI2JQP6eSeCPHcjV4
 wBskyGaQxKERzrFnj7A4logvlV3da1tUMP5sPXqdKF4DkTicziT3lH07ewgDuVKri+uoTEPfxai
 oJJpt1rTYtzHgzO/Od7PQPKRXoOkWIA0py2gUmbV4pyFp2EY/eoHlHOrpQnz6Y2ddIeoQM7ku2v
 LGVpOlMIxmsjIeIINqEx3BIJVG7IAaLqd+DDW8eQo4bv1JbuiiMVH+omFJvkiOlyNmdxhS7teoJ
 6okccjbQjKFRvZP7thNEQX0j+yrdJpIPbUFtRxod+wqGTXo2tkEosz3rHtuk9vo6KqH2eyOYCnB
 IURMAEpcMLY10rMQOJTDv1mxpZwl3csyXf1slIvZmDBFcVrc9Eo9P8q6ZiGXG6XvrdS5kQSn+rO
 2O2kNxBW/RG59Sereq
X-Google-Smtp-Source: AGHT+IGZye/y9cvU3r+6Vk8P00+ttuOfroBP5EjFw/lvymGB3T04YVW53B/0W72rWissYo+uMd77yA==
X-Received: by 2002:a17:903:2306:b0:240:9dd8:219b with SMTP id
 d9443c01a7336-290cb65b6camr156117885ad.49.1760898517280; 
 Sun, 19 Oct 2025 11:28:37 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebccf3sm58985775ad.1.2025.10.19.11.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 11:28:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 2/9] buildsys: Remove support for 32-bit MIPS hosts
Date: Sun, 19 Oct 2025 11:28:27 -0700
Message-ID: <20251019182834.481541-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251019182834.481541-1-richard.henderson@linaro.org>
References: <20251019182834.481541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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


