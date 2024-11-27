Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33596D609BB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 09:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGEES-0002Jh-8M; Wed, 27 Nov 2024 04:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tGEEQ-0002JR-Sq
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 04:21:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tGEEO-0006fL-6g
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 04:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732699265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8ZmZfccMST1TnML1AnloB2D+alPcPvmhy2zMJiBr0J4=;
 b=HP8Zc97W9uGXMFk3JPxH60AWEDPRRS3mu3P7Llyz+XV+i9ctmf7x+DhbwusGst7wFYgySU
 uzIofEoYCplukfew9fSCGMvB8lW6TjEP/RLX46puqqMsWt7Pu0yDMw+UE3mWdsfH/QA4uv
 LOlkq4CxyCsODAZUjkaprRGl2gwryd4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-cF9AtpmeP6aN-ZYQzjdJrg-1; Wed, 27 Nov 2024 04:21:04 -0500
X-MC-Unique: cF9AtpmeP6aN-ZYQzjdJrg-1
X-Mimecast-MFC-AGG-ID: cF9AtpmeP6aN-ZYQzjdJrg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38240d9ed31so3914172f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 01:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732699263; x=1733304063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZmZfccMST1TnML1AnloB2D+alPcPvmhy2zMJiBr0J4=;
 b=g3fN9774up1nZb8flLqfx2tfwyDnDUGJL2hkSica2sHyWlPscYEOZX56DX02HC7Ir9
 au39wW+2HP8sD1wjC9/EhHLSZzZRYP8Y1IfI4zzGnoWOEMXVRs4s2QdhOU2bpUYSV4Qi
 r4QoG/z0Jv/g1KoD8w4WQ8Pm8XFQ9SfmcKj+jGC4JgdJT+ULo/XW+RzmI4edJixawjem
 Q+suwGYH2FZHSTGGauhdJ7SfiGIetrFG6Wb8zulvBOFBXmdts5RL7HMki7yGPU/qztLI
 quxaavs2r4y4W4R598dZDGJVsBCdQOyRcGjtI2bOmvX9cE6zRTz2MD/D4ptzlAFoVeCw
 lBOw==
X-Gm-Message-State: AOJu0Ywq8CzAOIKKmmyNzu4w+1o79k/LHDJRWRqOkEYVR4L+sLWpwRUK
 JHWSm6IMlmBLrdWgvN9DEQXfwOxe4pdZ+B/Uv3rSJ2h5QkJ0lf7ifwvBvtwVfU8aSmbocXiIn6f
 GYlw437s+Xn1jNYfPSS8pKVjwwiFDhZ5q85q/GyBCpzQ5rjKepPfm
X-Gm-Gg: ASbGncvoe63/UJJwDWms+wS86ZIFSoob8+OM7o/R82FEQsZgerhqggKtT6KN63QdySC
 o43Zz6kXaGJUp36Zyoz+1vz8GIDPgK9t+sxAQEn+br43l7gTxgq/QXd+9x8ywhATZu1GWC0RFIB
 Isdd5L/ksSqYB1dfRLa/PES7HH5x+ZOLxIU3+tSpt1xW3cx30mKh4XZC9P6HMSmoG35I/ZhYB9s
 q/zomuSEF/NAdDx/O9b8LLftZSNTqrUu8yOpebC68i3B9FZxXMw007XOmcODVWlaf/0UJ4ZZjzW
 GU5FsfZBZyBN5/XYVpQX03rIiw==
X-Received: by 2002:a05:6000:381:b0:382:1504:f064 with SMTP id
 ffacd0b85a97d-385c6edd7cbmr1325172f8f.42.1732699262874; 
 Wed, 27 Nov 2024 01:21:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtKh0A8bSkc73MlbeDQs+ir97IsTopcTjfBy5Xq45f5kU2yfOaatv1f5AGl53vWDObFPb50Q==
