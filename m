Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AD3CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 07:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAkLB-000722-8J; Mon, 20 Oct 2025 03:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vAkL8-0006yu-Qa
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:29:58 -0400
Received: from 5.mo548.mail-out.ovh.net ([188.165.49.213])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vAkL6-0000aG-Fp
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:29:58 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.107])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cqnBS05vcz5yJt;
 Mon, 20 Oct 2025 07:29:52 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 20 Oct
 2025 09:29:51 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006701c8de3-9a6c-45a2-b8eb-0baf1185b5e0,
 FF32B7A34F2DEDF77D336B29AD6F053710A0DB6D) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d54934cf-945f-4a08-8710-30f2d5f5eb54@kaod.org>
Date: Mon, 20 Oct 2025 09:29:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] hw/sd/sdcard: Fix size check for backing block
 image
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
CC: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, <qemu-block@nongnu.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <484a8687e5cd44d94597512502180ba1aba57572.1760702638.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <484a8687e5cd44d94597512502180ba1aba57572.1760702638.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 683f8e15-a81d-4e46-9618-9ae462679638
X-Ovh-Tracer-Id: 16496403961444862907
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE/lW0jZdVrBv1TSkjlZWUtv6PAtcBvoIi938bP+Y/NPTl9htWBW4gN8rfCB8HWvMENvNofcahZvkyHRSXr2TSMm+YV06w69AOb45ag5MdVjFmkodck1mV23crisLwTgbVIbBsMVRdeemU3hdXp3oj87/N69y4fg9S/4e/aRsSOZViTIdxDD/zXuT48XcK0B92nMstLirP4x6/B/0SaSuxPFTsU38dpD5iZRPp2qohrewqW9/nfdjK25vP/xK97BipOKlZ4+chD4IKfIbYAFzn54TnQ423ppIqqBz39/lkzAk3a/mJjz7HrbM5NmvSc1tS5+fS47k65rww/6Za41ca+P7jkOlXLg0uPWrUjZ8zSF57qLX5XHc0Uit6O2XIzP1pb56ObjBc8EVG1Or7lUDROqOVZuPVI9C/O0rnAjAjzSrFlc4MJkgyVLyIqz3Cagx7tg2v55z2EwUTvTEs5Ymi4emprXWmiCQS/sWW5QoRWSOc0j8SxqEaoql3MwNyFecfohVhlHdwH4XNey95EgOotWuodstMmn/cjvJ19GKx6FS38n3rA0k7QhgSw9Yqkf9irwA+ja8nT/VWCVUi1qFsQNulr6uZuE3XqagIXL/OoYJf0Rf5Hnq9h9ICHjUCDt/Az0KHoLWz0w8MbI06GRnH6PzMW+8CWvjJrrzdd0hBQIQ
DKIM-Signature: a=rsa-sha256; bh=+0N6Vrcmz1DOua3YmWrcwJp4FOHmaZfOcePVXIInMZs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760945392; v=1;
 b=M460CJHWbMmW3dISU0EMLfrJ6O0+xl83WGpcqYHSgx1O0xYZIDhPxy1hi1zXY/MHdf9/VTjn
 4amwoATL8W3YD/7Js0bVUn7S2NmpvTaqMt0Xd16I9fJnEhkJuV4zlYJ783uWFRhk1tYFqOS1fNo
 JjCkf07P7OkdPSpzE2W1EpjSJRUogMlvj/n52t5XfBjBtcvxzXJ+24M4pvXK1AN72Znv0Jq1frj
 oHmgpv3/Kf/NEqDMJPnUqtWUUy34MF2Zr/07EurJona1gq4SoB29cnPwPBY6ap5pNlj6bDPEl+h
 WSxQ2y0pr+Hs+b7jEu58+xKosZT8LtjPAxFyK6H6cjESA==
