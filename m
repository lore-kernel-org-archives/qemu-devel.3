Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A4CC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDiD-0004Xb-VG; Fri, 11 Jul 2025 09:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaDiB-0004LP-JZ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaDi8-0005SB-NM
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752240163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hdWIT9J525HHUr1CDElgiHcdI08lUF26mpVBdb/6GwY=;
 b=I8qWciuo2vlami2VZ0lF8/t7s2nk6xygY+BunJlFb99UJ4z4ddKRawDq8vRgAr7EbKtPWF
 FtbWlQH4p47R67RwyLlBk7iNkWZsQUrSmjaId/DyhDudQOh3YAtybDlMZhMDW8Y+y/dLAO
 duk9wOXZaWHDuIvnVZ47GxbUXvFREKU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-s89zk5rxPvGoVcqSM9W6vw-1; Fri,
 11 Jul 2025 09:22:39 -0400
X-MC-Unique: s89zk5rxPvGoVcqSM9W6vw-1
X-Mimecast-MFC-AGG-ID: s89zk5rxPvGoVcqSM9W6vw_1752240157
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1613195608E; Fri, 11 Jul 2025 13:22:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74DB91955F29; Fri, 11 Jul 2025 13:22:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E3ED121E6A27; Fri, 11 Jul 2025 15:22:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Jiri Pirko <jiri@resnulli.us>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ani Sinha <anisinha@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Peter Xu <peterx@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>,  Jason Wang <jasowang@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  qemu-trivial@nongnu.org,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Lukas
 Straub <lukasstraub2@web.de>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Michael Tokarev
 <mjt@tls.msk.ru>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Zhenwei Pi <pizhenwei@bytedance.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 2/4] docs, qapi: generate undocumented return sections
In-Reply-To: <20250711051045.51110-3-jsnow@redhat.com> (John Snow's message of
 "Fri, 11 Jul 2025 01:10:43 -0400")
References: <20250711051045.51110-1-jsnow@redhat.com>
 <20250711051045.51110-3-jsnow@redhat.com>
Date: Fri, 11 Jul 2025 15:22:30 +0200
Message-ID: <87cya6zwtl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

> This patch changes the qapidoc parser to generate stub Return value
> documentation for any command that has a return value but does not have
> a "Returns:" doc section.
>
> The stubs include just the type name, which will be rendered with a
> cross-reference link in the HTML output.
>
> The algorithm for where return sections are placed is as follows:
>
> 1. If we have arguments, return goes right after them.
> 2. Else if we have errors, return goes right before them.
> 3. Else if we have features, return goes right before them.
> 4. Else return goes right after the intro
>
> To facilitate this algorithm, a "TODO:" hack line is used to separate
> the intro from the remainder of the documentation block in cases where
> there are no other sections to separate the intro from e.g. examples and
> additional detail meant to appear below the key sections of interest.

Good, except it neglects to spell out *why* we do this.  Here's my
attempt:

  qapi: Fix undocumented return values by generating something

  Generated command documentation lacks information on return value in
  several cases, e.g. query-tpm.

  The obvious fix would be to require a Returns: section when a command
  returns something.

  However, note that many existing Returns: sections are pretty useless:
  the description is basically the return type, which then gets rendered
  like "Return: <Type> =E2=80=93 <basically the return type>".  This sugges=
