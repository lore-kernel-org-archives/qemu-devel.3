Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0003AE77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKPma-0004jo-VN; Sun, 08 Dec 2024 17:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKPmX-0004jQ-ID
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:29:41 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKPmW-00046I-6c
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:29:41 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3eb45e42eb4so307108b6e.0
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733696978; x=1734301778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tWKJBfQl5Jkt+016bm8FB9YI35nTPAebAA86be0yyfI=;
 b=iOLQOxnchjxvRRYVbJ4t30Q1pBicJosduelqz8yy0R+RLfGiq60gPbBrfEQT9CyPxT
 INgh1V8r4b8wBbllXDcdl7TmblUhepBwlFizjzQGuYTP/PvZDLb7goaQyZEMWm+1XYtq
 bM46nsVrp+q5Y0yC25OjMRvTUoEYJsR+/+Ie7Zz677dvz/RXTqx61fvptGQv1waGsXew
 n2wXYxAQ19PcJl39GpDwcZwidbliFceUT5PTfuqc/kR3VrYB6qs4tNYdQAEvSfeyOkOB
 Jmh5yadDZ5c1ce10iGFq16BYPMjYQcmNyPTTMZNhL2et/6LzFNeuz2yI6iwARYrarbge
 e3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733696978; x=1734301778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tWKJBfQl5Jkt+016bm8FB9YI35nTPAebAA86be0yyfI=;
 b=I4GvC9X1ZOrBMsLVjj9dKlXtHT/Vglgt9GI9Md2yp6VyH2K0O7PzBLbJLbPmCOBDzx
 OEL4rqop0JdsW0g1TGwZ15K+bD8XD2uPwXiy9zy0hQqTLS8IaM74rL2SVn6QpsKB3n68
 5xZoyGLFa9fN9XFEGqNN1182rYu+8VVEsz9vf5KL+pdaQw20ml9e8mA/wYtKDxlN1JAz
 D+DPynKbXVVa48urqoasR2NNccP1xvWPrth09q2FKpLVaCyjd2vDVCEfVN3oi97MrbnI
 nr1D9lI6kkUiHXMWxkWRW3M0yFMfvqG2hxZJIt82e0S98MDSSKeZsQUi2TrR95PXap6j
 qDpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxhJgV/ODCUs5YzMfcshc596MapWJGv+MP/+sWKMQ7Dp4iZqznG6dyIqHYObJ2tyw+6EBoNZy8t2B/@nongnu.org
X-Gm-Message-State: AOJu0YxkdsxqFfhcA8uQmcSOLzXoGgTvNHBHxnUY+Hae55UaAM3iTPx6
 JwWuH4B6P1cB6wksXV8knfRnUCPFfTc7ugG4iz/tqL4su0WlO//DG7l0wPOFn6Q=
X-Gm-Gg: ASbGnct22SXvC4gRfXwTppTh1pX6ZDm6e3jzkjNp9DO9iKl0jzK/hgKB1gg4D1Cvnpk
 kM+2zgeo0h+zjUUENKU5oa+LWUFlJrFiH8ev8rK2tQQjcB9qk8xJaAQpipZ5x9XQdWyurZrNIOR
 1t6XsR2x/TVPkgPhVqQypX8RYyJlmma3AUHfT49kPutf1hVfJuefuvcfdRvIKrnMFUh9/e0NmFK
 SW3rKS4j4j02VGAvF6HcvBSd7HIL0/fgGeSvNWeNBoRykWUuJBsr7WgF6U2wSV0DvME4WVL8XZ+
 o+yxni2Cqk317CdkD2yyHgTGZe0n
X-Google-Smtp-Source: AGHT+IFlxQWj2FaiLozBu+T2ssnxzO/wrfOWujXJtIttYmkBXmvm/fw0HfzSQhnA2/hAOdCDkIKkrQ==
X-Received: by 2002:a05:6808:250e:b0:3ea:f791:3caf with SMTP id
 5614622812f47-3eb19c79a38mr9442858b6e.17.1733696978186; 
 Sun, 08 Dec 2024 14:29:38 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb5c26bb60sm32205b6e.44.2024.12.08.14.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Dec 2024 14:29:37 -0800 (PST)
Message-ID: <62c357ce-b988-4b81-8d3a-f4067bd92fdc@linaro.org>
Date: Sun, 8 Dec 2024 16:29:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Reset free_temps before tcg_optimize
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 wannacu <wannacu2049@gmail.com>
References: <20241207214700.211066-1-richard.henderson@linaro.org>
 <73f7357a-fe49-4cbd-8492-cb4ac7ed312a@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <73f7357a-fe49-4cbd-8492-cb4ac7ed312a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 12/8/24 12:01, Philippe Mathieu-Daudé wrote:
> On 7/12/24 22:47, Richard Henderson wrote:
>> When allocating new temps during tcg_optmize, do not re-use
>> any EBB temps that were used within the TB.  We do not have
>> any idea what span of the TB in which the temp was live.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: fb04ab7ddd8 ("tcg/optimize: Lower TCG_COND_TST{EQ,NE} if unsupported")
> 
> Hmm, the problem is due to arg_new_temp()?

Yes.

> Maybe add as tcg_temp_[ebb]_[reset|flush]() helper so we can reuse,
> like in tcg_func_start() and plugin_gen_inject()?

Ah, right.  I had a memory of solving this same problem once, but couldn't remember where, 
or if it was on a branch somewhere.  Good idea.


r~

