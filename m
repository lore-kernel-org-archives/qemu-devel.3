Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F60FC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 07:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTdVH-0000By-Oa; Sat, 27 Jan 2024 02:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTdVF-0000Bh-VE
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 02:53:25 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTdVE-0004OH-DZ
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 02:53:25 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-59a1a03d09aso219209eaf.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 23:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706342001; x=1706946801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+ZUnE7TqVuww37SKoytFpw6oZRw0KYssOrhOdlqgYKo=;
 b=pfXSQyVpaXDgpLxBNcySV7BaDUjoej67UUK1YhFRzBctX4WAfKhitQGuGjG0Io4QJU
 tcik2/zaluCBRR2FhUL09Vu51/5WZDk0YFvx/lAqNgJyQtgAFitZ9sxsPiAgiNb0SRGO
 NCk016tboxl8OlOqAL6ifqJlCY8A1+tpjMgRRQB1jUVf5aaihvmD6lnT43n4FQntASom
 bKl6fk0HZu9AyRok6jUPNwhhkIavZDHwjAoMVp569UES8ejKByL6w4gcsoXFFzW0lani
 L3w3GysyFASMi6Bg2iutHciAJR+eGnw9xLU1m9UmoSwdVylBPbQMZOG91uuXNEsXIDq/
 p9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706342001; x=1706946801;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ZUnE7TqVuww37SKoytFpw6oZRw0KYssOrhOdlqgYKo=;
 b=vBl5EbtOvUQA2nhK/pAnpVlQ4FvxMw3ER6vxO1K9h+xh1Y0ZKHy8Zv7rwTYfMdkm8D
 jtyzl8YRbS8xIe6Ee0Id1iCPpojXpKVRjabRBMEj7aTI6WNgYHHyWk7Z8rXY9i8t/T/A
 IGA7DigTXpVJFs9UGBXZtaduE7HZZojxDscm6EmupWxW+IuyIrsXX/mS9f9h0oTs5Iw8
 RF/d0CvGZISSi9hyUh6/9FluFWAFH7Xo1tEQUI84JRyBfFW2SQpfwWSVLjPDqRVbqsYt
 Hr6k9b84CogZXjrdoHbsD1/bSdjDJKdNuxF5XivZKO7MwfgiFcnNo9DKYQW/Al6jEsO0
 4K/g==
X-Gm-Message-State: AOJu0Yzdy+Uv9D19mxLy76h94iUBvKjdp8gdXBYMPOBEFITN6T0moqN/
 leXcRxK2KTDVOO/VmFNiiQJrQhos8jso0J4nOMJM/6cScjeRK1T0aTsH9oq/4GQ=
X-Google-Smtp-Source: AGHT+IH8H7pXYWfZKjeafoqZ0aMvC/mCqCAFnPmBEQjHaP7L8zEwdQvMyWRDJT2zQRRPkoRKFMdaZA==
X-Received: by 2002:a05:6358:524b:b0:176:569f:8921 with SMTP id
 c11-20020a056358524b00b00176569f8921mr1163964rwa.56.1706342001557; 
 Fri, 26 Jan 2024 23:53:21 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:f4e4:75ba:818d:188a?
 ([2001:8003:c96c:3c00:f4e4:75ba:818d:188a])
 by smtp.gmail.com with ESMTPSA id
 nm13-20020a17090b19cd00b0029061498a18sm4359076pjb.24.2024.01.26.23.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 23:53:21 -0800 (PST)
Message-ID: <2c2aabef-d4e4-4c1c-a613-3c72d0a1be18@linaro.org>
Date: Sat, 27 Jan 2024 17:53:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/34] exec: [CPUTLB] Move PAGE_* macros to common
 header
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-15-anjo@rev.ng>
 <92ed19b0-b86f-4c5d-9b74-bcf1cdd7f3cf@linaro.org>
In-Reply-To: <92ed19b0-b86f-4c5d-9b74-bcf1cdd7f3cf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

On 1/24/24 09:54, Richard Henderson wrote:
> On 1/20/24 00:40, Anton Johansson wrote:
>> These don't vary across targets and are used in soon-to-be common code
>> (cputlb.c).
>>
>> Signed-off-by: Anton Johansson<anjo@rev.ng>
>> ---
>>   include/exec/cpu-all.h    | 24 ------------------------
>>   include/exec/cpu-common.h | 30 ++++++++++++++++++++++++++++++
>>   2 files changed, 30 insertions(+), 24 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued, thanks.


r~


