Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F53D64088
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 08:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVnB4-000793-4f; Wed, 17 Dec 2025 03:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vVnB2-00078Q-LB
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 03:46:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vVnAz-0008Us-9Z
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 03:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765961188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=P+cSel+fKGIqJvLROXSJ7PyR292m8l34twaZ3oy1/Kw=;
 b=aq8pkL9zifPO2F8TQg77RAa7ZzHJfUQLljV5/mkAPzGoBT3jsyOZdnjyLVPKcsCEQoLFOd
 UwA5EBzefp4VRXziKuePyfYiS+06y0cSZ5XifGT+TLYdWgB+9lmy0S6gMSOGAR8Hbt1Bcw
 o6CJ6rV2MFmrMpjcWNzxI5B4up8NeE0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-iRcHctaKPtqSBKKa7PAueQ-1; Wed,
 17 Dec 2025 03:46:24 -0500
X-MC-Unique: iRcHctaKPtqSBKKa7PAueQ-1
X-Mimecast-MFC-AGG-ID: iRcHctaKPtqSBKKa7PAueQ_1765961183
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C047D19560B6; Wed, 17 Dec 2025 08:46:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 378CB30001A2; Wed, 17 Dec 2025 08:46:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B003E21E6A27; Wed, 17 Dec 2025 09:46:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/1] Error reporting patches for 2025-12-17
Date: Wed, 17 Dec 2025 09:46:19 +0100
Message-ID: <20251217084620.3319239-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

The following changes since commit 7154e4df40468012fccb6687ecd2b288c56a4a2d:

  Merge tag 'pull-glibc-20251216' of https://github.com/legoater/qemu into staging (2025-12-17 02:38:19 +1100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-error-2025-12-17

for you to fetch changes up to 00829ae3845fd11e56239390924e3e74c3a4c144:

  qdev: fix error handling in set_uint64_checkmask (2025-12-17 09:23:38 +0100)

----------------------------------------------------------------
Error reporting patches for 2025-12-17

----------------------------------------------------------------
Zesen Liu (1):
      qdev: fix error handling in set_uint64_checkmask

 hw/core/qdev-properties.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.49.0


