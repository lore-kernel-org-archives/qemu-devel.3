Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F44AC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 16:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPkT9-0002Tn-I1; Thu, 12 Jun 2025 12:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uPkT3-0002RO-0B
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 12:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uPkT1-0004WK-5f
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 12:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749744469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+uVuub5Ky1bzhq7P2Mnf0OieKw5ECMBGCTcKWAjvVoM=;
 b=E11ZqQqVz6WOQ3AiJAA8hadVCXk5CF1K0RUrNzhKrFV4bWKUCgqapryCCNBegykxlWjuN7
 520KV6KsHbnbtNDQ1zARFgP4wpPQ0SlsxwFrR8apD+T2JjLixBu9gUvG8dswH13K+Cs96f
 8/Z0LDaZP3W4pk/1G3a0pZ0PdmFwqY4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-Uv3enwPvPyq8CXgvFQds9w-1; Thu,
 12 Jun 2025 12:07:47 -0400
X-MC-Unique: Uv3enwPvPyq8CXgvFQds9w-1
X-Mimecast-MFC-AGG-ID: Uv3enwPvPyq8CXgvFQds9w_1749744465
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D1B818001D1; Thu, 12 Jun 2025 16:07:44 +0000 (UTC)
Received: from localhost (unknown [10.45.224.54])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED9A019560AF; Thu, 12 Jun 2025 16:07:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com, agraf@csgraf.de, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v7 13/14] arm/cpu: switch to a generated cpu-sysregs.h.inc
In-Reply-To: <CAFEAcA_Ju4QBUwiOyt9thPxuAFMcm6jVTZHpE8FFJeed5cJgsg@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250515153907.151174-1-cohuck@redhat.com>
 <20250515153907.151174-14-cohuck@redhat.com>
 <CAFEAcA_Ju4QBUwiOyt9thPxuAFMcm6jVTZHpE8FFJeed5cJgsg@mail.gmail.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Thu, 12 Jun 2025 18:07:40 +0200
Message-ID: <871prp9c4z.fsf@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 12 2025, Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 15 May 2025 at 16:40, Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> Generated against Linux 6.14-rc1.
>>
>> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>
> Does it make sense to include all these extra registers?
> Some of them are not simple ID registers at all,
> for example ID_CCSIDR_EL1 is an array of registers, not
> a single value (in QEMU, stored in cpu->ccsidr[]),
> and CSSELR_EL1 is not an ID register at all, it's a
> normal read/write sysreg.

Oops, I think the generator needs to check for op1=={0,1,3} instead of
including op1==2...

[Another issue that came up in recent discussions for the cpu model
series is that recent kernels have made {MIDR,REVIDR,AIDR}_EL1 writable,
but even though they are in the range the kernel reports writable
registers in, the source sysreg file does not include them. I've changed
the script to add them manually so far, but not sure if that is the
best solution here.]


