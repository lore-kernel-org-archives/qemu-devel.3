Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819EFD3B99F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 15:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFxDx-0000Ld-97; Tue, 26 Nov 2024 10:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tFxDu-0000Km-Ey
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:11:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tFxDs-0002P2-Sv
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732633888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JGU0ymwwubPU/KMUZ4VFprHZfB5g6qKLPHnXImxnKSc=;
 b=S14ygwsEoJrd17uac0nWk/IgYSkXIn6jqYTgj1Uw/lkZlTcNq63xcZpHQlslhG+lp7CrYR
 EJiSt1SFlpT8T2BbY00M6VpEUYJRrWW8Q6qdZRgkm1dim37W4qiIR9bWp53W3xl+2v/Jy3
 60XpRYsgyrHDhet7Ax6ko8Ft7AWVLOQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-TVL5P0iiO82lRUQp76T5GQ-1; Tue,
 26 Nov 2024 10:11:23 -0500
X-MC-Unique: TVL5P0iiO82lRUQp76T5GQ-1
X-Mimecast-MFC-AGG-ID: TVL5P0iiO82lRUQp76T5GQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EA7E1955F56; Tue, 26 Nov 2024 15:11:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A15CA1956086; Tue, 26 Nov 2024 15:11:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6DDB521E66C9; Tue, 26 Nov 2024 16:11:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 peter.maydell@linaro.org,  richard.henderson@linaro.org,
 philmd@linaro.org,  qemu-arm@nongnu.org,  qemu-devel@nongnu.org,
 alex.bennee@linaro.org,  Eric Blake <eblake@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 11/26] target/arm/kvm-rme: Add measurement algorithm
 property
In-Reply-To: <Z0XFsC6vWkrR7aAm@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 26 Nov 2024 12:57:20 +0000")
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-13-jean-philippe@linaro.org>
 <Z0XFsC6vWkrR7aAm@redhat.com>
Date: Tue, 26 Nov 2024 16:11:19 +0100
Message-ID: <87ed2yowrs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Nov 25, 2024 at 07:56:10PM +0000, Jean-Philippe Brucker wrote:

[...]

>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index f982850bca..901ba67634 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -1068,6 +1068,20 @@
>>    'data': { '*cpu-affinity': ['uint16'],
>>              '*node-affinity': ['uint16'] } }
>>=20=20
>> +##
>> +# @RmeGuestMeasurementAlgorithm:
>> +#
>> +# @sha256: Use the SHA256 algorithm
>> +#
>> +# @sha512: Use the SHA512 algorithm
>> +#
>> +# Algorithm to use for realm measurements
>> +#
>> +# Since: 9.3
>> +##
>> +{ 'enum': 'RmeGuestMeasurementAlgorithm',
>> +  'data': ['sha256', 'sha512'] }
>
>
> A design question for Markus....
>
>
> We have a "QCryptoHashAlg" enum that covers both of these strings
> and more besides.
>
> We have a choice of using a dedicated enum strictly limited to
> just what RME needs, vs using the common enum type, but rejecting
> unsupported algorithms at runtime.  Do we prefer duplication for
> improve specificity, or removal of duplication ?

With a dedicated enum, introspection shows precisely the accepted
values.

If we reuse a wider enum, introspection shows additional, invalid
values.

Say we later make one of these valid here.  If we reuse the wider enum
now, nothing changes in introspection then, i.e. introspection cannot
tell us whether this particular QEMU supports this additional algorithm.
With a dedicated enum, it can.  Whether that's needed in practice I find
hard to predict.

I lean towards lean towards dedicated enum.

Questions?

[...]


