Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76269C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4yvd-0003zx-V9; Wed, 16 Apr 2025 05:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4yv7-0003qi-JB
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:19:03 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4yv3-00008J-3H
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:19:01 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e6ff035e9aso11953874a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744795133; x=1745399933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=opxX0AnLU8z4IF4WKw6Y3YI4gcZ8WAb/hd2WUxU844M=;
 b=jCU5kfYqI4C3BMWBbvIHIwmvX9oHHK6qfSNhuZknDki+EDlyZRT/W3xj5RDYzgajZE
 nRZOcoDBeYxNRsnnV5UN5aiGlkK/JV9Kq9RkK2FsbmqLa46kRGHOZs0F+I0eVjCJh06n
 sOhxR3z9metHkjx3zU1Je0Om2sOp35UATP7S5rRwEt6gMOFVC17+dXRtwmg5bHnUJVDx
 /GcK4ZwlvK5b48uEa8ppzdPoto/w5gmoZQpBWwTeaTQsV/f7cWQTiQ/6r2VBxRqqYPpv
 RuppnQreMsHM8CC2A6vG/GXjW4Vc/zuw7VZCgfi5YPZ10XU4mLxqATPlE7m3RFzF46e8
 E96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744795133; x=1745399933;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=opxX0AnLU8z4IF4WKw6Y3YI4gcZ8WAb/hd2WUxU844M=;
 b=cQZnOKSpVI494mimEQJGvUPFxJ+keWhTvymmuB0C/941WEjV9Gf1427h3BcMxXKmAH
 kYLLk8M26HhGDgUS2eVxFUqXieWxN/FHXReKqXBcoxe3DVTYzx10rGReyDV4sZLQe+SO
 4WqW1VsmPhPxQfVVinVhdRYozOhar6LCKvfY1mqqC91HKTAR7DzLfbZ2ktg+BqTtTysv
 HOBExVdqMpB58zB8CNgTp2hEOa25HCtfBn2Mj1j6rpgpsKeimTH5BxRcGliz6uc5YNv+
 Nc7zJaGSlnfRG3gr/8XfD6mxvp++oWOI7LIH217cofcvY1zM+vxnKcy1K5yqjVnGdRh+
 vRkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs+rcOy+9Umdiyyn37UJl5iLWdOwV+JLo7jwYLWHPEeUrSOdvnFW+Se6yJP/QcNesbGcPKGAupkMff@nongnu.org
X-Gm-Message-State: AOJu0YyW8TbPGSFosGQV2x8g8eZzO11GoX65EVlhuobllA4bKeSq7XsA
 O/w3NCobb64DcO4rImjjui63m+sUX4e957rAJTNO/5tVsVkSzNVrdqPTcVjeMbM=
X-Gm-Gg: ASbGnctHxwmOD+JbDqed1KU1sSDJMZBhtPIFmRVvpKiPQTyyFjWzd+YOSQPC9JmTO0x
 9V7UvEy8UhYPxMrpCPPv4768NIerTcKr6txHR2pQD0gR7emvflbskBcEzYFiGtUmyZ9wBQs25Ky
 deiHgjpnBkc8jQgBrT39J/7jBTTXX/Iht4VBO6yBK/hcHnra5MM28rjEEe9nvfygKVEbXtJIBnB
 EIwyGCL4SGR5LWqePUbbB26+vwUXwRQB5DTsCpAPgHETActbWhGrJXQtuHw6PwagMDUNlXCPiBd
 DGPz72LR5U3tLC97n7aOKFK3xWrTjdG38fnSK59kSSxnoIgTZi7i2HKqWf7SSSqgX8eSujuL+eN
 arLDk6EvQJAwcBA==
X-Google-Smtp-Source: AGHT+IGr1/MfO5wsf3tA/3dnOJoLlld+cE6SoujA4jBiRHSd8qF8sSM327OsefaPiZzkZU94UvLfag==
X-Received: by 2002:a05:6402:1e91:b0:5ec:9352:7b20 with SMTP id
 4fb4d7f45d1cf-5f4b6dfb88dmr896220a12.0.1744795133486; 
 Wed, 16 Apr 2025 02:18:53 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f36f50569fsm8393804a12.52.2025.04.16.02.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 02:18:52 -0700 (PDT)
