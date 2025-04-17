Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DBEC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 21:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5WN4-0001Oz-8Z; Thu, 17 Apr 2025 17:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u5WMz-0001Mj-9T
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u5WMx-0001PZ-2Q
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744923716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iuGeuYTWQf49ryKPim08WmYHbuSwuV1YiLJdq2lG3hM=;
 b=XtDQ/MyCoTMM1MoQrenwYUeWHS7+GX9jKWhfgLY/lBaFawQi99Du/jrswExbO/h/ETG3fA
 SffmsyXiE0YKo/CWfgU+JSmzQBccTrm4OSX7onLAHs7P8lp33JnakbRZzJTzkNRuGPMwBY
 gIT//ajAmaE1o6ejAXWdPdZ0OIW7jZg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-XAIzGxezMu2XDviNodS7Ow-1; Thu, 17 Apr 2025 17:01:55 -0400
X-MC-Unique: XAIzGxezMu2XDviNodS7Ow-1
X-Mimecast-MFC-AGG-ID: XAIzGxezMu2XDviNodS7Ow_1744923714
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so4773545e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 14:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744923714; x=1745528514;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iuGeuYTWQf49ryKPim08WmYHbuSwuV1YiLJdq2lG3hM=;
 b=dYOo9K06ZpM+PM5yOoocrPcLU0C2pkbTpDWWnJyra08xDaBbbSe3NgcK7rE/2NBldJ
 7uOTcrn1H8NFFgoo9r4TO8R7LeSBx3hQICgdr3qMby+RaeBaih8D1Dy52WrvOT08cbg5
 7KFPSZyyuHs4JVr/9L/3zrUHUkhY/d2BC9EU+M5CNlxTVL+ZNCP13MW179sb6jNJTzm7
 N76KXmUcicUGYJXkXBorZZNfCN6r0MDnKfdpAqENhnkywQemqvMJhwWNyZPAz3VMVd5F
 Q3GkBPVnwRZ9M1PfBNuLegHsME1l/ip/S012zrroWX4ttRiCfEZ2lvRxzMrYFwKfGWCG
 nydg==
X-Gm-Message-State: AOJu0YzwrIpbtxVd2oFmRwTLgTn4IDTgpLgbUop8SK4i12+bHLuMu4Tm
 kFvKFTOKPbMZx4+NbHt1757QOWcIFXx3zhO3AJbs65d+s0iUcwLWXM9i26RXvZYCSAI760yxYvD
 IPnQT7NJINgVRJRLN+0lnlXysyO4Eu6fLiTkzxOhtzOU2h5NSOQ9b
X-Gm-Gg: ASbGnct5HdLMbIepd/nigQb6w9OfNrNHUMA+UpIQH7aBYgF0K9VM/ZNtmJZBibXDhNu
 Dr2UGoJffW0lkgddTNybs11X36I7zFWTS/AfLhgPwvGGk3awUUj/EE4UR7Ox1AhIzh22477OPbu
 4WAf1UTpTwxDyfnoNMQxdZpTzc98D2wbux4ZBsSJqrENEcVV3Jf10YWH4MRzZBfqrVxvpSiAcIW
 L83ervge13Y8WNQC0b1nMsVjr6cLnlYIrcx5CG85Tb4CUMSc3zbqfId+m1ZSvCL1QRZyfWy29Hh
 i4dFxA==
X-Received: by 2002:a05:6000:18a8:b0:391:1218:d5f7 with SMTP id
 ffacd0b85a97d-39efbad7d6amr270730f8f.40.1744923714049; 
 Thu, 17 Apr 2025 14:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG984paYZBTuOPlx5o8+YgCWwG/vIT+swfhczbiO9pNcGe5DWx4s5EKANuvfi3Mhjtyww8A5w==
X-Received: by 2002:a05:6000:18a8:b0:391:1218:d5f7 with SMTP id
 ffacd0b85a97d-39efbad7d6amr270684f8f.40.1744923713608; 
 Thu, 17 Apr 2025 14:01:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406abb6328sm3583475e9.1.2025.04.17.14.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 14:01:48 -0700 (PDT)
Date: Thu, 17 Apr 2025 17:01:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] exec: Rename target_words_bigendian() ->
 target_big_endian()
