Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3875EC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 05:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV2iv-0001fo-Iy; Sat, 20 Jul 2024 01:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sV2is-0001b3-2X
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 01:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sV2ip-0007Nl-EP
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 01:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721453609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tlR8jJhEa6glejda5qX5k/N8FNwvHY0j+66SOlOFCj4=;
 b=iofsS5mY4BeR6sNhioWRlX+eIvV7ri7Mf7Dy1FrvmUmtIFlylnpORze/n9k4chyrDpeNY7
 Qq2sl8c/1COidTJ8B5U/iqcX/MBt/kI3eke8W4JHovSmbQKK+yOrzUswGQBYza9XCW0Qab
 3BGYSAGSiVCVA4+K+Vi0XbJOLnSGiOE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-gmiNM3U4PkeYdvJO-fAIJQ-1; Sat,
 20 Jul 2024 01:33:25 -0400
X-MC-Unique: gmiNM3U4PkeYdvJO-fAIJQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71A561955F3D; Sat, 20 Jul 2024 05:33:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88F691955D47; Sat, 20 Jul 2024 05:33:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A863321E668F; Sat, 20 Jul 2024 07:33:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  thuth@redhat.com,
 david@redhat.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net,  Jiri Denemark
 <jdenemar@redhat.com>
Subject: Re: [PATCH v3] target/s390x: filter deprecated properties based on
 model expansion type
In-Reply-To: <20240719181741.35146-1-walling@linux.ibm.com> (Collin Walling's
 message of "Fri, 19 Jul 2024 14:17:41 -0400")
References: <20240719181741.35146-1-walling@linux.ibm.com>
Date: Sat, 20 Jul 2024 07:33:18 +0200
Message-ID: <87h6cksk4h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> Currently, there is no way to execute the query-cpu-model-expansion
> command to retrieve a comprehenisve list of deprecated properties, as
> the result is dependent per-model. To enable this, the expansion output
> is modified as such:
>
> When reporting a "full" CPU model, show the *entire* list of deprecated
> properties regardless if they are supported on the model. A full
> expansion outputs all known CPU model properties anyway, so it makes
> sense to report all deprecated properties here too.
>
> This allows management apps to query a single model (e.g. host) to
> acquire the full list of deprecated properties.
>
> Additionally, when reporting a "static" CPU model, the command will
> only show deprecated properties that are a subset of the model's
> *enabled* properties. This is more accurate than how the query was
> handled before, which blindly reported deprecated properties that
> were never otherwise introduced for certain models.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>
> Changelog:
>
>     v3
>     - Removed the 'note' and cleaned up documentation
>     - Revised commit message
>
>     v2
>     - Changed commit message
>     - Added documentation reflecting this change
>     - Made code changes that more accurately filter the deprecated
>         properties based on expansion type.  This change makes it
>         so that the deprecated-properties reported for a static model
>         expansion are a subset of the model's properties instead of
>         the model's full-definition properties.
>
> ---
>  qapi/machine-target.json         |  5 +++--
>  target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
>  2 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index a8d9ec87f5..67086f006f 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -21,8 +21,9 @@
>  # @props: a dictionary of QOM properties to be applied
>  #
>  # @deprecated-props: a list of properties that are flagged as deprecated
> -#     by the CPU vendor.  These props are a subset of the full model's
> -#     definition list of properties. (since 9.1)
> +#     by the CPU vendor.  These properties are either a subset of the
> +#     properties enabled on the CPU model, or a set of properties
> +#     deprecated across all models for the architecture.


When is it "a subset of the properties enabled on the CPU model", and
when is it "a set of properties deprecated across all models for the
architecture"?

My guess based on the commit message: it's the former when
query-cpu-model-expansion's type is "static", and the latter when it's
"full".

>  #
>  # Since: 2.8
>  ##
> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
> index 977fbc6522..e28ecf7ab9 100644
> --- a/target/s390x/cpu_models_sysemu.c
> +++ b/target/s390x/cpu_models_sysemu.c
> @@ -174,11 +174,15 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>                                  bool delta_changes)
>  {
>      QDict *qdict = qdict_new();
> -    S390FeatBitmap bitmap;
> +    S390FeatBitmap bitmap, deprecated;
>  
>      /* always fallback to the static base model */
>      info->name = g_strdup_printf("%s-base", model->def->name);
>  
> +    /* features flagged as deprecated */
> +    bitmap_zero(deprecated, S390_FEAT_MAX);
> +    s390_get_deprecated_features(deprecated);
> +
>      if (delta_changes) {
>          /* features deleted from the base feature set */
>          bitmap_andnot(bitmap, model->def->base_feat, model->features,
> @@ -193,6 +197,9 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>          if (!bitmap_empty(bitmap, S390_FEAT_MAX)) {
>              s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_enabled_feat);
>          }
> +
> +        /* deprecated features that are a subset of the model's enabled features */

Recommend to wrap this line for legibility.

> +        bitmap_and(deprecated, deprecated, model->features, S390_FEAT_MAX);
>      } else {
>          /* expand all features */
>          s390_feat_bitmap_to_ascii(model->features, qdict,
> @@ -207,12 +214,7 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>          info->props = QOBJECT(qdict);
>      }
>  
> -    /* features flagged as deprecated */
> -    bitmap_zero(bitmap, S390_FEAT_MAX);
> -    s390_get_deprecated_features(bitmap);
> -
> -    bitmap_and(bitmap, bitmap, model->def->full_feat, S390_FEAT_MAX);
> -    s390_feat_bitmap_to_ascii(bitmap, &info->deprecated_props, list_add_feat);
> +    s390_feat_bitmap_to_ascii(deprecated, &info->deprecated_props, list_add_feat);
>      info->has_deprecated_props = !!info->deprecated_props;
>  }


