Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EA9D3B7F6
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 09:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFVYv-0004vd-OV; Mon, 25 Nov 2024 04:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tFVYn-0004v6-F7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 04:39:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tFVYi-00045y-Su
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 04:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732527546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2w08m8o6SK0yxDdTGXbIYmmkIdO0S1p/4kTWVQ2YX+g=;
 b=K8GCGHy4MCVXw/F322ypCj3SWZEAw1gNU6T4cT13sXo241+cpd+qEvKKHad/QbVYemBV0/
 BpTWdWkGLzEt9SrT9sPI8Nrd+X7AP6Ed3LkDx1YxAgFI/0yNTGT7bdSPuLEHRE7ofDUdGY
 BqZ1iMCiXLG8Bds6sCkTLwOJsypgIE0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-NMn79X_XPK--Wx8-Mvxa-Q-1; Mon, 25 Nov 2024 04:39:00 -0500
X-MC-Unique: NMn79X_XPK--Wx8-Mvxa-Q-1
X-Mimecast-MFC-AGG-ID: NMn79X_XPK--Wx8-Mvxa-Q
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38256b20f5fso3209283f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 01:39:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732527539; x=1733132339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2w08m8o6SK0yxDdTGXbIYmmkIdO0S1p/4kTWVQ2YX+g=;
 b=ZSyvQXa2Gb4xQqwJCxhT2Yj3Yah+2ogXIwtVUenv/Uq6TNaCPZoAK/OFANZJlNKlyX
 GOYPlmZaFDasmbP1xEaZW5eChMEq3NKmKvW+arWxBz6rQzMHtLnHj6jQ3ZYxNs7LS9RX
 ztgQeUzR/gZWrxHdIe8X6Diqt7mOeZDNQZMCBfIzrXcn9VZO1yRXe8XvCObWMKIyIji/
 qeEiG4sGP71vn/ACd0j+573N5nw/y091ET7MDzr5FD4gMFDdqWxX064ZNqOB9ajW/wjY
 FOOv0Zc8h1ze9p2ToJn54Kk+xaFdiIfXAP+whzANjR3/rAy8axoz3IIMpLqekzugeP2D
 ocrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULjfsDP0mwHdeKyuY01FxoVB5CmqBCsOiqsr2wxcfYreaUzW26OVLX1Zd2vwvYGjUMkedVux57H1zb@nongnu.org
X-Gm-Message-State: AOJu0Yxelf7TIVUrwxOwDWKpXDiR4YIjLizyV3XO0YZFWBlChfgjc1qD
 XxMfs8XGDZ8emcpH4w02CSNTontH5idgd6fuOB4U3xcjvrYXz1w0fj5BosPRaFYGKOEa5knqAMp
 3rBdH9nO0WIxr0lAVY9qqHsgLKarnib2wPaRfQ4naEaY8bSYmp6hV
X-Gm-Gg: ASbGnctcx6JtY5wM5thZMR8Eg9Tmzhh5RwAUztqqo5DzDNWVtVF756qjo35Z11xkh+t
 9ph/fuc528xWU7t8UTgIQ5ddtCdn+4WfaFCnQD8eI+5NePeCv2GE/DKaY/f0p4psZahRQKVyzh5
 KmhV6RWYfoe9h1gFs93M1Q28UC7zKIy08A8zizai/9mv4l7IfFkMHrdVoBy1HSf+kPdgeM/EDW0
 3AKS3KVGwglR7iS56oImZgKQ9huELcGGy98EY6Wc6u+4E3mwWuS8yp3ETgs2Cs6DJUCIbPKNItA
 LGGYhWJB20SEE1noa8zLRQ==
X-Received: by 2002:a5d:6d0c:0:b0:381:d890:b5b7 with SMTP id
 ffacd0b85a97d-38260bda386mr12447420f8f.52.1732527539381; 
 Mon, 25 Nov 2024 01:38:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvoGsqasZcTQFAofuB3P2+k1YkiqaLxxV5bdZI6EYjy/wgQgnER614EJ73ze0gSuEqNRmeRQ==
X-Received: by 2002:a5d:6d0c:0:b0:381:d890:b5b7 with SMTP id
 ffacd0b85a97d-38260bda386mr12447393f8f.52.1732527538952; 
 Mon, 25 Nov 2024 01:38:58 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc4140sm10144027f8f.77.2024.11.25.01.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 01:38:58 -0800 (PST)
