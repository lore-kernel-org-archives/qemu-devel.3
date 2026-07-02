Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DD4C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfF5M-0001F2-V1; Thu, 02 Jul 2026 06:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfF5L-0001Bz-Ff
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 06:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfF5K-0002HG-02
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 06:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782989756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pNYtNWaMElSTD2+oZlLCqkygaqooCrm2GNjXaOOAJWA=;
 b=TPjrhI8CAPqhbh9aZdyJ58suu9kmBqG3yTytw7YvypXgnJQSpsv3v4ijOF7KjpWtIu4C4d
 zcRbDVmiq3lYsEoxpf1pa5SwXsX404DbDZ2BOsn/x416ci5YvcRdfK1piDdfUcWGNz60OC
 Rng3+5XIDPXsNgUIzrZLnquwD74ktZc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-kD7iVptHNTq-zOVzt4t_Zg-1; Thu,
 02 Jul 2026 06:55:53 -0400
X-MC-Unique: kD7iVptHNTq-zOVzt4t_Zg-1
X-Mimecast-MFC-AGG-ID: kD7iVptHNTq-zOVzt4t_Zg_1782989752
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD5D4194511C; Thu,  2 Jul 2026 10:55:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79D573000B51; Thu,  2 Jul 2026 10:55:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 151A921E6920; Thu, 02 Jul 2026 12:55:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Kostiantyn
 Kostiuk <kkostiuk@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qga: implement 'guest-get-fsinfo' for FreeBSD
In-Reply-To: <20260701162529.10235-1-bogorodskiy@gmail.com> (Roman
 Bogorodskiy's message of "Wed, 1 Jul 2026 18:25:28 +0200")
References: <20260701162529.10235-1-bogorodskiy@gmail.com>
Date: Thu, 02 Jul 2026 12:55:49 +0200
Message-ID: <87jyrd1wzu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Roman Bogorodskiy <bogorodskiy@gmail.com> writes:

> Implement the qmp_guest_get_fsinfo() API for FreeBSD.
> To implement it, reuse build_fs_mount_list() which is already
> implemented for FreeBSD. Extend the FsMount type to include
> a string "fromname" attribute to store the disk the FS is mounted from.
>
> Disk mapping info is not covered by this implementation.
>
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


