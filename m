Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965ABD64086
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 07:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVmKF-0005P7-3g; Wed, 17 Dec 2025 02:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vVmKC-0005Oy-2g
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 02:51:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vVmKA-000264-IE
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 02:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765957911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F6m7e1qWD9XjNZ4WVxqD47/l0CzjKshX3ahDOv/Zr7U=;
 b=L4hOtUQa78eer2HYRgSlKMFgdSI4j13MAZdKWiB7Z/SHxob8GHFw/N23piRnxwNgpC4WAx
 DG0D+/BzDpu8nhHqFABdGOz8vrMieiBBH58IQ9ihgDVTDNWrCoyvYESOeWI6OE3OqTrMwl
 wL7zFrVycOFIT++167aNmcEC5IxQtJI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-Tw_11YzCM36lJCbsAfWl3w-1; Wed,
 17 Dec 2025 02:51:45 -0500
X-MC-Unique: Tw_11YzCM36lJCbsAfWl3w-1
X-Mimecast-MFC-AGG-ID: Tw_11YzCM36lJCbsAfWl3w_1765957904
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76A75195605A; Wed, 17 Dec 2025 07:51:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4EF51956056; Wed, 17 Dec 2025 07:51:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7738D21E6A27; Wed, 17 Dec 2025 08:51:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com,  ira.weiny@intel.com,  alucerop@amd.com,
 a.manzanares@samsung.com,  dongjoo.seo1@samsung.com,  mst@redhat.com,
 marcel.apfelbaum@gmail.com,  linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
In-Reply-To: <20251216152411.mlx5tgsdwnjss7ku@offworld> (Davidlohr Bueso's
 message of "Tue, 16 Dec 2025 07:24:11 -0800")
References: <20251103195209.1319917-1-dave@stgolabs.net>
 <87cy4esysa.fsf@pond.sub.org>
 <20251216152411.mlx5tgsdwnjss7ku@offworld>
Date: Wed, 17 Dec 2025 08:51:40 +0100
Message-ID: <87jyylo8ab.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Davidlohr Bueso <dave@stgolabs.net> writes:

> On Tue, 16 Dec 2025, Markus Armbruster wrote:
>
>>Davidlohr Bueso <dave@stgolabs.net> writes:
>>
>>> The following allows support for component basic back invalidation discovery
>>> and config, by exposing the BI routing table and decoder registers. Instead
>>> of going the type2[0] route, this series proposes adding support for type3
>>> hdm-db, which allows a more direct way of supporting BI in qemu.
>>
>>[...]
>>
>>> Applies against branch 'origin/cxl-2025-10-03-draft' from Jonathan's repository.
>>
>>URL?
>
> That would be:
>      https://gitlab.com/jic23/qemu/-/commits/cxl-2025-10-03-draft

Have these patches been posted to the list?  If yes, Message-Id or
archive URL, please.


