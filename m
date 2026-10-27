Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA507606A327
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iqr4/h4j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLdl2-0004Sc-C2; Tue, 27 Oct 2026 05:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLdl0-0004Oc-In
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 05:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLdku-0001ro-TM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 05:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793094368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mztNzPIwHM8MQ9g92CdzrwCca/RYLMj81HkeAxUn2OY=;
 b=iqr4/h4ju5CUZdZX5sr4HSK4qcKF9/+AfJR7iIWbx8BQiC6fU9KfDv1JkKzZGD8UA4CHPF
 W2fW2/e9ith92bjhkYcKVRlZEYU0T4a1n79magzfMD0/B2dKt0aPGfQ/oBL3EKOFnoGc9m
 uBIicE8xvwaZSV2G22x/MnuQsgIUy+A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-O7RVcK0WPfiT1V6RMuaRiQ-1; Tue,
 27 Oct 2026 05:46:04 -0400
X-MC-Unique: O7RVcK0WPfiT1V6RMuaRiQ-1
X-Mimecast-MFC-AGG-ID: O7RVcK0WPfiT1V6RMuaRiQ_1793094363
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87EDC1955DCE; Tue, 27 Oct 2026 09:46:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 027EC1800643; Tue, 27 Oct 2026 09:46:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9DE2421E6A04; Tue, 27 Oct 2026 10:46:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PULL 02/14] qapi: add 'insecure-types' option for -compat
 argument
In-Reply-To: <20260917160525.1275388-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 17 Sep 2026 17:05:13
 +0100")
References: <20260917160525.1275388-1-berrange@redhat.com>
 <20260917160525.1275388-3-berrange@redhat.com>
Date: Tue, 27 Oct 2026 10:46:00 +0100
Message-ID: <877bj3a33b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This has long been merged.  I couldn't review it at the time, and
merging it without my review was clearly appropriate.

