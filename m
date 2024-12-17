Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22862E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZae-00047j-1c; Tue, 17 Dec 2024 10:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZab-00047R-6r
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:34:25 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZaU-0006Sy-VL
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:34:24 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71e1e051e50so1211829a34.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734449657; x=1735054457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RF2e0vHl7eHDKLOZnAXYsa/F6qzkBeBInG2A8jmpCEI=;
 b=F691otraobUoveAbGwzcAIo60ohAZnUOP2hhrsBg1XgzQMGjzK2BFRZqfaVN1t8IMw
 BdXgf80ouOqzIoOCeDl9N+BxQVlmCugA6LnoNriq/rGjHgRy9JVo6/Mr9bJTUOArwCfb
 sMpOPO8YSeRFemWNYg+OzasKR6liL1VQiqhK/7dfTMMj1jbWfm0V/FHMyUfvI3cSoAZJ
 k/2l/+NDX9lKdro6nJ1ny4tecRqf+bh0v5A07VD6Vbf9HiI74Hjd2VWDuthtF6GPEpIh
 SoCMZ1yxRnCiJNeTb/yOhNDkSWH/XuXFlU+g2hH1S3Px6T4EoS/rj90oB7n3CuycDUAp
 diMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734449657; x=1735054457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RF2e0vHl7eHDKLOZnAXYsa/F6qzkBeBInG2A8jmpCEI=;
 b=qzoopVLFPrDa3JAqhipJGFSoh3Dvqg1+VUtQLNOjs1FQr1zjyzWJR49FfdBmxXrILD
 BIW0402Ar8998Pf5AdhYLRKygMFl15d+0+pgX8Iq7INpWSrDoFew8jJeDYFiLVtARVTm
 7Z/EKVDjVm1GdVLb2P0shtYdNuV9yUIjpOGgWkN5g7+9aBqT9+t0tzLVoeQF9HET+dOQ
 NyODlP0cNwbvNYkJlWNg5Gy30I5o0GWC9f1eIzE1fwogzxLRYAJz7HhkucYrW4jaXUcI
 7UfQ8Ut5Ix8TWTyWPGRvYlBf2ewIJkIR27YYz0bM60rVPtKP0WC6u4dnMn79O9fXgxlY
 7QKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfw8O7eVkSgoqJpTqmjvcEPnv5ztjFasJ4dvxAB3DO952SEbvdOHV+IP2iEa9pjLHn1Z499rDj6tt2@nongnu.org
X-Gm-Message-State: AOJu0YyCW8Or7lNawJ0XYmgWHAvDrR9KBLaUmIkWbz27LdzxZcklCFAM
 r+wSNW9wh61/w8tcFaXxvCleo0r3SW4oh2KVYPxtC9MZ2yzCFv0OxHFj5cAdIB0=
X-Gm-Gg: ASbGnctgPVun14L0GUfsXGHO/p0YO1lNNtOgSoHhPXZBfz7g9oS23Hmv/5Cd2uGAair
 lwvIdHD2CCGQ5MHL2B78hbBfg7Ta37+/mu2j99mKHFmcBw6y8zQKsqDZhzpb1muG2ywHqSPhjkZ
 3gA2rxvSksPP/mWAX92I9QzCAHHTuCOnfe61hPT+lYm3ne5+tbSjTsorbo4Qf/wi8AHZHrJ5QNY
 Y4cg8M+dxRnmquRtYn0mvnFbfuY9rx+brYTwui4p/MeLBYSx2JLnGDIw6CX+zV+1YmW4/8Wjg==
X-Google-Smtp-Source: AGHT+IHAeo6x25osTJ+JzA3STElXExeV1ZwJydJC4y8ZHYzg7EmUZqzGBxhT3ME9o3C/NDTI1tpmtA==
X-Received: by 2002:a05:6870:7a0c:b0:29e:6096:c271 with SMTP id
 586e51a60fabf-2a3ac53f419mr9180694fac.9.1734449657453; 
 Tue, 17 Dec 2024 07:34:17 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d269e078sm2803989fac.30.2024.12.17.07.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 07:34:16 -0800 (PST)
Message-ID: <a1a38b2f-fd2f-4e02-8e12-e9acdf852864@linaro.org>
Date: Tue, 17 Dec 2024 09:34:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] contrib/plugins/hotblocks: fix 32-bit build
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
 <20241217010707.2557258-10-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217010707.2557258-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 12/16/24 19:07, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/hotblocks.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> index 02bc5078bdd..09b0932275c 100644
> --- a/contrib/plugins/hotblocks.c
> +++ b/contrib/plugins/hotblocks.c
> @@ -34,6 +34,7 @@ static guint64 limit = 20;
>    */
>   typedef struct {
>       uint64_t start_addr;
> +    uint64_t hash;
>       struct qemu_plugin_scoreboard *exec_count;
>       int trans_count;
>       unsigned long insns;
> @@ -91,7 +92,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>   
>   static void plugin_init(void)
>   {
> -    hotblocks = g_hash_table_new(NULL, g_direct_equal);
> +    hotblocks = g_hash_table_new(g_int64_hash, g_int64_equal);
>   }

I think this one should be using a proper comparison function: compare both pc and insns, 
the inputs to the simplistic hash function:

>       uint64_t hash = pc ^ insns;

An existing bug with the plugin, obviously.


r~

