Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A68C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvK5-0005Mu-GV; Fri, 28 Aug 2026 08:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvK4-0005Ma-D3
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvK2-0001gX-TH
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHUWUIlV1L88EuNWpXBRzIO9zHPWAXRW9+Hdx8pgeCk=;
 b=ZsGY7wxh0E7iUiTN4g04feHqqV9QQF1oAbe+wnZfhuMK8zmKqwPlD3adyG+TY3AZO7vZ5m
 DlkNz8jeW9GbLhE+Sw3lwfk4MQMZ3ZaakJgTeDefNDifXOt+VUu6IFP5CZquHewA+giuog
 CliwXejVWo0Bs6NXYesoqc7VMBE2CAU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-EI39d_ABPSuCDcsdwX4lFw-1; Fri,
 28 Aug 2026 08:04:34 -0400
X-MC-Unique: EI39d_ABPSuCDcsdwX4lFw-1
X-Mimecast-MFC-AGG-ID: EI39d_ABPSuCDcsdwX4lFw_1787918673
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 424F5190A086; Fri, 28 Aug 2026 12:04:33 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C9C57DB; Fri, 28 Aug 2026 12:04:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:03:59 +0400
Subject: [PATCH v5 02/50] vl: fix -monitor none prefix matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-2-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3iiRReSd94lLGBmuGE+7JzjtOZA9/s2KBjEkNLxXG5k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk4n5v7TJU7Hl/U4rEQmt5a0oR3C2rygvUlY
 v8CbJmmCDyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5ceIEACBu9h37zXXPRu0mtUP/J7sDS4NTruupcui2hB8ZqNza6zdzYrkMsKdDImNIEyramoaX1a
 k5SWby5uq2++XUIcRF5NhpO365L3rnGx2xT5j2UYa4maghhddKT1h8PJQDj4FKA8flj74jyzhCC
 apWftADMcfAN9kBzw5uE53XIBs7NkiOMdylAxzB77nF2K+9s9bGIax5+uKLVoodMjaqpU8UhWV7
 alDlGZBituedNErmKFw00QW9pNBfhfORvuppV/P2N6kIMmfFwVfureBhv3hbubaJD82UycgPAi8
 YJYZ9/gdilel+zzPyfzdA+tYdR1QS/RikUWUHTZdkh2TuId1PiUJbZ7551Kdx8oxzm7MEFc3FCp
 sj2xYKtozljj0AjtClVJ9L/dEBLsI/uiou9nVc4mvad9lIUgQ+cp26ZvK3PZrLZYddPh1HJm9t1
 Ul+FB6xmWtpVKb4gnahV4C/tR4MIC3x6V+UPOQc8fQWuUH7Xc5Y9HJFZuWYtX10dsQxf5sUKpL2
 CWegMvGY0NJfe/psyoyhnyydV/y30PNnqrlj1h+EzFxhMfZoh8h36U4QZt2YU9PQI0qhPNuZZfp
 vP2CA3kNJGPFoZCtqT2UzAmVOSMa1KaSCtSQrrcbtLZR9hotVxp4xTs+6/E1HnxQP4D3cDK8qSK
 jJVmdQr+6Uh23dA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Use g_strcmp0() for exact match instead of strncmp() which would
incorrectly treat any string starting with "none" as disabling
the monitor.

Fixes: 70e098af88f ("monitor: allow to disable the default monitor")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 061cbdf860bf..5ccc19282ba2 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3226,7 +3226,7 @@ void qemu_init(int argc, char **argv)
                 }
             case QEMU_OPTION_monitor:
                 default_monitor = 0;
-                if (strncmp(optarg, "none", 4)) {
+                if (g_strcmp0(optarg, "none")) {
                     monitor_parse(optarg, "readline", false);
                 }
                 break;

-- 
2.55.0.543.g5ebe2ebe4ea8


