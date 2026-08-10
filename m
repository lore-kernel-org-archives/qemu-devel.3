Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CACC5B567
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 17:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtU6w-0006O4-F9; Mon, 10 Aug 2026 13:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtU6s-0006Ne-Qj
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 13:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtU6n-0005we-3D
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 13:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786384099;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdoyu8UzLgfH9LJ+vJ/rgMybkp+L19KR/0EXmN4VSwY=;
 b=JRiOsFd8GmY0nik3QvAxBuQzsbHITb9jPeNTA+Di+AanBf5JaC7Yn2FnJDhhulPTgTbi94
 56uELqk5KuzIyMcfcaJ+dhPTMxErtf54NGGVZ0s3I93+jbjhtvca+rcomZHwLBjRx+IjE2
 XlPEyLO8a9HnMSz8amY6Yzcx8Zgt5h8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-cuiezZVKPvuwuoCD7y2LTg-1; Mon,
 10 Aug 2026 13:48:15 -0400
X-MC-Unique: cuiezZVKPvuwuoCD7y2LTg-1
X-Mimecast-MFC-AGG-ID: cuiezZVKPvuwuoCD7y2LTg_1786384095
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5E971956095; Mon, 10 Aug 2026 17:48:14 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6D76195DF91; Mon, 10 Aug 2026 17:48:13 +0000 (UTC)
Date: Mon, 10 Aug 2026 18:48:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 08/39] system: decouple qmp_inject_nmi() from Monitor
Message-ID: <anoO2n0-ekf3EpFY@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-8-8af31bc54c61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626-qemu-no-hmp-v2-8-8af31bc54c61@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Fri, Jun 26, 2026 at 01:19:09AM +0400, Marc-André Lureau wrote:
> Use first_cpu directly instead of going through monitor_get_cpu_index(),
> as this is HMP-territory. QMP doesn't have a `cpu` command, we should
> add arguments instead when needed.
> 
> Update the inject-nmi doc to accurately describe per-architecture NMI
> delivery.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/machine.json | 5 +++--
>  system/cpus.c     | 7 +++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b87..03461f5f723 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -432,8 +432,9 @@
>  ##
>  # @inject-nmi:
>  #
> -# Injects a Non-Maskable Interrupt into the default CPU (x86/s390) or
> -# all CPUs (ppc64).  The command fails when the guest doesn't support
> +# Injects a Non-Maskable Interrupt into the virtual machine.  The NMI
> +# is delivered to all vCPUs (x86, hppa, ppc64) or to the first vCPU
> +# (s390).  The command fails when the guest doesn't support
>  # injecting.
>  #
>  # Since: 0.14



> diff --git a/system/cpus.c b/system/cpus.c
> index 49f6daec3cd..6e3ef0afeca 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -915,6 +915,9 @@ exit:
>  
>  void qmp_inject_nmi(Error **errp)
>  {
> -    nmi_monitor_handle(monitor_get_cpu_index(monitor_cur()), errp);
> +    int cpu_index = UNASSIGNED_CPU_INDEX;
> +    if (first_cpu) {
> +        cpu_index = first_cpu->cpu_index;
> +    }

I'm wondering how this "if" logic turns into the behaviour documented
for x86/hppa/pc64  vs  s390 ? Don't all those arches have 'first_cpu'
defined, such that this changes semantics to 'first vCPU' instead of
'all vCPUs' ? 

> +    nmi_monitor_handle(cpu_index, errp);
>  }
> -
> 
> -- 
> 2.54.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


