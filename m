Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9C7D1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkSGv-0007f9-Il; Mon, 26 Jan 2026 14:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vkSGu-0007ew-4A
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:29:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vkSGs-0003VE-Iz
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769455749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j64+fVJTOBkyCGBbHm0ou4a5pGlwJcRR17AKqjQC7SM=;
 b=R2FLSyFfs+DU0KiegURrZjGeE6NsbrQb6xDQuJzK9l2sK5aOI67CXyi5UrOZjsxVfacs8s
 oqU7HLlwQzOskFoIZTQTBViMw9ZyUlraws/zHCm6WXcmG7uBa/2sBOnL69jrgl7y2jlOE+
 zzR62Ixut2zkM2jKvyE48DvLR/wyJOU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-0JB3kqe1MJyocr_kD7T6bg-1; Mon,
 26 Jan 2026 14:29:07 -0500
X-MC-Unique: 0JB3kqe1MJyocr_kD7T6bg-1
X-Mimecast-MFC-AGG-ID: 0JB3kqe1MJyocr_kD7T6bg_1769455746
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B87EA180034D; Mon, 26 Jan 2026 19:29:06 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7839430001A2; Mon, 26 Jan 2026 19:29:05 +0000 (UTC)
Date: Mon, 26 Jan 2026 13:29:02 -0600
From: Eric Blake <eblake@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/2] hmp_nbd_server_start: Don't ask for backing image
 data
Message-ID: <aXfAb-ou3Cn6sLld@redhat.com>
References: <cover.1768920111.git.pkrempa@redhat.com>
 <3d34ff5e7166abf4fd9d9b9b324cde3a1c2b00ee.1768920111.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d34ff5e7166abf4fd9d9b9b324cde3a1c2b00ee.1768920111.git.pkrempa@redhat.com>
User-Agent: NeoMutt/20251211
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 20, 2026 at 03:45:57PM +0100, Peter Krempa wrote:
> From: Peter Krempa <pkrempa@redhat.com>
> 
> 'hmp_nbd_server_start' uses only the device name from the data returned
> from 'qmp_query_block', thus no backing file information. Use the new
> options to suppress asking for the unused parts to save on resources.
> 
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---
>  block/monitor/block-hmp-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


