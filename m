Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5671CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 09:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNpOu-00068Q-Pe; Tue, 25 Nov 2025 04:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vNpOs-00067L-SV; Tue, 25 Nov 2025 04:31:54 -0500
Received: from mail.avm.de ([212.42.244.119])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vNpOq-0005bx-Nc; Tue, 25 Nov 2025 04:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1764063107; bh=dLDkBRXZ/w5kBrVKsCCzjjUrXJeEzVFwKjDtJtpNHhU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YSn8vDM7u0IaXa3Hr9O2ndg3DyG5TTtdMZm781JWOefuFmFJ4Z/WIli9oHVor7tZ8
 Y3+3+/CtrxWLFjb8TXiNgOmwVGQnnLwdni07QiYORBsOTpRDpnhz/ttpOyATwcZlSg
 C1syYce0DZUJrwu3Muh0p9uPH4DEPZ5Uqx6XXTmU=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 69257783-2186-7f0000032729-7f0000018e68-1
 for <multiple-recipients>; Tue, 25 Nov 2025 10:31:47 +0100
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Tue, 25 Nov 2025 10:31:47 +0100 (CET)
Received: from l-cspeich ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025112510314668-6997 ;
 Tue, 25 Nov 2025 10:31:46 +0100 
Date: Tue, 25 Nov 2025 10:31:45 +0100
From: Christian Speich <c.speich@avm.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-block@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Bin Meng
 <bmeng.cn@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH-for-10.2] hw/sd/sdcard: Correct SCR
 'DATA_STAT_AFTER_ERASE' bit
Message-ID: <x7xeywmpvfukdty64br4eebd6vbplgchlklh5ehcwhmsp4o5au@pyv2xgmedgin>
References: <20251124042008.55710-1-philmd@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20251124042008.55710-1-philmd@linaro.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 25.11.2025 10:31:46,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 25.11.2025 10:31:46, Serialize complete at 25.11.2025 10:31:46
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-purgate-ID: 149429::1764063107-0C5ECCF8-2E8AF582/0/0
X-purgate-type: clean
X-purgate-size: 1269
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

On Mon, Nov 24, 2025 at 05:20:08AM +0100, Philippe Mathieu-Daudé wrote:
> As a 'SD card vendor', QEMU chose to fill blocks with '1'
> during erase operation. Update the DATA_STAT_AFTER_ERASE
> SCR bit appropriately.
> 
> Fixes: 818a5cdcfcf ("hw/sd: sd: Actually perform the erase operation")
> Reported-by: Christian Speich <c.speich@avm.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/sd/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 40a75a43ffb..d35537702b2 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -446,7 +446,7 @@ static void sd_set_scr(SDState *sd)
>      /* reserved for manufacturer usage */
>      sd->scr[4] = 0x00;
>      sd->scr[5] = 0x00;
> -    sd->scr[6] = 0x00;
> +    sd->scr[6] = 1 << 7;        /* Data after an erase operation is 0xff */

Although the rest of this function works on magic values, maybe it would be
usefull to introduce a DATA_STAT_AFTER_ERASE define for this bit? This would
make it easier to search for it in the spec (or other projects, google).

Otherwise, lgtm. Reviewed-by: Christian Speich <c.speich@avm.de>

Greetings,
Christian

>      sd->scr[7] = 0x00;
>  }
>  
> -- 
> 2.51.0
> 
> 