ts
  that a description is often not really necessary, and requiring one
  isn't useful.

  Instead, generate the obvious minimal thing when Returns: is absent:
  "Return: <Type>".

  This auto-generated Return documentation is placed is as follows:

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 14 ++++++++------
>  qapi/machine.json      |  2 ++
>  scripts/qapi/parser.py | 35 +++++++++++++++++++++++++++++++++++
>  scripts/qapi/schema.py |  3 +++
>  4 files changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 8011ac9efaf..77e28a65cfc 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -255,16 +255,18 @@ def visit_feature(self, section: QAPIDoc.ArgSection=
) -> None:
>      def visit_returns(self, section: QAPIDoc.Section) -> None:
>          assert isinstance(self.entity, QAPISchemaCommand)
>          rtype =3D self.entity.ret_type
> -        # q_empty can produce None, but we won't be documenting anything
> -        # without an explicit return statement in the doc block, and we
> -        # should not have any such explicit statements when there is no
> -        # return value.
> +        # return statements will not be present (and won't be
> +        # autogenerated) for any command that doesn't return
> +        # *something*, so rtype will always be defined here.
>          assert rtype
>=20=20
>          typ =3D self.format_type(rtype)
>          assert typ
> -        assert section.text
> -        self.add_field("return", typ, section.text, section.info)
> +
> +        if section.text:
> +            self.add_field("return", typ, section.text, section.info)
> +        else:
> +            self.add_lines(f":return-nodesc: {typ}", section.info)
>=20=20
>      def visit_errors(self, section: QAPIDoc.Section) -> None:
>          # FIXME: the formatting for errors may be inconsistent and may
> diff --git a/qapi/machine.json b/qapi/machine.json
> index f712e7da6d6..e3e0505a4b4 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1301,6 +1301,8 @@
>  # Return the amount of initially allocated and present hotpluggable
>  # (if enabled) memory in bytes.
>  #
> +# TODO: This line is a hack to separate the example from the body
> +#
>  # .. qmp-example::
>  #
>  #     -> { "execute": "query-memory-size-summary" }
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 949d9e8bff7..aa8f1852c50 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -815,6 +815,41 @@ def connect_feature(self, feature: 'QAPISchemaFeatur=
e') -> None:
>                                 % feature.name)
>          self.features[feature.name].connect(feature)
>=20=20
> +    def ensure_returns(self, info: QAPISourceInfo) -> None:
> +
> +        def _insert_near_kind(
> +            kind: QAPIDoc.Kind,
> +            new_sect: QAPIDoc.Section,
> +            after: bool =3D False,
> +        ) -> bool:
> +            for sect in filter(lambda sect: sect.kind =3D=3D kind, rever=
sed(
> +                    self.all_sections)):
> +                idx =3D self.all_sections.index(sect) + (1 if after else=
 0)
> +                self.all_sections.insert(idx, new_sect)
> +                return True
> +            return False

I find this function a bit hard to understand.

filter() returns an iterator for the sections of kind @kind in
@all_sections.

The for loop doesn't actually loop, it executes its body at most once.

If there are no sections of kind @kind, it doesn't execute the body, and
returns False.

If there are such sections, the body is executed for the first one,
i.e. the last section of kind @kind in @all_sections.  It then searches
@all_sections again to find its index, inserts the new section before or
after that index, and returns True.

Here's my attempt to write less clever code:

           def _insert_near_kind(
               kind: QAPIDoc.Kind,
               new_sect: QAPIDoc.Section,
               after: bool =3D False,
           ) -> bool:
               for idx, sect in enumerate(reversed(self.all_sections)):
                   if sect.kind =3D=3D kind:
                       pos =3D len(self.all_sections) - idx - 1
                       if after:
                           pos +=3D 1
                       self.all_sections.insert(pos, new_sect)
                       return True
               return False

What do you think?

