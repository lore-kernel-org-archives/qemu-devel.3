Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72827E6F090
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Px-0002IB-1k; Tue, 23 Dec 2025 09:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vY3PA-00016a-Ds
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vY3P6-0003lA-4Q
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XtgQ7msBqfAheb1t0IsmW4BuhZDd8vLXk7X9sBGXXVU=;
 b=OcmsU61SDnhdMsBq6czZZSyPdURnNCO+v4SYeL5DpgRbpcMv6tXCT8bycYQYrFn9eNghuC
 uTk0wK36QggM3QX+tm2YipPk/3reYXW7yMpSHTAJkoQUkR183jZz7PxHG22Xz5i2GKxxmo
 XUAlbwFYXSdyT66tEbYiYtC+kR1SBJk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-dBOiewXnOnKhZffF-PUgcQ-1; Tue,
 23 Dec 2025 09:30:19 -0500
X-MC-Unique: dBOiewXnOnKhZffF-PUgcQ-1
X-Mimecast-MFC-AGG-ID: dBOiewXnOnKhZffF-PUgcQ_1766500217
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B67471800642; Tue, 23 Dec 2025 14:30:17 +0000 (UTC)
Received: from localhost (unknown [10.44.32.162])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B28621955F43; Tue, 23 Dec 2025 14:30:16 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com,
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v4 08/10] hw/arm/virt: Declare AArch32 DBGDTRTX as safe
 to ignore in incoming stream
In-Reply-To: <20251222134110.3649287-9-eric.auger@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251222134110.3649287-1-eric.auger@redhat.com>
 <20251222134110.3649287-9-eric.auger@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Tue, 23 Dec 2025 15:30:14 +0100
Message-ID: <87a4z9p8y1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 22 2025, Eric Auger <eric.auger@redhat.com> wrote:

> With the new infrastructure in place it is now feasible to teach
> qemu that it is safe to ignore a sysreg in the incoming migration
> stream. So with the plan to revert commit 4f2b82f60431 ("target/arm:
> Reinstate bogus AArch32 DBGDTRTX register for migration compat) from

<pedantic> Missing closing '"' </pedantic>

> qemu 11 onwards, let's add a compat in 10.2 machine options stating

QEMU 11.0?

> that this reg is safe to ignore. from 11.0 onwards we will not need
> that register anymore.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v3 -> v4:
> - add a comment related to DBGDTRTX (Connie)
> ---
>  hw/arm/virt.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ec0af8e6e7..00948887a2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -100,6 +100,15 @@ static GlobalProperty arm_virt_compat_defaults[] = {
>  static const size_t arm_virt_compat_defaults_len =
>      G_N_ELEMENTS(arm_virt_compat_defaults);
>  
> +/* Register erronously exposed on 10.2 and earlier */
> +#define DBGDTRTX 0x40200000200e0298
> +
> +static GlobalProperty arm_virt_compat_10_2[] = {
> +    { TYPE_ARM_CPU, "x-mig-safe-missing-regs", stringify(DBGDTRTX)},
> +};
> +static const size_t arm_virt_compat_10_2_len =
> +    G_N_ELEMENTS(arm_virt_compat_10_2);
> +
>  /*
>   * This cannot be called from the virt_machine_class_init() because
>   * TYPE_VIRT_MACHINE is abstract and mc->compat_props g_ptr_array_new()
> @@ -3536,6 +3545,7 @@ type_init(machvirt_machine_init);
>  
>  static void virt_machine_10_2_options(MachineClass *mc)
>  {
> +    compat_props_add(mc->compat_props, arm_virt_compat_10_2, arm_virt_compat_10_2_len);
>  }
>  DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
>  

Hm, maybe rebase this on top of the new machine types?


