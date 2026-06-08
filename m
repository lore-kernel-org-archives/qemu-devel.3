Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBB0CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUFK-000868-Em; Mon, 08 Jun 2026 03:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUF4-0007pF-MS
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUF2-0008TL-Gz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgSJ8GIemylwK2Rz+k6Wvgj6TCAI6JvDZRNWAtchu4s=;
 b=UEmZtmdf/Rt3fcCc2OebW3iFmONOVJPBZxpA5EYs9bieYGG9gj0suNc0BpucO/ncLHivXc
 QlzvtsPKIa73jUVmH93DGgB1Tty8EVHA7AskwPBX3Zn3BZtYdmo7Ml6Zu2tVMttca9Bj2u
 atOW0infJlg4ImTBmVbQYSkatrLY4x8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-fuzRg2jhPRynf6RY5w7CDA-1; Mon,
 08 Jun 2026 03:17:45 -0400
X-MC-Unique: fuzRg2jhPRynf6RY5w7CDA-1
X-Mimecast-MFC-AGG-ID: fuzRg2jhPRynf6RY5w7CDA_1780903064
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15A491800345; Mon,  8 Jun 2026 07:17:44 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23C571956053; Mon,  8 Jun 2026 07:17:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:30 +0400
Subject: [PATCH v2 12/33] ui/spice: remove dead spice_displays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-12-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=868;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=s60ojf6CttJ409AzZo9Cfg75xyybBgiiGTPP9biqSiE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxJtMddbFtvMBcz5i0aSR7i1UPwzOGhU0iL8
 /ObzSlwFN+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSQAKCRDa6OEJdZac
 5fIqD/95/+eMS1qvN+1hGlKVLkDHDemWTf7LSKlp/53zld8rxbMPhlc/eUO99Bg38r0EuZ4srHx
 woGWiRFl7Y6AF14vJCZGfr1lHJlMy+Ubz0/AOJ5sev4gORwGc3Oec5uCHSwhXHKiaLOUfzD6i76
 o0nknwiiUfud0QfdPZ9rqCp45+/xqEVQy1BWKz+R5fJLNkOwg1pfNPHAKhVZ8nAu+5yHuwlsjWk
 k8mFhwCy8ZtuZMfy90Zzr2eQo0ZI+WJZlDInl1S61JY7Is3Vj2UW21aaPJDyRc6CzXvxF3+1uXu
 wP+i7fIzvBdCRsmp3/tfa8Apb1rfmyBw5ExQXIcy+Jx/r7UqHNlhRQZzTDBOgs8AsfbSULb2xlF
 O4naioy4fnlA4CdKescqbCeFocnnDaagMQzJUBmsfJHpBLo/seqP/4XLpN2opc+8tGI4H7BUhqf
 7BpvORHdj8XSpaDmE42Uigik8HHjWNM+0SAfXWLjpZvE6njkceUT1sgx52bsiTlwiFuKXfcSfEh
 t74BALXc4tsj69zIJerWyDJ2NWE9K0XuzJW8z7JV25vxHrIy2CxuDjhMP8JCj88YC7fj1UmZJDv
 4E+1IZWirtKf5XMayhwChv0cgKv5fHMunCWsOnobh5cZ88jG2OMiPCF2TXW4V7fLKFdtsVSsH7r
 5mtnInrBiQ18Chg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This is left-over from commit 9fa032866da ("spice: fix multihead support")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/qemu-spice.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 111a09ceca3..59a68cd9833 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -33,13 +33,6 @@ bool qemu_spice_have_display_interface(QemuConsole *con);
 int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con);
 int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
                             const char *subject);
-
-#else  /* CONFIG_SPICE */
-
-#include "qemu/error-report.h"
-
-#define spice_displays 0
-
 #endif /* CONFIG_SPICE */
 
 static inline bool qemu_using_spice(Error **errp)

-- 
2.54.0


