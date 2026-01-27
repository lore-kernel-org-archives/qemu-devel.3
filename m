Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B724D2FEC0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 17:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkma1-0003jH-0L; Tue, 27 Jan 2026 12:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vkmZy-0003fE-KK
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 12:10:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vkmZw-0004tS-4l
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 12:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769533808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQbSxEII8/ndV80hzudIpCHKm8xiVJLAsTyNyo464hM=;
 b=fG2PTujFFbSBAPGY+2xbDsyH9EKlpoyGmWKiMyOY3W9qEXyKwz33SDqmUHkA2UO6lavD06
 hTyiOjC36y0Ymx0sd+AGN3iEdJ+KAi6ERkB+M/9cd4jYtv/7yGTqKJQq0+jEGQIUK8AkEC
 V5LHPGdRpJxATAL3joloswZZVremLCE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-2nDHDtrsN7mgI_c_vki6fg-1; Tue,
 27 Jan 2026 12:10:05 -0500
X-MC-Unique: 2nDHDtrsN7mgI_c_vki6fg-1
X-Mimecast-MFC-AGG-ID: 2nDHDtrsN7mgI_c_vki6fg_1769533803
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DF101944F12; Tue, 27 Jan 2026 17:10:03 +0000 (UTC)
Received: from localhost (pixel-6a.str.redhat.com [10.33.192.205])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88B431800109; Tue, 27 Jan 2026 17:10:02 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com,
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v6 03/11] target/arm/cpu: Allow registers to be hidden
In-Reply-To: <20260126165445.3033335-4-eric.auger@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260126165445.3033335-1-eric.auger@redhat.com>
 <20260126165445.3033335-4-eric.auger@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Tue, 27 Jan 2026 18:09:59 +0100
Message-ID: <87zf5zrnh4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 26 2026, Eric Auger <eric.auger@redhat.com> wrote:

> More recent kernels sometimes expose new registers in an
> unconditionnal manner. This situation breaks backward migration
> as qemu notices there are more registers in the input stream
> than supported on the destination host. This leads to a
> "failed to load cpu:cpreg_vmstate_array_len" error.
>
> A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
> pseudo FW register in v6.16 by commit C0000e58c74e (=E2=80=9CKVM: arm64:
> Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2=E2=80=9D). Trying to do backward
> migration from a host kernel that features the commit to a destination
> host that doesn't, fail with above error.
>
> Currently QEMU is not using that feature so ignoring this latter
> is not a problem. An easy way to fix the migration issue is to teach
> qemu we don't care about that register and we can simply ignore it
> when syncing its state during migration.
>
> This patch introduces an array of such hidden registers. Soon it will
> be settable through an array property.
>
> If hidden, the register is moved out of the array of cpreg which is
> built in kvm_arm_init_cpreg_list(). That way their state won't be
> synced.
>
> To extend that functionality to TCG, do the same in add_cpreg_to_list()
> and count_cpreg().
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>
> ---
> v2 -> v3:
> - use kvm_regidx
>
> v1 -> v2:
> - Move the property in a separate patch
> - improve the commit msg
> - change the trace point to just print info in
>   kvm_arm_init_cpreg_list()
> - improve comment in cpu.h (Connie)
>
> target/arm/helper: Skip hidden registers
>
> In case a cpreg is hidden, skip it when initialing the cpreg
> list.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

This looks a bit weird, probably due to patch folding... but I'm happy
to have my R-b apply to the whole patch :)

> ---
>  target/arm/cpu.h        | 20 ++++++++++++++++++++
>  target/arm/helper.c     | 12 +++++++++++-
>  target/arm/kvm.c        | 12 +++++++++++-
>  target/arm/trace-events |  2 ++
>  4 files changed, 44 insertions(+), 2 deletions(-)


