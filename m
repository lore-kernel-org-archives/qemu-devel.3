Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF42ECD983
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo2ZL-0003Mx-I0; Thu, 05 Feb 2026 11:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vo2ZH-0003MW-JV
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:50:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vo2ZF-0000ZB-LK
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770310256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VuB/vmGYoNd/vJlbcXr5UhXD3CurBfw5E1o7fNVepBw=;
 b=Mb7I8JthjlixCevBB4gWRKF7Mnm+Wn+rGmuCCdV9yqVF5ho532YioZqIp6NZM6QzKM+w6k
 35nYMDhn0hsU6AUvMx5C/ftMgdC3RrGGj9pn6stIVvibcYvwNR0xntC1JNDkZ9tUl9AQEv
 SkcpAnq+c/oKz4XB1R0BOnOLsKit7HA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-qGRCuUFLMl-LSHZx3haQJA-1; Thu,
 05 Feb 2026 11:50:52 -0500
X-MC-Unique: qGRCuUFLMl-LSHZx3haQJA-1
X-Mimecast-MFC-AGG-ID: qGRCuUFLMl-LSHZx3haQJA_1770310251
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 880A41956059; Thu,  5 Feb 2026 16:50:50 +0000 (UTC)
Received: from localhost (unknown [10.44.34.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 193ED19373D8; Thu,  5 Feb 2026 16:50:48 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Eric Auger
 <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Alireza Sanaee
 <alireza.sanaee@huawei.com>
Subject: Re: [PATCH v2 0/3] arm: demuxed ID registers (CCSIDR_EL1)
In-Reply-To: <CAFEAcA9SvgjUvwLb8VjOzyDNy_g0E30wpUKSN=ENfm3HXx_-SA@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260204133229.297061-1-cohuck@redhat.com>
 <CAFEAcA9SvgjUvwLb8VjOzyDNy_g0E30wpUKSN=ENfm3HXx_-SA@mail.gmail.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Thu, 05 Feb 2026 17:50:46 +0100
Message-ID: <87qzqzrv6h.fsf@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Feb 05 2026, Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 4 Feb 2026 at 13:32, Cornelia Huck <cohuck@redhat.com> wrote:
>> RFC because there are still some open questions:
>
>> - There's a slight disagreement between the current code (providing 16
>>   entries for CCSIDR_EL1) and the KVM code (providing (7 cache levels) *
>>   (data/unified, instruction) = 14 entries.) With FEAT_MTE2, we might be
>>   needing 7 more entries.
>
> This is because architecturally the CCSELR_EL1 register is:
>  bit 4 : TnD (tag-not-data)
>  bits [3:1] : level
>  bit 0 : InD (instruction-not-data)
>
> but the 'level' field has 0b111 as Reserved, and KVM doesn't
> (currently) handle the FEAT_MTE2 TnD bit, so from KVM's point
> of view only 0..13 are valid values here.
>
> The architecture says that if you set CSSELR_EL1 to an invalid
> setting then reading CCSIDR_EL1 can be:
>  * a NOP
>  * UNDEF
>  * return an UNKNOWN value
>
> For TCG we opted to permit any indexes 0..15, so that we treat
> the architecturally invalid 0b1110 and 0b1111 the same way as
> we treat "you picked a level this particular CPU doesn't implement"
> (and return a 0 from our cpu->cssidr[] array). Otherwise we would
> have had to add an extra check for "and level isn't invalid".

That makes sense.

>
> TCG also doesn't do anything with the FEAT_MTE2 TnD bit: looks
> like we missed that functionality when we added MTE2 emulation.
> Setting TnD and InD at once isn't a valid combination, so we
> could either extend our cpu->ccsidr[] array to 32 words (and
> live with 8 of the extras being unused), or else add a new
> 8-word array for the MTE tag-cache ID values.

Whatever we do, it would be easiest if KVM and TCG followed a similar
approach, so we don't end up having to special case the code.

As KVM also supports setting (virtual) CCSIDR_EL1 values, I think just
extending the array would be easiest, so that QEMU can just keep
everything in one place.


