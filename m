Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E97A606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EyaTYsWE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMN2b-0002FH-PO; Thu, 29 Oct 2026 06:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xMN2W-0002EE-OS
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xMN2T-0001lB-Ti
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793268436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UU4VjIFEhIcjr/ep0pDiBDzQhP8rVCjcSoth2sg4MOA=;
 b=EyaTYsWE25pk4wd63Gr4UT0aRFhcZn74R9UVBnPBRVWNtsFH8kxeM5cQOzIl5mxiS/MZOo
 L7Oy0ZvkQpzUIU6Bew8iVSwuw/d3aAjZ0SfXnNjEVjlLlrmUNxfFuCjrEfF/JjcKxNfq4D
 pbYiXsVq93XdPosTUPFrHYiIwjVN8ek=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-2XDBETXjO1S6z2j4S9Le5Q-1; Thu,
 29 Oct 2026 06:07:13 -0400
X-MC-Unique: 2XDBETXjO1S6z2j4S9Le5Q-1
X-Mimecast-MFC-AGG-ID: 2XDBETXjO1S6z2j4S9Le5Q_1793268431
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A57201955DCD; Thu, 29 Oct 2026 10:07:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49442433; Thu, 29 Oct 2026 10:07:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com,
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com,
 milesg@linux.ibm.com, farman@linux.ibm.com
Cc: armbru@redhat.com, mbawa@redhat.com
Subject: Re: [PATCH for-11.2 7/9] target/kvm: Pass an Error handle to
 kvm_arch_init_vcpu
In-Reply-To: <20261029092307.281287-8-eric.auger@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-8-eric.auger@redhat.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Thu, 29 Oct 2026 11:07:06 +0100
Message-ID: <87o6cc252t.fsf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29 2026, Eric Auger <eric.auger@redhat.com> wrote:

> The 2 callers of kvm_arch_init_vcpu(), namely kvm_rebind_vcpus()
> and kvm_init_vcpu() are passed an Error handle. So it is a pity
> not using it in kvm_arch_init_vcpu(). Also, in the future, the
> error handle could be passed to other functions called inside.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/system/kvm.h       |  2 +-
>  accel/kvm/kvm-all.c        | 15 +++++++--------
>  target/arm/kvm.c           | 26 +++++++++++++-------------
>  target/i386/kvm/kvm.c      | 22 ++++++++++++----------
>  target/loongarch/kvm/kvm.c | 27 +++++++++------------------
>  target/ppc/kvm.c           | 10 +++++++---
>  target/riscv/kvm/kvm-cpu.c |  6 +++++-
>  target/s390x/kvm/kvm.c     |  2 +-
>  8 files changed, 55 insertions(+), 55 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


