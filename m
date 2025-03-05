Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DCEC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdze-0001Hf-6s; Tue, 04 Mar 2025 20:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzH-0007hk-T1
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:56 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzD-0000VT-VE
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:54 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223480ea43aso156445295ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139750; x=1741744550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqlXuHoQttbFjb7GklM7QN7V3vl4gqchpKqjbHsAjDg=;
 b=WHGwnhJAMz9Hz01LrcvmmbhcTeIlxGwRKJ4KEi26YfxTl9m5UKKrDalR52VW4EyD23
 ZpuFdzPGZudbs2SNrKKo4VIH1gerNKoc5qJMd+JNz6NEADsEhb28zCJzvoYCDPHEH0D6
 fXkAv4Y51TFrjRML0lfRRXuuUCo5ydQ6DPK2ZznZOuHrizOme+r+dTo0CWWSdq2JCmyo
 TgqfRqkYb8N88+U8D8kwBTLvMT091+vuTW/dWJO0+ZgDLztJifTKFnS+mKYQc9agZoTJ
 Z3TOLOMdGMbapmXGFgiUGyIgLB3XBiqHR7S6yJI0OSyRwkYIdxp0pX3SY2lPryWacDen
 VpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139750; x=1741744550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqlXuHoQttbFjb7GklM7QN7V3vl4gqchpKqjbHsAjDg=;
 b=I65yO3+XDHo9o6jw2Oto/P/NeV6jb1TvBn+4qUvz5PECMT9mFPYeJQdqZTA/UUwRjx
 sgxivZrvAe1jv8jU35/VAbHyF+aGYxtg2wspvnNAiXPgelCgzirX5b6VCZ5nc65xbOEJ
 sieMtxXTBHKkASRcCmg7ombkbaoOPLeojjvxOjooSmpoXvmfPzFSvnm/srRKJZQM3w3q
 ZR1aMy6KzBicbceImnub85FJCLHkgo+Jf4hCfnFhkvs7hM4kIg1qpJ52OJoPVwZR1tkO
 Z2xSjGEDtK5LzNb2j9Sw9KVIIHFGd8t23P0+K8sHatXIlXjRXZeCvRFj0Ywpqe7N2St5
 GtMw==
X-Gm-Message-State: AOJu0YzaeaDWCGCA86UalXJBDE+pl3fWcNO6N2ZvNdcMa1luKbyelVsg
 ORkfNDuQi/mUGerPZ33pwOczPDIWDe2g+OndD2LWVMrkBIYUD0mxB1/txnUN8ac=
X-Gm-Gg: ASbGncugwHcbG85mWxe0VQt0we7UiqCEZCjzD3gUR3ORGlVVkLMvyeRm0TaDNF1+xAc
 0P9FNRuvjgLeeXEdv/U1oF+Q1RDOBTolp1qMG3mqMdSqdvhja6j++H0zcRQIpdiHSt1UveTEB56
 hGU3SfkxoGNDMDqrcmivdEqDlOF/C6qTznGRyT6SinR4B6lMbKR2HeUv5dAef96nOCvDiVYhQc8
 k83kfpJoEdJ3vu2UMWe25OYtI2Fch4Tttsvs1TnXMVpjcHr2N8qIdW2f6aiGtrW85szC/3b7W1r
 GP7/k/xlDUtMW+nhbqXYzfrlrHnTrKAUB53e62Rvlhvdu2ZqL/JLz91X1gCc3g06CQKyBcmRYAC
 YTKk0orGh+Wbi+lMqkvh/Gz1REKb2pRrei74oEISOeb0KiqQAsMc=
X-Google-Smtp-Source: AGHT+IHRnoyiFNoA8awxrW/PPd7PJ8O8t/G0gu5rkTWbtmiitsaRy3uMY/u9QqvKlpfnBiur9GKBEg==
X-Received: by 2002:a17:903:2f8d:b0:223:6180:1bea with SMTP id
 d9443c01a7336-223f1d212bamr23886325ad.37.1741139750341; 
 Tue, 04 Mar 2025 17:55:50 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:49 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrea Bolognani <abologna@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 53/59] binfmt: Add --ignore-family option
Date: Wed,  5 Mar 2025 11:53:01 +1000
Message-ID: <20250305015307.1463560-54-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Andrea Bolognani <abologna@redhat.com>

Until now, the script has worked under the assumption that a
host CPU can run binaries targeting any CPU in the same family.
That's a fair enough assumption when it comes to running i386
binaries on x86_64, but it doesn't quite apply in the general
case.

For example, while riscv64 CPUs could theoretically run riscv32
applications natively, in practice there exist few (if any?)
CPUs that implement the necessary silicon; moreover, even if you
had one such CPU, your host OS would most likely not have
enabled the necessary kernel bits.

This new option gives distro packagers the ability to opt out of
the assumption, likely on a per-architecture basis, and make
things work out of the box for a larger fraction of their user
base.

As an interesting side effect, this makes it possible to enable
execution of 64-bit binaries on 32-bit CPUs of the same family,
which is a perfectly valid use case that apparently hadn't been
considered until now.

Link: https://src.fedoraproject.org/rpms/qemu/pull-request/72
Thanks: David Abdurachmanov <davidlt@rivosinc.com>
Thanks: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Andrea Bolognani <abologna@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20250127182924.103510-4-abologna@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 scripts/qemu-binfmt-conf.sh | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 8d9136a29f..5fd462b1d1 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -205,6 +205,9 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
        --persistent:    if yes, the interpreter is loaded when binfmt is
                         configured and remains in memory. All future uses
                         are cloned from the open file.
+       --ignore-family: if yes, it is assumed that the host CPU (e.g. riscv64)
+                        can't natively run programs targeting a CPU that is
+                        part of the same family (e.g. riscv32).
        --preserve-argv0 preserve argv[0]
 
     To import templates with update-binfmts, use :
@@ -337,7 +340,12 @@ qemu_set_binfmts() {
         fi
 
         if [ "$host_family" = "$family" ] ; then
-            continue
+            # When --ignore-family is used, we have to generate rules even
+            # for targets that are in the same family as the host CPU. The
+            # only exception is of course when the CPU types exactly match
+            if [ "$target" = "$host_cpu" ] || [ "$IGNORE_FAMILY" = "no" ] ; then
+                continue
+            fi
         fi
 
         $BINFMT_SET
@@ -355,10 +363,11 @@ CREDENTIAL=no
 PERSISTENT=no
 PRESERVE_ARG0=no
 QEMU_SUFFIX=""
+IGNORE_FAMILY=no
 
 _longopts="debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,\
-persistent:,preserve-argv0:"
-options=$(getopt -o ds:Q:S:e:hc:p:g:F: -l ${_longopts} -- "$@")
+persistent:,preserve-argv0:,ignore-family:"
+options=$(getopt -o ds:Q:S:e:hc:p:g:F:i: -l ${_longopts} -- "$@")
 eval set -- "$options"
 
 while true ; do
@@ -418,6 +427,10 @@ while true ; do
         shift
         PRESERVE_ARG0="$1"
         ;;
+    -i|--ignore-family)
+        shift
+        IGNORE_FAMILY="$1"
+        ;;
     *)
         break
         ;;
-- 
2.48.1


