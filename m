Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B662AF428D3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD6ZS-0003oV-No; Wed, 15 Apr 2026 16:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wD6ZQ-0003nf-R2
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:10:44 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wD6ZO-00020o-8M
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:10:44 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 21ABD596A47;
 Wed, 15 Apr 2026 22:10:39 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 1XF-Ylhw-BO2; Wed, 15 Apr 2026 22:10:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 288A55969F6; Wed, 15 Apr 2026 22:10:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2720F5969EC;
 Wed, 15 Apr 2026 22:10:37 +0200 (CEST)
Date: Wed, 15 Apr 2026 22:10:37 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: Feifan Qian <bea1e@proton.me>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/2] hw/display/ati: reset host_data.next on early returns
 in ati_host_data_flush()
In-Reply-To: <DHTVKTNF92GX.1CR2SGLBUGI6N@jablonski.xyz>
Message-ID: <376dc5c2-5e10-ce42-3b2f-bebaf9f0f646@eik.bme.hu>
References: <U62ZPP3C0eUIUhmFb68h6Zbpn_gAjGsyJL3MlLsNd6Y4685t5cgo1IQEs3jQpw27LX8rbQaav04Kd-xLwbQXykyIUq2ouFnbFlMgXoKB_NY=@proton.me>
 <42adf9e0-6e57-08e1-5fce-94a43ebad32a@eik.bme.hu>
 <DHTVKTNF92GX.1CR2SGLBUGI6N@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Wed, 15 Apr 2026, Chad Jablonski wrote:
> I agree with Zoltan on the overflow issue. I think it may be best fixed
> by resetting next in the write handler after both ati_host_data_finish
> and ati_host_data_flush. The next reset could be removed from inside of
> ati_host_data_flush entirely. That way the write handler handles the full
> lifecycle of next and it's both clearer and much harder to miss if new
> failure cases are added.
>
>>> + if (!ctx.bpp) {
>>> + qemu_log_mask(LOG_GUEST_ERROR,
>>> + "host_data_blt: invalid bpp\n");
>>> + s->host_data.next = 0;
>>> + return false;
>>> + }
>
> This guard is separate from the acc overflow issue but worth keeping.

Without context I'm not sure where this was proposed to be added but 
there's such check in ati_2d_do_blt. If we move this check out from there 
that one is not needed after adding similar check in ati_2d_blt too. 
Having duplicate check seems unnecessary. Then should we move the 
dst_stride check out of ati_2d_do_blt too?

Regards,
BALATON Zoltan

