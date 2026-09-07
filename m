Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4619C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3YzY-00067s-Qo; Mon, 07 Sep 2026 09:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3YzV-00067Q-JI
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:29 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3YzT-0004zj-My
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49b0d8bc2aaso44797455e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788786145; x=1789390945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rXw6DPR0lE4RgYwCOQwi6dKav//13vR4aZJMzDyd++E=;
 b=dxJHPNNWRagdp721PGwkBHPsXMXv0q+1wRA7EXianD5knY0gEgc4bL79+Duji+MOZ+
 cj1jy3U5CpvQEhVuMHMmJgRk25D7E1ggPwO41oBrkfFZWN8o4x4LGyes7gAlR2XgR2I+
 /GT0r/YlUepVClyeUsdCFDtiOzjn7YwbUJyPEYsnBzikLkIAy5sLuTBCt667hiczKm4d
 4evIzbw+CpNv0MyyR8yMw1D05RC4OrayFsGkza2E/RguTvIMbC1selquy62EYji3cj+Q
 6sTwexnNhEpBRt256WFsgFhGKO9gQstsbDDRATpXDQpb6TiACWq1PvIcLsvvSMkMWlj8
 SGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786145; x=1789390945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rXw6DPR0lE4RgYwCOQwi6dKav//13vR4aZJMzDyd++E=;
 b=tHAUUQ4ovKMR501Hs0nyXoh+nbd95WeJeZdSF4r4eNFUoeAWYUCogWmgGDP92C04kn
 TwNQID7gPxtWXJpLGRa//QCeBjZFv0JDyqzdQd1b4vMUkQ3GhVzYZvTygRiv+ELN8Gal
 IRRxeJFag0hCW9eeoRqGW7odk07LGltcj2skZlvvUPBKJZJ4bT0WCYk9SR8KqzDogA5G
 qwk6cRnY80q/dTVoXtABw+IwiGHxGa48dLRJgjutlxNvApO2nnxvLiVh3aN6tkcDViPi
 Af6ICrMz2enWqgofVIK8U6cWM3qrPYcAnuCymzM+yMg1Vj/4T0yjROuQC+ncS+As/Op1
 27Tg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWsOicrUEV5Cju8AIuuhXW2Svq/7siLbkRiX0/rHdkz2jkSP1dZiMua1KcwcqYFRsIRLfvmLvxuRva@nongnu.org
X-Gm-Message-State: AFuF++kAZPJ4x0SQDe58jsCQRhZViU8iWSyn8I7E7T1Fkv1GrBc1l9H2
 wl3L6pAJM8AfLiRyzjXpL2LK4zpYbXUCR71JPe7YfFOoC+t6LOD3NeWhNfNxZyhfKM4=
X-Gm-Gg: AYBFou1hUBEUBD1b4cjQ/Rquew328mdbdOqSnn48SCv6DOFuHfe4GScqkZ57aK3pv/w
 D1ssteCWmh6pgcHzr8YfRW6Ab94qAa0E97qQbZu7h5hTOZALWWcYn5Gx3LZaPT7fKhsh/DpZbsn
 pX5J7pH++/Cewo4GITxN+MdpehS63GQhgZPSkfE94o2aw0ecdPhvxaABnLgxHG1dsbTdYBEDiuC
 tW/jbpsUZIRHELyGMVuYK4CN7iy6OyuTnAojGCI29QOe5aawGp/L+nhFBkT3j5ykkQxpVmfswBz
 hGWt4NrvnyFJKS/vXV+kvz6xrpW5nV23gGRCIP5Y5aUPU+lmZKrCyCjRxXMl02pFB8mL3CjfkL7
 U9aW+vvnAdfBFXplSA9gxyn8wLJAaNxA8+/XgdBs7392IhfIyRr4TfD8Dr5Ve2RALJoGxSltdWs
 oW4CC/CrANBW0gkBMZ9VzjoEhKdGki23OyG6q7jo0nbQzS2bOVSte7M4zReA0k6HPTshWTC3dTA
 SEXshBpSlbtkMkn4X5w4/B5IT7q8S9fSJVpsB0G5dxLzlJjTwek+ISwgqYN9tCD++eVllM=
