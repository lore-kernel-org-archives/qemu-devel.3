Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADB8FED2DD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0apm-0008UA-H4; Thu, 12 Mar 2026 03:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0apk-0008Tv-PX
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0api-0008BO-CP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773301909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H3akfImtvfH/doWZxbKQI/tLFi25Aen/ZNXmA6PkZk4=;
 b=RQMEuY+OdJBRytagxo6cmpMmp1B+FQA5nBe4H1gC1Y+qNi0h7+AIcIPdoDHXV5zbhOYTmP
 Fu9Bnqk0Gn0qFxZdnlkj/p/mp2QimBSvNt4GxyVU1MiIi/EHS9h7QTC5sxQ0BAJtaH6Dny
 4wid4sLEWs9ZFiid+4k8vPAceFDZK4E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-60jZrCpeM8msxrmEuEoI2g-1; Thu,
 12 Mar 2026 03:51:47 -0400
X-MC-Unique: 60jZrCpeM8msxrmEuEoI2g-1
X-Mimecast-MFC-AGG-ID: 60jZrCpeM8msxrmEuEoI2g_1773301906
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E3A518005B0; Thu, 12 Mar 2026 07:51:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34F5819540C2; Thu, 12 Mar 2026 07:51:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BFCB321E6937; Thu, 12 Mar 2026 08:51:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>,  qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] target/xtensa/cpu: Move initialization of memory region
 to realize function
In-Reply-To: <20260311202503.107026-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 11 Mar 2026 21:25:03 +0100")
References: <20260311202503.107026-1-thuth@redhat.com>
Date: Thu, 12 Mar 2026 08:51:43 +0100
Message-ID: <87y0jxzdrk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> When introspecting the xtensa CPUs from the command line, QEMU currently
> crashes:
>
>  $ ./qemu-system-xtensa -device dc233c-xtensa-cpu,help
>  qemu-system-xtensa: ../../devel/qemu/system/physmem.c:1401:
>   register_multipage: Assertion `num_pages' failed.
>  Aborted (core dumped)
>
> Move the initialization of the memory regions to the realize function
> to fix this problem.
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Looking a bit closer at the code leading to the assertion failure:
TARGET_PAGE_BITS (macro expanding to target_page.bits) is still zero.
Hmm.  Is this a regression?  If yes, could there be more invalid uses of
TARGET_PAGE_BITS we haven't discovered, yet?  I guess they'd also be
relatively safe, as TARGET_PAGE_BITS becomes valid before things get
spicy, i.e. before the guest runs.

I tested v10.2.0, and it also crashes, but the assertion differs:

    qemu-system-xtensa: ../system/physmem.c:1337: phys_section_add: Assertion `map->sections_nb < TARGET_PAGE_SIZE' failed.

So, if it's a regression, it's not a recent one.

Another interesting detail is how TARGET_PAGE_BITS is defined:

    #ifdef TARGET_PAGE_BITS_VARY
    [...]
    # ifdef CONFIG_DEBUG_TCG
    #  define TARGET_PAGE_BITS   ({ assert(target_page.decided); \
                                    target_page.bits; })

Here, we assert it's valid.

    [...]
    # else
    #  define TARGET_PAGE_BITS   target_page.bits

Here, we just trust it.  I guess because the assertion above is
too expensive.

    [...]
    #else

And here it seems to be pulled from elsewhere.  The possible elsewheres
seem to be target/$target/cpu-param.h, which #define it as an integer
literal.

    [...]
    #endif

Cc'ing Richard, who has worked in the TARGET_PAGE_BITS area.  Just fyi,
Richard, I'm not asking you for further input.

> ---
>  target/xtensa/cpu.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index 86ec899a67c..eebf40559bc 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -244,6 +244,14 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
>      Error *local_err = NULL;
>  
>  #ifndef CONFIG_USER_ONLY
> +    CPUXtensaState *env = &XTENSA_CPU(dev)->env;
> +
> +    env->address_space_er = g_malloc(sizeof(*env->address_space_er));
> +    env->system_er = g_malloc(sizeof(*env->system_er));
> +    memory_region_init_io(env->system_er, OBJECT(dev), NULL, env, "er",
> +                          UINT64_C(0x100000000));
> +    address_space_init(env->address_space_er, env->system_er, "ER");
> +
>      xtensa_irq_init(&XTENSA_CPU(dev)->env);
>  #endif
>  
> @@ -269,12 +277,6 @@ static void xtensa_cpu_initfn(Object *obj)
>      env->config = xcc->config;
>  
>  #ifndef CONFIG_USER_ONLY
> -    env->address_space_er = g_malloc(sizeof(*env->address_space_er));
> -    env->system_er = g_malloc(sizeof(*env->system_er));
> -    memory_region_init_io(env->system_er, obj, NULL, env, "er",
> -                          UINT64_C(0x100000000));
> -    address_space_init(env->address_space_er, env->system_er, "ER");
> -
>      cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, cpu, 0);
>      clock_set_hz(cpu->clock, env->config->clock_freq_khz * 1000);
>  #endif

Fixes the crash for all xtensa CPUs.

Tested-by: Markus Armbruster <armbru@redhat.com>


