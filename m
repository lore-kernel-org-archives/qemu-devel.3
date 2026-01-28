Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080A3D3F098
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 16:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl8iu-0006AU-K2; Wed, 28 Jan 2026 11:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl8it-00069q-7j
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:48:55 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl8ir-0007pE-Sx
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:48:55 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so60909f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 08:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769618932; x=1770223732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z2XlviFpbv7AwfBuEmQBvm4nMPfXEBxAdawdRVCaPfs=;
 b=Kp0vIgCvZPC2vxmfLzeZXwdRuzqo1ufj1NxPtl8fqPBttOk9szpLK0T+Wnk+ZxfIxJ
 DNWCMmldy3uY8gh8BwFP2RwCWgl8KfsoKm1iMMZxpoplK1H36bblwevNbqaXZeXwl6Ez
 //txwvdl+RA0MBOMZU5jjH6g8EBo0bdB5PclcTIMrbUsdq5Gea8PN3sh5/oIZP22wzwh
 O3txY+0pnwRtwMjFraNUJMmB2aHe8gczydyFHesMFzc9S82OcnYDULBRTlQd5QNsnim6
 WwIafjp/BnGcQbYbETa7SqRLlZ9Hr9rG/j9CC8nz2TXBdzQCue5UuABM8ZaMlF4prwY0
 qRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769618932; x=1770223732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z2XlviFpbv7AwfBuEmQBvm4nMPfXEBxAdawdRVCaPfs=;
 b=cqC7sXKRI35r7R+dtMxnKNVjAXHuOERlbhzRhlQ70WRrhqhd0075wA2/NNwZial0Oo
 /Fv2PhYVduOdZ5q3OD3BFlZhELbAJYIOcQnP3e84JU6ZJ2T/AV/pHsUbjbOjm+Ji0i6X
 5LnWBlWEIcK2mrOq10iDp/H/2EP3WscgSyy1qkKRbHpUPW6B4awmui0xczI0OGX3tIw4
 gccGMq2VE9n4bnMAmpA3qGjOx3xn237D2y+JfUfCaCIeT+d/aD/sK8gKCrK0DBg+2BAT
 hOh8r7gAmytzF23ZkZo/Pc5VX8T9Q699hjlFVTQkKIcew9Iai8+tat/hc1EhpljpZ7AI
 L5OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTFjmxi32OVXktYP33+4R3p/ZgTdbQK6dq3KmlyDvY7O8jubZ2ybhF0sPvSkQjYhBJ7M9ThnoPNVLy@nongnu.org
X-Gm-Message-State: AOJu0Yzq8U3K4xFxcieJwg1QRaAOCByxMq26K6p5ZrTXdrPGHQja8yWI
 7K8hIeaOBvZZGvxH+feHTEt7tnWv4Uhrh3bC71IaTSBR7CXi6hrdDwGtJumMKNy4fYE=
X-Gm-Gg: AZuq6aKcsaSaj7Fz6t+deR4Q9+0m/xF3sJlx28fmeBXiO8ODTGYTqm21j4/MqbN+p9E
 eNMZyuyQG6sceoaQuOg9AtEKytWc0ofzR7f4KBlYIDrRsNRmrPvpKjMtFDBgVXUyIZxe42Pe6GI
 MdqlSsg+AH6YmvbEk+FW0/mT8lYgQYL1J+mDX5HXa9M+e8Mn9ALQhLmleA60sUD/2v0jfJb28S2
 QY8Bqj0ZoKJgBtE7SI4SZy9AVaygdFPx3HIiNfc0iuGtZD40Nbztbbz0m8qywhH/MUE7QyOuv02
 IWVdBCSpxBJHqlYNf7TuGzkCRLDBbgfKZgoPAk4jvgAxZPDmvRrp/RIsINPAxV2dQ3Sv4nh/DPK
 nSr9nlO0XpA9ms7BgMIsALg2yL5bI/gGaQG+FpXjHVY+PUgLYxmHkEJyafhqMhhXz7g5Sg9YmAB
 ua19vdveqfH0b47NihHt1OfKF00zZpjGtvY35PkR3j8wKxUhk8P2Qs2g==
X-Received: by 2002:adf:f205:0:b0:435:e448:2ce5 with SMTP id
 ffacd0b85a97d-435e4482d3bmr2876875f8f.48.1769618932138; 
 Wed, 28 Jan 2026 08:48:52 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1322eefsm8045049f8f.30.2026.01.28.08.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 08:48:51 -0800 (PST)
Message-ID: <5374847b-dd0f-454f-aa1c-c386b62960d2@linaro.org>
Date: Wed, 28 Jan 2026 17:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] accel/tcg: Send the CPUTLBEntryFull struct into
 io_prepare()
Content-Language: en-US
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>
References: <20260128152348.2095427-1-jim.shu@sifive.com>
 <20260128152348.2095427-2-jim.shu@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260128152348.2095427-2-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 28/1/26 16:23, Jim Shu wrote:
> To let io_prepare() function use the multiple members in
> CPUTLBEntryFull struct, send the full struct instead of 'xlat_section'
> member as the argument.
> 
> It is the preliminary patch of next commit.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   accel/tcg/cputlb.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Mark Burton <mburton@qti.qualcomm.com>

