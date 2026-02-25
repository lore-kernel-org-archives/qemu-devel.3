Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7032F55435
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv8hi-0001ph-3i; Wed, 25 Feb 2026 01:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vv8hf-0001pK-FB
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:48:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vv8hd-00079j-Ui
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772002137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NadLZSCU7fi99PJ9ZN55WzcfAcI+r8zDiMPB8hdIOJM=;
 b=RIi3nSSf2bgHazeURfyutg4IIM56haP+z852m1tAdbL/5SZUzi9STdghxd4BcE8YPWefdK
 zo4uhUbjYQ9uxOLziJwltaqWgU9VuCYAkznSteNFpHREfxjosYxOi5pcxRfoEQgwD2l2kr
 3UFIh6/IKvo1kX07SPtumTaIGfNR7yk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-LTzPNs4NOy-QvL684Cam_A-1; Wed,
 25 Feb 2026 01:48:53 -0500
X-MC-Unique: LTzPNs4NOy-QvL684Cam_A-1
X-Mimecast-MFC-AGG-ID: LTzPNs4NOy-QvL684Cam_A_1772002132
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 149101800349; Wed, 25 Feb 2026 06:48:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 883501800668; Wed, 25 Feb 2026 06:48:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0603F21E692D; Wed, 25 Feb 2026 07:48:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 09/16] scripts/qapi: add QAPISchemaIfCond.rsgen()
In-Reply-To: <20260108131043.490084-10-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 8 Jan 2026 14:10:36 +0100")
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-10-pbonzini@redhat.com>
Date: Wed, 25 Feb 2026 07:48:48 +0100
Message-ID: <87pl5txqr3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Generate Rust #[cfg(...)] guards from QAPI 'if' conditions; it
> turns out that they are very similar, with both of them using
> not/any/all, so just walk the tree.
>
> The next commit will put it to use.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20210907121943.3498701-15-marcandre.lurea=
u@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/qapi/common.py | 19 +++++++++++++++++++
>  scripts/qapi/schema.py |  4 ++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index d7c8aa3365c..14d5dd259c4 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -199,6 +199,25 @@ def guardend(name: str) -> str:
>                   name=3Dc_fname(name).upper())
>=20=20
>=20=20
> +def rsgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
> +
> +    def cfg(ifcond: Union[str, Dict[str, Any]]) -> str:
> +        if isinstance(ifcond, str):
> +            return ifcond
> +        assert isinstance(ifcond, dict) and len(ifcond) =3D=3D 1
> +        if 'not' in ifcond:
> +            oper =3D 'not'
> +            arg =3D cfg(ifcond['not'])
> +        else:
> +            oper, operands =3D next(iter(ifcond.items()))
> +            arg =3D ', '.join([cfg(c) for c in operands])
> +        return f'{oper}({arg})'
> +
> +    if not ifcond:
> +        return ''
> +    return '#[cfg(%s)]' % cfg(ifcond)
> +
> +

Why not reuse the existing tree walker?  See appended diff.

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


diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d7c8aa3365..d8accae835 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -201,7 +201,8 @@ def guardend(name: str) -> str:
=20
 def gen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]],
                cond_fmt: str, not_fmt: str,
-               all_operator: str, any_operator: str) -> str:
+               all_fmt: str, all_sep: str,
+               any_fmt: str, any_sep: str) -> str:
=20
     def do_gen(ifcond: Union[str, Dict[str, Any]],
                need_parens: bool) -> str:
@@ -211,15 +212,15 @@ def do_gen(ifcond: Union[str, Dict[str, Any]],
         if 'not' in ifcond:
             return not_fmt % do_gen(ifcond['not'], True)
         if 'all' in ifcond:
-            gen =3D gen_infix(all_operator, ifcond['all'])
+            gen =3D gen_infix(all_fmt, all_sep, ifcond['all'])
         else:
-            gen =3D gen_infix(any_operator, ifcond['any'])
+            gen =3D gen_infix(any_fmt, any_sep, ifcond['any'])
         if need_parens:
             gen =3D '(' + gen + ')'
         return gen
=20
-    def gen_infix(operator: str, operands: Sequence[Any]) -> str:
-        return operator.join([do_gen(o, True) for o in operands])
+    def gen_infix(fmt: str, sep: str, operands: Sequence[Any]) -> str:
+        return fmt % sep.join([do_gen(o, True) for o in operands])
=20
     if not ifcond:
         return ''
@@ -227,12 +228,18 @@ def gen_infix(operator: str, operands: Sequence[Any])=
 -> str:
=20
=20
 def cgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
-    return gen_ifcond(ifcond, 'defined(%s)', '!%s', ' && ', ' || ')
+    return gen_ifcond(ifcond, 'defined(%s)', '!%s',
+                      '%s', ' && ', '%s', ' || ')
+
+
+def rsgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
+    return '#[cfg(%s)]' % gen_ifcond(ifcond, '%s', 'not(%s)',
+                                     'all(%s)', ', ', 'any(%s)', ', ')
=20
=20
 def docgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
     # TODO Doc generated for conditions needs polish
-    return gen_ifcond(ifcond, '%s', 'not %s', ' and ', ' or ')
+    return gen_ifcond(ifcond, '%s', 'not %s', '%s', ' and ', '%s', ' or ')
=20
=20
 def gen_if(cond: str) -> str:


