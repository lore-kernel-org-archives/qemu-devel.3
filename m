Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CE9E9B24E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 10:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vupZB-000782-RQ; Tue, 24 Feb 2026 05:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vupZ8-00077d-41
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:22:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vupZ5-0007Bs-P5
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771928570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NyTNj0WrUG82kCnVjAgz2sgw9Aar9CWE6bbTe6ra1UY=;
 b=cY5WinhgLoV4t3f96sWNs7dzfcj9HEsevWJMpHy/FZrAUKQ1ZHei7l49jujkGScb+RZ2kE
 0OQbLZdNvb6kkl1mvu5rq8U1ZwgDLFTgAKpmyS0ZfYVO2RiSiUuwaYB0f2iWsrEgvSPpWw
 iyIk0jjpMbCeNcNXB5qs1jCmOsrNyWE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-2nUx2MHNNy6-7cjh9TVxFA-1; Tue, 24 Feb 2026 05:22:47 -0500
X-MC-Unique: 2nUx2MHNNy6-7cjh9TVxFA-1
X-Mimecast-MFC-AGG-ID: 2nUx2MHNNy6-7cjh9TVxFA_1771928566
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4376ecafb7fso3599752f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 02:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771928566; x=1772533366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NyTNj0WrUG82kCnVjAgz2sgw9Aar9CWE6bbTe6ra1UY=;
 b=tFJadGhIXHN1RaemclisQucb938szJZlvxIKUiNuKCe5ytIRk0qGQalj1BBAUfMxpL
 2xJaj7/MvbtOPJ9VJEJXOJ6GeJTiMssWRFAc+IWrAnKyrdqeblwQrle3m7j6R2XGFcqV
 sv1ZnqCST7I0dmlUcLCrkeswtdpE50WDs7EJFrQbrOb4eKkVdM6Hd8qMzvr636KEjkc2
 MSF9sw4mV6k6x3uUi2x1TPeSYKhUH/jfGrmFwM0HgLBP8zLBlzcG6Gwf+iO1eVmrS57t
 BGPq7Jk4hMLlG/FViOC9zECBiwHHMPNQVeDppR+vlYoYkFbPqa8QNu17WAQjC9wQgfep
 u4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771928566; x=1772533366;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NyTNj0WrUG82kCnVjAgz2sgw9Aar9CWE6bbTe6ra1UY=;
 b=o8zDyANg7wGuy9/jnS3k5qT23Io4F18YSjXg326PbHGN98TglmV13blnzGjLWRshsR
 ObiiCJSkmeprVS3UoHStApgprqGx2TYMjJvnGNjEBp9teUhjJa/67nlZnivzswiW1fBD
 y6zyn5mtfWlLYSDJvqKfxw3MEZnTvV5sgsAgNH8M2TcFiVuyNdpJK8a9/IJnPdNMCJhr
 DWLPT5dCkzOl3P9h4CpoQyfdD9kGZ3NR25g9+D64rMh32r/sYapi2vmoZIqRzvfca789
 QpqBtgx+REVog06necAA8jBV+T/34RBEUUZP1xwoaur98yCWcc0BaAPGOBN5jtSHGqZt
 I19w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSTxm0FeAXn6V5vy0LTHhpXrrVOcdgElnOr93Q3RXkd5WPrz7G3Om3FL0GJQahfJ383K8SynTKN7za@nongnu.org
X-Gm-Message-State: AOJu0YzRWCce820VvXt0PElk2vH9GvcS6/+j3TSn8c6ro4LmwpXrHQNj
 skHSSt0rNNmJM8EVTxx5PNQt0YKOkrOQbdtIUs7N4MRMKyMBAmZ7QV2QKuN01EkSuoaqGQPYCzf
 F/vv13M/X17+4xZAbq+GPsszDEbkMab8ZWUDh55xpz4uMYLACLKcO4s/O
