Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A69CA5FED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF5Uj-0005gZ-4z; Fri, 09 Oct 2026 03:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF5Ua-0005fz-7s
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 03:58:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF5UY-0002oI-Ju
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 03:58:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso27035405e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791532689; x=1792137489; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SdjidOj5YtoS1qYPtD/Plt2aIcSLpWV2LDHEhRRFs4A=;
 b=L+CsB2y51Il6tOReGqUtbqDdNTusyRFrpo/qT9EJcvHOoUYm+NcGsLgHifayxSTZp4
 NfNtiVgcarwclgVmOLHtYSexFNrqM9jxJTLG5wjoAeogfGcuftIcfsxHa6nyK881gFKw
 d8HfNxcth3MXrvwq/CM+rV43jgn6bSk9dGpMOGHZdIu8fEzi+RZPGQ4rJF1De6cfbrQ5
 9Cx+UaFRTOQ/EypQpWGKNniyP1G/PiOQJCP3J2eYwiR7AZk/QAJIDpgtAAnEkm4p2SZ5
 5SHNepBjW2oms7oWd6CfxfVm6JtVoExbzabhJtpLTAXL6FNfJevfpWlT8TYJpiA8Stkm
 nO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791532689; x=1792137489;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SdjidOj5YtoS1qYPtD/Plt2aIcSLpWV2LDHEhRRFs4A=;
 b=YmsQnx0XxvJpFHizdnJ4AbcsjBmxRVLSG3GYR5hREz4vJvu+KxY94M07o4nCbokMOS
 Vz4IsgqTKKJMJg40F4PVVst2JU80D/YxdwZVBxFVHPXWGTJU5kZr3879LQKqtixihCmA
 a+dAS9wuuhf9bD0bZBPeJVWqjxUqmRVd3ReqEgytiXy6zT7/NT6xApe4gSuR/O0FSVki
 XKgw1hhQW0DdApUa7vCkg4QQ6Zk8vBdwum8vERBtMMrTkDjHZOosKWBhFK4d2WIscIqp
 gzj1N+w6Dc0nz5jSjGDk/+dLH4jmEEhIBmGnnfOqU/XH7twKfWtr6gbmZpJljIQQDNvM
 w56w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0HB7J3Mjqn/Sh1QKIvzbKHtTwNSf4Y1UsA9wvajX0a9gMxEhaP3pPn/CFadQDPGzZmaUuz9id7pJB@nongnu.org
X-Gm-Message-State: AFuF++m/rB3rt4ByzgVpWkN1dMvV4NAJT3g2TiyLpo3azC65I+3SGQh2
 wYKuEM2T6hM7QoReKZ29ofBEjiqVsPpGlLXI66OYqi83gjlgNtxQCkrEYPJj/VuO/hM=
X-Gm-Gg: AYBFou2XvR1VRFVLBH4O+pbugyhOg+jUQfHzG3ndb92QiOUkiswUiM1NGIrKfmfKPJ/
 1K6/sYJKGovylk7aF4eJJAk1acvs4FzHVCXypNzUj86KORxNnHDO9oUJ3sEN7SbdUsBi1pa04j4
 tETJa7QZvxhefuhPUP1BmaQwyLj3QeCupHKg3nfa5fch2tuvKBHkYTquyeWi9m7XOtdMPrA5Bfb
 QBgEJuYjzfUDfSwLvJcfNYOxiyBX7zVGB5lkl/NGqYsfDdBkk+EIq7eJMqx+LE4bS9wIxK62yV8
 LPJwztJOeakhpEJ1cPd45RzfgnySmShVrLdIM7Fyes6yN7Th/K9pRR5hLDGGBwzbLiQ3aZGdAmG
 onPhiTwJl7rw0+IotPlM7rcvXWM2xa5lmV7DRjakhscuYzGraMEEEnYq4IlnaHFqaXr9ztqjyJz
 8gQWw2iNMk7VYW0bZqDVrS/plH8tXUqUOs4bKrSKjOH2VcMh+pfhLPX8pAPQlU9kNKIcO2McCny
 iGNsguxf+6d4JHAe+85QzgcvyPrk7rss4PQJVv1OTHpp8cldRl4D24wtSwUgCxoQBf9D3xTLVmr
 LA==
X-Received: by 2002:a05:600c:3f06:b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-4a18e4a3bfbmr19812985e9.8.1791532689097; 
 Fri, 09 Oct 2026 00:58:09 -0700 (PDT)
Received: from [10.86.151.227]
 (ipservice-092-208-245-012.092.208.pools.vodafone-ip.de. [92.208.245.12])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e33d2sm2957397f8f.9.2026.10.09.00.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 00:58:08 -0700 (PDT)
Message-ID: <095c1590-5ba3-474a-abc1-9718b46cfbdc@linaro.org>
Date: Fri, 9 Oct 2026 09:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Build fix 20261008
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261009005017.61989-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261009005017.61989-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 10/9/26 02:50, Pierrick Bouvier wrote:
> The following changes since commit f9587d4045c67cd0d8d8bdcd5d0bb5b6b395b63c:
> 
>    Merge tag 'pbouvier/pr/plugins-20261005' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-10-06 11:26:40 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/build_tests-20261009
> 
> for you to fetch changes up to 39dc3b12f6ec1aef0ed2df761735c1fddfa7c779:
> 
>    gitlab-ci: enable slirp in the Windows cross-build (2026-10-08 20:58:30 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH 0/2] tests/qtest: fix and gaurd PXE test build on MinGW (Yonggang Luo<luoyonggang@gmail.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261008184119.142-1- 
> luoyonggang@gmail.com

Applied, thanks.

r~

