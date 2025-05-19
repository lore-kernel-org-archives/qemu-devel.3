Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B18C3DA6D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 06:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGtq8-00006j-4m; Mon, 19 May 2025 02:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uGtq5-00005Y-KC
 for qemu-devel@nongnu.org; Mon, 19 May 2025 02:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uGtq3-0002s4-2y
 for qemu-devel@nongnu.org; Mon, 19 May 2025 02:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747635540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AlZkfcsBxWwgZMt56Y2zA23k8TR+bLy/Hgq/kBXaYI8=;
 b=X8PFS01SHNFPA/6Oufc6EdEnXuT4hQVeIPn7CTPswwYffubGVD+7wEOAh1Tbf1NlbLZ38P
 ImKsszDsynvQaUBiDc+2Hvt1VAcyqjgmNOeJWRyCeQRnkZ6p61w6ktJKjCnEkh4bYzYZtM
 APw3PqbHCeiU+zfx7WkaRYWi5mtCxfI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-oJSaC2y1MR6e-3kGU0TKuw-1; Mon,
 19 May 2025 02:18:56 -0400
X-MC-Unique: oJSaC2y1MR6e-3kGU0TKuw-1
X-Mimecast-MFC-AGG-ID: oJSaC2y1MR6e-3kGU0TKuw_1747635535
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B66E1800446; Mon, 19 May 2025 06:18:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0127519560AB; Mon, 19 May 2025 06:18:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5BE0221E66C3; Mon, 19 May 2025 08:18:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Michael Roth
 <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  berrange@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 08/12] qapi: Make
 CpuModelExpansionInfo::deprecated-props optional and generic
In-Reply-To: <20250515172732.3992504-9-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 15 May 2025 10:27:28 -0700")
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
 <20250515172732.3992504-9-pierrick.bouvier@linaro.org>
Date: Mon, 19 May 2025 08:18:52 +0200
Message-ID: <87a579jf77.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
> Let's always include this field, regardless of the target, but
> make it optional.

Let's add:

  This is not a compatibility break only because the field remains
  present always on S390x.

>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  qapi/machine-target.json | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 426ce4ee82d..e153291a7fc 100644
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
> +            '*deprecated-props' : { 'type': ['str'] } },

[Copied from review of prior posts]

Make this

               '*deprecated-props' : ['str'] },

please.

When I see "optional array", I wonder about the difference between
"absent" and "present and empty".  The doc comment doesn't quite explain
it.  I figure "present and empty" means empty, while "absent" means we
don't know / not implemented.

Is the difference useful?

Daniel doubts it is.

Philippe is happy to implement either variant.

>    'if': { 'any': [ 'TARGET_S390X',
>                     'TARGET_I386',
>                     'TARGET_ARM',

Note the patch doesn't touch any of the qmp_query_cpu_model_expansion().
The S390x version continues to set @deprecated_props always.  The others
continue not to set it.


