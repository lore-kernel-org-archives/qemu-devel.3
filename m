Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC28D58D66
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 16:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFcG1-0007Cj-Vv; Mon, 25 Nov 2024 11:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFcFx-0007CH-UI
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 11:48:16 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFcFw-00074S-6D
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 11:48:13 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7f8095a200eso4361876a12.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 08:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732553290; x=1733158090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2FlzKWTO4XbNurswbjAnESbLd9Rt31M/m86ri9Pa2AE=;
 b=sr77uAIVlCkaiG4dK1wUBtpeQt9TZc+kZyuTyezEvRuIxm99ACAiGuv2xKbOAV/scV
 aGG+qzfwKsqw/5yrJL/gfxfDVBCy4zFMHATne+lGA8vcSE4vfz3kEr3qASSuyBd5K62C
 84b/tDIk5+DvRsSv9YAOopNfTmpKobcT25V0CV8lqhPuOP1i2Wa6xACO2NbTcXQk4Ag7
 Z7AL79KK2+RSr5XgLDRAv2ZizXPXyfRNvgPZz+Dz4b9Z4dTWH2FL8hiWv3bGRmhk+cLq
 nFkdWGQ6ueA3sO8NF+F3wCF0V1Va4cJBDelGpWFWCy+lCMm56LwoUuQhhYPgzsnTp0jC
 0ZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732553290; x=1733158090;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2FlzKWTO4XbNurswbjAnESbLd9Rt31M/m86ri9Pa2AE=;
 b=rQA+UIozGYH1C6Gi01J5sbwZQefV9EoT4s15hjYmt1gumMZIgrhY/x8qhoMdkp5MHI
 na1hBF94YNCtoLg87EGl8+Uk9DzFqWyVB1JzxHuJyo+HzJf4qesrO+TTZJ8Luk3Q1Noz
 Q3iyIyJEqNHjvGiKJ3cv9AgOZ65v9+4J3idYWogx0AevoYR6GPzFOCm7DBg1rz5zT4Na
 4A+RkWTvafqmBpXfN98hUTlMBHPGoAvW/LqKR1eJEcCYbb3PIpbjE8pgW6BqPyP91xQk
 xBWi3aHlepHRHU9mjdYNRRhBHvlcauC9Rp51kJjCkmghYQIXIVvJOoInFRrwDiaBedwa
 Meag==
X-Gm-Message-State: AOJu0YzdilJPw49QHUtUzRzLv7RkHoiKXVcRCws2KigJMi0tXdVdpJ1M
 Hb7d4hPPFAEAFCefSIZPxusiR8Y9AFdJgP4CtaBwkB/MU/9sJMvsT1WahD1fjfg=
X-Gm-Gg: ASbGncs6B23nujfY9QdNQR3d8clvBRPI0LKvMp+sExWh+7L6ad89xYgPZ9hKdMzmXg6
 GilRXl7lnmHafJfgNQISArK1yteo3hhZj0EeaVzC2WrmczWwLULuBwfWDEJlrFLT/AN2iCCyfzU
 1VBss7PxF0kbAPhEQXmMNUqg8/8igclGkApP00DsEfEkpsl9wMSo/MRlKKJJWdCHC/OA6dqcKPe
 O4ysfJnBHBgELpv/IAHcvD06IHUN77Bk54zKD5+i20Wpy0sX756IHPzo7QSVeHX65rpfCVlzK0a
 BrKyohcBs6vPMpvcKFjSsw==
X-Google-Smtp-Source: AGHT+IGWWt9VXXS3gNlYCPC/A73/UDnTo1OoHaGjikIFh+egKydHShvita93KDD9shAD9L/gzQWmqA==
X-Received: by 2002:a05:6a21:1690:b0:1d9:15b2:83e with SMTP id
 adf61e73a8af0-1e0d66ec811mr114633637.7.1732553290300; 
 Mon, 25 Nov 2024 08:48:10 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbcc22ca48sm5862141a12.51.2024.11.25.08.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 08:48:09 -0800 (PST)
Message-ID: <d02f2221-ffa6-4232-bfcf-a19deee6d1ac@linaro.org>
Date: Mon, 25 Nov 2024 08:48:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting clang on windows
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
 <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
 <CABgObfbpEEHbLYNNXoNUwD0VNPiNAYB-9REqgEFhRz3QQKTZYw@mail.gmail.com>
 <Z0REl6xtaYuvP876@redhat.com>
 <CABgObfYeNW2WYVkPVGmaPKXHLC6bfHm8fFO+wuoQzZiOB5DPyA@mail.gmail.com>
 <05108195-009e-4d06-bc79-065b1e3432ed@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <05108195-009e-4d06-bc79-065b1e3432ed@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

Thanks everyone for your valuable feedback on this, and taking time to 
give more rationale about the previous position you had.

On 11/25/24 03:19, Thomas Huth wrote:
> 
> So fine for me if we allow compiling with Clang on Windows now, but we
> should make sure to avoid that those problems are sneaking in again. So
> Pierrick, please provide a patch to docs/devel/style.rst to say that we
> disallow bitfields in packed structs in future contributions. Then I think
> it's ok to remove the gcc_struct from QEMU_PACKED. (Just my 2 cents, of course)
> 
>    Thomas
> 

I just compared windows binaries with/without gcc_struct, and as Thomas 
found for qemu linux binaries using pahole, there is no difference with 
or without gcc_struct, so the attribute is unused now.

In case you want to check that by yourself, I uploaded binaries and 
dwarf info on this repo:
https://github.com/pbo-linaro/qemu_packed_structs
(gcc_attribute has gcc_struct binaries, gcc_no_attribute_no_option has 
binaries without it).

Before sending the a series removing gcc_struct and editing the 
documentation, do we all agree here it's the right move forward?
If yes, should we apply this to 9.2 release?

Thanks,
Pierrick

