Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B6DD277C2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 22:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKpA-0007bD-6Z; Fri, 09 Jan 2026 17:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKp7-0007a6-8v
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:19:13 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKp4-0003Iz-GB
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:19:12 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-29f2676bb21so42136565ad.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 14:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767997149; x=1768601949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NLQeuKrmGXxSnP2cKQbqbHFwg0XZXtphPUWdp/K740Y=;
 b=zJKwbqaYaZiMU9g2JXT9LL0ux0BtmK1MFUD1qIvQibbxn2Fqnbcy2ZCMVw2d0qlANg
 SCGjmp6+iVKFHYDLfiUPPxStubZMJtpTih0BXki3ejAdRcSIIrCVy53U9VggzP/0RnQN
 sn7HI/ebqTY917xlyooM56Matcv0S3sfE7qYNeDOsM7phehIlQmL72KrCHKm+lphorM0
 KFWOyBza3apHPuB8f/zlynZWv59FBYiFL6LpjjxTyxFdZNuWORe1wLxsC4vVqklIW2Dy
 M8C+YGDaMZNGTsTuoX06uJQPrv5abDClsmtmqtpXPran3Kxe6HRA88PzuDmGCef+EtpG
 RRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767997149; x=1768601949;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NLQeuKrmGXxSnP2cKQbqbHFwg0XZXtphPUWdp/K740Y=;
 b=LzRcm4zVFakaqZtgAKPsUq1ApIaKU5fiQTSRex8ehAKDTgQlNXGT0Ixsbk/SfV/6mT
 UXkNXVC8Ejvb3zXYEWI+3iGy2kO/XD0mYmRI6DGneMjLdem0gxJsGOum0koFrJroHhOt
 Uco1QlRXPZCJuJ/VkN5hm5NVcipCYR4+WXNDHqP80SJxFi6cO80I8J+jr9k6vCXa88/g
 14PbbA5ZpSjavxItZM8DNcX6C72fHZ/9leHX6pwxdkzNWapya7OwGzp0HtTU4elHUGH8
 CK5kqVNcXrROoOKZ8qBTCv1hdi/wcUAoBNZSftIRRieSpukRUmtrZvb2KwFzVLtXshCO
 YASQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJQM/sEgN9Ps9cB5kwfKFfnpKkwot2l6jFaDev+KXliDpq2DnVoHum3MNg53L0wz0mkzGjEUsIdZyZ@nongnu.org
X-Gm-Message-State: AOJu0YyQjjDpFuwFzPR5pSWWmBoE53pZozEKtrrHp9fagpOL8m9T0xIf
 vZlyjqzRUSESyXGXINGM8nhshh3yYJH8EYIouVgrrh+9AuFhy/q82m+Z1pJCZRcIKug=
X-Gm-Gg: AY/fxX6s3JTYfzkqWTXYAtB32GQybMLWyreN6tJAUdGxZY4IbZWbw6eRUp+uIcWoWR4
 gw+V8vuKysLhfeqJKFDB1xDWXm/7ubjY29tAKXEgEkEkTGTMl2+u/mnQYcjc2KBTFlyygBDWCIN
 jywk0LwFzTBO9KJ+L+ekJKhDp6vBjF/5RMZUfHw/xW2cQlu88yPGnm8TOfDMIbmzX7CvAvi8+ZQ
 QKiPiPrmuSyzep8cM/JsT5hdwaRXEGWzAHUi0+jqWUCLQFfjMXzEDG9WAj1JgvgKcyRvWEF+qwg
 2FTHzgevWkQxf1/MtXpqE9+vD6dsNuDgCnTeAKD9UxEhMK7Ncw1hFYPgPM0z3hYhgWZ1A8BX0Sp
 nbpjTdvtpzvBzgQpYhrIgcQS9xt1U714kKbkxPQmpa945ofyzCkK7r8FiQiA7aI3kHm8S5v4KEl
 ELweN5n75IoaxkKnq+sO3xgrbexQ==
X-Google-Smtp-Source: AGHT+IEJPvFYjAhMsitKGy+eXqodutyL2vcRTmxXGv4wWmnSPHnNbk+iL5CdzIneLYLg2P2dB/pcjQ==
X-Received: by 2002:a17:902:fc4c:b0:2a0:dd66:d813 with SMTP id
 d9443c01a7336-2a3ee4c1625mr106361415ad.55.1767997148617; 
 Fri, 09 Jan 2026 14:19:08 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc88c2sm113048445ad.79.2026.01.09.14.19.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 14:19:08 -0800 (PST)
Message-ID: <3d3d3fe7-27be-4c28-a6d8-b68322231284@linaro.org>
Date: Sat, 10 Jan 2026 09:19:02 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/29] include/tcg/tcg-op.h: introduce TARGET_ADDRESS_BITS
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
 <a68321f0-3d54-4909-864c-9793cda05b2a@linaro.org>
 <f12d31b4-48e1-4683-be30-31ba469ceb38@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <f12d31b4-48e1-4683-be30-31ba469ceb38@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/10/26 09:11, Pierrick Bouvier wrote:
> Yes, target/arm uses TCGv *only* for addresses, but it's very arm-centric to think about 
> this.
> 
> So what's the benefit to split memory operations instead of parameterize TCGv directly?

Sure, but Arm has a unique set of circumstances.

The benefit is to leave the name "TCGv" to all other targets that don't have a clear 
separation of 32-bit and 64-bit mode.  By arranging for the name to not be defined for 
Arm, we avoid any use of it creeping back in.


r~

