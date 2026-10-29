Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9FE606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YCHHBtQo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJQc-0001KY-1w; Thu, 29 Oct 2026 02:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMJQY-0001Jb-P9
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 02:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMJQW-0003Gw-8G
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 02:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793254550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlkIwo++liCwzU0DCO3CxRST0xtbKPxOb+jZhbSy7qc=;
 b=YCHHBtQoCG/i3msAbNIbdR35niurBTOFPj+I6fwoGlOdbNOfm5gDju1wGB2JT7J3RG2upJ
 O/YCqbZc/6Z3dY6oYzUoFnBWemsIHJb8Vj1fAC4tGLJa06S16HOkNhH1OFrjO3fT+ImGOu
 DMNDKRcbkuR6NdJ/9Lyjq793SRPyo3A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-Veaq5YwMM0-soD1b5NqXiA-1; Thu,
 29 Oct 2026 02:15:42 -0400
X-MC-Unique: Veaq5YwMM0-soD1b5NqXiA-1
X-Mimecast-MFC-AGG-ID: Veaq5YwMM0-soD1b5NqXiA_1793254541
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 943DB1955F14
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:15:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5210C30000E7
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:15:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB6A121E6A04; Thu, 29 Oct 2026 07:15:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 4/8] qapi: drop CompatPolicySecurity and use
 CompatPolicyInput
In-Reply-To: <20261028133603.1893289-5-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 28 Oct 2026 13:35:59
 +0000")
References: <20261028133603.1893289-1-berrange@redhat.com>
 <20261028133603.1893289-5-berrange@redhat.com>
Date: Thu, 29 Oct 2026 07:15:38 +0100
Message-ID: <875wylghh1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> With CompatPolicyInput gaining a "warn" option, the CompatPolicySecurity
> type is redundant.
>
> Note the error message for insecure-input changes from
>
>    Type 'rtl8139' does not provide a security boundary
>    to protect against untrusted data or actions
>
> To
>
>    Insecure QOM type rtl8139 disabled by policy

This loses a bit of information.  Do we care?  I show a way to retain it
below.

>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qapi/compat.json | 18 +-----------------
>  qapi/qapi-util.c | 21 ++++-----------------
>  2 files changed, 5 insertions(+), 34 deletions(-)
>
> diff --git a/qapi/compat.json b/qapi/compat.json
> index f28c24149c8..7790a7896a8 100644
> --- a/qapi/compat.json
> +++ b/qapi/compat.json
> @@ -37,22 +37,6 @@
>  { 'enum': 'CompatPolicyOutput',
>    'data': [ 'accept', 'hide' ] }
>=20=20
> -##
> -# @CompatPolicySecurity:
> -#     Policy for handling any devices or backends which do not provide
> -#     a security boundary to protect against untrusted environments
> -#
> -# @accept: Allow any usage
> -#
> -# @reject: Reject with an error reported
> -#
> -# @warn: Allow any usage, with a warning reported
> -#
> -# Since: 11.2
> -##
> -{ 'enum': 'CompatPolicySecurity',
> -  'data': [ 'accept', 'reject', 'warn' ] }
> -
>  ##
>  # @CompatPolicy:
>  #     Policy for handling deprecated management interfaces.
> @@ -87,4 +71,4 @@
>              '*deprecated-output': 'CompatPolicyOutput',
>              '*unstable-input': 'CompatPolicyInput',
>              '*unstable-output': 'CompatPolicyOutput',
> -            '*insecure-input': 'CompatPolicySecurity' } }
> +            '*insecure-input': 'CompatPolicyInput' } }

This adds policy value "crash", doesn't it?  The commit message should
mention it.

> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> index e6f3006b16c..36926b5003d 100644
> --- a/qapi/qapi-util.c
> +++ b/qapi/qapi-util.c
> @@ -72,23 +72,10 @@ bool compat_policy_check_security(const CompatPolicy =
*policy,
>          return true;
>      }
>=20=20
> -    switch (policy->insecure_input) {
> -    case COMPAT_POLICY_SECURITY_ACCEPT:
> -        return true;
> -
> -    case COMPAT_POLICY_SECURITY_REJECT:
> -        error_setg(errp, "Type '%s' does not provide a security boundary=
 "
> -                   "to protect against untrusted data or actions", typen=
ame);
> -        return false;
> -
> -    case COMPAT_POLICY_SECURITY_WARN:
> -        warn_report("Type '%s' does not provide a security boundary "
> -                    "to protect against untrusted data or actions", type=
name);
> -        return true;
> -
> -    default:
> -        g_assert_not_reached();
> -    }
> +    return compat_policy_input_ok1(policy->insecure_input,
> +                                   "Insecure",
> +                                   ERROR_CLASS_GENERIC_ERROR,
> +                                   "QOM type", typename, errp);
>  }

... then try something like this:

       if (!compat_policy_input_ok1(...) {
           error_append_hint(errp, ...);
       }

Don't forget ERRP_GUARD() then, error_append_hint() needs it.


