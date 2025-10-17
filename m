Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397A3CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9lwa-0001Uz-Nt; Fri, 17 Oct 2025 11:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1v9lwX-0001Ui-2L
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1v9lwI-0004d3-NB
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760713209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6V1FrDJ+Af8kWa47B2peRWpCLaGtgrvraDenPng+ps=;
 b=c3on27P1fBT5FyaAqACr0eUn5KVYP+gWckClRM0nDwCmBF0aLQsGKQOBhz0mJn+inSjuzZ
 veHA1PywSP2XdpfpdZCaMzZkLkCNcohw60QFXV3iCuC6PPVhF5gem3JZq3UzEmMVkhGK7q
 C2mCIN7NEF5dJqwGcKzIwMgMYHZw6Ko=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-_rO3DNDwNmmRgHfu3vmzZA-1; Fri,
 17 Oct 2025 11:00:03 -0400
X-MC-Unique: _rO3DNDwNmmRgHfu3vmzZA-1
X-Mimecast-MFC-AGG-ID: _rO3DNDwNmmRgHfu3vmzZA_1760713202
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 934DD195422C; Fri, 17 Oct 2025 15:00:01 +0000 (UTC)
Received: from localhost (unknown [10.45.226.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69B24180035A; Fri, 17 Oct 2025 14:59:58 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com,
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [RESEND PATCH 1/7] target/arm/machine: Improve traces on
 register mismatch during migration
In-Reply-To: <20251016140039.250111-2-eric.auger@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251016140039.250111-1-eric.auger@redhat.com>
 <20251016140039.250111-2-eric.auger@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Fri, 17 Oct 2025 16:59:56 +0200
Message-ID: <877bwtvaj7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, Oct 16 2025, Eric Auger <eric.auger@redhat.com> wrote:

More information is really valuable here. I have some nits :)

> Currently whenthe number of KVM registers exposed by the source is

s/whenthe/when the/

> larger than the one exposed on the destination, the migration fails
> with: "failed to load cpu:cpreg_vmstate_array_len"
>
> This gives no information about which registers are causing the trouble.
>
> This patches rework the target/arm/machine code so that it becomes

s/patches rework/patch reworks/

> able to handle an input stream with a larger set of registers than
> the destination and print useful information about which registers
> are causing the trouble. The migration outcome is unchanged:
> - unexpected registers still will fail the migration
> - missing ones are print but will not fail the migration, as done today.

s/print/printed/

>
> The input stream can contain MAX_CPREG_VMSTATE_ANOMALIES(10) extra
> registers compared to what exists on the target.
>
> If there are more registers we will still hit the previous
> "load cpu:cpreg_vmstate_array_len" error.
>
> At most, MAX_CPREG_VMSTATE_ANOMALIES missing registers
> and MAX_CPREG_VMSTATE_ANOMALIES unexpected registers are print.

s/print/printed/

If we really get tons of register discrepancies, I'd expect the reason for
that to be something more obvious, so limiting should be fine.

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
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/cpu.h        |  6 +++++
>  target/arm/kvm.c        | 23 ++++++++++++++++
>  target/arm/machine.c    | 58 ++++++++++++++++++++++++++++++++++++-----
>  target/arm/trace-events |  7 +++++
>  4 files changed, 88 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index bf221e6f97..a7ed3f34f8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -936,6 +936,12 @@ struct ArchCPU {
>      uint64_t *cpreg_vmstate_values;
>      int32_t cpreg_vmstate_array_len;
>  
> +    #define MAX_CPREG_VMSTATE_ANOMALIES 10
> +    uint64_t cpreg_vmstate_missing_indexes[MAX_CPREG_VMSTATE_ANOMALIES];
> +    int32_t cpreg_vmstate_missing_indexes_array_len;
> +    uint64_t cpreg_vmstate_unexpected_indexes[MAX_CPREG_VMSTATE_ANOMALIES];
> +    int32_t cpreg_vmstate_unexpected_indexes_array_len;

"indices"?

> +
>      DynamicGDBFeatureInfo dyn_sysreg_feature;
>      DynamicGDBFeatureInfo dyn_svereg_feature;
>      DynamicGDBFeatureInfo dyn_smereg_feature;

(...)


