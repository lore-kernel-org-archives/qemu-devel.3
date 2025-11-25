Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C47D0EE0D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 17:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNwUC-00055U-0a; Tue, 25 Nov 2025 12:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vNwTH-0004n7-Hp
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:04:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vNwTE-0004Ux-Rd
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764090290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7w1aHtTFT/JcF6TqW06vbQKPaLyGII/eXkBIWVoDFr0=;
 b=PjrC4AwqppUUzBLl+3f2RMZkW+f+iIx5rbJTFCq6YcMS1Nrx5wOWNoACynysnE9sKfQEub
 n/yIvpA9JqNF/A5f0ai3LF+0kdsruL+zoiyKjTifKtnH/LAFZcATKmSY9vz5CIo/pQt3Qn
 5LrCkax0A3RE9M7wF4dXa8B6ZYOeqHQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-RhcSYJ2LNmOlWHJQy5zONg-1; Tue,
 25 Nov 2025 12:04:47 -0500
X-MC-Unique: RhcSYJ2LNmOlWHJQy5zONg-1
X-Mimecast-MFC-AGG-ID: RhcSYJ2LNmOlWHJQy5zONg_1764090282
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A67B1956066; Tue, 25 Nov 2025 17:04:42 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED79C195608E; Tue, 25 Nov 2025 17:04:40 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com,
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 03/11] target/arm/cpu: Allow registers to be hidden
In-Reply-To: <20251125100859.506228-4-eric.auger@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251125100859.506228-1-eric.auger@redhat.com>
 <20251125100859.506228-4-eric.auger@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 25 Nov 2025 18:04:38 +0100
Message-ID: <87ms4aoxg9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Nov 25 2025, Eric Auger <eric.auger@redhat.com> wrote:

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

I'm wondering whether the patch description should also mention non-KVM
cases (e.g. the bogus reg that was exposed). It might also make sense to
merge patch 5 here?

>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Otherwise, LGTM.


