Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AD5EE01EB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so8qq-0000jf-TJ; Tue, 10 Sep 2024 17:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so8qp-0000iV-RU
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:56:43 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so8qo-0004vp-DS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:56:43 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-718e6299191so2039263b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 14:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726005401; x=1726610201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yGG+Di4r2nwqQAmeASZOr97I4+5IyAwvbQtq9Nu/YUQ=;
 b=a0vt28t5jJG9dRFcAWsE1Yiqe9WzXhLGNMVbhxQxNdkTjXJ+LVyDVPv2zR19d9qpyM
 GLo1bAensewcQNOdk2Njn79MIrByWDmlT7SjI9B8Gev+TJ5O1Sv/emP8YD3HdoE+aKqa
 wt0eOGsDK/uIsgHuJE4BQBprC723/fEdebamQ46Hz0+VcwXHt2/31vM8k/nlJkJ7+KYa
 HD0oHXG4Ln5+qASpc0KQeVBh3JGlJKzJHCWD9DAY+sn+dkEgD9MMgKRTQ7mMD/w6TMge
 8PvhXqovrusM2++XmpG8AoouLtPsCk4sDSGo2d/7dvKR4qLLpeZT9rHaYcE4oJFmQLz+
 sJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726005401; x=1726610201;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yGG+Di4r2nwqQAmeASZOr97I4+5IyAwvbQtq9Nu/YUQ=;
 b=AZgf2OuEioc3vqOsjpWFd8kDaqAl3bSBKvPLw/r7cMdGgVtq38HJDw3S268wzyFZOx
 ApaysNgBoAbn6kPiEgFBTOng4GEF10M/php7D27MEcmkycECGNeNRYsY4kHvO/0tLccJ
 7NV6Eanv3tUJ3dTdAxOdUpbZy2G1/KFQLsZXN6EcErlHTlf542CiTH69dwMvbj+cxAVn
 m6SCIj4dyvy7RSJ0l8Z4Giuxr39AcqRncLMWo7tYKI5GMsCOhn2OyM4rTnnxvaZ96pUM
 xARS1UgvOXCI2PXk7dftIDcVv9FaqKx0zCYADxVfzE3VmOfounmzsS/4g2gQZnzonftc
 teew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQMzWpZVww8eESAlwvmoZVgCv/5fR6DsViSt+xnENnOdpQf20T/j5ExjDdSk84xxwsSI8JJnOC2D+X@nongnu.org
X-Gm-Message-State: AOJu0Yw0vn3ZKMoI6Ds0dKWVmQbvd8cjM7VHkphPdlCCsTWqBzyUMX3L
 bI+GadPlDbKAeHFjzdYlR2mw4Ha5zsdPQdP09L+xCMbJk76HIxxxHUXoBZisy74=
X-Google-Smtp-Source: AGHT+IEntlGd8ZCcaNBUiP04MyA8paxt9OsvncTTYBn2pCEheeTKUXYAtJn8LmUS+MlM6bYuX23qRQ==
X-Received: by 2002:a05:6a00:399e:b0:718:13bf:9a6e with SMTP id
 d2e1a72fcca58-718d5f1ff51mr16664797b3a.28.1726005400516; 
 Tue, 10 Sep 2024 14:56:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090b0485sm1863708b3a.179.2024.09.10.14.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 14:56:39 -0700 (PDT)
Message-ID: <37f55f01-5260-4261-938a-562d64aa12f9@linaro.org>
Date: Tue, 10 Sep 2024 14:56:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tcg: Propagate new TCGOp to add_as_label_use
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Elisha Hollander <just4now666666@gmail.com>
References: <20240910212351.977753-1-richard.henderson@linaro.org>
 <20240910212351.977753-3-richard.henderson@linaro.org>
 <047bf152-ac20-49e0-90fb-ff9b56511982@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <047bf152-ac20-49e0-90fb-ff9b56511982@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 9/10/24 14:50, Pierrick Bouvier wrote:
> the tcg_last_op() referred to in this case can be another op than the one expected?
> Are there other cases where usage of tcg_last_op could be a problem?
I don't think so.  Aside from plugins, there are (currently) no other uses of emit_before_op.


r~

