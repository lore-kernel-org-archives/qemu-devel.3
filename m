Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86765CDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrUM-00076H-B3; Thu, 25 Jun 2026 17:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUJ-00075f-Nb
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUI-0003Jc-Es
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5A1Fmm4M8RrXZPhjzR9sV3rAlzlNlgQH97VWILPurQ=;
 b=gIdKKBU7mM9TMguidIeNZg8Uxigz17/Zv/jfqIlL28gNMFFiIFHgjwf3NzLU/DVxrKg2Hj
 STtFhGKzTS2Nd2je4boGEp5TNBSvRCL0R8MWglGzvyYnp3qMt4FhWsN+qyFwdB9IOpCI9M
 EcDRAZo1A+ZRtYLUUzcK5iob23WP/Ps=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-JC2LtsCaN_WP8CkV2cDGdw-1; Thu,
 25 Jun 2026 17:19:52 -0400
X-MC-Unique: JC2LtsCaN_WP8CkV2cDGdw-1
X-Mimecast-MFC-AGG-ID: JC2LtsCaN_WP8CkV2cDGdw_1782422391
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BB301955E75; Thu, 25 Jun 2026 21:19:51 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 150B630001BE; Thu, 25 Jun 2026 21:19:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:04 +0400
Subject: [PATCH v2 03/39] hmp: fix snapshot_blkdev argument type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-3-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yDXBGsCbQ79WaynGZjlcFthvE1q8wujUNM91a5aZAIk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtcmwOe+nOLqWoVD3RAvrv+rwh+O3QzfPc60
 q5khugOOH+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXAAKCRDa6OEJdZac
 5dfcD/9KxdZAWd+YMFBWFKf51N5uDKkDwXJ88MlCla4Ki1tuoSk1yWYxiMtiOz8QQDZkkaDE10j
 uoLjyu+MMEWJo6OGlwuNUJywHOfSdK/mcOjpbbg+ES5hhC8GCv2nP+E6dMj2vqAvHjaQiYRgeyY
 Li5p1BNwyBuXQQbm06RT8f+Obm9sSJioPIV7lQp9BcicgMbTOSOkzfyE3JekRZDGxXY9p3q/FA0
 Kh//oxu4TgbCGwiR0GJ1foyDqyMmbd+TLBNZ7d3IPeZyiIemtReFhtivUq2QSWVaGWbbDoQ96Aw
 Jq5onWQp1sRhQqDuhwzXswXq/oiSu/uy6gKEas7pH4ADyBAcrQPG82OPuBvLaEN7vBGemprkoJ5
 7wv8LS6LYcHwbzlPLdwxl8o/Clu6nXOrvofa58Pw+LVlE8pDYhYYYPq9i/cKZqPy8e5s5BUx2Y0
 Co4rSKtDL9uG7IgX5BGAxAb0GYjjrcqLua3ueQb6BJAy6X3N8ReuufJ5WrndLIiZBMt4sZujSkk
 WZZrfTDyyB12iPFWkmU0HSPukkMVwCPVS4nl9faH8sjY4DlpPshJU60DfKepAnUAuoPjowBPasf
 fRhzaZt2sk1qmqEuyJ2/qCTRMynK11wfcdlXbkrEhKJczTNgVUpDdycDt9Rvantqpx5zS7G4Xmk
 bCgr1mwET2yu5SQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

The `snapshot-file` argument for `snapshot_blkdev` is mandatory. Correct
the `args_type` definition to reflect this.

Fixes: 6106e2492fe ("qapi: Convert blockdev_snapshot_sync")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hmp-commands.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 2b658bbbf28..1e286b7c89d 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1168,7 +1168,7 @@ ERST
 
     {
         .name       = "snapshot_blkdev",
-        .args_type  = "reuse:-n,device:B,snapshot-file:s?,format:s?",
+        .args_type  = "reuse:-n,device:B,snapshot-file:s,format:s?",
         .params     = "[-n] device [new-image-file] [format]",
         .help       = "initiates a live snapshot\n\t\t\t"
                       "of device. If a new image file is specified, the\n\t\t\t"

-- 
2.54.0