I have questions / doubts about the external interface I'd like to
discuss now.

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
> This new command line option is currently a no-op, but will
> become functional as following patches enable the checks.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qapi/compat-policy.h |  5 +++++
>  qapi/compat.json             | 23 ++++++++++++++++++++++-
>  qapi/qapi-util.c             | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
> index ea65e10744a..f5af2090692 100644
> --- a/include/qapi/compat-policy.h
> +++ b/include/qapi/compat-policy.h
> @@ -24,6 +24,11 @@ bool compat_policy_input_ok(uint64_t features,
>                              const char *kind, const char *name,
>                              Error **errp);
>=20=20
> +bool compat_policy_check_security(const CompatPolicy *policy,
> +                                  const char *typename,
> +                                  bool is_secure,
> +                                  Error **errp);
> +
>  /*
>   * Create a QObject input visitor for @obj for use with QMP
>   *
> diff --git a/qapi/compat.json b/qapi/compat.json
> index 90b8d51cf27..b54f8eb3713 100644
> --- a/qapi/compat.json
> +++ b/qapi/compat.json
> @@ -37,6 +37,23 @@
>  { 'enum': 'CompatPolicyOutput',
>    'data': [ 'accept', 'hide' ] }
>=20=20
> +##
> +# @CompatPolicySecurity:
> +#
> +# Policy for handling any devices or backends which do not provide a
> +# security boundary to protect against untrusted environments
> +#
> +# @accept: Allow any usage
> +#
> +# @reject: Reject with an error reported
> +#
> +# @warn: Allow any usage, with a warning reported
> +#
> +# Since: 11.2
> +##
> +{ 'enum': 'CompatPolicySecurity',
> +  'data': [ 'accept', 'reject', 'warn' ] }
> +
>  ##
>  # @CompatPolicy:
>  #
> @@ -62,10 +79,14 @@
   # Policy for handling deprecated management interfaces.
   #
   # This is intended for testing users of the management interfaces.
   #
   # Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
   # with feature 'deprecated' or 'unstable'.  We may want to extend it
   # to cover semantic aspects and CLI.
   #
   # Limitation: deprecated-output policy @hide is not implemented for
   # enumeration values.  They behave the same as with policy @accept.
   #
   # @deprecated-input: how to handle deprecated input (default 'accept')
   #
   # @deprecated-output: how to handle deprecated output (default
   #     'accept')
   #
   # @unstable-input: how to handle unstable input (default 'accept')
   #     (since 6.2)
   #
>  # @unstable-output: how to handle unstable output (default 'accept')
>  #     (since 6.2)
>  #
> +# @insecure-types: how to handle types that are not declared secure
> +#     (default 'accept') (since 11.2)

Minor issue: "types" is ambiguous without context.  We call lots of
things "types" in our external interfaces.  It's actually QOM types
here.  Let's say so.  I can take care of it.

Similar confusion exists elsewhere[*], but let's not digress.

> +#
>  # Since: 6.0
>  ##
>  { 'struct': 'CompatPolicy',
>    'data': { '*deprecated-input': 'CompatPolicyInput',
>              '*deprecated-output': 'CompatPolicyOutput',
>              '*unstable-input': 'CompatPolicyInput',
> -            '*unstable-output': 'CompatPolicyOutput' } }
> +            '*unstable-output': 'CompatPolicyOutput',
> +            '*insecure-types': 'CompatPolicySecurity' } }

The existing members are all named "wide", and the documentation narrows
them.  For instance, the name @deprecated-input could cover *any* input,
but its documentation narrows it to "only syntactic aspects of QMP".  I
did it this way to let us extend coverage without having to change the
external interface.

New member @insecure-types is named "narrow".  Why different?  Why not
@insecure-input?

The existing @FOO-input support CompatPolicyInput: "accept", "reject",
"crash".  New insecure-types supports CompatPolicySecurity: "accept",
"reject", "warn".  Why different?

My rationale for "crash" is in commit dbb675c19aa (qapi: New -compat
deprecated-input=3Dcrash):

    Bugs in integration tests may mask the error from policy "reject".
    Provide a larger hammer: crash outright.  Masking that seems unlikely.

If "crash" can be useful for testing a management application's non-use
of deprecated and unstable interfaces, surely it's just as useful for
insecure ones.

Likewise, "warn".  I didn't provide "warn" at the time, because QMP
lacks support for warnings.  Do management applications find warnings on
stderr in response to QMP commands useful?

-util.c b/qapi/qapi-util.c
> index 3d849fe0347..38b1cec7a41 100644
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
> +bool compat_policy_check_security(const CompatPolicy *policy,
> +                                  const char *typename,
> +                                  bool is_secure,
> +                                  Error **errp)

More minor issues.

The policy functions are named compat_policy_FOO_ok().  Why different?

Their arguments are "relevant facts" (@features), @policy, "stuff for
error message" (@error_class, @kind, @name), @errp.  This one has the
same things in different order.  Why?

> +{
> +    if (is_secure) {
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
> +                   "to protect against untrusted data or actions", typen=
ame);
> +        return false;
> +
> +    case COMPAT_POLICY_SECURITY_WARN:
> +        warn_report("Type '%s' does not provide a security boundary "
> +                    "to protect against untrusted data or actions", type=
name);
> +        return true;
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


[*] So I digress in a footnote.  Sue me ;)

While examining the QAPI schema, I found near object-add:

    ##
    # @qom-list-properties:
    #     List properties associated with a QOM object.
    #
    # @typename: the type name of an object
    [...]
    ##
    # @object-add:
    #     Create a QOM object.
    #
    # Errors:
    #     - If @qom-type is not a valid class name
    [...]
    ##
    # @ObjectOptions:
    #     Describes the options of a user creatable QOM object.
    #
    # @qom-type: the class name for the object to be created

We use "QOM type" and "QOM class".  This is pretty bad; we should pick
one and stick with it.

And near device_add:

    ##
    # @device-list-properties:
    #     List properties associated with a device.
    #
    # @typename: the type name of a device
    [...]
    ##
    # @device_add:
    #     Add a device.
    #
    # @driver: the name of the new device's driver

We use "driver" and "device type".  Similarly bad.

Not today.


