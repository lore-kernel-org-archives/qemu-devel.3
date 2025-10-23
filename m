Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D7FCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBsiB-0007RX-IM; Thu, 23 Oct 2025 06:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBsiA-0007RP-8E
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBsi7-0007UD-QF
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761215900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/tbawGAjV1xhvwvsNEnJPY4JbmtFI/uvewp+ITQ8us=;
 b=bMnGe2RTl46sIlqz1zJdCdHQbyQL2Eip1ebf8xR3X5iEb6aZJcdXgX1ylB8vyMzepjydzP
 QtMXcBtzTj+xrE/cJvd1Z9ndYqGgZw/9DeuaL2nXiHwcMWXMgrlYJ4xrob0+GvtnLMOw3M
 SxhE86uqZLGLsCTUOkIzkssmVg7jrXk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-MbxCvu1LPDazKbFmKhrZAQ-1; Thu,
 23 Oct 2025 06:38:17 -0400
X-MC-Unique: MbxCvu1LPDazKbFmKhrZAQ-1
X-Mimecast-MFC-AGG-ID: MbxCvu1LPDazKbFmKhrZAQ_1761215896
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EAFD1800365; Thu, 23 Oct 2025 10:38:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99EAA30002D9; Thu, 23 Oct 2025 10:38:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1B0021E6A27; Thu, 23 Oct 2025 12:38:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 03/32] qapi: add 'insecure-types' option for -compat
 argument
In-Reply-To: <20250926140144.1998694-4-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 26 Sep 2025 15:01:14
 +0100")
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-4-berrange@redhat.com>
Date: Thu, 23 Oct 2025 12:38:12 +0200
Message-ID: <87ldl19a3v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> This introduces a new 'insecure-types' option for the 'compat'
> argument that accepts three values
>
>  * accept: Allow any usage
>  * reject: Reject with an error reported
>  * warn: Allow any usage, with a warning reported
>
> For historical compatibility it defaults to 'accept'.
>
> The 'reject' and 'warn' values will take effect for any type
> that has been explicitly marked insecure, or is lacking an
> explicit declaration of its security status.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Suggest to mention that the new option doesn't do anything, yet.

> ---
>  include/qapi/compat-policy.h |  5 +++++
>  qapi/compat.json             | 24 +++++++++++++++++++++++-
>  qapi/qapi-util.c             | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
> index ea65e10744..b2d0835c36 100644
> --- a/include/qapi/compat-policy.h
> +++ b/include/qapi/compat-policy.h
> @@ -24,6 +24,11 @@ bool compat_policy_input_ok(uint64_t features,
>                              const char *kind, const char *name,
>                              Error **errp);
>=20=20
> +bool compat_policy_check_security(CompatPolicy *policy,
> +                                  const char *typename,
> +                                  bool isSecure,

is_secure

> +                                  Error **errp);
> +
>  /*
>   * Create a QObject input visitor for @obj for use with QMP
>   *
> diff --git a/qapi/compat.json b/qapi/compat.json
> index 90b8d51cf2..dcef10a3a5 100644
> --- a/qapi/compat.json
> +++ b/qapi/compat.json
> @@ -37,6 +37,24 @@
>  { 'enum': 'CompatPolicyOutput',
>    'data': [ 'accept', 'hide' ] }
>=20=20
> +##
> +# @CompatPolicySecurity:
> +#
> +# Policy for handling any devices or backends which
> +# do not provide a security boundary to protect
> +# against untrusted environments

Please wrap like this:

   # Policy for handling any devices or backends which do not provide a
   # security boundary to protect against untrusted environments

> +#
> +# @accept: Allow any usage
> +#
> +# @reject: Reject with an error reported
> +#
> +# @warn: Allow any usage, with a warning reported
> +#
> +# Since: 10.2
> +##
> +{ 'enum': 'CompatPolicySecurity',
> +  'data': [ 'accept', 'reject', 'warn' ] }
> +
>  ##
>  # @CompatPolicy:
>  #
> @@ -62,10 +80,14 @@
>  # @unstable-output: how to handle unstable output (default 'accept')
>  #     (since 6.2)
>  #
> +# @insecure-types: how to handle types that are not declared
> +#     secure (default 'accept') (since 10.2)
> +#

Please wrap like this:

   # @insecure-types: how to handle types that are not declared secure
   #     (default 'accept') (since 10.2)

>  # Since: 6.0
>  ##
>  { 'struct': 'CompatPolicy',
>    'data': { '*deprecated-input': 'CompatPolicyInput',
>              '*deprecated-output': 'CompatPolicyOutput',
>              '*unstable-input': 'CompatPolicyInput',
> -            '*unstable-output': 'CompatPolicyOutput' } }
> +            '*unstable-output': 'CompatPolicyOutput',
> +            '*insecure-types': 'CompatPolicySecurity' } }
> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> index 3d849fe034..ef982d903e 100644
> --- a/qapi/qapi-util.c
> +++ b/qapi/qapi-util.c
> @@ -14,6 +14,7 @@
>  #include "qapi/compat-policy.h"
>  #include "qapi/error.h"
>  #include "qemu/ctype.h"
> +#include "qemu/error-report.h"
>  #include "qapi/qmp/qerror.h"
>=20=20
>  CompatPolicy compat_policy;
> @@ -58,6 +59,35 @@ bool compat_policy_input_ok(uint64_t features,
>      return true;
>  }
>=20=20
> +bool compat_policy_check_security(CompatPolicy *policy,
> +                                  const char *typename,
> +                                  bool isSecure,
> +                                  Error **errp)
> +{
> +    if (isSecure) {
> +        return true;
> +    }
> +
> +    switch (policy->insecure_types) {
> +    case COMPAT_POLICY_SECURITY_ACCEPT:
> +        return true;
> +
> +    case COMPAT_POLICY_SECURITY_REJECT:
> +        error_setg(errp, "Type '%s' does not provide a security boundary=
 "
> +                   "to protect against untrusted workloads", typename);
> +        return false;
> +
> +    case COMPAT_POLICY_SECURITY_WARN:
> +        warn_report("Type '%s' does not provide a security boundary "
> +                    "to protect against untrusted workloads", typename);
> +        return true;

The error messages are hard to judge until we see uses.  I figure what
"untrusted workloads" actually means depends on the type.  For a device,
it's probably an untrusted guest.  For a block backend, it could be an
untrusted image.

> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +
>  const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
>  {
>      assert(val >=3D 0 && val < lookup->size);


