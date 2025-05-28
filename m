Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8596AC54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 03:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK7Rc-0001z2-Op; Tue, 27 May 2025 23:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uK7Ra-0001yu-Ce
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:27:06 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uK7RY-0004bG-D5
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:27:06 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so3117839b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 20:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748402823; x=1749007623;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uCFjXR5zgfKX0SKS8i98rNTyKMt9pJNvZ6PgDDYJjY8=;
 b=tZJQTq6ohkgGWrKmNtD+LGrOCi6cCmnR2lgVz/Js+wnUzZP8HbFacjtgUeMBcOpj/u
 X+NkMrwe9DtrVoSadNgs5vVqGqK0q0FI4j9d5kLmoMDsv0djxQlqWDF3Wh9D2qgQd6tQ
 /arpkFDAQyS/+RykKqHnKoNVF3/VHqGKQVngyFDn8s5mtaAX0Y2gUuZM3fyMLhy0WpaT
 XiDmu7FFXNax7J077ieR3CAh0ZkFRS4YkTXrzt9KqTUW9Gxn2H9wh4B8P4FPVqsWLgKj
 rR9CIN9MQ5SrKjstN0g2GUqyOyREa2Dr65iJTCEaAMvW7W9xy31cNJnPtC/ziU8AVY+T
 oLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748402823; x=1749007623;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uCFjXR5zgfKX0SKS8i98rNTyKMt9pJNvZ6PgDDYJjY8=;
 b=wS0uCAy1hU7ACedPSwoSVQjX7vTe8ZKv55uv7FAS9Kx2Os740GGZ56W2xLd2SWX69m
 tVFLHtIOVfbB1POTs/6WCWvLmzzuh5VFPpqutv9ES0RrkeNqW7c/utktWFOnsbVUMVZG
 ISpD225DB00W1LkdrFIRixK4MT9v80kXoCjs4dFjopUT9RfICDJGKgvqCJaEyg3LE2Sb
 BcwquPD/4abWgSa6dU8FIEaY32sf9rTzErUMgS2iyhplVhgYHqttTvwCG3vJOwDaUEtP
 yMCjH1ob11W0E5LHKRDkBwhe9t0iQVUcKVTyBEwhU70xDQ+PsLJQw+6UyhUySfZjd3+j
 UnGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCIquOqMFt6iiMan21hFqRLcTuFN5g1fT4JVraWWq21NRcDGf4qBSqd4ZAT3HV2BS3sURvNpNFxcNa@nongnu.org
X-Gm-Message-State: AOJu0Yx9XQ/edQ3w17XiwPQiDz0N3a8h/ZSP//bVfP1+5KLtMFwZYhAa
 6NmUGd4U+397rtVMJaDyfaHGXUdm56TtiGXHoUDfwHxYB76fQsh4U+BnNqg/RCSxOdw=
X-Gm-Gg: ASbGncveuEAVitkZthztlYqlF3otgZX42fsvaJEIkI562BulTPfcdqDIaRHxO4qXA+Y
 TaVYhyqi/mFoRLjH6craDCC7VxeD4dMZ2TvTNmFJS5a2LGHDMqVGyE+YJphFyrX4fiT9QHknDLO
 JHG0uT8LEJwZAv8+cJvRuqMIl+vjFSSJ5qygAXgAoOapqwLWlHUPH64PNYY//fzN0aGg6b2ihHx
 myBUXShi6mdF/NjQ/17a+lO1QcwzGxXObiJJtF3PorSep+rdHEDQNYOEZQ4kdTvFfyqoUnaOrYZ
 8aCbRatD8NM8tVOKAMNTG0A6Mc9vgbPQz+/6PREB7K+JjEYbO48Ubc+lrUOtgjoaQwXHy6si
X-Google-Smtp-Source: AGHT+IG9blmonXPSH3djRpbEzvIprHVSrUZNAmsThoxzfVi1YRZEXQewSo5NvKQGjUl5IZaIKCI0Dw==
X-Received: by 2002:a05:6a20:9f08:b0:215:e1a0:805f with SMTP id
 adf61e73a8af0-21aad937af0mr975781637.31.1748402822649; 
 Tue, 27 May 2025 20:27:02 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-746e3442729sm236389b3a.155.2025.05.27.20.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 20:27:02 -0700 (PDT)
Message-ID: <feb0d8ee-ae0e-44f3-ac79-dde785de6463@daynix.com>
Date: Wed, 28 May 2025 12:26:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] Improve futex usage
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
 <9461fc05-3c1d-4236-a0b7-99f39781f278@redhat.com>
 <a8d508a2-7369-4ccd-a6a7-7c74b38c962a@daynix.com>
 <CABgObfbh+VOvjWBM-NdTWnuSzgkmjLN=nfskLrxL8-NBtJwUTQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CABgObfbh+VOvjWBM-NdTWnuSzgkmjLN=nfskLrxL8-NBtJwUTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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

On 2025/05/28 0:01, Paolo Bonzini wrote:
> On Tue, May 27, 2025 at 5:01 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>> I'd like to submit it with "[PATCH v4 05/11] qemu-thread: Avoid futex
>> abstraction for non-Linux" because it aligns the implementations of
>> Linux and non-Linux versions to rely on a store-release of EV_SET in
>> qemu_event_set().
> 
> Ok, I see what you mean - you would like the xchg to be an
> xchg_release essentially.
> 
> There is actually one case in which skipping the xchg has an effect.
> If you have the following:
> 
> - one side does
> 
>    s.foo = 1;
>    qemu_event_set(&s.ev);
> 
> - the other side never reaches the qemu_event_reset(&s.ev)
> 
> then skipping the xchg might allow the cacheline for ev to remain
> shared. This is unlikely to *make* a difference, though it does
> *exist* as a difference, so I will review the patch, but I really
> prefer to place it last.  It's safer to take a known-working
> algorithm, apply it to all OSes (or at least Linux and Windows), and
> only then you refine it. It also makes my queue shorter.

Compilers and processors are free to make such an optimization so the 
contract between us and them does not change in that sense.

On the other hand, the removal of smb_mb() does change the contract; now 
compilers and processors are free to reorder loads and stores specified 
before qemu_event_set() after the load of ev->value, which was not 
possible in the past.

I'm confident that the change of the contract is safe, but it makes 
sense to pay extra caution.  I'll reorder the patches with the next version.

Regards,
Akihiko Odaki

