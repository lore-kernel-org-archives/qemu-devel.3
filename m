Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CA606A89B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Stt4CoN0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTIp-0003NM-3K; Thu, 12 Nov 2026 06:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRTIn-0003N1-HA
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRTIm-0001Fb-0l
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794484151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IgFmldIUB6JD4JWn9Zs4m+4gjny75GlFXD5upBZo1VA=;
 b=Stt4CoN0F43cc/4orsNDM4sytaJEMm2aogGg9YqaFZVC+2FfvzIx4kQKaMSR1ih7tlxgQC
 wpGmT/MZ7XCiuzy8SgOT8qeQ9ykXxYTvIo26Z0k100ARBVFbCY6QspL82XagzyVoUMzsIf
 yGVbXOT4rmVgL4qx8N2v+zwS86hSrKU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-DZ07MGYJP3KmwXzegOSkhw-1; Thu,
 12 Nov 2026 06:49:09 -0500
X-MC-Unique: DZ07MGYJP3KmwXzegOSkhw-1
X-Mimecast-MFC-AGG-ID: DZ07MGYJP3KmwXzegOSkhw_1794484148
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1E8F19344C7; Thu, 12 Nov 2026 11:49:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C82441F; Thu, 12 Nov 2026 11:49:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E01CA21E6A04; Thu, 12 Nov 2026 12:49:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  david@kernel.org,  imammedo@redhat.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH 1/7] backends/hostmem: Drop redundant validation of
 property "size"
In-Reply-To: <avV0-C7TSKV4lQWP@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 12 Nov 2026 08:12:40 +0000")
References: <20261111122342.634370-1-armbru@redhat.com>
 <20261111122342.634370-2-armbru@redhat.com>
 <avRjUJ9-d0_RxIvk@redhat.com> <87fqx6sdcz.fsf@pond.sub.org>
 <avV0-C7TSKV4lQWP@redhat.com>
Date: Thu, 12 Nov 2026 12:49:05 +0100
Message-ID: <8733t6s21a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Nov 12, 2026 at 08:44:28AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

[...]

>> > as a separate patch I might suggest

[...]

>> > so that we get the nicer message:
>> >
>> >     $ ./build/qemu-system-x86_64 -object memory-backend-ram,size=3D0,i=
d=3Dfoo
>> >     qemu-system-x86_64: cannot create 'memory-backend-ram' with a size=
 of 0
>>=20
>> Your message assumes that the property is only ever set on behalf of an
>> object creation request.  Not true in general, qom-set exists.  I
>> believe it's true here due to the host_memory_backend_mr_inited() guard.
>> But that's not entirely obvious, isn't it?
>>=20
>> Possible phrasings that don't assume this:
>>=20
>>    property 'size' of 'memory-backend-ram' cannot be zero
>>    cannot set property 'size' of 'memory-backend-ram' to zero
>>=20
>> Is one of them good enough?  I doubt this error is common.
>
> I'm fine with either of those, perhaps mildly leaning towards
> the second.
>
>> There are enough "doesn't take value" error messages elsewhere to
>> justify a small series of its own.

Just posted:

    From: Markus Armbruster <armbru@redhat.com>
    Subject: [PATCH] error: Improve a few error messages on setting propert=
y to zero
    Date: Thu, 12 Nov 2026 12:47:02 +0100
    Message-ID: <20261112114702.969681-1-armbru@redhat.com>


