Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E1ACAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 15:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwj6V-00041H-H9; Thu, 11 Sep 2025 11:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uwj6R-000409-7I
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uwj6O-0000Nw-Cu
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757604047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tOjExAn4JGRhPRDQ0WJJbK5lyids4y2Yr8Uf8gzSoHE=;
 b=PnlsVl99aX+TUqlS7rCCPV6I02IbJ0mDsmcl51Cm+n9/k/45iEXJdsaYvYxMmrwmAnZC3Z
 v8VxGYPSUXHG7sF82tGYtcdDIMx1ayzXAv8jAoPu9OftAdc4raAZxhhPSqErw6km7ZyO1V
 BZvSPi7nepLwP6BcAdMWmxHEkzkapqM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-Y10K22_aO_KjI0a9Yrc-7g-1; Thu,
 11 Sep 2025 11:20:43 -0400
X-MC-Unique: Y10K22_aO_KjI0a9Yrc-7g-1
X-Mimecast-MFC-AGG-ID: Y10K22_aO_KjI0a9Yrc-7g_1757604042
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 858BA195609E; Thu, 11 Sep 2025 15:20:42 +0000 (UTC)
Received: from localhost (unknown [10.45.225.185])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B7371944CCA; Thu, 11 Sep 2025 15:20:41 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Eric Auger
 <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
Subject: Re: [PATCH v2] arm/kvm: report registers we failed to set
In-Reply-To: <CAFEAcA-_FgV69C6mKk5XiaQwj=LQD=C9ecjcm_gGuhEjYD3dyw@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250902092732.706338-1-cohuck@redhat.com>
 <CAFEAcA-_FgV69C6mKk5XiaQwj=LQD=C9ecjcm_gGuhEjYD3dyw@mail.gmail.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Thu, 11 Sep 2025 17:20:38 +0200
Message-ID: <877by5f22h.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Sep 11 2025, Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 2 Sept 2025 at 10:27, Cornelia Huck <cohuck@redhat.com> wrote:
>> +static gchar *kvm_print_register_name(uint64_t regidx)
>> +{
>> +        switch ((regidx & KVM_REG_ARM_COPROC_MASK)) {
>> +        case KVM_REG_ARM_CORE:
>> +            return g_strdup_printf("core reg %lx", regidx);
>> +        case KVM_REG_ARM_DEMUX:
>> +            return g_strdup_printf("demuxed reg %lx", regidx);
>
> You can't print a uint64_t with %lx. I suppose this code is
> only going to get compiled on a 64-bit host but we might
> someday want to move it so we can pretty-print registers
> elsewhere (e.g. in cpu_post_load() where we fail for
> "incoming migration stream has sysreg X but we don't know it").

OK, if we want to have this as some kind of generic function eventually,
it needs to become PRIx64.


