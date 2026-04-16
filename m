Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9B2F8A142
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDHgD-0005dO-JI; Thu, 16 Apr 2026 04:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDHgB-0005bL-BB; Thu, 16 Apr 2026 04:02:27 -0400
Received: from mail.avm.de ([212.42.244.120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDHg9-0006RK-8J; Thu, 16 Apr 2026 04:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1776326539; bh=qmB3hM7s24a6b/k6W500gKBX/SbaVs39IaQRh/+OV2U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kFsLx2BpHXbPrn7vmUcdqXRUUVz1m4v5N3xGYr2FyVCPMzzjTFpMwjILtQatjQap7
 tMdqRoxJyTG0RZ7HF8DZOFZxKLay1o0alMWghBHzZaHJzF4FXWF/CZ2IczKqrZjOHf
 oE8ThHhiPF8CrO3lV7/HYNs7CEHbi/gZG0W7O7Os=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <c.speich@avm.de>)
 id 69e0978b-044c-7f0000032729-7f000001a9a8-1
 for <multiple-recipients>; Thu, 16 Apr 2026 10:02:19 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Thu, 16 Apr 2026 10:02:19 +0200 (CEST)
Received: from l-cspeich ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026041610022007-1705 ;
 Thu, 16 Apr 2026 10:02:20 +0200 
Date: Thu, 16 Apr 2026 10:02:19 +0200
From: Christian Speich <c.speich@avm.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 5/6] hw/sd/sdcard: Add erase-blocks-as-zero option.
Message-ID: <atp673czap4hd3ozv2u5y7fiie6fsoqkvy4ou5vwp5ukxz5iw5@ac6356oe52jw>
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
 <20260204-sdcard-performance-b4-v3-5-dc1cf172ee57@avm.de>
 <8d358e4b-d6a0-417f-b357-99a0ae06164e@linaro.org>
MIME-Version: 1.0
In-Reply-To: <8d358e4b-d6a0-417f-b357-99a0ae06164e@linaro.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 16.04.2026 10:02:20,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 16.04.2026 10:02:20, Serialize complete at 16.04.2026 10:02:20
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-purgate-ID: 149429::1776326539-41FF9960-B54D96B1/0/0
X-purgate-type: clean
X-purgate-size: 4027
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=212.42.244.120; envelope-from=c.speich@avm.de;
 helo=mail.avm.de
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Apr 14, 2026 at 05:02:34PM +0200, Philippe Mathieu-Daudé wrote:
> On 4/2/26 14:22, Christian Speich wrote:
> > Currently, erased blocks are filled with 0xFF. However SCR Bit 55
> > (DATA_STAT_AFTER_ERASE) indicates that an erase produces zeros. One of
> > them is wrong.
> > 
> > This patch does two things.
> > 
> > First it fixes the reporting of DATA_STAT_AFTER_ERASE in SCR to
> > correctly reflect the content of erased blocks. We also increase the
> > Product Revision (REV in CID) to indicate to the guest that
> > DATA_STAT_AFTER_ERASE is now reliable.
> > 
> > Secondly, we introduce a erase-blocks-as-zero option, which allows the
> > user to choose if erased blocks should contain 0xFF or 0x00. The default
> > is still 0xFF to remain compatible with current users.
> > 
> > Signed-off-by: Christian Speich <c.speich@avm.de>
> > ---
> >   hw/sd/sd.c | 15 +++++++++++++--
> >   1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index c9cfd3620b563fbe7520cfe361e14b57cd8f7472..5ddaa08d77b6b7606005fb59f42f107d254d6e5c 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -162,6 +162,7 @@ struct SDState {
> >       /* Static properties */
> >       uint8_t spec_version;
> > +    bool erase_blocks_as_zero;
> >       uint64_t boot_part_size;
> >       uint64_t rpmb_part_size;
> >       BlockBackend *blk;
> > @@ -439,6 +440,9 @@ static void sd_set_scr(SDState *sd)
> >       sd->scr[0] |= 2;            /* Spec Version 2.00 or Version 3.0X */
> >       sd->scr[1] = (2 << 4)       /* SDSC Card (Security Version 1.01) */
> >                    | 0b0101;      /* 1-bit or 4-bit width bus modes */
> > +    if (!sd->erase_blocks_as_zero) {
> > +        sd->scr[1] |= (1 << 7); /* DATA_STAT_AFTER_ERASE: Erase produces 0xFF */
> > +    }
> >       sd->scr[2] = 0x00;          /* Extended Security is not supported. */
> >       if (sd->spec_version >= SD_PHY_SPECv3_01_VERS) {
> >           sd->scr[2] |= 1 << 7;   /* Spec Version 3.0X */
> > @@ -456,7 +460,7 @@ static void sd_set_scr(SDState *sd)
> >   #define MID     0xaa
> >   #define OID     "XY"
> >   #define PNM     "QEMU!"
> > -#define PRV     0x01
> > +#define PRV     0x02
> >   #define MDT_YR  2006
> >   #define MDT_MON 2
> > @@ -1363,7 +1367,12 @@ static void sd_erase(SDState *sd)
> >       sd->erase_end = INVALID_ADDRESS;
> >       sd->csd[14] |= 0x40;
> > -    memset(sd->data, 0xff, erase_len);
> > +    if (sd->erase_blocks_as_zero) {
> > +        memset(sd->data, 0x0, erase_len);
> > +    } else {
> > +        memset(sd->data, 0xFF, erase_len);
> > +    }
> > +
> >       for (erase_addr = erase_start; erase_addr <= erase_end;
> >            erase_addr += erase_len) {
> >           if (sdsc) {
> > @@ -3287,6 +3296,8 @@ static void emmc_realize(DeviceState *dev, Error **errp)
> >   static const Property sdmmc_common_properties[] = {
> >       DEFINE_PROP_DRIVE("drive", SDState, blk),
> > +    DEFINE_PROP_BOOL("erase-blocks-as-zero", SDState, erase_blocks_as_zero,
> > +                     false),
> >   };
> 
> Keep it enabled for previous versions adding in hw/core/machine.c:
> 
> GlobalProperty hw_compat_11_0[] = {
>     { "sdmmc-common", "erase-blocks-as-zero", "true" },
> };
> 
> (Although I wonder about the PRV bit).

If I understand the hw_compat correctly, this would mean sdcards would switch from
`erase as 0xFF` (old behaviour) to `erase as 0x00` when using the migration path?

I don't think this is a good idea as an guest might depend on the erase behaviour (e.g.
looking if an block is erased by comparing a "well-known" byte in the block for the
eraseure value. Changing this unexpectantly might confuse the guest to think used blocks
are empty and vice versa).

The other way around would be to change the default to true, and use compat to keep it
at false when migrating. This would make more sense, I think?

Kind Regards,
Christian


> 
> Otherwise LGTM.
> 

