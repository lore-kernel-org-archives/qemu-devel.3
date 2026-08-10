Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98995C5B56A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 17:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtTz8-0002Ex-Qa; Mon, 10 Aug 2026 13:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtTz3-00024l-B3
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 13:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtTz1-0004BL-9B
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 13:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786383617;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8E+A5HmnioucgfRq8iLAH4U0YUO4EsEMyHGYlct8P3E=;
 b=UNV322Kw4F7j2KpwUdsByEc8ZkPo4G8+2GnFq4K4rCx+8XqE4TZOZQW/muHerlBpWTs5lw
 H29JwziAEsA3sCxuoJjjpwow18a7C2GOrJi+vtBJvP7RcNkSfopxS8XEb61lihr3BO1skQ
 Ve7mVNUMjNSV39AqpBOPKLJIN0yu7cY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-CkaRzZc0MR2uhggOq5QxCQ-1; Mon,
 10 Aug 2026 13:40:13 -0400
X-MC-Unique: CkaRzZc0MR2uhggOq5QxCQ-1
X-Mimecast-MFC-AGG-ID: CkaRzZc0MR2uhggOq5QxCQ_1786383612
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7D6219560B5; Mon, 10 Aug 2026 17:40:12 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 790683001D38; Mon, 10 Aug 2026 17:40:11 +0000 (UTC)
Date: Mon, 10 Aug 2026 18:40:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 04/39] target/i386: decouple cpu_x86_inject_mce() from
 Monitor
Message-ID: <anoM-GDPeNTNfFR_@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-4-8af31bc54c61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626-qemu-no-hmp-v2-4-8af31bc54c61@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 26, 2026 at 01:19:05AM +0400, Marc-André Lureau wrote:
> Replace monitor_printf() error reporting with the standard **errp
> pattern. Drop the Monitor *mon parameter and return bool to indicate
> success, improving the function usage from non-HMP contexts. Update the
> KVM MCE injection path and hmp_mce() accordingly.
> 
> Notes:
>  - we may want to print the error in KVM path too
>  - multiple error prints are now accumulated with error hints
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  target/i386/cpu.h     |  4 ++--
>  target/i386/helper.c  | 49 ++++++++++++++++++++++++++++---------------------
>  target/i386/kvm/kvm.c |  4 ++--
>  target/i386/monitor.c |  6 ++++--
>  4 files changed, 36 insertions(+), 27 deletions(-)


>  typedef struct MCEInjectionParams {
> -    Monitor *mon;
> +    GString *err;

Why not have "Error **errp"

>      int bank;
>      uint64_t status;
>      uint64_t mcg_status;
> @@ -428,9 +428,9 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>           * reporting is disabled
>           */
>          if ((cenv->mcg_cap & MCG_CTL_P) && cenv->mcg_ctl != ~(uint64_t)0) {
> -            monitor_printf(params->mon,
> -                           "CPU %d: Uncorrected error reporting disabled\n",
> -                           cs->cpu_index);
> +            g_string_append_printf(params->err,
> +                "CPU %d: Uncorrected error reporting disabled\n",
> +                cs->cpu_index);

and use  error_setg here and the other two places below.

>              return;
>          }
>  
> @@ -439,10 +439,9 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>           * reporting is disabled for the bank
>           */
>          if (banks[0] != ~(uint64_t)0) {
> -            monitor_printf(params->mon,
> -                           "CPU %d: Uncorrected error reporting disabled for"
> -                           " bank %d\n",
> -                           cs->cpu_index, params->bank);
> +            g_string_append_printf(params->err,
> +                "CPU %d: Uncorrected error reporting disabled for bank %d\n",
> +                cs->cpu_index, params->bank);
>              return;
>          }
>  
> @@ -459,7 +458,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>          if (need_reset) {
>              emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
>                                        recursive);
> -            monitor_printf(params->mon, "%s", msg);
> +            g_string_append_printf(params->err, "%s\n", msg);
>              qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
>              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>              return;
> @@ -488,14 +487,16 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>      emit_guest_memory_failure(MEMORY_FAILURE_ACTION_INJECT, ar, recursive);
>  }
>  
> -void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
> +bool cpu_x86_inject_mce(X86CPU *cpu, int bank,
>                          uint64_t status, uint64_t mcg_status, uint64_t addr,
> -                        uint64_t misc, int flags)
> +                        uint64_t misc, int flags, Error **errp)
>  {
> +    ERRP_GUARD();
>      CPUState *cs = CPU(cpu);
>      CPUX86State *cenv = &cpu->env;
> +    g_autoptr(GString) err = g_string_new(NULL);
>      MCEInjectionParams params = {
> -        .mon = mon,
> +        .err = err,

This indirection via GString feels overkill when we could
use directly pass 'errp', given the ERRP_GUARD we have

>          .bank = bank,
>          .status = status,
>          .mcg_status = mcg_status,
> @@ -506,21 +507,21 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
>      unsigned bank_num = cenv->mcg_cap & 0xff;
>  
>      if (!cenv->mcg_cap) {
> -        monitor_printf(mon, "MCE injection not supported\n");
> -        return;
> +        error_setg(errp, "MCE injection not supported");
> +        return false;
>      }
>      if (bank >= bank_num) {
> -        monitor_printf(mon, "Invalid MCE bank number\n");
> -        return;
> +        error_setg(errp, "Invalid MCE bank number");
> +        return false;
>      }
>      if (!(status & MCI_STATUS_VAL)) {
> -        monitor_printf(mon, "Invalid MCE status code\n");
> -        return;
> +        error_setg(errp, "Invalid MCE status code");
> +        return false;
>      }
>      if ((flags & MCE_INJECT_BROADCAST)
>          && !cpu_x86_support_mca_broadcast(cenv)) {
> -        monitor_printf(mon, "Guest CPU does not support MCA broadcast\n");
> -        return;
> +        error_setg(errp, "Guest CPU does not support MCA broadcast");
> +        return false;
>      }
>  
>      run_on_cpu(cs, do_inject_x86_mce, RUN_ON_CPU_HOST_PTR(&params));
> @@ -539,6 +540,12 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
>              run_on_cpu(other_cs, do_inject_x86_mce, RUN_ON_CPU_HOST_PTR(&params));
>          }
>      }
> +    if (params.err->len) {
> +        error_setg(errp, "Failed to inject MCE");
> +        error_append_hint(errp, "%s", params.err->str);
> +        return false;
> +    }

This could be just

  if (*params.errp) {
     return false;
  }

> +    return true;
>  }
>  
>  static inline target_ulong get_memio_eip(CPUX86State *env)

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