Message-ID: <a92737eb-786d-4ebc-87df-a5518417195c@linaro.org>
Date: Wed, 16 Apr 2025 11:18:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] util/mmap-alloc: Add qemu_ram_mmap implementation
 for emscripten
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
 <7ef485c860a0c26d2ddcf6a96430f5443deb5aee.1744787186.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7ef485c860a0c26d2ddcf6a96430f5443deb5aee.1744787186.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   util/mmap-alloc.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index ed14f9c64d..91f33682e8 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -145,6 +145,7 @@ static bool map_noreserve_effective(int fd, uint32_t qemu_map_flags)
>       return false;
>   }
>   
> +#ifndef EMSCRIPTEN
>   /*
>    * Reserve a new memory region of the requested size to be used for mapping
>    * from the given fd (if any).
> @@ -176,6 +177,7 @@ static void *mmap_reserve(size_t size, int fd)
>   
>       return mmap(0, size, PROT_NONE, flags, fd, 0);
>   }
> +#endif
>   
>   /*
>    * Activate memory in a reserved region from the given fd (if any), to make
> @@ -244,6 +246,21 @@ static inline size_t mmap_guard_pagesize(int fd)
>   #endif
>   }
>   
> +#ifdef EMSCRIPTEN
> +void *qemu_ram_mmap(int fd,
> +                    size_t size,
> +                    size_t align,
> +                    uint32_t qemu_map_flags,
> +                    off_t map_offset)
> +{
> +    /*
> +     * emscripten doesn't support non-zero first argument for mmap so
> +     * mmap a larger region without the hint and return an aligned pointer.
> +     */
> +    void *ptr = mmap_activate(0, size + align, fd, qemu_map_flags, map_offset);
> +    return (void *)QEMU_ALIGN_UP((uintptr_t)ptr, align);
> +}
> +#else
>   void *qemu_ram_mmap(int fd,
>                       size_t size,
>                       size_t align,
> @@ -293,6 +310,7 @@ void *qemu_ram_mmap(int fd,
>   
>       return ptr;
>   }
> +#endif /* EMSCRIPTEN */
>   
>   void qemu_ram_munmap(int fd, void *ptr, size_t size)
>   {

Can we keep this code generic? I.e. with something in the lines
of (only build-tested):

-- >8 --
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index ed14f9c64de..0e52cce5b29 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -238,3 +238,10 @@ static inline size_t mmap_guard_pagesize(int fd)
  {
-#if defined(__powerpc64__) && defined(__linux__)
+#if defined(EMSCRIPTEN)
+    /*
+     * emscripten doesn't support non-zero first argument for mmap so we
+     * don't use any guard, returning 0 to mmap a larger region without the
+     * hint and return an aligned pointer in qemu_ram_mmap().
+     */
+    return 0;
+#elif defined(__powerpc64__) && defined(__linux__)
      /* Mappings in the same segment must share the same page size */
@@ -246,2 +253,3 @@ static inline size_t mmap_guard_pagesize(int fd)

+
  void *qemu_ram_mmap(int fd,
@@ -253,4 +261,8 @@ void *qemu_ram_mmap(int fd,
      const size_t guard_pagesize = mmap_guard_pagesize(fd);
-    size_t offset, total;
-    void *ptr, *guardptr;
+    size_t offset = 0, total;
+    void *ptr, *guardptr = NULL;
+
+    assert(is_power_of_2(align));
+    /* Always align to host page size */
+    assert(align >= guard_pagesize);

@@ -262,13 +274,11 @@ void *qemu_ram_mmap(int fd,

-    guardptr = mmap_reserve(total, fd);
-    if (guardptr == MAP_FAILED) {
-        return MAP_FAILED;
+    if (guard_pagesize) {
+        guardptr = mmap_reserve(total, fd);
+        if (guardptr == MAP_FAILED) {
+            return MAP_FAILED;
+        }
+
+        offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - 
(uintptr_t)guardptr;
      }

-    assert(is_power_of_2(align));
-    /* Always align to host page size */
-    assert(align >= guard_pagesize);
-
-    offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - 
(uintptr_t)guardptr;
-
      ptr = mmap_activate(guardptr + offset, size, fd, qemu_map_flags,
---

