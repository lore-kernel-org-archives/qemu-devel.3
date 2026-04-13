Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B85FF531D9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCPsU-00079j-7K; Mon, 13 Apr 2026 18:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPsS-00079W-J0
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:35:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPsQ-0005A4-Mj
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:35:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so34028875e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776119728; x=1776724528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q3ihsIrXxIVyK4BILZFbDVAkQrEikVz7/YrcgSRVoHA=;
 b=men0YLmA3vqfoWzoVA8Shvxr9eU28SVtrlZoOJEHJbwCxFIJJnd1RsK03VP1u5a2ks
 c5nkb4JyEfj3WELCCS95JiKCAJCLTRgmxHcIaHvR8LKb05rodne28XHJJd7wN2rZAw2j
 U6j2ZGzq0h6brrOsbOKmRzd1rFJqLv9z+RgxwWif2H0qUSQ1WrsCMt/PQbH+2fc88Wu1
 opSkw8Xh0f3/vIDs/CWP+jgY4v/e9Xw5zCP+nFL7XAYfi1ZDDRwKpuz1ue8X9kw4Grzn
 tK1sNczvuFucKDc/jVH16yBS9yVsWt3wzrWJDPaKDL9+UxxIF12XRq9/ty2QOnO8MiFU
 tSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776119728; x=1776724528;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q3ihsIrXxIVyK4BILZFbDVAkQrEikVz7/YrcgSRVoHA=;
 b=PoXTMT38JmtC0WuCf0zfPT81N5xOZn2m/sjBMALgVFxPyD16JsLhq2BqxJe8gSV+KX
 GOO6yDtr8ZkV5lIlhlyT03Q4hhbht7PeaIuKlNOymq8tB7V9E7OijErVFHtO2GGP3LCs
 qmHhAo5lP2m03UN8JL5pPncXQtZ2KM3MCMrl3kgTetH8LtfEi/F2sax//TRo78grVByp
 0G/ATWuWrpMe2onqS3VCOR8PPwa8+avqlDUGlNjiGM2SGl+d5d+1rFkBgQe0AOkmpZP6
 RfJ0Z+Qv0FNJe19RR0oeb8mgZnCyEkSj6XzvRGB0GdTL0r83386su8b7pcd+AwuBydIK
 2kKw==
X-Gm-Message-State: AOJu0YwpjNVXHwC2xJQ2D13IyfyI8op69L2PY+Upfpl+kv7Z8HHXMhcM
 CrXM/QC9cvsJA8d9u8Gy115F8ELtA2pk+6T5yO14+6iofhugP/JvFJCNyoMRGXN8UpDnKbi3evy
 We9aiLnI=
X-Gm-Gg: AeBDies4zVgbuj6bHoOZPorvRdcsISzCwS09PUNSYBoO0fX2w1ZsQ07tAvDeTwSZGVf
 bXgjTZnjBPBEZzKEBXI+Z0QVc+DB/AjRT+1ib7kvWb86jsZYr2SIRZYjkb1Oo1TElgwCOwtyMMa
 4OZfclKmPuEY4k2veMY5oSwmhCzbF970qAXTfRRZ/r/qTtvAzVuXpOetloOSFZN2W14yqTv6TrI
 XAQMvkBSadFABWX4krZqb/2zqgfntybl4ezrLhNzDS/7AnnWfC9NUKoYZf4hhl03jimZKi04yX4
 lsUotR3h3PPNGdpyuPYFhzBf6yN4JGaoFj7mJ9k9CtIcAxV8xXiJyZHTKq8ObOa2m2ksW5RaL9S
 tJ+rm0KAyiBUSvm7BiEIYzcRl2D31pcf31TgnjaOsRmvMXFDbORWFTDlnxtDxVwS1yFFqz9K3iA
 iu2RoQjjJN9Cg9TrnBg0CwH+Ejyun5wIWrj+RZIy2zMZYA1FwUjaGOXuBZoYdlzTMYGA==
X-Received: by 2002:a05:600c:a010:b0:488:aa3d:faca with SMTP id
 5b1f17b1804b1-488d68af250mr211607765e9.18.1776119728495; 
 Mon, 13 Apr 2026 15:35:28 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede24eb0sm188315e9.8.2026.04.13.15.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 15:35:27 -0700 (PDT)
Message-ID: <0a3d45b7-6c16-48c4-8e4d-ebc0aff55b7a@linaro.org>
Date: Tue, 14 Apr 2026 00:35:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/loongarch: Forbid to use legacy ldst_phys() API
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Bibo Mao <maobibo@loongson.cn>
References: <20260319104944.66690-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260319104944.66690-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 19/3/26 11:49, Philippe Mathieu-Daudé wrote:
> Replace legacy ldq_le_phys() by address_space_ldq_le()
> then lock the target again further legacy API uses.
> 
> Philippe Mathieu-Daudé (2):
>    target/loongarch: Replace legacy ldq_le_phys() ->
>      address_space_ldq_le()
>    configs/targets: Restrict the legacy ldst_phys() API on LoongArch64

Series queued via single-binary tree, thanks.

