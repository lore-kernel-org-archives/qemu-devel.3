Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC970E6F093
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3K1-000668-0H; Tue, 23 Dec 2025 09:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vY3Jr-00064J-MJ
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vY3Jp-0001J7-Bp
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766499883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUtB8EDzfz0urX/plB0MRggkC7CeBvyngYHMBVwZCwY=;
 b=VjdcBDwEtomqdi+ltmYiTYeiCYUR53KPV64jd55Tnhx1yEwjmZA9Fz36fU9zU59uX9FoUp
 sr7jfQNnTjwNJMOGjXkUTsZlhcAfIhjkFone0b3l0AXWGiNsJmRqOxAbpn+54OUT9WUlYB
 3EwzzAQ0swumo2uYn0ybUvoY5Byk/eA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-NxXXnhsFN6OIYCG101uDMw-1; Tue,
 23 Dec 2025 09:24:41 -0500
X-MC-Unique: NxXXnhsFN6OIYCG101uDMw-1
X-Mimecast-MFC-AGG-ID: NxXXnhsFN6OIYCG101uDMw_1766499880
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CA66195F156; Tue, 23 Dec 2025 14:24:40 +0000 (UTC)
Received: from localhost (unknown [10.44.32.162])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADAC8180049F; Tue, 23 Dec 2025 14:24:38 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com,
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v4 03/10] target/arm/cpu: Allow registers to be hidden
In-Reply-To: <20251222134110.3649287-4-eric.auger@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251222134110.3649287-1-eric.auger@redhat.com>
 <20251222134110.3649287-4-eric.auger@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Tue, 23 Dec 2025 15:24:35 +0100
Message-ID: <87fr91p97g.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
>
> ---
>
> v2 -> v3:
> - use kvm_regidx

This looks a bit odd after squashing the patches, maybe edit the patch
description?

Otherwise,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

> ---
>  target/arm/cpu.h        | 20 ++++++++++++++++++++
>  target/arm/helper.c     | 12 +++++++++++-
>  target/arm/kvm.c        | 12 +++++++++++-
>  target/arm/trace-events |  2 ++
>  4 files changed, 44 insertions(+), 2 deletions(-)