Received-SPF: pass client-ip=188.165.49.213; envelope-from=clg@kaod.org;
 helo=5.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10/17/25 14:03, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Alignment rules apply the the individual partitions (user, boot, later
> on also RPMB) and depend both on the size of the image and the type of
> the device. Up to and including 2GB, the power-of-2 rule applies to the
> user data area. For larger images, multiples of 512 sectors must be used
> for eMMC and multiples of 512K for SD-cards. Fix the check accordingly
> and also detect if the image is too small to even hold the boot
> partitions.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> CC: Warner Losh <imp@bsdimp.com>
> CC: Cédric Le Goater <clg@kaod.org>
> CC: Joel Stanley <joel@jms.id.au>
> CC: Alistair Francis <alistair@alistair23.me>
> CC: Alexander Bulekov <alxndr@bu.edu>
> ---
>   hw/sd/sd.c | 65 +++++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d7a496d77c..d1e1bb4f0e 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2759,9 +2759,32 @@ static void sd_instance_finalize(Object *obj)
>       timer_free(sd->ocr_power_timer);
>   }
>   
> +static void sd_blk_size_error(SDState *sd, int64_t blk_size,
> +                              int64_t blk_size_aligned, const char *rule,
> +                              Error **errp)
> +{
> +    const char *dev_type = sd_is_emmc(sd) ? "eMMC" : "SD card";
> +    char *blk_size_str;
> +
> +    blk_size_str = size_to_str(blk_size);
> +    error_setg(errp, "Invalid %s size: %s", dev_type, blk_size_str);
> +    g_free(blk_size_str);
> +
> +    blk_size_str = size_to_str(blk_size_aligned);
> +    error_append_hint(errp,
> +                      "%s size has to be %s, e.g. %s.\n"
> +                      "You can resize disk images with"
> +                      " 'qemu-img resize <imagefile> <new-size>'\n"
> +                      "(note that this will lose data if you make the"
> +                      " image smaller than it currently is).\n",
> +                      dev_type, rule, blk_size_str);
> +    g_free(blk_size_str);
> +}
> +
>   static void sd_realize(DeviceState *dev, Error **errp)
>   {
>       SDState *sd = SDMMC_COMMON(dev);
> +    int64_t blk_size = -ENOMEDIUM;
>       int ret;
>   
>       switch (sd->spec_version) {
> @@ -2774,32 +2797,34 @@ static void sd_realize(DeviceState *dev, Error **errp)
>       }
>   
>       if (sd->blk) {
> -        int64_t blk_size;
> -
>           if (!blk_supports_write_perm(sd->blk)) {
>               error_setg(errp, "Cannot use read-only drive as SD card");
>               return;
>           }
>   
>           blk_size = blk_getlength(sd->blk);
> -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
> -            int64_t blk_size_aligned = pow2ceil(blk_size);
> -            char *blk_size_str;
> -
> -            blk_size_str = size_to_str(blk_size);
> -            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
> -            g_free(blk_size_str);
> -
> -            blk_size_str = size_to_str(blk_size_aligned);
> -            error_append_hint(errp,
> -                              "SD card size has to be a power of 2, e.g. %s.\n"
> -                              "You can resize disk images with"
> -                              " 'qemu-img resize <imagefile> <new-size>'\n"
> -                              "(note that this will lose data if you make the"
> -                              " image smaller than it currently is).\n",
> -                              blk_size_str);
> -            g_free(blk_size_str);
> -
> +    }
> +    if (blk_size >= 0) {
> +        blk_size -= sd->boot_part_size * 2;
> +        if (blk_size > SDSC_MAX_CAPACITY) {
> +            if (sd_is_emmc(sd) && blk_size % (1 << HWBLOCK_SHIFT) != 0) {
> +                int64_t blk_size_aligned =
> +                    ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
> +                                  "multiples of 512", errp);
> +                return;
> +            } else if (!sd_is_emmc(sd) && blk_size % (512 * KiB)) {
> +                int64_t blk_size_aligned = ((blk_size >> 19) + 1) << 19;
> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
> +                                  "multiples of 512K", errp);
> +                return;
> +            }
> +        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
> +            sd_blk_size_error(sd, blk_size, pow2ceil(blk_size), "a power of 2",
> +                              errp);
> +            return;
> +        } else if (blk_size < 0) {
> +            error_setg(errp, "eMMC image smaller than boot partitions");
>               return;
>           }
>   


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



