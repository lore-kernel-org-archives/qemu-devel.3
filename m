Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E588DCD4F48
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 12:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNs6i-00063D-Dg; Fri, 15 May 2026 08:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNs6g-00062X-KJ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 08:57:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNs6f-0000V7-3I
 for qemu-devel@nongnu.org; Fri, 15 May 2026 08:57:34 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d75312379so611372f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778849850; x=1779454650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pr2CxwzThTzz0uV1lzmvCBO25aUZd+rb/X7PVMHHSVg=;
 b=ax3EoXbOD7/iYqhbOyyLsYOs/K9gGRWaLoRpc+6ugIOqFKy11wgdZbl0GA4Wgw5/HQ
 p6E3WQlOGUjyiEOZyeUpHW+Dkbn+Dc8LV4cLw4GM/yK0BJFEcj3UxjO+ux9iEA/xoeqN
 6S9lAHL21vaqmEp95xT5x+KVvv604VwZUZgw/xCS5cQV+3V47X0RpjIC0MEPwkBdz19i
 ymmlLCtlzau1eTG3ZvVo1eBGRslUhtB4kVfFLtWLf34L+89J+NHGENZ614frRGWj5Xt3
 TWN0EGytLzo9/WLbzlr/TZwwS+/IJufvnD08R/nKPNxSjCAJZq1UQ2pzbzSkZ0hecJ4g
 87Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778849850; x=1779454650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pr2CxwzThTzz0uV1lzmvCBO25aUZd+rb/X7PVMHHSVg=;
 b=JaU61P6Kg6d4wpR0pkM3BqnEdZqyYNGTegZDciBosbIz0sU6KSlWRFJsfU/QPbaDHQ
 sYMqCb1DfR9/iR5SWwzhmyJuJuEhelWwcNdJB56gbSpS1U4Kpavw/DfA8AiUPttvr5RC
 cT8hl/ENOKAyRvoTI+7xS6jheoQCxqlJTHoYd5tzc7/v58ZPR3FXCuiCAxL15057Rs+N
 FpPjsM1NOVuu3EBiMxo6zU8iTyKucoIIies0FOebvTVolPqNlWYLOY/GWSGZ20bV9L9v
 +q634997x/CQ1yusuAZZrCLMMSYbH0WPJY0+KAoeNTQqn+wZExbAV2N4P9QaFo2dBOxP
 dXww==
X-Gm-Message-State: AOJu0Yx6GyvkkOxtu7gyNb8nwzA4nOVRkuKiLOBapjJNm2WmOGXJ0q9Y
 7FDgcHDy5EBibAIixPXq2m6FADTttO1Y45gFgXQ15PxbQxaa9xl3GHNnZBGgrznF0VrSuNHe05d
 2OgPs
X-Gm-Gg: Acq92OHEXmXyrYTVixQ/8WbX+1V49LLW0/2wSX0eh4QSYzpYIO9lBevJQxw2q0v2Sxs
 L09vUawG9G4f5n3pXCx4vRGZW3Kf+6hAk/qGfb9RUt5HPDS7re1/2AYA8b5GMA2ZSYeDXi5S1rg
 JlaGa2TT3/xOcGpiCCn7UjCYE2fb7KDe2GtQO2qfPvbyCSOoetPQmeBD0yJBiP+W0vMpPrv58yU
 5mIhvBNO5QofH+AWXh9UKg3Ksv+KxAL1I008/wOOLn2rVQN7Swlhpg+iyMU4eTJEbjCWGd8Sngj
 SQxiiAnfnd55IJqcWfCYqVVeKxaA8IaSfZlY8RZhZ9DQ7tHremgLL9MZpOvLd/247+QYmxtfvgM
 iXOdVp5Vd3PI/DZg7EVmvh/ZDC+OiEShrkGXHqie9WsWhqZVCuD9e1YLHlpuDCbsNQtfagyHlsh
 mUdMkGt2WgScp3G0/RU987xT8xH8Fkqv+eCQJ1rv4WULFOHu95OX/YnNqaLG7Uedlu9L2oJoN9/
 Ls16q9XBT/Jyy3MDdht9JRNliAxte4=
X-Received: by 2002:a05:600c:1914:b0:48f:d620:c27f with SMTP id
 5b1f17b1804b1-48fe4dac5efmr51211335e9.4.1778849850311; 
 Fri, 15 May 2026 05:57:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c833fcsm57526515e9.2.2026.05.15.05.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 05:57:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 0/3] i386, microblaze: convert to translate_for_debug
Date: Fri, 15 May 2026 13:57:24 +0100
Message-ID: <20260515125727.349675-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

We currently have three methods that a target can use to implement
"translate virtual to physical address for debug purposes":
get_phys_addr_debug, get_phys_addr_attrs_debug, and the new
translate_for_debug.

Only microblaze and i386 implement get_phys_addr_attrs_debug;
convert them to the newer and more flexible translate_for_debug,
and remove the get_phys_addr_attrs_debug handling entirely.

(Now that the translate_for_debug patchset is upstream, this is
a bit of followon cleanup that I said I'd do.)

thanks
-- PMM

Peter Maydell (3):
  target/microblaze: Convert to translate_for_debug
  target/i386: Convert to translate_for_debug
  hw/core: Remove SysemuCPUOps::get_phys_addr_attrs_debug

 hw/core/cpu-system.c             | 11 ++---------
 include/hw/core/sysemu-cpu-ops.h | 14 --------------
 target/i386/cpu.c                |  2 +-
 target/i386/cpu.h                |  4 ++--
 target/i386/helper.c             | 31 +++++++++++++++++--------------
 target/i386/whpx/whpx-all.c      |  2 +-
 target/microblaze/cpu.c          |  2 +-
 target/microblaze/cpu.h          |  4 ++--
 target/microblaze/helper.c       | 25 ++++++++++++++-----------
 9 files changed, 40 insertions(+), 55 deletions(-)

-- 
2.43.0


