Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63108CFD364
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 09:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNpeC-0000id-Kj; Tue, 25 Nov 2025 04:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vNpe8-0000fk-At; Tue, 25 Nov 2025 04:47:40 -0500
Received: from mail.avm.de ([212.42.244.119])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vNpe5-00085l-7b; Tue, 25 Nov 2025 04:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1764064053; bh=+UWYKk8HAglGdduUCqVwR0QbUFgbICk6UJpkxVvSmuM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jzl33wwyoGD5tI6a0WXgZKLkM/jgAX210vj5EVamo76HI6K72KVL09GRnI5O/iKio
 f3pU2grrJDEPQcW7d0c4H0FkAt0wT7RYJ4G3f0SLHkQtcJUOzgW4sIKpOYYgXyPXcY
 utWiv6vCwZam+CEUI1wHuJzsuUVUGvpW5Q4GLf/4=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 69257b35-2186-7f0000032729-7f000001d22a-1
 for <multiple-recipients>; Tue, 25 Nov 2025 10:47:33 +0100
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Tue, 25 Nov 2025 10:47:33 +0100 (CET)
Received: from l-cspeich ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025112510473304-7490 ;
 Tue, 25 Nov 2025 10:47:33 +0100 
Date: Tue, 25 Nov 2025 10:47:32 +0100
From: Christian Speich <c.speich@avm.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 3/4] hw/sd/sdcard: Erase blocks to zero
Message-ID: <mwi6yot7w7whhd5dyaq7vgnv4r7ldw6rcqu5zhd7ta4vgwpfrp@e3cq3tlbylmk>
References: <20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de>
 <20250919-sdcard-performance-b4-v1-3-e1037e481a19@avm.de>
 <a289ad27-20f2-46f1-bd33-a08cf8f1a14e@linaro.org>
MIME-Version: 1.0
In-Reply-To: <a289ad27-20f2-46f1-bd33-a08cf8f1a14e@linaro.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 25.11.2025 10:47:33,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 25.11.2025 10:47:33, Serialize complete at 25.11.2025 10:47:33
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-purgate-ID: 149429::1764064053-095EACF8-57C52E52/0/0
X-purgate-type: clean
X-purgate-size: 2246
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=212.42.244.119; envelope-from=c.speich@avm.de;
 helo=mail.avm.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 24, 2025 at 05:09:03AM +0100, Philippe Mathieu-Daudé wrote:
> On 19/9/25 14:34, Christian Speich wrote:
> > Currently, erased blocks are filled with 0xFF. However SCR Bit 55
> > (DATA_STAT_AFTER_ERASE) indicates that an erase produces zeros. One of
> > them is wrong.
> 
> You are right, we don't set DATA_STAT_AFTER_ERASE correctly.
> 
> > As erasing to zero is more performant and allows block devices to
> > use optimizations, we the erase to produce 0x00.
> > 
> > Signed-off-by: Christian Speich <c.speich@avm.de>
> > ---
> >   hw/sd/sd.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index 23764ed99f36cf39ee7abe02f08e51897c05e718..94ef3cc62582717ee044c4b114b7f22bd1b4a256 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -1115,7 +1115,6 @@ static void sd_erase(SDState *sd)
> >       sd->erase_end = INVALID_ADDRESS;
> >       sd->csd[14] |= 0x40;
> > -    memset(sd->data, 0xff, erase_len);
> >       for (erase_addr = erase_start; erase_addr <= erase_end;
> >            erase_addr += erase_len) {
> >           if (sdsc) {
> > @@ -1127,7 +1126,8 @@ static void sd_erase(SDState *sd)
> >                   continue;
> >               }
> >           }
> > -        sd_blk_write(sd, erase_addr, erase_len);
> > +        blk_pwrite_zeroes(sd->blk, erase_addr + sd_part_offset(sd),
> > +                          erase_len, 0);
> >       }
> >   }
> 
> I'm OK with this change, but I'd rather having a device boolean property
> so we can keep the old behavior for backward compatibility. Maybe
> 'erase-block-as-zero'? Do you mind updating this patch?

I've refrained from making this a user-configruable property to keep the
code simple and as erasing to zero can be better optimized (performance
and disk usage, e.g. the following commit). Additionally, it may be less
confusing to users as new disks created by qemu-img will be filled with
zeros.

I see that this is a breaking change though, so I'll look into adding
a property.

I assume you want erase-block-as-zero to default to false? (I'd prefer
true, but thats just my use-case).

Greetings,
Christian


> 
> Regards,
> 
> Phil.
> 

