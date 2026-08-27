Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AD4C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSOn-0004SA-Sp; Thu, 27 Aug 2026 01:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSOa-00047A-5y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:11:25 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSOX-0004EJ-JI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:11:23 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso1207264a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787807480; x=1788412280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g7qPAmD5Uc4zNc8vOsv1rG83nWMR8s88x8LyK/YSuMs=;
 b=WWVaQ+3lyeyiCh2Yh4OK2Acdftkixg2hOcG7CO2+9Apb6gDQHKBktr+zRwZ/chSKJF
 5aqrbLHHbDK6E0AvtFHt2sGpMIpR7+XQzc4IA57wxPMoEFe9BFnwbYnyNyG+k+BOYpVU
 vsH4pjqkakV64baW7un0TQsiIAQrs8q4I463fYL0GY5LvGX53yvDORQlvl3VQm7M/ARr
 ImvjhU15p5CGLzrNtUfCTJDF/z5MltLOM4GSVaM6x0gDdPU11A5KNyuBde/CRnTxOF7m
 Wq56VRTjlaviCTepF8WX+wLrXvPBlJzkmk81h4/FjHt8ZyHoy065UOtFpvWpKkvK7iu/
 9jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787807480; x=1788412280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g7qPAmD5Uc4zNc8vOsv1rG83nWMR8s88x8LyK/YSuMs=;
 b=Rzy4s0lPXfyf8r41bsUUGv5oyInPCXJm0WnQqGM+fJGPRJ/YjRpdPlou3YO03T+9yW
 eJzp9LixP6tXSziwbLI/hTNKblXpa5vMDGUEGOoZcq9fCDr7ghDypXoBoq7d3EF3JemG
 SXepTllpWfJP3JhQWt6hjH7hpBaGATOp9pnzE/0JCy4xC5D6zCAK0fh3/myD0Cd9DUJS
 mh/HapguugS5/N2Cs8cnf4zzU+9bbInEz7J/ssNJq8IhYbr2qmyhtzc4dmNEjwiBUHTG
 YJtSdMfLBsjeagyTezfjv5JiKqTc64xcX8uj0dZ7Dj4v5qELez0GZtNcVmxowhd/C5/i
 Yyvw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2teXgt0UWlP6i0tUya6b6yqlM8VrRUB8TOzd3FFIsBXOubUeD9Oeaxbas11ZJWdYWDM6BXqr7WiU9@nongnu.org
X-Gm-Message-State: AFuF++kks5XEAG4XL6kMCHQ6BMq3uTAzt/v1OoeYQXiKIuapWojBm0Sv
 RZw/XwUAhP7AfkiVGw6OrfHNpuJJ9PDcThDOcei2XgtdkfBm9qF2ERkZ
X-Gm-Gg: AR+sD13qjd+cTwGDth41x8QojzFY+77UlpW3HL24+XttYoaPUXhYv3/U8d7iyMaT7S6
 nvDq/WcVBWbI0OHQCVAAK9FOK4rxzKkdl5QapcAhwra5fspL9+XnBgqQRPwP9LYG7P5/A589rEg
 8vE+1Hvu1PN9qZT8js/X7UtcElkTME3nDEsAWlzEbBp3LiuBxPAK2P/vN5RbcK9AO39Tm5XyNrr
 j9thnaVTQ++LdztsDBIYGJ7hJC6UMOzmw+R923TrSfzlxNYnNfEoITskv4oEJihy5/TdWVIpEs4
 Dm+lnQsNV75wargueGPrH458S0Xd+Cu4Drab75A3kzM4BG3E4jqPq16/w9tLxDVdeudV32FjuI0
 WY85OrZqibVkKfo1bApIP/Q4rtb0SzfXzkmIfV5pnRUA0e+cktzOLnTDJZBgfclpzP59zu6RcpF
 QKDqio6u1ID9h3lJc1VYCUI0UVnnee+E7qvVVrKjZCGtnIsiNfZ29UBfFSXfUWbUnU3ESbq5QJw
 Vg536PaYI2Xw7yPleNjppQWQlKJyk4IvnWQ/D0vRZHYz1KRDZmsaTs0Kww+Iylg3FsQ1YcNaYV2
 8511UF98GnyXuKGCzOc7
