Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B433C79FBD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Olw-0003lp-5T; Wed, 09 Sep 2026 16:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Olq-0003kv-4B
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Oln-0006pc-5p
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQiUtO9FFdYDsrkplKMoHJRbeQVndfO8CWyHufMZeqE=;
 b=emG34YAYq3e/9NG29Am+mDvpvfnMArEWr69nPWPsfw376pc3HlIDp1LaVvrov1u7Pr5A73
 6+yvYOi8gR0qkgtawCudRL8Iz3UFxLuX9weA6uCEBK5f4vVhQwROC0hlJGjz4xP6dvJhFt
 ue0l1SdREWEf1VdLNyUvFuXjnRQxRo8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-WjKXqsVzNtizExFLSJhbFw-1; Wed,
 09 Sep 2026 16:19:43 -0400
X-MC-Unique: WjKXqsVzNtizExFLSJhbFw-1
X-Mimecast-MFC-AGG-ID: WjKXqsVzNtizExFLSJhbFw_1788985182
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31B101800BE0; Wed,  9 Sep 2026 20:19:42 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE553195608E; Wed,  9 Sep 2026 20:19:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 02/14] qapi: add 'insecure-types' option for -compat
 argument
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260909175656.1572689-3-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-3-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517053.2613908.15158811228016231318.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4526;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3TEXyOipDzsehNN2kFDYpzI01GGuYkwHowM46JllIqY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9V+V8O4FNqjA9Vve8HiXaFFCJ1WWPVi7zwH
 p2YjIDp5o6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VQAKCRDa6OEJdZac
 5ZPoEACpAnQ/No9ZV3IEoTQl54voDuHT7z6JYlNSks/dCM30XNfhyRopRvdd+OlCPA8ZMN/HbJJ
 1TjYq0InFxvnMeiWaFDQlTqWpYOTdkcOcp8sQhkqrJIM+9n8JpHEypx9lFocBaA2Y9WGJG/q7ES
 EC8g0Su6tOTbwBdXAJLY/KpMoVNGVXwgSrq3XVQLtVyyoGzp+f/14VY+YaPADrtu8cAkvNLxbZw
 hyIrew+3T95IK38HOrfOylts60IMp3Prmh5c1hKOlF1qlsv268ySMW+r70CtxRT8ZYm3Nhrl0pf
 b4FTD4JpnGKsLF/DjM/KF/K0aqcpExF2NBboc+DgbuXKOG/XjEfxliNlgtAmJiwN++lc8THufb4
 U1oJndZponHqK+3EHkllMgBGaVQ86YF0qHW/fhaoJrGgQdHfSjFiP3DlAKwP/NnOrx2qMUeSHWb
 uXlYv3AyojCfWbvkyFRjjh8IZkxt7qDTI/f56oPUujccrQ9PqEUpHCWMAC9BdhK2Yjxw9UXE4Ck
 /WN8DzUImksksREzha538wQzufFxHm5/FA19O+lncdGpon3gp5B8kObYtqCEJEn9DaH4m9nSCik
 OEKOYsl95hqlrgeenWoBgpt8UkIyupwMHtSTHt20Osnon8GhB055MYoMFcmYxTs2lXG3ZFAOK4I
 ojVbijGf290eqyQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20260909175656.1572689-3-berrange@redhat.com>
>
> diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
> index ea65e10744ab..f5af20906923 100644
> --- a/include/qapi/compat-policy.h
> +++ b/include/qapi/compat-policy.h
> @@ -24,6 +24,11 @@ bool compat_policy_input_ok(uint64_t features,
>                              const char *kind, const char *name,
>                              Error **errp);
>  
> +bool compat_policy_check_security(const CompatPolicy *policy,
> +                                  const char *typename,
> +                                  bool is_secure,
> +                                  Error **errp);
> +
>  /*
>   * Create a QObject input visitor for @obj for use with QMP
>   *
> diff --git a/qapi/compat.json b/qapi/compat.json
> index 90b8d51cf27e..d57f25e112f8 100644
> --- a/qapi/compat.json
> +++ b/qapi/compat.json
> @@ -37,6 +37,23 @@
>  { 'enum': 'CompatPolicyOutput',
>    'data': [ 'accept', 'hide' ] }
>  
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
> +# Since: 10.2

Since: 11.2

> +##
> +{ 'enum': 'CompatPolicySecurity',
> +  'data': [ 'accept', 'reject', 'warn' ] }
> +
>  ##
>  # @CompatPolicy:
>  #
> @@ -62,10 +79,14 @@
>  # @unstable-output: how to handle unstable output (default 'accept')
>  #     (since 6.2)
>  #
> +# @insecure-types: how to handle types that are not declared secure
> +#     (default 'accept') (since 10.2)

(since 11.2)

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
> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> index 3d849fe0347f..38b1cec7a415 100644
> --- a/qapi/qapi-util.c
> +++ b/qapi/qapi-util.c
> @@ -14,6 +14,7 @@
>  #include "qapi/compat-policy.h"
>  #include "qapi/error.h"
>  #include "qemu/ctype.h"
> +#include "qemu/error-report.h"
>  #include "qapi/qmp/qerror.h"
>  
>  CompatPolicy compat_policy;
> @@ -58,6 +59,35 @@ bool compat_policy_input_ok(uint64_t features,
>      return true;
>  }
>  
> +bool compat_policy_check_security(const CompatPolicy *policy,
> +                                  const char *typename,
> +                                  bool is_secure,
> +                                  Error **errp)
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
> +        error_setg(errp, "Type '%s' does not provide a security boundary "
> +                   "to protect against untrusted data or actions", typename);
> +        return false;
> +
> +    case COMPAT_POLICY_SECURITY_WARN:
> +        warn_report("Type '%s' does not provide a security boundary "
> +                    "to protect against untrusted data or actions", typename);
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
>      assert(val >= 0 && val < lookup->size);

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


