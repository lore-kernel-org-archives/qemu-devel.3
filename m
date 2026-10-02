Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64453CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 07:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCXxe-0003QM-Eb; Fri, 02 Oct 2026 03:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xCXxb-0003Q0-K9
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 03:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xCXxY-0003TP-4n
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 03:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790927134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=3ERt7tsRQBfh8ZRUyqk87sWaiHQQX/q4bR6kz67ljtE=;
 b=K9qyZ1j8KazptkikFfhUAHipWwLWjtBiVxeuQpRYcWK5QX+TzgdHpkCf7LBr3VKTHK7TGe
 XbtaBcWZhtwZZaBKz6ZrmyWiyoFtNP2lQWBC4t9Jfagj6soyz3pRgMw9ariZ48kxjZ3PtA
 RU3FxWJBkHv47/2hdoC7Di6d0rA5SlI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-R14POc55OZKIBSl13K1mMQ-1; Fri,
 02 Oct 2026 03:45:31 -0400
X-MC-Unique: R14POc55OZKIBSl13K1mMQ-1
X-Mimecast-MFC-AGG-ID: R14POc55OZKIBSl13K1mMQ_1790927129
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC3D01955EA1; Fri,  2 Oct 2026 07:45:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E3401800370; Fri,  2 Oct 2026 07:45:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 076C021E6A04; Fri, 02 Oct 2026 09:45:24 +0200 (CEST)
Resent-To: michael.roth@amd.com, jasowangio@gmail.com, zhao1.liu@intel.com,
 mchehab+huawei@kernel.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 stefanb@linux.vnet.ibm.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 jiri@resnulli.us, alex@shazbot.org, farosas@suse.de,
 vsementsov@yandex-team.ru
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Fri, 02 Oct 2026 09:45:23 +0200
Resent-Message-ID: <87ld8g5ywc.fsf@pond.sub.org>
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
Subject: Re: [PATCH 13/14] qapi/parser: add new _sections mapping
In-Reply-To: <20260928223657.2303684-14-jsnow@redhat.com> (John Snow's message
 of "Mon, 28 Sep 2026 18:36:56 -0400")
References: <20260928223657.2303684-1-jsnow@redhat.com>
 <20260928223657.2303684-14-jsnow@redhat.com>
Date: Fri, 02 Oct 2026 09:24:37 +0200
Message-ID: <87se2o5zuy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Modify the _sections field to be a mapping between section kinds and a
> list of sections instead of a simple, flat list.
>
> This makes it trivial to insert new auto-generated sections at the
> correct position in the collection instead of needing to iterate
> carefully over the list every time.
>
> As a result, a lot of helpers we had to help us manage these
> insertions are now unnecessary and can be deleted with extreme
> prejudice.
>
> NOTE: The remaining fishy use of a member insertion by the qapidoc
> generator still remains, though it uses a simpler code pathway
> now. The addition of the actual inliner mechanism will be the final
> piece to remove this hack.
>
> NOTE 2: Because "TODO:" sections are not strictly ordered in source,
> this new section collection mechanism just lumps them in at the
> end. For our generated documentation, this is functionally identical
> as we do not render those sections anyway, but there is a noticeable
> impact on our unit tests which *do* render TODO sections.

This takes a path between the two extremes:

1. Throw them away.  Makes them completely invisible to the tests.

