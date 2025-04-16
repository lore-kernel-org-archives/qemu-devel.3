Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8F0C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ydq-000220-EA; Wed, 16 Apr 2025 05:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4ydi-0001zx-0i
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:01:05 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4yde-0005V7-VB
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:01:01 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e5dce099f4so8431190a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744794057; x=1745398857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3VElVfjX45mj1/WonUIf3ibIkb+BD4bvk0WWThnCbn4=;
 b=OnUfPYCz0SqD6FJnc+BDL93rN2BFKZSsvq+2x7P7qMg45xJHWsec1dzM1picwaWrYz
 ZVp2JqnA9yL8e6QdumsYbXkNeTk67VWyZn69WVOPmbCbU3OWN/nUAwrNQxCeBoadsL90
 cXI+deYYSTdgkiNBq4kF1RT7Z6WSDY2zIwqgXF/Un0hycFXf6c8P07/1MfB0QfrhH6GG
 6vX7R7nyPaXwifwMO0RnYeUqDmWYk/Qlr7AaDQAjIsbZcqrji4eSoTUjWvPgJgsDMjeM
 Q6fH2jTmCP88HN9rzadBCeoqtZDzt4ZXHmUWNNUhSrxnTVFyGgsyJR+yOBjCvcz2jMFa
 B+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744794057; x=1745398857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3VElVfjX45mj1/WonUIf3ibIkb+BD4bvk0WWThnCbn4=;
 b=mxRSDSJHXS9SkrxkorkRU2rfAXSDhN6FI2ERJu3df1PrlHjs879P5NZzD71rblQei6
 8NpzFPtij77n0LaA3syUFYCsQ60iW3tj+hSlL543u9xb90gXJqmRRyl1SgUTmUQVe4qw
 ghe6n0U/Y1SfWf4YkdFzQrwYPBpQHjYWaMldeeG5kwnfG8xu5bTgPaXh1kUs0wo/K6c/
 Dh0CJyZ1f7yds6/gY9+CEGB+Q0lC49jRxx/H4s0b4pbOOO0gojXDfkDNCrRAQ8K3pC2y
 qzj/GJsdnUoau37kFEy4ykciqb+UqUi/uN2cNWa0cEzCCRZ69FHvyWg+3GAbu0lvHBkk
 bAcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLHFnWJOWOXetecZS7v2PNcOHZ+O9KDJyB7waxlOmWLn+r1lbqhErO5YtmlJ1Wp8X22QoAtYAme6FV@nongnu.org
X-Gm-Message-State: AOJu0YzZ08TXR8TOKUsKuSWvDTUUExAfz5z1Tpfp+Xv/jWD+w6AuYl3x
 9/lbDCakuFjdvyS9An3g6gIvOCny0hpfH1zk2y9bSfkk/fF3BAqnO/tHQYMAbkA=
X-Gm-Gg: ASbGncsMDuhBEZP75C1dWY5ZFhIIKhQnv0u177FzGkrOexA4Cm/JcMYCD7zyAtRnQxW
 nhd0Jvz5FsQNGPQ25Fs8S1niCPWtlDju7MovQEnyS74WjTwNq2otd9IYxAg6hFs80U39i/rNpbI
 vsgdDssYewZ1XQjHjpthzoLl54KKh50Rq7tJITk93wpQy4QY5OCX/rFmMoT5osASV6XK0tiii4W
 dKBfEJkv0m9wsZrucrJOYDreFpGIVOsTxpOMfi2oIEXOdYXtWcttVrzOmhsMyxgMUzgrTGullqs
 LyeDld/UMb6A2SEjV2Da9/92/JnWz9yDP+FaPWQ10cC27mBN76PndzaEcLOoMw/E59SGSGh7beK
 Onkki1FcSEZW26g==
X-Google-Smtp-Source: AGHT+IGj+IC3tfxmH1L1LTV5Ido32LezNB1aM4TK4otxy0m+9SPby/MHE4nVYKb49xBdsNXucqxxqg==
X-Received: by 2002:a05:6402:4407:b0:5e5:e396:3f6e with SMTP id
 4fb4d7f45d1cf-5f4b75dcfe1mr962378a12.26.1744794056842; 
 Wed, 16 Apr 2025 02:00:56 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f36ef56376sm8046360a12.19.2025.04.16.02.00.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 02:00:56 -0700 (PDT)
Message-ID: <afe0abf1-2c33-47d8-bde6-8abc722eb212@linaro.org>
Date: Wed, 16 Apr 2025 11:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] block: Update block to compile with Emscripten
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <9da41d784991f77e2c1f38d0781cd047b593e053.1744787186.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9da41d784991f77e2c1f38d0781cd047b593e053.1744787186.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 16/4/25 10:14, Kohei Tokunaga wrote:
> emscripten exposes copy_file_range declaration but doesn't provide the
> implementation in the final link. Define the emscripten-specific stub
> function to avoid type conflict with the emscripten's header.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   block/file-posix.c |  6 ++++++
>   stubs/emscripten.c | 13 +++++++++++++
>   2 files changed, 19 insertions(+)
>   create mode 100644 stubs/emscripten.c
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 56d1972d15..22e0ed5069 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -110,6 +110,10 @@
>   #include <sys/diskslice.h>
>   #endif
>   
> +#ifdef EMSCRIPTEN
> +#include <sys/ioctl.h>
> +#endif
> +
>   /* OS X does not have O_DSYNC */
>   #ifndef O_DSYNC
>   #ifdef O_SYNC
> @@ -2010,6 +2014,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
>       return handle_aiocb_write_zeroes(aiocb);
>   }
>   
> +#ifndef EMSCRIPTEN
>   #ifndef HAVE_COPY_FILE_RANGE
>   static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>                                off_t *out_off, size_t len, unsigned int flags)
> @@ -2023,6 +2028,7 @@ static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>   #endif
>   }
>   #endif
> +#endif
>   
>   /*
>    * parse_zone - Fill a zone descriptor
> diff --git a/stubs/emscripten.c b/stubs/emscripten.c
> new file mode 100644
> index 0000000000..2157d6349b
> --- /dev/null
> +++ b/stubs/emscripten.c
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#include "qemu/osdep.h"
> +/*
> + * emscripten exposes copy_file_range declaration but doesn't provide the
> + * implementation in the final link. Define the stub here but avoid type
> + * conflict with the emscripten's header.
> + */
> +ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
> +                             off_t *out_off, size_t len, unsigned int flags)
> +{
> +    errno = ENOSYS;
> +    return -1;
> +}

I'd include in this patch this hunk from patch 17:

-- >8 --
diff --git a/stubs/meson.build b/stubs/meson.build
index 63392f5e78..4fd4d362f9 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -89,3 +89,7 @@ if have_system or have_user
    stub_ss.add(files('hotplug-stubs.c'))
    stub_ss.add(files('sysbus.c'))
  endif
+
+if host_os == 'emscripten'
+  stub_ss.add(files('emscripten.c'))
+endif
---

