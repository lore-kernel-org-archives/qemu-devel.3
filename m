Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE55C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBJx-0007ji-Jz; Fri, 12 Jul 2024 04:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sSBJo-0007dX-7U
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:07:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sSBJj-0008GI-HK
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720771662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2Ea2/A9VWMACddcFx3S0ZRQ1GD5aBkN8u7dZqTUVW8=;
 b=Xv1S2YLXrudq4OFrPCMpW+g0qOdFjxTfpJ1+eFLUfPHSpk1xLfdTPv2amvj4OI3AWY6si8
 +vAYKwxBXU1jNcapYG0NvSnk1c2zmhBeXK+JNXQNQuVs1PttPS0q6p5JAYTA0e77Kx3Yw4
 5kR/bJ/v6fNTRzxa3V7/6SXXiQQjkIo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-kSQc62e_NASUYYQgDpPu3Q-1; Fri,
 12 Jul 2024 04:07:38 -0400
X-MC-Unique: kSQc62e_NASUYYQgDpPu3Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F34F61956088; Fri, 12 Jul 2024 08:07:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D56B1955E70; Fri, 12 Jul 2024 08:07:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8462B21E668F; Fri, 12 Jul 2024 10:07:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH 04/14] qapi: add a 'command-features' pragma
In-Reply-To: <20240604153242.251334-5-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 4 Jun 2024 16:32:32
 +0100")
References: <20240604153242.251334-1-berrange@redhat.com>
 <20240604153242.251334-5-berrange@redhat.com>
Date: Fri, 12 Jul 2024 10:07:34 +0200
Message-ID: <87r0bzuj7d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The 'command-features' pragma allows for defining additional
> special features that are unique to a particular QAPI schema
> instance and its implementation.

So far, we have special features (predefined, known to the generator and
treated specially), and normal features (user-defined, not known to the
generator).  You create a new kind in between: user-defined, not known
to the generator, yet treated specially (I guess?).  Hmm.

Could you at least hint at indented use here?  What special treatment do
you have in mind?

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/qapi/parser.py | 2 ++
>  scripts/qapi/source.py | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 7b13a583ac..36a9046243 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -243,6 +243,8 @@ def check_list_str(name: str, value: object) -> List[=
str]:
>              pragma.documentation_exceptions =3D check_list_str(name, val=
ue)
>          elif name =3D=3D 'member-name-exceptions':
>              pragma.member_name_exceptions =3D check_list_str(name, value)
> +        elif name =3D=3D 'command-features':
> +            pragma.command_features =3D check_list_str(name, value)
>          else:
>              raise QAPISemError(info, "unknown pragma '%s'" % name)
>=20=20
> diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
> index 7b379fdc92..07c2958ac4 100644
> --- a/scripts/qapi/source.py
> +++ b/scripts/qapi/source.py
> @@ -28,6 +28,8 @@ def __init__(self) -> None:
>          self.documentation_exceptions: List[str] =3D []
>          # Types whose member names may violate case conventions
>          self.member_name_exceptions: List[str] =3D []
> +        # Arbitrary extra features recorded against commands
> +        self.command_features: List[str] =3D []
>=20=20
>=20=20
>  class QAPISourceInfo:


