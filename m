Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FC2ECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmWl-00071O-Ed; Mon, 09 Sep 2024 18:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmWW-0006om-In
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:06:18 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmWO-0007jO-9e
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:06:09 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c24ebaa427so9019896a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725919567; x=1726524367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rWt+IHuUM05zkQCTMhK3rrKJGBMKQ1sT8ZxzweW5kdc=;
 b=WrpRyBVExobhbmcHwW9QPqpBQ/b0kbr15UxPJROKfibmiC6jWUPA1bq5H0a3mYQ+MH
 Eo9RWpKiga1yjEwXiHX9AVEBa41gkJLUMyAVR2yAIfy0hwfvryAqkXFKioVujGennROt
 1a/kqrJTkV+cfO/p2SAWZkXB6zW6gTQAFICFXEii2MuDTNmrSEZ8zu7EpMcJ1MQ8myIu
 5stzvz/M1g8qMEugvwcjfNAxkvSbklru9mETWU62F/mhRKDbACteaUnK9M86FRNvtqiW
 t1ZUh0czHS62cci9nF/z4oxReIKLIG6R7Fsxp/ABO64B3Pk0gfApl6oGCEabgjYMWBlg
 h87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725919567; x=1726524367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rWt+IHuUM05zkQCTMhK3rrKJGBMKQ1sT8ZxzweW5kdc=;
 b=LiYGIjAUY1+Ar6O0jQQELDv80x9p4AvwV+OCEt2e5OrL0waOnFZJ230oPILFUU4adz
 fgz+NjjJ/LGrIBwmHBZ8Bp2rbjGJNm6CIRhKNgsGv0GAES5wFyAnwzHy+8+6sZnIx66n
 3otFCGj5b8N8k7MCCsJ2jTvBL3SPYtHRqNTtUBSCFRRStPBRiV4tk3pzppLGRPdQftkc
 c5Mv/nyRiGzMfr6O2r8UVTJJPYVGfOH+EEjkQEyQac9ZiYnFdkQyizw/4HfdnikTYvlg
 EHhRs8c/iwvAaRgA9VFRj/bIs/u34Xn/YFymJq036cRx9R8rVSq4SmGHmcOUHE2RITo6
 RYNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkVCjytX30DwgsJPrew08LFczP4tKNyNyC20+K3EK5VGcsnSSvDoc4O5WqkSn5tVX01N27ubA9YMnK@nongnu.org
X-Gm-Message-State: AOJu0YzwUstXp2y9y12Qwv0cF1KlTuV2DUfDz+smhHQbgKt3ejKBrcbh
 0zrb0euCGw8H/dZbT/QDStIbDWNzZwjk/P75cPCA7zbAsDmaPFnKrkbyFzX+sMs=
X-Google-Smtp-Source: AGHT+IHtz6Myp3j2iob0kb7sCgzNZM0JE/q/ERMncedbEH34utwiiXeG4K3oQk4pktfDjvFn8pUi2g==
X-Received: by 2002:a05:6402:5d2:b0:5c2:7699:92ef with SMTP id
 4fb4d7f45d1cf-5c4015ef7ddmr1334101a12.16.1725919566786; 
 Mon, 09 Sep 2024 15:06:06 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41cd7sm3488059a12.3.2024.09.09.15.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:06:06 -0700 (PDT)
Message-ID: <600d30af-d431-4216-9e85-56571ca829d7@linaro.org>
Date: Tue, 10 Sep 2024 00:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/26] target/m68k: Remove env argument to gen_lea_mode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com
References: <20240909172823.649837-1-richard.henderson@linaro.org>
 <20240909172823.649837-16-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909172823.649837-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

On 9/9/24 19:28, Richard Henderson wrote:
> Use the env pointer in DisasContext.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


