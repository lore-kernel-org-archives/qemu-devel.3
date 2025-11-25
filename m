Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB510D0EE0D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 17:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNwWE-0006w6-4z; Tue, 25 Nov 2025 12:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vNwVn-0006Zj-M5
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:07:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vNwVl-0005Fb-R5
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764090449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wa/9s/M61zVcMzMpgdq28pU/sb+HCZWmqF7dKdrbbbM=;
 b=FZ2AlEPssfBfZzednkDapWVIF6FvSc1uL5ELa+7MPDT87pQgoybx8MwCsVhweiFz1Mwo/U
 YB6f/wM/5Z8w1geca09LFNwmWm3QvCvcVGMSEWqzss/4HQ13z5cN+x5Qsnf5Scnc/O2EE3
 tM7xdGpkMVU4AWxYJhWHS4o0J2Va/4Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-7u1_XPwWMOKgbEnzxxTM6Q-1; Tue,
 25 Nov 2025 12:07:23 -0500
X-MC-Unique: 7u1_XPwWMOKgbEnzxxTM6Q-1
X-Mimecast-MFC-AGG-ID: 7u1_XPwWMOKgbEnzxxTM6Q_1764090442
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 317E2180123A; Tue, 25 Nov 2025 17:07:22 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C5D630044DC; Tue, 25 Nov 2025 17:07:20 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com,
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 04/11] target/arm/machine: Allow extra regs in the
 incoming stream
In-Reply-To: <20251125100859.506228-5-eric.auger@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251125100859.506228-1-eric.auger@redhat.com>
 <20251125100859.506228-5-eric.auger@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 25 Nov 2025 18:07:18 +0100
Message-ID: <87jyzeoxbt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Nov 25 2025, Eric Auger <eric.auger@redhat.com> wrote:

> Newer kernels may revoke exposure of KVM regs to userspace. This can
> happen when one notices that some registers were unconditionnally
> exposed whether they shall be conditionnally exposed for example.
>
> An example of such situation is: TCR2_EL1, PIRE0_EL1,  PIR_EL1.
> Associated kernel commits were:
> 0fcb4eea5345=C2=A0 KVM: arm64: Hide TCR2_EL1 from userspace when disabled=
 for guests
> a68cddbe47ef=C2=A0 KVM: arm64: Hide S1PIE registers from userspace when d=
isabled for guests
>
> Those commits were actual fixes but the cons is that is breaks forward
> migration on some HW. Indeed when migrating from an old kernel that
> does not feature those commits to a more recent one, destination
> qemu detects there are more KVM regs in the input migration stream than
> exposed by the destination host and the migration fails with:
> "failed to load cpu:cpreg_vmstate_array_len"
>
> This patchs adds the capability to define an array of register indexes
> that may exist in the migration incoming stream but may be not
> exposed by KVM on the destination.
>
> We provision for extra space in cpreg_vmstate_* arrays during the preload
> phase to allow the state to be saved without overflow, in case the
> registers only are in the inbound data.
>
> On postload we make sure to ignore them when analyzing potential
> mismatch between registers. The actual cpreg array is never altered
> meaning those registers are never accessed nor saved.
>
> The array will be populated with a dedicated array property.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v2 -> v3:
> - add a missing_as_expected trace point
>
> v1 -> v2:
> - get rid of the enforced/fake terminology
> - remove the useless array of fake regs. Only the number of missing
>   regs is needed
>
> RFC -> v1:
> - improve comment in target/arm/cpu.h (Connie)
> ---
>  target/arm/cpu.h        | 22 ++++++++++++++++++++++
>  target/arm/machine.c    | 30 +++++++++++++++++++++---------
>  target/arm/trace-events |  1 +
>  3 files changed, 44 insertions(+), 9 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


