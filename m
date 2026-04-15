Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ABBFA0C30
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 05:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCtEb-0007Go-FL; Wed, 15 Apr 2026 01:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20260415054608cf281d0f0f000207ad-3n0Pwk@rts-flowmailer.siemens.com>)
 id 1wCtEZ-0007Fx-Pi
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 01:56:20 -0400
Received: from mta-64-226.siemens.flowmailer.net ([185.136.64.226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20260415054608cf281d0f0f000207ad-3n0Pwk@rts-flowmailer.siemens.com>)
 id 1wCtEW-000509-3A
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 01:56:19 -0400
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20260415054608cf281d0f0f000207ad for <qemu-devel@nongnu.org>;
 Wed, 15 Apr 2026 07:46:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=G/4GzvHTpYuXZHIwOADPDiN02RLMijQk4gxGuKYRdzs=;
 b=ZCx1vD/UmQR+o9/W0LRehHiznEBu1HZJhtzgqHAXl7UoWqnY0nmgmgIeuJM5XgFObP6DE3
 V2GRlWyQZEBJOtqzxK0HhsOs9pt80mGT3YGfzNOkYjQvEatcoWjKCO7fLz8lqY+GPcEXqXxN
 s61NrVm8gGbRlJprvmekAvnqJ3FJjGTOc4nnvA2AOraF9H3M3LdWL+piX77+N2cAyV0EiVh5
 VEFg30yUATJ+1+ueqTtNNT/9IDjeNhMO5EEZ3eBkfFC6YnuYxgNlGUVT+g+JIJkhvTx4+6Me
 ZNvE6Ja4lBwyqGQ0wI6Q4kBKGJS45uMBsKz58a7l4g/IeC9/OfKbI3ag==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 0/2] sd: Small improvements around RPMB emulation
Date: Wed, 15 Apr 2026 07:46:05 +0200
Message-ID: <cover.1776231967.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.226;
 envelope-from=fm-294854-20260415054608cf281d0f0f000207ad-3n0Pwk@rts-flowmailer.siemens.com;
 helo=mta-64-226.siemens.flowmailer.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Besides a cosmetic fix for the emmc disk image generation script, this
adds a property to the emmc model that allows to preset the
authentication key. And that enables to build OPTEE without key writing
support, bringing the related firmware much closer to real setups.

An alternative to this option would have been persisting additional
state such as the key or the write counter on the disk image as well.
This is still an option for the future, e.g. to model also write
protection groups or other persistent states. As this requires another
format extension of the eMMC disk image, I want for this much simpler
and less invasive approach.

Jan

Jan Kiszka (2):
  scripts: mkemmc.sh: Fix output pollution on missing images
  hw/sd/sdcard: Add support for pre-setting the authentication key

 hw/sd/sd.c        | 23 +++++++++++++++++++++++
 scripts/mkemmc.sh |  4 ++--
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.47.3


