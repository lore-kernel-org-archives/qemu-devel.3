Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2748C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTeb-0008Bf-5O; Fri, 06 Jun 2025 05:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uNTeY-00089d-7e
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:46:22 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uNTeV-0004Ec-DK
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:46:21 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2320d06b728so17922755ad.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 02:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749203177; x=1749807977;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=duuqwHErUIam1DuMnj+QdeSLu1QCabbhYzv9VEo1NPg=;
 b=1SUxfsVNfyuWReKf2GbPfexnz83XM1sYd3jAUmUF2TpYhqeALf/t73+vEZo+l1hjRp
 +CbyJkNff9iPbzqV6Mrdi+CsfvE0Z9mybu4JukM2mTkaMKXogPNoLraVNutIQoYK4TWn
 vXKZcYtc/5V0DpK5dpA6IZLoqA2rlYfLszZPsf9BdQmycFVYdwG+iCeNWjlJJ7mntv7S
 h3fC0cT8HKQ6guungpSbxislvRnyqkGP8bPpERlzAyluURqziHrGegvCItMqjuO2a9UI
 gfjaiX0QzLtQmIRYCyaim1wTtll0w0QRCkqgOTg+8rAKwArQ4pPBO6kRSLuLP9dNe1Q5
 WREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749203177; x=1749807977;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=duuqwHErUIam1DuMnj+QdeSLu1QCabbhYzv9VEo1NPg=;
 b=lyJi8T4BR7Z0WhNMLKQZVyPBihYwFuRcy8vhInnZ4KJOMbL6MbHR5CyrV2LVI1HixD
 e1VHuwVMbWjm8uY61m6mQ9NLDvHAaH15ByCJP8t7PTJzmli1eCGfjjqBA2q8CjQfKmVD
 l+vocy308iRdksAHzwwUCGd/2Qo2Gahy8wWosRePlMwNSV8thFiF0mpy7vgw62PmYdIJ
 ab7t4QB5qDsxH28KzDP5E4Keksz3RKOwu1Q1jHP8eJTdWjdjlsT9PRSq4b+/SQ+EBNbv
 GRslFsDATGHBlJWUHWAzBsjHZSEpJP+S8G4jR+nrEmOI3ipN+zyY4nsaBhOp3YuvcFwN
 aDIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB0hgBQZ732jDujfqauDjub25FJE7yTYXGxNal832yPBktS2IuvYTKZ2qvrIRRdU95U/P7DLaEkf47@nongnu.org
X-Gm-Message-State: AOJu0Yzle0Aw3VJJKBYXQXwaSbM8gfzMtHo1OIbEBIasnsm154+rO3du
 kMQ1oDQBLrpDiSD/dR3vszhHq6RbNyxkOe3DRNLLfCoRCAvpmFGK4asNzv74VTMPcs0=
X-Gm-Gg: ASbGnctRc+6BrZr1LvNHhn1r9qWJYPUgr00rJ0LJj772Em9ZhUl+Tk/B2yiCTr2NdVP
 UrWEim1YEYjT6wVCxjLSZX4+7yEXUrLSKva7L/u7RkKMP9l/+WT3h4JPFb9G3boDqhmgHzmE8Bj
 geiMEIPFwqetHmGohchOp6IWV0fm1T1HQUlZalDgQPmu17sOu3MwkuvijmjIZlXCbYzSOg5/4Mo
 kkFCLOy+qYN0ULhp4RxlTqylfl41KaxDIyQFcScd3CkLROFrZKiycfEAmFRNE+42m9GujFUu/qQ
 Ykk7HLX2yKoUXEOiFr52ZzjU3odjZmeTnmFLsjiqkaw6hX5YW3JxMibIfVlTnYxuoCUDF16kSbM
 =
X-Google-Smtp-Source: AGHT+IE7MufQejtzLXpcpo/9uyI8rkYZ6NXDk1Qeld7XzkCQ6O8y3sDVeEB3gsDpQKUUtIrGuEkBeQ==
X-Received: by 2002:a17:902:e5cd:b0:234:88f5:c0d1 with SMTP id
 d9443c01a7336-23601cf0994mr42108565ad.10.1749203177277; 
 Fri, 06 Jun 2025 02:46:17 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-236032fc9ebsm8865965ad.106.2025.06.06.02.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 02:46:17 -0700 (PDT)
Message-ID: <b41eb6f4-96b8-47bf-90cf-e4918a613dcf@daynix.com>
Date: Fri, 6 Jun 2025 18:46:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] Improve futex usage
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@daynix.com,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250605132427.404551-1-pbonzini@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250605132427.404551-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/06/05 22:24, Paolo Bonzini wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
>> In a recent discussion, Phil Dennis-Jordan pointed out a quirk in
>> QemuEvent destruction due to futex-like abstraction, which prevented
>> the usage of QemuEvent in new and existing code[1]. With some more
>> thoughts after this discussion, I also found other problem and room
>> of improvement in futex usage. Here is a stack of patches to resolve
>> them.
> 
> Thanks.  I haven't had the time to go through the final two patches,
> so I took the current Linux code unmodified and added the non-Linux
> changes on top.  But I have kept the delta locally and will get back
> to it.
> 
> I also had to squash this in for CI to pass:
> 
> diff --git a/meson.build b/meson.build
> index 20e8f37e6e7..34729c2a3dd 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -843,7 +843,12 @@ if host_os == 'windows'
>     midl = find_program('midl', required: false)
>     widl = find_program('widl', required: false)
>     pathcch = cc.find_library('pathcch')
> -  synchronization = cc.find_library('Synchronization')
> +  synchronization = cc.find_library('Synchronization', required: false)
> +  if not synchronization.found()
> +    # The library name is lowercase on mingw
> +    synchronization = cc.find_library('synchronization', required: true)
> +  endif
> +

This conditional is unnecessary; docs/about/build-platforms.rst says we 
only supports MinGW.

I failed to catch this problem because I ran MinGW on Windows, which is 
case-insensitive. Since it is case-insensitive, the lowercase name will 
work for the OS too.

Regards,
Akihiko Odaki

