Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24724C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 12:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMRMw-00064D-Fd; Wed, 26 Jun 2024 08:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMRMu-00063F-Pl
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:03:20 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMRMt-0001Jm-44
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:03:20 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3626c29d3f0so3564374f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 05:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719403397; x=1720008197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pNotolGjEzosFZxUZhK/Xq2SnJYjKmHcUh/U8UvdC4g=;
 b=wCvyo6HhAq7TZ75+c/Lf9PIYZstRrU+ZAluJ5YsGG1hlhrIPYkvj3kHJzKjS8glF2f
 qp+elCbq5mdeQbHlUzlwCZ5BIMb0qCiRlWpy+SuM3eLnF8WGXkp9IpOdLDixkuNOK7hH
 2sFgBgNPx5+FoBE/BCkBwYZiBT9DN42q8CrSKm1X3y5PBsQOPSfi5GyqKrD4SYTbj+c0
 5VoKIM4wO//Fm+2ABM+5OJ3lzzJWk6moWkpymZZv3bZsOB6zlFWOHDUW0lS33nc+ssEt
 vgQTReCdu0qixSwohu0cNmt5TqiGLBkXmDbxIJvf7hEowlnvRRM6VA0DNQpHVqTnl+d8
 wsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719403397; x=1720008197;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNotolGjEzosFZxUZhK/Xq2SnJYjKmHcUh/U8UvdC4g=;
 b=ElbmwskEKFbzjsTA073/vhZrEhudcao51i2Uo0AoNvwdRAKJexIE0Zt4TMPX8C7U9H
 VtZdCsRJljhXliCXnLbqiKHtCsId+NerbEVo6nkVHelYNxzSQtp4gqxSL2Y9AWNIAeam
 QKUQJlTFi97HJTgJY0b4C5hHvEXy427AM7iI0/ScUEPRg7ZGiAmg8+TkNFOnlCzgu8xV
 QT/XyP70RiRUvXVsNHu+o7zBt1GeLCv7LcBQG/ZXzyGZJedc64iaedxHIM3pA20jfLtS
 /1SggBZqSfVxn1k5mnrRvOfKsvQsIG+3uFj+jqoyacRsudbxKhUjuQmBQT1tssdYCGix
 DBnQ==
X-Gm-Message-State: AOJu0YxaNz8uRTxsPDKFLdVmE1/YO8QjN2N5YYuFAEjzv8Rby4OOy2dW
 GtCMgpekXlty2gHSFfqYDv3OXvQmg4V1P7tUqVSP/GTyPDyFltdEM8p4oqX94t0=
X-Google-Smtp-Source: AGHT+IHJvivtO64hzjs1VtcKhIhY999KPvUtNHmK+wIiobjUCFGR2xfAbXQ5Iy5jh129Qu3sLZuqWA==
X-Received: by 2002:a5d:634d:0:b0:364:1692:ea05 with SMTP id
 ffacd0b85a97d-366e948e6d7mr6753449f8f.21.1719403397526; 
 Wed, 26 Jun 2024 05:03:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.234])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638f858fbsm15562855f8f.65.2024.06.26.05.03.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 05:03:17 -0700 (PDT)
Message-ID: <efdfa803-775c-4aa2-b7c4-f016dafe9a88@linaro.org>
Date: Wed, 26 Jun 2024 14:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] ppc/vof: Fix unaligned FDT property access
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
 <20240626-san-v1-5-f3cc42302189@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240626-san-v1-5-f3cc42302189@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 26/6/24 13:06, Akihiko Odaki wrote:
> FDT properties are aligned by 4 bytes, not 8 bytes.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/ppc/vof.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> index e3b430a81f4f..b5b6514d79fc 100644
> --- a/hw/ppc/vof.c
> +++ b/hw/ppc/vof.c
> @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
>       mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
>       g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
>       if (sc == 2) {
> -        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uint32_t) * ac));
> +        mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
>       } else {
>           mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uint32_t) * ac));

OK but please keep API uses consistent, so convert other uses please.

>       }
> 


