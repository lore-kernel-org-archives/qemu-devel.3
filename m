Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C499C624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1TPn-0001NN-5B; Tue, 01 Sep 2026 14:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1TPe-0001M0-Bx
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1TPc-0006Fc-Qd
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788288047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=REAsZ6vIYctH3BZzpZW4ImrV4skpXeQi6jmOAb4vidA=;
 b=hM6EvO5FCUV8d7S5kgSgoVIm/pKVjRvx5UXT23Xqi4+BxkXmnAOdVnrRZ9s8xWn0GX1vrf
 I1cyPAb5cpaaApN/PeOEUgwBPX+b3Ilm1oZoRypcxZEBkkRgyD22+j4ziRAA81F1Z2M8zK
 1dmePLWcDyElexBKHGFpL3UlEP1Cw14=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-4aigCHJkN-Ktn4ts6Qq0lw-1; Tue,
 01 Sept 2026 14:40:46 -0400
X-MC-Unique: 4aigCHJkN-Ktn4ts6Qq0lw-1
X-Mimecast-MFC-AGG-ID: 4aigCHJkN-Ktn4ts6Qq0lw_1788288045
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E0171954B14; Tue,  1 Sep 2026 18:40:45 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6388F7D8; Tue,  1 Sep 2026 18:40:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/3] Block patches
Date: Tue,  1 Sep 2026 14:40:39 -0400
Message-ID: <20260901184043.728292-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit eb710c255642cd7dc947f25c9a06c9fc8191e98d:

  Merge tag 'firmware-20260901-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-09-01 10:38:45 +0100)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 8e02b06882e5742fb760138e3db627a8591bdef3:

  file-posix: fix zone write granularity assignment for zoned block devices (2026-09-01 14:38:03 -0400)

----------------------------------------------------------------
Pull request

Fixes from Daniil Tatianin and Niklas Cassel. No new features.

----------------------------------------------------------------

Daniil Tatianin (1):
  tests/../test_hotplug_blk: drop unused nic

Niklas Cassel (2):
  file-posix: fix cache.direct=on check for zoned block devices
  file-posix: fix zone write granularity assignment for zoned block
    devices

 block/file-posix.c                          | 24 ++++++++++-----------
 tests/functional/x86_64/test_hotplug_blk.py |  1 +
 2 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.55.0


