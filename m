Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C858BECD9B1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 22:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo7xa-0004j1-Gl; Thu, 05 Feb 2026 17:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo7xY-0004hY-6g
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:36:25 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo7xW-0005kU-Iq
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:36:23 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a77c1d5c3bso6277215ad.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 14:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770330981; x=1770935781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RY8dbBJNl0iVtAqXIJI3knfeSwev1t6cHnxolir5B/w=;
 b=u/Qpk0bzYIyKsQphxhYRUNlm1CCPyRmLbj3eq+sTsiVkM4L3jcTZ1yl9KhbJ8GmF+q
 mS8PTDfhsHjCb2COJNYQMMY3VWJe0RqwoHiH/Nt6fwXq440QcXWTIxsD18jwG1tIUDJO
 ck0YwqnEYZxYoYlbRp0Qga/sSgS7IbXNrJUAeyk0kZ9aMv35Z2P7A2maanLdtVgtyk6W
 46F/N9p0kemekqxCJptkpBOP70ZwFc6VTPF/TcNtjD0h68vxp15tn98jJ4lI87TnacJ8
 TEd+bix0TSyD88AUMuxFlttbqCNaZQrWNJ6NMcnf1j7e9euNOvICxupWY/oWFmissMYw
 bGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770330981; x=1770935781;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RY8dbBJNl0iVtAqXIJI3knfeSwev1t6cHnxolir5B/w=;
 b=Y4OXvyAePbhzPl/LT94aXYXLy0vUYcXwKcxCa8mGBTInA6+m8GTrGKBtDgEGLozbvf
 GYIBJFYm7NXhSqPHtaA3sP93B4IY8VIjiUeIWDaE0P0mbCpSzC7gpt1RvzMD1bSW6Nxj
 j/Va+/Nz/1vq+3SGTwtdMktWcN4E4alLqEFC/3SfQEa4geuSGsZyjSLcftpTJFtTTHSO
 /0WjzMYyigg+KaBRPTwB9h2At+UdtfsUUYKk/L1wnqOeJWRF5jwKKW3nTARB+gdKodS6
 Xb0FLzVJdVCjJiPTNxK7gHKS79THRd6C8LacWhxoLQ/XS1jUyRsQxRI3+0929NS5boVn
 3ghg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOECLCro8c6ke9s+oHXGE/8iFbl+1FsBGgAAo/MwB9EsA6tTkvWJ0AfNrz+IFclz/5TU99mNosb32z@nongnu.org
X-Gm-Message-State: AOJu0YwJ2M4jd09gQbX8pzjQTYOSmtr2WfL5dAYXz7sMfTFW/totqLmS
 m+XD75EG+8lXGDWwH/WqwcmrI8Lhc6f/QmzJd3/iiM34ohfNIGdQFibIwl5qZAOtV9Q=
X-Gm-Gg: AZuq6aIIlQ+h8rNVooPg/ghHhd3f8zT07EZNdexska3c5frqxsrk0LxkkPagfIbjDOf
 f7PA18+XWOiRgxqqHTL+qKpDpIRaq1w6sIDRA0/Trdibd7EqOvAeQ/eFJ8EFonk7qB2N+mwI1+E
 8vJdmz4SebNexZOPaCdF4eBLMoNiVQAWi9yS/TuKD6ZcQpsNx4K+w0VpYZJ+sBvCHlm6tXJ4oO8
 5WbKbHqd8FIW9D8PAXx7dpgW6v89x2sjD/oGREhFZ9sXlxySMrMZIUcK+8iNs1r6O3oWgzIO5Hs
 8d0umUDalbdF3+8ILo9qiPb85zfQtMsCcpfUsZxS8ULq4t/UC+AeLDhF8fQ/LLByZycfqE1ibkB
 iqsMeP9ttcEi00Y+h9ndTcuz3teUvm2A1RJi7bS4D86xBR1n1XP3rtr1mQqAx4pg5+GqMm5WEqq
 DAg8f6JP1NlIeYW6u1xqOkj8qfDgdf4xsQEzb5vLwn2E1Vn77yO7bcXYV2T/NQeSVRMtFthr5Ej
 bDGix2D5q4ZHwS/n8S4APWucfhsKl6f1aACT69pew==
X-Received: by 2002:a17:902:ebca:b0:2a0:a33f:3049 with SMTP id
 d9443c01a7336-2a951607aeemr6807005ad.4.1770330980839; 
 Thu, 05 Feb 2026 14:36:20 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:3c5e:852f:abc3:6539?
 (bg30dhzs8j4dh00m37sw.ip6.superloop.au.
 [2401:d002:dc0f:2100:3c5e:852f:abc3:6539])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951a6449asm3853195ad.3.2026.02.05.14.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 14:36:20 -0800 (PST)
Message-ID: <6ddad25a-192c-4b5a-80fc-b006436810a2@linaro.org>
Date: Fri, 6 Feb 2026 08:36:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target-info: set target_arch statically
To: Markus Armbruster <armbru@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
 <7645fcac-c4b2-4a9f-91c8-4990e9c92ef9@linaro.org>
 <5fd0062c-b474-4971-9a46-06af9ae4e0c7@linaro.org>
 <e1495603-4ac2-44bb-8b0d-74c45e5f2e66@linaro.org>
 <877bsr34au.fsf@pond.sub.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <877bsr34au.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/5/26 19:52, Markus Armbruster wrote:
>> I assume the qapi string is the one that should take precedence; everything else appears to be merely qemu source level strings.  Marcus, can you confirm?
> 
> What exactly would you like me to confirm?
> 
> I *guess* it's about the messy part of the patch you posted upthread.
> There, you have to normalize TARGET_ARCH value 'openrisc' to 'or1k'.

Yes.  I wanted you to confirm that changing the string in qapi is a non-starter, therefore 
'or1k' is the string we should standardize on.

> I figure this is about adding 'hexagon' to SysEmuTarget even though it's
> not actually a system emulator target now.
> 
> The fact that adding it there helps indicates SysEmuTarget has leaked
> into user emulators, and its name has become misleading.  Is this true?

Yes.  The target_info structure is used for both user and system, and one of these fields 
is the SysEmuTarget entry.


r~