2. Fully preserve order information somehow.

   Consider this doc comment from doc-good.json:

    ##
    # @cmd:
    #
    # @arg1:
    #     description starts on a new line,
    #     indented
    #
    # @arg2: description starts on the same line
    #     remainder indented differently
    #
    # Returns: @Object
    #
    # Errors: some
    #
    # Features:
    # @cmd-feat1: a feature
    # @cmd-feat2: another feature
    #
    # .. note:: @arg3 is undocumented
    #
    # TODO: frobnicate
    #
    # .. admonition:: Notes
    #
    #  - Lorem ipsum dolor sit amet
    #  - Ut enim ad minim veniam
    [...]
    # Since: 2.10
    ##

  Its sections are:

    kind                source order
    --------------------------------------------
    Intro               0
    Member=arg1         1
    Member=arg2         2
    Member=arg3         none (it's synthesized)
    Returns             3
    Errors              4
    Feature=cmd-feat1   5
    Feature=cmd-feat2   6
    Details             7
    TODO                8
    Details             9
    Since               10

  We could record the number in the right column.

  Or we could try to use existing .info.line instead.  Slight
  complication: synthesized section Member=arg3 has a funny value there.

Mind, I'm not making demands here, I'm throwing you ideas.

> NOTE 3: This patch is what makes it obvious as to why we need
> _append(), len(), and iter() implementations.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

I'd like the commit message to point out that and how we don't lose
source order, except for TODO.

Before the patch, ._sections is a flat list in source order.

The patch turns it into a dict of lists.  The strict section ordering
established in prior patches ensures that walking the dict's lists in
order is in source order: we add sections in source order, all sections
of the same kind are together, we keep the dict elements (lists) in
source order by adding at the end, and dict order is insertion order
since Python 3.6.

Except for the TODOs, because these are not strictly ordered.

> ---
>  docs/sphinx/qapidoc.py         |  6 +--
>  scripts/qapi/parser.py         | 74 ++++++++--------------------------
>  tests/qapi-schema/doc-good.out |  4 +-
>  3 files changed, 20 insertions(+), 64 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index fd666be131f..41acb560628 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -371,11 +371,7 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
>          # other users of the QAPISchema or QAPIDoc objects outside of
>          # the document generator. Fishy, but not harmful.
>          if ent.doc:
> -            ent.doc.append_member_stub(
> -                QAPIDoc.ArgSection(
> -                    ent.doc.info, QAPIDoc.Kind.MEMBER, "q_dummy"
> -                )
> -            )
> +            ent.doc.new_argument(ent.doc.info, "q_dummy")
>  
>          sections = list(ent.doc) if ent.doc else []
>  
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 894b8979b9e..1d8f1d39ab1 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -758,8 +758,13 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
>          self.info = info
>          # definition doc's symbol, None for free-form doc
>          self.symbol: Optional[str] = symbol
> -        # the sections in textual order
> -        self._sections: List[QAPIDoc.Section] = []
> +
> +        # all sections arranged by kind. This is identical to source

All

> +        # order, with the exception of TODO sections and any generated
> +        # sections that are appended post-hoc.

post hoc (no dash), I think.

> +        self._sections: Dict[QAPIDoc.Kind, List[QAPIDoc.Section]] = {
> +            kind: [] for kind in QAPIDoc.Kind
> +        }
>  
>          # The most recently appended section, on which append_line operates
>          self._active_section: Optional[QAPIDoc.Section] = None
> @@ -767,6 +772,7 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
>          # dicts mapping parameter/feature names to their description
>          self._args: Dict[str, QAPIDoc.ArgSection] = {}
>          self._features: Dict[str, QAPIDoc.ArgSection] = {}
> +
>          # a command's "Returns" and "Errors" section
>          self._returns: Optional[QAPIDoc.Section] = None
>          self._errors: Optional[QAPIDoc.Section] = None

This looks out of place.

> @@ -781,11 +787,8 @@ def _append(self, section: 'QAPIDoc.Section') -> None:
>          """
>          Primary internal interface for adding a new section.
>  
> -        It is intended to become the sole access point for adding new
> -        sections to the QAPIDoc section list, but we are currently in
> -        a transitional phase where other methods access the section
> -        list directly to do insertions of generated sections at
> -        targeted points.
> +        All other methods/helpers/etc ultimately use this and only
> +        this interface for appending a new section.
>          """
>          if section.kind == QAPIDoc.Kind.RETURNS:
>              if self._returns:
> @@ -802,14 +805,15 @@ def _append(self, section: 'QAPIDoc.Section') -> None:
>                  raise QAPISemError(
>                      section.info, "duplicated '%s' section" % section.kind)
>              self.since = section
> -        self._sections.append(section)
> +        self._sections[section.kind].append(section)
>          self._active_section = section
>  
>      def __iter__(self) -> Iterator['QAPIDoc.Section']:

Worth a comment about source order?  There's already one next to
self._sections.

> -        return iter(self._sections)
> +        for values in self._sections.values():
> +            yield from values
>  
>      def __len__(self) -> int:
> -        return len(self._sections)
> +        return sum(len(x) for x in self._sections.values())

No longer used as far as I can tell.

>  
>      def end(self) -> None:
>          for section in self:
> @@ -870,32 +874,6 @@ def append_line(self, line: str) -> None:
>          assert self._active_section is not None
>          self._active_section.append_line(line)
>  
> -    def _insert_near_kind(
> -        self,
> -        kind: 'QAPIDoc.Kind',
> -        new_sect: 'QAPIDoc.Section',
> -        after: bool = False,
> -    ) -> bool:
> -        """Insert or append a new doc section at a specific point."""
> -        for idx, sect in enumerate(reversed(list(self))):
> -            if sect.kind == kind:
> -                pos = len(self) - idx - 1

This is where it's used before this patch.

> -                if after:
> -                    pos += 1
> -                self._sections.insert(pos, new_sect)
> -                return True
> -        return False
> -
> -    def append_member_stub(self, stub: 'QAPIDoc.Section') -> None:
> -        """
> -        Append a stub section after any Member sections.
> -        """
> -        if self._insert_near_kind(QAPIDoc.Kind.MEMBER, stub, True):
> -            return
> -
> -        # No MEMBER sections present. Insert after INTRO section.
> -        self._insert_near_kind(QAPIDoc.Kind.INTRO, stub, after=True)
> -
>      def connect_member(self, member: 'QAPISchemaMember') -> None:
>          if member.name not in self._args:
>              assert member.info
> @@ -908,7 +886,7 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
>              stub_section = QAPIDoc.ArgSection(
>                  self.info, QAPIDoc.Kind.MEMBER, member.name)
>              self._args[member.name] = stub_section
> -            self.append_member_stub(stub_section)
> +            self._append(stub_section)
>  
>          self._args[member.name].connect(member)
>  
> @@ -920,30 +898,12 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
>          self._features[feature.name].connect(feature)
>  
>      def ensure_returns(self, info: QAPISourceInfo) -> None:
> -        # This is more complicated than it ought to be.  The doc
> -        # parser should already know where a generated RETURNS section
> -        # should go.  It currently doesn't.
> -        #
> -        # TODO: Take advantage of the new strict section ordering and
> -        # simplify this algorithm.
> -
> -        if self._returns:
> +        if self._sections[QAPIDoc.Kind.RETURNS]:

Why not keep the more concise self._returns?

>              return
>  
>          # Stub "Returns" section for undocumented returns value
>          stub = QAPIDoc.Section(info, QAPIDoc.Kind.RETURNS)
> -
> -        if any(self._insert_near_kind(kind, stub, after) for kind, after in (
> -                # 1. If arguments, right after those.
> -                (QAPIDoc.Kind.MEMBER, True),
> -                # 2. Elif errors, right *before* those.
> -                (QAPIDoc.Kind.ERRORS, False),
> -                # 3. Elif features, right *before* those.
> -                (QAPIDoc.Kind.FEATURE, False),
> -                # 4. Else, right *after* the intro.
> -                (QAPIDoc.Kind.INTRO, True),
> -        )):
> -            return
> +        self._append(stub)
>  
>      def check_expr(self, expr: QAPIExpression) -> None:
>          if 'command' in expr:
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 7a485e46037..4a0fae6fce2 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -181,8 +181,6 @@ a feature
>  another feature
>      Details
>  .. note:: @arg3 is undocumented
> -    Todo
> -frobnicate
>      Details
>  .. admonition:: Notes
>  
> @@ -207,6 +205,8 @@ Examples::
>  
>  Note::
>      Ceci n'est pas une note
> +    Todo
> +frobnicate
>      Since
>  2.10
>  doc symbol=cmd-boxed


