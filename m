Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5C6C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFLt-0003cT-DD; Mon, 14 Jul 2025 05:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubF7b-0003DU-VG
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubF7Z-0006wR-Kh
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752483911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3kR6AprqenTMfhoWDA+lFCsBWj2eHNgKoPQx1lOdUk=;
 b=ZU08YYuOrNDJBVdvG9mI4T+A897fbVPY8Q+bvZTg02aXuQNfLkhzgzYB4D/kydIPJ3ypwx
 5apNGoQGnGHobPSu/2JNUO78x8GGeDqV5MQ0S5ny2gkyatU4QkTUXXRsPk5f9YyOVUYWbl
 v76ME4NM3d27cmNX+Y0H3Bzedp/CEAE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375--gBHF0fJOoava2XFx2Zpag-1; Mon, 14 Jul 2025 05:05:09 -0400
X-MC-Unique: -gBHF0fJOoava2XFx2Zpag-1
X-Mimecast-MFC-AGG-ID: -gBHF0fJOoava2XFx2Zpag_1752483908
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso31249495e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 02:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752483908; x=1753088708;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S3kR6AprqenTMfhoWDA+lFCsBWj2eHNgKoPQx1lOdUk=;
 b=o81oAvYjva1fruKA3MAOQCAbcLXPnGwhzCbQ5sJbYFCGsOHWUPLVFvgyL7+eIvpMO6
 qQS7DOGYASwEzgTS2WBYGGBiJucAxskhYkCaZDChy2n/a9i0lYpUrXvWUB7p1aGBgQG9
 D5Ma48y6AJvqYbuZEPn1QRkV+VGKDt5tWhBx/VZ/9/GStWjh0XDHPs6Od550Rpr8TeiC
 Rxrz08nArVw23EmIaQC24XeOos9YFMXHGZoz0WMYMXcHq7JEPRm2T0t8BQqfuKw1/UH3
 UtzclLWYPAQ0AgcAyF0EoH0Psy/0y9GD21FqS2jODiyu26EMpZzp8f92CphUGjG8G6Iu
 ZZog==
X-Gm-Message-State: AOJu0YwnVtkxifVSQwOHe5KUUv3J2O5wk9+hpHl34uJNheKwinGC56Rs
 P45urCZxCJ8O7LqP9u1shtgCeZ+Gai2J0zw0blx53wBd99lHiKPLeiWSiMCEWdW+TgwZyr/Gzvm
 t8u+vAzPI31AT7Nzg2ed5S231rooqFrpNJ5Upmk7AvDEiDnux9a+VnbF5
X-Gm-Gg: ASbGncuVjmWgrxlBZRLEZA2AFdtLWGjJwEzB3By+f/tquQX46QCoiOHznKb5SH905Vq
 3j3xGLk0vshvyGQJI7YzlcCX32ypJGd/qdcGr846llPLeha7dy3N6MrQEdYMV8dwlRFhMJt6awx
 b/X18WWSPUlaKUjIZ4fFkznUowAy17gNw36YRo4UqBxDC9xhwurPWiuAZN7u2yfHXJNRHa40Z5h
 BB/dDIOtHi185+6/FcMEVWh5BbDQfk5tgwHU7ZhUnFQ53F7dfq51JU0HwnkMhsX9DGIhswY1l3i
 1i5bf0O2AbD34lfThXKTAMP7whvP2UbeaJy6/dFtAwE=
X-Received: by 2002:a05:600c:3155:b0:454:ab87:a0a0 with SMTP id
 5b1f17b1804b1-454f4257f20mr124091925e9.17.1752483907938; 
 Mon, 14 Jul 2025 02:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkbz6uXPs7gRwumu+oXnhywRFmZssnK+9l+dRhoRg4fij/TNvrG1p+a03pPIjsrexl0/fVMw==
X-Received: by 2002:a05:600c:3155:b0:454:ab87:a0a0 with SMTP id
 5b1f17b1804b1-454f4257f20mr124091515e9.17.1752483907406; 
 Mon, 14 Jul 2025 02:05:07 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d5easm11719286f8f.48.2025.07.14.02.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 02:05:06 -0700 (PDT)
Message-ID: <b745cfee-5e29-431a-8a3d-070c47e3f0a3@redhat.com>
Date: Mon, 14 Jul 2025 11:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/13] virtio: introduce support for GSO over UDP
 tunnel
To: Lei Yang <leiyang@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <CAPpAL=y4e=+H2rxHwwgbGvU+x10aTDVZ7ix+2YqVC3e6hd6L7g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAPpAL=y4e=+H2rxHwwgbGvU+x10aTDVZ7ix+2YqVC3e6hd6L7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/14/25 10:43 AM, Lei Yang wrote:
> Does the compile of this series of patches require support for a
> special kernel environment? I hit a compile issue after applied you
> patches:
> [1440/2928] Compiling C object libsystem.a.p/hw_virtio_vhost.c.o
> FAILED: libsystem.a.p/hw_virtio_vhost.c.o
> cc -m64 -Ilibsystem.a.p -I. -I.. -Isubprojects/dtc/libfdt
> -I../subprojects/dtc/libfdt -Isubprojects/libvduse
> -I../subprojects/libvduse -Iui -Iqapi -Itrace -Iui/shader
> -I/usr/include/pixman-1 -I/usr/include/glib-2.0
> -I/usr/lib64/glib-2.0/include -I/usr/include/libmount
> -I/usr/include/blkid -I/usr/include/sysprof-6
> -I/usr/include/gio-unix-2.0 -I/usr/include/slirp
> -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O0 -g
> -fstack-protector-strong -Wempty-body -Wendif-labels
> -Wexpansion-to-defined -Wformat-security -Wformat-y2k
> -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self
> -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
> -Wold-style-declaration -Wold-style-definition -Wredundant-decls
> -Wshadow=local -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
> -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
> -Wno-shift-negative-value -isystem
> /mnt/tests/distribution/command/qemu/linux-headers -isystem
> linux-headers -iquote . -iquote /mnt/tests/distribution/command/qemu
> -iquote /mnt/tests/distribution/command/qemu/include -iquote
> /mnt/tests/distribution/command/qemu/host/include/x86_64 -iquote
> /mnt/tests/distribution/command/qemu/host/include/generic -iquote
> /mnt/tests/distribution/command/qemu/tcg/i386 -pthread -mcx16 -msse2
> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero
> -fzero-call-used-regs=used-gpr -fPIE -DWITH_GZFILEOP -DCONFIG_SOFTMMU
> -DCOMPILING_SYSTEM_VS_USER -MD -MQ libsystem.a.p/hw_virtio_vhost.c.o
> -MF libsystem.a.p/hw_virtio_vhost.c.o.d -o
> libsystem.a.p/hw_virtio_vhost.c.o -c ../hw/virtio/vhost.c
> ../hw/virtio/vhost.c: In function ‘vhost_dev_set_features’:
> ../hw/virtio/vhost.c:38:9: error: ‘r’ may be used uninitialized
> [-Werror=maybe-uninitialized]
>    38 |         error_report(fmt ": %s (%d)", ## __VA_ARGS__, \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    39 |                      strerror(-retval), -retval); \
>       |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../hw/virtio/vhost.c:1006:9: note: in expansion of macro ‘VHOST_OPS_DEBUG’
>  1006 |         VHOST_OPS_DEBUG(r, "extended features without device support");
>       |         ^~~~~~~~~~~~~~~
> ../hw/virtio/vhost.c:989:9: note: ‘r’ was declared here
>   989 |     int r;
>       |         ^
> cc1: all warnings being treated as errors
> ninja: build stopped: subcommand failed.
> make[1]: *** [Makefile:168: run-ninja] Error 1
> make[1]: Leaving directory '/mnt/tests/distribution/command/qemu/build'
> make[1]: Entering directory '/mnt/tests/distribution/command/qemu/build'
> [1/1493] Generating subprojects/dtc/version_gen.h with a custom command
> [2/1493] Generating qemu-version.h with a custom command (wrapped by
> meson to capture output)
> [3/1492] Compiling C object libsystem.a.p/hw_virtio_vhost.c.o
> FAILED: libsystem.a.p/hw_virtio_vhost.c.o
> cc -m64 -Ilibsystem.a.p -I. -I.. -Isubprojects/dtc/libfdt
> -I../subprojects/dtc/libfdt -Isubprojects/libvduse
> -I../subprojects/libvduse -Iui -Iqapi -Itrace -Iui/shader
> -I/usr/include/pixman-1 -I/usr/include/glib-2.0
> -I/usr/lib64/glib-2.0/include -I/usr/include/libmount
> -I/usr/include/blkid -I/usr/include/sysprof-6
> -I/usr/include/gio-unix-2.0 -I/usr/include/slirp
> -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O0 -g
> -fstack-protector-strong -Wempty-body -Wendif-labels
> -Wexpansion-to-defined -Wformat-security -Wformat-y2k
> -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self
> -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
> -Wold-style-declaration -Wold-style-definition -Wredundant-decls
> -Wshadow=local -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
> -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
> -Wno-shift-negative-value -isystem
> /mnt/tests/distribution/command/qemu/linux-headers -isystem
> linux-headers -iquote . -iquote /mnt/tests/distribution/command/qemu
> -iquote /mnt/tests/distribution/command/qemu/include -iquote
> /mnt/tests/distribution/command/qemu/host/include/x86_64 -iquote
> /mnt/tests/distribution/command/qemu/host/include/generic -iquote
> /mnt/tests/distribution/command/qemu/tcg/i386 -pthread -mcx16 -msse2
> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero
> -fzero-call-used-regs=used-gpr -fPIE -DWITH_GZFILEOP -DCONFIG_SOFTMMU
> -DCOMPILING_SYSTEM_VS_USER -MD -MQ libsystem.a.p/hw_virtio_vhost.c.o
> -MF libsystem.a.p/hw_virtio_vhost.c.o.d -o
> libsystem.a.p/hw_virtio_vhost.c.o -c ../hw/virtio/vhost.c
> ../hw/virtio/vhost.c: In function ‘vhost_dev_set_features’:
> ../hw/virtio/vhost.c:38:9: error: ‘r’ may be used uninitialized
> [-Werror=maybe-uninitialized]
>    38 |         error_report(fmt ": %s (%d)", ## __VA_ARGS__, \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    39 |                      strerror(-retval), -retval); \
>       |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../hw/virtio/vhost.c:1006:9: note: in expansion of macro ‘VHOST_OPS_DEBUG’
>  1006 |         VHOST_OPS_DEBUG(r, "extended features without device support");
>       |         ^~~~~~~~~~~~~~~
> ../hw/virtio/vhost.c:989:9: note: ‘r’ was declared here
>   989 |     int r;
>       |         ^
> cc1: all warnings being treated as errors
> ninja: build stopped: subcommand failed.
> make[1]: *** [Makefile:168: run-ninja] Error 1
> make[1]: Leaving directory '/mnt/tests/distribution/command/qemu/build'

Thank you for reporting the problem.

No special kernel requirement to build the series, the above is just a
gross mistake on my side in patch 7/13. If you want to test the series,
please apply incrementally the following diff.

What baffles me is that gcc 14.3.1 and 11.5.0 are not raising the
warning (that looks legit/correct) here.

I'll fix the above in the next revision.

Note that you need a running kernel based on current net-next tree in
both the hypervisor and the guest to actually leverage the new feature.

Thanks,

Paolo
---
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2eee9b0886..c4eab5ce08 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1003,8 +1003,8 @@ static int vhost_dev_set_features(struct vhost_dev
*dev,

     if (virtio_features_use_extended(features) &&
         !dev->vhost_ops->vhost_set_features_ex) {
-        VHOST_OPS_DEBUG(r, "extended features without device support");
         r = -EINVAL;
+        VHOST_OPS_DEBUG(r, "extended features without device support");
         goto out;
     }


