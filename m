Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AAB109317C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 07:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Tyc-0003wI-Mf; Fri, 20 Mar 2026 03:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3TyY-0003vP-6n
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 03:08:54 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3TyV-0000lR-To
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 03:08:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48374014a77so14645885e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 00:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773990530; x=1774595330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cmyb7PwsyG0KXmUJnRQdmXOhtsMGL9iFNphCYUFU+3U=;
 b=TRjmxqrsl9F2KJ6+vKUJ+Squ71RZd3cp6kKrPhlgsgTZF7WsUc/vjb79snxPAr/N/K
 Xp2iCRk41RYgSbMgoF3PJ8sO/UC/Cnq24PA5KzcsBrNNhZpyANhX2dUtUtEogd+IltI/
 Qhi5bMBRaAZb+JAL4A+Q8HdCk22/iReLaxdoB6cx/HC/oY1CC5b9Idt+RSxehj6EU9vc
 RsagMf5eaLCqKxGscGc6NbE+UqPU6kyI1JKBGxovbjY4Ip/YuVlNcTUzEwuh7+ve127J
 5iQdcXOIhzuFwWiqtk9HbOUES9qCwnqe6SUCohj5706TrL931JEUPDBvE/tzEMry8vAe
 82pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773990530; x=1774595330;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cmyb7PwsyG0KXmUJnRQdmXOhtsMGL9iFNphCYUFU+3U=;
 b=ek1fHZCDjTdsDeyvahIJctMtA3yn6cewa9c78bS2yQKTDGX3W/Mc7K+tgy6CMrkqVj
 SstSAprJiXefesqQqpwixRJhBY3qKBpxX62V7FWRsXXieUirysgisBCaSAHT1wzAiFoU
 sji0ymKUKi1NXqcyKnrNzKqbxp8f87WQLkuvr2BTPAy0o+FHekBRceDGaxDz+hM9CPCV
 Hm8l5rM/aEtP6qDzuZA2X+D6i3FO8g38dpy0LvwbYqESjkijO5C51kT4ah68wbYXPd0h
 rL6fojkYEpkzGhrOPly8GRGUO1gxBEzzeywEA9MwXuHuQK1FBiTNnonlEoZ5bnRuZViC
 Dbwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVscIVuR/svccV3hUzY+MrY/yCegdb2Z0LzzM4On86fU/yfY8HywT90ck5Dn4Xk8WwMsmVDrPS8dggg@nongnu.org
X-Gm-Message-State: AOJu0YwqRciAUK07UQ+DnadeL2dB4CgBO+KjGl6UoOgZ/DdEssqJ6fJi
 ya/KhDqgwTRTTmbqPLPi+Fs/5dkaHDQMR9oz08gMkxeWO3aJ1IJpsW9a+kMRmdbBZgo=
X-Gm-Gg: ATEYQzzoInxZJw6RaCaUPftVBIw6FNzB56Wv93hWkSjiaT7rewA44CeW0kNidOtNaOg
 gYqN9/ZcvPmczE3RyrIsDGU679ntgJsQTgQXg0Wg0OL73TI1KkZQqEgXL9pg9NvgK5PXC7qBORk
 qHeagSuN3KSGeFrSFK51lqpv6JPYSeKWuM3snKT+EJKRnDpgmFvSSlgQImQ0JnHt7Xdbk1WcDPT
 0+kKf0/waSpeLyDqC0Ay6ahLYk6H+0Flcz9JeKeyhPOoE88eu6g1TIqy3gTUDYhNjyMjn0rxBPV
 tL2t8WHMYH/QwfPuqhnazrhI8FGwn3S8WNAPUD+3InPAf2+t+VfvOpN/T3/wVoIvufyrBXCNOOh
 10+eDXJW3dpyaffOZaypMG2SxT0FgJNUPnxeBD15KPaHfwDhoeZVcsmw/vl2oJ4Y+E4w70nc1lM
 Ksic1k4I10PnoLsguGxyPukrW/Cx6J7R5PDfJYlbo3L1cYGK4c8Snoaipyzan4RzCNPA==
X-Received: by 2002:a05:600c:c111:b0:485:3a03:cee1 with SMTP id
 5b1f17b1804b1-486ff02119bmr17976485e9.33.1773990529834; 
 Fri, 20 Mar 2026 00:08:49 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe83e994sm38863275e9.15.2026.03.20.00.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 00:08:49 -0700 (PDT)
Message-ID: <ba45d8ab-7c2f-4634-9bce-900af78ecc8d@linaro.org>
Date: Fri, 20 Mar 2026 08:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide: resolve core crash caused by optical drive pop-up
 during virtual machine startup
Content-Language: en-US
To: yanlonglong <yanlonglong@kylinos.cn>, qemu-devel@nongnu.org
References: <20260320020724.8714-1-yanlonglong@kylinos.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>
In-Reply-To: <20260320020724.8714-1-yanlonglong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

Cc'ing maintainers:

$ ./scripts/get_maintainer.pl -f hw/ide/atapi.c
John Snow <jsnow@redhat.com> (odd fixer:IDE)
qemu-block@nongnu.org (open list:IDE)
qemu-devel@nongnu.org (open list:All patches CC here)

On 20/3/26 03:07, yanlonglong wrote:
> Signed-off-by: yanlonglong <yanlonglong@kylinos.cn>
> ---
>   hw/ide/atapi.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
> index a42b748521..d14feed45b 100644
> --- a/hw/ide/atapi.c
> +++ b/hw/ide/atapi.c
> @@ -153,6 +153,11 @@ static void cd_read_sector_cb(void *opaque, int ret)
>   static int cd_read_sector(IDEState *s)
>   {
>       void *buf;
> +
> +    //resolve core crash caused by optical drive pop-up during virtual machine startup
> +    if (!blk_is_available(s->blk)) {
> +        return -ENOMEDIUM;
> +    }

IMHO we shouldn't reach this because drive ejection should cancel any
running transfer (with ide_transfer_stop IIRC). We could assert here:

        assert(blk_is_available(s->blk));

to check the missing cancel transfer path.

>       if (s->cd_sector_size != 2048 && s->cd_sector_size != 2352) {
>           block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);


