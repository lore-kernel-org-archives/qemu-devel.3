Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70AEC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVlO-0006BW-8V; Mon, 24 Aug 2026 10:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyVlM-0006B2-B3
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyVlJ-0004XJ-MH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787582096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vShCxNmNZl2ixTeVJG9CCDE9KJKhvzNqsRyL4bLqO1Y=;
 b=Vu8hUk1+exdyQVJRCQSxbyKRCQXRTLw1Ekvy6claTVamx6HSK1/E7RjpAQsRaUCHZeX1Qj
 O1rZjEI7EhIKggvgHb2Kt1Hj1o8RBQecTTTOikIDPSKzLi/HqFPp4yPB9WH529s4Mm70WV
 1RObfjbM+0IJIncsQ0KGoVPR/b7tobQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-lYqv_eZCMnCX3MHzs21A0Q-1; Mon, 24 Aug 2026 10:34:54 -0400
X-MC-Unique: lYqv_eZCMnCX3MHzs21A0Q-1
X-Mimecast-MFC-AGG-ID: lYqv_eZCMnCX3MHzs21A0Q_1787582094
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-845cc1ab48eso138275727b3.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 07:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787582094; cv=none;
 d=google.com; s=arc-20260327;
 b=YTgqK/71ZBpQcMDXS//nx+AYmoUimpnUGpol/+kNmmyDp6t631LQJnMfcc03HYdalg
 vvUv2uN6qpFqXHyugel4xhO75AGbyGEGbgE8nBB+T5KIzkA+K+SJMJuKKuz8B73FXDKc
 bC9vMCTRrYtCLaZH18EgeBmMkZu5paqcP4Q1kD4lJWLUos+NjYL9ooM3hAkYF3y3cKJ1
 VchDufjb9nsOzzF+PNY2c4AZhZDVTSr/yLi4cWyzcsWxUSXsXwwAd8vAzwBi4Y58xxYd
 i3H/lSBPkyd/L99Cbt49gtwGP/kIziccz+G2W01NQcJa57jMwg9KM1+gyQcbZW+d7xfJ
 12XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vShCxNmNZl2ixTeVJG9CCDE9KJKhvzNqsRyL4bLqO1Y=;
 fh=u+TktI8dnQS4/uy62FkWRsYn3WbFn3ONp+4InT/4YY4=;
 b=dhPIKe2Oa8AixkmSTj2IrZaDRVcPXSorY9m8mo0iaSFzfPo/IpMb0bnaNkUEm43TOX
 7OccdJMiwrycSC4M7Bi2t9v+bcv7YZk99xT8aRWZt9b4kiePU2oh3el9bfhnu0Aiq+ac
 mjABe4WD7oU7s5IqZ64RzInEm7YXlbyXS9+mgvDlulHe4TAy5UbAlvwtHneWdemnEuaZ
 X47gCADZXhdAh07AxSWFvsYAKnCg8BSXQ+yovEUPadns6JDx31Hvkd9p9rKS0TDxUrZf
 5QRW3lnInOFsERsRoiACvS7jqXy1aw1oXQ4rMmtOWdt/m6MB3pF+pnd31zkQBIRJdgVx
 hh9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787582094; x=1788186894; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vShCxNmNZl2ixTeVJG9CCDE9KJKhvzNqsRyL4bLqO1Y=;
 b=aFzVjxRqTIKgJpoY07BvLYNMQVUJYGug/eAyxlIqghQPMqbWY7p59vA8x6uUZeou/R
 d7coWYGOARfw+PwMHj6CqWrG6AitHitFkCdxvNzlsFHq4HrUFRan9zTbT2gHw1B6JWsD
 HkxPtHEIj+jA2nxXU1970ymGOZp+LW5znzzRjHH2vbQlCfLbKSLCFeouz28O1P52amWB
 62WxIMf9JZiMQiBJZR7c6WTfCROxMiFIf1TKtsNaOwLcGQekxVcn/CcN2BPkyDSio03U
 ghiR+i7iI+LAoRzKpdmouWs2+caJ4m/oOG19cPJNnbran/WoqRQIlT8Lg/JyNNYG/To4
 9NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787582094; x=1788186894;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vShCxNmNZl2ixTeVJG9CCDE9KJKhvzNqsRyL4bLqO1Y=;
 b=IjKG1O4jlMMYulJpvHfVwp01/16eyUmGxmqPlNT5AmdmN3UGrggjbeEhenwUataBXe
 2IqOZYjJjJqFODTSkkEx5P5q2SXxL5hb8+6mYCS9zpPFMalUGdWd4JWtb123ooEJWeDC
 KQPFE274PeRZt0PEGpRa+KLpJjBmVw08amaYOs+pMeAXUgRo4Zi1Z2qZJMDQem88Vxyj
 EyKc4z6mRG++0MnDZhP8a/PcNwSGAz2cIdiywOwX7eRMiV8yXHbZkZkBV72sZ5jhiO+j
 846xElp3owoq0jHuHZLqSQ3OlYnky/kANEF7+pl3DJxHvkS1OW5q+jCc+C0c61WBdoeQ
 HI6g==
