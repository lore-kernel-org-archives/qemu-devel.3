Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E993C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 13:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiv5z-0003iV-UQ; Mon, 04 Aug 2025 09:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiuNf-0004mj-VL
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:33:49 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiuNc-0003zW-Us
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:33:31 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-71b5381f21aso35406487b3.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 05:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754310807; x=1754915607; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n+53sEYMfqm+0jsFdhLSvqKRCQdTBc32bFm7l7jJno4=;
 b=NrjVMaTjDOBQpjbCmWb/ajiJuw6btbZjDa0z5TJYJnBP9+7ig/cIEz3bQI39Ou/sng
 ddLeVnrX+ORy+tNWvAtm/jrCOeaVduAX6qhplPYv7ufzPD30WDx60HpWFPzRIP6D86+8
 n4f4SbTTJvhxi766x2dX1uzlkfcQb5G05W1LV2pBMM7tBBs8kFFKPfppee5bjTEsOPqd
 D4xK2s4oyql6jNlMhDj3tSRsxH0VKDF+FAPl78D4EVUpkXv86TbnMcbhnYi8gfTCWEHq
 MJmZsxG9dG4+HiHj/kGRKf/i2S2/ByHqt/QTTpb+D20LO1nJtm5o+X8tOMylNBVktOfR
 rkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754310807; x=1754915607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n+53sEYMfqm+0jsFdhLSvqKRCQdTBc32bFm7l7jJno4=;
 b=wZzyg0sCGwe+tOKG4jElpaWmRIWtHtWGIjeSxETO4et+OLNplStN762AjhYotwvlSa
 VVRtbT9+ukQk1+edqUwum0w5kqylrZBiDzzfou4NEee0aD6AfWTp8YxHP47Wr1db4+11
 6G2sEu7eZwasHhCiGleCUDOAg4e8iYXQHNiTeBdghV+rZxB7MPn0ATEXx4LraZMlcmUL
 eX9vjdvOpesxCssUcmjWIfC7mfymJ25EqnrKmqHVQ8cbazWNhZtkX1La1xYDMYdzDobz
 xaRzfUAYHlFyyBPJxUOHtFiGbEn8zJgGtFKuxJCoXBPkABytQ7DRfQV9HtMgjNktdo0F
 Q4tw==
X-Gm-Message-State: AOJu0YyzqpoHCvK81SbInQluoqfhez8WM7dS3j5kuIITsOXREU3jyXX2
 gmHhIGLiVK5kiQZcTLOO3ONATqttbT8F986zujifZS0tCHiZXw8yEWNaBjUDJQGbJArYRvKWnvj
 VEWz9tVNYYj/tLQOCg5Wa0djKuoF/4ZQhhZAO1AQ/aA==
X-Gm-Gg: ASbGncs295nOpAEzdnwpmj5jNcEd7vLzh1A9bUggZEriv/gT9YqeOu1zK7wiGeG+qc3
 PR7xhThJUhWkPyqDcY8baMENPe+AkCO9GGQpXN9WOtwUBP8Y31uj0jImPyw5aJh0iv2yktE1Tzn
 SFHkGjqnoEBSclC/BfEwXMQ8ghKfOagIJE54+ZY9/QDVRzhrDvQIRb72ZPjifrbFVA4N6/6phCn
 xC3ABjQ
X-Google-Smtp-Source: AGHT+IGCq2AhSeYvcm6exbH+WboiAa+K1/6okUD3U9lnnapdEcKVEmVZCiuM/qlVFVK1MhQNzaPt6Y2ldd46Dk1gI7E=
X-Received: by 2002:a05:690c:4609:b0:719:53fd:79aa with SMTP id
 00721157ae682-71b7f84a212mr82623237b3.22.1754310806713; Mon, 04 Aug 2025
 05:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-25-luc.michel@amd.com>
In-Reply-To: <20250716095432.81923-25-luc.michel@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Aug 2025 13:33:15 +0100
X-Gm-Features: Ac12FXzwSQr7AGfm_c6izhNNgr5b_dyUuokAdnAavoDAWYgIHDZpchMhi984Ktc
Message-ID: <CAFEAcA-QHdkU-12U6dh8QHk9gP4gePB2oGJSWNx_C5P0t3mz3A@mail.gmail.com>
Subject: Re: [PATCH 24/48] hw/intc/arm_gicv3: Introduce a 'first-cpu-index'
 property
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Francisco Iglesias <francisco.iglesias@xilinx.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 16 Jul 2025 at 10:55, Luc Michel <luc.michel@amd.com> wrote:
>
> From: Francisco Iglesias <francisco.iglesias@xilinx.com>
>
> Introduce a 'first-cpu-index' property for specifying the first QEMU CPU
> connected to the GICv3. This makes it possible to have multiple instances
> of the GICv3 connected to different CPU clusters.
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@xilinx.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  include/hw/intc/arm_gicv3_common.h | 1 +
>  hw/intc/arm_gicv3_common.c         | 3 ++-
>  hw/intc/arm_gicv3_cpuif.c          | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)

hw/intc/arm_gicv3_kvm.c also calls qemu_get_cpu(). You should
either update that also so it can handle first-cpu-index, or
else make kvm_arm_gicv3_realize() fail if it's non-zero.

thanks
-- PMM

