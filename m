Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC4BCD5BA6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 08:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPGHR-0005Ja-DR; Tue, 19 May 2026 04:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>) id 1wPGHP-0005JP-BB
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:58:23 -0400
Received: from mail.avm.de ([2001:bf0:244:244::119])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>) id 1wPGHN-0002Bl-8r
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1779181095; bh=1EEJI+A+JPdcOKp6n9ksRnjRKKt8rBSv8fui/mp0GZU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uQvG1AuSXAe2GOXLd/cb7UhavBIHBJBweyo4NongxDroDm8LPZ4kGu1sYji25V1Jv
 HTK6cKouZHAoRx7i0iISrZ9+nTp3OQsDLgdv99esv8tjtNEuLCM+G59YrcA9BejfqN
 ZNMBvR4I9tmq2XyTCukrEa1gi2pP011II72MruFM=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.56.1)
 (envelope-from <c.speich@avm.de>)
 id 6a0c2627-cede-7f0000032729-7f0000019846-1
 for <multiple-recipients>; Tue, 19 May 2026 10:58:15 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Tue, 19 May 2026 10:58:15 +0200 (CEST)
Received: from l-cspeich ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026051910581479-2272 ;
 Tue, 19 May 2026 10:58:14 +0200 
Date: Tue, 19 May 2026 10:58:13 +0200
From: Christian Speich <c.speich@avm.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 06/41] hw/sd/sd: Allow multi-byte read/write for generic
 paths
Message-ID: <dfirgzamckaztjht7becglrbcetfhnlj36ge737nowlansrjub@lftxjhzeuhi4>
References: <20260512062142.67998-1-philmd@linaro.org>
 <20260512062142.67998-7-philmd@linaro.org>
 <b1910325-bfd7-4f4c-a288-fb40f597ccc0@linaro.org>
MIME-Version: 1.0
In-Reply-To: <b1910325-bfd7-4f4c-a288-fb40f597ccc0@linaro.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 19.05.2026 10:58:14,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 19.05.2026 10:58:14, Serialize complete at 19.05.2026 10:58:14
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-purgate-ID: 149429::1779181095-2658639B-B5947E0E/0/0
X-purgate-type: clean
X-purgate-size: 4396
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::119;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hey Phil, 

On Tue, May 12, 2026 at 10:37:34PM +0200, Philippe Mathieu-Daudé wrote:
> On 12/5/26 08:21, Philippe Mathieu-Daudé wrote:
> > From: Christian Speich <c.speich@avm.de>
> > 
> > Paths that use sd_generic_write/read_data can now write/read multiple
> > bytes with one call.
> > 
> > Signed-off-by: Christian Speich <c.speich@avm.de>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Message-ID: <20260417-sdcard-performance-b4-v4-2-119e66be10c2@avm.de>
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> >   hw/sd/sd.c | 62 ++++++++++++++++++++++++++++++------------------------
> >   1 file changed, 35 insertions(+), 27 deletions(-)
> > 
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index c0b89735f69..b49b83b96e8 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -1610,7 +1610,7 @@ static sd_rsp_type_t sd_cmd_optional(SDState *sd, SDRequest req)
> >       return sd_illegal;
> >   }
> > -/* Configure fields for following sd_generic_write_byte() calls */
> > +/* Configure fields for following sd_generic_write_data() calls */
> >   static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
> >                                                uint64_t start, size_t size)
> >   {
> > @@ -1625,7 +1625,7 @@ static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
> >       return sd_r1;
> >   }
> > -/* Configure fields for following sd_generic_read_byte() calls */
> > +/* Configure fields for following sd_generic_read_data() calls */
> >   static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
> >                                              uint64_t start,
> >                                              const void *data, size_t size)
> > @@ -2615,11 +2615,15 @@ send_response:
> >   }
> >   /* Return true if buffer is consumed. Configured by sd_cmd_to_receivingdata() */
> > -static bool sd_generic_write_byte(SDState *sd, uint8_t value)
> > +static bool sd_generic_write_data(SDState *sd, const void *buf, size_t *len)
> >   {
> > -    sd->data[sd->data_offset] = value;
> > +    size_t to_write = MIN(sd->data_size - sd->data_offset, *len);
> > -    if (++sd->data_offset >= sd->data_size) {
> > +    memcpy(sd->data, buf, to_write);
> 
> Always writing beginning of buffer.
> 
> > +    sd->data_offset += to_write;
> > +    *len = to_write;
> > +
> > +    if (sd->data_offset >= sd->data_size) {
> >           sd->state = sd_transfer_state;
> >           return true;
> >       }
> > @@ -2627,11 +2631,15 @@ static bool sd_generic_write_byte(SDState *sd, uint8_t value)
> >   }
> >   /* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
> > -static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
> > +static bool sd_generic_read_data(SDState *sd, void *buf, size_t *len)
> >   {
> > -    *value = sd->data[sd->data_offset];
> > +    size_t to_read = MIN(sd->data_size - sd->data_offset, *len);
> > -    if (++sd->data_offset >= sd->data_size) {
> > +    memcpy(buf, sd->data, to_read);
> 
> Always reading beginning of buffer.

Oh, good find! Thanks!

I see that only 3 of 7 patches from my series made it into this PULL, are there any
problems with the others I can help with?

Greetings,
Christian

> 
> > +    sd->data_offset += to_read;
> > +    *len = to_read;
> > +
> > +    if (sd->data_offset >= sd->data_size) {
> >           sd->state = sd_transfer_state;
> >           return true;
> >       }
> 
> Squashing:
> 
> -- >8 --
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index b49b83b96e8..11f6b91576a 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2619,7 +2619,7 @@ static bool sd_generic_write_data(SDState *sd, const
> void *buf, size_t *len)
>  {
>      size_t to_write = MIN(sd->data_size - sd->data_offset, *len);
> 
> -    memcpy(sd->data, buf, to_write);
> +    memcpy(&sd->data[sd->data_offset], buf, to_write);
>      sd->data_offset += to_write;
>      *len = to_write;
> 
> @@ -2635,7 +2635,7 @@ static bool sd_generic_read_data(SDState *sd, void
> *buf, size_t *len)
>  {
>      size_t to_read = MIN(sd->data_size - sd->data_offset, *len);
> 
> -    memcpy(buf, sd->data, to_read);
> +    memcpy(buf, &sd->data[sd->data_offset], to_read);
>      sd->data_offset += to_read;
>      *len = to_read;
> 
> ---
> 

