Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E456C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 17:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucSdn-0005lO-0c; Thu, 17 Jul 2025 13:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ucQDg-0006nW-6t
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ucQDb-00027N-14
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752764893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=14czh6RRPcrgej6f9V9oJtuw78x+35YkVJBQTbjE4ng=;
 b=J5jDqI7mJGOD1oUqAAIlgRd8ILu4BsMaoh23AEdJ5b8Ap3Np46KniUXqheuRaGgXL/fL2X
 Rd9GAaEDzuJ9pRRJVU1IgUPk5Lpms0CBlUGaj/Zusz/4viA4ApPlZBoI/Y0K1UGfCtmd4W
 CIzYAz0n078DWv38M0fthy5/JYgGZWE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-RZnx5VtbOX-sV2ebTfkTjg-1; Thu,
 17 Jul 2025 11:08:10 -0400
X-MC-Unique: RZnx5VtbOX-sV2ebTfkTjg-1
X-Mimecast-MFC-AGG-ID: RZnx5VtbOX-sV2ebTfkTjg_1752764889
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E8CC19560B3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 15:08:09 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74C2E180049D; Thu, 17 Jul 2025 15:08:07 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 0/6] net: Fix various Coverity issues in vhost-user and passt
Date: Thu, 17 Jul 2025 17:07:59 +0200
Message-ID: <20250717150805.1344034-1-lvivier@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch series addresses several static analysis warnings reported by=0D
Coverity (CIDs 1612365, 1612368, 1612369, 1612371, 1612372, 1612375)=0D
in the vhost-user and passt networking code.=0D
=0D
The changes are mostly minor cleanups and fixes:=0D
=0D
Three patches remove an unused "err" variable and its associated=0D
unreachable error handling block.=0D
=0D
One patch removes another piece of dead code in an error path by=0D
refactoring away a goto.=0D
=0D
The remaining two patches initialize a pointer to prevent a potential=0D
illegal memory access and add a check for the return value of=0D
g_remove() to log potential errors.=0D
=0D
Laurent Vivier (6):=0D
  net/passt: Remove unused "err" from passt_vhost_user_event() (CID=0D
    1612375)=0D
  net/vhost-user: Remove unused "err" from net_vhost_user_event() (CID=0D
    1612372)=0D
  net/passt: Remove dead code in passt_vhost_user_start error path (CID=0D
    1612371)=0D
  net/passt: Check return value of g_remove() in net_passt_cleanup()=0D
    (CID 1612369)=0D
  net/passt: Initialize "error" variable in net_passt_send() (CID=0D
    1612368)=0D
  net/vhost-user: Remove unused "err" from chr_closed_bh() (CID 1612365)=0D
=0D
 net/passt.c      | 22 +++++++---------------=0D
 net/vhost-user.c |  9 ---------=0D
 2 files changed, 7 insertions(+), 24 deletions(-)=0D
=0D
-- =0D
2.49.0=0D
=0D