X-Received: by 2002:a17:90b:5828:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-3966d486840mr26426950a91.13.1787807480024; 
 Wed, 26 Aug 2026 22:11:20 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39670599275sm2210473a91.0.2026.08.26.22.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 22:11:19 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 11/12] configure: Provide OBJDUMP to the tcg tests
Date: Thu, 27 Aug 2026 14:39:50 +0930
Message-ID: <20260827050953.67184-12-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827050953.67184-1-joel@jms.id.au>
References: <20260827050953.67184-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Probe for a cross objdump alongside the other binutils and add
OBJDUMP to tests/tcg config-target.mak so test makefiles can
inspect the binaries they build.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 configure | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configure b/configure
index 56158cd95f7b..b82a43018563 100755
--- a/configure
+++ b/configure
@@ -318,6 +318,7 @@ as="${AS-${cross_prefix}as}"
 ccas="${CCAS-$cc}"
 dlltool="${DLLTOOL-${cross_prefix}dlltool}"
 objcopy="${OBJCOPY-${cross_prefix}objcopy}"
+objdump="${OBJDUMP-${cross_prefix}objdump}"
 ld="${LD-${cross_prefix}ld}"
 ranlib="${RANLIB-${cross_prefix}ranlib}"
 nm="${NM-${cross_prefix}nm}"
@@ -1384,6 +1385,7 @@ probe_target_compiler() {
   container_cross_ld=
   container_cross_nm=
   container_cross_objcopy=
+  container_cross_objdump=
   container_cross_ranlib=
   container_cross_strip=
 
@@ -1489,6 +1491,7 @@ probe_target_compiler() {
     : ${container_cross_ld:=${container_cross_prefix}ld}
     : ${container_cross_nm:=${container_cross_prefix}nm}
     : ${container_cross_objcopy:=${container_cross_prefix}objcopy}
+    : ${container_cross_objdump:=${container_cross_prefix}objdump}
     : ${container_cross_ranlib:=${container_cross_prefix}ranlib}
     : ${container_cross_strip:=${container_cross_prefix}strip}
   done
@@ -1517,6 +1520,7 @@ probe_target_compiler() {
       target_ld=$ld
       target_nm=$nm
       target_objcopy=$objcopy
+      target_objdump=$objdump
       target_ranlib=$ranlib
       target_strip=$strip
       ;;
@@ -1535,6 +1539,7 @@ probe_target_compiler() {
       compute_target_variable $target_arch target_ld ld
       compute_target_variable $target_arch target_nm nm
       compute_target_variable $target_arch target_objcopy objcopy
+      compute_target_variable $target_arch target_objdump objdump
       compute_target_variable $target_arch target_ranlib ranlib
       compute_target_variable $target_arch target_strip strip
       ;;
@@ -1596,6 +1601,7 @@ probe_target_compiler() {
     target_ld=
     target_nm=
     target_objcopy=
+    target_objdump=
     target_ranlib=
     target_strip=
   fi
@@ -1617,6 +1623,7 @@ write_target_makefile() {
     echo "LD=$docker_py cc --cc $container_cross_ld -i qemu/$container_image -s $source_path --"
     echo "NM=$docker_py cc --cc $container_cross_nm -i qemu/$container_image -s $source_path --"
     echo "OBJCOPY=$docker_py cc --cc $container_cross_objcopy -i qemu/$container_image -s $source_path --"
+    echo "OBJDUMP=$docker_py cc --cc $container_cross_objdump -i qemu/$container_image -s $source_path --"
     echo "RANLIB=$docker_py cc --cc $container_cross_ranlib -i qemu/$container_image -s $source_path --"
     echo "STRIP=$docker_py cc --cc $container_cross_strip -i qemu/$container_image -s $source_path --"
   else
@@ -1639,6 +1646,9 @@ write_target_makefile() {
     if test -n "$target_objcopy"; then
       echo "OBJCOPY=$target_objcopy"
     fi
+    if test -n "$target_objdump"; then
+      echo "OBJDUMP=$target_objdump"
+    fi
     if test -n "$target_ranlib"; then
       echo "RANLIB=$target_ranlib"
     fi
@@ -1998,6 +2008,7 @@ preserve_env LD_LIBRARY_PATH
 preserve_env NM
 preserve_env OBJCFLAGS
 preserve_env OBJCOPY
+preserve_env OBJDUMP
 preserve_env PATH
 preserve_env PKG_CONFIG
 preserve_env PKG_CONFIG_LIBDIR
-- 
2.47.3


