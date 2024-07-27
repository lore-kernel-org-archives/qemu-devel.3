Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEBEC3DA61
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2024 06:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXaVv-0001tO-7h; Sat, 27 Jul 2024 02:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sXaVs-0001sJ-PG
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 02:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sXaVp-0001LP-Ht
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 02:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722060155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gAmgNwutb2vDGU2+FUjAjSHmmY8Zmdlkwyqf1L5pvKU=;
 b=GZm6w5BSjrZRUw63Dg0vn8o6oBCJIQLQG598mydj9U75ChmUen32rHOF3Gm58Fv9xTlhA2
 9BHliUkZzMb5cy4JKYYVp0uRMu9kz6uSAQJpKNaHzJrMXuCgYD7HXKws9BgxJIzPKCuRS2
 D3R54uAv+/oKnFJaWnbBLb/shkjTeM8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-ov0jLDhnMZudRjUU17h6YQ-1; Sat,
 27 Jul 2024 02:02:31 -0400
X-MC-Unique: ov0jLDhnMZudRjUU17h6YQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B0181955D44; Sat, 27 Jul 2024 06:02:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1006F19560AE; Sat, 27 Jul 2024 06:02:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B0C9221E6757; Sat, 27 Jul 2024 08:02:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  thuth@redhat.com,
 david@redhat.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net
Subject: Re: [PATCH v1] target/s390x: move @deprecated-props to
 CpuModelExpansion Info
In-Reply-To: <20240726203646.20279-1-walling@linux.ibm.com> (Collin Walling's
 message of "Fri, 26 Jul 2024 16:36:46 -0400")
References: <20240726203646.20279-1-walling@linux.ibm.com>
Date: Sat, 27 Jul 2024 08:02:24 +0200
Message-ID: <877cd7qsnj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Collin Walling <walling@linux.ibm.com> writes:

> The @deprecated-props array did not make any sense to be a member of the
> CpuModelInfo struct, since this field would only be populated by a
> query-cpu-model-expansion response and ignored otherwise.

Doesn't query-cpu-model-baseline also return it in its response?  It
seems to assume the "static" expansion type.