X-Gm-Gg: ATEYQzyK8yhcvZCozqodCgdHUHa+F4G+1xxaLbcID6Sn03P2uY//F6vIO0JpRbPVI7l
 CFtRXFth+CBHQY4596pqv7UQ3M/KrNZ+jciRJMXE/VnfRzbDuFp3Zmrr1XOx7e4AW0gcDlszL+o
 duOjgUcNx70fMtDcI8O1YACA0+5CbU1ppfzEqTDEv1o3LFY3XlD/0xyFByoAwxlTn3JNkNYWP9n
 BDhgjJAy2OH+0jvv3UYnUlFIiCK3yndVOGlqFypDhkk5y0pLUUY5FjWoKRqDexTuV5NyIIHcSuW
 /c1FDErkap0llCRi71P9iTdmJ8qdy/J5XE2i2xXyNzNvQvNT30itevYRf+ODLVB0gbTP3Hghc+4
 k1Toor98gCAh7jL4TXxkE5Vjzgdc+SyDoauA01erXPcZG4JKBUz/usx138wiyhFIsZSxglgusxr
 7YRxiNvyYyme2iKTtfgqSHaYbfeHo=
X-Received: by 2002:adf:e7c2:0:b0:439:89e6:9776 with SMTP id
 ffacd0b85a97d-43989e6980amr1435922f8f.25.1771928566362; 
 Tue, 24 Feb 2026 02:22:46 -0800 (PST)
X-Received: by 2002:adf:e7c2:0:b0:439:89e6:9776 with SMTP id
 ffacd0b85a97d-43989e6980amr1435866f8f.25.1771928565817; 
 Tue, 24 Feb 2026 02:22:45 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm832650f8f.9.2026.02.24.02.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 02:22:44 -0800 (PST)
Message-ID: <2be88699-f77b-4236-a959-bc999a3e4caf@redhat.com>
Date: Tue, 24 Feb 2026 11:22:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] accel: Add Nitro Enclaves accelerator
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org, philmd@linaro.org,
 berrange@redhat.com, marcandre.lureau@redhat.com,
 Cornelia Huck <cohuck@redhat.com>, mst@redhat.com,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Tyler Fanelli <tfanelli@redhat.com>, mknaust@amazon.com,
 nh-open-source@amazon.com
References: <20260218015151.4052-1-graf@amazon.com>
 <20260218015151.4052-4-graf@amazon.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260218015151.4052-4-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

