Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC6FC5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 08:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd4rz-0003vH-4Z; Thu, 22 Feb 2024 03:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rd4rt-0003ui-Ry
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 03:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rd4ro-0006DG-Us
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 03:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708592143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+M16XHqHViPN14kSc4fMQAfsITXwokN7kxY0nxzhpc=;
 b=bngLp3lT6wBff+vgNcaoG7oiiO4HJ3SVMvTpxGKHOP7aFWz6EMPOXkXKx1U8rccxQw8Tkl
 K/XL66mB2AZOae9J5p5sLdvHpEb8wALOh5ZSlkOnMVOu7jhTpaDC0gAsmGSg/gFXMJ6TXk
 jdbliiPeAjv/Ew9MB9ez9ZB/N1hJO2A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-3L7C1FzxM5aPTe0h-DIqNA-1; Thu, 22 Feb 2024 03:55:39 -0500
X-MC-Unique: 3L7C1FzxM5aPTe0h-DIqNA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4738583B8EC;
 Thu, 22 Feb 2024 08:55:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0364C492BC8;
 Thu, 22 Feb 2024 08:55:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CDB0C21E66D5; Thu, 22 Feb 2024 09:55:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  jsnow@redhat.com,
 eblake@redhat.com,  peter.maydell@linaro.org
Subject: Re: [PATCH 14/16] qapi: Rewrite doc comment parser
In-Reply-To: <ZdTQ8cuJEkWXS8y3@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 20 Feb 2024 16:18:57 +0000")
References: <20240216145841.2099240-1-armbru@redhat.com>
 <20240216145841.2099240-15-armbru@redhat.com>
 <ZdTQ8cuJEkWXS8y3@redhat.com>
Date: Thu, 22 Feb 2024 09:55:37 +0100
Message-ID: <87sf1kx4hi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> On Fri, Feb 16, 2024 at 03:58:38PM +0100, Markus Armbruster wrote:
>> QAPISchemaParser is a conventional recursive descent parser.  Except
>> QAPISchemaParser.get_doc() delegates most of the doc comment parsing
>> work to a state machine in QAPIDoc.  The state machine doesn't get
>> tokens like a recursive descent parser, it is fed tokens.
>>=20
>> I find this state machine rather opaque and hard to maintain.
>>=20
>> Replace it by a conventional parser, all in QAPISchemaParser.  Less
>> code, and (at least in my opinion) easier to understand.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/parser.py | 478 ++++++++++++++++++-----------------------
>>  1 file changed, 210 insertions(+), 268 deletions(-)
>
> Reviewing parsing code typically gives me a headache, and reviewing
> diffs of parsing code is even worse. Thus instead of R-b I'll give
> a
>
>   Tested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> on the basis that we've got great test coverage and I think that's
> the real killer requirement for parsing code. The tests still pass
> with this commit, so functionally it is working as expected.

Makes sense.  Figuring out what language the old parser parses gave me a
headache or three, too.

Thanks!


