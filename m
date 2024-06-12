Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7A5C27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 05:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHGrX-0003x0-B2; Wed, 12 Jun 2024 01:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHGrV-0003wR-2P
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 01:49:33 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHGrS-0005jf-FP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 01:49:32 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-35f2266edd8so1439035f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 22:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718171368; x=1718776168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FJEXnSYS89m3/YxvYHuwZzWVdIsED6LEvlvNI2qr600=;
 b=tBmKD5xD8LwNlk3J/rC4BMOHCuNF3LIdY542Dtry7djNV2J29GPuWupHeAM1rlQEdU
 epV52LKGYlawXcx91w2NH80P59H0FcgCBL1Je1tveaDOjRU1+dCeUJyJMQiXx+oNmM8/
 dFfNAkWbOEu8HDMPyCD6wn4iApymRoUo8UtL8KEJ5GZGy/8VUWF8UsIodifGJNG6xQ33
 +8Dv6jnuTH0FRzonht+3oMr8VN9bMAITnX08MYh1nAzFVgtwT26vfBFVaBYhU7rVCycB
 6IinuiaU7KLDHNXIe0GcdVhg1+cT0p+CiP9iiLMXlcOgl3Qtn0YM2ZaWQjSu/BqEOmDX
 t0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718171368; x=1718776168;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FJEXnSYS89m3/YxvYHuwZzWVdIsED6LEvlvNI2qr600=;
 b=ZP35meUly/9l7Qqm9Tv69r7KB801lPrSC9wIi4qJAQrDAHhRbn2cTfZrpFosgqiiDu
 uQ9rz7Qg8IGha4F4Ur+UcluzT1dPD0ZmJ/Qu7VrVLFN6/R/V706e4NVmVWvVXKCGQyd7
 eMXiEv1k2E8ZbTo0PmVFSvKT8QZto+zECQSUopCYXPKUUDrt3+6hY8CyfEOzM3khjzp+
 67XRkGdALpNItuFA8yaTtkytXBNMP6I5ZIBRxmsbSeMhbcilEJFMp3oz/B+GsEGkvXiG
 iavQsEhLkEVVnhxfoFZHru5b1pqGQ7SqIA3JUWeyAbG27c2SlcBkOSvzNyxXBnHPvtR2
 STqA==
X-Gm-Message-State: AOJu0YzcCEp+AxkGITjUqteTwvj0LGqUSOn8qkqrZ6hy6e4RlUwE7nhi
 v/kJw+UxlIn4mQx4t18RExMC5gr68gOwTIYRn28LgzVaBZSFIDhVlIseeOqCX9mvzb5k/QU/M7F
 GYNM=
X-Google-Smtp-Source: AGHT+IEFZVMOlaCnBqgwVs/Wdq3kg1GgsHr6rJERVKFvYj/sLy2PRfunMcw4+7VR9IrHkeHLkfM8Rw==
X-Received: by 2002:a5d:4112:0:b0:35f:48e:fe59 with SMTP id
 ffacd0b85a97d-35fe89449fcmr419858f8f.66.1718171367600; 
 Tue, 11 Jun 2024 22:49:27 -0700 (PDT)
