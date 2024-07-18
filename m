Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53698C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURM5-0002Z0-K6; Thu, 18 Jul 2024 09:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sURLw-00027g-Uj
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sURLu-0001RH-NP
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721309961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kXsZ2XI3G/9gnTN11BE0k8Msh8UF6H5GpffLH2q/kaI=;
 b=blFtKlDudQ/ZoIdXupTxebZ8vtueCboqFoRB67Am0biW5A2HwWwtJL0+vbchcsGiV8EQ1C
 0oRDTkivvBU6+SVlOnVIIgkV/MNFJ8z/UM4ir5RjUMAieCaQc5VjWrxGSD7542yKSXi7ED
 UqI9Nn3sTk76ebg9LQ5oMmrW/w3+Mtg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-TbzhWe9sOt6vNMGV0AifcQ-1; Thu,
 18 Jul 2024 09:39:18 -0400
X-MC-Unique: TbzhWe9sOt6vNMGV0AifcQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C1011955D48; Thu, 18 Jul 2024 13:39:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CC0B195605A; Thu, 18 Jul 2024 13:39:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1779A21E66A3; Thu, 18 Jul 2024 15:39:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  thuth@redhat.com,
 david@redhat.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net,  Jiri Denemark
 <jdenemar@redhat.com>
Subject: Re: [PATCH v2] target/s390x: filter deprecated properties based on
 model expansion type
In-Reply-To: <20240716173253.28533-1-walling@linux.ibm.com> (Collin Walling's
 message of "Tue, 16 Jul 2024 13:32:53 -0400")
References: <20240716173253.28533-1-walling@linux.ibm.com>
Date: Thu, 18 Jul 2024 15:39:13 +0200
Message-ID: <87le1yn7jy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> As s390 CPU models progress and deprecated properties are dropped
> outright, it will be cumbersome for management apps to query the host
> for a comprehensive list of deprecated properties that will need to be
> disabled on older models. To remedy this, the query-cpu-model-expansion
> output now behaves by filtering deprecated properties based on the
> expansion type instead of filtering based off of the model's full set
> of features:
>
> When reporting a static CPU model, only show deprecated properties that
> are a subset of the model's enabled features.
>
> When reporting a full CPU model, show the entire list of deprecated
> properties regardless if they are supported on the model.
>
> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>
> Changelog:
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
>         For example:
>
>         Previously, the z900 static model would report 'bpb' in the
>         list of deprecated-properties.  However, this prop is *not*
>         a part of the model's feature set, leading to some inaccuracy
>         (albeit harmless).
>
>         Now, this feature will not show during a static expansion.
>         It will, however, show up in a full expansion (along with
>         the rest of the list: 'csske', 'te', 'cte').
>
> @David, I've elected to respectully forgo adding your ack-by on this
> iteration since I have changed the code (and therefore the behavior)
> between this version and the previous in case you do not agree with
> these adjustments.
>
> ---
>  qapi/machine-target.json         |  8 ++++++--
>  target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
>  2 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index a8d9ec87f5..d151504f25 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -21,8 +21,12 @@
>  # @props: a dictionary of QOM properties to be applied
>  #
>  # @deprecated-props: a list of properties that are flagged as deprecated
> -#     by the CPU vendor.  These props are a subset of the full model's
> -#     definition list of properties. (since 9.1)
> +#     by the CPU vendor.  (since 9.1).
> +#
> +# .. note:: Since 9.1, the list of deprecated props were always a subset
> +#    of the model's full-definition list of properites. Now, this list is
> +#    populated with the model's enabled property set when delta changes
> +#    are applied. All deprecated properties are reported otherwise.

I'm confused.

"Since 9.1, the list of deprecated props were ..." and "Now, this list
is" sounds like you're explaining behavior before and after a change.
What change?  Since only released behavior matters, and
@deprecated-props is new, there is no old behavior to document, isn't
it?

docs/devel/qapi-code-gen.rst section "Documentation markup":

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

>  #
>  # Since: 2.8
>  ##

[...]


