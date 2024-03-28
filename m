Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AB6C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprUG-0002ch-PR; Thu, 28 Mar 2024 11:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rprUC-0002c5-JU
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rprUA-0003Kp-Ih
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711638969;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+w3xDrEmi8SU6qoC1GYg9hAuUVnK+SuJ8bqvl0lc2I=;
 b=gVqCLHdOC+CGn2g3F+peoIYivVcCAF75IHGRvRIuggAkfr+5sds+e7D0cQiCq04T8lyjus
 yA5vytwytRQXvkbhSxUsswMhNmpAjKDUWaBjfwsPoLq65bvTpm9aABpOTVpRMxhV+B8mMi
 x9dT7LOICRNbnOhYZYwiF6oO530+m5A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-MbdK5HD_M5mDWXpY1C7JMg-1; Thu, 28 Mar 2024 11:16:05 -0400
X-MC-Unique: MbdK5HD_M5mDWXpY1C7JMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A29A8007A2;
 Thu, 28 Mar 2024 15:16:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F29C417AA2;
 Thu, 28 Mar 2024 15:16:02 +0000 (UTC)
Date: Thu, 28 Mar 2024 15:15:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, devel@lists.libvirt.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH-for-9.0 v2] hw/i386/pc: Deprecate 64-bit CPUs on ISA-only
 PC machine
Message-ID: <ZgWJrTfMl6iQYepJ@redhat.com>
References: <20240327165456.34716-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327165456.34716-1-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 27, 2024 at 05:54:56PM +0100, Philippe Mathieu-Daudé wrote:
> Per Daniel suggestion [*]:
> 
>  > isapc could arguably be restricted to just 32-bit CPU models,
>  > because we should not need it to support any feature that didn't
>  > exist prior to circa 1995. eg refuse to start with isapc, if 'lm'
>  > is present in the CPU model for example.
> 
> Display a warning when such CPU is used:
> 
>   $ qemu-system-x86_64 -monitor stdio -S -M isapc -cpu Westmere
>   qemu-system-x86_64: warning: Use of 64-bit CPU 'Westmere' is deprecated on the ISA-only PC machine
>   QEMU 8.2.91 monitor - type 'help' for more information
>   (qemu) q
> 
>   $ qemu-system-x86_64 -monitor stdio -S -M isapc -cpu athlon
>   QEMU 8.2.91 monitor - type 'help' for more information
>   (qemu) q

I've thought of a possible problem here..

   $ qemu-system-x86_64 -monitor stdio -S -M isapc -cpu max

is going to enable 'lm'  (and a bazillion other new features)
for 'isapc', which is a shame, as 'max' is something we want
to be usable in general. I'm not sure how to square that
circle.

I might suggest that 'isapc' instead only makes sense in the
context of qemu-system-i386, since that only has 32-bit CPUs.
We wanted to kill that binary in favour of qemu-system-x86_64
for both 32 & 64 bit though, so we can't block 'isapc' from
qemu-system-x86_64.

> 
> [*] https://lore.kernel.org/qemu-devel/ZgQkS4RPmSt5Xa08@redhat.com/
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/about/deprecated.rst |  7 +++++++
>  include/hw/i386/pc.h      |  1 +
>  hw/i386/pc_piix.c         | 14 ++++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7b548519b5..345c35507f 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -208,6 +208,13 @@ is no longer packaged in any distro making it harder to run the
>  ``check-tcg`` tests. Unless we can improve the testing situation there
>  is a chance the code will bitrot without anyone noticing.
>  
> +64-bit (x86_64) CPUs on the ``isapc`` machine (since 9.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``isapc`` machine aims to emulate old PC machine without PCI was
> +generalized, so hardware available around 1995, before 64-bit intel
> +CPUs were produced.
> +
>  System emulator machines
>  ------------------------
>  
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 27a68071d7..2d202b9549 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -96,6 +96,7 @@ struct PCMachineClass {
>      const char *default_south_bridge;
>  
>      /* Compat options: */
> +    bool deprecate_64bit_cpu; /* Specific to the 'isapc' machine */
>  
>      /* Default CPU model version.  See x86_cpu_set_default_version(). */
>      int default_cpu_version;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 18ba076609..2e5b2efc33 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -182,7 +182,20 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>      }
>  
>      pc_machine_init_sgx_epc(pcms);
> +
>      x86_cpus_init(x86ms, pcmc->default_cpu_version);
> +    if (pcmc->deprecate_64bit_cpu) {
> +        X86CPU *cpu = X86_CPU(first_cpu);
> +
> +        if (cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> +            const char *cpu_type = object_get_typename(OBJECT(first_cpu));
> +            int cpu_len = strlen(cpu_type) - strlen(X86_CPU_TYPE_SUFFIX);
> +
> +            warn_report("Use of 64-bit CPU '%.*s' is deprecated"
> +                        " on the ISA-only PC machine",
> +                        cpu_len, cpu_type);
> +        }
> +    }
>  
>      if (kvm_enabled()) {
>          kvmclock_create(pcmc->kvmclock_create_always);
> @@ -918,6 +931,7 @@ static void isapc_machine_options(MachineClass *m)
>      pcmc->gigabyte_align = false;
>      pcmc->smbios_legacy_mode = true;
>      pcmc->has_reserved_memory = false;
> +    pcmc->deprecate_64bit_cpu = true;
>      m->default_nic = "ne2k_isa";
>      m->default_cpu_type = X86_CPU_TYPE_NAME("486");
>      m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
> -- 
> 2.41.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


