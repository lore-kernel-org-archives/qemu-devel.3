Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273D0D59F5A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kLa-0008U7-Me; Wed, 06 Nov 2024 13:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8kLX-0008Te-Db
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:01:35 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8kLV-0004Cl-Ji
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:01:35 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d4c1b1455so8709f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730916091; x=1731520891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y8C08c0CPdhXWq3j6o58B0Sg8LTBvoeIkrJl1JpkVyQ=;
 b=aYz+h5yoJXJmUIsrB6Z0CjdXcDPsmufCvyME6E6LD4do2QFowqRtslg1osV7VDtNyV
 +kzmop/tqvB/Cf7cl46JavoZfyhCOFuezkVwZk5wnjy1KKhznldFZOrofMMBTOgrawOq
 pBeLGm4cH8oEb55w43QQmspA1bvvRa3FYGTt62J8Kg4ffAEjwuYdefw/p05h8j8hgDDg
 pf2k8V6Eg7Ymyaiq8KaJHOjzCTAX3xq6gSAFq6/xnB00/Qb6bvgIpAfpA40Drk7NlGXv
 ofMglYhqudqA9dZnrsB5MYopvI7jCC6x0xXZCSikTSFtnBauu55s580DEuqsPR11MeEn
 o2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730916091; x=1731520891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y8C08c0CPdhXWq3j6o58B0Sg8LTBvoeIkrJl1JpkVyQ=;
 b=b8j9fWbeTwLSaEfu/d0TmKgm44aTVs7/zhGbqFq6icHpa9gMPLInnVhSTfDfuU+143
 JI+jXh+mIe68GAUIn0fYNKC1fV98U//fSeoHkXtRcZU2Uh4OYPUEHQRoPKDbpI1Q5WTL
 Dn0CMQyWnhn5WMPn5ooLvQtjDxITHi48x04U9rg+/M8PXqt0xFFQnaaelg2pUtHfTNLK
 ai7cJ9qGiSvfP7eWn9OaZ1PAe485MUQfhm23GFCLI8APy4hVU3yum6BUabPmpsDyqA8n
 tjIZc+3gPJ6o/A92waDC2x/0fDN0nt/0e4bKWHrlBsEG+Lj1sKhrQgQS810LjoubEPdw
 pIWw==
X-Gm-Message-State: AOJu0YwBoBGoLeGmb740Ch0Yte0BBNZW42V0lcY/oKqaT42qwqcbBr6Z
 ytFCw6+UPENMX1FnxnqSE4IgOW40ce+S/VQPs7HB6aTXDPnaysMIvdLc82xysBw=
X-Google-Smtp-Source: AGHT+IFVnuWqv8qdKmqSJtMrsurVAAW8yDIqZSTrl+PCVh+/5bwf9A5pZ6VTb+I/gg8maMBSBAElPQ==
X-Received: by 2002:adf:f6d1:0:b0:37d:4332:e91d with SMTP id
 ffacd0b85a97d-381b710f7f1mr21038163f8f.52.1730916091239; 
 Wed, 06 Nov 2024 10:01:31 -0800 (PST)
Received: from [10.134.195.192] ([193.32.126.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e687sm20043607f8f.84.2024.11.06.10.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 10:01:30 -0800 (PST)
Message-ID: <0c612f91-3699-48b4-bbe9-eea2298ff3fe@linaro.org>
Date: Wed, 6 Nov 2024 10:01:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Bump timeouts of functional tests
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20241106170946.990731-1-thuth@redhat.com>
 <c233a6b5-bfea-4d5e-9b1f-5bc3a467e17d@linaro.org>
 <CAFEAcA-MVg2EU2cKJz+drZp3=GBCPJXqbP7iNimg8fs0NYfhOQ@mail.gmail.com>
 <235c9cc1-aba0-4612-ba19-32885cb4b138@linaro.org>
 <f1e324ed-e086-4f8b-8027-be2323383665@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f1e324ed-e086-4f8b-8027-be2323383665@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42c.google.com
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

On 11/6/24 09:40, Thomas Huth wrote:
> On 06/11/2024 18.30, Pierrick Bouvier wrote:
>> On 11/6/24 09:26, Peter Maydell wrote:
>>> On Wed, 6 Nov 2024 at 17:21, Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>> I noticed by --enable-debug in configure is a combination of enabling
>>>> checks (enable-debug-tcg + graph + mutex), and deactivating optimizations.
>>>>
>>>> Would it be worth keeping the optimizations and runtime checks instead?
>>>> This way, there would be no more "timeout" issue.
>>>>
>>>> I'm not sure which added value we get from O0, except for debugging
>>>> locally QEMU.
>>>
>>> "Debugging locally QEMU" is exactly what --enable-debug is intended for...
>>>
>>
>> Yes...
>> but it seems like we take it for "enable debug checks" in CI as well and it
>> impacts runtime, because optimizations are deactivated. I think I've not
>> been the only one confused about this.
>>
>> So my point is that we should maybe differentiate the two use cases at
>> configure level.
>>
>> --enable-debug and
>> --enable-runtime-checks (or something more explicit)
> 
> Would that really help? I guess people still want to be able to run "make
> check" when they compiled with --enable-debug, so we still need to be
> prepared to run the checks with a slow QEMU.
> 

Makes sense, even though it seems to indicate we have a wrong default 
semantic here.

> But I wonder whether we could maybe use -Og instead of -O0 nowadays?
> 

It would not hurt, but I'm not sure it's enough to avoid hitting those 
timeout/perf difference issues.

>    Thomas
> 


