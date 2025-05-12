Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD134C3ABD7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 22:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEbl9-000129-I9; Mon, 12 May 2025 18:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEbl7-00011m-Ry
 for qemu-devel@nongnu.org; Mon, 12 May 2025 18:36:29 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEbl5-00082S-RD
 for qemu-devel@nongnu.org; Mon, 12 May 2025 18:36:29 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30820167b47so4184154a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747089386; x=1747694186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U3cGlnGiqaFNQbqNMkxxj2ffYOhDCbch++YLyNsjY2s=;
 b=PhEhSH79wxLF9RXHiaQFFV/qnHG8ol1ONH2iFBAoxeuGs0INd1tOgIpk2wqApnyGA/
 9c3Jy4KQw2XnT9Ss2iaTXru1OVePque+Fwfp/sny+qj1zLtdgxglZUWUPssIQ5+4nodH
 M9Z83JFbTL6S4QxFXxGARuY4TRCJUTyae7wKtGKs66COvlqYtqnjrPBrNc2ytKl40WfL
 bIho0r8wjJQ22bvQHFqACh7dnEM8QUt/CHUcl03poWIW7kE0oazLbBF5Ha6EhB3jv4rV
 NklZJKtsu+JV3KdyHYxJxX7GQZEqHidd5SIXI/RwI3e8ti77EHHmsQynD5+t2ifLPAG/
 Yf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747089386; x=1747694186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U3cGlnGiqaFNQbqNMkxxj2ffYOhDCbch++YLyNsjY2s=;
 b=YHcxhtCc7xH65Q1FT4SoVcGtlgs6zKE56c6V7POIhd2Gk3K+xd8gV+b8baLQTotPP6
 jGlXgytwEk5tmAU2SDQGoU7AS9fcU/oF89XvLH55dUiuLoEukPlOkIE5ROP+5RXslyhn
 ZhODkIZyYKFlBeZFgCExA2+2qfBqDTFznmGoglZTC6tbM4OaIVkngSvzeHtco/Nnwy1i
 PGaDR5vowcDW4u747E+sio3u7C+0/EZ6WVLjy4CfPCfedVP4P5vj+eKJAn1ZFXc4WXxy
 MculIz87CqmReSr5ZGh2nXb+WNV9L98ez8KK1F2B6yloTFJoa9vjU159Q11RV7s1ticR
 PyLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpPdTLmXjqncA/LwXJFdw057bkxkTe0VtR3l3tj89NL6QJVtzw3qvD2HOw7Pvmhp/0IbwlHlqlBPN8@nongnu.org
X-Gm-Message-State: AOJu0Yy1eEFaxv7n4Xau1hzL4/y/3FNLBpG3Oe1u5DlDoLZ8o2ODnqUJ
 iRJaqJ49Ou6m90338o0uSzj0AA8ngmpQG9rvBN+z+9gwKeGtIjeN2vQpmx5ze4s=
X-Gm-Gg: ASbGncvYbOUU9o3WfWoxyrAqFpcqSsJ1S20MEBtQiau72E87qX0Ur6apGRAaC2VMaV4
 R/Uq+dxD/j9rGc3y2fA5wQWALzNBRjfCblt5GyuDvnHIRHjSUu0I9h/MeHwWtRoWPC0BLzuT9Ek
 vCRldqInnA3geZu+sIaWNGrXnZYeaB7/RxHc4Ve3UG7/5tDKljsLyogDmji9CAMBkL3/RW1JnWV
 /BZhgBXISWLl+kDJNIIRrHFFCCMz70vDOuizPiZCWfBk6P7pgNiIRJts1CyqTcbOVUdmlKFKFUq
 P3+B4V1anWYhkw8HLMCj7LWIlfb328s7ClMHXBgtaCHL0+2Atu6E4pjS3u4s+MH0
X-Google-Smtp-Source: AGHT+IEv4aAcpDB3ziYWaDnDxuY6ke3Baq5EVsFs5vfopvIrTiZGAqP+6fihrW+6SVWL94Dn0v0v+g==
X-Received: by 2002:a17:90b:4d0a:b0:2fa:4926:d18d with SMTP id
 98e67ed59e1d1-30e0de3c670mr1514237a91.13.1747089385596; 
 Mon, 12 May 2025 15:36:25 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c519db9f9sm6278089a91.17.2025.05.12.15.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 15:36:25 -0700 (PDT)
Message-ID: <f3dd6b8e-6ce3-4ab9-97ee-2ec762a1ea0e@linaro.org>
Date: Mon, 12 May 2025 15:36:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/23] plugins: add API for registering discontinuity
 callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1746968215.git.neither@nut.email>
 <0cb4afe5e43f0138b74e4ccf3e5f4332c5941b42.1746968215.git.neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0cb4afe5e43f0138b74e4ccf3e5f4332c5941b42.1746968215.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

On 5/11/25 6:13 AM, Julian Ganz wrote:
> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. In addition to
> those events, we recently defined discontinuity events, which include
> traps.
> 
> This change introduces a function to register callbacks for these
> events. We define one distinct plugin event type for each type of
> discontinuity, granting fine control to plugins in term of which events
> they receive.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   include/qemu/plugin-event.h |  3 +++
>   include/qemu/qemu-plugin.h  | 16 ++++++++++++++++
>   plugins/core.c              | 15 +++++++++++++++
>   3 files changed, 34 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


