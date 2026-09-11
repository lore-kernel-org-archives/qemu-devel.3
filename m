Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0BDC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x70-0000zU-Hq; Fri, 11 Sep 2026 04:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4x6y-0000zB-SJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4x6x-0007hK-6O
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIewDwVbSFkoIBxPtOaUyKrtR8TJ0pkLjaAft5la66M=;
 b=M1vurrc6gAJeKFfpgLGqdMPBC3LkGLRDrF//7gcE2V3+jQPsjfXHxxMbAuoOkVMhoQBZJy
 JTGTN3LINf2WZFbNTKpvfRRieRdbB9NZ50gk0/wjIXNJ5uBOb0vLb/zUUBXOXJ1RX6P4aA
 yhhHnv4jl4OC+115B61g63tZ0sYDWjg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-aEgFXBqHNPqlxXGhazmlHg-1; Fri,
 11 Sep 2026 04:59:49 -0400
X-MC-Unique: aEgFXBqHNPqlxXGhazmlHg-1
X-Mimecast-MFC-AGG-ID: aEgFXBqHNPqlxXGhazmlHg_1789117188
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 393041800365; Fri, 11 Sep 2026 08:59:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 734C4180057F; Fri, 11 Sep 2026 08:59:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1FE4321E6A04; Fri, 11 Sep 2026 10:59:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Igor Mammedov <imammedo@redhat.com>,  linux-cxl@vger.kernel.org,  Zhao
 Liu <zhao1.liu@intel.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Lukas Straub <lukasstraub2@web.de>,  Jonathan
 Cameron <jic23@kernel.org>,  qemu-block@nongnu.org,  Ani Sinha
 <anisinha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 08/10] qapi: convert simple data struct intros for
 machine.json
In-Reply-To: <20260910203856.99003-9-jsnow@redhat.com> (John Snow's message of
 "Thu, 10 Sep 2026 16:38:54 -0400")
References: <20260910203856.99003-1-jsnow@redhat.com>
 <20260910203856.99003-9-jsnow@redhat.com>
Date: Fri, 11 Sep 2026 10:59:44 +0200
Message-ID: <871pb09n9b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/machine.json | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 942d35d7275..0516112f8e8 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -468,8 +468,7 @@
>  
>  ##
>  # @NumaNodeOptions:
> -#
> -# Create a guest NUMA node.  (for OptsVisitor)
> +#     Create a guest NUMA node.  (for OptsVisitor)
>  #
>  # @nodeid: NUMA node ID (increase by 1 from 0 if omitted)
>  #

The (for OptsVisitor) part has become wrong.  I'll post a patch.

> @@ -596,11 +595,10 @@
>  
>  ##
>  # @NumaCpuOptions:
> -#
> -# Option "-numa cpu" overrides default cpu to node mapping.  It
> -# accepts the same set of cpu properties as returned by
> -# `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`, where
> -# node-id could be used to override default node mapping.
> +#     Option "-numa cpu" overrides default cpu to node mapping.  It
> +#     accepts the same set of cpu properties as returned by
> +#     `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`,
> +#     where node-id could be used to override default node mapping.
>  #
>  # Since: 2.10
>  ##