X-Received: by 2002:a05:600c:1914:b0:499:60bf:c6f7 with SMTP id
 5b1f17b1804b1-49cf8269fdfmr222262875e9.13.1788786145374; 
 Mon, 07 Sep 2026 06:02:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm468589935e9.9.2026.09.07.06.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:02:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>
Subject: [PATCH 0/8] target/arm: Fix AArch32 Secure banked reg migration
Date: Mon,  7 Sep 2026 14:02:15 +0100
Message-ID: <20260907130223.3148989-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

This patchset fixes a very long standing bug where we didn't migrate
the values of the Secure banked copy of an AArch32 banked coprocessor
register (https://gitlab.com/qemu-project/qemu/-/work_items/467).
This is something that Tao Ding sent a patch for back in July:
https://lore.kernel.org/qemu-devel/20260717174412.88258-1-dingtao0430@163.com/
I didn't think that patch was quite right, but digging into it I found
a slightly wider set of problems than I expected, plus testing on
a bunch of configs was a bit tedious, so it's taken me a while to
get something ready to send out. Sorry for the delay...

The underlying cause of the bug is that we store registers in our
cpreg hashtable with a key with one format (32 bit, QEMU specific),
but store them in the (index, value) lists for migration with an
index of a different format (64 bit, same as KVM uses).  Because KVM
never supports EL3 its index format doesn't have a way to say "this
is the Secure banked copy of this cpreg"; only our QEMU specific
index does.  The conversion functions kvm_to_cpreg_id() and
cpreg_to_kvm_id() were written to assume that the KVM index was
always for a NonSecure register.

The current code doesn't touch the CP_REG_AA32_NS_MASK bit when
converting from the 32-bit ID format to a KVM ID, and it forces the
NS bit to 1 when converting from a KVM ID to a cpreg.  The effect of
this on migration is that the indexes in cpreg_indexes[] have NS = 0
for the Secure banked registers and NS = 1 for the NS banked
registers, but when we read and write the values into the CPUState by
finding the register using kvm_to_cpreg_id(cpreg_indexes[i]) we
always find the NS register, and so the S register values aren't
actually migrated.

This went unnoticed most of the time because (a) most setups don't
enable EL3 at all (b) AArch64 is unaffected (c) most users don't use
migration (d) the case where we direct boot a Linux kernel in NS and
the S regs remain at their reset values happened to work by luck. 
But it breaks migration of a guest which is running in S, such as
Linux or u-boot on the imx boards.

Patch summary:
 * Patch 1 is the fix for this bug; I included keeping migration
   compat from old QEMU here for the benefit of that case (d) that
   used to work. 
 * Patch 2 fixes a corner case for AArch32 v8 CPUs where we wouldn't
   migrate some secure banked registers because we incorrectly
   assumed an AArch64 regdef would do the job
 * Patches 3 and 4 are minor tidyup
 * Patches 5, 6, 7 fix some v7R and v8R bugs where we were exposing
   cpregs and the ATS insns when we should not (noticed because
   this bug caused the debug check in patch 7 to fire)
 * patch 8 adds a debug check when QEMU is compiled in debug that
   every cpreg that we claimed is an ARM_CP_ALIAS to something
   else really does have some other cpreg handling the migration
   of its CPU state struct field. It's a bit heuristic but it did
   successfully report the missing migration handling for the
   bug fixed in patch 1, as well as the other things which
   patches 2-7 fix.

thanks
-- PMM

Peter Maydell (8):
  target/arm: Keep the S/NS bit in migration data
  target/arm: Don't assume secure-banked registers are migrated by
    64-bit regs
  target/arm: Drop uses of reset_ignore for banked AArch32 registers
  target/arm: Don't use arm_cp_reset_ignore when fieldoffset is 0
  target/arm: Move ESR_EL1 definition to vmsa_pmsa_cp_reginfo
  target/arm: Don't set ARM_FEATURE_VAPA for v7 PMSA
  target/arm: Don't register 64-bit TTBR0, TTBR1 for PMSA
  target/arm: Add a debug check that all sysregs are migrated

 target/arm/cpregs.h  |  21 +++--
 target/arm/cpu.c     |   6 +-
 target/arm/cpu.h     |   6 ++
 target/arm/helper.c  | 198 ++++++++++++++++++++++++++++++++++++-------
 target/arm/machine.c |  80 +++++++++++++++++
 5 files changed, 273 insertions(+), 38 deletions(-)

-- 
2.43.0


