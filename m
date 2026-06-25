Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801D0CDE010
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrUX-0007Eq-T8; Thu, 25 Jun 2026 17:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUV-0007AB-DF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUT-0003Y8-Ud
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZVJSLuYC67R7uydR6aDnrGkLmhgIMa9GeQ+BIvj5s8=;
 b=cMmXTJXjXMqd7J1F6dnt6bExO5we8X2bqaQa4NhCm7izg8U4ha/XGmYNfg9F4TnN38mTwy
 Lvnj4rilJnTnSnhxQ88qpjY8ADcwuxwws+nfcVgnMRiCZFalEgYc2vB+knuYcYc5Sq6DJi
 8TrmLL1vw4Yi9yB4NlnIQ5x2nVyPqmQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-moBKdVgTPvKIv5fab8AZ0Q-1; Thu,
 25 Jun 2026 17:20:02 -0400
X-MC-Unique: moBKdVgTPvKIv5fab8AZ0Q-1
X-Mimecast-MFC-AGG-ID: moBKdVgTPvKIv5fab8AZ0Q_1782422401
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EEEE186BF3F; Thu, 25 Jun 2026 21:20:01 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC83B1800370; Thu, 25 Jun 2026 21:19:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:06 +0400
Subject: [PATCH v2 05/39] target/i386: return an error for invalid CPU in
 hmp_mce()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-5-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=922;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=H8fyqVWjZ5ZUdHKFdi/uAxwk9XqORp2OV/LppjqTpm4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtcGKOJtbyurPliXIN15bNh78IFupowNsKw+
 TBbfaEeqUiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXAAKCRDa6OEJdZac
 5R1WD/9QYU0Uubnb1BlzmUTe3cbz3Ei4U2fsv2Jh2DRVkFSXSADZaKottyOff8+vcv/TUc+Wyzv
 MqGTKtvUIvQJzuu1EWLUJLqc+cW11uSi2/MttpO6EltswNhKjzyd5RImoMBDbOYrOfkeezKjIIm
 rVmGmeT0Pa1hDWSQ6MbYWhbPca2A/si1uLdJWstyun3dMzx+ruVJokdo1/aheyx+swp3QCNkaMR
 KCCTO3FN8QCgpnQz+sNomX1nDemWDRl8WJ8OsPydHWo+SrQGWS4f1xkIeSQN+GlXYOSNJZwWHJe
 Ni5gYPrf5zKshe5OMFHTT/H0SJlm0Gs04liobhAfGJ91M0poAW7dwYrPSstd2JJGdGVBTPf1bVk
 XISR1Ph7zqJiE0jMqzYNwB4485Ll40Z6petcqGEU664SED2uJy1cNmBKJW+I0noQtfcCWW2cSWo
 XEPOCb/+ckWwJhWBTcuPteISwyT+NuAxu5PG5ns3uBxbaIZb3/cUjZD9DvVLIFDE+ZKo8JRpnjG
 uWgXNprt1ZxFHo3nr+o/OHjQ1d8DArgZ98zgtIdTPoRpT64/keNmXoxP8RxG3fUq6EowD4fw48W
 2FH2EGveIzeaSolXpnceChPGHD8dXDqJGao4xl46xUYrWfAz4aq23qlTCrsidUYg++flbH9unkB
 RoqDch6PIkyF+rg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Rather than silently doing nothing.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/monitor.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 785a13dd710..9ed772e6d7f 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -586,10 +586,12 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
         flags |= MCE_INJECT_BROADCAST;
     }
     cs = qemu_get_cpu(cpu_index);
-    if (cs != NULL) {
+    if (cs) {
         cpu = X86_CPU(cs);
         cpu_x86_inject_mce(cpu, bank, status, mcg_status, addr, misc,
                            flags, &err);
-        hmp_handle_error(mon, err);
+    } else {
+        error_setg(&err, "Invalid CPU %d", cpu_index);
     }
+    hmp_handle_error(mon, err);
 }

-- 
2.54.0


