Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB05CCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWL2-0000C6-Ua; Tue, 29 Sep 2026 07:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBWKv-0000Aw-Nc
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 07:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBWKu-0007nH-3m
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 07:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790682566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IXqC/bGM6Uy4HbTef8VUojJfstMWN9l+XWDYWBjIBk0=;
 b=K+5DBeQeG/dnujSp512mDJPNr8SlLpnqKLBJjz1o5f1o0t+DSD7TusC4k5qXDMvK7EKbyK
 tCEE511iFMFTOKkg9+CslODROZ9jT7+B0Joe+J5OzY2L0qlAAPngtVwfpJNfAocmmlRuqS
 uPUg0NbtywBlfD74lND04agl8XXu7A8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-aurfVLfPNWOLXY6qVHAL3w-1; Tue,
 29 Sep 2026 07:49:23 -0400
X-MC-Unique: aurfVLfPNWOLXY6qVHAL3w-1
X-Mimecast-MFC-AGG-ID: aurfVLfPNWOLXY6qVHAL3w_1790682560
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FAD41869DB3; Tue, 29 Sep 2026 11:49:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B12181955F74; Tue, 29 Sep 2026 11:49:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 49A7D21E6A04; Tue, 29 Sep 2026 13:49:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Hanna
 Reitz <hreitz@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Kevin Wolf <kwolf@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Jiri Pirko <jiri@resnulli.us>,  Alex
 Williamson <alex@shazbot.org>,  Kashyap Chamarthy <kchamart@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Kostiantyn Kostiuk
 <kkostiuk@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Michael Roth
 <michael.roth@amd.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-block@nongnu.org,  =?utf-8?Q?C=C3=A9?=
 =?utf-8?Q?dric?= Le Goater
 <clg@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 01/14] qapi: rename "plain" sections to "details"
In-Reply-To: <20260928223657.2303684-2-jsnow@redhat.com> (John Snow's message
 of "Mon, 28 Sep 2026 18:36:44 -0400")
References: <20260928223657.2303684-1-jsnow@redhat.com>
 <20260928223657.2303684-2-jsnow@redhat.com>
Date: Tue, 29 Sep 2026 13:49:16 +0200
Message-ID: <87y0ckxooz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> With this change, we no longer have "plaintext" sections at all: they
> are all now either "Intro" or "Details". This patch does not enforce
> where those details sections must occur; that change occurs in a later
> patch.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py         |  2 +-
>  scripts/qapi/parser.py         | 18 +++++++++++-------
>  tests/qapi-schema/doc-good.out | 18 +++++++++---------
>  3 files changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 54a32e45f7e..ae57056a393 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -383,7 +383,7 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
>          for section in sections:
>              section.text = self.reformat_arobase(section.text)
>  
> -            if section.kind.name in ("PLAIN", "INTRO"):
> +            if section.kind.name in ("INTRO", "DETAILS"):
>                  self.visit_plaintext(section)
>              elif section.kind == QAPIDoc.Kind.MEMBER:
>                  assert isinstance(section, QAPIDoc.ArgSection)
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index dcc04b2663e..fe284a3f866 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -674,7 +674,7 @@ class QAPIDoc:
>      """
>  
>      class Kind(enum.Enum):
> -        PLAIN = 0
> +        DETAILS = 0
>          MEMBER = 1
>          FEATURE = 2
>          RETURNS = 3

I'd like the order of enum values to match the order of sections
eventually.

> @@ -747,12 +747,16 @@ def has_features(self) -> bool:
>      def end(self) -> None:
>          for section in self.all_sections:
>              section.text = section.text.strip('\n')
> -            if not (section.kind.name in ("INTRO", "PLAIN") or section.text):
> +            if (
> +                    section.kind not in (
> +                        QAPIDoc.Kind.INTRO, QAPIDoc.Kind.DETAILS
> +                    ) and section.text == ''
> +            ):

This isn't just rename.

The old conditional is a bit "uh, why bother with enums if we do strings
anyway".  The conditional is ugly.

Are empty DETAILS even possible?  Got a reproducer?

If not, you could use

               if section.text == '' and section.kind != QAPIDoc.Kind.INTRO:

>                  raise QAPISemError(
>                      section.info, "text required after '%s:'" % section.kind)
>  
>      def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
> -        kind = QAPIDoc.Kind.PLAIN
> +        kind = QAPIDoc.Kind.DETAILS
>  
>          if self.all_sections and self.all_sections[-1].kind == kind:
>              # extend current section
> @@ -837,8 +841,8 @@ def _insert_after_intro(
>          """
>          Insert a section immediately after the intro section.
>  
> -        While we convert PLAIN sections to INTRO sections, all
> -        contiguous INTRO/PLAIN sections at the start of a QAPIDoc
> +        While we convert DETAILS sections to INTRO sections, all
> +        contiguous INTRO/DETAILS sections at the start of a QAPIDoc
>          section list are treated as "the intro".
>  
>          Once INTRO conversion is complete, this helper will no longer be

This goes away in PATCH 9.  I'd be tempted to delay the rename until
after that.  Up to you.

> @@ -855,7 +859,7 @@ def _insert_after_intro(
>  
>          index = 0
>          for index, ref_section in enumerate(self.all_sections):
> -            if ref_section.kind.name in ("PLAIN", "INTRO"):
> +            if ref_section.kind.name in ("INTRO", "DETAILS"):
>                  continue
>              break
>          else:
> @@ -871,7 +875,7 @@ def append_member_stub(self, stub: 'QAPIDoc.Section') -> None:
>          if self._insert_near_kind(QAPIDoc.Kind.MEMBER, stub, True):
>              return
>  
> -        # No MEMBER sections present. Insert after INTRO/PLAIN sections.
> +        # No MEMBER sections present. Insert after INTRO/DETAILS sections.
>          self._insert_after_intro(stub)
>  
>      def connect_member(self, member: 'QAPISchemaMember') -> None:
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index eaaf119dea8..1d4fbd3762a 100644

[...]


