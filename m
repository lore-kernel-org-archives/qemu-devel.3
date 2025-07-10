Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B18C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuTn-0007Gv-NP; Thu, 10 Jul 2025 12:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZu9b-0002vn-Bx
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:29:54 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZu9Y-0003pQ-9v
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:29:47 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-234b9dfb842so11827765ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752164977; x=1752769777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wtGwUc5A7pk1NnKmmvyZgHPr3BcQayREo9qXinaIQMo=;
 b=zW61qQTeRJE2WeM0+RPHQnGvoIC4BGiUdLrU7FRfkW2etauP6FKidBpbeHHJZjDd/8
 4toqhdOMTz86JDLqFyCuRJy3PC2LllCv7R6YEvGniLIo3oS5nsTdbq6s+4QqVBjI2aBD
 Vx4RFnsf0NTdZGzcoL9tomQcZc+SXPzpkpIP2kbugCXsU9tuAWTElS8SdRinpA5LJkTw
 rrmqALr44puM/wmFMgCq8OYLhhZoOO0gqlWixYgeXIERkFOEFnzNigHT2sQbIGd4KoED
 2cVbFxNx0G1V2dTT7g+p1fcrMujzZ+mHGcpkUWA4F2Iwh8VHFdihU2sGm27vc3Vde82F
 MnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752164977; x=1752769777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wtGwUc5A7pk1NnKmmvyZgHPr3BcQayREo9qXinaIQMo=;
 b=m2b9Blm3zVhY30fwGbSq58WdU9LiYcTcn84AYtwJveG1LulESJh8A1+Cdf1pGQB8j9
 Y+THdhdYsuMpmeBuk/snFbrbXKO4l+ut14nT+eDvILVrFoe03wwUerR4meuryYEApbo6
 YgAo/yI1vHppS/zxn1XyoQg+cgmwtUJZ84jXyGn4WwmyAq2xrug6yYV6zvKehlv5a+H+
 x+FiL1CwqRx+PFiya0F7NXvTQN56h31mU/NON4mc2ef4PgebKPSEqh/TrjrItYfwCfjw
 Yso3zon0ADip0NdAbSFizgrF0nd+ZIZJ+mmMa+lcyiCivPOAwxoe3gVU6GDyvRKyMb5j
 m38A==
X-Gm-Message-State: AOJu0YzzfGD0lpIYBNtwVjy2P+UFLLplxZRjKHyF7G0RxfaJiy4x/Ige
 oGegSnFcSg92sE2cVQ/6r6kifRCmhaLdk8r/yzFWkx0E/cMlXv3oxY3ZatvcuND5q7Y=
X-Gm-Gg: ASbGnct3jPmHIAYoCoY0s8suC00vuDNTw5bMpOr81I+5N4jPHcVyvd2P5yzC1xvvcGa
 T94SJ+0nqs4EQBos0vQUGVbaA71Q8vrxmz1ljjlD7k0tpZuH88kxjTzL5wQUhZyPJ/WNxVm/r/B
 mdqdpQs1h9elxLnNxklVcdKHtExf+ipkP0eNYU/kBs4WzEkiNCn4S/qO6Z/1XDplhXG5rrk6bbL
 2jrTAe6Nkhd9gQiRHOl9iWDpOO96BRmy7DD2wSjD7u6V8YG+KXcIpYvRJlYX+y1gdNthuY8Atl/
 UxqBsIUfeJmTM5WxYLfNTPUWDpusR21jPsEQOaCqxe5BljvDDGq2UdY8GoSvdhPTGvItGMM0RNx
 MP/C9PsRdhrD/46nalfQADu9AaRs5
X-Google-Smtp-Source: AGHT+IGlyK+49LiXR5cY+/eOLthxkDzQg4eugL8ehFpC1Kp5OySSuyYEP2uHLHY9lrandpH+b0x67A==
X-Received: by 2002:a17:902:da85:b0:23c:8f4c:6658 with SMTP id
 d9443c01a7336-23de48725b3mr47074415ad.25.1752164977544; 
 Thu, 10 Jul 2025 09:29:37 -0700 (PDT)
Received: from [192.168.0.102] (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4367be3sm23559935ad.251.2025.07.10.09.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 09:29:36 -0700 (PDT)
Message-ID: <2ded21e5-8c4c-4ab9-930d-906b31e944a0@linaro.org>
Date: Thu, 10 Jul 2025 13:29:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] target/arm: Advertise FEAT_MEC in cpu max
To: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250709180326.1079826-1-gustavo.romero@linaro.org>
 <20250709180326.1079826-7-gustavo.romero@linaro.org>
 <a15724b9-a0f4-4323-b8c1-3cdf8581ee43@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <a15724b9-a0f4-4323-b8c1-3cdf8581ee43@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62e.google.com
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

Hi Richard!

On 7/9/25 17:54, Richard Henderson wrote:
> On 7/9/25 12:03, Gustavo Romero wrote:
>> At this point, no real memory encryption is supported, but most software
>> stacks that rely on FEAT_MEC to run should work properly.
> 
> s/most //?
> 
> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks a lot for the reviews :)

I'm sending v5 addressing your comments.


Cheers
Gustavo

