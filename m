Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B518CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1YG-0000HC-GC; Wed, 29 Oct 2025 04:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1YB-0000Fo-HC
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:29:00 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1Xu-00077H-Ko
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:28:50 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b6d53684cfdso1537788466b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761726518; x=1762331318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mfzcm/smG5MiEJoVjb3U+mcB8RhDoxgydBLQch3cRic=;
 b=cI6v4gGBKfETd/rOGThzLP9UKCHYSU4oDzUtbvQWNQquW6+ieKgmmNod6vZZfE7iAP
 aSNxU4vvvP+a+13YZGyM16VkcHV3Km1sd0ErKiRBRvUnDWbHlp0kjSUk8PMVlHiGm+uL
 Yl0QshebO9l+JrPJJovtLkezlSvNM6bZlPQBjmUyPZvPJX9auLoyHpqnuA2ghMh8V+t3
 Rbb8fkERFlNz9FMgw7s6HHibgF5hsIAaCkxSEcQgqjGxNCCzU2fsPw/QTRmi/idhxwKV
 KbMAv/v29i3W2a5DrliIg+7BptAxSxDTo+D6g0Im2yAG0iQD5eYR/E7JawgEzTHUf74u
 mlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761726518; x=1762331318;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mfzcm/smG5MiEJoVjb3U+mcB8RhDoxgydBLQch3cRic=;
 b=QU4EefbbX3WImZJT3UbC/L/XYNNh2IQfr9+30gUQ1LuXEWyyMdn1dahXJzmMRkVMVD
 hj4X4fGvyLnL/zgq9JLB6GGehlHQn89rib4wLLaOEhcTra0RSBsMZLgigJ8RkD/ZyMNj
 +M0ZuvTk8hNC7peEYA8KPKgbI9nq/W8P7HpHcmOUCnEejlyOuU+kgKSWnnERpVsBhz37
 FvCdRSN5TIP9K4BjTA6SsgknqmgDLeSOf57slIqadPvT78tO54InjQnwWPfmaLieBKpd
 ezA/z+yjf0dCNVQq0UyeMFA3JfuEcTuK99rt4KBncA79W6NYzJ9WdA3kg9G75gKd0udk
 AwZQ==
X-Gm-Message-State: AOJu0YzeCbeLpHN+sbIRH5f0CYCvX1oue31FSN592jEpFdwyKaMDwzby
 75Q7XZXcF+RpNYNxDalwd+6sTVhLc+pyngxHcgoc31G/0lRky3u18hikqAPvQptiDVGv/+Or1dP
 HMLVdAqI=
X-Gm-Gg: ASbGncsRK0hqp4NDj4DYMRj/BzY7g/LRerEIGUmEQtuUSNDCuXbafacAOSu/gPiP40O
 jxVcmJJJ70xh4C4j3R1lOvDDYJVboDT3uOwuzj4Qq83CkXQ4MBDhntU6axHp2yCpf6KO4ncbKQT
 pfS7It3rLy8sz+h2Dhc2uuEAxW8JE+rSv3cJUvUTTYTTZ2zhleYJ5GyfeFRAAyxa++uhMNZdxQP
 zCUFZ5+rAYUAtmgJ/sK9ufj16LBgVUlBRrXhVjQ4l5c+C+Z5SWtzC1JHtklk7XbHXJ0n32h1wkW
 y7duo4ZYvxM/4qODD9J9S5+Kibmaq2yu9WWdopKwy/A2rulCiCozwlzKdqEXgbRouQvgJl+QzhF
 dj+qsIE9iJRtMcYE5AdByqDJ9iPzSB/xCQLXCQ7Rw+wJhFLdqmUcnH41fiG5zdtEZNHi4C6gmb/
 XRXdMJ4cfaNGfqzTia
X-Google-Smtp-Source: AGHT+IGCe7ePOEXXV3yeKDtmuma7sPe6ZGfVUHSDl39ihr7BfmQV2w0RY1abIEYIlBae9z7rU2UKPg==
X-Received: by 2002:a17:906:f5a9:b0:b4b:caf9:8cc4 with SMTP id
 a640c23a62f3a-b703d301a30mr194426266b.15.1761726517793; 
 Wed, 29 Oct 2025 01:28:37 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85308cb0sm1390587066b.9.2025.10.29.01.28.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:28:37 -0700 (PDT)
Message-ID: <b9a46cf4-9971-496b-b338-e49a405c27e1@linaro.org>
Date: Wed, 29 Oct 2025 09:28:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/25] migration/ram: Use memory_region_get_address()
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> MemoryRegion::addr is private data of MemoryRegion, use
> memory_region_get_address() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   migration/ram.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