> +
> +        if any(s.kind =3D=3D QAPIDoc.Kind.RETURNS for s in self.all_sect=
ions):
> +            return
> +
> +        # Stub "Returns" section for undocumented returns value
> +        stub =3D QAPIDoc.Section(info, QAPIDoc.Kind.RETURNS)
> +
> +        if any(_insert_near_kind(kind, stub, after) for kind, after in (
> +                # 1. If arguments, right after those.
> +                (QAPIDoc.Kind.MEMBER, True),
> +                # 2. Elif errors, right *before* those.
> +                (QAPIDoc.Kind.ERRORS, False),
> +                # 3. Elif features, right *before* those.
> +                (QAPIDoc.Kind.FEATURE, False),
> +        )):
> +            return
> +
> +        # Otherwise, it should go right after the intro. The intro
> +        # is always the first section and is always present (even
> +        # when empty), so we can insert directly at index=3D1 blindly.
> +        self.all_sections.insert(1, stub)
> +
>      def check_expr(self, expr: QAPIExpression) -> None:
>          if 'command' in expr:
>              if self.returns and 'returns' not in expr:
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index cbe3b5aa91e..3abddea3525 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -1062,6 +1062,9 @@ def connect_doc(self, doc: Optional[QAPIDoc] =3D No=
ne) -> None:
>              if self.arg_type and self.arg_type.is_implicit():
>                  self.arg_type.connect_doc(doc)
>=20=20
> +            if self.ret_type and self.info:
> +                doc.ensure_returns(self.info)
> +
>      def visit(self, visitor: QAPISchemaVisitor) -> None:
>          super().visit(visitor)
>          visitor.visit_command(

Let's check how generated output changes:

  diff -rup 01-qapi-gen-1711c67f7c/qemu-qmp-ref.txt 02-qapi-gen-cfb5bf6462/=
qemu-qmp-ref.txt
  --- 01-qapi-gen-1711c67f7c/qemu-qmp-ref.txt	2025-07-11 11:38:27.142499312=
 +0200
  +++ 02-qapi-gen-cfb5bf6462/qemu-qmp-ref.txt	2025-07-11 11:41:35.193205635=
 +0200
  @@ -3607,6 +3607,9 @@ Command x-debug-query-block-graph (Since

      Get the block graph.

  +   Return:
  +      "XDbgBlockGraph"
  +

Clause 3. Else if we have features, return goes right before them.
Good.

      Features:
         * **unstable** -- This command is meant for debugging.

  @@ -10350,6 +10353,9 @@ Command query-tpm (Since: 1.5)

      Return information about the TPM device

  +   Return:
  +      "[""TPMInfo""]"
  +

Clause 4. Else return goes right after the intro.  Good.

Note: schema source terminates intro with Since: section.

      Example::

         -> { "execute": "query-tpm" }
  @@ -13991,6 +13997,9 @@ Command query-dirty-rate (Since: 5.2)
           which to report calculation time. By default it is reported in
           seconds.  (Since 8.2)

  +   Return:
  +      "DirtyRateInfo"
  +

Clause 1. If we have arguments, return goes right after them.  Good.

      Example: Measurement is in progress:

          <- {"status": "measuring", "sample-pages": 512,
  @@ -14061,6 +14070,9 @@ Command query-vcpu-dirty-limit (Since: 7
      Return information about virtual CPU dirty page rate limits, if
      any.

  +   Return:
  +      "[""DirtyLimitInfo""]"
  +

Clause 4. Else return goes right after the intro.  Good.

      Example::

         -> {"execute": "query-vcpu-dirty-limit"}
  @@ -16775,6 +16787,9 @@ Command query-vm-generation-id (Since: 2

      Show Virtual Machine Generation ID

  +   Return:
  +      "GuidInfo"
  +

Clause 4. Else return goes right after the intro.  Good.

   Command system_reset (Since: 0.14)

      Performs a hard reset of a guest.
  @@ -17548,6 +17563,9 @@ Command query-memory-size-summary (Since
      Return the amount of initially allocated and present hotpluggable
      (if enabled) memory in bytes.

  +   Return:
  +      "MemoryInfo"
  +

Clause 4. Else return goes right after the intro.  Good.

      Example::

         -> { "execute": "query-memory-size-summary" }
  @@ -17739,6 +17757,9 @@ Command query-memory-devices (Since: 2.1

      Lists available memory devices and their state

  +   Return:
  +      "[""MemoryDeviceInfo""]"
  +

Clause 4. Else return goes right after the intro.  Good.

      Example::

         -> { "execute": "query-memory-devices" }
  @@ -20012,6 +20033,9 @@ Command query-acpi-ospm-status (Since: 2
      Return a list of ACPIOSTInfo for devices that support status
      reporting via ACPI _OST method.

  +   Return:
  +      "[""ACPIOSTInfo""]"
  +

Clause 4. Else return goes right after the intro.  Good.

      Example::

         -> { "execute": "query-acpi-ospm-status" }
  @@ -20498,6 +20522,9 @@ Command query-stats-schemas (Since: 7.1)
         * **provider** ("StatsProvider", *optional*) -- a provider to
           restrict the query to.

  +   Return:
  +      "[""StatsSchema""]"
  +

Clause 1. If we have arguments, return goes right after them.  Good.

      Note:

        Runtime-collected statistics and their names fall outside QEMU's

Placement is all good.

Clauses 1, 3, 4 covered.  The next patch will cover clause 2.


In all instances of clause 4 but one, intro is terminated by a Since:
section.

The exception is query-memory-size-summary, which has its Since: at the
end.  It therefore needs the "TODO:" hack line you add to separate intro
from example.

All but one of the intro-terminating Since: are followed by an example.
We more commonly put Since: at the very end (roughly 3 out of four
times).  But if we moved these to the end, we'd need a "TODO:" hack line
to separate intro from example.

The need for terminating the intro is not obvious when writing doc
comments.  Mistakes are bound to happen.

I understand the inliner similarly relies on intro-termination for
placement.

We've toyed with the idea of automating since information.  If we pull
that off, the Since: go away.

I think relying on existing Since: for separation is fine for now, but
we'll likely need a more robust solution eventually.

With the commit message amended and preferably with a less clever
version of _insert_near_kind():
Reviewed-by: Markus Armbruster <armbru@redhat.com>