X-Gm-Message-State: AFuF++mMY850HYTRVIRJA36cZTr8EergG82Q//9DKCp6N9CYrrq5lg+E
 WJy5+wCMlooDsRP2xM8cGQi72E9K+s60mEQoiLe+iuzRBRR8YihNFiUaYiYCIvovZx6y/Msvm8U
 5O8pB7TvJbQmStC0eOoxLaDYFqx5P0RYxnupwDRjhg2BBIlnnVFIpdHsIhfDHd8Xdq+ohtWpbB1
 1xejhxFgkbxzZgtvM16aG4yEBKYGJihjw=
X-Gm-Gg: AR+sD12fELlnnbe/ZKCh+bCEu4FjyAtjACQmjfs+dsaydl4XZEzX+fnxUH/wEEwzwLO
 fWiGzQrePj0oSi25IftUJCbTm9DaLGv/BIfadVMTaDcbNrcT06o2Gt3RWl5Lwl4wyBqWAZ5Q3xm
 1+6rmwbqklEbe2uQDTCcg1TdDi3sDBbz8QhlWHbnTjSLtm2zUNervkaDle7mHWvb155KYW4ITIa
 QhLbEQfVBJMFcHG
X-Received: by 2002:a53:b885:0:b0:66c:85e3:7f30 with SMTP id
 956f58d0204a3-66ce4b01154mr7360604d50.37.1787582093622; 
 Mon, 24 Aug 2026 07:34:53 -0700 (PDT)
X-Received: by 2002:a53:b885:0:b0:66c:85e3:7f30 with SMTP id
 956f58d0204a3-66ce4b01154mr7360578d50.37.1787582093015; Mon, 24 Aug 2026
 07:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-13-jsnow@redhat.com>
 <87h5kjuaa8.fsf@pond.sub.org>
