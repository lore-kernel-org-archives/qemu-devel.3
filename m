Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A98606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OI7hU1Wv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRPUC-0007ck-N2; Thu, 12 Nov 2026 02:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRPU6-0007bW-I4
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 02:44:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRPU4-0006ek-K5
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 02:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794469474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QslGCBPxyZS5ODa03J/suWTZiylSnpDcG5Q6LGtP3lY=;
 b=OI7hU1Wvu4VKfzUAODhg2VYtUH/N40TRx9CnUtif0ZCJYkII51CQsB5OBBBbHdm72z3n4t
 t3AUzlzr9ziAOb1QzaPc09xvKmAyDDKiRgckw2AbX8wp7DnnYo4KHN+llz/b/oP8LPpOWH
 364U/nFIJSTjsZJXoiR64b/5Dh28qEI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-jpydFdRgPNm_YAz04Mrh-Q-1; Thu,
 12 Nov 2026 02:44:33 -0500
X-MC-Unique: jpydFdRgPNm_YAz04Mrh-Q-1
X-Mimecast-MFC-AGG-ID: jpydFdRgPNm_YAz04Mrh-Q_1794469472
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAFEF18002CB; Thu, 12 Nov 2026 07:44:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DD3530000D3; Thu, 12 Nov 2026 07:44:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B6BF421E6A04; Thu, 12 Nov 2026 08:44:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  david@kernel.org,  imammedo@redhat.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH 1/7] backends/hostmem: Drop redundant validation of
 property "size"
In-Reply-To: <avRjUJ9-d0_RxIvk@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 11 Nov 2026 12:45:04 +0000")
References: <20261111122342.634370-1-armbru@redhat.com>
 <20261111122342.634370-2-armbru@redhat.com>
 <avRjUJ9-d0_RxIvk@redhat.com>
Date: Thu, 12 Nov 2026 08:44:28 +0100
Message-ID: <87fqx6sdcz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Nov 11, 2026 at 01:23:36PM +0100, Markus Armbruster wrote:
>> Property "size" is mandatory, and its setter
>> host_memory_backend_set_size() rejects value zero.  Delete the
>> redundant checks for zero in the .alloc() callbacks.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  backends/hostmem-epc.c   | 5 -----
>>  backends/hostmem-file.c  | 4 ----
>>  backends/hostmem-memfd.c | 5 -----
>>  backends/hostmem-ram.c   | 5 -----
>>  backends/hostmem-shm.c   | 5 -----
>>  5 files changed, 24 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> ...it is a shame this was/is dead code, since the actual error message
> from host_memory_backend_set_size() is (IMHO) worse than that from the
> unreachable code you're deleting
>
>   $ ./build/qemu-system-x86_64 -object memory-backend-ram,size=3D0,id=3Df=
oo
>   qemu-system-x86_64: property 'size' of memory-backend-ram doesn't take =
value '0'

Fair point.

> as a separate patch I might suggest
>
>     diff --git a/backends/hostmem.c b/backends/hostmem.c
>     index 173d042be35..f523dce6eb0 100644
>     --- a/backends/hostmem.c
>     +++ b/backends/hostmem.c
>     @@ -77,8 +77,8 @@ host_memory_backend_set_size(Object *obj, Visitor *=
v, const char *name,
           if (host_memory_backend_mr_inited(backend)) {
               error_setg(errp, "cannot change property %s of %s ", name,
                          object_get_typename(obj));
               return;
           }

           if (!visit_type_size(v, name, &value, errp)) {
               return;
>          }
>          if (!value) {
>              error_setg(errp,
>     -                   "property '%s' of %s doesn't take value '%" PRIu6=
4 "'",
>     -                   name, object_get_typename(obj), value);
>     +                   "cannot create '%s' with a size of 0",
>     +                   object_get_typename(obj));
>              return;
>          }
>          backend->size =3D value;
>
> so that we get the nicer message:
>
>     $ ./build/qemu-system-x86_64 -object memory-backend-ram,size=3D0,id=
=3Dfoo
>     qemu-system-x86_64: cannot create 'memory-backend-ram' with a size of=
 0

Your message assumes that the property is only ever set on behalf of an
object creation request.  Not true in general, qom-set exists.  I
believe it's true here due to the host_memory_backend_mr_inited() guard.
But that's not entirely obvious, isn't it?

Possible phrasings that don't assume this:

   property 'size' of 'memory-backend-ram' cannot be zero
   cannot set property 'size' of 'memory-backend-ram' to zero

Is one of them good enough?  I doubt this error is common.

There are enough "doesn't take value" error messages elsewhere to
justify a small series of its own.


