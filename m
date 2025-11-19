Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E054ECF34B7
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 14:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLjX9-0003Ii-HL; Wed, 19 Nov 2025 09:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vLjX8-0003IH-3i
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:51:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vLjX6-0006VZ-C6
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763563901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6RzCOw9GSiBNfRiXsDhSUHukPdNX4iZBvf/RI976f7U=;
 b=ENKbUBauEfJgufUNiW44w5AhOda7q2PoUQ+IPDBKlT84FGxmsX14Z0dGt35AGMDJ2NZoO4
 FBaO2M68jD8wY4FSFIDJrKnvOQTkJJD9OG+GGiwsAeXleKDuNhwfSQ1sq9Smrxl2l9oiox
 hgHnaAVw4wZxKmG8E600VYvmVilbc9A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-fMq7Wk5CPwKsPFVF7V2rxg-1; Wed,
 19 Nov 2025 09:51:36 -0500
X-MC-Unique: fMq7Wk5CPwKsPFVF7V2rxg-1
X-Mimecast-MFC-AGG-ID: fMq7Wk5CPwKsPFVF7V2rxg_1763563893
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0096118001FE; Wed, 19 Nov 2025 14:51:33 +0000 (UTC)
Received: from localhost (dhcp-192-224.str.redhat.com [10.33.192.224])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DDDA1800451; Wed, 19 Nov 2025 14:51:30 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com,
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v2 1/8] target/arm/machine: Improve traces on register
 mismatch during migration
In-Reply-To: <20251118160920.554809-2-eric.auger@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251118160920.554809-1-eric.auger@redhat.com>
 <20251118160920.554809-2-eric.auger@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 19 Nov 2025 15:51:28 +0100
Message-ID: <874iqqqdn3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Nov 18 2025, Eric Auger <eric.auger@redhat.com> wrote:

> Currently when the number of KVM registers exposed by the source is
> larger than the one exposed on the destination, the migration fails
> with: "failed to load cpu:cpreg_vmstate_array_len"
>
> This gives no information about which registers are causing the trouble.
>
> This patch rework the target/arm/machine code so that it becomes

s/rework/reworks/

> able to handle an input stream with a larger set of registers than
> the destination and print useful information about which registers
> are causing the trouble. The migration outcome is unchanged:
> - unexpected registers still will fail the migration
> - missing ones are printed but will not fail the migration, as done today.
>
> The input stream can contain MAX_CPREG_VMSTATE_ANOMALIES(10) extra
> registers compared to what exists on the target.
>
> If there are more registers we will still hit the previous
> "load cpu:cpreg_vmstate_array_len" error.
>
> At most, MAX_CPREG_VMSTATE_ANOMALIES missing registers
> and MAX_CPREG_VMSTATE_ANOMALIES unexpected registers are printed.
>
> Example:
>
> qemu-system-aarch64: kvm_arm_cpu_post_load Missing register in input stream: 0 0x6030000000160003 fw feat reg 3
> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 0 0x603000000013c103 op0:3 op1:0 crn:2 crm:0 op2:3
> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 1 0x603000000013c512 op0:3 op1:0 crn:10 crm:2 op2:2
> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 2 0x603000000013c513 op0:3 op1:0 crn:10 crm:2 op2:3
> qemu-system-aarch64: error while loading state for instance 0x0 of device 'cpu'
> qemu-system-aarch64: load of migration failed: Operation not permitted
>
> With TCG there no user friendly formatting of the faulting

s/there/there is/

> register indexes as with KVM. However the 2 added trace points
> help to identify the culprint indexes.

s/culprint/culprit/

...although "culprint" would make a nice portmanteau :)

>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v1 -> v2:
> - fixed some type in the commit msg
> ---
>  target/arm/cpu.h        |  6 +++++
>  target/arm/kvm.c        | 23 ++++++++++++++++
>  target/arm/machine.c    | 58 ++++++++++++++++++++++++++++++++++++-----
>  target/arm/trace-events |  7 +++++
>  4 files changed, 88 insertions(+), 6 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


