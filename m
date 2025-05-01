Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51096C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 22:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAccE-0000a2-S4; Thu, 01 May 2025 18:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAccD-0000Z8-0E
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:42:49 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAccA-0005Rn-2i
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:42:48 -0400
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-86142446f3fso40543439f.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 15:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746139357; x=1746744157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WDRi4VSEk6OfniXtRpBatK7NsCoQVVdPMP3Q8XnultY=;
 b=esHIWvtjyP0rZPOq01g3sbCv/h40BQadCEXmM8QlInMYxuFuLThHrHl+0MN8rWjDyD
 Uvkb+zGuLSSFF0xiZFTUJ4acd5QzOUEuLV1wJCDwW/s+Gj5JzHMxhiKIQringU5KO6AD
 ismGl1MGDdfzbVYuoq5dyelZn4CsVQ9gfC4LonMcDctRzmYLyCa41hejSLelJvU+h0Ws
 1vXIH5Hw2V3HokAR08ichICRmmplHh7jCVhN6OCbuLreSHjXJ4ofZcepwUt1K6PWAaBM
 u0DDFWUYqMaUOOQP4fM8t0xU95Rovf5fhrcvAuDoXujCzGesRS5bHUmrYZgx1CcM4D1T
 v7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746139357; x=1746744157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WDRi4VSEk6OfniXtRpBatK7NsCoQVVdPMP3Q8XnultY=;
 b=chHBIiZkiEUI71mltjHA/ZGw6bfa0i4g9nGke1dWtu2IzPQQvDCuP2FHWpAWGvBISM
 MyhEWGGpvpQuTg9otrOK0H6N1T+2YFV8bTTyqCsnwNwlaEKSU+liZMtg+nr1sKxmSyyz
 cTlfelmFRW+iOwuZDuWZt95TeW5je4w8YLVuW6EVr9DH4xPERsaT8UOLKqgE5MK1wJgg
 utWaeL0Kwe/xrSQFmM/Mmzu4lAEnHtkU7mBTB7SnMIMYvcMVkGZpeZ+pGBPQ0oPRn1d/
 akKX8DmhtH+ptqfn8+ucMpIH+pZxWzt6K/NZYfNEciNmv52Pi+6ALYf6B5qJ5EuWnfOf
 af1A==
X-Gm-Message-State: AOJu0Yz3EgsO/Ly75Z0/PKrrSO6MyIjtLjfWB7pshMOTh6r1YSla/F8S
 YaJb5zxA9smW1ONi/EArrorei/EXEJsMct6ZfJtsBu7Qdf2jLTEOPGOYMt7eBgs=
X-Gm-Gg: ASbGncsQsBuGc9zxB9T9+de/0QDlqBtR0ErhVZMIPD5RAuAGGP8nJMM4DoERl0WxVUg
 m9HYbW/4ljokAGPY8cdwjbk9K/r9YA0jiC3+uMohv3jXmYpRD8m6WnsTcEf3thhYNW4ubh3hbE/
 oHi6T2V8fIXr8f2df8eDwLG7aQXNKgEgI4ACt3OD2x72b8UVS3QAUHFzatWZ5oKX4dyjQvtPrVk
 yi29hgkKp8Ll5X6N7omrPrOi82KxHdGg13ugzqeETRNMdZukXjB/AtPuJBcg0/6+aUKnYBMADb/
 OCANYAAdCiIzl0W7vD3MNVIkx6vsjcR4SeI0CouQLL1s6HXjWzs4WgNUmWiRbP+HvMaNxnXg0Nu
 kClkvLJmTmkiwbg==
X-Google-Smtp-Source: AGHT+IHep2wsYRPLhjIvVuLapZDFK/a+5llo2sdxTnnZj/53ZFwbFikAiXnFEqjtwONGfXiS/okLDQ==
X-Received: by 2002:a05:6602:7205:b0:864:4b3a:9e3a with SMTP id
 ca18e2360f4ac-866b4859e7amr127837639f.13.1746139356776; 
 Thu, 01 May 2025 15:42:36 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aa95febsm80262173.131.2025.05.01.15.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 15:42:36 -0700 (PDT)
Message-ID: <df476c65-eeac-4c0f-bb9e-4c132bfc8c70@linaro.org>
Date: Fri, 2 May 2025 00:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] hw/s390x/s390-virtio-ccw: Remove the deprecated 2.10
 and 2.11 machine types
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250115073819.15452-1-thuth@redhat.com>
 <20250115073819.15452-6-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250115073819.15452-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2c.google.com
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

On 15/1/25 08:38, Thomas Huth wrote:
> They are older than 6 years, so according to our machine support
> policy, they can be removed now.
> 
> There was not anything special in the 2.10 machine type, so just remove
> it together with the 2.11 machine type. The 2.11 machine type switched
> some configuration that needs additional cleanups in the following
> patches.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 37 -------------------------------------
>   1 file changed, 37 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


