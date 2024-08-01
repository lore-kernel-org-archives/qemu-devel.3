Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AED0C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZVEa-0003VR-8Q; Thu, 01 Aug 2024 08:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZVER-00033R-M6
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:48:36 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZVEO-00060q-N3
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:48:34 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7a83a968ddso975554266b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722516510; x=1723121310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VYRZTBdIF23ygeHNPmHZmE6P9/QEL1DHI0iPVHT/NEw=;
 b=Q/eT9ny7m0uoLSg3279A0Svgu6HVqzGS4O/fRwWnOh8zL5RJvhHIO53pmpcbtM4IUN
 W9sCFH42NyQmNKDIO97y/dnpEzMiTn3UEijc0KZexxWzYiYGuilUE16oRvTWQbefReN4
 K8TAlovjmDhd5GPG3ccegdgTMXJ/dfeRkbBol54FAN/JBrnJ9aZyOOkoSn8X36XHiVfR
 ffhrgx8fx248amI1D4fTcBO7haylSJsTS7+hqlHKZy3qPgtE00D/fwICX8u4icdjaq/W
 kmMtwJEPTldtPBAQWKmb6NbuOs+YwRPTUKInN3Qd3NoylIFB7UcE8QbvVckQ4Zhd0NI0
 9rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722516510; x=1723121310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VYRZTBdIF23ygeHNPmHZmE6P9/QEL1DHI0iPVHT/NEw=;
 b=Cmm5csYRe2gBB83R7p3W0biNbgJeg08huY6FjxkhUChlFfL4r5BK9Ae5cMXre9nVi6
 zg+6LDgFnvC7zKaitjirubXkjMC5nh6t9R5cgqEt8xyCfYHHIZooOWMwPwkA5cQgwgI7
 pXzGkvEG0GcVc8bHy/IQQ1qkP5fx4zZyoj2dZGP1tHY0qSpMtwv9mhXvN0Rq0SVuF7aG
 WFF30QmFLOWgprnRMo+9SVrI0El7K9BhQxIFYHWuW/JnViQXuAc54r/oPuwaS3EniE7h
 dZOJGTbmyFFn227lDMQp4enPDQJ0o8NJY2jItKXD2XYR4f0lbKqej3vkjNRuAtKPBeFw
 4wHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW609Hi+y/imnUyuZUGHfW8cdmou3bmdevXSn26iBuw1XJCqYSzWkHJ7sAFOiVb/aCd2wsIXNzqti2W0jU2jBfeoqC8Syc=
X-Gm-Message-State: AOJu0YwOj3gP6hd+u9j+ra16H8MmaaR6sIcJPEpOrMZOgz/IguoO0Iqv
 e0dHtITO0bnuLDaUzHEIMjvuVL0EjsD9bXRScYPohSLbxQTcYUsIYqblJSPrUT0=
X-Google-Smtp-Source: AGHT+IGsdY7105AFAy0RsSDhCU0VUEaYmzJETy0BOhkXSo5xdjHAjnRGavAsi8Imaj6wXl61XLf7eQ==
X-Received: by 2002:a17:907:1ca2:b0:a7a:bd5a:1eb7 with SMTP id
 a640c23a62f3a-a7dc5105635mr1580766b.59.1722516509805; 
 Thu, 01 Aug 2024 05:48:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab2316dsm902763566b.2.2024.08.01.05.48.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 05:48:28 -0700 (PDT)
Message-ID: <8524dc6f-51a0-4fbe-88d5-47a662e674b5@linaro.org>
Date: Thu, 1 Aug 2024 14:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] util: use RETRY_ON_EINTR() on open() more consistently
To: Philipp Reisner <philipp.reisner@linbit.com>, qemu-devel@nongnu.org,
 qemu-block <qemu-block@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
References: <CAFEAcA9J37Z1JJb34zyRDo=ow0h1QgOq9bm10dCc0u5bMyQKpg@mail.gmail.com>
 <20240731151714.326879-1-philipp.reisner@linbit.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731151714.326879-1-philipp.reisner@linbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Philipp,

On 31/7/24 17:17, Philipp Reisner wrote:
> As with many syscalls, open() might be interrupted by a signal.
> 
> The call trace
> img_open_file()
>    blk_new_open()
>      raw_open()
>        raw_open_common()
>          qemu_open()
>            qemu_open_internal()
>              qemu_open_cloexec()
> 
> Ended up in calling open() without a retry loop around it.
> 
> The experienced logfile entry is:
> qemu-system-x86_64: -device virtio-blk-pci,bus=pci.0,addr=0x7,drive=libvirt-2-format,id=virtio-disk0,bootindex=2,write-cache=on,serial=1b990c4d13b74a4e90ea: Could not open '/dev/drbd1003': Interrupted system call
> 
> Add the RETRY_ON_EINTR() in qemu_open_cloexec() and remove it on
> call-sites using qemu_open_old().
> 
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> ---
>   chardev/char-fd.c   | 2 +-
>   chardev/char-pipe.c | 4 ++--
>   os-posix.c          | 2 +-
>   util/osdep.c        | 4 ++--
>   4 files changed, 6 insertions(+), 6 deletions(-)

If you need to repost, please set the next version in your patch
(which will be v4). Also avoid replying to previous version /
discussions and your patch could be missed, see
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#when-resending-patches-add-a-version-tag:

   Send each new revision as a new top-level thread, rather than
   burying it in-reply-to an earlier revision, as many reviewers
   are not looking inside deep threads for new patches.

Also please Cc qemu-block@nongnu.org since the block layer is
involved via the blk_new_open() call.

Regards,

Phil.

