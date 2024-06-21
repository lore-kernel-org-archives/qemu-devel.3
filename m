Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413A6C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 06:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKXv3-0000nD-Ah; Fri, 21 Jun 2024 02:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sKXv1-0000mR-Tw
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 02:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sKXv0-00006y-7P
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 02:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718951920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dY4FeXt5egMnI8MmHYIDhsUj5TMCC/7av1kZ8RTaiaQ=;
 b=d5UfBnAGlucg+HAYzbh+ZQPmNlPYv9p4iRCyNFkX+QGkYfQ03easDI0sHZzQdb4pHCwzYe
 85xjtNKL00qY3nxovj5/LQr4meNYQaVF/sr/8459lDx9b/jVgnjHvuFZPHdi7CXKXkPltd
 JGYs43NDjF46A7svLe03lHJBnyL2sag=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-s11vOxSlPFGm9U0IiiaDvw-1; Fri,
 21 Jun 2024 02:38:37 -0400
X-MC-Unique: s11vOxSlPFGm9U0IiiaDvw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED0E819560AB; Fri, 21 Jun 2024 06:38:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 706BD19560AF; Fri, 21 Jun 2024 06:38:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6BBFE21E6687; Fri, 21 Jun 2024 08:38:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Victor Toso de Carvalho <victortoso@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Marcel
 Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Fabiano Rosas <farosas@suse.de>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Peter Xu <peterx@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Jason
 Wang <jasowang@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>,  Jiri Pirko <jiri@resnulli.us>,  Alex
 Williamson <alex.williamson@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 04/13] qapi/parser: preserve indentation in QAPIDoc
 sections
In-Reply-To: <CAFn=p-bdtS=u6upkjD6+Vn_7cC1cysd-DLKvrg6T5SPrucQpLg@mail.gmail.com>
 (John Snow's message of "Thu, 20 Jun 2024 11:14:32 -0400")
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-5-jsnow@redhat.com>
 <878qz12l87.fsf@pond.sub.org>
 <CAFn=p-YUUfaSKWwEwdR=+3q-TrKR6v0HmYNUk75AvmFEjpviAQ@mail.gmail.com>
 <87h6dnsldn.fsf@pond.sub.org>
 <CAFn=p-bdtS=u6upkjD6+Vn_7cC1cysd-DLKvrg6T5SPrucQpLg@mail.gmail.com>
Date: Fri, 21 Jun 2024 08:38:29 +0200
Message-ID: <87plsareai.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

> On Thu, Jun 20, 2024, 11:07=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Wed, Jun 19, 2024, 8:03=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>> >
>> >> John Snow <jsnow@redhat.com> writes:
>> >>
>> >> > Change get_doc_indented() to preserve indentation on all subsequent=
 text
>> >> > lines, and create a compatibility dedent() function for qapidoc.py =
to
>> >> > remove that indentation. This is being done for the benefit of a new
>> >>
>> >> Suggest "remove indentation the same way get_doc_indented() did."
>> >>
>> >
>> > Aight.
>> >
>> >
>> >> > qapidoc generator which requires that indentation in argument and
>> >> > features sections are preserved.
>> >> >
>> >> > Prior to this patch, a section like this:
>> >> >
>> >> > ```
>> >> > @name: lorem ipsum
>> >> >    dolor sit amet
>> >> >      consectetur adipiscing elit
>> >> > ```
>> >> >
>> >> > would have its body text be parsed as:
>> >>
>> >> Suggest "parsed into".
>> >>
>> >
>> > Why? (I mean, I'll do it, but I don't see the semantic difference
>> > personally)
>> >
>>
>> "Parse as <language>" vs. "Parse into <representation>".
>>
>> >> > (first and final newline only for presentation)
>> >> >
>> >> > ```
>> >> > lorem ipsum
>> >> > dolor sit amet
>> >> >   consectetur adipiscing elit
>> >> > ```
>> >> >
>> >> > We want to preserve the indentation for even the first body line so=
 that
>> >> > the entire block can be parsed directly as rST. This patch would now
>> >> > parse that segment as:
>> >>
>> >> If you change "parsed as" to "parsed into" above, then do it here, to=
o.
>> >>
>> >> >
>> >> > ```
>> >> > lorem ipsum
>> >> >    dolor sit amet
>> >> >      consectetur adipiscing elit
>> >> > ```
>> >> >
>> >> > This is helpful for formatting arguments and features as field list=
s in
>> >> > rST, where the new generator will format this information as:
>> >> >
>> >> > ```
>> >> > :arg type name: lorem ipsum
>> >> >    dolor sit amet
>> >> >      consectetur apidiscing elit
>> >> > ```
>> >> >
>> >> > ...and can be formed by the simple concatenation of the field list
>> >> > construct and the body text. The indents help preserve the continua=
tion
>> >> > of a block-level element, and further allow the use of additional r=
ST
>> >> > block-level constructs such as code blocks, lists, and other such
>> >> > markup. Avoiding reflowing the text conditionally also helps preser=
ve
>> >> > source line context for better rST error reporting from sphinx thro=
ugh
>> >> > generated source, too.
>> >>
>> >> What do you mean by "reflowing"?
>> >>
>> >
>> > Poorly phrased, was thinking about emacs too much. I mean munging the =
text
>> > post-hoc for the doc generator such that newlines are added or removed=
 in
>> > the process of re-formatting text to get the proper indentation for th=
e new
>> > rST form.
>> >
>> > In prototyping, this got messy very quickly and was difficult to corre=
late
>> > source line numbers across the transformation.
>> >
>> > It was easier to just not munge the text at all instead of munging it =
and
>> > then un-munging it.
>> >
>> > (semantic satiation: munge munge munge munge.)
>>
>> Is this about a possible alternative solution you explored?  Keeping
>> .get_doc_indented() as is, and then try to undo its damage?
>>
>
> precisamente. That solution was categorically worse.

Since .get_doc_indented() removes N spaces of indentation, we'd want to
add back N spaces of indentation.  But we can't know N, so I guess we'd
make do with an arbitrary number.  Where would reflowing come it?

I'd like you to express more clearly that you're talking about an
alternative you rejected.  Perhaps like this:

  block-level constructs such as code blocks, lists, and other such
  markup.

  The alternative would be to somehow undo .get_doc_indented()'s
  indentation changes in the new generator.  Much messier.

Feel free to add more detail to the last paragraph.

>> [...]