Message-ID: <20250417170137-mutt-send-email-mst@kernel.org>
References: <20250417210025.68322-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417210025.68322-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 17, 2025 at 11:00:25PM +0200, Philippe Mathieu-Daudé wrote:
> In commit 98ed8ecfc9d ("exec: introduce target_words_bigendian()
> helper") target_words_bigendian() was matching the definition it
> was depending on (TARGET_WORDS_BIGENDIAN). Later in commit
> ee3eb3a7ce7 ("Replace TARGET_WORDS_BIGENDIAN") the definition was
> renamed as TARGET_BIG_ENDIAN but we didn't update the helper.
> Do it now mechanically using:
> 
>   $ sed -i -e s/target_words_bigendian/target_big_endian/g \
>         $(git grep -wl target_words_bigendian)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/exec/tswap.h     | 12 ++++++------
>  system/memory-internal.h |  2 +-
>  cpu-target.c             |  4 ++--
>  hw/core/cpu-system.c     |  2 +-
>  hw/display/vga.c         |  2 +-
>  hw/virtio/virtio.c       |  2 +-
>  system/memory.c          |  4 ++--
>  system/qtest.c           |  2 +-
>  8 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/exec/tswap.h b/include/exec/tswap.h
> index 84060a49994..49511f26117 100644
> --- a/include/exec/tswap.h
> +++ b/include/exec/tswap.h
> @@ -11,15 +11,15 @@
>  #include "qemu/bswap.h"
>  
>  /**
> - * target_words_bigendian:
> + * target_big_endian:
>   * Returns true if the (default) endianness of the target is big endian,
>   * false otherwise. Common code should normally never need to know about the
>   * endianness of the target, so please do *not* use this function unless you
>   * know very well what you are doing!
>   */
> -bool target_words_bigendian(void);
> +bool target_big_endian(void);
>  #ifdef COMPILING_PER_TARGET
> -#define target_words_bigendian()  TARGET_BIG_ENDIAN
> +#define target_big_endian()   TARGET_BIG_ENDIAN
>  #endif
>  
>  /*
> @@ -29,7 +29,7 @@ bool target_words_bigendian(void);
>  #ifdef COMPILING_PER_TARGET
>  #define target_needs_bswap()  (HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN)
>  #else
> -#define target_needs_bswap()  (HOST_BIG_ENDIAN != target_words_bigendian())
> +#define target_needs_bswap()  (HOST_BIG_ENDIAN != target_big_endian())
>  #endif /* COMPILING_PER_TARGET */
>  
>  static inline uint16_t tswap16(uint16_t s)
> @@ -83,7 +83,7 @@ static inline void tswap64s(uint64_t *s)
>  /* Return ld{word}_{le,be}_p following target endianness. */
>  #define LOAD_IMPL(word, args...)                    \
>  do {                                                \
> -    if (target_words_bigendian()) {                 \
> +    if (target_big_endian()) {                      \
>          return glue(glue(ld, word), _be_p)(args);   \
>      } else {                                        \
>          return glue(glue(ld, word), _le_p)(args);   \
> @@ -120,7 +120,7 @@ static inline uint64_t ldn_p(const void *ptr, int sz)
>  /* Call st{word}_{le,be}_p following target endianness. */
>  #define STORE_IMPL(word, args...)           \
>  do {                                        \
> -    if (target_words_bigendian()) {         \
> +    if (target_big_endian()) {              \
>          glue(glue(st, word), _be_p)(args);  \
>      } else {                                \
>          glue(glue(st, word), _le_p)(args);  \
> diff --git a/system/memory-internal.h b/system/memory-internal.h
> index 085e81a9fe4..29717b3c58f 100644
> --- a/system/memory-internal.h
> +++ b/system/memory-internal.h
> @@ -45,7 +45,7 @@ static inline bool devend_big_endian(enum device_endian end)
>                        DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
>  
>      if (end == DEVICE_NATIVE_ENDIAN) {
> -        return target_words_bigendian();
> +        return target_big_endian();
>      }
>      return end == DEVICE_BIG_ENDIAN;
>  }
> diff --git a/cpu-target.c b/cpu-target.c
> index e018acbf71a..b5645ff0dbb 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -86,8 +86,8 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
>      abort();
>  }
>  
> -#undef target_words_bigendian
> -bool target_words_bigendian(void)
> +#undef target_big_endian
> +bool target_big_endian(void)
>  {
>      return TARGET_BIG_ENDIAN;
>  }
> diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
> index 82b68b8927d..3c84176a0c5 100644
> --- a/hw/core/cpu-system.c
> +++ b/hw/core/cpu-system.c
> @@ -133,7 +133,7 @@ bool cpu_virtio_is_big_endian(CPUState *cpu)
>      if (cpu->cc->sysemu_ops->virtio_is_big_endian) {
>          return cpu->cc->sysemu_ops->virtio_is_big_endian(cpu);
>      }
> -    return target_words_bigendian();
> +    return target_big_endian();
>  }
>  
>  GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index b01f67c65fb..20475ebbd31 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -2264,7 +2264,7 @@ bool vga_common_init(VGACommonState *s, Object *obj, Error **errp)
>       * into a device attribute set by the machine/platform to remove
>       * all target endian dependencies from this file.
>       */
> -    s->default_endian_fb = target_words_bigendian();
> +    s->default_endian_fb = target_big_endian();
>      s->big_endian_fb = s->default_endian_fb;
>  
>      vga_dirty_log_start(s);
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 85110bce374..8fbf1716b88 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2248,7 +2248,7 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
>  
>  static enum virtio_device_endian virtio_default_endian(void)
>  {
> -    if (target_words_bigendian()) {
> +    if (target_big_endian()) {
>          return VIRTIO_DEVICE_ENDIAN_BIG;
>      } else {
>          return VIRTIO_DEVICE_ENDIAN_LITTLE;
> diff --git a/system/memory.c b/system/memory.c
> index 7e2f16f4e95..67e433095b4 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2575,7 +2575,7 @@ void memory_region_add_eventfd(MemoryRegion *mr,
>      unsigned i;
>  
>      if (size) {
> -        MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
> +        MemOp mop = (target_big_endian() ? MO_BE : MO_LE) | size_memop(size);
>          adjust_endianness(mr, &mrfd.data, mop);
>      }
>      memory_region_transaction_begin();
> @@ -2611,7 +2611,7 @@ void memory_region_del_eventfd(MemoryRegion *mr,
>      unsigned i;
>  
>      if (size) {
> -        MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
> +        MemOp mop = (target_big_endian() ? MO_BE : MO_LE) | size_memop(size);
>          adjust_endianness(mr, &mrfd.data, mop);
>      }
>      memory_region_transaction_begin();
> diff --git a/system/qtest.c b/system/qtest.c
> index 523a0479959..c675fa2cb30 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -693,7 +693,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>  
>          qtest_send(chr, "OK\n");
>      } else if (strcmp(words[0], "endianness") == 0) {
> -        if (target_words_bigendian()) {
> +        if (target_big_endian()) {
>              qtest_sendf(chr, "OK big\n");
>          } else {
>              qtest_sendf(chr, "OK little\n");
> -- 
> 2.47.1


