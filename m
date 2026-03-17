Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AEDF33817
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Q9w-0006Jk-ET; Tue, 17 Mar 2026 04:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9J-0005mS-IT
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9H-0002kK-Fe
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgGMqWRoNgYqfadnrZRN+egBryZS2leBtfp1A62h7kc=;
 b=GQUenXLzCKXZ9Emg50oFIj8yIQ6LSlPXMyKh79esBWiCneF0ciTZwrjnDkmRfBeM66b+YP
 XHJX222Wb1A9jxTo5xDiYQXS6McSKAfEFHNavUtap7jnCA3jD/JUXYS8isI7QjYic40IdT
 dS06yu3fbsmWakUHBCM5sUE7vsmik40=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-dyvESVB6Mv2-RaNqlsln4g-1; Tue,
 17 Mar 2026 04:51:33 -0400
X-MC-Unique: dyvESVB6Mv2-RaNqlsln4g-1
X-Mimecast-MFC-AGG-ID: dyvESVB6Mv2-RaNqlsln4g_1773737492
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EE4E18005B0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:32 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 22DB8180075B
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:23 +0400
Subject: [PATCH 09/60] ui/vnc-jobs: drop redundant (and needless)
 qemu_thread_get_self()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-9-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=726;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=b1rg64rVjg+JyQU94K34Xh3zXu/+C7TtUel6eexqkFA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXasXDRbk3PAiMHTFDMytATM3KJio/YfZWM2
 wJvO2VzcVyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5arjD/9o1Ca9oO63aAUpA9MRqZeLmBLW/dyxzMuBv2L4ZaIxLu2EeMUWEV0rcRPS6SsAkcajdE4
 hXNmUvYwxfIoFzzJWQVUikY1Zq9URNlvMHwA9E8kTUwZbUNG0r90N9jJArFd4aSF4FnR7X4T4HV
 FTxvPmdgQW67Rh28cMty3tpB4ZujJpmQrbbKZRgcQvbBDQVoPzzfZdBYdFGg85UPc633V4+KiTl
 JZxFIVrqkjeTS4RLr9ZY1sFSYiqiQ40ki2A26PQYtg8MdT9VpDNJl/LofReELXhuWJSFsqimONi
 iK1i6FwcQIKrD2uvVcL26vHtgk68zw4gbDr8FwcOc4NfhDUdF02GdqqmsH6MzIGgOkIXxC9J74v
 ly44LSGic30sAOM/N8ipUKbJLF+FugfxRn8nxpm7dJM1onAUDI2VjFLmLZbLB+W6sfeYk/RIK35
 mOj/fIQWwph7zEFxLTdlyXobiFvF6+XonizkcHKZ3k3Vc0RnYCjKiNWu3Gr6r4D1UvBojQvjW8r
 7Z50+8TFiE/AacxXP2DeeI6/llFN/BFWxU89Rl6c5JbLtq6GwJMuO5OKUYHJQUeU7Szqlbdr3uU
 yE7I1ZNcmOghnzBZ0WcfWPfhYz580udvIGngYNUONP+dAAG6cvRbs/AJjf3cnuNKCJr6pkU2Y3p
 w2noAWgBuj+aKjw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

The call is unnecessary, since "thread" is already set at creation time.
Furthermore, the "thread" field is mostly useless as the thread is
created DETACHED and isn't used for anything but perhaps debugging.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index ae925171fae..0523e52cbd2 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -349,8 +349,6 @@ static void *vnc_worker_thread(void *arg)
 {
     VncJobQueue *queue = arg;
 
-    qemu_thread_get_self(&queue->thread);
-
     while (!vnc_worker_thread_loop(queue)) ;
     g_assert_not_reached();
     return NULL;

-- 
2.53.0


