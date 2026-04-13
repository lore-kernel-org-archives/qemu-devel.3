Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77EAF34C52
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHC9-0006sg-3s; Mon, 13 Apr 2026 09:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCHC8-0006sY-05
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCHC6-0005p7-03
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776086352;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DSVKvEnG2AmtI4dCWIctdV61Ja5Ms5AVxm9/sRciN4w=;
 b=W4OyC2GzY8V+oPndop/Ld+p63NGyHZeaHHD5ToxyI/N6W6wX86I3/HYJ8Gb8EGrLx7EaPY
 2YTXKIEBS8pab1QHyz0EY/+J2Go3z+Oa+l5YD2bXQYKOs3azRFvu2v4BRMrUqlE54K/u7H
 q8oNe9kBQoXrsesu6dCW6HFMP9Nztd0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-6iflTfPMMVicRLlPceZZ5w-1; Mon,
 13 Apr 2026 09:19:08 -0400
X-MC-Unique: 6iflTfPMMVicRLlPceZZ5w-1
X-Mimecast-MFC-AGG-ID: 6iflTfPMMVicRLlPceZZ5w_1776086347
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 104BB1956089; Mon, 13 Apr 2026 13:19:07 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3F283000C1F; Mon, 13 Apr 2026 13:19:04 +0000 (UTC)
Date: Mon, 13 Apr 2026 14:19:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-11.0?] target/i386: Mandate monitor 'info lapic' take
 a vCPU ID argument
Message-ID: <adztRa80X42EGP4Y@redhat.com>
References: <20260413130748.6631-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413130748.6631-1-philmd@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Apr 13, 2026 at 03:07:48PM +0200, Philippe Mathieu-Daudé wrote:
> With SMP configurations, using the 'current vCPU' under the
> monitor isn't recommended, as it changes during runtime. Better
> to specify which vCPU we want to monitor by its index. Deprecate
> the default of 'info lapic', mentioning an argument is expected,
> so we can remove this unpredictable behavior one day.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> The other command with this unpredictable behavior is 'info tlb'
> which we'll deal with differently, after the v11.0 release.

Aren't there quite a few more commands that rely on the HMP
"current" vCPU concept besides these two ?

info registers  comes to mind, 

There are others whic call mon_get_cpu(), which are not
directly caring about a specific CPU, eg 'info mem',
'memory_dump'

Why the rush to get lapic deprecated in 11.0 but not the
otherrs ?


> ---
>  docs/about/deprecated.rst | 6 ++++++
>  target/i386/cpu-apic.c    | 2 ++
>  hmp-commands-info.hx      | 3 +--
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index a6d6a713265..a62da93259a 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -169,6 +169,12 @@ The ``stopcapture`` command is deprecated and will be removed in a future releas
>  
>  The ``info capture`` command is deprecated and will be removed in a future release.
>  
> +``info lapic`` without ``apic-id`` argument (since 11.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +When no APIC ID is provided, ``info lapic`` defaults to the current vCPU.
> +This behavior is now deprecated, the ID will be mandatory in a future release.
> +
>  Host Architectures
>  ------------------
>  
> diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
> index eaa10ad2a3d..9ca569f62b8 100644
> --- a/target/i386/cpu-apic.c
> +++ b/target/i386/cpu-apic.c
> @@ -97,6 +97,8 @@ void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
>              cpu_synchronize_state(cs);
>          }
>      } else {
> +        monitor_printf(mon, "Not specifying the local apic id is deprecated"
> +                       " (using the current CPU one)\n");
>          cs = mon_get_cpu(mon);
>      }
>  
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 74c741f80e2..e4206d329fc 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -118,8 +118,7 @@ ERST
>          .name       = "lapic",
>          .args_type  = "apic-id:i?",
>          .params     = "[apic-id]",
> -        .help       = "show local apic state (apic-id: local apic to read, default is which of current CPU)",
> -
> +        .help       = "show local apic state (apic-id: local apic to read)",
>          .cmd        = hmp_info_local_apic,
>      },
>  #endif
> -- 
> 2.53.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


