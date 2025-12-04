Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21844D1D892
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 08:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4ok-00041q-RT; Thu, 04 Dec 2025 03:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4og-0003ut-NA
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:36:01 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4oe-0005lT-Tc
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:35:58 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779d47be12so5851255e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 00:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764837355; x=1765442155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hkgbVZHn6iJRkRIe9EULExstxnB4Rbm6N2KP0S57IfI=;
 b=ogLwX2MqXWD4YduehzIU0L0bygDHXGWDl6QfTnEH8ahtn4B/AejKHRrjDLAZDrKdTz
 ScK2WtBjuCucwx09DjF4xA2IZQUXnioclJyHTO5cmuw6UBvxtV+/b9VBvDtZNck+fZ5a
 YxnHUsPyN6bFlSOw78eWS2rPRfTMAnDum1uPRHtfTiIFxnKZj+dAfETlsfWQNG7Jy2hq
 I7Tdkj2gq5G/0Z3v+eIn4QOnP/0xYsxnZvid10vAF6105/CAeSb+9HW8gTookf2NxzUK
 WMS6ohYWJwrDVC2cX7Bb5lJGp3h8Up6gK0SHbV/lHlzYhZCp4sTxAWjryN2el3FcN1bQ
 YDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764837355; x=1765442155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hkgbVZHn6iJRkRIe9EULExstxnB4Rbm6N2KP0S57IfI=;
 b=roINHA1fw1yFsUWHCpRlvakPMkw/EdxJwGu1ueMWZff4crHA4i1h4RiSHd1oOg91R1
 4Kd5I/u+bcppNnGpSnAEvx/2FZcsXwPqt9xEq8qs8nb0KyObYV7DzM5e9YPHVMTeDTUx
 JaAuVxbDRHXxlPbx1BDulCMYep+cpgJdQCu7rhA0pOPHkaSP55jBXZM0Tx2CCv+6fCJG
 LwR2UAdlee9GSrLK/tceLkHxUK74W0vBbwWp5F3lBPL1XUSBJ/FS7UI4LlkSOsZb4bZn
 +eoBWbVtZ5rTfKQWbm2JjWc7keEh+ESlcoH4O6hT2ZvOzLNE2xk02dBiFhuHjXC/Ni2y
 B7qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP6OM3M+VKpxjAyRZMIDt8g4hU5QAXMBmtExETR+pn0oCpO+Fqh4LdHeBggyQiPLG5ObouKzZIeMCV@nongnu.org
X-Gm-Message-State: AOJu0YxIZ2x6fsdieusYVaTQS3VnJw6hODhbT+mVzoCG8wxItKHHydgf
 UAUDxQzRLlTSxT8nwQ8wqMbqYcIv27DfDBlk6mGC5nytP4Ts4ihjRXsJ8h4dp66y238=
X-Gm-Gg: ASbGncu0XwaDgjap2LdHLkic/mLPpWaeLYwL1mHFpkD4A6b+h4IqL/8lxbwouAlzYOh
 jgtP+Nlipk+DQSmYsN1vfZYwbKsIF3ED6DFbWo5gl/V0IEQpkwKW/m959r49YjUOyyuumWDsP8K
 HrzY1pizdQL7QvpsGRYmkhV13N6d2QOpbogtJiFvtWFoz9LpLrxEy2eE5nrEDt6k4bvW9w4MITz
 CNbTcxni5OrUuc5Br/tsAseMnradr4zg/ZymyUxIYakiOLLHXRY2FwzeSm72V0YsOMOw5akEe0j
 U0a/jWR91sEdIVogJzWik8Hbs5CMSGexukC/MD5xRvZvmE5xWW625JS03z5BX63s8G7xtrS61d4
 qQq7xxzIK+0G6LaHVGPKZItodZPBUk4wC6WqkWy1eVKIBAYga6tSTzVw4H+z9nof9D1WoKH/Ol9
 ssxmg9GoIoHhQ7TtJXVFXxjbzKo6xdDYCXah1aItK+zfuyHdKcVsIRvA==
X-Google-Smtp-Source: AGHT+IHIyNuL2yl8iMY1pJn/ReBnqvb8mXV1f1f0UZTa967ZK10Hljg2+u+mizKYTcKUKwK4Ey6ROQ==
X-Received: by 2002:a05:6000:220e:b0:42b:2e65:655f with SMTP id
 ffacd0b85a97d-42f7317da33mr4991222f8f.19.1764837355248; 
 Thu, 04 Dec 2025 00:35:55 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331df0sm1944282f8f.36.2025.12.04.00.35.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 00:35:54 -0800 (PST)
Message-ID: <1290719a-43af-4ff1-9f84-0668047ec513@linaro.org>
Date: Thu, 4 Dec 2025 09:35:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] block: rename block/aio.h to qemu/aio.h
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.omc
References: <20251203185133.2458207-1-pbonzini@redhat.com>
 <20251203185133.2458207-5-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203185133.2458207-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 3/12/25 19:51, Paolo Bonzini wrote:
> AioContexts are used as a generic event loop even outside the block
> layer; move the header file out of block/ just like the implementation
> is in util/.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   MAINTAINERS                       | 2 +-
>   docs/devel/multiple-iothreads.rst | 4 ++--
>   include/block/aio-wait.h          | 2 +-
>   include/block/raw-aio.h           | 2 +-
>   include/block/thread-pool.h       | 2 +-
>   include/hw/scsi/scsi.h            | 2 +-
>   include/hw/virtio/virtio.h        | 2 +-
>   include/io/channel.h              | 2 +-
>   include/{block => qemu}/aio.h     | 0
>   include/qemu/job.h                | 2 +-
>   include/qemu/main-loop.h          | 2 +-
>   include/qemu/throttle.h           | 2 +-
>   include/scsi/pr-manager.h         | 2 +-
>   include/system/event-loop-base.h  | 2 +-
>   include/system/iothread.h         | 2 +-
>   include/system/replay.h           | 2 +-
>   tests/unit/iothread.h             | 2 +-
>   util/aio-posix.h                  | 2 +-
>   block/aio_task.c                  | 2 +-
>   block/export/fuse.c               | 2 +-
>   block/io_uring.c                  | 2 +-
>   block/linux-aio.c                 | 2 +-
>   block/win32-aio.c                 | 2 +-
>   iothread.c                        | 2 +-
>   qapi/qmp-dispatch.c               | 2 +-
>   replay/replay-events.c            | 2 +-
>   scsi/pr-manager.c                 | 2 +-
>   stubs/linux-aio.c                 | 2 +-
>   stubs/replay-tools.c              | 2 +-
>   tests/unit/iothread.c             | 2 +-
>   tests/unit/test-aio-multithread.c | 2 +-
>   tests/unit/test-aio.c             | 2 +-
>   tests/unit/test-nested-aio-poll.c | 2 +-
>   tests/unit/test-thread-pool.c     | 2 +-
>   tests/unit/test-throttle.c        | 2 +-
>   util/async.c                      | 2 +-
>   util/main-loop.c                  | 2 +-
>   util/qemu-co-timeout.c            | 2 +-
>   util/qemu-coroutine-lock.c        | 2 +-
>   util/qemu-coroutine-sleep.c       | 2 +-
>   util/qemu-coroutine.c             | 2 +-
>   util/throttle.c                   | 2 +-
>   scripts/analyze-inclusions        | 2 +-
>   43 files changed, 43 insertions(+), 43 deletions(-)
>   rename include/{block => qemu}/aio.h (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


