Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DCEC87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 14:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukkbA-0002fs-HC; Sat, 09 Aug 2025 10:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukkae-0002cF-3S
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 10:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukkac-0003Sz-8I
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 10:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754749829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtFgom+fibTpSrI/tkRC05vQF1r6SFBFk46gaVK65pI=;
 b=dFJ3xyrx5Jg1Chdnji9qHf6bKTpEO8K6xskZZD2qKfobTuBfKdqWxeYwrF9KOgeJrOax9J
 k0dEICmXuBbff+GMyrzz/NFR3Q26hfxSHVNaT2BfH1C8yw5YNEvM/zxBmPvHBr/TQGP1rJ
 gXKHHlPPEnp6Pj2GAHku5eYaJuuSgxg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-ShBFraTyOymoj3dDrXRBaQ-1; Sat,
 09 Aug 2025 10:30:24 -0400
X-MC-Unique: ShBFraTyOymoj3dDrXRBaQ-1
X-Mimecast-MFC-AGG-ID: ShBFraTyOymoj3dDrXRBaQ_1754749822
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC72018003FD; Sat,  9 Aug 2025 14:30:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 898FF19560B4; Sat,  9 Aug 2025 14:30:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C97F821E6A27; Sat, 09 Aug 2025 16:30:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Markus Armbruster <armbru@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>,  Arun Menon <armenon@redhat.com>,
 qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Cornelia Huck
 <cohuck@redhat.com>,  Halil Pasic <pasic@linux.ibm.com>,  Eric Farman
 <farman@linux.ibm.com>,  Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  Thomas Huth <thuth@redhat.com>,  Christian
 Borntraeger <borntraeger@linux.ibm.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Fam Zheng <fam@euphon.net>,  Nicholas Piggin
 <npiggin@gmail.com>,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,  Alex Williamson
 <alex.williamson@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Peter
 Xu <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Hailiang Zhang
 <zhanghailiang@xfusion.com>,  Steve Sistare <steven.sistare@oracle.com>,
 qemu-s390x@nongnu.org,  qemu-ppc@nongnu.org,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,  Matthew Rosato
 <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v6 23/24] migration: Add error-parameterized function
 variants in VMSD struct
In-Reply-To: <d3c6cac8-cbf6-4c27-afea-c49391262935@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Sat, 9 Aug 2025 18:53:51 +0900")
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-23-fef740e15e17@redhat.com>
 <3e9aa703-2805-4ac4-9f10-f4ba71c10c8a@rsg.ci.i.u-tokyo.ac.jp>
 <aH5AtUcjI3HYXdBe@redhat.com>
 <9c552525-72fa-4d1e-89a2-b5c0e446935a@rsg.ci.i.u-tokyo.ac.jp>
 <87fre0ucxu.fsf@pond.sub.org>
 <d3c6cac8-cbf6-4c27-afea-c49391262935@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 09 Aug 2025 16:30:16 +0200
Message-ID: <87jz3csh3b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> On 2025/08/09 17:17, Markus Armbruster wrote:
>> Almost missed this, sorry.
>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
>>=20
>>> On 2025/07/21 22:29, Daniel P. Berrang=C3=A9 wrote:

[...]

>>>> No, please do NOT make these functions void. As that text you quote
>>>> says, we want functions to return a value indicating success/failure.
>>>> 'void' return is a historical practice we don't want to continue
>>>> in QEMU.
>>>>
>>>> Given that the existing methods all return 'int', we should remain
>>>> consistent with the new functions and return 'int', with -1 for
>>>> failure, 0 for success, and not use bool.
>>>
>>> Markus, I'd also like to hear your opinion since you are the maintainer=
 of the error reporting facility.
>>
>> I'm with Daniel.
>>
>> New code should stick to the rules.
>>
>> Changing existing code from "sticks to the rules" to not requires pretty
>> compelling justification.
>>
>> The other direction is more welcome, but whether the juice is worth the
>> squeeze still needs to be decided case by case.
>
> What do you refer with the rules?

The big comment in qapi/error.h starts with a section =3D Rules =3D.

> There were three options on the table: bool, int, and void.
>
> The previous discussion you referred explains why void should be avoided,=
 and include/qapi/error.h also says void should be avoided.
>
> There is pre_load() that does not use Error returns int, but now we are a=
dding pre_load_errp() that uses Error.
>
> Then what pre_load_errp() should return: bool or int?

I like bool when it's all we need.

When we need to return a non-negative int on success, use int and return
-1 or a negative error code on failure.

Another reason to pick int is local consistency: related functions
already use int.

Changing working code from int to bool doesn't seem worth the bother.

Questions?