In-Reply-To: <87h5kjuaa8.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 24 Aug 2026 10:34:40 -0400
X-Gm-Features: AcwNN1Uu24Um54ZO_9TPULjBwcTJbF0E8ol9eFNmukZLu7-NNjJPLvDLS-ee2yo
Message-ID: <CAFn=p-YwVQi0Hh7HPNMz82VS4QuujSv_u4yvWWP6tsoXx+=zAg@mail.gmail.com>
Subject: Re: [PATCH 12/12] sphinx: drop qapidoc back-compat overboiled
 spaghetti dinner
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 24, 2026 at 5:40=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Drop the disgusting amount of hacks required to keep qapidoc working
> > on older Sphinx versions, enjoying the cutting edge technology of
> > 2023.
> >
> > This felt like an achievement to have written, and equally feels an
> > achievement to have deleted.
>
> It was, and it is.
>
> docs/sphinx/compat.py is black magic.  It was difficult and expensive to
> write, and it would be difficult and expensive to modify.  More so (much
> more so) for anybody not John Snow.  Since it can go now, it must.
>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/compat.py      | 230 -------------------------------------
> >  docs/sphinx/qapi_domain.py |  47 ++++----
> >  2 files changed, 22 insertions(+), 255 deletions(-)
> >  delete mode 100644 docs/sphinx/compat.py
> >
> > diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
> > deleted file mode 100644
> > index 9cf7fe006e4..00000000000
> > --- a/docs/sphinx/compat.py
> > +++ /dev/null
> > @@ -1,230 +0,0 @@
> > -"""
> > -Sphinx cross-version compatibility goop
> > -"""
> > -
> > -import re
> > -from typing import (
> > -    TYPE_CHECKING,
> > -    Any,
> > -    Callable,
> > -    Optional,
> > -    Type,
> > -)
> > -
> > -from docutils import nodes
> > -from docutils.nodes import Element, Node, Text
> > -from docutils.statemachine import StringList
> > -
> > -import sphinx
> > -from sphinx import addnodes, util
> > -from sphinx.directives import ObjectDescription
> > -from sphinx.environment import BuildEnvironment
> > -from sphinx.roles import XRefRole
> > -from sphinx.util import docfields
> > -from sphinx.util.docutils import (
> > -    ReferenceRole,
> > -    SphinxDirective,
> > -    switch_source_input,
> > -)
> > -from sphinx.util.typing import TextlikeNode
> > -
> > -
> > -MAKE_XREF_WORKAROUND =3D sphinx.version_info[:3] < (4, 1, 0)
> > -
> > -
> > -SpaceNode: Callable[[str], Node]
> > -KeywordNode: Callable[[str, str], Node]
> > -
> > -if sphinx.version_info[:3] >=3D (4, 0, 0):
> > -    SpaceNode =3D addnodes.desc_sig_space
> > -    KeywordNode =3D addnodes.desc_sig_keyword
> > -else:
> > -    SpaceNode =3D Text
> > -    KeywordNode =3D addnodes.desc_annotation
> > -
> > -
> > -def nested_parse_with_titles(
> > -    directive: SphinxDirective, content_node: Element
> > -) -> None:
> > -    """
> > -    This helper preserves error parsing context across sphinx versions=
.
> > -    """
> > -
> > -    # necessary so that the child nodes get the right source/line set
> > -    content_node.document =3D directive.state.document
> > -
> > -    try:
> > -        # Modern sphinx (6.2.0+) supports proper offsetting for
> > -        # nested parse error context management
> > -        util.nodes.nested_parse_with_titles(
> > -            directive.state,
> > -            directive.content,
> > -            content_node,
> > -            content_offset=3Ddirective.content_offset,
> > -        )
> > -    except TypeError:
> > -        # No content_offset argument. Fall back to SSI method.
> > -        with switch_source_input(directive.state, directive.content):
> > -            util.nodes.nested_parse_with_titles(
> > -                directive.state, directive.content, content_node
> > -            )
> > -
> > -
> > -# ###########################################
> > -# xref compatibility hacks for Sphinx < 4.1 #
> > -# ###########################################
> > -
> > -# When we require >=3D Sphinx 4.1, the following function and the
> > -# subsequent 3 compatibility classes can be removed. Anywhere in
> > -# qapi_domain that uses one of these Compat* types can be switched to
> > -# using the garden-variety lib-provided classes with no trickery.
> > -
> > -
> > -def _compat_make_xref(  # pylint: disable=3Dunused-argument
> > -    self: sphinx.util.docfields.Field,
> > -    rolename: str,
> > -    domain: str,
> > -    target: str,
> > -    innernode: Type[TextlikeNode] =3D addnodes.literal_emphasis,
> > -    contnode: Optional[Node] =3D None,
> > -    env: Optional[BuildEnvironment] =3D None,
> > -    inliner: Any =3D None,
> > -    location: Any =3D None,
> > -) -> Node:
> > -    """
> > -    Compatibility workaround for Sphinx versions prior to 4.1.0.
> > -
> > -    Older sphinx versions do not use the domain's XRefRole for parsing
> > -    and formatting cross-references, so we need to perform this magick
> > -    ourselves to avoid needing to write the parser/formatter in two
> > -    separate places.
> > -
> > -    This workaround isn't brick-for-brick compatible with modern Sphin=
x
> > -    versions, because we do not have access to the parent directive's
> > -    state during this parsing like we do in more modern versions.
> > -
> > -    It's no worse than what pre-Sphinx 4.1.0 does, so... oh well!
> > -    """
> > -
> > -    # Yes, this function is gross. Pre-4.1 support is a miracle.
> > -    # pylint: disable=3Dtoo-many-locals
> > -
> > -    assert env
> > -    # Note: Sphinx's own code ignores the type warning here, too.
> > -    if not rolename:
> > -        return contnode or innernode(target, target)  # type: ignore[c=
all-arg]
> > -
> > -    # Get the role instance, but don't *execute it* - we lack the
> > -    # correct state to do so. Instead, we'll just use its public
> > -    # methods to do our reference formatting, and emulate the rest.
> > -    role =3D env.get_domain(domain).roles[rolename]
> > -    assert isinstance(role, XRefRole)
> > -
> > -    # XRefRole features not supported by this compatibility shim;
> > -    # these were not supported in Sphinx 3.x either, so nothing of
> > -    # value is really lost.
> > -    assert not target.startswith("!")
> > -    assert not re.match(ReferenceRole.explicit_title_re, target)
> > -    assert not role.lowercase
> > -    assert not role.fix_parens
> > -
> > -    # Code below based mostly on sphinx.roles.XRefRole; run() and
> > -    # create_xref_node()
> > -    options =3D {
> > -        "refdoc": env.docname,
> > -        "refdomain": domain,
> > -        "reftype": rolename,
> > -        "refexplicit": False,
> > -        "refwarn": role.warn_dangling,
> > -    }
> > -    refnode =3D role.nodeclass(target, **options)
> > -    title, target =3D role.process_link(env, refnode, False, target, t=
arget)
> > -    refnode["reftarget"] =3D target
> > -    classes =3D ["xref", domain, f"{domain}-{rolename}"]
> > -    refnode +=3D role.innernodeclass(target, title, classes=3Dclasses)
> > -
> > -    # This is the very gross part of the hack. Normally,
> > -    # result_nodes takes a document object to which we would pass
> > -    # self.inliner.document. Prior to Sphinx 4.1, we don't *have* an
> > -    # inliner to pass, so we have nothing to pass here. However, the
> > -    # actual implementation of role.result_nodes in this case
> > -    # doesn't actually use that argument, so this winds up being
> > -    # ... fine. Rest easy at night knowing this code only runs under
> > -    # old versions of Sphinx, so at least it won't change in the
> > -    # future on us and lead to surprising new failures.
> > -    # Gross, I know.
> > -    result_nodes, _messages =3D role.result_nodes(
> > -        None,  # type: ignore
> > -        env,
> > -        refnode,
> > -        is_ref=3DTrue,
> > -    )
> > -    return nodes.inline(target, "", *result_nodes)
> > -
> > -
> > -class CompatField(docfields.Field):
> > -    if MAKE_XREF_WORKAROUND:
> > -        make_xref =3D _compat_make_xref
> > -
> > -
> > -class CompatGroupedField(docfields.GroupedField):
> > -    if MAKE_XREF_WORKAROUND:
> > -        make_xref =3D _compat_make_xref
> > -
> > -
> > -class CompatTypedField(docfields.TypedField):
> > -    if MAKE_XREF_WORKAROUND:
> > -        make_xref =3D _compat_make_xref
> > -
> > -
> > -# ################################################################
> > -# Nested parsing error location fix for Sphinx 5.3.0 < x < 6.2.0 #
> > -# ################################################################
> > -
> > -# When we require Sphinx 4.x, the TYPE_CHECKING hack where we avoid
> > -# subscripting ObjectDescription at runtime can be removed in favor of
> > -# just always subscripting the class.
> > -
> > -# When we require Sphinx > 6.2.0, the rest of this compatibility hack
> > -# can be dropped and QAPIObject can just inherit directly from
> > -# ObjectDescription[Signature].
> > -
> > -SOURCE_LOCATION_FIX =3D (5, 3, 0) <=3D sphinx.version_info[:3] < (6, 2=
, 0)
> > -
> > -Signature =3D str
> > -
> > -
> > -if TYPE_CHECKING:
> > -    _BaseClass =3D ObjectDescription[Signature]
> > -else:
> > -    _BaseClass =3D ObjectDescription
> > -
> > -
> > -class ParserFix(_BaseClass):
> > -
> > -    _temp_content: StringList
> > -    _temp_offset: int
> > -    _temp_node: Optional[addnodes.desc_content]
> > -
> > -    def before_content(self) -> None:
> > -        # Work around a sphinx bug and parse the content ourselves.
> > -        self._temp_content =3D self.content
> > -        self._temp_offset =3D self.content_offset
> > -        self._temp_node =3D None
> > -
> > -        if SOURCE_LOCATION_FIX:
> > -            self._temp_node =3D addnodes.desc_content()
> > -            self.state.nested_parse(
> > -                self.content, self.content_offset, self._temp_node
> > -            )
> > -            # Sphinx will try to parse the content block itself,
> > -            # Give it nothingness to parse instead.
> > -            self.content =3D StringList()
> > -            self.content_offset =3D 0
> > -
> > -    def transform_content(self, content_node: addnodes.desc_content) -=
> None:
> > -        # Sphinx workaround: Inject our parsed content and restore sta=
te.
> > -        if self._temp_node:
> > -            content_node +=3D self._temp_node.children
> > -            self.content =3D self._temp_content
> > -            self.content_offset =3D self._temp_offset
> > diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> > index f561dc465f8..e8bae5587fb 100644
> > --- a/docs/sphinx/qapi_domain.py
> > +++ b/docs/sphinx/qapi_domain.py
> > @@ -30,20 +30,10 @@
> >  )
> >  from sphinx.locale import _, __
> >  from sphinx.roles import XRefRole
> > -from sphinx.util import logging
> > +from sphinx.util import docfields, logging
> >  from sphinx.util.docutils import SphinxDirective
> >  from sphinx.util.nodes import make_id, make_refnode
> >
> > -from compat import (
> > -    CompatField,
> > -    CompatGroupedField,
> > -    CompatTypedField,
> > -    KeywordNode,
> > -    ParserFix,
> > -    Signature,
> > -    SpaceNode,
> > -)
> > -
> >
> >  if TYPE_CHECKING:
> >      from typing import (
> > @@ -157,7 +147,10 @@ def result_nodes(
> >          return results, []
> >
> >
> > -class QAPIDescription(ParserFix):
> > +Signature =3D str
> > +
> > +
> > +class QAPIDescription(ObjectDescription[Signature]):
> >      """
> >      Generic QAPI description.
> >
> > @@ -315,7 +308,7 @@ class QAPIObject(QAPIDescription):
> >
> >      doc_field_types =3D [
> >          # :feat name: descr
> > -        CompatGroupedField(
> > +        docfields.GroupedField(
> >              "feature",
> >              label=3D_("Features"),
> >              names=3D("feat",),
> > @@ -327,8 +320,8 @@ def get_signature_prefix(self) -> List[nodes.Node]:
> >          """Return a prefix to put before the object name in the signat=
ure."""
> >          assert self.objtype
> >          return [
> > -            KeywordNode("", self.objtype.title()),
> > -            SpaceNode(" "),
> > +            addnodes.desc_sig_keyword("", self.objtype.title()),
> > +            addnodes.desc_sig_space(" "),
> >          ]
> >
> >      def get_signature_suffix(self) -> List[nodes.Node]:
> > @@ -337,7 +330,7 @@ def get_signature_suffix(self) -> List[nodes.Node]:
> >
> >          if "since" in self.options:
> >              ret +=3D [
> > -                SpaceNode(" "),
> > +                addnodes.desc_sig_space(" "),
> >                  addnodes.desc_sig_element(
> >                      "", f"(Since: {self.options['since']})"
> >                  ),
> > @@ -376,7 +369,7 @@ def handle_signature(self, sig: str, signode: desc_=
signature) -> Signature:
> >
> >          return sig
> >
> > -    def _add_infopips(self, contentnode: addnodes.desc_content) -> Non=
e:
> > +    def _add_infopips(self, content_node: addnodes.desc_content) -> No=
ne:
> >          # Add various eye-catches and things that go below the signatu=
re
> >          # bar, but precede the user-defined content.
> >          infopips =3D nodes.container()
>
> Are this hunk and the next one necessary parts of the patch, or have
> they crept in?

Necessary. The newer Sphinx version changes these parameter names, so
type checking and linters begin to complain about us changing the
parameter name. This block is fairly straightforward, ...

>
> > @@ -420,7 +413,7 @@ def _add_pip(
> >              )
> >
> >          if infopips.children:
> > -            contentnode.insert(0, infopips)
> > +            content_node.insert(0, infopips)
> >
> >      def _validate_field(self, field: nodes.field) -> None:
> >          """Validate field lists in this QAPI Object Description."""
> > @@ -470,7 +463,11 @@ def _validate_field(self, field: nodes.field) -> N=
one:
> >              )
> >              logger.warning(msg, location=3Dfield)
> >
> > -    def transform_content(self, content_node: addnodes.desc_content) -=
> None:
> > +    def transform_content(
> > +        self,
> > +        # pylint: disable=3Darguments-renamed
> > +        content_node: addnodes.desc_content
> > +    ) -> None:
> >          # This hook runs after before_content and the nested parse, bu=
t
> >          # before the DocFieldTransformer is executed.
> >          super().transform_content(content_node)
>
> Likewise.

This block is less straightforward: the argument/parameter name here
was changed in the versions we still support, so either name I choose
for it causes errors on either the older or newer end of the tests.
Adopt the eventual name, and silence the error on the minreqs test.

>
> > @@ -485,7 +482,7 @@ def transform_content(self, content_node: addnodes.=
desc_content) -> None:
> >                      self._validate_field(field)
> >
> >
> > -class SpecialTypedField(CompatTypedField):
> > +class SpecialTypedField(docfields.TypedField):
> >      def make_field(self, *args: Any, **kwargs: Any) -> nodes.field:
> >          ret =3D super().make_field(*args, **kwargs)
> >
> > @@ -518,14 +515,14 @@ class QAPICommand(QAPIObject):
> >                  can_collapse=3DFalse,
> >              ),
> >              # :error: descr
> > -            CompatField(
> > +            docfields.Field(
> >                  "error",
> >                  label=3D_("Errors"),
> >                  names=3D("error", "errors"),
> >                  has_arg=3DFalse,
> >              ),
> >              # :return TypeName: descr
> > -            CompatGroupedField(
> > +            docfields.GroupedField(
> >                  "returnvalue",
> >                  label=3D_("Return"),
> >                  rolename=3D"type",
> > @@ -533,7 +530,7 @@ class QAPICommand(QAPIObject):
> >                  can_collapse=3DTrue,
> >              ),
> >              # :return-nodesc: TypeName
> > -            CompatField(
> > +            docfields.Field(
> >                  "returnvalue",
> >                  label=3D_("Return"),
> >                  names=3D("return-nodesc",),
> > @@ -551,7 +548,7 @@ class QAPIEnum(QAPIObject):
> >      doc_field_types.extend(
> >          [
> >              # :value name: descr
> > -            CompatGroupedField(
> > +            docfields.GroupedField(
> >                  "value",
> >                  label=3D_("Values"),
> >                  names=3D("value",),
> > @@ -568,7 +565,7 @@ class QAPIAlternate(QAPIObject):
> >      doc_field_types.extend(
> >          [
> >              # :alt type name: descr
> > -            CompatTypedField(
> > +            docfields.TypedField(
> >                  "alternative",
> >                  label=3D_("Alternatives"),
> >                  names=3D("alt",),
>