Received: from meli-email.org (adsl-33.109.242.225.tellas.gr. [109.242.225.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f2f67b5b8sm2781625f8f.12.2024.06.11.22.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 22:49:27 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:48:49 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Fr=?UTF-8?B?w6k=?= d=?UTF-8?B?w6k=?= ric Barrat <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@kaod.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH 00/26] hw/ppc: Prefer HumanReadableText over Monitor
User-Agent: meli 0.8.6
References: <20240610062105.49848-1-philmd@linaro.org>
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
Message-ID: <eydid.qr5cr60ecbze@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 10 Jun 2024 09:20, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Hi,
>
>This series remove uses of Monitor in hw/ppc/,
>replacing by the more generic HumanReadableText.
>Care is taken to keep the commit bisectables by
>updating functions one by one, also easing review.
>
>For rationale see previous series from Daniel:
>https://lore.kernel.org/qemu-devel/20211028155457.967291-1-berrange@redhat.com/
>
>Regards,
>
>Phil.
>
>Philippe Mathieu-Daudé (26):
>  hw/ppc: Avoid using Monitor in pnv_phb3_msi_pic_print_info()
>  hw/ppc: Avoid using Monitor in icp_pic_print_info()
>  hw/ppc: Avoid using Monitor in xive_tctx_pic_print_info()
>  hw/ppc: Avoid using Monitor in ics_pic_print_info()
>  hw/ppc: Avoid using Monitor in PnvChipClass::intc_print_info()
>  hw/ppc: Avoid using Monitor in xive_end_queue_pic_print_info()
>  hw/ppc: Avoid using Monitor in spapr_xive_end_pic_print_info()
>  hw/ppc: Avoid using Monitor in spapr_xive_pic_print_info()
>  hw/ppc: Avoid using Monitor in xive_source_pic_print_info()
>  hw/ppc: Avoid using Monitor in pnv_phb4_pic_print_info()
>  hw/ppc: Avoid using Monitor in xive_eas_pic_print_info()
>  hw/ppc: Avoid using Monitor in xive_end_pic_print_info()
>  hw/ppc: Avoid using Monitor in xive_end_eas_pic_print_info()
>  hw/ppc: Avoid using Monitor in xive_nvt_pic_print_info()
>  hw/ppc: Avoid using Monitor in pnv_xive_pic_print_info()
>  hw/ppc: Avoid using Monitor in pnv_psi_pic_print_info()
>  hw/ppc: Avoid using Monitor in xive2_eas_pic_print_info()
>  hw/ppc: Avoid using Monitor in xive2_end_eas_pic_print_info()
>  hw/ppc: Avoid using Monitor in xive2_end_queue_pic_print_info()
>  hw/ppc: Avoid using Monitor in xive2_end_pic_print_info()
>  hw/ppc: Avoid using Monitor in xive2_nvp_pic_print_info()
>  hw/ppc: Avoid using Monitor in pnv_xive2_pic_print_info()
>  hw/ppc: Avoid using Monitor in
>    SpaprInterruptControllerClass::print_info()
>  hw/ppc: Avoid using Monitor in spapr_irq_print_info()
>  hw/ppc: Avoid using Monitor in pnv_chip_power9_pic_print_info_child()
>  hw/ppc: Avoid using Monitor in pic_print_info()
>
> include/hw/pci-host/pnv_phb3.h |   2 +-
> include/hw/pci-host/pnv_phb4.h |   2 +-
> include/hw/ppc/pnv_chip.h      |   4 +-
> include/hw/ppc/pnv_psi.h       |   2 +-
> include/hw/ppc/pnv_xive.h      |   4 +-
> include/hw/ppc/spapr_irq.h     |   4 +-
> include/hw/ppc/xics.h          |   4 +-
> include/hw/ppc/xive.h          |   4 +-
> include/hw/ppc/xive2_regs.h    |   8 +--
> include/hw/ppc/xive_regs.h     |   8 +--
> hw/intc/pnv_xive.c             |  38 ++++++------
> hw/intc/pnv_xive2.c            |  48 +++++++--------
> hw/intc/spapr_xive.c           |  41 ++++++-------
> hw/intc/xics.c                 |  25 ++++----
> hw/intc/xics_spapr.c           |   7 +--
> hw/intc/xive.c                 | 108 ++++++++++++++++-----------------
> hw/intc/xive2.c                |  87 +++++++++++++-------------
> hw/pci-host/pnv_phb3_msi.c     |  21 +++----
> hw/pci-host/pnv_phb4.c         |  17 +++---
> hw/ppc/pnv.c                   |  52 ++++++++--------
> hw/ppc/pnv_psi.c               |   9 ++-
> hw/ppc/spapr.c                 |  11 +++-
> hw/ppc/spapr_irq.c             |   4 +-
> 23 files changed, 256 insertions(+), 254 deletions(-)
>
>-- 
>2.41.0

For the series:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

