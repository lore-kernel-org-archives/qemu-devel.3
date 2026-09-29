Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B475BCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXac-0004XT-OX; Tue, 29 Sep 2026 09:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBXab-0004X4-14
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 09:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBXaY-0001Tp-Pe
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 09:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790687380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYbopPsTbwDvA/tHNViO4V1315xPpKqk9YiqVQrch/o=;
 b=Kr8OD32IaQmn7gptkCY+iLI7KTlPKoX8jY6t6EFnwh5JAtL3UQ/sHSWJwS0ou6s6LkJRTX
 eR+AvggKtxHtDVbG2A8maz4+/yXOiP9t2lOubF7xUF13nt+AKw5nGC3uycup+TXSYqHh+v
 /yf9DItYQvipKjlF4v0bxjk25Ix6yQA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-tEeX3qJPNB2oDwwN69ohbA-1; Tue,
 29 Sep 2026 09:09:37 -0400
X-MC-Unique: tEeX3qJPNB2oDwwN69ohbA-1
X-Mimecast-MFC-AGG-ID: tEeX3qJPNB2oDwwN69ohbA_1790687375
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFCB61809C9F; Tue, 29 Sep 2026 13:09:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 456E41956095; Tue, 29 Sep 2026 13:09:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E943F21E6A04; Tue, 29 Sep 2026 15:09:30 +0200 (CEST)
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
Subject: Re: [PATCH 09/14] qapi/parser: remove _insert_after_intro() helper
In-Reply-To: <20260928223657.2303684-10-jsnow@redhat.com> (John Snow's message
 of "Mon, 28 Sep 2026 18:36:52 -0400")
References: <20260928223657.2303684-1-jsnow@redhat.com>
 <20260928223657.2303684-10-jsnow@redhat.com>
Date: Tue, 29 Sep 2026 15:09:30 +0200
Message-ID: <87v77ow6et.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> I promised I'd remove this.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/parser.py | 49 ++++++------------------------------------
>  1 file changed, 7 insertions(+), 42 deletions(-)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index c14bff2cbc3..5fc9c18c81d 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -862,49 +862,15 @@ def _insert_near_kind(
>                  return True
>          return False
>  
> -    def _insert_after_intro(
> -        self,
> -        section: 'QAPIDoc.Section',
> -    ) -> None:
> -        """
> -        Insert a section immediately after the intro section.
> -
> -        While we convert DETAILS sections to INTRO sections, all
> -        contiguous INTRO/DETAILS sections at the start of a QAPIDoc
> -        section list are treated as "the intro".
> -
> -        Once INTRO conversion is complete, this helper will no longer be
> -        needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
> -        be sufficient.
> -        """
> -        first = self.all_sections[0]
> -        if first.text and first.kind == QAPIDoc.Kind.INTRO:
> -            # First section is introduction and is non-empty: insert here.
> -            # Rest assured all of this ugliness will very soon go away.
> -            # Pinkie-swear.
> -            self.all_sections.insert(1, section)
> -            return
> -
> -        index = 0
> -        for index, ref_section in enumerate(self.all_sections):
> -            if ref_section.kind.name in ("INTRO", "DETAILS"):
> -                continue
> -            break
> -        else:
> -            index += 1
> -
> -        self.all_sections.insert(index, section)
> -
>      def append_member_stub(self, stub: 'QAPIDoc.Section') -> None:
> -
>          """
>          Append a stub section after any Member sections.
>          """
>          if self._insert_near_kind(QAPIDoc.Kind.MEMBER, stub, True):
>              return
>  
> -        # No MEMBER sections present. Insert after INTRO/DETAILS sections.
> -        self._insert_after_intro(stub)
> +        # No MEMBER sections present. Insert after INTRO section.
> +        self._insert_near_kind(QAPIDoc.Kind.INTRO, stub, after=True)

There can only be one INTRO section, and it must be first.  So this must
be equivalent to

           self.all_sections.(1, stub)

Correct?

The argument for using the more complex ._insert_near_kind() is of
course symmetry with the other case.  Okay.

We have three ._insert_near_kind() calls:

        if self._insert_near_kind(QAPIDoc.Kind.MEMBER, stub, True):

        self._insert_near_kind(QAPIDoc.Kind.INTRO, stub, after=True)

        if any(self._insert_near_kind(kind, stub, after) for kind, after in (
                [...]
        )):

None of them omit the optional last argument.  Two pass it positionally,
one as a keyword argument.  Let's dumb this down to mandatory argument.

>  
>      def connect_member(self, member: 'QAPISchemaMember') -> None:
>          if member.name not in self._args:
> @@ -932,10 +898,10 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
>      def ensure_returns(self, info: QAPISourceInfo) -> None:
>          # This is more complicated than it ought to be.  The doc
>          # parser should already know where a generated RETURNS section
> -        # should go.  It currently doesn't, mostly because it accepts
> -        # tagged sections in any order.
> +        # should go.  It currently doesn't.
>          #
> -        # TODO: Tighten doc syntax and simplify.
> +        # TODO: Take advantage of the new strict section ordering and
> +        # simplify this algorithm.
>  
>          if any(s.kind == QAPIDoc.Kind.RETURNS for s in self.all_sections):
>              return
> @@ -950,12 +916,11 @@ def ensure_returns(self, info: QAPISourceInfo) -> None:
>                  (QAPIDoc.Kind.ERRORS, False),
>                  # 3. Elif features, right *before* those.
>                  (QAPIDoc.Kind.FEATURE, False),
> +                # 4. Else, right *after* the intro.
> +                (QAPIDoc.Kind.INTRO, True),
>          )):
>              return
>  
> -        # Otherwise, it should go right after the intro.
> -        self._insert_after_intro(stub)
> -

We now have

           if any(call for ...)
               return
           [implicit return at end of function]

Please simplify to

           any(call for ...)

or maybe even

           for ...:
               if call:
                   break

>      def check_expr(self, expr: QAPIExpression) -> None:
>          if 'command' in expr:
>              if self._returns and 'returns' not in expr:


