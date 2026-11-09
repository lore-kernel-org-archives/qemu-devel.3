Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C26606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HtBYRDsK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPtG-0005CH-Hz; Mon, 09 Nov 2026 08:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQPt6-00052n-Fa
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:58:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQPt3-0007IH-Ce
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794232695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aeormPUN+IE5IR9JK1OrZdmwByJz1Sup5ujeu3UnUpA=;
 b=HtBYRDsKL67pYsMB5FHCmxWs4Bk9zaaOdp6T5U+0nGRqPS9PzvZnQJrzqq550804qXdG2i
 3pGjHUovBYBrTOWA0JfdLKQ+l5eo0XvQpJE7J0rWw+Ij+uaLGRgZcSz5lIJcZdkLN6jcGG
 ZFmB5dFBtTJfY3H3aVSMda2QIulds6U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-OOtiTlRtNQaaiiH2IV6ckg-1; Mon,
 09 Nov 2026 08:58:10 -0500
X-MC-Unique: OOtiTlRtNQaaiiH2IV6ckg-1
X-Mimecast-MFC-AGG-ID: OOtiTlRtNQaaiiH2IV6ckg_1794232688
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09A9F1800637; Mon,  9 Nov 2026 13:57:56 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8112F18004F5; Mon,  9 Nov 2026 13:57:53 +0000 (UTC)
Date: Mon, 9 Nov 2026 07:57:50 -0600
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, berrange@redhat.com, qemu-block@nongnu.org, 
 Feifan Qian <bea1e@proton.me>, Haotian Jiang <jianghaotian.sunday@gmail.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 2/3] nbd/server: Reject rather than assert on
 non-compliant BLOCK_STATUS
Message-ID: <avHRM8Jaoa1Wd01b@redhat.com>
References: <20261107225834.778738-5-eblake@redhat.com>
 <20261107225834.778738-7-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107225834.778738-7-eblake@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 04:54:37PM -0600, Eric Blake wrote:
> The NBD spec is clear that a client must not send NBD_BLOCK_STATUS
> requests to a server if it did not negotiate any metacontexts with
> NBD_OPT_SET_META_CONTEXT.  However, if the non-compliant client uses
> NBD_OPT_EXTENDED_HEADERS and then passes in the relatively new
> NBD_CMD_FLAG_PAYLOAD_LEN flag alongside an inappropriate block status
> request, this was enough to trigger an assertion in qemu.
> 
> If you do not use recommended practice to prevent untrusted clients
> from connecting to QEMU's NBD server, then you are at risk of a denial
> of service attack from a rogue client.  Per our stated policy on flaws
> triggered by network connections, this is considered a low-severity
> security flaw, since it is trivial to avoid by using proper
> configuration of TLS and x509 certificate authorization to reject
> rogue clients; therefore, no CVE has been assigned yet.

CVE-2026-124559 has been assigned; I'll update the commit message
accordingly before the pull request, if no other changes in the series
are requested.

> 
> Fixes: 2dcbb11b ("nbd/server: Add FLAG_PAYLOAD support to CMD_BLOCK_STATUS", v8.2.0)
> Reported-by: Feifan Qian <bea1e@proton.me>
> Reported-by: https://gitlab.com/qemu-project/qemu/-/work_items/3796
> CC: Haotian Jiang <jianghaotian.sunday@gmail.com>
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/server.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index e6c47f8c2e3..bc37cbcb338 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2584,12 +2584,12 @@ nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
>          return -EINVAL;
>      }
> 
> -    assert(client->contexts.exp == client->exp);
>      nr_bitmaps = client->exp->nr_export_bitmaps;
>      request->contexts = g_new0(NBDMetaContexts, 1);
>      request->contexts->exp = client->exp;
> 
> -    if (payload_len % sizeof(uint32_t) ||
> +    if (!client->contexts.count ||
> +        payload_len % sizeof(uint32_t) ||
>          payload_len < sizeof(NBDBlockStatusPayload) ||
>          payload_len > (sizeof(NBDBlockStatusPayload) +
>                         sizeof(id) * client->contexts.count)) {
> -- 
> 2.56.0
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


