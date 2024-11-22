Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8C0E69185
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 18:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEYMS-0003Vg-Uz; Fri, 22 Nov 2024 13:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEYMQ-0003VW-He
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:26:30 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEYMP-0004CA-1C
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:26:30 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2689e7a941fso1593861fac.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 10:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732299987; x=1732904787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=udOmIoOxEq3+nZ8ls4Aq4/Tb6hRso8lnghPyA6EyHhc=;
 b=IdIyVM3gb9cYpPncfrhVKW7ifFhPmNB1Y33lO0NXM4C/yuU7+S/X5nhq0C5KoqNmNH
 13uzNtmVbddI4fD50i9MEqvhTu3gPp29NdymtejrzQXcSAID0KEeX5P5FmJB1EcLwPyK
 bPNIZV8JhwrH27RDGpLqXpwbkLYLESNxDQFojoMJME9FV6CKAfSy/k35wjN7MZGT1p7L
 MgGXJLSsuY3eNVqSPTQQjsLFgRQU6Mo5zrJgi8bcDnvlPAP4aYYCCURJwrRYe78GmT6I
 3n824i2fyVRsQQ8Sti1B/2qZNyIovUDL9jyINgHLCc4QHt+fHany/Rnr+/0eIjUmObSW
 bxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732299987; x=1732904787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=udOmIoOxEq3+nZ8ls4Aq4/Tb6hRso8lnghPyA6EyHhc=;
 b=r7+bUuax9iDvCmlOJdi4fnmhTc2cqK4/jQKXJYEPJAJNjdxFEKBSx/xMqRcN4cLSxC
 xs7KluyIIu70mDx3kFbNPSgGxju1ksGqqbsMF5W776sgHLGGn/1IcUix1ofc6qoqk4kT
 ihsOWgyNvILjdTfK8E2PEuFTERvxHInK0084oAjpJ73MTjCwF5m/CYHe662E0tWxb/UC
 YW+wpHQWW+HBse7ObXJ8DrzzkQmWDMochZfZstxlKkkGWB7Njz46qv3ad7kyifa1rJl2
 fPTjMHJvA8bZgrcSvUUYq5llAmYNAVzZdsiwN/Z7n/b8xkEwPoXojJEqV0cEL3V4b9Uo
 8u1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM6x0fFufPQMsEyssRUnVwiBOki9xap+2iUp43ePJCl/sw4VdYHnG9JeJ6HNIpkGvz1BNII0nxF6yq@nongnu.org
X-Gm-Message-State: AOJu0YxvWlTa5vFUJ2Nvz+Uk90+erEa6tlaC+B6ELREtjHKfsTLIC3ie
 chWhObuH9NokHRehVfLA6EKfCPJnZBRWuC4PNS/p4krFnIoA2Z8UL+XqAdDezAM=
X-Gm-Gg: ASbGncsXxYrrdt0cLLDQRDFGE8oENyCgGy34ATC57UY4w9LyR7UzPsTq9zQocWoYMkf
 Rv8kDqXZrFLL4EWKjTbJSt+mPhaKUC47psnAMhoMAZC+Q7Wsk3tpfEMua3W2e3/m6GVTs+Fv1rC
 1zWMHgUzTJQdJfV68RbDWrxddzBfyj8Evrf/cYRmg0eNJIr6O5CwpK06kpi2RJBcHl3jvBM6UE8
 kDscCd2y7OSgUqmMttIvvo6RFpYgZ5UqT8943Aht+a7yeDqMomy3O4O4kC8d6qM1P8YpXg=
X-Google-Smtp-Source: AGHT+IHduu8fUQ1e68ODxCPy1Ixf1vQZnHQ0mCE4Fdi6Bv829hK5PUMd9RRxK58fRyqEwICno1SNbQ==
X-Received: by 2002:a05:6871:3a09:b0:288:accd:fa48 with SMTP id
 586e51a60fabf-29720ad028dmr3837223fac.4.1732299987400; 
 Fri, 22 Nov 2024 10:26:27 -0800 (PST)
Received: from [192.168.170.227] ([187.210.107.181])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f06984a458sm492251eaf.33.2024.11.22.10.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 10:26:26 -0800 (PST)
Message-ID: <974f626c-4f51-481e-8e7c-93e8624b1424@linaro.org>
Date: Fri, 22 Nov 2024 12:26:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 28/43] helper-to-tcg: Introduce TcgType.h
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-29-anjo@rev.ng>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121014947.18666-29-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

On 11/20/24 19:49, Anton Johansson via wrote:
> Adds a struct representing everything a LLVM value might map to in TCG,
> this includes:
> 
>    * TCGv (IrValue);
>    * TCGv_ptr (IrPtr);
>    * TCGv_env (IrEnv);
>    * TCGLabel (IrLabel);
>    * tcg_constant_*() (IrConst);
>    * 123123ull (IrImmediate);
>    * intptr_t gvec_vector (IrPtrToOffset).

Why would you map TCGv (the TARGET_LONG_BITS alias) rather than the base TCGv_i32 and 
TCGv_i64 types?  This seems like it would be more natural within LLVM, and take advantage 
of whatever optimization that you're allowing LLVM to do.


r~


