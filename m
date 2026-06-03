Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C385CD6E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUguY-0008CU-0L; Wed, 03 Jun 2026 04:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUguR-000850-R0
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:09 -0400
Received: from msg-3.mailo.com ([213.182.54.8] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUguQ-000307-FP
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780473849; bh=xFANv9Ndsvjj4SHczxxx3Lxiroky5T5zJlVE6l5d2a0=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=FkY47JmCTCFC0+T6LJaPD5POtYDfOjmFC4yTCV9QORL9qGeWRZedH06YcdLDwuvrZ
 xIamPo8epHKPrznp4zWVyRvub2PYL7U6quGLTe93yuj9gDtg4y6EDjpcb0tvXUBzbd
 Ss9UPF/mn5EO0qtbVLzpPJQbJb23MxrWBcAB09aU=
Received: by be1-2.in.mailobj.net [192.168.91.12] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 10:03:59 +0200 (CEST)
X-EA-Auth: 7IssbG2/4tG40B9Ha4TAUQaXu6HOTHvXu08CMlry/MosQa4MLPhxblALY1iAJHW/x5GbS3ZwV2lV6eiId6grlFpk8mzjmwvN
Message-ID: <1b92f1d4-5de6-488b-8072-14a049086c69@mailo.com>
Date: Wed, 3 Jun 2026 10:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Fix information leak in vfio_rom_read()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Mario Casquero <mcasquer@redhat.com>
References: <20260602074446.1206892-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260602074446.1206892-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.8; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 2/6/26 09:44, CÃ©dric Le Goater wrote:
> vfio_rom_read() can leak uninitialized stack data to the guest when a
> read occurs at the end boundary of the ROM BAR.
> 
> Fix this by initializing the val union to 0xff, matching the ROM
> initialization pattern used in vfio_pci_load_rom().
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>