On 2/18/26 02:51, Alexander Graf wrote:
> +/*
> + * Start the Enclave. This gets called when the first vCPU 0 enters its main
> + * loop. At this point memory is set up and the EIF is loaded. This function
> + * donates memory, adds vCPUs, and starts the enclave.
> + */
> +static void nitro_do_start(NitroAccelState *s)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    int nr_cpus = ms->smp.cpus;
> +    int i, ret;
> +    struct ne_enclave_start_info start_info = {
> +        .flags = s->debug_mode ? NE_ENCLAVE_DEBUG_MODE : 0,
> +        .enclave_cid = s->enclave_cid,
> +    };
> +
> +    ret = qemu_ram_foreach_block(nitro_donate_ram_block, s);
> +    if (ret < 0) {
> +        error_report("nitro: failed to donate memory");
> +        exit(1);
> +    }
> +
> +    for (i = 0; i < nr_cpus; i++) {
> +        uint32_t cpu_id = 0;
> +        if (ioctl(s->enclave_fd, NE_ADD_VCPU, &cpu_id) < 0) {
> +            error_report("nitro: NE_ADD_VCPU failed: %s", strerror(errno));
> +            exit(1);
> +        }
> +    }
> +
> +    ret = ioctl(s->enclave_fd, NE_START_ENCLAVE, &start_info);
> +    if (ret < 0) {
> +        switch (errno) {
> +        case NE_ERR_NO_MEM_REGIONS_ADDED:
> +            error_report("nitro: no memory regions added");
> +            break;
> +        case NE_ERR_NO_VCPUS_ADDED:
> +            error_report("nitro: no vCPUs added");
> +            break;
> +        case NE_ERR_ENCLAVE_MEM_MIN_SIZE:
> +            error_report("nitro: memory is below the minimum "
> +                         "required size. Try increasing -m");
> +            break;
> +        case NE_ERR_FULL_CORES_NOT_USED:
> +            error_report("nitro: requires full CPU cores. "
> +                         "Try increasing -smp to a multiple of threads "
> +                         "per core on this host (e.g. -smp 2)");
> +            break;
> +        case NE_ERR_NOT_IN_INIT_STATE:
> +            error_report("nitro: not in init state");
> +            break;
> +        case NE_ERR_INVALID_FLAG_VALUE:
> +            error_report("nitro: invalid flag value for NE_START_ENCLAVE");
> +            break;
> +        case NE_ERR_INVALID_ENCLAVE_CID:
> +            error_report("nitro: invalid enclave CID");
> +            break;
> +        default:
> +            error_report("nitro: NE_START_ENCLAVE failed: %s (errno %d)",
> +                         strerror(errno), errno);
> +            break;
> +        }
> +        exit(1);
> +    }
> +
> +    s->enclave_cid = start_info.enclave_cid;
> +    trace_nitro_enclave_started(s->enclave_cid);
> +
> +    /*
> +     * Push enclave CID to all devices that need it.
> +     * Each device handles its own connection (console, heartbeat).
> +     */
> +    {
> +        BusState *sysbus = sysbus_get_default();
> +        BusChild *kid;
> +
> +        QTAILQ_FOREACH(kid, &sysbus->children, sibling) {
> +            DeviceState *dev = kid->child;
> +            if (object_property_find(OBJECT(dev), "enclave-cid")) {
> +                object_property_set_uint(OBJECT(dev), "enclave-cid",
> +                                         s->enclave_cid, NULL);
> +            }
> +        }

I think it makes more sense to have a "nitro bus" with its own subclass 
and an enclave_started(NitroDevice *dev, int enclave_cid, Error **errp) 
method.  Properties can be set with -device and that gets either awkward 
or buggy pretty quickly.

> +    }
> +}
> +
> +/*
> + * vCPU dummy thread function. The real vCPUs run inside the enclave.
> + *
> + * Based on dummy_cpu_thread_fn() from accel/dummy-cpus.c.
> + */
> +static void *nitro_vcpu_thread_fn(void *arg)
> +{
> +    CPUState *cpu = arg;
> +    NitroAccelState *s = NITRO_ACCEL(current_accel());
> +    sigset_t waitset;
> +
> +    rcu_register_thread();
> +
> +    bql_lock();
> +    qemu_thread_get_self(cpu->thread);
> +    cpu->thread_id = qemu_get_thread_id();
> +    current_cpu = cpu;
> +
> +    sigemptyset(&waitset);
> +    sigaddset(&waitset, SIG_IPI);
> +
> +    cpu_thread_signal_created(cpu);
> +    qemu_guest_random_seed_thread_part2(cpu->random_seed);
> +
> +    /* vCPU 0 starts the enclave on first entry */
> +    if (cpu->cpu_index == 0) {
> +        nitro_do_start(s);
> +    }

Can you replace this with an async_run_on_cpu() call when vCPU 0 is 
created (in nitro_start_vcpu_thread) and just reuse dummy_cpu_thread_fn()?

Or alternatively with a machine ready notifier.

> diff --git a/accel/stubs/nitro-stub.c b/accel/stubs/nitro-stub.c
> new file mode 100644
> index 0000000000..186c8444f8
> --- /dev/null
> +++ b/accel/stubs/nitro-stub.c
> @@ -0,0 +1,11 @@
> +/*
> + * Nitro accel stubs for QEMU
> + *
> + * Copyright © 2026 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +bool nitro_allowed;

Maybe all these *_allowed variables should be in a .c file in accel/.

Paolo


