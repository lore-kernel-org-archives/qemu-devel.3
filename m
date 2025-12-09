Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D01D3B98A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 18:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT2gu-0000OO-9r; Tue, 09 Dec 2025 13:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vT2go-0000N6-AF
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 13:43:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vT2gm-0008W7-L6
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 13:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765305836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=exzAWHPQSqZT2+l+5h4Cv986A3Dg+mAFN3J91q7qk3E=;
 b=Db7DklL9RG0OVWvqn46Rgiq4lgrVziaGaeN/vioWwLl0GJZXO7wmS7LNS6+jC30Xjtsbi2
 0kLufkQwlbsSJnuW5SaICTQE4rsykl9jOMhvL4+9nG/QbKuj5BICDa/uOXYqI3NRh8Y5we
 aPwCC1bLC83xujbrf8+iAytoXgEeql4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-PgvL1AbhMq6pam3BMs5Avg-1; Tue,
 09 Dec 2025 13:43:52 -0500
X-MC-Unique: PgvL1AbhMq6pam3BMs5Avg-1
X-Mimecast-MFC-AGG-ID: PgvL1AbhMq6pam3BMs5Avg_1765305832
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED97D19560AD; Tue,  9 Dec 2025 18:43:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 629AC180045B; Tue,  9 Dec 2025 18:43:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6410021E6A27; Tue, 09 Dec 2025 19:43:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 13/19] scripts/qapi: add QAPISchemaIfCond.rsgen()
In-Reply-To: <20251010151006.791038-14-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 10 Oct 2025 17:09:58 +0200")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-14-pbonzini@redhat.com>
Date: Tue, 09 Dec 2025 19:43:48 +0100
Message-ID: <87ms3rbimz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Generate Rust #[cfg(...)] guards from QAPI 'if' conditions.

Please mention that this isn't used, yet.  I commonly write something
like "The next commit will put it to use."

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20210907121943.3498701-15-marcandre.lurea=
u@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/qapi/common.py | 16 ++++++++++++++++
>  scripts/qapi/schema.py |  4 ++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index d7c8aa3365c..f16b9568bb9 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -199,6 +199,22 @@ def guardend(name: str) -> str:
>                   name=3Dc_fname(name).upper())
>=20=20
>=20=20
> +def rsgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:

This is the Rust-generating cousin of cgen_ifcond().

The argument is None or a tree.  The tree's leaves are str, and its
inner nodes look like

    {'all': [sub-tree, ...]}
    {'any': [sub-tree, ...]}
    {'not': sub-tree}

mypy doesn't do recursive types, so we approximate the tree as
Union[str, Dict[str, Any]].

> +
> +    def cfg(ifcond: Union[str, Dict[str, Any]]) -> str:

The argument's type is wrong.  It should be

    Union[str, List[Dict[str, Any]], Dict[str, Any]]

We'll see below why mypy doesn't complain, and where the List[...]
comes from.

The name @ifcond is misleading.  This isn't an if condition, it's the
union of if condition and list of if conditions.

I needed John Snow's help to figure this out.  Thanks, John!

Case 1: the code for str, i.e. a tree leaf:

> +        if isinstance(ifcond, str):
> +            return ifcond

Case 2: the code for List[Dict[str, Any]]:

> +        if isinstance(ifcond, list):
> +            return ', '.join([cfg(c) for c in ifcond])

Case 3: the code for Dict[str, Any]:

gen_ifcond() below has

           assert isinstance(ifcond, dict) and len(ifcond) =3D=3D 1

right here to make this crystal clear.

> +        oper, operands =3D next(iter(ifcond.items()))

Recall @ifcond is either

    {'all': [sub-tree, ...]}
    {'any': [sub-tree, ...]}
    {'not': sub-tree}

The next(...) wizardry returns the first element of the @ifcond
dictionary.  Actually *the* element, since @ifcond has just one.

Thus:

    @oper is 'all', 'any', or 'not'

    @operands is a sub-tree when @oper is 'not', else a [sub-tree, ...],
    i.e. Dict[str, Any] or List[Dict[str, Any]]

> +        operands =3D cfg(operands)

We pass @operands to cfg().  That's where the List[...] comes from.

> +        return f'{oper}({operands})'
> +
> +    if not ifcond:
> +        return ''
> +    return '#[cfg(%s)]' % cfg(ifcond)

So, cfg(ifcond) returns the argument to interpolate into '#[cfg(%s)]'.

When @ifcond is str, it's @ifcond itself.  This is case 1.

When @ifcond is {'not': COND}, it's 'not(CC)', where CC is cfg(COND).
This is case 3 and case 2 with a non-list argument.

When @ifcond is {'all': [COND, ...]}, it's 'all(CC, ...)', where the CC
are cfg(COND).  This is case 3 and case 2 with a list argument.

Likewise for {'any': [COND, ...]}.

Okay apart from the incorrect type hint and the misleading name.

Less clever code would've saved me quite some review time.

But why doesn't mypy scream?  Consider again

           oper, operands =3D next(iter(ifcond.items()))

@ifcond's static type is Dict[str, Any].  Therefore @oper's static type
is str, and @operands is Any.  Any suppresses type checking!  The call
cfg(operands) is therefore *not* checked, and we get away with passing a
list to cfg() even though its type hint doesn't allow it.

> +
> +
>  def gen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]],
>                 cond_fmt: str, not_fmt: str,
>                 all_operator: str, any_operator: str) -> str:
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 8d88b40de2e..848a7401251 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -37,6 +37,7 @@
>      docgen_ifcond,
>      gen_endif,
>      gen_if,
> +    rsgen_ifcond,
>  )
>  from .error import QAPIError, QAPISemError, QAPISourceError
>  from .expr import check_exprs
> @@ -63,6 +64,9 @@ def gen_endif(self) -> str:
>      def docgen(self) -> str:
>          return docgen_ifcond(self.ifcond)
>=20=20
> +    def rsgen(self) -> str:
> +        return rsgen_ifcond(self.ifcond)
> +
>      def is_present(self) -> bool:
>          return bool(self.ifcond)


