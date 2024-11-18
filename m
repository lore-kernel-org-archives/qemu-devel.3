Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F8CD591AE
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 19:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD7YU-0007oV-B4; Mon, 18 Nov 2024 14:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tD7YB-0007Xk-Om
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 14:36:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tD7Y6-0002lz-BR
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 14:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731958596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e7ofCQ+249Vj9nH+a+nSLtF/gioIhep7/MglIz9cg1c=;
 b=QLq08iwELH3mSE/zC8anYIKGiZr/rhh8UT+OgWsHAZgyVrNI/MXa6UCMkV30WwSwTbqPl/
 p7bYAQnDNEYlaLAIWr8vIJH/udI299g7gqQAxbJACwJ6CQCInHw4lEvY+lCN+Y+Ltx5pLc
 joNkIWlgPMGMCqoHz5i3Wf6AKFOSkvs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-90fZ6H-gMYyZ_Pq1_mgTow-1; Mon,
 18 Nov 2024 14:36:33 -0500
X-MC-Unique: 90fZ6H-gMYyZ_Pq1_mgTow-1
X-Mimecast-MFC-AGG-ID: 90fZ6H-gMYyZ_Pq1_mgTow
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09A601956048
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 19:36:32 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.76])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B0C21956086
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 19:36:30 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for -rc1 0/1] NBD patches for 2024-11-18
Date: Mon, 18 Nov 2024 13:35:11 -0600
Message-ID: <20241118193627.1826228-3-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit abb1565d3d863cf210f18f70c4a42b0f39b8ccdb:

  Merge tag 'pull-tcg-20241116' of https://gitlab.com/rth7680/qemu into staging (2024-11-16 18:16:46 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2024-11-18

for you to fetch changes up to efd3dda312129b91986f85976afbda58d40f757f:

  nbd-server: Silence server warnings on port probes (2024-11-18 09:06:17 -0600)

----------------------------------------------------------------
NBD patches for 2024-11-18

- Eric Blake: Silence qemu-nbd on harmless client port probes

----------------------------------------------------------------
Eric Blake (1):
      nbd-server: Silence server warnings on port probes

 nbd/server.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)
-- 
2.47.0


