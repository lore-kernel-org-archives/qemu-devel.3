Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650C8CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 10:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stloI-0003u2-Pp; Thu, 26 Sep 2024 06:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66f53402.v1-c30f7570a69a4edea420fec1bd6ad99a@bounce.vates.tech>)
 id 1stloF-0003so-TX
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 06:33:20 -0400
Received: from mail136-20.atl41.mandrillapp.com ([198.2.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66f53402.v1-c30f7570a69a4edea420fec1bd6ad99a@bounce.vates.tech>)
 id 1stloE-0002As-6z
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 06:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1727345666; x=1727606166;
 bh=t2ClioiobIx8sORcFDyjTmKyeW+IX3Hdgvdic7NBgp0=;
 h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
 b=HnZErQ4eDIyU1tkzy/ukDQav2kBagREiFtyKrcAoF6HY7rc2C5XGdU8vTRmN3F7ho
 tuCz45hYxCW+SykvtnyQgiomL3h+TKmbRq6RyJ0xlFzHlJmkCWjSA523Q0ZVLFxnEk
 hA3UtWM0rv8BmyeCqI9hWscno3pLxaHSM9gfHGBQ/EXRO30u24MYPclWmQoWGtA7Ns
 tDSz94ohI73prie+dJzKWR98CSrEQmKVvpTIZV1Ss+S0c4XrNVpXrcQH1LGN0INuSz
 YkmUuI0JHqFN0EwCgPFVutcWqi8JEVGBofF6YKW/YCMuy5RZ7zOxoF5k9J6Kk9c3dn
 8Jen2jvanYS8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1727345666; x=1727606166; i=anthony.perard@vates.tech;
 bh=t2ClioiobIx8sORcFDyjTmKyeW+IX3Hdgvdic7NBgp0=;
 h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
 b=VIF5PW+gDw2e92o+F1tcQS1dhjcm0OikrqNrOB9PkG5TfrMrBLxU9wIJmFRY473c7
 n+ozNgVkYmbl8BPBY4q8cmTTyFp56oPMyrVgAU1YUk/nyPg1g6AC8lxqmu9axGMArK
 b9GdINRrRDe7PJ5epQpnEBW21JEBjmUvfV1CPsnBl2m0+UaoYeuT1+Xm7eCtTlXlJJ
 PzYvWOZw8FIKTNKDAPFEKhSilep/Ysf8UE9wnbaZkMIgs+sfyi9UWFKb8ZoPf2VJgR
 nvdLRHR7iOaNDv9s/nte44RRYzpOr/l/zBqQKubqYPTZOyZlLXkm6uNyOEc0KUZa3g
 5j7A8YAfcFbIg==
Received: from pmta11.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail136-20.atl41.mandrillapp.com (Mailchimp) with ESMTP id
 4XDqFt1jZ8zCfBbQl
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 10:14:26 +0000 (GMT)
From: Anthony PERARD <anthony.perard@vates.tech>
Subject: =?utf-8?Q?[PATCH=200/2]=20Xen:=20Update=20sector-size=20handling=20in=20block=20backend?=
Received: from [37.26.189.201] by mandrillapp.com id
 c30f7570a69a4edea420fec1bd6ad99a; Thu, 26 Sep 2024 10:14:26 +0000
X-Mailer: git-send-email 2.39.2
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1727345665088
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@vates.tech>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paul Durrant <paul@xen.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony@xenproject.org>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org
Message-Id: <20240926101334.2388-1-anthony.perard@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.c30f7570a69a4edea420fec1bd6ad99a?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20240926:md
Date: Thu, 26 Sep 2024 10:14:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.136.20;
 envelope-from=bounce-md_30504962.66f53402.v1-c30f7570a69a4edea420fec1bd6ad99a@bounce.vates.tech;
 helo=mail136-20.atl41.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The specification have been clarified regarding what "sector" is in Xen PV
block protocol by Xen commit 221f2748e8da ("blkif: reconcile protocol
specification with in-use implementations") and "feature-large-sector-size"
have been removed.

https://xenbits.xenproject.org/gitweb/?p=xen.git;a=commit;h=221f2748e8dabe8361b8cdfcffbeab9102c4c899

This update the header and the backend.

Thanks,

Anthony PERARD (2):
  include: update Xen public headers io/blkif.h
  hw/block/xen-block: Update sector-size handling

 hw/block/dataplane/xen-block.c      | 31 ++++++++++++-----
 hw/block/xen-block.c                |  8 ++---
 include/hw/xen/interface/io/blkif.h | 52 +++++++++++++++++++++--------
 3 files changed, 65 insertions(+), 26 deletions(-)

-- 


Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech

