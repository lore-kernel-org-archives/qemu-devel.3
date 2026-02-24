Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0ECE9B263
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 13:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vusru-00085G-Ma; Tue, 24 Feb 2026 08:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vusrs-000843-I9
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:54:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vusrq-0000nn-S4
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771941266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CnONwSc06k/yYtuX0E7Tjqf4OQn+lAZCqZ2HhMPOUO8=;
 b=V74Ut4WnalM49O9t1Gq5cRZDdlz6wb/4vCdSCoYet2AGmKELabB2cJE2U+i36ohs4c/WQs
 LdXVddEiFSflNiwEJtZgQPU8I995hEWafFvSCiXA7OZIbaCUOCtHVaD+RJXAfKJsqxqGC2
 A35wTTMWBXFpp8G6Tf0cirgf892leQ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-fqIsDcolPwqwPCEkF5BNYA-1; Tue,
 24 Feb 2026 08:54:24 -0500
X-MC-Unique: fqIsDcolPwqwPCEkF5BNYA-1
X-Mimecast-MFC-AGG-ID: fqIsDcolPwqwPCEkF5BNYA_1771941263
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C47318004AD; Tue, 24 Feb 2026 13:54:23 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3EA41800286; Tue, 24 Feb 2026 13:54:21 +0000 (UTC)
Date: Tue, 24 Feb 2026 14:54:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Antoine Damhet <adamhet@scaleway.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH 1/2] block/curl: fix concurrent completion handling
Message-ID: <aZ2ti76G3CiCm-4x@redhat.com>
References: <20260212162730.440855-1-adamhet@scaleway.com>
 <20260212162730.440855-2-adamhet@scaleway.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212162730.440855-2-adamhet@scaleway.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 12.02.2026 um 17:27 hat Antoine Damhet geschrieben:
> curl_multi_check_completion would bail upon the first completed
> transfer even if more completion messages were available thus leaving
> some in flight IOs stuck.
> 
> Rework a bit the loop to make the iterations clearer and drop the breaks.
> 
> The original hang can be somewhat reproduced with the following command:
> 
> $ qemu-img convert -p -m 16 -O qcow2 -c --image-opts \
>   'file.driver=https,file.url=https://scaleway.testdebit.info/10G.iso,file.readahead=1M' \
>   /tmp/test.qcow2
> 
> Fixes: 1f2cead32443 ("curl: Ensure all informationals are checked for completion")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Antoine Damhet <adamhet@scaleway.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


