Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5582AD3942F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 14:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Iue-0001u8-6b; Thu, 02 Apr 2026 10:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1w8IuX-0001tA-Na
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:20:42 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1w8IuU-0003Qx-1A
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:20:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d01d6b50cso825811f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775139634; x=1775744434; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dhcMvMqGzu67Gn2dSSCkGPd+khYYkpToOP8J31pc4cU=;
 b=hRE82We40s9cR/coG55e/qdk6qaLBD4K02Q/4w9A8Ih7mtWBtR0dm1kYCV+tx+KQsv
 YOsXDH00f5o72BjSH2PJKslkDLVxcOrypGuE8DCjkXdi20OiuX7MEWxxXFinSZVc1Cn4
 wH7Mnaqcenz0JagtELMviTPMBT9tCC2Klt1M/zsWZK50AgQ7Kd2Lo7/IWAqENLk97WVC
 C2SzgPRZsWpIPo4YQbdjN3rBJkJ9Bd4yp/eyKFNnXjb1qIXiziupDXRszWL7PUtY64G3
 lKOMk95//ekTPsb3GPmBJE3tRp1L3eLKdMtUUqSX1boV9cv2zCZbnx0SpgPm/EvAYDFq
 PqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775139634; x=1775744434;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhcMvMqGzu67Gn2dSSCkGPd+khYYkpToOP8J31pc4cU=;
 b=l0GugVty1UqTU2/SPLz/Lg1Qmcr5fX3G1HHzHNht9skDZZCbWRXPlGfTaldFjRwKnO
 NZ7PBekvdvA2jicyXChu2arCXNmMkN1uwdRHajdrbV+kWtnaw82B4Ha1qWqVQni3twDG
 zWhz4DYpBHbRJBBT/VmyjSZSfr2n1tW2T8JrWIQXGI4kYPBvTDo22eFjDE8CpdWcVop0
 FX8hLdFoFYh42YhfZ3DMLhCtI7PM52dtTRKViQvRX46dmp07fERqWle0KBxPNpYp38YK
 fa9SpG80bGPZWq86VElNMv7ljojQlPcP7gUEa/sQ5apt2JlYK3SVgKVEeaY2YX+Eszhg
 D6dw==
X-Gm-Message-State: AOJu0Yy5eqUmMsbns104QbNuzPDgMFMDA4e1BtVdFLLyveRmwGC30lYS
 rhqQdlYoQMeKYsWw5s54PqlskbJrnhOE0VFzsbeVWx14t/9DBzyyx4CLTBxTiOJDAJk=
X-Gm-Gg: AeBDieveOfJ9v9k3rtstggSEFQ2R6g51znjcCxyy+dPH5dswgGIuV+m4X8oSodzcPGs
 0MGu1HDfKiPx7AiSF+brL7iN2BWT7lGouF0aswvVREegDBIB7GcjpXuNmnPhHCj6CmDV44rdONV
 ClgwyFKCVyjHBEfz4yKz+Xoqau+SvIzOYynrkQkFKOLFgEEFsAx2b2YW+2WwonlUEAH/J4bG7Mo
 Di1bNBz2CmokRQsHyFM88OPWtj8cs5r2yIus8/3/fBNlP2iKy2NpbwSMtJAK1s+pvxKpk0Q0J5M
 vfDIEo4oX3ERQ1WQTaxA0IKdwkx/fI+71aBdCqF7nVqK1TCW7J8n2Rd0x5dIvwGubP5JL2AZdTa
 XjDrvKxe1Tgk6z9SksPKAAZ/3YS0qCcCgMqB66/md5VGTi0ZFeyiZ4xaGxQp58GIWEbcDlX21D7
 rTDmfyqMCx7k75ETnVd1yopafxuPodqlFwkWzc
X-Received: by 2002:a05:6000:2586:b0:43d:121c:37d9 with SMTP id
 ffacd0b85a97d-43d15045eadmr15023220f8f.1.1775139634381; 
 Thu, 02 Apr 2026 07:20:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:6bea:159e:9f17:ebb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e5890sm7902384f8f.31.2026.04.02.07.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 07:20:34 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 0/2] Replace aarch64 TCG instruction formats with more
 meaningful names
Date: Thu, 02 Apr 2026 15:20:27 +0100
Message-Id: <20260402-aarch64-tcg-instruction-format-rename2-v1-0-0998a08a515c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACt7zmkC/x2NQQqEMAwAvyI5G2iDdmW/Ih5CN2oO1iWtsiD+f
 YvHOczMBVlMJcO7ucDk1Kx7quDbBuLKaRHUT2UgR8F1jpDZ4ho6LHFBTbnYEUt1cN5t44ImiTc
 hJAqD9y8Jvh+gxr4ms/6e0Tjd9x/IlCAAeAAAAA==
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x435.google.com
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

tcg/aarch64/tcg-target.c.inc contains a lot of numbered instruction formats
called "I3XXX" in the enum AArch64Insn, named for the original section in the
Arm documentation which described those formats.

This patch aims to give them more meaningful names, for example, I3314 becomes
Ildstpair. Where possible, these names match those used in
target/arm/tcg/a64.decode.

Changes since the RFC version:
* bitfield_32, logic_imm_32, movw_32 have had the _32 suffix removed since they
  also apply to 64 bit versions here.
* The I3310 mask is now ldst_imm_to_reg; the previous 'to_sign_extend' name was
  wrong.

For convenience, here is a list of the replacements.

* Automatic changes, made by passing the values in the enum to a modified
  version of the code produced by scripts/decodetree.py:
3206 => branch
3305 => ldlit
3306 => stxp
3312 => ldst_imm
3314 => ldstpair
3401 => addsub_imm
3406 => pcrel
3501 => addsub_ext
3502 => addsub_shift
3503 => rrr_sf
3507 => rr_sf
3508 => rrr
3509 => rrrr
3510 => logic_shift
3611 => rrr_e

* Manual changes, still matching names given in a64.decode but found in that
  file manually:
3201 => cbz
3205 => tbz
3207 => bcond_reg
3303 => simd_load_replicate
3403 => extract
3616 => qrrr_e
3617 => qrr_e

* Slightly edited names, from a64.decode but with the '_32' suffix removed,
  since they also apply to 64 bit versions in TCG:
3402 => bitfield
3404 => logic_imm
3405 => movw

* Names invented by me, where a64.decode does not have a meaningful name:
3202 => bcond_imm
3506 => csel
3605 => simd_copy
3606 => simd_imm
3609 => q_shift
3612 => simd_rr
3614 => simd_shift_imm
3502S => addsub_realshift

We've also looked into extracting names from the machine-readable instruction 
descriptions given by Arm. These don't give a 1:1 mapping with many of the
existing names in a64.decode, so would need a much larger restructuring to use.

Thanks to Richard Henderson for initial review on the RFC.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Jim MacArthur (2):
      tcg/aarch64/tcg-target.c.inc: Replacement of I3XXX names
      tcg/aarch64/tcg-target.c.inc: Manual replace of I3310, I3313

 tcg/aarch64/tcg-target.c.inc | 994 ++++++++++++++++++++++---------------------
 1 file changed, 509 insertions(+), 485 deletions(-)
---
base-commit: 7df28e4c41c45a68afbc60766c2111358fc7fd37
change-id: 20260402-aarch64-tcg-instruction-format-rename2-2268117e6158

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


