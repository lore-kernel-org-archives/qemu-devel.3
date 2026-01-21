Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D73EC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 16:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vib5g-000801-Ew; Wed, 21 Jan 2026 11:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vib46-000736-RP
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:28:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vib44-0004Pj-Lh
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769012894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q2aEhM5SMkba1phfpRyBD/3sybNT84asY5s0cd0gCRA=;
 b=cjmaIL5+ataSz0HY7LNhzDSqF2Z+gQsSq6fdhyOaa/KTvtWREPKfkqysI7b9+HGwDyCUL1
 F8jt10HXOEkQfFAnbi1cVRtVkCmheg3donHkfDHA2i0yrjECy1raa1JejbG0+dQEpHRlDX
 /WObiBTpUBkWgksT13qVCYEpmbz4FB4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-BnSZ7QsTOh28YNenxjnS4g-1; Wed,
 21 Jan 2026 11:28:12 -0500
X-MC-Unique: BnSZ7QsTOh28YNenxjnS4g-1
X-Mimecast-MFC-AGG-ID: BnSZ7QsTOh28YNenxjnS4g_1769012891
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 747E418005BF; Wed, 21 Jan 2026 16:28:10 +0000 (UTC)
Received: from localhost (unknown [10.44.34.34])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFD5D1800577; Wed, 21 Jan 2026 16:28:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 jonathan.cameron@huawei.com
Subject: Re: [PATCH RFC 0/3] arm: demuxed ID registers (CCSIDR_EL1)
In-Reply-To: <20260120114447.00004699.alireza.sanaee@huawei.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260119172732.140613-1-cohuck@redhat.com>
 <20260120114447.00004699.alireza.sanaee@huawei.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Wed, 21 Jan 2026 17:28:07 +0100
Message-ID: <878qdrszfs.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jan 20 2026, Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> On Mon, 19 Jan 2026 18:27:29 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>
> Hi Cornelia,
>
>
>
>> Note: this is on top of <20260105154119.59853-1-cohuck@redhat.com>
>> ("[PATCH v3 0/2] arm: move DCZID_EL0 to idregs array")
>> 
>> While trying to move to an autogenerated cpu-sysregs.h.inc (so that we
>> may keep a common view on registers), we should first address the ID
>> registers that are still kept outside of ARMISARegisters. Other than
>> DCZID_EL0 (addressed by the series this one goes on top of), that's
>> the CCSIDR_EL1 values kept in cpu->cssidr[] (indexed via CSSELR_EL1.)
>> 
>> My idea was to provide {GET,SET}_IDREG_DEMUX helper that work similar
>> to {GET,SET}_IDREG and operate on a two-dimensional array. As a side
>> effect, this also allows to get the values KVM provides for CCSIDR_EL1
>> (which are virtualized as well.)
>> 
>> RFC because there are still some open questions:
>> - The demux array cannot easily be autogenerated. We can get rid of the
>>   ccsidr[] array, but we now have an autogenerated entry in the non-demux
>>   array that does nothing. Both are not that nice.
>> - I'm not sure if we need any compat handling for KVM (on TCG, everything
>>   should stay the same.) In theory, the KVM interface allows setting
>>   values from userspace (I didn't try.)
>> - There's a slight disagreement between the current code (providing 16
>>   entries for CCSIDR_EL1) and the KVM code (providing (7 cache levels) *
>>   (data/unified, instruction) = 14 entries.) With FEAT_MTE2, we might be
>>   needing 7 more entries.
>> 
>> Feedback appreciated.
>> 
>> Cornelia Huck (3):
>>   arm: handle demuxed ID registers
>>   arm: handle CCSIDR_EL1 as a demuxed register
>>   arm/kvm: get demuxed ID registers from kvm
>> 
>>  hw/intc/armv7m_nvic.c        |  2 +-
>>  target/arm/cpu-sysregs.h     |  6 ++++
>>  target/arm/cpu-sysregs.h.inc |  1 +
>>  target/arm/cpu.h             | 26 ++++++++++++----
>>  target/arm/cpu64.c           | 12 ++++----
>>  target/arm/helper.c          |  2 +-
>>  target/arm/kvm.c             | 33 ++++++++++++++++++++
>>  target/arm/tcg/cpu32.c       | 32 +++++++++----------
>>  target/arm/tcg/cpu64.c       | 60 ++++++++++++++++++------------------
>>  9 files changed, 114 insertions(+), 60 deletions(-)
>> 
>
> This impacts my set https://lore.kernel.org/all/20260106155828.643-1-alireza.sanaee@huawei.com/

Duh, that series had actually been sitting in my "to look at" queue...

>
> I tested it with mine of course it required a few changes, but looks like working on TCG, didn't try KVM.
>
> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>

Thanks for testing! I'll also try to take a look at your series.


