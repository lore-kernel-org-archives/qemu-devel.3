Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69118E6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3MI-0007n8-9V; Tue, 23 Dec 2025 09:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vY3MD-0007kb-6A
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:27:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vY3MB-0002pc-Ms
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8CdsuGFlWbmx9W123k4NnksvkPSJHLJkDLmA/H6QUQ=;
 b=Ga7Nl78tH1Hd5R8kluoZuzZco5Lbz+8liIxebcQwEB/NSulAPfzxK5ZGITd48+8AzLG3W8
 5kG0y9zI3Ob/yaI1CIlkFkIVC5CYOOdzAWslElnDjzw7e+GHUVjarROR4DDFwMIYcvAFK4
 kjPoAv3Vjuv99X2aZnpl5jQXjg7JsrY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-nvTSlG_9P6eogh0n574YKA-1; Tue,
 23 Dec 2025 09:27:17 -0500
X-MC-Unique: nvTSlG_9P6eogh0n574YKA-1
X-Mimecast-MFC-AGG-ID: nvTSlG_9P6eogh0n574YKA_1766500036
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62E4018002C9; Tue, 23 Dec 2025 14:27:16 +0000 (UTC)
Received: from localhost (unknown [10.44.32.162])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 788E919560A7; Tue, 23 Dec 2025 14:27:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com,
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v4 07/10] target/arm/cpu: Expose x-mig-hidden-regs and
 x-mig-safe-missing-regs properties
In-Reply-To: <20251222134110.3649287-8-eric.auger@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251222134110.3649287-1-eric.auger@redhat.com>
 <20251222134110.3649287-8-eric.auger@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Tue, 23 Dec 2025 15:27:11 +0100
Message-ID: <87cy45p934.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> Allows to set both array properties along with arm cpus. Their "x-" prefix
> reminds that those shall be used carefully for distro specific use cases
> to enable cross kernel migration.
>
> This will allow to define such compat machine props like:
>
>     static GlobalProperty arm_virt_kernel_compat_10_1[] = {
>         /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
>         { TYPE_ARM_CPU, "x-mig-hidden-regs", "0x6030000000160003" },
>         { TYPE_ARM_CPU, "x-mig-safe-missing-regs",
>           /* TCR_EL1, PIRE0_EL1, PIR_EL1 */
>           "0x603000000013c103, 0x603000000013c512, 0x603000000013c513" },
>     }
>
> The first one means KVM_REG_ARM_VENDOR_HYP_BMAP_2 shall always
> be hidden for machine types older than 10.1. The second one means
> that along with 10.1 machine type we may receive in the incoming
> migration stream, 3 registers that are unknown on destination.
>
> Obviously, using the reg index as defined in
> linux/Documentation/virt/kvm/api.rst is not user friendly. However
> These options are supposed to be used to enable specific, rare cases,
> and in general, by people trying to configure distribution defaults
> familiar with those specific cases.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v3 -> v4:
> - typo and rewording in the commit description (Connie)
> ---
>  target/arm/cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


