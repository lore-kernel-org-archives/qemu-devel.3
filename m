Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C74FC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCa8O-0000nu-Mg; Thu, 30 May 2024 03:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCa8E-0000jF-91
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:23:26 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCa89-0006oN-J9
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:23:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-35dc04717a1so374529f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717053800; x=1717658600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vNgVXM+jRmEN5kYnjkXoD2wqjpY/FpiImfgZWVlHIZo=;
 b=u2eFM7d/22H+PURzUwTRc9joC8jylqhZKbZGnT8N4ALP6OZ1WfpUvQNsprJMVHQOgS
 KcC4KscUsY75Wo15Vc/luAyAHr4+pJB/RcYRg+F0VxQklUuKLPRFG4bFZ89AcmgTKOtb
 htE+CSM4Krqe8E2Avqs6IAfWsE+ScuXt/Kc6XuoDB+yGdOGRYjesQfRh8L+YZwhpKDs1
 sABb8P0h59FFaPdgLiCjT2tC5mu2cVy0es0WlYOgzdwrmQuRF9ai2G65dMpSFQHCi2jk
 U0hWg5/yKcFR9jCv0JAreRlFcX/+jpnjTUu/08L47pu6HNa0WwBcFQki93Hhx0yWn++J
 e16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717053800; x=1717658600;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vNgVXM+jRmEN5kYnjkXoD2wqjpY/FpiImfgZWVlHIZo=;
 b=WWSkqpR2MXOk+ImBWBU1MO7VO38127Crji14uHSwEy2DevtRAJqxLEJ2qJQ+79D6Ei
 ByiMrAjBEdK8HHBCdodMwqOfq1QF8555S02nPORCSYT9bQJaqFkZVR18maEuoKXFiLYl
 jbqFeGfakNvJpiUX2Oj/GEA4w3rFos9Pwe8aP7SarnBGZo28uSIbEoA/UGOoc3awZVb8
 3dffBGg9Q/K5H7LZDjAq4IY+E/K9UKuKb6OFZNerWYVFbrZsB+YPjfkp68vIszzGldHU
 ExChUredTKAalOaZr5t16NN8e61YPZ8OQ3NeItC6I1sayHg0gsdE5kTJJzmESdKqspkL
 +7yg==
X-Gm-Message-State: AOJu0YzeNbOcmLr5jwo4dNHq1e3nz8bDc56C27txQmJ7zel1tx4c9bSM
 6T/wnPkOPzSGDf2JZcyNDb49FuNF7Iy8dzRgNo+TDON7T6BuyK8+DhUGnWRngro=
X-Google-Smtp-Source: AGHT+IG+EUCTF73/WAi0mfOD435vQmR5wLlbEgjLymwx/Shs12jnaUPkFxA57hg2wUjAPdeTivpZHA==
X-Received: by 2002:a5d:69ce:0:b0:354:e021:51d5 with SMTP id
 ffacd0b85a97d-35dc0087ecdmr1771754f8f.13.1717053799688; 
 Thu, 30 May 2024 00:23:19 -0700 (PDT)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a090c20sm16475965f8f.62.2024.05.30.00.23.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 00:23:19 -0700 (PDT)
Message-ID: <8ffbe6ff-b5de-4c8f-af57-11892d9fe72d@linaro.org>
Date: Thu, 30 May 2024 09:23:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] semihosting: Restrict to TCG
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240529155548.5878-1-philmd@linaro.org>
 <878qzse8md.fsf@draig.linaro.org>
 <CABgObfZ0P0Frgj6=mTmvgaA9_Ve6x0BeATgSKdVqM0Ku21p=iw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfZ0P0Frgj6=mTmvgaA9_Ve6x0BeATgSKdVqM0Ku21p=iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 30/5/24 08:03, Paolo Bonzini wrote:
> On Wed, May 29, 2024 at 9:11 PM Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> It is pointless to build semihosting when TCG is not available.
>>>
>>> Philippe Mathieu-Daudé (3):
>>>    target/mips: Restrict semihosting to TCG
>>>    target/riscv: Restrict semihosting to TCG
>>>    semihosting: Restrict to TCG
>>
>> Queued to semihosting/next, thanks.
> 
> Please don't, at least not in the current form. These are jokes, not
> commit messages...

Sorry if it appears to you as a joke, I thought it would be something
trivial :(


