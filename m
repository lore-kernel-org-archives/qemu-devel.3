Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4613CF3959
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 16:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLlDV-0001Di-4s; Wed, 19 Nov 2025 11:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vLlDJ-0001Bw-I0; Wed, 19 Nov 2025 11:39:25 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vLlDH-0003Hg-JU; Wed, 19 Nov 2025 11:39:25 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A42C7C0417;
 Wed, 19 Nov 2025 19:39:19 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d4f::1:a] (unknown [2a02:6bf:8080:d4f::1:a])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EdZ4hj1FoqM0-PnOuENIM; Wed, 19 Nov 2025 19:39:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1763570359;
 bh=DM0KRnw/bJmlXF59KSLJHO7inhk1CSuI+W867TiXkhk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=1aV3AQx9aES23Vo5+MMzL/Y4U1Q/xSdVQV9kID9CPGBFyxOO5gCBPF5Z0uI5h3BF4
 iYmwL1dOKyCcf3BHSPNZ0GR9CkFWL1iXtOFXUxpaH5+YEU4mAePovvIojEwsXcoIkr
 pM/RDLPTvlXlZtbSzEM/5jVb9Kkrncl88vVYyO64=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a36f938d-b35a-4605-ab77-6ed7dd419945@yandex-team.ru>
Date: Wed, 19 Nov 2025 19:39:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/nvram/xlnx-bbram: More idiomatic and simpler error
 reporting
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, mst@redhat.com, imammedo@redhat.com, 
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 alistair@alistair23.me, edgar.iglesias@gmail.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 berrange@redhat.com, peterx@redhat.com, farosas@suse.de, eblake@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-3-armbru@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251119130855.105479-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19.11.25 16:08, Markus Armbruster wrote:
> bbram_bdrv_error() interpolates a "detail" string into a template with
> error_setg_errno(), then reports the result with error_report().
> Produces error messages with an unwanted '.':
> 
>      BLK-NAME: BBRAM backstore DETAIL failed.: STERROR
> 
> Replace both calls of bbram_bdrv_error() by straightforward
> error_report(), and drop the function.  This is less code, easier to
> read, and the error message is more greppable.
> 
> Also delete the unwanted '.'.

Also, using "errp" name for local "Error *" (one star) variable is a bit misleading.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> ---
>   hw/nvram/xlnx-bbram.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
> index 22aefbc240..fe289bad9d 100644
> --- a/hw/nvram/xlnx-bbram.c
> +++ b/hw/nvram/xlnx-bbram.c
> @@ -88,18 +88,6 @@ static bool bbram_pgm_enabled(XlnxBBRam *s)
>       return ARRAY_FIELD_EX32(s->regs, BBRAM_STATUS, PGM_MODE) != 0;
>   }
>   
> -static void bbram_bdrv_error(XlnxBBRam *s, int rc, gchar *detail)
> -{
> -    Error *errp = NULL;
> -
> -    error_setg_errno(&errp, -rc, "%s: BBRAM backstore %s failed.",
> -                     blk_name(s->blk), detail);
> -    error_report("%s", error_get_pretty(errp));
> -    error_free(errp);
> -
> -    g_free(detail);
> -}
> -
>   static void bbram_bdrv_read(XlnxBBRam *s, Error **errp)
>   {
>       uint32_t *ram = &s->regs[R_BBRAM_0];
> @@ -162,7 +150,8 @@ static void bbram_bdrv_sync(XlnxBBRam *s, uint64_t hwaddr)
>       offset = hwaddr - A_BBRAM_0;
>       rc = blk_pwrite(s->blk, offset, 4, &le32, 0);
>       if (rc < 0) {
> -        bbram_bdrv_error(s, rc, g_strdup_printf("write to offset %u", offset));
> +        error_report("%s: BBRAM backstore write to offset %u failed: %s",
> +                     blk_name(s->blk), offset, strerror(-rc));
>       }
>   }
>   
> @@ -178,7 +167,8 @@ static void bbram_bdrv_zero(XlnxBBRam *s)
>   
>       rc = blk_make_zero(s->blk, 0);
>       if (rc < 0) {
> -        bbram_bdrv_error(s, rc, g_strdup("zeroizing"));
> +        error_report("%s: BBRAM backstore zeroizing failed: %s",
> +                     blk_name(s->blk), strerror(-rc));
>       }
>   
>       /* Restore bbram8 if it is non-zero */


-- 
Best regards,
Vladimir

