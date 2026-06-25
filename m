Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B73CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrUC-00074L-7R; Thu, 25 Jun 2026 17:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUA-00073s-88
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrU8-0003Ec-RX
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9lPklvICYk46kVZkC0HSwMbSWR8J8MLaRWbDX9bXA3I=;
 b=JtTkXZYfIhim5cYV59oskMEQKrk49fTjKSbIu0/SDogr6NbM4HICzCm2A+Hw9sobp/VqLU
 AaGbT8k9XOMU33v7QxjyI3fCpHfc21S06Bz4AcnrApIIplatQYPlMj56ykN0ieNpblO8nz
 Zw8BGQucGyeVfy5G8WlyHwwQ+KEiXfk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-Dm3JqVaxMxmYYtOcvdSxlA-1; Thu,
 25 Jun 2026 17:19:42 -0400
X-MC-Unique: Dm3JqVaxMxmYYtOcvdSxlA-1
X-Mimecast-MFC-AGG-ID: Dm3JqVaxMxmYYtOcvdSxlA_1782422381
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA0F9180123C; Thu, 25 Jun 2026 21:19:40 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 650B430001BE; Thu, 25 Jun 2026 21:19:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:02 +0400
Subject: [PATCH v2 01/39] vl: fix -monitor none prefix matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-1-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=861;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4usgVJ9P7SKQwWT543/6Z9zcURG29yQ9Ga9Ctlbj7b8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtc8NUExapB9DEEIqlvUwWMs5snCsRnPF8Ue
 pqUzh43J8qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXAAKCRDa6OEJdZac
 5QUlEACEY61v/hZTAkhqqwcr0AosfkdmkSqFynF3R0E7OILya3/Kr/5Eh4e6mJYcX1gFDUVA1Zr
 qqBiis04oATpq264iedvFplYF9TK1H3b4ukvgTyRFDKinQMn3RZ1Suottp0IFHCDgFffsDPGuGU
 YLnoybCVPPnN/6SzSn7Qj76gz+lQAy+2zkHYGkbmm1oKFHMS78cpKN09gQqhjyoVLds8CyX2+so
 GmlxsAZv95HanBNsEvT/WkSGVRomV/QjGIcIJkpBR2z3r0zkANp1kUOH8SKId5vsb6/jzIo/XQX
 NnQn+puBVaS/cfKA68gz/rJnLthxViGNeuKkpNOFLG9yuZpcmbWPmHDPkraVZEiYBuvnK1GNG1/
 6iql982Z0tyclYaSGmogb85KantHW1E/nx2Z2OF2/BhfTf2F0MS3NxVLaqxrEiu9wioKhundROM
 Twk+oClXwg6W8TjEAbUNiFbfgxjzgzDST6mxIYe87oIl1jwVg5OCrnXRWjnpTc0gDSHfm6rxU/n
 yY3RRCgxuuoeWhH5lwVuxoPV9iQDIdkFlFPdZCEXHdEPZrpFZhoaSDVCwUlegYVPeoor689+Vvb
 UYBsnzCU+owZ/pXIz697dUK5GUVJzGXriHX0U/gcVuPMgt+GxESWrD4J8JUVa9R8eLEG3sgLf04
 ge5R3Q9CN/lyIkg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
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

Use g_strcmp0() for exact match instead of strncmp() which would
incorrectly treat any string starting with "none" as disabling
the monitor.

Fixes: 70e098af88f ("monitor: allow to disable the default monitor")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 1c0da7df293..dd7fe828118 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3221,7 +3221,7 @@ void qemu_init(int argc, char **argv)
                 }
             case QEMU_OPTION_monitor:
                 default_monitor = 0;
-                if (strncmp(optarg, "none", 4)) {
+                if (g_strcmp0(optarg, "none")) {
                     monitor_parse(optarg, "readline", false);
                 }
                 break;

-- 
2.54.0


