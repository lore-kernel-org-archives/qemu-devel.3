Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872FAC55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 06:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr8ua-0004LO-91; Tue, 04 Aug 2026 02:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wr8uZ-0004L7-4c
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 02:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wr8uX-0006Ol-PR
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 02:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785825960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Til7dJ+LBxYd932gQSxYw4R3kFQ/CW4QMe0aradBus=;
 b=MpBZgyLa4EiBQ4k255ZrYhe9h6P14Eb/DAb49Eh/GCNsEpq7tAld34FzOXettWcjn2mBi2
 dnrdR311L3ZBUXYm6enusF2JDmetN7aymJ8CivZgx6MMS8k/+1OL3yGnSpYCoGgI+H/GaI
 0Ffvt0hnLRLuktQxlEHXR2LauHnDGxY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-SV9xW_IvNheFpOtuyKHrYA-1; Tue,
 04 Aug 2026 02:45:57 -0400
X-MC-Unique: SV9xW_IvNheFpOtuyKHrYA-1
X-Mimecast-MFC-AGG-ID: SV9xW_IvNheFpOtuyKHrYA_1785825955
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 408171956048; Tue,  4 Aug 2026 06:45:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51EB641C; Tue,  4 Aug 2026 06:45:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BEBB521E6920; Tue, 04 Aug 2026 08:45:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  kvmarm@lists.linux.dev,
 eric.auger@redhat.com,  cohuck@redhat.com,  peter.maydell@linaro.org,
 richard.henderson@linaro.org,  maz@kernel.org,  oliver.upton@linux.dev,
 berrange@redhat.com,  abologna@redhat.com,  jdenemar@redhat.com,
 gshan@redhat.com,  skolothumtho@nvidia.com,  sebott@redhat.com,
 philmd@linaro.org,  yangjinqian1@huawei.com,  shaju.abraham@nutanix.com,
 mark.caveayland@nutanix.com,  prerna.saxena@nutanix.com
Subject: Re: [RFC PATCH v3 16/19] qmp: add query-cpu-props-info command
In-Reply-To: <20260716213858.609699-17-khushit.shah@nutanix.com> (Khushit
 Shah's message of "Thu, 16 Jul 2026 21:38:55 +0000")
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-17-khushit.shah@nutanix.com>
Date: Tue, 04 Aug 2026 08:45:50 +0200
Message-ID: <878q6m5qox.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Khushit Shah <khushit.shah@nutanix.com> writes:

> Introduce the 'query-cpu-props-info' QMP command. For CPU model
> properties it reports the type (boolean or number) and the set of values
> supported under the active accelerator and host.
>
> For numbers the supported values are expressed as a list of inclusive
> {min, max} ranges; for booleans as the list of allowed true/false
> values.
>
> The command and its return types (CpuPropertyType, CpuPropertyInfo and
> friends) are defined in qapi/machine.json rather than an Arm-specific
> schema, since the concept applies to other targets (e.g. x86, riscv)
> too. Target that do not implement it return an error.
>
> The Arm/KVM implementation spins up a scratch "host" vCPU object,
> walks its QOM properties: SYSREG_ ID-register fields become 'number'
> properties whose ranges come from arm_field_get_supported_values(),
> and the advertised feature toggles become 'boolean' properties.
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>

This explains what the command does and how it's implemented.  It's
silent on the most important aspect: why do we want the command?  What
is its intended purpose?


