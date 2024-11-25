Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73E3D58066
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 11:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFXGB-0004TN-2Y; Mon, 25 Nov 2024 06:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFXG9-0004TE-Pg
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:28:05 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFXG8-0002uG-09
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:28:05 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-382423e1f7aso3049927f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 03:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732534082; x=1733138882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nFn8h8/MPaKv5Q7lSmoJtjp0AZdop9bx/hPQQqXkybE=;
 b=IOezIMlTC8QEdnC97zgoxCW/TZ2kXVgPL3KJJrl3Sw9oJOMSl6y8K5PyGVzt8kkahQ
 4QwOIPERnd+d7N3ASsRkm4AXYPsmPAnmhUJDy5sLisgzeuxhwelMKVer+iigrp+yLVFv
 cJA7bGm6s1hb3TXUE4S5jqVIJAwnKZylu/wasAcUEH1UjGNa7h3JxoacbNqOG/vJ1Jsp
 958W/yxRzZVfXf9Pbj01+L/C3fj6PbC1RyDBfPqzMtEe4mtRo4O95AjWZ2PIspr+aeIR
 nkK3YiK4ytnsDiVjr6YO/coGlgLrp3LdrU9pzVgIdudFctRrZ3EZ+IhAjhXujX8zJQwA
 tVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732534082; x=1733138882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nFn8h8/MPaKv5Q7lSmoJtjp0AZdop9bx/hPQQqXkybE=;
 b=lBva4p3RTfnlPUjx3LDFkz93tjgOvlvNhY/QrQYF4r5bWp7yAP4NGCxX3leOUppmVx
 0NRgYvw9wcRigTIUYhEo8ssrK2n52YuKnLsZ109zRpeL5PXB6jYH1DDyYjdDaNq0rdyi
 stCBz9CeoZDXrNgo7M61dYiyOHp1JjdKYfrVMxIazyNuukidph82Bo7Qeshz4lBEICAU
 1HH9sq+Om1qxDiIHSZdHZsejPRg3aq84tZhwluovbB7GbZMGS2eUZ7AlCTKntBcwGVaN
 kBQaaaOYcanQu2dnIQLJupb0NL/iitvRSP6ohA/Cd+Pm3XC/FKLvxR5diNRfqZRRcp10
 IrbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuJ6fw4+u5RUf++Gs9uD08GzEuvYlZ+gmNM3kKgYhrQ+2oUfoIkCOD9hRmAlfe1QzcRFwOphUK+Kmy@nongnu.org
X-Gm-Message-State: AOJu0Yxp2L00bUw6yEbe91UweC0u7fTt1gMqnbq2kcSgp5+4k0B4K4Kt
 NqZ/HWsmAe4DCGA4NjojDZZzfKodJMQ0zeZ6Lh4L2UOVBd3IZ7gynNuM/VhdQ3AmKAQQIoaSOGt
 S
X-Gm-Gg: ASbGncv4rRl4sLqu1SQZ5fngLv+wVVKCE5Yhgd4UwAPzHnbSCJjh2B4ZvTXyo/s8q+I
 0RVD95mI1ZeaPH+/ctcb872NQtlJ3ay7uZnzPWfP9sqR1LazZA57PSbfyTr/a6tuuNODlOdfxSi
 b4aKO6WOzbCjsIuoK2+RkhWPP1TDaWFO7IJjh/nCrCQf03itssVklabWjHQg5I36ZfgnpgUWaYK
 3tkDgPJhXNQMdFpgteVlMrmDYi/l0mSsQre/9+P9IHd/LqMDXOJ9oO+2EJrMc/S6Q==
X-Google-Smtp-Source: AGHT+IGr8kFgoGYzU+Rp5/7KvynI9Pl5SoJFsLJpsrvVKF6r4XJA56/JhUGzcjPiw4K+1em3SvWLKw==
X-Received: by 2002:a5d:588e:0:b0:382:383e:84e2 with SMTP id
 ffacd0b85a97d-38260bc93acmr12228364f8f.46.1732534081929; 
 Mon, 25 Nov 2024 03:28:01 -0800 (PST)
Received: from [192.168.69.146] ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb537dfsm10082174f8f.63.2024.11.25.03.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 03:28:01 -0800 (PST)
Message-ID: <97cd2bab-d2e2-4998-81ed-2a359f4019b4@linaro.org>
Date: Mon, 25 Nov 2024 12:27:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 08/43] include/helper-to-tcg: Introduce annotate.h
To: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-9-anjo@rev.ng>
 <0cc41877-c1fe-42ba-9a5f-b84563f25ba0@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0cc41877-c1fe-42ba-9a5f-b84563f25ba0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 22/11/24 19:12, Richard Henderson wrote:
> On 11/20/24 19:49, Anton Johansson wrote:
>> Wrap __attribute__((annotate(str))) in a macro for convenient
>> function annotations.  Will be used in future commits to tag functions
>> for translation by helper-to-tcg, and to specify which helper function
>> arguments correspond to immediate or vector values.
>>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>   include/helper-to-tcg/annotate.h | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>   create mode 100644 include/helper-to-tcg/annotate.h
> 
> Is this really specific to helper-to-tcg, or might it be used for 
> something else in the future?  In other words, does it belong in 
> include/qemu/compiler.h?

We already have there QEMU_ANNOTATE() since end of 2022
(use in commit cbdbc47cee, QEMU macro in d79b9202e4).

