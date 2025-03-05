Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF73C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 08:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkbA-00056P-Dx; Wed, 05 Mar 2025 03:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpkb7-00055t-In
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:59:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpkb3-00059f-Et
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741165160;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/mgmMB1R8rmyGtKAlzFLtFza52MQvUDiJyia7RRIx4=;
 b=NqiZwfOLMoUaKuRPFy/sDUu4O/ocwGZxaPbJ8zM/y5Z7fJlI+BHGqwHzs3Lte1cSQ3t7Bd
 ssWYiyhiM0/cW6/FjVYNEIIfJJI0fzRfupiok7OXyjtmpHUEfeABx8KBLA3JzHodo1ebFo
 hI8Xi/1HufUuqy9K0ZKudesfnx1OqXY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-TxyGq7rjNoGhfOOFmJhIJQ-1; Wed,
 05 Mar 2025 03:59:15 -0500
X-MC-Unique: TxyGq7rjNoGhfOOFmJhIJQ-1
X-Mimecast-MFC-AGG-ID: TxyGq7rjNoGhfOOFmJhIJQ_1741165154
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57CE1180AF4A; Wed,  5 Mar 2025 08:59:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC821180049D; Wed,  5 Mar 2025 08:59:10 +0000 (UTC)
Date: Wed, 5 Mar 2025 08:59:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 10/11] qemu: Introduce qemu_arch_name() helper
Message-ID: <Z8gSW9n0R8zWS7jM@redhat.com>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-11-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305005225.95051-11-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 05, 2025 at 01:52:24AM +0100, Philippe Mathieu-Daudé wrote:
> Introduce a generic helper to get the target name of a QemuArchBit.
> (This will be used for single / heterogeneous binaries).
> Use it in target_name(), removing the last use of the TARGET_NAME
> definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/qemu/arch_info.h |  2 ++
>  arch_info-target.c       | 34 +++++++++++++++++++++++++++++++++-
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/arch_info.h b/include/qemu/arch_info.h
> index 613dc2037db..7e3192f590f 100644
> --- a/include/qemu/arch_info.h
> +++ b/include/qemu/arch_info.h
> @@ -46,6 +46,8 @@ typedef enum QemuArchBit {
>  #define QEMU_ARCH_LOONGARCH     BIT(QEMU_ARCH_BIT_LOONGARCH)
>  #define QEMU_ARCH_ALL           -1
>  
> +const char *qemu_arch_name(QemuArchBit qemu_arch_bit);
> +
>  const char *target_name(void);
>  
>  bool qemu_arch_available(unsigned qemu_arch_mask);
> diff --git a/arch_info-target.c b/arch_info-target.c
> index 61007415b30..9b19fe8d56d 100644
> --- a/arch_info-target.c
> +++ b/arch_info-target.c
> @@ -24,9 +24,41 @@
>  #include "qemu/osdep.h"
>  #include "qemu/arch_info.h"
>  
> +const char *qemu_arch_name(QemuArchBit qemu_arch_bit)
> +{
> +    static const char *legacy_target_names[] = {
> +        [QEMU_ARCH_ALPHA] = "alpha",

All the others you've used QEMU_ARCH_BIT except for this. Yes, it happens
to have the same value either way, but it still looks wrong.

> +        [QEMU_ARCH_BIT_ARM] = TARGET_LONG_BITS == 32 ? "arm" : "aarch64",
> +        [QEMU_ARCH_BIT_AVR] = "avr",
> +        [QEMU_ARCH_BIT_HEXAGON] = "hexagon",
> +        [QEMU_ARCH_BIT_HPPA] = "hppa",
> +        [QEMU_ARCH_BIT_I386] = TARGET_LONG_BITS == 32 ? "i386" : "x86_64",
> +        [QEMU_ARCH_BIT_LOONGARCH] = "loongarch64",
> +        [QEMU_ARCH_BIT_M68K] = "m68k",
> +        [QEMU_ARCH_BIT_MICROBLAZE] = TARGET_BIG_ENDIAN ? "microblaze"
> +                                                       : "microblazeel",
> +        [QEMU_ARCH_BIT_MIPS] = TARGET_BIG_ENDIAN
> +                             ? (TARGET_LONG_BITS == 32 ? "mips" : "mips64")
> +                             : (TARGET_LONG_BITS == 32 ? "mipsel" : "mips64el"),
> +        [QEMU_ARCH_BIT_OPENRISC] = "or1k",
> +        [QEMU_ARCH_BIT_PPC] = TARGET_LONG_BITS == 32 ? "ppc" : "ppc64",
> +        [QEMU_ARCH_BIT_RISCV] = TARGET_LONG_BITS == 32 ? "riscv32" : "riscv64",
> +        [QEMU_ARCH_BIT_RX] = "rx",
> +        [QEMU_ARCH_BIT_S390X] = "s390x",
> +        [QEMU_ARCH_BIT_SH4] = TARGET_BIG_ENDIAN ? "sh4eb" : "sh4",
> +        [QEMU_ARCH_BIT_SPARC] = TARGET_LONG_BITS == 32 ? "sparc" : "sparc64",
> +        [QEMU_ARCH_BIT_TRICORE] = "tricore",
> +        [QEMU_ARCH_BIT_XTENSA] = TARGET_BIG_ENDIAN ? "xtensaeb" : "xtensa",

Why do we need to give arches different names based on endian/bits, as
opposed to a fixed int -> name mapping. What's the intended  usage of
this ?

Since you're calling this a legacy_target_names, should the method also
be call qemu_legacy_arch_name() rather than qemu_arch_name - I would
have naively expected qemu_arch_name to be a plain mapping.

> +    };
> +
> +    assert(qemu_arch_bit < ARRAY_SIZE(legacy_target_names));
> +    assert(legacy_target_names[qemu_arch_bit]);
> +    return legacy_target_names[qemu_arch_bit];
> +}
> +
>  const char *target_name(void)
>  {
> -    return TARGET_NAME;
> +    return qemu_arch_name(QEMU_ARCH_BIT);
>  }
>  
>  bool qemu_arch_available(unsigned qemu_arch_mask)
> -- 
> 2.47.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


