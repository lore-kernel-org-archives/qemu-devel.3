Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E871C021AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 09:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkg0E-0005tq-9z; Wed, 19 Feb 2025 04:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkg0B-0005tI-UQ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 04:04:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkg08-00088m-Ik
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 04:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739955855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocBR5LGCbzpOEQ6oL9LxsRdCTK7a08kvS7Nr9NK+tMw=;
 b=BXa7UW914UIvvIGtJFFHVTKYt3t8IuP+/V4rdg1jlsTWCDQulRHDIVogzyCCNgGEGmW3XN
 FFIjgoMxbroNgVIzWXtZvvd6/D+O4vQApQO6Rvpb8RzWes3hRfPxI2oVadd9rcaUOlDkf5
 tEkkquuay4JUJUFw2PVdz2e0p12u+Ig=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-svTTE5svOjCTXUU6nuws1Q-1; Wed,
 19 Feb 2025 04:04:11 -0500
X-MC-Unique: svTTE5svOjCTXUU6nuws1Q-1
X-Mimecast-MFC-AGG-ID: svTTE5svOjCTXUU6nuws1Q_1739955850
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6862E180087B; Wed, 19 Feb 2025 09:04:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76D041955BCB; Wed, 19 Feb 2025 09:04:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 73E4921E6A28; Wed, 19 Feb 2025 10:04:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Fabiano Rosas <farosas@suse.de>,  Zhao Liu <zhao1.liu@intel.com>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Jason Wang
 <jasowang@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 29/42] qapi: Add "Details:" disambiguation marker
In-Reply-To: <CAFn=p-a8=+BZfUjiaQpXU7UbH7_oV5WNdumHqbD8kauf3YqKVQ@mail.gmail.com>
 (John Snow's message of "Tue, 18 Feb 2025 17:26:02 -0500")
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-30-jsnow@redhat.com>
 <87seocrdk9.fsf@pond.sub.org>
 <CAFn=p-a8=+BZfUjiaQpXU7UbH7_oV5WNdumHqbD8kauf3YqKVQ@mail.gmail.com>
Date: Wed, 19 Feb 2025 10:04:05 +0100
Message-ID: <878qq271bu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Mon, Feb 17, 2025 at 6:55=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This clarifies sections that are mistaken by the parser as "intro"
>> > sections to be "details" sections instead.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  qapi/machine.json      | 2 ++
>> >  qapi/migration.json    | 4 ++++
>> >  qapi/qom.json          | 4 ++++
>> >  qapi/yank.json         | 2 ++
>> >  scripts/qapi/parser.py | 8 ++++++++
>> >  5 files changed, 20 insertions(+)
>>
>> Missing updates for the new syntax
>>
>> * Documentation: docs/devel/qapi-code-gen.rst
>>
>
>> * Positive test case(s): tests/qapi-schema/doc-good.json
>>
>> * Maybe a negative test case for _tag_check() failure
>>
>>
> Understood; I wasn't entirely sure if this concept would fly, so I saved
> the polish and you got an RFC quality patch. Forgive me, please! If you

As I wrote in review of PATCH 28, this is good strategy.

> think this approach is fine, I will certainly do all the things you
> outlined above.
>
>
>> [...]
>>
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index c5d2b950a82..5890a13b5ba 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -544,6 +544,14 @@ def _tag_check(what: str) -> None:
>> >                          raise QAPIParseError(
>> >                              self, 'feature descriptions expected')
>> >                      have_tagged =3D True
>> > +                elif line =3D=3D 'Details:':
>> > +                    _tag_check("Details")
>>
>> This one.
>>
>
> ACK
>
>
>>
>> > +                    self.accept(False)
>> > +                    line =3D self.get_doc_line()
>> > +                    while line =3D=3D '':
>> > +                        self.accept(False)
>> > +                        line =3D self.get_doc_line()
>> > +                    have_tagged =3D True
>> >                  elif match :=3D self._match_at_name_colon(line):
>> >                      # description
>> >                      if have_tagged:
>>
>>


