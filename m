Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8EEC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 11:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJsYD-000105-3r; Tue, 27 May 2025 07:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJsXv-0000y7-Dj
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJsXk-0001Tu-Nj
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748345545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQiCNQFJOinvn66rLR/m9nW9VwVq2V6O256INkb9Fio=;
 b=MrGDa9+nCrVcBD22MoOBi3NFCl4CroCxz7GA77UMjsKjoXS6NyZbVKx6CrVE4obKmqnR73
 WzY1Z7oBWFbw/I5c9DPcblxQ9+qru8L8ivUFQIOR56rYhQkXPRmVctt1JvOgb0JZ7V76oJ
 9p1Zsl8qIQ2bupWUfXSR5F0wrwCy19M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-8QKmGH9FORWlIuesE8RYeQ-1; Tue,
 27 May 2025 07:32:21 -0400
X-MC-Unique: 8QKmGH9FORWlIuesE8RYeQ-1
X-Mimecast-MFC-AGG-ID: 8QKmGH9FORWlIuesE8RYeQ_1748345540
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD06D180036E; Tue, 27 May 2025 11:32:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92E6419560AB; Tue, 27 May 2025 11:32:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E279421E6757; Tue, 27 May 2025 13:32:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  thuth@redhat.com,
 pbonzini@redhat.com,  richard.henderson@linaro.org,
 peter.maydell@linaro.org,  berrange@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH v4 08/15] qapi: Make
 CpuModelExpansionInfo::deprecated-props optional and generic
In-Reply-To: <20250522190542.588267-9-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 22 May 2025 12:05:35 -0700")
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-9-pierrick.bouvier@linaro.org>
Date: Tue, 27 May 2025 13:32:16 +0200
Message-ID: <87bjreqofz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> We'd like to have some unified QAPI schema. Having a structure field
> conditional to a target being built in is not very practical.
>
> While @deprecated-props is only used by s390x target, it is generic
> enough and could be used by other targets (assuming we expand
> CpuModelExpansionType enum values).
>
> Let's always include this field, regardless of the target, but make it
> optional. This is not a compatibility break only because the field
> remains present always on S390x.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  qapi/machine-target.json | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 426ce4ee82d..d8dbda4b508 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -244,19 +244,18 @@
>  #
>  # @model: the expanded CpuModelInfo.
>  #
> -# @deprecated-props: a list of properties that are flagged as
> +# @deprecated-props: an optional list of properties that are flagged as
>  #     deprecated by the CPU vendor.  The list depends on the
>  #     CpuModelExpansionType: "static" properties are a subset of the
>  #     enabled-properties for the expanded model; "full" properties are
>  #     a set of properties that are deprecated across all models for
> -#     the architecture.  (since: 9.1).
> +#     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
>  #
>  # Since: 2.8
>  ##
>  { 'struct': 'CpuModelExpansionInfo',
>    'data': { 'model': 'CpuModelInfo',
> -            'deprecated-props' : { 'type': ['str'],
> -                                   'if': 'TARGET_S390X' } },
> +            '*deprecated-props' : ['str'] },
>    'if': { 'any': [ 'TARGET_S390X',
>                     'TARGET_I386',
>                     'TARGET_ARM',

[Copied from review of prior posts]

When I see "optional array", I wonder about the difference between
"absent" and "present and empty".  The doc comment doesn't quite explain
it.  I figure "present and empty" means empty, while "absent" means we
don't know / not implemented.

Is the difference useful?

Daniel doubts it is.

[end of copy]

Let's take with this patch as is.  If we prefer to remove the
difference, we can do so on top.


