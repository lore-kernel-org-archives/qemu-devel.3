Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F12ED65559
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG32i-00082q-Ns; Tue, 26 Nov 2024 16:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG32h-00082h-UH
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:24:20 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG32g-0003T0-6q
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:24:19 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21278f3d547so46958005ad.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 13:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732656257; x=1733261057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u8+ZQcAosLtWNzqv4UbZi6YFllNXz4H5DPrwsrGhdUk=;
 b=pciuJwWRJz3GNCKWjyonjkwXbDkdrcyJPgamAY7TTCHv252nkLlP2diiIDsgNq0cqE
 LEZOR7YPnEnBHcN+keAQPfT18RH/9KqdMDrlsHn12q97Zt82nbw8bOPGD31tPow70kih
 duUnOM4BWeUnWvWpFlkYKK8yHWrQYpXnZUkO5cfkZW2fPMy9+lTbZ7u5Zzre4+W0qxeh
 kYixWgrr/s+wDfjxt7di/PESS6YsQx+Br3T+eEYMd98EaHinQl0LRIvITmZMW/lCnCsC
 tNUoxzlBojaS5byYx4340wvNn1hwBQd/3/vx5b+bSx0VEeD1SvUiNwJ29f692iIQnC+4
 7niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732656257; x=1733261057;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u8+ZQcAosLtWNzqv4UbZi6YFllNXz4H5DPrwsrGhdUk=;
 b=uKLgp0oEd2dLhQb0EtxpNMYYzMvw/vumyik72UsNuJhxt6PrrCvCrVe462y6ZXsY38
 hV08boRxSHDfJqBWKeWxTHUg8AqQW2r7ulbgE2UrD73lZTJ1O3WvuPrQt1t4+r9qIhNH
 W4Z1qmIvpZRNeLSroSuptdSXsmY5lqPkxe3hGEb/B8/yWjbMjtPY6A4gjBjVwbsSWQU7
 wTZ5zc9A0DjLCO0JzkACeI/cW8C06hRHX8adVe65QICGsVCqZZ73M1pZEzayzShFkVfd
 UiCIc3qYEsyrJvSyA2gJWwhTG/ykI98SPy5bCOj6VlVLE+qpoglwPqS5ySlkQ3+DV/kA
 XrzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQzbfwTs1LqLGiuKAkI97DpNlwG+tiKpwLXbGNrWN84rIxYT5KCtkevI+dHLgh1fqweXUTiM+0XwXh@nongnu.org
X-Gm-Message-State: AOJu0YzUYPtj0WdEsZYmrjdLnzENkn116dg0MVwOK1v4Yel88SUlAH9o
 Jat0dI5U1IdATzs12bRdvwMr336CWsZ7GTOUISsfgKbvLp3EW/hV+UpJc0bMY/E=
X-Gm-Gg: ASbGncs6/wzSe7/h5NtCZYbRzmZ+efioXV6tLu/hHsQq5CXdH+0sHKxzizk5DECgxFz
 S81d2ERblp/FL5bXk2a6kRclLmULpQKq1fuwS6Y1Fl2m7CBtAqxnMK8xosQScK7b7gAa1017T7v
 1PU12ohgxqUeUuKpq7d8bZlmrn7DpOxFwCT5VDEqyn5hH+RebqGIC3WlBuONIiXCd0IUYEmu3bl
 3Um1uy6WFUe0B3xheie6AqhqTL1pV7epUrgX0hHhMi40b+77Blvxo9XVOqaGHzPfyrLY6bKSeVm
 TaK73TF+awfwgwHKnF9seQ==
X-Google-Smtp-Source: AGHT+IFmsq7H7Mja1ijIcPubiw0wdi14Ptplbme2tUuf7i2k3OGCIqE7bqAl5rfCo/AsYuDdAMN4GQ==
X-Received: by 2002:a17:903:22cd:b0:211:f52d:4e03 with SMTP id
 d9443c01a7336-21501385b3dmr6333855ad.27.1732656256782; 
 Tue, 26 Nov 2024 13:24:16 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1fa27sm89155265ad.225.2024.11.26.13.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 13:24:16 -0800 (PST)
Message-ID: <776d3794-171e-46ca-bf63-7542102dc8b6@linaro.org>
Date: Tue, 26 Nov 2024 13:24:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting clang on windows
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
 <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
 <CABgObfbpEEHbLYNNXoNUwD0VNPiNAYB-9REqgEFhRz3QQKTZYw@mail.gmail.com>
 <Z0REl6xtaYuvP876@redhat.com>
 <CABgObfYeNW2WYVkPVGmaPKXHLC6bfHm8fFO+wuoQzZiOB5DPyA@mail.gmail.com>
 <05108195-009e-4d06-bc79-065b1e3432ed@redhat.com>
 <d02f2221-ffa6-4232-bfcf-a19deee6d1ac@linaro.org>
 <CAFEAcA9vPC40B1cJpuzhN2-mfQG4sY6Sth8jhB+9RwC7aVvDsw@mail.gmail.com>
 <b01bf9cc-45b8-47ee-a63f-667150209e16@linaro.org>
Content-Language: en-US
In-Reply-To: <b01bf9cc-45b8-47ee-a63f-667150209e16@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 11/25/24 13:47, Pierrick Bouvier wrote:
> On 11/25/24 09:05, Peter Maydell wrote:
>> On Mon, 25 Nov 2024 at 16:48, Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>> Before sending the a series removing gcc_struct and editing the
>>> documentation, do we all agree here it's the right move forward?
>>> If yes, should we apply this to 9.2 release?
>>
>> I would prefer not to put it into the 9.2 release -- it's one
>> of those "small change with global effects" which it's hard to be
>> sure don't have unexpected consequences[*], this isn't a
>> regression, and we're already some way into the freeze-and-rc
>> process.
>>
> 
> Ok! no rush then.
> 
> I'll send a series with that removal and the doc edit (+ fixing plugins
> build for clang on windows).
> I'm just waiting for plugin build with meson to be merged in, which
> should be very soon as Alex already sent the PR for this.
>

Sent the series, as plugin build with meson was merged yesterday:
https://lore.kernel.org/qemu-devel/20241126211736.122285-1-pierrick.bouvier@linaro.org/T/#t

>> [*] though in this case the stuff you've done with comparing
>> binaries is great and very reassuring
>>
>> thanks
>> -- PMM
> 
> Thanks,
> Pierrick
> 


