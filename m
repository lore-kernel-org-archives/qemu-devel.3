Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399BEC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twQrz-00030s-L4; Sun, 23 Mar 2025 15:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQrx-00030W-Tn
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:20:25 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQrt-0006rj-VL
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:20:25 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223fb0f619dso71169045ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742757619; x=1743362419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9JfijrTmgBFCapMyaayEmyYA7LUF0f8zA8VUgYNpfAw=;
 b=lVIbh0QZdwv4HoB/x5mGh2lQ7t1o61ejG4LLh+K/dL4NYIbiJBy687sK55nHYgBnfj
 sI+3V7f/Mqv2URP1CPYvKh0lHxRmI/Hq8nK5ETrnA8WMC65Mf7gLYAIOyrLBy7dJvlTG
 E1jE149+B/MRuFJj5HIR46ixvD9atQpyHR9mGzDSYLyJU0Kbx1wqGQgjJ25LFYVSkpCX
 Op1H0m7QlVAqln5bVOoAsJN6KK3M+f8iw5Y7HFKKhUdZLvF8T/2qsm6E9yGCp+wNTHOO
 +D0u92q4j4psNlys+H2dpYGTd0ONTh6/1PiDTTp/Y0UR2a049DUOThASkIhtPRrCjP0F
 rNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742757619; x=1743362419;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9JfijrTmgBFCapMyaayEmyYA7LUF0f8zA8VUgYNpfAw=;
 b=Bsr4LndOSKJ9X/vodHeTN0oDbEpFzVI6d9ul8zEaRXIa4ED0NwWaEYUcvfTPcLmn7s
 wLtUg/4cWiPPxm50BxU6dSZ6vEx3lCR75FuUJjJs4NpRfkoux2FtodY2ytF7qL7YLTyR
 23yF3hPylLEm/I5+JWVTWLg0DZzmgymkWtcqb8dSx9Mswqtmj3n5bnhydNwR3hmsMPas
 7Xh44cVgZ9d7eGshDTfo6nvmNoGQcskiNpakAQmRAaFSWQ+2TQHaLkb6Pe6S/ZyqMxv4
 ZI7msgxpa6w35ujHdCQ9KQnvsN0IxOFu9+U5gQkvBctDHuItOEto2PDwNbR2d3nwsrd0
 +aeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTMq0GH3l3OdRXHmKUSdxP0LQPTIlYL2BY7VzBHwkPAkd2pfvrUh9wWXHdizfykvKS8d3SKFVsv6Tn@nongnu.org
X-Gm-Message-State: AOJu0YxPF6DmJeQmjTlePOQ5maQCZJ4TiWREmfFhvFC6vwmni8XMmDrJ
 SOq5Lb1b3X6ZQhNqu7brC9iSnsPHb3x5BefOPMByinGtwB4I/HPBB5YkU4xkdwnExy5/6W6YDoG
 5
X-Gm-Gg: ASbGncsOXV8ra5xIHUJF6q209SLuQrR7ECfe9KLDAbUFuRrW9jxu11I0OdnfuZwcecg
 VBX/6CfLBMiPT3yzBiXNDZI7xFw3X0sCVKokLOcnTCDBptK7MBlcPfykoGMRwV0rRBfo7ERnKzE
 EemdhYpau8v20CmNjfJrUHv4IcALFyxdDmCTRARCxTp2nbP4HbNEwZrP+epyfMgr/TYEPZi1M8/
 3pHwatOXd3210uZRvK84DmgCTXsuYmE0Ule6eudzCVitQz0Wy4suvwWKy3PhohFZVarN4U5wpAd
 id2r7ALX1hMIcvqseqkK9Fx1FleZRXXSPXcnwb/BJ8FFFLUWZSdaXjOzNCvO0FAlFKflAJ4yj6y
 GjNlQZHcn
X-Google-Smtp-Source: AGHT+IEX1uCvnFZbhUgX1knhzfxdTVtTH6x07kHvBrUtZ1+TXm9GN145jVHqx95NMK3Zb6PRjwGD4w==
X-Received: by 2002:a17:902:cccb:b0:224:255b:c934 with SMTP id
 d9443c01a7336-22780e45114mr153339285ad.51.1742757619566; 
 Sun, 23 Mar 2025 12:20:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a27de717sm5627349a12.12.2025.03.23.12.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:20:19 -0700 (PDT)
Message-ID: <ae574fab-f043-4499-a67a-14bed6ee39bf@linaro.org>
Date: Sun, 23 Mar 2025 12:20:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Fix a typo in s390_cpu_class_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
References: <20250323153018.73491-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250323153018.73491-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/23/25 08:30, Philippe Mathieu-Daudé wrote:
> Fixes: 41868f846d2 ("s390x/cpumodel: "host" and "qemu" as CPU subclasses")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index d73142600bf..1f75629ddc2 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -377,7 +377,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>       resettable_class_set_parent_phases(rc, NULL, s390_cpu_reset_hold, NULL,
>                                          &scc->parent_phases);
>   
> -    cc->class_by_name = s390_cpu_class_by_name,
> +    cc->class_by_name = s390_cpu_class_by_name;
>       cc->mmu_index = s390x_cpu_mmu_index;
>       cc->dump_state = s390_cpu_dump_state;
>       cc->query_cpu_fast = s390_query_cpu_fast;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

