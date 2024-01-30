Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F8CC47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmJ2-0004Ui-67; Tue, 30 Jan 2024 06:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmIw-0004UF-AS
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:29:26 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmIu-0004xH-7Z
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:29:26 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51031ae95a1so3554467e87.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706614161; x=1707218961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NaLR0Fb3JxzqoiyrrHZqBGjfAgh3vX++gbW1pMSK+5Q=;
 b=yvXfk3qMjyjRbZVDr+/u3Zomre6a1cdk3EFIh3u8bU6G2DR7rJ8IG0pcshdHXhSOFO
 8htIa8X6MvkTbZBntXYkbsVdhqC86FWB84/wF8AqiT68ZI8bS7YSQq5v0CxxDzinZ9nl
 Nd9NsNE6nHd00m859VvFADxBvglY88TY6ngY41mIPbr1zmBMQSDqTgco9wnTWYbNam3x
 ULtVmn4FDAzU1NovmQYe8VeXFZlKOUr9mQJtxW2p7rtfY9KLz5Z0S43UtzlQIwmZQqo+
 DtMUR+SHpL0wdGnZLsaUGfV6FulyGcm/XVw3yNklIckx2WBF8XL6q8z7zmKrFNc+frJ2
 inBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706614161; x=1707218961;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NaLR0Fb3JxzqoiyrrHZqBGjfAgh3vX++gbW1pMSK+5Q=;
 b=wNE8QrEg1jdR+/4eE9JxqieNrGNfeScgP03gfnrAvZDOoPXkMs18neFYqmAgrkdf7G
 XuaWWN21/U+bPFPxMTxAn2zx2ymi5HuLMFAhK5uMUrGNHmPABvUkNIuwfJCUOC4tf2YQ
 Buwg028lV6Mlod1vapFf9LDJQuXklCYMGUDiiia0cmZGGMvWc8oDHbudrivPBEC5ElI9
 viBnfVuSNR8afTCa6GtuxJxBNsigvM7bl/R/ZK4F8CXycdnalOo/1/ciFa7K5klqdDcN
 icZ6Jk5tnb3M6b/sSzUXXBIB6Z60A+/wKMgcxoecgMRB8xG1zj13/c5TXY0gDasBOvol
 /R5Q==
X-Gm-Message-State: AOJu0YynzepOjlac03pK2PVDJvM8DaTopoG2do6x+Di6a7HM95DVXEsF
 LXULWJJTCiB/tBd3/5mcPc9yZPln9TB6V5n9fz2r97ib5r+qq4vapuwXz9gYbiU=
X-Google-Smtp-Source: AGHT+IFS0EwYAcwquBPoqkDOn8pLTcq2WjCa2MAHqKePDUkTkO8U+l97GP1AIO4cdNxoaEsJg/IDGA==
X-Received: by 2002:a05:6512:2315:b0:511:e76:b9af with SMTP id
 o21-20020a056512231500b005110e76b9afmr4903904lfu.43.1706614161418; 
 Tue, 30 Jan 2024 03:29:21 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a05600c354300b0040efcec0a6asm2394342wmq.42.2024.01.30.03.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 03:29:21 -0800 (PST)
Message-ID: <3aa27f14-b8eb-4dce-9a02-72c00ca426d8@linaro.org>
Date: Tue, 30 Jan 2024 12:29:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] include/exec: Change cpu_mmu_index argument to
 CPUState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20240129233043.34558-1-richard.henderson@linaro.org>
 <20240129233043.34558-34-richard.henderson@linaro.org>
 <51e69a4f-9003-45b0-9350-24728d952d86@linaro.org>
 <f62596da-6ad8-458a-a917-bef072647630@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f62596da-6ad8-458a-a917-bef072647630@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/1/24 12:05, Richard Henderson wrote:
> On 1/30/24 18:26, Philippe Mathieu-Daudé wrote:
>> What is the rationale here? (I'm trying to generically understand
>> in which case one is better than another).
> 
> Didn't you ask Anton why a generic cpu_* function was using CPUArchState?
> 
> Anyway, I think we've generally used CPUState more often with generic 
> functions, and this should follow.

Yes I concur. I thought maybe you figured another benefit I
didn't noticed yet, that would be useful to document elsewhere.


