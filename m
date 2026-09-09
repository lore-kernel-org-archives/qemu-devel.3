Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB0CC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NBy-00069v-Ax; Wed, 09 Sep 2026 14:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NBr-00067V-68; Wed, 09 Sep 2026 14:38:35 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NBp-00072Y-ME; Wed, 09 Sep 2026 14:38:34 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA23540A43;
 Wed,  9 Sep 2026 18:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B83D1F000FF;
 Wed,  9 Sep 2026 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788979111;
 bh=psoQShLqT6+yJV1dS5Y85vhVuzwxt9jvlzJ6J91iiVk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=a1YY0raUx9vHTAQSRW3uhkdmXoFX/SG/z1ZecSK+B1RBJ+S6gSmiOAqEryiNrkGwl
 pQSxR8s7CSe3P4r/KOI3KAeZ0Teo/EWhg7oeXlTJ/imyK6FC2CPDslL3f/KRt1hHso
 YpDbroz1oNkJhdh3yfF2jMZyBKZLdMe4v3H0h0S/S5FZIrazOQ0N79JiELxTHjzr3a
 UK7S9kWx0cFuYKVxdeUtR0wbBAAFhwsX9FQqSphiWT7caTJwEy6pV/unQoSxhAZZaa
 SxCkuibIENz/XPAhUEkBejsI/UHz6jQ4rBuGZUyKBp47sjdqUgN92l3wTjlOjrl+jO
 tc5chewIp1y9A==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Wed, 09 Sep 2026 20:36:53 +0200
Subject: [PATCH v3 4/7] dma-helpers: chunk dma_blk_cb at IOV_MAX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-align-nvme-mdts-with-linux-v3-4-1cee970cc8c8@samsung.com>
References: <20260909-align-nvme-mdts-with-linux-v3-0-1cee970cc8c8@samsung.com>
In-Reply-To: <20260909-align-nvme-mdts-with-linux-v3-0-1cee970cc8c8@samsung.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Daniel Gomez <da.gomez@kernel.org>, 
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788979097; l=1069;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=pwviRsrqUtdVfz/fQZeanc/8A6kQn0kCksJJk+P7S0w=;
 b=qrVop/xKzHRGSlgGWvOJmC9QHibXH69h9e/+TibV58ZxLGvuLQI0xRuRIrcPhiwyTPCzJVBWU
 llsUorO2uqxATFPqo+sq2FYkEXNK4FDSLob8R2RbzOu+Up+k//yd0wM
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=172.234.252.31; envelope-from=da.gomez@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Gomez <da.gomez@samsung.com>

dma_blk_cb() submits dbs->iov to io_func() in one shot, so callers
must keep dbs->iov.niov below IOV_MAX or the host preadv()/pwritev()
rejects the call.

Break the accumulation loop when niov reaches IOV_MAX. The existing
re-entry path resumes mapping and submits a follow-up chunk under
the same AIOCB, so callers no longer carry that constraint.

Suggested-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Jesper Wendel Devantier <foss@defmacro.it>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 system/dma-helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index d4fd33a3d4c..613fa548669 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -175,6 +175,9 @@ static void dma_blk_cb(void *opaque, int ret)
             dbs->sg_cur_byte = 0;
             ++dbs->sg_cur_index;
         }
+        if (dbs->iov.niov >= IOV_MAX) {
+            break;
+        }
     }
 
     if (dbs->iov.size == 0) {

-- 
2.55.0


