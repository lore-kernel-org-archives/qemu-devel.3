Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19450C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 20:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfmKi-0008Ct-Pj; Wed, 05 Feb 2025 15:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tfmKh-0008Cb-EO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:49:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tfmKf-0000GI-Fo
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738788552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/wJ0O/1x/iv1FeQNDq2CHLOuMyyx1LH8BqLJ51E6Mg8=;
 b=Mu6YH02wDMrCiy1S4KXu/cj5uPO0udkBoxJ4lL2/S7WD7r5m/ow6YADN6GRK2vVH1+8Slh
 ET/8uwpNpUrhHIJo6fcYMFIxMn5a6pTUcN4CLCtWGvcLl2AYapMnrNQeDmeaNhgaTcuu88
 bh0/pTQMMf814/sSOM6lpW4vhIilW20=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602--0sijGQUMC-SiHR9mDjQLw-1; Wed,
 05 Feb 2025 15:49:11 -0500
X-MC-Unique: -0sijGQUMC-SiHR9mDjQLw-1
X-Mimecast-MFC-AGG-ID: -0sijGQUMC-SiHR9mDjQLw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5ED0C1955D4F; Wed,  5 Feb 2025 20:49:10 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA47D195608D; Wed,  5 Feb 2025 20:49:06 +0000 (UTC)
Date: Wed, 5 Feb 2025 14:49:04 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 16/16] iotests: Add (NBD-based) tests for inactive nodes
Message-ID: <vjbi4k3dfeyjn7iou4nigfzwb474vvdmv77ue4bo3oyo7bgxrl@s7du4tx22xge>
References: <20250204211407.381505-1-kwolf@redhat.com>
 <20250204211407.381505-17-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204211407.381505-17-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 04, 2025 at 10:14:07PM +0100, Kevin Wolf wrote:
> This tests different types of operations on inactive block nodes
> (including graph changes, block jobs and NBD exports) to make sure that
> users manually activating and inactivating nodes doesn't break things.
> 
> Support for inactive nodes in other export types will have to come with
> separate test cases because they have different dependencies like blkio
> or root permissions and we don't want to disable this basic test when
> they are not fulfilled.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py                 |   4 +
>  tests/qemu-iotests/tests/inactive-node-nbd    | 303 ++++++++++++++++++
>  .../qemu-iotests/tests/inactive-node-nbd.out  | 239 ++++++++++++++
>  3 files changed, 546 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/inactive-node-nbd
>  create mode 100644 tests/qemu-iotests/tests/inactive-node-nbd.out
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


