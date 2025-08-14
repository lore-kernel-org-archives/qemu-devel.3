Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14793CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 04:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umQ39-0000jG-Du; Thu, 14 Aug 2025 00:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umQ38-0000if-5n
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 00:58:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umQ35-0003yU-IV
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 00:58:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a1b00f187so2087385e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 21:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755147524; x=1755752324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7170DETvvwt7Ih5QHnZm37lt4bc7Ha+pOx8xtbPZddM=;
 b=bhDnl6B83/5QnFqyophPFqaLFaUevywFgEGjro7wdZuaMvI/Pvlc1rktpADbRGDF7u
 emce69R2oDeSuHJhwMWymbxH+2IzDV0nc5gflxIRaay7D9wBS2knHz2xsrY3X/r3OUGV
 n2ncDwiCObqI2eOF1+tfTFkUegpk/UQInVJUQsYjsBhWip8O+MDAKaC6jrPe3vNloMgr
 Dh/v/3VJnQAAfTCh4KU8NZpLzcyZZTymskAIgQSK3f8YcRY1z3rT09kh9sBlmxm/Fz+t
 ruLdRnV6FdNfJix0PDqodzi7bOogYl8Hk4aoTkDaR0+Oc1acez9tYG5FwXtLodxGMhUR
 vMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755147524; x=1755752324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7170DETvvwt7Ih5QHnZm37lt4bc7Ha+pOx8xtbPZddM=;
 b=jRLqWGcHlXMDLH1SyDa269rwqZUhFzNk2TDYwrNj7436Jp47jnyP+OfKzGjX7Y7A70
 CqwggH8ACEPkvEi26LAxhYJBNFgpxwklmurs6tNv7InjvTt4zuZ/znxEUo2cz61C1oRU
 Lu3ofFeero816AYfV5QL4v0gqCzY+e43apKpOy/urAecN6j3srwxClTJHwzihaPL/A7v
 703R7MiH5m9uJ6+AsJRoEkwoNja0CebVmf8LQEqdfKz3vtLmNd7aDh0NiFhXajAAQ9UF
 8pfkoHqSb2MbqWsfsszpl4YaqGYY9aWkoHritHT7Rc4bfbuwJR7MzXIrkG3tQXnGtSNS
 ytsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeZvyNVp5C/jNKV3SFJCQnI5H8F9JGKlv5TqgmgMBMTASs1kL+YSpJYPHpyeKSrjhdyCxX6B4XEssn@nongnu.org
X-Gm-Message-State: AOJu0Yw/u/KzYFrPQzCvM16pPF7MR6kGTeuXSsyHwEZsPufAaoS39hT6
 Um7I6nQUXdb4vnJ+tVkPrNQfNU5Kp2grgRLpvBj66vV4lZpi8APskPmA6DpUJzWB/+4=
X-Gm-Gg: ASbGncu7NbSNBeQfiQMQii3ACxMfvguzSA/GHEg5H/b5Cfb8wlD9GWpc0ZvFkjK/GSh
 qVbCN2bfEl6LgB8oUIBw8hNvs2htnH8PBuZbZm+TYfxfpFV1gBpwoEIiP7id2c1u37tFAn211oM
 +TQ6jq1AVoeXDGDqSYCB7deYqW97JvK8caqzLu6WV6AOsHLyOIFn7BbzJ7s2cRxklNpnDKnm9r/
 /AvsJh+odcdhgbodQ5qxDbSU+SoTxGi+EyTiFjfEb6FSybDEIxMeAPTgolTg3fjCJeeKRMV7+FP
 P4y0PUT6Z0QIHK2IrPUlsM6srACoWb88VYTYbL0duhnvQb0SgfhDV4JA+kRxoGD7+8eLIfnuiuE
 X/siRriQk+/0WM9EBCKlH/3hsPnyGNHdHrGX5QNDh3ltTs4owsQRCctpjUJ3hyQgxaw==
X-Google-Smtp-Source: AGHT+IFyojR481rcDVW6Ql1/JLUXy9XW3b3WLcVwV210A6ujHLW2kl5VSOBNmYzlkBIgc/Anior3DA==
X-Received: by 2002:a05:6000:2304:b0:3b7:75dd:f37d with SMTP id
 ffacd0b85a97d-3b9e416251dmr1094735f8f.0.1755147523989; 
 Wed, 13 Aug 2025 21:58:43 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c749143sm6185975e9.16.2025.08.13.21.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 21:58:43 -0700 (PDT)
Message-ID: <f3637a8d-04ae-4d46-b5c6-5022f5a4c865@linaro.org>
Date: Thu, 14 Aug 2025 06:58:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] vhost-user-blk: add some useful trace-points
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com, 
 peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-23-vsementsov@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250813164856.950363-23-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 13/8/25 18:48, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/block/trace-events     | 10 ++++++++++
>   hw/block/vhost-user-blk.c | 15 +++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index cc9a9f2460..3b5fd2a599 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events


> +# vhost-user-blk.c
> +vhost_user_blk_start(void) ""
> +vhost_user_blk_start_finish(void) ""
> +vhost_user_blk_stop(void) ""
> +vhost_user_blk_stop_finish(void) ""
> +vhost_user_blk_connect(void) ""
> +vhost_user_blk_connect_finish(void) ""
> +vhost_user_blk_device_realize(void) ""
> +vhost_user_blk_device_realize_finish(void) ""

Maybe use _in / _out suffixes? Naming is hard...

