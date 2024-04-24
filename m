Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA56C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 06:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzVyo-0006I1-2F; Wed, 24 Apr 2024 02:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzVyn-0006Go-BX
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 02:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzVyl-00033p-6N
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 02:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713939577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bsOflYf6wj8EJhMeT5A3h2oQmsjrNBlc38MKgUT1k8U=;
 b=DrVmHWSVXcawmqIw4xpOa4cbm0jx/MgH4ErW5je1UGptbIcVIBLrCSNwmYrJnl4fDY1d1U
 0JC1Ne5Gi8pymeLfJIEwv9957URbl3BbXuicv5uMf8vqqZKu/EQyfU8HItWPDFse4B+ROG
 IRAAc5aiwmODi9kjKI84nePH/2K+gA4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-IN1xE2AWMP65ZtXJLeM5cA-1; Wed, 24 Apr 2024 02:19:32 -0400
X-MC-Unique: IN1xE2AWMP65ZtXJLeM5cA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DE3380B935;
 Wed, 24 Apr 2024 06:19:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AC1F200AE7F;
 Wed, 24 Apr 2024 06:19:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB7E321E6680; Wed, 24 Apr 2024 08:19:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  thuth@redhat.com,
 david@redhat.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net
Subject: Re: [PATCH v2 1/3] cpu-models: add "disable-deprecated-feats"
 option to cpu model expansion
In-Reply-To: <20240423210655.66656-2-walling@linux.ibm.com> (Collin Walling's
 message of "Tue, 23 Apr 2024 17:06:53 -0400")
References: <20240423210655.66656-1-walling@linux.ibm.com>
 <20240423210655.66656-2-walling@linux.ibm.com>
Date: Wed, 24 Apr 2024 08:19:30 +0200
Message-ID: <87bk5z5ll9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

Collin Walling <walling@linux.ibm.com> writes:

> This optional parameter for query-cpu-model-expansion enables CPU
> model features flagged as deprecated to appear in the resulting
> list of properties.
>
> This commit does not add support beyond adding a new argument
> to the query. All queries with this option present will result
> in an error claiming this option is not supported.
>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  qapi/machine-target.json         | 7 ++++++-
>  target/arm/arm-qmp-cmds.c        | 7 +++++++
>  target/i386/cpu-sysemu.c         | 7 +++++++
>  target/s390x/cpu_models_sysemu.c | 7 +++++++
>  4 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 29e695aa06..b9da284d2d 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -285,6 +285,10 @@
>  #
>  # @type: expansion type, specifying how to expand the CPU model
>  #
> +# @disable-deprecated-feats: include CPU model features that are
> +#     flagged as deprecated. If supported, these features will appear
> +#     in the properties list paired with false.

What's the default?

Which command result(s) does this affect?  Suggest to explain using
unabridged example QMP input and output before and after this series.

We generally avoid abbreviations in QMP names.  Let's call this
@disable-deprecated-features.

Separate sentences with two spaces for consistency, please.

> +#
>  # Returns: a CpuModelExpansionInfo describing the expanded CPU model
>  #
>  # Errors:
> @@ -298,7 +302,8 @@
>  ##
>  { 'command': 'query-cpu-model-expansion',
>    'data': { 'type': 'CpuModelExpansionType',
> -            'model': 'CpuModelInfo' },
> +            'model': 'CpuModelInfo',
> +            '*disable-deprecated-feats': 'bool' },
>    'returns': 'CpuModelExpansionInfo',
>    'if': { 'any': [ 'TARGET_S390X',
>                     'TARGET_I386',
                      'TARGET_ARM',
                      'TARGET_LOONGARCH64',
                      'TARGET_RISCV' ] } }

Put a pin into this conditional: [*].

> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index 3cc8cc738b..1010d654e3 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -100,6 +100,8 @@ static const char *cpu_model_advertised_features[] = {
>  
>  CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>                                                       CpuModelInfo *model,
> +                                                     bool has_disable_deprecated_feats,
> +                                                     bool disable_deprecated_feats,
>                                                       Error **errp)
>  {
>      CpuModelExpansionInfo *expansion_info;
> @@ -110,6 +112,11 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>      const char *name;
>      int i;
>  
> +    if (has_disable_deprecated_feats) {
> +        error_setg(&err, "Unsupported option 'disable-deprecated-feats'");
> +        return NULL;
> +    }

Reject the new argument in the ARM version, ...

> +
>      if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
>          error_setg(errp, "The requested expansion type is not supported");
>          return NULL;
> diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
> index 3f9093d285..c15786fb66 100644
> --- a/target/i386/cpu-sysemu.c
> +++ b/target/i386/cpu-sysemu.c
> @@ -196,6 +196,8 @@ out:
>  CpuModelExpansionInfo *
>  qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>                                                        CpuModelInfo *model,
> +                                                      bool has_disable_deprecated_feats,
> +                                                      bool disable_deprecated_feats,
>                                                        Error **errp)
>  {
>      X86CPU *xc = NULL;
> @@ -204,6 +206,11 @@ qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>      QDict *props = NULL;
>      const char *base_name;
>  
> +    if (has_disable_deprecated_feats) {
> +        error_setg(&err, "Unsupported option 'disable-deprecated-feats'");
> +        goto out;
> +    }

... the i386 version, ...

> +
>      xc = x86_cpu_from_model(model->name, model->props, "model.props", &err);
>      if (err) {
>          goto out;
> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
> index 2d99218069..ef9fa80efd 100644
> --- a/target/s390x/cpu_models_sysemu.c
> +++ b/target/s390x/cpu_models_sysemu.c
> @@ -210,6 +210,8 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>  
>  CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>                                                        CpuModelInfo *model,
> +                                                      bool has_disable_deprecated_feats,
> +                                                      bool disable_deprecated_feats,
>                                                        Error **errp)
>  {
>      Error *err = NULL;
> @@ -217,6 +219,11 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>      S390CPUModel s390_model;
>      bool delta_changes = false;
>  
> +    if (has_disable_deprecated_feats) {
> +        error_setg(&err, "Unsupported option 'disable-deprecated-feats'");
> +        return NULL;
> +    }

... and the S390 version, but ...

> +
>      /* convert it to our internal representation */
>      cpu_model_from_info(&s390_model, model, "model", &err);
>      if (err) {

... neither the loongarch not the RISC-V version, which according to
condition [*] above also implement the command[*].  Bug?

Peeking ahead in the series, I see that you implement
@disable-deprecated-feats only for S390.

Having to reject @disable-deprecated-feats in targets that implement
query-cpu-model-expansion, but not the @disable-deprecated-feats, is
problematic:

1. If we implement query-cpu-model-expansion for another target, we need
to remember rejecting @disable-deprecated-feats.  Trap for the unwary.

2. query-qmp-schema can't tell whether the argument is supported.

You could make @query-cpu-model-expansion conditional on S390.

Since conditional arguments require 'boxed': true, you first have to
do that, like so:

    { 'command': 'query-cpu-model-expansion', 'boxed': true,
      'data': 'Foo',
      'returns': 'CpuModelExpansionInfo',
      'if': { 'any': [ 'TARGET_S390X',
                       'TARGET_I386',
                       'TARGET_ARM',
                       'TARGET_LOONGARCH64',
                       'TARGET_RISCV' ] } }

where Foo is

    { 'struct': 'Foo',
      'data': { 'type': 'CpuModelExpansionType',
                'model': 'CpuModelInfo' } }

Then add the conditional argument:

    { 'struct': 'Foo',
      'data': { 'type': 'CpuModelExpansionType',
                'model': 'CpuModelInfo' } }
                '*disable-deprecated-feats': { 'type': 'bool',
                                               'if': 'TARGET_S390X' }

Use a reasonable name instead of Foo, of course.

Disadvantages:

* More churn

* Possibly something else I can't see without trying it

Advantages:

* You don't have to reject the argument for all targets that don't
  implement it

* We can't forget to reject the argument when implementing
  query-cpu-model-expansion for another target

* query-cpu-model-expansion shows whether the argument is supported

I think you should give this a try.


