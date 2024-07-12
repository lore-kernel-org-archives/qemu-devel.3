Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A93C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 07:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSB7A-0006cq-Ln; Fri, 12 Jul 2024 03:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sSB79-0006WM-8u
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 03:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sSB76-0003in-Jz
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 03:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720770882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8uD1IUUrBzTJ61qf8ksdspani95oBHfaReaPNAn0BQ=;
 b=OS7G/xPIUOVWIuROfoJGCrAo7pndq6RvcDrAxt9jd3KnOKYR4pLcYVXgolCZr8O7iM8iHW
 /qqgiVwHaf+vaFNn2D6vghTZkhbq63LufSa/3c3kIrGJS4e2cOPHOwi0gdIfwfRWD7+5wp
 GteI62N40ptXbvWkzU/MuNoXjLstSqs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-vcnY5SmTPg2bovpdUOzG8A-1; Fri,
 12 Jul 2024 03:54:40 -0400
X-MC-Unique: vcnY5SmTPg2bovpdUOzG8A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FA9D1935DE5; Fri, 12 Jul 2024 07:54:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49D9A3000186; Fri, 12 Jul 2024 07:54:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5EB8921E5E6D; Fri, 12 Jul 2024 09:54:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH 03/14] qapi: cope with special feature names containing
 a '-'
In-Reply-To: <20240604153242.251334-4-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 4 Jun 2024 16:32:31
 +0100")
References: <20240604153242.251334-1-berrange@redhat.com>
 <20240604153242.251334-4-berrange@redhat.com>
Date: Fri, 12 Jul 2024 09:54:36 +0200
Message-ID: <87v81bujsz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

> When we shortly allow custom special feature names to be defined, it
> will be valid to include a '-', which must be translated to a '_'
> when generating code.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/qapi/gen.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index 9c590a1c2e..650efc59ed 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -41,7 +41,7 @@
>=20=20
>=20=20
>  def gen_special_features(features: Sequence[QAPISchemaFeature]) -> str:
> -    special_features =3D [f"1u << QAPI_FEATURE_{feat.name.upper()}"
> +    special_features =3D [f"1u << QAPI_FEATURE_{feat.name.upper().replac=
e('-','_')}"
>                          for feat in features if feat.is_special()]
>      return ' | '.join(special_features) or '0'

I'd prefer something like

    f"1 << {c_enum_const('QAPI_FEATURE', feat.name)}"


