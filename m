Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70910C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 09:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkLMa-0007ee-DX; Wed, 13 Mar 2024 05:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rkLMY-0007eV-UU
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 05:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rkLMU-0004tX-Dz
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 05:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710323845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8sMROQ3yib4xGEnFk8bKAONZocACo5qE86giw+lzeU=;
 b=bCVCMYD/YsqLr8F6Zh/ndlrSh8FRo1MoG1Ytm0M0aXqO1vShqMgcohTYrZj1YhQQgfyE9E
 lzvyB+cIhLRu7GkJi6E/vloJ4HNXdHqEH57DX6mw1kjmrDKXA2I7JOiCo5t/vL0uGqpkLc
 fcm/l6FvGDqHAKgJT90L2fw8XhH4OUE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-MlqI8cGpNySajLvg3Pp2fg-1; Wed, 13 Mar 2024 05:57:21 -0400
X-MC-Unique: MlqI8cGpNySajLvg3Pp2fg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45F32101A552;
 Wed, 13 Mar 2024 09:57:21 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2F492166B4F;
 Wed, 13 Mar 2024 09:57:19 +0000 (UTC)
Date: Wed, 13 Mar 2024 10:57:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH for 9.0] migration: Skip only empty block devices
Message-ID: <ZfF4fhtyZOho51KN@redhat.com>
References: <20240312120431.550054-1-clg@redhat.com>
 <ZfBKNhRkAt2_7hmc@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfBKNhRkAt2_7hmc@x1n>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 12.03.2024 um 13:27 hat Peter Xu geschrieben:
> On Tue, Mar 12, 2024 at 01:04:31PM +0100, Cédric Le Goater wrote:
> > The block .save_setup() handler calls a helper routine
> > init_blk_migration() which builds a list of block devices to take into
> > account for migration. When one device is found to be empty (sectors
> > == 0), the loop exits and all the remaining devices are ignored. This
> > is a regression introduced when bdrv_iterate() was removed.
> > 
> > Change that by skipping only empty devices.
> > 
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Suggested: Kevin Wolf <kwolf@redhat.com>
> 
> This should be:
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> 
> I think the missed "by" caused Kevin not in the cc list, I added Kevin in.
> 
> I'll hold a bit for Kevin to ACK, no repost needed just for above; I can
> fix it.

Thanks.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


