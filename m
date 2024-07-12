Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2822C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 05:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS8lB-00076m-Jp; Fri, 12 Jul 2024 01:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sS8l9-000743-CE
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 01:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sS8l6-0000jt-CL
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 01:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720761831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XAYf0xq/GMtRTv60l+2DBJgxd42KFkYDiAnourTVR+k=;
 b=Mpt+fIiUCvPVQp1SSzfMB0I23QkO21JJ/jEM94KAKf9AhPYQURC1e4oQwU4UDQywjJCP1W
 cYuLfNTqH+lmY9LiteXT0cryCAeFkKuJyN8EQnK/4UcmfcX8n673BKgCdREefuoJn7Z0y4
 3GNvpny97u9NWTiDNHs+u/xHLAjB6Y8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-gvKU2KS6MLO9YLLnRQoCNQ-1; Fri,
 12 Jul 2024 01:23:46 -0400
X-MC-Unique: gvKU2KS6MLO9YLLnRQoCNQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3361819560A2; Fri, 12 Jul 2024 05:23:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4723319560AE; Fri, 12 Jul 2024 05:23:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B22721E6757; Fri, 12 Jul 2024 07:23:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  thuth@redhat.com,
 david@redhat.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net,  Jiri Denemark
 <jdenemar@redhat.com>
Subject: Re: [PATCH v1] target/s390x: filter deprecated features based on
 model expansion type
In-Reply-To: <20240711203254.49018-1-walling@linux.ibm.com> (Collin Walling's
 message of "Thu, 11 Jul 2024 16:32:54 -0400")
References: <20240711203254.49018-1-walling@linux.ibm.com>
Date: Fri, 12 Jul 2024 07:23:39 +0200
Message-ID: <87h6cvxjxg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> It is beneficial to provide an interface to retrieve *all* deprecated
> features in one go. Management applications will need this information
> to determine which features need to be disabled regardless of the
> host-model's capabilities.
>
> To remedy this, deprecated features are only filtered during a static
> expansion. All deperecated features are reported on a full expansion.
>
> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>

Which command(s) exactly are affected?

Do they need a doc update?

> ---
>  target/s390x/cpu_models_sysemu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
> index 977fbc6522..76d15f2e4d 100644
> --- a/target/s390x/cpu_models_sysemu.c
> +++ b/target/s390x/cpu_models_sysemu.c
> @@ -211,7 +211,15 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>      bitmap_zero(bitmap, S390_FEAT_MAX);
>      s390_get_deprecated_features(bitmap);
>  
> -    bitmap_and(bitmap, bitmap, model->def->full_feat, S390_FEAT_MAX);
> +    /*
> +     * For static model expansion, filter out deprecated features that are
> +     * not a subset of the model's feature set. Otherwise, report the entire 
> +     * deprecated features list.
> +     */
> +    if (delta_changes) {
> +        bitmap_and(bitmap, bitmap, model->def->full_feat, S390_FEAT_MAX);
> +    }
> +
>      s390_feat_bitmap_to_ascii(bitmap, &info->deprecated_props, list_add_feat);
>      info->has_deprecated_props = !!info->deprecated_props;
>  }


