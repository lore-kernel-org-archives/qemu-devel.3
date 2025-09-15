Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027ABCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 21:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyGvV-0000Jk-J3; Mon, 15 Sep 2025 17:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uyGvS-0000J8-Mg
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 17:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uyGvF-0000mG-3A
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 17:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757972364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jKXYryI5OToUTuKx+mCNIQ5wy22PPLmLzCt612h+s28=;
 b=HGyNzdOKdgQ14jowi2iY4fppHkp+/IkgJhWThSkR+RDG4V10TKPN2gGFrQAQjO3DmxzUO1
 ie2TwjowUMpql7GtYGIUnG4pgH0nrlIOE8M3xcm+efMTcYqDHjn8opSAi6pXmduPb5OY5T
 lkjfCktvSIwWo0O+3EBl63M38qSFA3M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-BzyhFna6MqS2tsm-kkJkxg-1; Mon,
 15 Sep 2025 17:39:23 -0400
X-MC-Unique: BzyhFna6MqS2tsm-kkJkxg-1
X-Mimecast-MFC-AGG-ID: BzyhFna6MqS2tsm-kkJkxg_1757972362
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 171BF1800578
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 21:39:22 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.73])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D37D18004D8
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 21:39:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] reject qcow2 creation with protocol in data_store
Date: Mon, 15 Sep 2025 16:37:25 -0500
Message-ID: <20250915213919.3121401-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

v2 was here:
https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg06231.html
Since then:
 - rebase to latest tree

Eric Blake (2):
  block: Allow drivers to control protocol prefix at creation
  qcow2, vmdk: Restrict creation with secondary file using protocol

 include/block/block-global-state.h | 3 ++-
 block.c                            | 4 ++--
 block/crypto.c                     | 2 +-
 block/parallels.c                  | 2 +-
 block/qcow.c                       | 2 +-
 block/qcow2.c                      | 4 ++--
 block/qed.c                        | 2 +-
 block/raw-format.c                 | 2 +-
 block/vdi.c                        | 2 +-
 block/vhdx.c                       | 2 +-
 block/vmdk.c                       | 2 +-
 block/vpc.c                        | 2 +-
 12 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.51.0


