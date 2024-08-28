Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF0AC636E5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 17:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjMEM-0005o2-In; Wed, 28 Aug 2024 13:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1sjMEK-0005mh-OP
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:13:12 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1sjMEJ-0000se-0C
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:13:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 219A8A40885;
 Wed, 28 Aug 2024 17:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69F6C4CEC0;
 Wed, 28 Aug 2024 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724865182;
 bh=tDtYbwB/YhvyKuU+oVhSe84C7DG/yQsQ73QFdvJXmLk=;
 h=Date:From:To:Subject:From;
 b=XpoYtJG9Lgv8VgRTtlw34mJFzufjAJ24j/Ju28eyQeKbYse8onVdcm1UuXPtx6mNK
 R6s9e5NY7uOWnNiDHCuTKDK4shj/YP4MfjC2btatmt1aq6r5jtQ90NeP6B9PYMAgmE
 J9price2mVCEXlEvHT/41Ku2DbYWvsDVtV5bJ6KUQgPlq+YJ/kevpywEW6jEbs+VWa
 jB5Ep3sfqmJWi2T9Mqv0zgU63ezEK/ISkdiq7HhKlT3M1w9oVavQcGwA4PcRGS7/7w
 /6clqbmXbHe2K5usafUea2m2uqYQtsyNmxhnTfhEZmmiD8m0s8ChgXmZxEJVW8lmrw
 +zE238Px09A9A==
Date: Wed, 28 Aug 2024 19:12:59 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: qemu-hppa-user: crashes immediately in hppa chroot
Message-ID: <Zs9am5fIuo3eXoKF@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Richard,

I tested qemu-user from v9.1-rc4 for hppa and noticed that it crashes
immediately when starting a hppa chroot.

I was able to bisect the segfault back to
commit 081a0ed188d8d9d9038f00337d331d185a7ae331
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Wed Mar 27 13:04:00 2024 -1000
    target/hppa: Do not mask in copy_iaoq_entry

This commit does not apply to git head any longer, but when I instead
apply this (modified) patch the segfault vanishes:

--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -664,6 +664,11 @@ static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
                             const DisasIAQE *src)
 {
     tcg_gen_addi_i64(dest, src->base ? : cpu_iaoq_f, src->disp);
+
+#if CONFIG_USER_ONLY
+    uint64_t mask = gva_offset_mask(ctx->tb_flags);
+    tcg_gen_andi_i64(dest, dest, mask);
+#endif
 }
 
Any idea or suggestion to fix it?

Helge

