Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BE8CF395B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 15:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srIiu-0006Zf-Ow; Thu, 19 Sep 2024 11:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1srIis-0006Ya-6U
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 11:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1srIiq-0007e5-0u
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 11:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726758330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CRBaIT1ZiEL/UGx9VPyJK7064AwhFwjo48bUXISveq8=;
 b=JBwG3LZvE/HZGQCnvDmvEaVgoNcVRkuSaH8olqwE+Tb4iqzI+QXWbyavP2JR+Fb68bhzsf
 mNJ4YcT/es9VMyP9kOgH7aRoWNBo0UHo5JIe9RUxo3jki37cj+7IcJPCeF+lmy5EuBxi6V
 s6AOFMONb0dXe1coM6c5fwn/pPgAQtA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-9YGylzwgNteCDK_4Ujoq1g-1; Thu,
 19 Sep 2024 11:05:27 -0400
X-MC-Unique: 9YGylzwgNteCDK_4Ujoq1g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7260E193611E; Thu, 19 Sep 2024 15:05:25 +0000 (UTC)
Received: from localhost (unknown [10.39.194.77])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EB8719560AF; Thu, 19 Sep 2024 15:05:24 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, darren@os.amperecomputing.com
Subject: Re: [PATCH V2] arm/kvm: add support for MTE
In-Reply-To: <879f7e65-070a-4d9b-b70f-60576b7b5319@os.amperecomputing.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240912091616.393685-1-gankulkarni@os.amperecomputing.com>
 <0faf9a7c-0400-482c-974f-7b70e1d58202@linaro.org>
 <879f7e65-070a-4d9b-b70f-60576b7b5319@os.amperecomputing.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Thu, 19 Sep 2024 17:05:21 +0200
Message-ID: <8734lvu1ji.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 19 2024, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:

> I have modified as below diff to keep TCG if loop as it is and adding if 
> for KVM case to clear/mask the MTE bits if MTE in KVM mode is not 
> enabled by user command(if no mte=on).
>
> Is below diff makes sense?
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index a59417aac8..523996576d 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2390,15 +2390,20 @@ static void arm_cpu_realizefn(DeviceState *dev, 
> Error **errp)
>
>   #ifndef CONFIG_USER_ONLY
>           /*
> -         * If we do not have tag-memory provided by the TCG
> -         * nor MTE at KVM enabled, reduce MTE support to
> -         * instructions enabled at EL0.
> +         * If we do not have tag-memory provided by the TCG,
> +         * reduce MTE support to instructions enabled at EL0.
>            * This matches Cortex-A710 BROADCASTMTE input being LOW.
>            */
> -        if (cpu->tag_memory == NULL && !cpu->kvm_mte) {
> +        if (tcg_enabled() && cpu->tag_memory == NULL) {
>               cpu->isar.id_aa64pfr1 =
>                   FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
>           }
> +
> +        /* Disable MTE, if it is not enabled by the user for KVM mode.
> +         */
> +        if (kvm_enabled() && !cpu->kvm_mte) {
> +                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
> +        }
>   #endif
>       }

Wouldn't that be a possibly guest-visible change?


