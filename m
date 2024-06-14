Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D848FC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 08:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI2gI-0005Ya-Hs; Fri, 14 Jun 2024 04:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sI2gH-0005Y0-EN
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:53:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sI2gF-00081p-Nx
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718355186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9+LR6yP9mrXncVyErJ25kSNX6GLYDKv6m8mu9TX0ysk=;
 b=d8AyROOfB39yzbeFrBVSgLkEX8STfzD1/XhVQhkb5E2KwXOuFnCJyd2fGU4R4U6BIkBB04
 48fBLWAj/ctqKUbFWcASdBouyCGQoDTTwSfqda4fYDlRqx791ppBLFZZqz29yMhdEL04QF
 qZrgxBvxdKFgxotZ5AbahKxQbBdqIzE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-kxj4SObwMR2gQ-O34OZnug-1; Fri,
 14 Jun 2024 04:53:05 -0400
X-MC-Unique: kxj4SObwMR2gQ-O34OZnug-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 996901956096; Fri, 14 Jun 2024 08:53:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4632319560BF; Fri, 14 Jun 2024 08:52:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0949321F4B8B; Fri, 14 Jun 2024 10:52:57 +0200 (CEST)
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
Subject: Re: [PATCH 09/20] qapi/parser: add undocumented stub members to
 all_sections
In-Reply-To: <20240514215740.940155-10-jsnow@redhat.com> (John Snow's message
 of "Tue, 14 May 2024 17:57:28 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-10-jsnow@redhat.com>
Date: Fri, 14 Jun 2024 10:52:57 +0200
Message-ID: <87tthv52ja.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> This helps simplify the doc generator if it doesn't have to check for
> undocumented members.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/parser.py | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index b1794f71e12..3cd8e7ee295 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -740,8 +740,24 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
>                  raise QAPISemError(member.info,
>                                     "%s '%s' lacks documentation"
>                                     % (member.role, member.name))
> -            self.args[member.name] = QAPIDoc.ArgSection(
> -                self.info, '@' + member.name, 'member')
> +
> +            # Insert stub documentation section for missing member docs.
> +            section = QAPIDoc.ArgSection(
> +                self.info, f"@{member.name}", "member")

Although I like f-strings in general, I'd pefer to stick to '@' +
member.name here, because it's simpler.

Also, let's not change 'member' to "member".  Existing practice: single
quotes for string literals unless double quotes avoid escapes.  Except
English prose (like error messages) is always in double quotes.

> +            self.args[member.name] = section
> +
> +            # Determine where to insert stub doc.

If we have some member documentation, the member doc stubs clearly must
go there.  Inserting them at the end makes sense.

Else we want to put them where the parser would accept real member
documentation.

"The parser" is .get_doc().  This is what it accepts (I'm prepared to
explain this in detail if necessary):

    One untagged section

    Member documentation, if any

    Zero ore more tagged or untagged sections

    Feature documentation, if any

    Zero or more tagged or untagged sections

If we there is no member documentation, this is

    One untagged section

    Zero ore more tagged or untagged sections

    Feature documentation, if any

    Zero or more tagged or untagged sections

Note that we cannot have two adjacent untagged sections (we only create
one if the current section isn't untagged; if it is, we extend it
instead).  Thus, the second section must be tagged or feature
documentation.

Therefore, the member doc stubs must go right after the first section.

This is also where qapidoc.py inserts member documentation.

> +            index = 0
> +            for i, sect in enumerate(self.all_sections):
> +                # insert after these:
> +                if sect.kind in ('intro-paragraph', 'member'):
> +                    index = i + 1
> +                # but before these:
> +                elif sect.kind in ('tagged', 'feature', 'outro-paragraph'):
> +                    index = i
> +                    break

Can you describe what this does in English?  As a specification; simply
paraphrasing the code is cheating.  I tried, and gave up.

Above, I derived what I believe we need to do.  It's simple enough: if
we have member documentation, it starts right after the first (untagged)
section, and the stub goes to the end of the member documentation.
Else, the stub goes right after the first section.

Code:

            index = 1;
            while self.all_sections[index].kind == 'member':
                index += 1

Of course future patches I haven't seen might change the invariants in
ways that break my simple code.  We'll see.

> +            self.all_sections.insert(index, section)
> +
>          self.args[member.name].connect(member)
>  
>      def connect_feature(self, feature: 'QAPISchemaFeature') -> None:


