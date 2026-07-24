Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DC8C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnHdG-0006WL-UX; Fri, 24 Jul 2026 11:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnHcf-0006SQ-5q
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnHcc-0007QN-Ht
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784906133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7wLlRvl9aTSIW0lryAVTzGTM0xZS5xJWq4Ve7OXQdI=;
 b=PpIW2g8nhW+cC3ZZGu5Gi0D9pyG5WBiMAOs7SOEPttv+1zZTFNRz/tTmURZIuJ+Tq3vpo3
 QI/KhiVL88W2SLzz27iYEPlMQvRmVw889PSrAcfTeSr6XvJZ/a8c1iczAkn7iAH650ipd5
 jVNw0UzZSrE93G1+1tPFwoLoxTsCKho=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-YuQctpyhNkifVn7kd-KWMA-1; Fri,
 24 Jul 2026 11:15:28 -0400
X-MC-Unique: YuQctpyhNkifVn7kd-KWMA-1
X-Mimecast-MFC-AGG-ID: YuQctpyhNkifVn7kd-KWMA_1784906128
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF4ED1828A8D; Fri, 24 Jul 2026 15:15:27 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27DBD15AD; Fri, 24 Jul 2026 15:15:25 +0000 (UTC)
Date: Fri, 24 Jul 2026 17:15:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH for-11.1 0/3] dmg: add missing input validation
 (CVE-2026-65929 & CVE-2026-65928)
Message-ID: <amOBixUuhV1Q6Ica@redhat.com>
References: <20260723144519.364701-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723144519.364701-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 23.07.2026 um 16:45 hat Stefan Hajnoczi geschrieben:
> The read-only dmg block driver can crash or leak information when it encounters
> a malicious DMG file. The severity of these issues is low because the block
> driver is used in qemu-img convert workflows where there is no sensitive
> information to leak and crashing is a self-DoS.
> 
> See the individual patches for descriptions of the bugs.

Thanks, applied to the block branch.

Kevin


