Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DFF1061B2B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 11:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Wvp-0003ON-4s; Tue, 31 Mar 2026 07:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7Wvn-0003NS-Ly
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 07:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7Wvm-0001Ny-0v
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 07:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774955204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YTJPUWbhFIXDCiSg2VdcJlH45wmBHYIoy7jfBvyQTvU=;
 b=Ucb37UYR5X/fPFJfobl3hxZoP40ZytGpcRknTrVQaht9bGyeM+b8vkCvQe0621XaOu9GwR
 kmAhW0+mhVBNBSisH+mdFs3dC4lhCYZf3NZA1RnFtVIB8QLzNqJfeWd/Pvnyyfs4s777AG
 TiBS8BJvLT5cXDK/Q9hHN7An/5oHS/k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-7m_4PbUzMn6-JDaPoxzGfQ-1; Tue,
 31 Mar 2026 07:06:41 -0400
X-MC-Unique: 7m_4PbUzMn6-JDaPoxzGfQ-1
X-Mimecast-MFC-AGG-ID: 7m_4PbUzMn6-JDaPoxzGfQ_1774955199
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1E831956065; Tue, 31 Mar 2026 11:06:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58716180075B; Tue, 31 Mar 2026 11:06:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0990421E6A28; Tue, 31 Mar 2026 13:06:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,  qemu-devel@nongnu.org,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com,
 Emily.Deng@amd.com,  Victor.Zhao@amd.com,  PengJu.Zhou@amd.com,
 Qing.Ma@amd.com
Subject: Re: [PATCH v3] migration/rdma: add x-rdma-chunk-size parameter
In-Reply-To: <acqgZShXRkqzBU1C@x1.local> (Peter Xu's message of "Mon, 30 Mar
 2026 12:10:13 -0400")
References: <20260327065006.2567463-1-guoqing.zhang@amd.com>
 <acqgZShXRkqzBU1C@x1.local>
Date: Tue, 31 Mar 2026 13:06:37 +0200
Message-ID: <875x6ctg02.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Peter Xu <peterx@redhat.com> writes:

[...]

> One thing to mention is RDMA migration is in odd-fixes stage, actually it
> doesn't have a real maintainer so it is kind of "orphaned".  In this case,
> I actually won't suggest we add any new knobs for performance reasons.

Good point.

> Do you have a strong reason to propose this patch to land upstream?  Is it
> used in production systems and it solves some real problems for you?

If you use it in production, finding an upstream maintainer is in your
best interest.  Give it a thought.

> I also wonder what Zhijian would say on this.
>
> Thanks,


