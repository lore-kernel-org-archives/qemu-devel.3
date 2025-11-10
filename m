Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F4CCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIPx9-0002iY-7R; Mon, 10 Nov 2025 06:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPcP-0007Gh-BK
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:59:33 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPcM-0002sz-7N
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:59:27 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-656b52c0f88so1107564eaf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 02:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762772365; x=1763377165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3IzNoBSFlvX2VhmSutXqh3rjth5z1B8PQhgJPhYYBTY=;
 b=OVw0+1kgXjSjzi2nYcqcKwbfPTg1e/LQkkeOIEIgLE5fXo3SEcaq+5082hlDhePyGq
 fM4t3GvJgJPvpaXML6Q0QZ/2G8OMw/rt9XWUWR/pOtsa6ItjfSTVXLszRLEXfuz66oMG
 8Vbq6hmbQ+Jdh+XfL8K9kui/Z/JKSaDwXkMAP0cT+LsZBLSaxOUxb3Yv3MPBpJAJV0IL
 t++HnpdKu2ztSJ53PLmKoarww5nRJNs/lGL8jG6YpdRFftEsXQ3wMjY+tyr687KfIk5b
 oi7MFevENcZ+9A2YFJZ6fFtj8BE5jfu2f4KSMcyr8n13YFd0XbCMueEy852f2naV7Hdi
 /coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762772365; x=1763377165;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3IzNoBSFlvX2VhmSutXqh3rjth5z1B8PQhgJPhYYBTY=;
 b=ZSFckScDokJcmLfT31auSRiIdBfe7KNzzuIPLUxSfodUEE0f3T0pQT8n6Hw8R4Velt
 hxCGmViosiwRIIpXH5bRg7AKXFl6mM8wtP8yqK2WBaaGjBYPvsQGG3Fs+R3ifqhFgkdX
 As/GSAuJ9AYkOV2V6mvek5+QHR2uv9xausBw2bCw6mD0CCh6qfG7H9oWWyJZLQ/C3rdy
 OPr0Y1OUET4cTmbF2N18A5hvdrpa//LI7J/4PCpjENIcEh03xDGXwtH950dzlkTSc4jy
 +ZPEFt4+C0dQkJReAj5obNbb5CMB/4BKMsuTW14VnaJx4AnFrhKh6Croeobyue8eMLgi
 iCHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK6Tc2Gu5I1gXpyt+OdT3Kvb9qdOmv54yjlzr6dxgHgpyJUASh0yg1rCbE7DpspqWCo6zBPIGsiojs@nongnu.org
X-Gm-Message-State: AOJu0YzHFdthpsDSjB6TI+3CQ1p9y8kqKjOuOh5qo79uPWsRdOPMOm31
 Lep2fZFBmzr1NiL2wiZ6bhRhEAaVecBaYXi/I5PvJbeCBzCWxsGWhh3E9EykpXRDDCw=
X-Gm-Gg: ASbGncvfYvGaDjM1Yn9X+KCqdFBtxWzB6pgQaolhnM7tITIwE6CWuSI8GfkCD5YAfoA
 A5z/jqfL+qVAQWfISFENVmoyHo52+rVcn3VY0sKcKRSkjRJJsoZUCBR3yMtvqc3HrYCBQCvmrOs
 zzt7Bq5iAuLURN79k15nR5zwFjHZw8gpdXhiB7qYXltFS+6B4X4jZuKW41amcVyzixE0DVUM+yu
 JkM5or5ykjj+3wKptMQNp9C1IyFVii8W5JJwlMfYFvE2Qivj7Fkp8DIDsyc8TlLwOfLnyejpbJM
 cYHllhBU+aVHfGkmhq++VYhMuJUx8Yb/65ueief9EIvJ/MWT4fMDctHCq1RcZh6zB6CHCvEWplT
 NY7b5rsCi5KT6Et/EaLyKM/EIRZTpMrA+wovDUh7ky6T7KdB0EgoV4mi+EdyjVfvnJNrMW79fXf
 0WeO739YywmZZebz2UgPwP9FRuAghvy/2ptDR6aY1WB/TtBuc+HEBJXANu9iwGsYjVg+w=
X-Google-Smtp-Source: AGHT+IGZGenx6m/dI0WLXtYiTmtKYfXYJk+ki3G9gvwIfhycxFUdqJ0hX+HgqXe3tSPB870kksqR/A==
X-Received: by 2002:a05:6808:4f60:b0:438:37eb:62c7 with SMTP id
 5614622812f47-4502a2ca46cmr4186056b6e.21.1762772364928; 
 Mon, 10 Nov 2025 02:59:24 -0800 (PST)
Received: from [10.89.10.227] ([172.58.183.226])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656c5713288sm5819727eaf.5.2025.11.10.02.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 02:59:24 -0800 (PST)
Message-ID: <65b33dd1-cef6-47f9-86c4-5367146d103e@linaro.org>
Date: Mon, 10 Nov 2025 11:59:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2] tests/functional: Mark another MIPS replay test
 as flaky
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20251104145955.84091-1-philmd@linaro.org>
 <dac450e7-e22e-43ad-a40f-690753e19813@linaro.org>
Content-Language: en-US
In-Reply-To: <dac450e7-e22e-43ad-a40f-690753e19813@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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

On 11/6/25 12:28, Richard Henderson wrote:
> On 11/4/25 15:59, Philippe Mathieu-Daudé wrote:
>> When disabling MIPS tests on commit 1c11aa18071
>> ("tests/functional: Mark the MIPS replay tests as flaky")
>> we missed the 5KEc test.
>>
>> Reported-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/functional/mips64el/test_replay.py | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/functional/mips64el/test_replay.py b/tests/functional/mips64el/ 
>> test_replay.py
>> index 05cc585f854..e9318448fa7 100755
>> --- a/tests/functional/mips64el/test_replay.py
>> +++ b/tests/functional/mips64el/test_replay.py
>> @@ -40,6 +40,7 @@ def test_replay_mips64el_malta(self):
>>           '75ba10cd35fb44e32948eeb26974f061b703c81c4ba2fab1ebcacf1d1bec3b61')
>>       @skipUntrustedTest()
>> +    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2013")
>>       def test_replay_mips64el_malta_5KEc_cpio(self):
>>           self.set_machine('malta')
>>           self.cpu = '5KEc'
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued.

r~

