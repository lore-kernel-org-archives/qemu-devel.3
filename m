Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0358BE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLJF3-0004Rl-Qz; Wed, 11 Dec 2024 04:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tLJF1-0004Qz-Tn
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:42:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tLJF0-00046x-Br
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733910164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TsZsIbzOpC28BTDzDOBNhO/zN1qcoD/MmmQDCWbnEVQ=;
 b=Z8BLEtHv5YlZC5A0w+vUwEElc25m/ZalO2k0xyUVpWYDjrpsZEdGu3zaBEundaRIKQMf6L
 Y9JZ25+ozz9ulZB0xDB77OBmBqSeJph0BPUIaz159qFgXSPKA7e3CHyPAsQDoAtCehjecD
 7IlZN56Igm/A978XCaSiMjw1KzQJybQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-fQhfZA3xOGygUWZiJU_skw-1; Wed,
 11 Dec 2024 04:42:43 -0500
X-MC-Unique: fQhfZA3xOGygUWZiJU_skw-1
X-Mimecast-MFC-AGG-ID: fQhfZA3xOGygUWZiJU_skw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FF3D1958B0D; Wed, 11 Dec 2024 09:42:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EB521956089; Wed, 11 Dec 2024 09:42:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE1B921EC343; Wed, 11 Dec 2024 10:42:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Roman Penyaev <r.peniaev@gmail.com>,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH v4 6/8] chardev/char-mux: implement backend chardev
 multiplexing
In-Reply-To: <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 16 Oct 2024
 15:13:52 +0400")
References: <20241016102605.459395-1-r.peniaev@gmail.com>
 <20241016102605.459395-7-r.peniaev@gmail.com>
 <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
Date: Wed, 11 Dec 2024 10:42:38 +0100
Message-ID: <87frmuwo6p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

I'm awfully, awfully late.  My apologies!
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Wed, Oct 16, 2024 at 2:29=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
>
>> This patch implements multiplexing capability of several backend
>> devices, which opens up an opportunity to use a single frontend
>> device on the guest, which can be manipulated from several
>> backend devices.
>>
>> The idea of the change is trivial: keep list of backend devices
>> (up to 4), init them on demand and forward data buffer back and
>> forth.
>>
>> Patch implements another multiplexer type `mux-be`. The following
>> is QEMU command line example:
>>
>>    -chardev mux-be,id=3Dmux0 \
>>    -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0,mu=
x-be-id=3Dmux0 \
>>    -chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \
>>
>
> I am not sure about adding "mux-be-id" to all chardev. It avoids the issue
> of expressing a list of ids in mux-be though (while it may have potential
> loop!)
>
> Markus, do you have a suggestion to take an array of chardev ids as a CLI
> option? It looks like we could require QAPIfy -chardev from Kevin here..

We've developed a number of ways of array-shaped configuration bits.
The most recent one relies on QAPI.  To not get bogged down in
compatibility considerations, let me show a new option first.

Create a QAPI type FooOptions for the option's argument, say

    { 'struct': 'FooOptions',
      'data': { 'ids': ['str'] } }

Create the new option -foo, and use qobject_input_visitor_new_str() and
visit_type_T() to parse its argument into a T.

The new option now supports both JSON and dotted keys syntax for its
argument.

JSON example:

    -foo '{"ids": ["eins", "zwei", "drei"]}'

Same in dotted keys:

    -foo ids.0=3Deins,ids.1=3Dzwei,ids.2=3Ddrei

Note: dotted keys are slightly less expressive than JSON.  For instance,
they can't do empty arrays.  Users need to fall back to JSON then.
Peruse the big comment in util/keyval.c if you're curious.

Things can get messy when QAPIfying an existing option argument.  Dotted
keys are designed to be close to QemuOpts, but they're not identical.
If existing usage of the option argument relies on funky QemuOpts
features dotted keys don't replicate, we have a compatibility problem.
For complicated arguments, we may not know whether we have a
compatibility problem.

We can sacrifice dotted key syntax to avoid compatibility problems: if
the argument isn't JSON, fall back to the old option parsing code
instead.  Ugly, because we then have effectively two interfaces instead
of a single interface with a choice of syntax.

Hope this still helps at least some.


