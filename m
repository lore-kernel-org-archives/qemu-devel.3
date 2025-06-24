Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C61C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 04:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTvVZ-00012B-4t; Tue, 24 Jun 2025 00:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTvVX-00011U-7k
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 00:43:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTvVV-0004de-IH
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 00:43:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so46093385e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 21:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750740218; x=1751345018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nrcFPI3Gaf1T9h/k2Nr8XQ2k/keLOJSConrIMRjkxx0=;
 b=AGv3Qb9m7Ji9v3qkcvzVl8jvFqVsaTvljHuLQQ836F40uUFTgSocnDtNvjATIk18DE
 rV6h3MBOEVRiNVeC1fNlfUn4gFR7IqZWuw7d3UrGDS1HymLi1kq2ddTVFuWlibZnv3AX
 aIuCPFpUdEzqRFWKyCTQxugvAtEC2+ub2iJNMUD2mVt5P4BdgOzq+Ddgc3aYO/fKszyE
 5Mmgd6VeXemrPnElMk6mDRCI/z+SSS1LwfWyVrPryUA4Dtm+3ayPSv7Imv0He/YpLSZL
 01iwHZl0mMLkT3RHGT01J4Rv7B2+wg/OGEt4aicBgD8ZCk3bjRHP1QbW4LqdNPNNj2dB
 5+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750740218; x=1751345018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nrcFPI3Gaf1T9h/k2Nr8XQ2k/keLOJSConrIMRjkxx0=;
 b=lMetG355wq2CIItWOQXEipQn36bl17AurXbLSQtVcjF8zJKPRylGkpyQBfuh33annq
 2f5qjJGY/t8iIfKt30QLrokgKYeCmUem/fRpfpktYkT/GJxgiNZWSYJEJKe8FFWBPX8d
 D7Z4CoJ/Tvw2DVVV9JIQqP1ByLsUbRqyAbw2CJrRn2KzUwni05dHXDxgBxztqISDTuDF
 /Nd6ZM1JcWKi3BLVu82SQnZQ0RP3IkXIONLf9QiecqMWKjWZdRzMhyhRwRw6dXIarFOo
 XKa8SBia0MPavYDOUTZ7O6GWi7+91812hAQKbVZYzOPnRZYwFMijkyAc1X8R0GcOxntu
 r1KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCxIozP2tABDwyu8cfguCF7p2QZZVaZYLUA8ktUSfGpvsZsWx8BAqfJTNKUxiC+mvSL0AdnPaT1g+u@nongnu.org
X-Gm-Message-State: AOJu0YyOowa+4BsGEZFT7/yTzfyqfvzLblOcbmXneL1BcdOFgYz7LRV/
 vor2v+Mlu5eMr4cmco1RbM+sSDk9R7dy0mQfCFz7/38YsaaZEwwzq4Qgu4amT3EG6vc=
X-Gm-Gg: ASbGnctv72nKSsM3AjVNOdCP5eyUA5kq7fJO31SbKHFEqF+XqR0LFQOosNydyuedCSA
 paIudeZf+loH4XH0rCIDXWLNZs4NQ93KmI1GBa5YMj2j60qSA9TMdlhOjweQ5RZYjNV61JQdI4l
 IqMTWy033FzAGvLS4r6/DzABzeFCGmjKPThRPeL9tW1DXjCxD0rNq29rvG8N3dcSs1uw5gb7oWE
 6BVVnGoBBtXf7hXvtxwMoDQclJCM8Quyo4IpEocUfMHUkdtWMfwoPlg9fnEazWeLYNzAqxyMVd9
 f+5DKcwf+LZLtFcxhRkUtSWfISVm7QsBD5B83k4l46uVO9/4t02UfjCiQy33Z3HL9lsS0ZDFt1+
 UAO6cOBVwGgdLopmaOItQSpYc0C4Y6A==
X-Google-Smtp-Source: AGHT+IEBvHJRj/n3rM64ahxsZg+FF2BaXZBL4pEnVTH1wWeDd9McRs4wu+JaTvzYjGehAorDic7xVA==
X-Received: by 2002:a05:600c:3115:b0:453:9bf:6f7c with SMTP id
 5b1f17b1804b1-453657be1bemr153939925e9.9.1750740217648; 
 Mon, 23 Jun 2025 21:43:37 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646d14ddsm126976175e9.10.2025.06.23.21.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 21:43:36 -0700 (PDT)
Message-ID: <63af6d5b-79d7-42a4-9d74-ed533c383a3d@linaro.org>
Date: Tue, 24 Jun 2025 06:43:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] Memory/SDHCI/ParallelFlash patches for v7.2.0-rc0
To: Salvatore Bonaccorso <carnil@debian.org>,
 T K Sourabh <sourabhtk37@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>,
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20221108183352.9466-1-philmd@linaro.org>
 <CAJSP0QVdQ=wTtgNVDChzu5U1ww3SZAa2HfXjuE4z5uOnFeT_bw@mail.gmail.com>
 <CAJSP0QVZ8D59AM_tvgHzdhqF6EUefUgmyD9WMtfPUD=nn54v+g@mail.gmail.com>
 <898348ed-a9bf-5e4a-d389-b60a456ccaba@linaro.org>
 <ZYSr456CZ0p_X9wv@eldamar.lan>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZYSr456CZ0p_X9wv@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 21/12/23 22:19, Salvatore Bonaccorso wrote:
> Hi Philippe,
> 
> On Wed, Nov 09, 2022 at 08:43:19AM +0100, Philippe Mathieu-Daudé wrote:
>> On 8/11/22 21:57, Stefan Hajnoczi wrote:
>>> I've dropped the SDHCI CVE fix due to the CI failure.
>>>
>>> The rest of the commits are still in the staging tree and I plan to
>>> include them in v7.2.0-rc0.
>>
>> Thank you Stefan, sorry for not catching that failure sooner.
> 
> I was looking through some older CVE's for qemu which are tracked
> still unfixed in Debian and noticed CVE-2022-3872 . Do you happen to
> know if the fix for CVE-2022-3872, the dropped one above, was ever
> fixed in another way? Or did that felt trough the cracks?

Doh... You are right, this totally slipped off my radar :/