X-Received: by 2002:a05:6000:381:b0:382:1504:f064 with SMTP id
 ffacd0b85a97d-385c6edd7cbmr1325143f8f.42.1732699262284; 
 Wed, 27 Nov 2024 01:21:02 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it.
 [79.46.200.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad5fa2sm16184751f8f.1.2024.11.27.01.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 01:21:01 -0800 (PST)
Date: Wed, 27 Nov 2024 10:20:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v2 1/3] win32: remove usage of attribute gcc_struct
Message-ID: <v63qepc7jqqncwcknnu2v2ksnjxrrfe7dpugorc7ppro2soxxp@vra5v6glq2eb>
References: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
 <20241126211736.122285-2-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241126211736.122285-2-pierrick.bouvier@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

On Tue, Nov 26, 2024 at 01:17:34PM -0800, Pierrick Bouvier wrote:
>This attribute is not recognized by clang.
>
>An investigation has been performed to ensure this attribute has no
>effect on layout of structures we use in QEMU [1], so it's safe to
>remove now.
>
>In the future, we'll forbid introducing new bitfields in packed struct.

Why?
I suggest reporting in this commit description what you wrote in the
following patch in the documentation (or a summary), because at first
glance I could not understand the correlation between removing
gcc_struct and bitfields in packed struct.

>
>[1] https://lore.kernel.org/qemu-devel/66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org/
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---
> meson.build                               | 5 -----
> include/qemu/compiler.h                   | 7 +------
> scripts/cocci-macro-file.h                | 6 +-----
> subprojects/libvhost-user/libvhost-user.h | 6 +-----
> 4 files changed, 3 insertions(+), 21 deletions(-)

The patch LGTM.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/meson.build b/meson.build
>index e0b880e4e13..fa6d24e1233 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -354,11 +354,6 @@ elif host_os == 'sunos'
>   qemu_common_flags += '-D__EXTENSIONS__'
> elif host_os == 'haiku'
>   qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
>-elif host_os == 'windows'
>-  if not compiler.compiles('struct x { int y; } __attribute__((gcc_struct));',
>-                           args: '-Werror')
>-    error('Your compiler does not support __attribute__((gcc_struct)) - please use GCC instead of Clang')
>-  endif
> endif
>
> # Choose instruction set (currently x86-only)
>diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>index c06954ccb41..d904408e5ed 100644
>--- a/include/qemu/compiler.h
>+++ b/include/qemu/compiler.h
>@@ -22,12 +22,7 @@
> #define QEMU_EXTERN_C extern
> #endif
>
>-#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>-# define QEMU_PACKED __attribute__((gcc_struct, packed))
>-#else
>-# define QEMU_PACKED __attribute__((packed))
>-#endif
>-
>+#define QEMU_PACKED __attribute__((packed))
> #define QEMU_ALIGNED(X) __attribute__((aligned(X)))
>
> #ifndef glue
>diff --git a/scripts/cocci-macro-file.h b/scripts/cocci-macro-file.h
>index d247a5086e9..c64831d5408 100644
>--- a/scripts/cocci-macro-file.h
>+++ b/scripts/cocci-macro-file.h
>@@ -23,11 +23,7 @@
> #define G_GNUC_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
> #define G_GNUC_NULL_TERMINATED __attribute__((sentinel))
>
>-#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>-# define QEMU_PACKED __attribute__((gcc_struct, packed))
>-#else
>-# define QEMU_PACKED __attribute__((packed))
>-#endif
>+#define QEMU_PACKED __attribute__((packed))
>
> #define cat(x,y) x ## y
> #define cat2(x,y) cat(x,y)
>diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
>index deb40e77b3f..2ffc58c11b1 100644
>--- a/subprojects/libvhost-user/libvhost-user.h
>+++ b/subprojects/libvhost-user/libvhost-user.h
>@@ -186,11 +186,7 @@ typedef struct VhostUserShared {
>     unsigned char uuid[UUID_LEN];
> } VhostUserShared;
>
>-#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>-# define VU_PACKED __attribute__((gcc_struct, packed))
>-#else
>-# define VU_PACKED __attribute__((packed))
>-#endif
>+#define VU_PACKED __attribute__((packed))
>
> typedef struct VhostUserMsg {
>     int request;
>-- 
>2.39.5
>