>                                                           Move this
> field to the CpuModelExpansionInfo struct where is makes more sense.
>
> References:
>  - https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg05996.html
>  - commit eed0e8ffa38f0695c0519508f6e4f5a3297cbd67
>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>
> @David, the previous commit header did not align with the changes made
> here, so I tagged this as a "v1" but added the previous conversation as
> a reference.  I hope this is appropriate?
>
> ---
>  qapi/machine-target.json         | 18 ++++++++++--------
>  target/s390x/cpu_models_sysemu.c | 31 ++++++++++++++++++++-----------
>  2 files changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index a552e2b0ce..09dec2b9bb 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -20,17 +20,11 @@
>  #
>  # @props: a dictionary of QOM properties to be applied
>  #
> -# @deprecated-props: a list of properties that are flagged as deprecated
> -#     by the CPU vendor.  These properties are either a subset of the
> -#     properties enabled on the CPU model, or a set of properties
> -#     deprecated across all models for the architecture.
> -#
>  # Since: 2.8
>  ##
>  { 'struct': 'CpuModelInfo',
>    'data': { 'name': 'str',
> -            '*props': 'any',
> -            '*deprecated-props': ['str'] } }
> +            '*props': 'any' } }
>  
>  ##
>  # @CpuModelExpansionType:
> @@ -248,10 +242,18 @@
>  #
>  # @model: the expanded CpuModelInfo.
>  #
> +# @deprecated-props: a list of properties that are flagged as deprecated
> +#     by the CPU vendor.  The list depends on the CpuModelExpansionType:
> +#     "static" properties are a subset of the enabled-properties for
> +#     the expanded model; "full" properties are a set of properties
> +#     that are deprecated across all models for the architecture.
> +#     (since: 9.1).
> +#
>  # Since: 2.8
>  ##
>  { 'struct': 'CpuModelExpansionInfo',
> -  'data': { 'model': 'CpuModelInfo' },
> +  'data': { 'model': 'CpuModelInfo',
> +            '*deprecated-props': ['str'] },
>    'if': { 'any': [ 'TARGET_S390X',
>                     'TARGET_I386',
>                     'TARGET_ARM',

This solves several interface problems:

1. Removes inappropriate @deprecated-props argument of
   query-cpu-model-comparison, query-cpu-model-expansion,
   query-cpu-model-baseline.

2. Removes @deprecated-props return of query-cpu-model-baseline.

3. Properly documents how @deprecated-props depends on the expansion
   type.

Remaining problem:

4. Only S390 implements this.

Suggest to capture 1-3 more clearly in the commit message, perhaps like
this:

    CpuModelInfo is used both as command argument and in command
    returns.

    Its @deprecated-props array does not make any sense in arguments,
    and is silently ignored.  We actually want it only as return value
    of query-cpu-model-expansion.

    Move it from CpuModelInfo to CpuModelExpansionType, and document
    its dependence on expansion type propetly.

The simplest way to address 4 is to tack 'if': 'TARGET_S390X' to
@deprecated-props.

I recommend to make @deprecated-props mandatory rather than optional
then.

> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
> index 94dd798b4c..44e7587acb 100644
> --- a/target/s390x/cpu_models_sysemu.c
> +++ b/target/s390x/cpu_models_sysemu.c
> @@ -174,15 +174,11 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>                                  bool delta_changes)
>  {
>      QDict *qdict = qdict_new();
> -    S390FeatBitmap bitmap, deprecated;
> +    S390FeatBitmap bitmap;
>  
>      /* always fallback to the static base model */
>      info->name = g_strdup_printf("%s-base", model->def->name);
>  
> -    /* features flagged as deprecated */
> -    bitmap_zero(deprecated, S390_FEAT_MAX);
> -    s390_get_deprecated_features(deprecated);
> -
>      if (delta_changes) {
>          /* features deleted from the base feature set */
>          bitmap_andnot(bitmap, model->def->base_feat, model->features,
> @@ -197,9 +193,6 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>          if (!bitmap_empty(bitmap, S390_FEAT_MAX)) {
>              s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_enabled_feat);
>          }
> -
> -        /* deprecated features that are a subset of the model's enabled features */
> -        bitmap_and(deprecated, deprecated, model->features, S390_FEAT_MAX);
>      } else {
>          /* expand all features */
>          s390_feat_bitmap_to_ascii(model->features, qdict,
> @@ -213,9 +206,6 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>      } else {
>          info->props = QOBJECT(qdict);
>      }
> -
> -    s390_feat_bitmap_to_ascii(deprecated, &info->deprecated_props, list_add_feat);
> -    info->has_deprecated_props = !!info->deprecated_props;
>  }
>  
>  CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> @@ -226,6 +216,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>      CpuModelExpansionInfo *expansion_info = NULL;
>      S390CPUModel s390_model;
>      bool delta_changes = false;
> +    S390FeatBitmap deprecated_feats;
>  
>      /* convert it to our internal representation */
>      cpu_model_from_info(&s390_model, model, "model", &err);
> @@ -245,6 +236,24 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>      expansion_info = g_new0(CpuModelExpansionInfo, 1);
>      expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
>      cpu_info_from_model(expansion_info->model, &s390_model, delta_changes);
> +
> +    /* populated list of deprecated features */
> +    bitmap_zero(deprecated_feats, S390_FEAT_MAX);
> +    s390_get_deprecated_features(deprecated_feats);
> +
> +    if (delta_changes) {
> +        /*
> +         * Only populate deprecated features that are a
> +         * subset of the features enabled on the CPU model.
> +         */
> +        bitmap_and(deprecated_feats, deprecated_feats,
> +                   s390_model.features, S390_FEAT_MAX);
> +    }
> +
> +    s390_feat_bitmap_to_ascii(deprecated_feats,
> +                              &expansion_info->deprecated_props, list_add_feat);
> +    expansion_info->has_deprecated_props = !!expansion_info->deprecated_props;
> +
>      return expansion_info;
>  }

Implementation looks good to me.


