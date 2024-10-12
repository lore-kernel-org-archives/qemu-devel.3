Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD0BD1A431
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 07:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szW6s-0005mN-AF; Sat, 12 Oct 2024 03:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szW6o-0005m9-GW
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 03:00:14 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szW6h-0008Bu-R8
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 03:00:13 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20cb7088cbcso6246505ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 00:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728716406; x=1729321206;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V/x8ylieZ3pJFBks2PjrJhcV7QIQZP1C7HKTU/rWtQ8=;
 b=umRXL7ZtnZUEqS1wtYhrULBJOzso6jqd1JmkJ0nAvjUM24LoI5kkWQHtcuGj56tT72
 2GelwEkzvz/F+xFKpbi4YSy3JqPOb2sBSt77MXxCFY8bSpcq/9cT20sDpKXofuH7pMkK
 ooNGR1sFesg32RH2pDpnNvvJhAnJPWom4FkLB7cDz96sTS+3ANwHUxQCzEETM9ozZTe5
 Ykl3A0eLrlBaaPC4CpBcsoHo9hTfEbQVpeOWDf/FkfCjJYkSiedf/NZ8owzqUGm2UvcZ
 +7zUFkhJRvMPJUAB4lq9E4TPZ7v31G3QSW037j0XVh/zla9ZZFW5LkRyLUCVK7yERhJ9
 8EfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728716406; x=1729321206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V/x8ylieZ3pJFBks2PjrJhcV7QIQZP1C7HKTU/rWtQ8=;
 b=EbS5QViLWfhu4yUWmusGFfhYLOA8O3VJKMR57gicfqHJfCztfOfQP5JHHrKLt2F2ha
 WMj+QY+GgJna9pSqNkO2IbxNLqS3vhFM5V8AYlzCQq4PtaXqoG/VY8zwDml9Fn52VM0P
 eJ66Bln4T+YyfK4/Egbyb4B0TUbZGn5MCdUrRECdnCE8NgRnbNUBm6V7XMOUCtbkY2G+
 Nd5sNk+N4YwC7ipIZVUnG9cLb7VeK/ytUnMxdUv5dv3k/axif448vMGOG8i2nfXENS8n
 GdDrX3VxQziChJlEqhEymQDeswQ6G7lQM8DYZMDWS8DcQAwMwiZL+ShOYUxJxJc7fnKc
 LTIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1Z97Pd0ozuqNnNowKSan8178kH9wWSSZr192LjYNI9nBomNRRwBB4M6uzH+xVmNSBBos9G93EAkYo@nongnu.org
X-Gm-Message-State: AOJu0YyS41PULT/wB6ni+IAjivZJSGFgAcnbVk5+L0S2uU27OJY8VEfz
 qHA8VGInqZXItyzOM5Y/yX13TsPFebbT2AeXhkp+UejIM8VfOJIj/M2F/fTds1Q=
X-Google-Smtp-Source: AGHT+IGxP48LdDTxKx+bI370oCGUEyjKLbFqi+rlZlX+OiZcd7vqFtbZSwSEticGSI4mooKpGRGAVA==
X-Received: by 2002:a17:902:e888:b0:20c:7a1f:96e5 with SMTP id
 d9443c01a7336-20ca16bdda2mr71924095ad.41.1728716405865; 
 Sat, 12 Oct 2024 00:00:05 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bc0133fsm32620975ad.80.2024.10.12.00.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 00:00:05 -0700 (PDT)
Message-ID: <602b3bbd-06b8-4ac5-a250-7113d83923da@daynix.com>
Date: Sat, 12 Oct 2024 16:00:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] UI-related fixes & shareable 2d memory with
 -display dbus
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, belmouss@redhat.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20241008125028.1177932-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241008125028.1177932-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/08 21:50, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> This series adds Listener.Unix.Map interface to -display dbus, to allow shared
> memory for the display (similar to Listener.Win32.Map interface).
> 
> While working on it, I collected a few fixes. I can re-send them in a different
> series or queue them once they are reviewed.
> 
> thanks
> 
> v2 (after Akhiko Odaki review):
>   - rebased
>   - introduce qemu_pixman_shareable, to reduce #ifdef usage
>   - fixed bad mmap testing
>   - fixed mingw cross-compilation
> 
> Marc-André Lureau (19):
>    hw/audio/hda: free timer on exit
>    hw/audio/hda: fix memory leak on audio setup
>    ui/dbus: fix leak on message filtering
>    ui/win32: fix potential use-after-free with dbus shared memory
>    ui/dbus: fix filtering all update messages
>    ui/dbus: discard display messages on disable
>    ui/dbus: discard pending CursorDefine on new one
>    util/memfd: report potential errors on free
>    ui/pixman: generalize shared_image_destroy
>    ui/dbus: do not limit to one listener per connection / bus name
>    ui/dbus: add trace for can_share_map
>    ui/surface: allocate shared memory on !win32
>    meson: find_program('gdbus-codegen') directly
>    ui/dbus: make Listener.Win32.Map win32-specific
>    ui/dbus: add Listener.Unix.Map interface XML
>    ui/dbus: implement Unix.Map
>    virtio-gpu: allocate shareable 2d resources on !win32
>    ui: refactor using a common qemu_pixman_shareable
>    tests: add basic -display dbus Map.Unix test
> 
>   meson.build                     |   2 +-
>   include/hw/virtio/virtio-gpu.h  |   4 +-
>   include/ui/qemu-pixman.h        |  24 +++++
>   include/ui/surface.h            |  14 ++-
>   hw/audio/hda-codec.c            |  33 ++++---
>   hw/display/virtio-gpu.c         |  69 ++++----------
>   tests/qtest/dbus-display-test.c |  72 ++++++++++++++-
>   ui/console.c                    |  78 ++++++----------
>   ui/dbus-console.c               |  23 +----
>   ui/dbus-listener.c              | 159 ++++++++++++++++++++++++++++----
>   ui/qemu-pixman.c                |  71 ++++++++++++++
>   util/memfd.c                    |   9 +-
>   ui/dbus-display1.xml            |  49 ++++++++++
>   ui/trace-events                 |   1 +
>   14 files changed, 440 insertions(+), 168 deletions(-)
> 

For the whole series:
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

