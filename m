Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE9CC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHfPu-0006iZ-T7; Thu, 13 Jun 2024 04:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sHfPt-0006iE-E1
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sHfPr-0007Z8-8f
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718265758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lf1YWxGvRCF5qvFxXmpJCBHNLnrO8MqZURtxRDNhyYM=;
 b=V9Ssv3EMwFLfGpzxO4WNKQW4Aqp7FitIExnqWhdIq76x0IVbLl64WL7pXBTu0tuis4mrlv
 Yx/wA+AlNqlB8mU8fQxY8zbuhX2Zk8uWoFsP4enmwTRB3vTjlIjSFh4vB/aSm/pTE9Tk4U
 awREPeY64aN1fXE9zV918/f6JiEQmAU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-st2rkfChMxGueBzC3CgtuQ-1; Thu,
 13 Jun 2024 04:02:34 -0400
X-MC-Unique: st2rkfChMxGueBzC3CgtuQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F7F5195609F; Thu, 13 Jun 2024 08:02:32 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.41])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3943A1955F2D; Thu, 13 Jun 2024 08:02:28 +0000 (UTC)
Date: Thu, 13 Jun 2024 10:02:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, hreitz@redhat.com, jsnow@redhat.com,
 f.ebner@proxmox.com
Subject: Re: [PATCH v4 5/5] iotests: add backup-discard-source
Message-ID: <ZmqnkubkBeVYhW7_@redhat.com>
References: <20240313152822.626493-1-vsementsov@yandex-team.ru>
 <20240313152822.626493-6-vsementsov@yandex-team.ru>
 <ZmiORpYFHEWUXQRI@redhat.com>
 <accc6cdc-7b1e-4d26-9352-380f93cc3853@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <accc6cdc-7b1e-4d26-9352-380f93cc3853@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am 12.06.2024 um 21:21 hat Vladimir Sementsov-Ogievskiy geschrieben:
> On 11.06.24 20:49, Kevin Wolf wrote:
> > Am 13.03.2024 um 16:28 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > Add test for a new backup option: discard-source.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
> > > Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> > 
> > This test fails for me, and it already does so after this commit that
> > introduced it. I haven't checked what get_actual_size(), but I'm running
> > on XFS, so its preallocation could be causing this. We generally avoid
> > checking the number of allocated blocks in image files for this reason.
> > 
> 
> Hmm right, I see that relying on allocated size is bad thing. Better
> is to check block status, to see how many qcow2 clusters are
> allocated.
> 
> Do we have some qmp command to get such information? The simplest way
> I see is to add dirty to temp block-node, and then check its dirty
> count through query-named-block-nodes

Hm, does it have to be QMP in a running QEMU process? I'm not sure what
the best way would be there.

Otherwise, my approach would be 'qemu-img check' or even 'qemu-img map',
depending on what you want to verify with it.

Kevin


