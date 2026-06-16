Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F20CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQeH-0004OQ-AE; Tue, 16 Jun 2026 06:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wZQeF-0004Nn-Lj
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wZQeD-00028d-1t
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781604234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocN4TMh4a49jzz/P5LZezRinQosZaAjc2LCF+4G99kg=;
 b=YCmomaTPff7gtprhJRZgkNk2W+0tkR4RBPbSoQCJGLKSxTkC6BAUmg7k/tJ0lPn/hsDYGi
 4o8UQa73Wv3aAklT7nN3L51GdUKN4Zf1vtruqF47qRuE+yIzJLK6dpPVE9hUprXFzQ2IOw
 fL5euh8n0Xhl6Xe/pO0KGKOdv9w7brs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-e2ssvhUSOP-Uoe-AE-jiPA-1; Tue,
 16 Jun 2026 06:03:51 -0400
X-MC-Unique: e2ssvhUSOP-Uoe-AE-jiPA-1
X-Mimecast-MFC-AGG-ID: e2ssvhUSOP-Uoe-AE-jiPA_1781604230
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B7321955DB4; Tue, 16 Jun 2026 10:03:49 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4914B1624; Tue, 16 Jun 2026 10:03:44 +0000 (UTC)
Date: Tue, 16 Jun 2026 12:03:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Christian Barry <christian.barry@usp.br>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 David de Barros Tadokoro <davidbtadokoro@usp.br>,
 Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
Subject: Re: [PATCH] block: qcow2-bitmap: fix persistent bitmap corruption on
 ENOSPC
Message-ID: <ajEffqTgNxUEncoj@redhat.com>
References: <20260610023337.165474-1-christian.barry@usp.br>
 <c2a0d86c-5989-40ca-9a7c-265b15e6b1c6@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2a0d86c-5989-40ca-9a7c-265b15e6b1c6@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 16.06.2026 um 11:06 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 10.06.26 05:33, Christian Barry пишет:
> > From: Christian Barry <christian.barry@usp.br>
> > 
> > Changed qcow2_co_remove_persistent_dirty_bitmap() to treat free_bitmap_clusters()
> > failure as fatal and roll back the header update through a new helper
> > function rollback_ext_header_and_dir_helper(), which was also applied
> > to update_ext_header_and_dir(), which had internal rollback logic.
> > Changed bitmap_list_store() to zero the cluster tail after write,
> > guaranteeing that qemu-img won't parse into stale bytes.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3516
> 
> Hi!
> 
> First, seem like two different fixes merged into one commit, please if
> possible, make them separate two commits.
> 
> Next, please, make commit messages more descriptive, about what the
> issue we solve (link is good as additional information, but the commit
> message itself should be complete).
> 
> For example, I don't understand free_bitmap_clusters makes the image
> unreadable. And we we fix it in one place, leaving other calls to
> free_bitmap_clusters() unchanged. Could we fix free_bitmap_clusters()
> itself? See also my comments below

I haven't looked at the patch yet, but this sounds like apart from
splitting the patches into one logical change per patch and improving
the commit message, the patch series should also include a test case
(probably qemu-iotests) that demonstrates the problem and how the patch
changes behaviour.

Kevin


