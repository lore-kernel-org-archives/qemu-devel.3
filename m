Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D21ECD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9wo-0005rb-KC; Sat, 16 May 2026 04:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wm-0005nr-U3
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wl-0007aO-DL
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2eZf1p5B9iU/LpmdGUTPslOXBQR4xs83NdisiayIy0Y=;
 b=eq7ZdKkjKEM08kcMH8dDVUPNOsePRQsC8Vn8RRb+z1dGZGJNlXjjToEOMYRqclhuUT0ohS
 U5wuHDUI2fxt+A5f9evvsCBZGVwr9B8shmjgHIUXkTbYHczFvlK/N+UQGEsBMSAulAzlW+
 HkQIlZZJ1mA+dNESCMzJAYhgKBKU8RA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-ndEpO671MNqBoSP6DSmlcA-1; Sat,
 16 May 2026 04:00:28 -0400
X-MC-Unique: ndEpO671MNqBoSP6DSmlcA-1
X-Mimecast-MFC-AGG-ID: ndEpO671MNqBoSP6DSmlcA_1778918427
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9DED1800344
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:00:27 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7DDD330001A2; Sat, 16 May 2026 08:00:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:11 +0400
Subject: [PATCH v3 12/24] hw/core/machine: free shim_filename on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-12-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=718;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=E+Mw/r+U2Z/IIOcJlVsJmQHnesFU93bUUoyxJd97jjw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPPNHBG76GY5F443n9VgJBZjkx386ayBoz0d
 p0wRjYXwg+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5RGDEAC2SxBsuLxLcmIVUv36KojDsdKp5IyqZWDhPykGvfcbDPL0xt6g4FYQv3iz5m3E2Ab4Svu
 1VGelwgEOzs1EWJDJFB+nTG26ubAMHs7CJyzIMQwxNekdfoMxkdolPsCH5ODcZT7HKNx5lSDI/w
 ide9HEBF8pingCcAowY022zbTChXvXCOBHuBZyXzBistrkr0uKBeo7p8R8DB5KaZ7AI0nzKmp1o
 +8htqe3DhAJSxQ6YwcPLBu+cRSPW0TNTr5h64bK2uXUxrnHuoBHfqy3dhFJkc4g6Tdu1avKnvjs
 VU3KbzrUtFWtN/3FyD2wS03F5QZe+njx3P5zAdactD8oY82k0ueK4bUDJRYEhV8V1wjdomEqubu
 5vU28mh/c/xGJuw4u7vEOrdwznPD401KbBouJLOu6PO1C9+MU1voOkNpBMwuYfU01hs6pndzAlO
 V053qBSctxJKmulbqQJ+vu6fDnfI9kfS68IhDQabYACM+ol48UkoTItYeAQFd7M799Xp0cpMLuD
 VsdmDEKftMP62QwlV1fcfv94YrKTShVrcAeAI/r/4QRTLpwabiFeSqF0lR/H23sD6GxQVIq5QnX
 ABhu6AVRcGN8nBFsS7rwSazjlqW+ZM4ots8zRIm1N+Z8CiuTUJ7E3srz7E60Lk5idYoBWVb/CH/
 uN5hUS4d94VIypg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

machine_set_shim allocates shim_filename via g_strdup, but
machine_finalize did not free it.

Fixes: a5bd044b1579 ("x86/loader: add -shim option")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 63baff859f3..95ddbf472b4 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1284,6 +1284,7 @@ static void machine_finalize(Object *obj)
     MachineState *ms = MACHINE(obj);
 
     machine_free_boot_config(ms);
+    g_free(ms->shim_filename);
     g_free(ms->kernel_filename);
     g_free(ms->initrd_filename);
     g_free(ms->kernel_cmdline);

-- 
2.54.0


