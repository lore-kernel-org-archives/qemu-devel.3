Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F11C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 14:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHlVK-0002Kj-MX; Thu, 13 Jun 2024 10:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHlVI-0002K3-OS
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHlVH-0006QO-2B
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718289157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNxEnMNZafh7INYTouKPK6U78gyVTvTwyFx8W1ouKD8=;
 b=PcUQvx6My9YWfSW5185yj501U9lx+69ZKJKz1xDpvm2wD0mCCVGHfzYoeF2L+gWnRutKZT
 5XidcaXjHt3ng3QWUWK+fCwgoa1veSJFMUQ5DoM8gKVsV63f/vX+WFdxO81VL65V8oGHt8
 Vv4aTfTSymDOPz7D0Pk63WsGl49sppQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-CXEHSnSjM_eaCsxrPnsBRQ-1; Thu,
 13 Jun 2024 10:32:31 -0400
X-MC-Unique: CXEHSnSjM_eaCsxrPnsBRQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E1771955D9B; Thu, 13 Jun 2024 14:32:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 129E53000221; Thu, 13 Jun 2024 14:32:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C844221E6682; Thu, 13 Jun 2024 16:32:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Ani
 Sinha <anisinha@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Mads Ynddal
 <mads@ynddal.dk>,  Jason Wang <jasowang@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Yanan Wang <wangyanan55@huawei.com>,  Hanna Reitz
 <hreitz@redhat.com>
Subject: Re: [PATCH 06/20] qapi/parser: fix comment parsing immediately
 following a doc block
In-Reply-To: <CAFn=p-YbP7tH8qxRapEDV5tF=5ShDXx9ULquwU_Mu0-un0i==g@mail.gmail.com>
 (John Snow's message of "Thu, 16 May 2024 13:32:46 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-7-jsnow@redhat.com>
 <875xvepa64.fsf@pond.sub.org>
 <CAFn=p-YbP7tH8qxRapEDV5tF=5ShDXx9ULquwU_Mu0-un0i==g@mail.gmail.com>
Date: Thu, 13 Jun 2024 16:32:10 +0200
Message-ID: <878qz8ap79.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> On Thu, May 16, 2024 at 2:01=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > If a comment immediately follows a doc block, the parser doesn't ignore
>> > that token appropriately. Fix that.
>>
>> Reproducer?
>>
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/parser.py | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index 41b9319e5cb..161768b8b96 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -587,7 +587,7 @@ def get_doc(self) -> 'QAPIDoc':
>> >                  line =3D self.get_doc_line()
>> >                  first =3D False
>> >
>> > -        self.accept(False)
>> > +        self.accept()
>> >          doc.end()
>> >          return doc
>>
>> Can't judge the fix without understanding the problem, and the problem
>> will be easier to understand for me with a reproducer.
>>
>
> audio.json:
>
> ```
> ##
> # =3D Audio
> ##
>
> ##
> # @AudiodevPerDirectionOptions:
> #
> # General audio backend options that are used for both playback and
> # recording.
> #
> ```
>
> Modify this excerpt to have a comment after the "=3D Audio" header, say f=
or
> instance if you were to take out that intro paragraph and transform it in=
to
> a comment that preceded the AudiodevPerDirectionOptions doc block.
>
> e.g.
>
> ```
> ##
> # =3D Audio
> ##
>
> # Lorem Ipsum
>
> ##
> # @AudiodevPerDirectionOptions:
> ```
>
> the parser breaks because the line I changed that primes the next token is
> still set to "not ignore comments", but that breaks the parser and gives a
> rather unhelpful message:
>
> ../qapi/audio.json:13:1: junk after '##' at start of documentation comment

When ._parse()'s loop sees a comment token in .tok, it expects it to be
the start of a doc comment block (because any other comments are to be
skipped).  It then calls .get_doc(), which expects the same.  The
unexpected comment token then triggers .get_doc()'s check for junk after
'##'.

> Encountered when converting developer commentary from documentation
> paragraphs to mere QAPI comments.

Your fix is correct.

It's actually a regression.  Please add

    Fixes: 3d035cd2cca6 (qapi: Rewrite doc comment parser)

to the commit message.

Let's add a reproducer to tests/qapi-schema/doc-good.json right in this
patch, e.g.

diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son
index de38a386e8..8b39eb946a 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -55,6 +55,8 @@
 # - {braces}
 ##
=20
+# Not a doc comment
+
 ##
 # @Enum:
 #


