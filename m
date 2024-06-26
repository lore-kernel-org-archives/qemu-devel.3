Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0300C30659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 12:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMRO1-00078e-LS; Wed, 26 Jun 2024 08:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMRO0-00078D-JI
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:04:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMRNx-0001Q1-Bu
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:04:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-421f4d1c057so51557345e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 05:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719403464; x=1720008264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5oQWaIBZ17CKlldckKnapKuRBrmyX7UwkA/lwYdTLUY=;
 b=P50oMXo27lLiW6HJVzOt9QUk7mTKrcfjRtEK9LCb+2vKviNqA1EZ0jVelnzGF+amnP
 pLVj4F7ovGHj5as4UwlqFaHnetFRcu0JLvvz4qiVhuBcSExFb7LsqJj5qpIlk+r9/URh
 1M9aL22htwS5SS2foUh5tu5ILchPin10c1zByM1CifRjHmn8CwfNpg33yqjhD5bXHa3Q
 12Po7L7ZH5099O+Nikq1EbS2CTTn1mduuMmAwvY4/L+a0B0Z9+4fUyB/q9EGVyIat+wH
 I2lc2SxqrIYFtJa3DxMBuasbCBsswk2bqXfsrRgO4+bRsLlwfbJhpHu5C9vt2ViyQtp2
 3J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719403464; x=1720008264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5oQWaIBZ17CKlldckKnapKuRBrmyX7UwkA/lwYdTLUY=;
 b=J6YpSrfuc+N1Ve7eYcWlv48IUPA8v5FFP9Jfz+Kn1zqMnv+qtGisHoDwGVEdGZsGoo
 jQ78YqrLw4QvmuGjZw9iWXvInmMTz5+QmxfmQIqi/d2O+kb5cG89eVn1emB6D9b+2Ho5
 uF9rKG+SteN/brcfaywNoTJmJmrQxDhZnDyZXmDsMA3h0LL7XIFElXLXwOW6perm4MIC
 iN2m+gbaTdigSKS+cI+GQHFlg1pLH7MTyVltrMvOuMMQntd1sm984dlx6R+J7RL/k8Ri
 qO1T/Ea1mLKmrCbKAuPu1Kfn8uJOLVSCtF34+7JOZlypp0eY45fz/3JZwQDsQ79VNxBQ
 DFfA==
X-Gm-Message-State: AOJu0Yz53OHzkx2P3d4f+uTI80qUOmp9tq9p2uB3nEi9vLXDGZc59M4k
 ZYmGD16LfFnly1tPNWGv4Vr/JQ3PKCzisuYbmQeuUgb6Vh0oPHdScYY0tzu3Vhg=
X-Google-Smtp-Source: AGHT+IEPlk5GYi+TpijixAFYL8UHMtD/cD7+35/u7wPSPDc51W45D3aXtuFnuScUhQQqEOi/eHpUiw==
X-Received: by 2002:a05:6000:178a:b0:362:9313:e535 with SMTP id
 ffacd0b85a97d-366e7a56799mr9129145f8f.48.1719403463541; 
 Wed, 26 Jun 2024 05:04:23 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.234])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366389b8ad2sm15554877f8f.33.2024.06.26.05.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 05:04:23 -0700 (PDT)
Message-ID: <abae8326-84a8-4cdd-aad7-8986cb655a68@linaro.org>
Date: Wed, 26 Jun 2024 14:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] hw/core: Free CPUState allocations
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 qemu-trival@nongnu.org
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
 <20240626-san-v1-1-f3cc42302189@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240626-san-v1-1-f3cc42302189@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> This suppresses LeakSanitizer warnings.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/core/cpu-common.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 0f0a247f5642..42f38b01a97f 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -274,6 +274,9 @@ static void cpu_common_finalize(Object *obj)
>   {
>       CPUState *cpu = CPU(obj);
>   
> +    g_free(cpu->thread);
> +    g_free(cpu->halt_cond);
> +    g_free(cpu->cpu_ases);
>       g_array_free(cpu->gdb_regs, TRUE);
>       qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
>       qemu_mutex_destroy(&cpu->work_mutex);
> 

Similar patch queued via trivial tree:
https://lore.kernel.org/qemu-devel/3ad18bc590ef28e1526e8053568086b453e7ffde.1718211878.git.quic_mathbern@quicinc.com/