Date: Mon, 25 Nov 2024 10:38:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] cpu: Initialize nr_cores and nr_threads in
 cpu_common_initfn()
Message-ID: <20241125103857.78a23715@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241122160317.4070177-1-xiaoyao.li@intel.com>
References: <20241108070609.3653085-2-xiaoyao.li@intel.com>
 <20241122160317.4070177-1-xiaoyao.li@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 22 Nov 2024 11:03:17 -0500
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> Currently cpu->nr_cores and cpu->nr_threads are initialized in
> qemu_init_vcpu(), which is called a bit late in *cpu_realizefn() for
> each ARCHes.
> 
> x86 arch would like to use nr_cores and nr_threads earlier in its
> realizefn(). To serve this purpose, initialize nr_cores and nr_threads
> in cpu_common_initfn(), which is earlier than *cpu_realizefn().
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  hw/core/cpu-common.c | 10 +++++++++-
>  system/cpus.c        |  4 ----
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 09c79035949b..6de92ed854bc 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -237,14 +237,22 @@ static void cpu_common_unrealizefn(DeviceState *dev)
>  static void cpu_common_initfn(Object *obj)
>  {
>      CPUState *cpu = CPU(obj);
> +    Object *machine = qdev_get_machine();
> +    MachineState *ms;
>  
>      gdb_init_cpu(cpu);
>      cpu->cpu_index = UNASSIGNED_CPU_INDEX;
>      cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
>      /* user-mode doesn't have configurable SMP topology */
> -    /* the default value is changed by qemu_init_vcpu() for system-mode */
>      cpu->nr_cores = 1;
>      cpu->nr_threads = 1;
> +#ifndef CONFIG_USER_ONLY
> +    if (object_dynamic_cast(machine, TYPE_MACHINE)) {
> +        ms = MACHINE(machine);
> +        cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
> +        cpu->nr_threads = ms->smp.threads;
> +    }
> +#endif

Can't say, that I'm fond of adding/moving hack to access MachineState
from CPU context. Granted we did/still do it elsewhere, But I'd rather
prefer getting rid of those remnants that access globals.
It's basically technical debt we are carrying since 2009 (dc6b1c09849).
Moving that around doesn't help with getting rid of arbitrary access to globals.

As Paolo've noted there are other ways to set cores/threads,
albeit at expense of adding more code. And that could be fine
if it's done within expected cpu initialization flow.

Instead of accessing MachineState directly from CPU code (which is
essentially a layer violation), I'd suggest to set cores_nr/threads_nr
from pre_plug handler (which is machine code).
We do similar thing for nr_dies/nr_modules already, and we should do
same for cores/trheads.

Quick hack would be do the same for cores/threads in x86_cpu_pre_plug(),
and make qemu_init_vcpu() conditional to avoid touching other targets/machines.

I'd even ack that, however that's just leaves us with the same
old technical debt. So I'd like to coax a promise to fix it properly
(i.e. get rid of access to machine from CPU code).

(here goes typical ask to rewrite whole QEMU before doing thing you
actually need)

To do that we would need to:
  1. audit usage of cpu->nr_cores/cpu->nr_threads across QEMU, to figure out
     what targets/machines need them
  2. then add pre_plug() handlers to those machines to set them.
  3. In the end get rid of initializing them in cpu_common_initfn().

With that done we can then add a common helper to generalize topo config
based on -smp from pre_plug() handlers to reduce duplication caused by
per machine pre_plug handlers.

Or introduce a generic cpu_pre_plug() handler at Machine level and make
_pre_plug call chain to call it (sort of what we do with nested realize calls);

I'd prefer the 1st option (#2) as it explicitly documents what
targets/machines care about cores/threads at expense of some boiler plate code
duplication, instead of blanket generic fallback like we have now (regardless of
if it's actually needed).

>      cpu->cflags_next_tb = -1;
>  
>      /* allocate storage for thread info, initialise condition variables */
> diff --git a/system/cpus.c b/system/cpus.c
> index 1c818ff6828c..c1547fbfd39b 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -664,10 +664,6 @@ const AccelOpsClass *cpus_get_accel(void)
>  
>  void qemu_init_vcpu(CPUState *cpu)
>  {
> -    MachineState *ms = MACHINE(qdev_get_machine());
> -
> -    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
> -    cpu->nr_threads =  ms->smp.threads;
>      cpu->stopped = true;
>      cpu->random_seed = qemu_guest_random_seed_thread_part1();
>  


