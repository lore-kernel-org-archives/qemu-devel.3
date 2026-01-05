Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAD5C79F9D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 14:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vclRh-00069b-7i; Mon, 05 Jan 2026 09:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vclRf-000697-ED
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 09:20:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vclRe-0005QP-4L
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 09:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767622829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BWklRkf2mLEiRVJ85312vCzolrRxNfdWE3Ygw2dseac=;
 b=fuF8r5mxVlrmMHckQ/7WAAqXuVxMy6XLdF7+yShABznUWKPPD/Ttj6dZsZ/IROf5yBwzCi
 NZcUuhZAWykDxHLWEerKyS45ce/Air4PhqAI2eQqOYTz2PDO0hqbJC1mnl2dFd0ENpeC6a
 PAiGdY9D9/wp8g8AUjcrb71rY2O/f40=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-ZTWiI2OSN5SL4HuEk6b28w-1; Mon,
 05 Jan 2026 09:20:26 -0500
X-MC-Unique: ZTWiI2OSN5SL4HuEk6b28w-1
X-Mimecast-MFC-AGG-ID: ZTWiI2OSN5SL4HuEk6b28w_1767622825
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4164E1956089; Mon,  5 Jan 2026 14:20:25 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.33.52])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FF571800663; Mon,  5 Jan 2026 14:20:22 +0000 (UTC)
Date: Mon, 5 Jan 2026 15:20:20 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] block: Wire up 'flat' mode also for 'query-block'
Message-ID: <aVvIpF3VUY43xUvh@angien.pipo.sk>
References: <38fa3ec064ed20282fb61f70ffed8e0abb3abbfa.1765445716.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38fa3ec064ed20282fb61f70ffed8e0abb3abbfa.1765445716.git.pkrempa@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Dec 11, 2025 at 10:37:53 +0100, Peter Krempa wrote:
> From: Peter Krempa <pkrempa@redhat.com>
> 
> Some time ago (commit facda5443f5a8) I've added 'flat' mode (which
> omits 'backing-image' key in reply) to 'query-named-block-nodes' to
> minimize the size of the returned JSON for deeper backing chains.
> 
> While 'query-block' behaved slightly better it turns out that in libvirt
> we do call 'query-block' to figure out some information about the
> block device (e.g. throttling info) but we don't look at the backing
> chain itself.
> 
> Wire up 'flat' for 'query-block' so that libvirt can ask for an
> abbreviated output. The implementation is much simpler as the internals
> are shared with 'query-named-block-nodes'.
> 
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---
>  block/monitor/block-hmp-cmds.c | 4 ++--
>  block/qapi.c                   | 9 +++++----
>  qapi/block-core.json           | 4 ++++
>  ui/cocoa.m                     | 2 +-
>  4 files changed, 12 insertions(+), 7 deletions(-)

Ping


