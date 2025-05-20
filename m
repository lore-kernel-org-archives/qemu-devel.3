Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE2AC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHP9C-0006UH-BB; Tue, 20 May 2025 11:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uHP9A-0006TO-Lp
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uHP98-0001l3-IH
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747755888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aNlsCtZE0r3OHxgKyDXuSNuJvP4hqieubTiXEhLmsg8=;
 b=bR+0WpQKHd03h1V0uOJjVgSfaDr0E48Pm+OSrUm56hVYywzZqDLsdY20mEpGz97Gb3LZt6
 yXDkwJ6M2cTEbVzYYbuDM/OLiEJkLxTr5tt2onB+N09VuwkYq0f5ztuGSgXsv7N1vIqMzY
 QkcmAVlLTHbSGlPaFt9E+CfkCoxH6/k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-G2eZDXyaN5uKLSYjJHj7Jg-1; Tue,
 20 May 2025 11:44:45 -0400
X-MC-Unique: G2eZDXyaN5uKLSYjJHj7Jg-1
X-Mimecast-MFC-AGG-ID: G2eZDXyaN5uKLSYjJHj7Jg_1747755883
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C8F61955E79; Tue, 20 May 2025 15:44:42 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.201])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2861819560A3; Tue, 20 May 2025 15:44:36 +0000 (UTC)
Date: Tue, 20 May 2025 10:44:34 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, 
 stefanha@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru, 
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v2 00/24] block: do not drain while holding the graph lock
Message-ID: <3izqd7cy467tul2k6xuv74jwbbl65hi7gmknhl5m33asm3zaii@3mtbilfwfszt>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520103012.424311-1-f.ebner@proxmox.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, May 20, 2025 at 12:29:48PM +0200, Fiona Ebner wrote:
> Previous discussion [0].
> 

> NOTE:
> there are pre-existing test failures on current master, e.g. '240' for
> all formats, '295 296 inactive-node-nbd luks-detached-header' for luks
> and 'mirror-sparse' for raw. For me, the failures do not change after
> this series.

I have not yet reproduced the mirror-sparse failure locally; I suspect
the culprit may be a difference in filesystems and how well (or not)
SEEK_HOLE and FALLOC_FL_PUNCH_HOLE work on different filesystems.

Can I get more details on the failure as you see it, so I can work on
skipping the test when the filesystem does not support the test at
hand?  (It might be better to reply in context to the pull request
that introduced the file [2])

[2] https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg03623.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


