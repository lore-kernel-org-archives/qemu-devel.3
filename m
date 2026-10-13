Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE0CCC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXZ-0007J9-QY; Tue, 13 Oct 2026 09:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVd-0003J5-EX
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVb-000519-G4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whgjGPadMYFR5u4wZQX0i1KivDS4KT7W++PNX4zc2Ws=;
 b=JDv8YHulzFTDmv/Qde93oFrtSTIRWcazCsonMSyS+TxYeEzdTYFPg9Vfj/g+aI3LwSQ6lY
 Yi1aaDtt9vgY/zXRzrtstGw9PkB8pdmvu/ugOsH7SF0rDwOMa0qbRs2lUXag5mBkSxIHza
 4EFDDnBSaLuqm0Rr64y/XpL+KBkZuqQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-k0Rl63nENvufbrp6XRfvwg-1; Tue,
 13 Oct 2026 13:25:33 +0000
X-MC-Unique: k0Rl63nENvufbrp6XRfvwg-1
X-Mimecast-MFC-AGG-ID: k0Rl63nENvufbrp6XRfvwg_1791897932
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D081180B5FF; Tue, 13 Oct 2026 13:25:32 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86C6A180057E; Tue, 13 Oct 2026 13:25:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:33 +0400
Subject: [GIT PULL 36/40] chardev/char-pty: free pty_name in finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-36-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=859;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QKHxzG1p9o0LxZI1pcDFO7NgHN89/wsbAZTXUnJYR58=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDERF3ml+6PcJDFOKY9CAWLR3S2NgPT/yamf
 Cb/R0YcHk+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wxAAKCRDa6OEJdZac
 5cFbEACRV+/1Dr6LgdvXno/tF8ZZJjcB5l1m8EFJO0aUFxZA3neULbM/gOxP6xv21a5QOR13jwN
 6L+//nFPQvpQMbHRlJ/xh8Wzu+qcdVrlyR26X4fq5eQpWGCvvTxiVOLwiFEVljPdJq4Q/xyYHug
 mlwZfrOSYpnE1Y8kcIBYph+jpTq1Rfd/LhwPfa6JPisTLcQUcEpcwaD+Q1JaQYAL6FTP2vJEKWo
 drAEevPWX+zHbJyANeODosZ0s9klXLQGU4GyASWSus4PHLvlmnzmsgRqgZnnjE4ZckYOoPMzVhH
 O0hhVSfq212z9/bsY1wOtSUJIMaOvk2e3SG8gfPLvn8Dv+F9FJIPQADDxmC2Nnbg1WaykqCq1Jp
 93KR7+RPLbI7RipZYmJEXb4ZAXQr+QwJRjh8FqMjRs/egvdjyjZYsl00f17tAzuGy+d6U3G5EOq
 tLJrMJRiODl5FItMUFxGJboSeylk5zNqz3FWxxka6y23Xjg4XQmA2UML06jJ8OaI68MfH4rrC1D
 ROnSilG8L/EX51m2NeFjyGrspkH2u8HMABx59YrbGP4tvfdS70l9l52Yo4Xtrn7hq/Cowakas7g
 6aHZJF+8Rk+0pZWFlqTcGNNjZhakLQmhLyWEApH3U78w0EjbS0j6prRJnb0dl4DLFSWgpF6nKAd
 SrM3kk5/yblIAYQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The pty_name field was added to PtyChardev state but never freed
on object finalize, leaking the allocated string.

Fixes: 1116f5176e7a ("chardev/char-pty: store pty_name into PtyChardev state")
Reported-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-19-ccbef537cbeb@redhat.com>
---
 chardev/char-pty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 7e95132cdbba..612607609c80 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -215,6 +215,7 @@ static void char_pty_finalize(Object *obj)
         unlink(s->path);
         g_free(s->path);
     }
+    g_clear_pointer(&s->pty_name, g_free);
 
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));

-- 
2.56.0.116.g6de20f6092dc


