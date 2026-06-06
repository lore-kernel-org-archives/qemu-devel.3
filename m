Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EDECD6E55
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjPD-0003Kc-JM; Sat, 06 Jun 2026 01:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjP7-0002tU-1a
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjP4-0008Io-7i
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780723021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flPmDRwJi+ybUNe2kHFSb0m1RU2KLtvltS5ncicUaW0=;
 b=hraSFHqbGKe4XLlY7wJqy49L3urXE6BkBM5E+2w/dYwBvKA7kjLPqAWtsf0OsBywkno34t
 pVcPADdK7Z2PdNWQjGEMZJbKU7Jl2xSfyjtkoBgZPQCff5lAwR1XPcvzOV8aAxwynvByt5
 vtJbRWCRKOHbyh2xbfNETvXR+1+iRG8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-fmVqxIflOKe5IAeR6YQBaQ-1; Sat,
 06 Jun 2026 01:17:00 -0400
X-MC-Unique: fmVqxIflOKe5IAeR6YQBaQ-1
X-Mimecast-MFC-AGG-ID: fmVqxIflOKe5IAeR6YQBaQ_1780723019
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 620F4180047F
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:16:59 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F33BD195608E; Sat,  6 Jun 2026 05:16:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:47 +0400
Subject: [GIT PULL v2 15/23] hw/i386/nitro_enclave: add instance finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-15-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3C7niU2OJQvZnNEzM2kL0E6yy2/Uxqq6Etx4xtM0Tsk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z1C+1pKyOiXXPxo684kcaeIwB11g/4Y7f48
 5/qr3V6W2eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9QAKCRDa6OEJdZac
 5aLeD/9+cvTDiRpLG0EFgOnzbBGHC6wsVrowTQ8kziakYf6BP4xJLSQlIAZyjFubgO6r94Jnugb
 2MGtCofWZMXgfkoqbd5M9LDVmwhfdYufWoyBbFC+pbVL3pQAFNyjNjcVvfJB5XCfOYaNAF8QvL7
 i9jV39Ek8iXpQPJFqmi2kjcyZ39yfJqIbpqJQCdPEQ9k6uQvcxbw0UdOSHVxBWoVKWuD21wwRTU
 6EcfBZWsYnX2dLj7GtFtpTuItVHAawOdvLTDeaJ7zH+K2n4Z6GfcXeusel4MKuibkGqlMBRCzQu
 +mF8lL3Zjig6p4hg/8EaOZMiSk2DyQYfRpaNSPl6VAmbcCIsL+UXtfm5YDZgsdwD3tlL3flmuMn
 Ee0akGpIibD3zfLsLP9g/jfFz07h6I5Qs96tYcU26zM1VwvygUfitqL/pNeiwO7iiL+u1J1sndi
 kBZBeAhYXRcHoMAc3oGsYEedFbbfho7gA0gptqfJVuU9jIZM562d/0O44jsi4Jj6v2chuFKlJnc
 vIcLTsS1jmdh1+RNq0Xjy2PTSGK/ZRfiIAQyqKODqVTDVzzrImhV1Vf/rGKxbvyW4rpKKeiHMoL
 eTbetPUuPWHqqjOy/RBpSvTwZ6jtKeKkFZst/KwMTFXG60cO9aGY63IRITdMKaBwHeRRX4UeP+m
 5FrcAzp5mb+8gVQ==
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

Property setter strings (vsock, id, parent_role, parent_id) were
never freed because nitro_enclave_machine_info had no
instance_finalize.

Fixes: f1826463d2e8 ("machine/nitro-enclave: New machine type for AWS Nitro Enclaves")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/nitro_enclave.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index a29f0044d0e..1ce9ee3358a 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -337,11 +337,22 @@ static void nitro_enclave_class_init(ObjectClass *oc, const void *data)
                                           "Set parent instance identifier");
 }
 
+static void nitro_enclave_machine_finalize(Object *obj)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    g_free(nems->vsock);
+    g_free(nems->id);
+    g_free(nems->parent_role);
+    g_free(nems->parent_id);
+}
+
 static const TypeInfo nitro_enclave_machine_info = {
     .name          = TYPE_NITRO_ENCLAVE_MACHINE,
     .parent        = TYPE_MICROVM_MACHINE,
     .instance_size = sizeof(NitroEnclaveMachineState),
     .instance_init = nitro_enclave_machine_initfn,
+    .instance_finalize = nitro_enclave_machine_finalize,
     .class_size    = sizeof(NitroEnclaveMachineClass),
     .class_init    = nitro_enclave_class_init,
 };

-- 
2.54.0


