Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A109ACD8C81
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWk7-00061n-6X; Fri, 05 Jun 2026 11:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWju-0005fO-DF
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjn-0006LU-GH
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKv7uKXevO2mwOyC4qHpjh1F8G+LrZIXjRyqb5hTmN0=;
 b=Bx7vInIZrsgR949VcC6lfh7kRpaW8ljxHa6/+MnNPmMfe/6IdbBrd9afVPO89ahkG9mxbG
 4+J3ZeZM5GKhgyGgHHXuY4+xF30myiFX3dBZafblmPRTTMsZ+ynhWEf3Ri/qCmzEIFKKXF
 0jHTEXhkfQrYGo7fNNrKD7Ql9BG5KVQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-zTZhdmQcPKK22DDvcjLlNw-1; Fri,
 05 Jun 2026 11:45:26 -0400
X-MC-Unique: zTZhdmQcPKK22DDvcjLlNw-1
X-Mimecast-MFC-AGG-ID: zTZhdmQcPKK22DDvcjLlNw_1780674326
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9A8718002C8
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:45:25 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C40753000210; Fri,  5 Jun 2026 15:45:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:31 +0400
Subject: [GIT PULL 11/23] hw/core/machine: free shim_filename on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-11-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=774;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=K+iwOApmpEnOaMk0KH5HYUgH1BE9LXcBH+NmGOZb1Go=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7VxxaP19nb14e9z3igFexmBc/xWBBDoeD2a
 B8Uf1+H90iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1QAKCRDa6OEJdZac
 5b5dD/4ggTuIzstLEcFskcsbuJOienyWnGfwScDw13A0qEPP9ueQQtTwexp87f5Zf99E02awMtv
 HxrZAW43s2t5PbV37/aHCyXrnI5cF5uEsdriiCH2CW26wqb6rL4W4F0V8PC6UubaWKCxZ4K0p8v
 gpUqvZm4nPD03cVhTggDMJ5WPghbkhOUf33lP7c25JvICrzBR+JEdCnoodzhGhofL5RFLhQQHN/
 RsO5mMc/1sL+lhcwAcjQ0V7QJ4ItCAB0Opt7e0MTsLaMf6L0pbLFRwyOpvQFVt9v4De4d+dLJ03
 pvuW7RbLzhv6YL8Upid21TeKIefKVzkCNEvn1fwoXb+99plMZUfyw4zHU5rwRgbdU7kkpvjR2TX
 nVkrKNEVJH1eoZSq5Zy/jgnQgMdOUvlqwix4ncdjKVMl6KqCFRm5W0/NrewlMqfPylUzZsIZ6JZ
 2lZt2ma6NQlwX68LFaWGve//TQWeM0KrWhgntapP5lo1rvRsxaiNKZaYKzlGnruuegJibqAu+pk
 95YPbOdKbPNDMdwHUTiVPWtI4y+m6/AvaLaLyC/rpMlcjRTeSroDNpEkElb1JC8aNgj+/0+JXgG
 OjZZo3fmrET0Giu5wkYPWHr8251cK5L7yZGvv7ZW4L7ttgIVhiM63J/9LSIxas31qzfFbQih6u3
 DXz5N7LV/qVfKJA==
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

machine_set_shim allocates shim_filename via g_strdup, but
machine_finalize did not free it.

Fixes: a5bd044b1579 ("x86/loader: add -shim option")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 17970b78b65..4d8b15d99e9 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1286,6 +1286,7 @@ static void machine_finalize(Object *obj)
     MachineState *ms = MACHINE(obj);
 
     machine_free_boot_config(ms);
+    g_free(ms->shim_filename);
     g_free(ms->kernel_filename);
     g_free(ms->initrd_filename);
     g_free(ms->kernel_cmdline);

-- 
2.54.0


