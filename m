Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B107CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9xC-0007Xn-8D; Sat, 16 May 2026 04:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9x9-0007Es-Vo
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9x8-0007kU-8V
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dJKu4geQlHBf6lMxppaNvhNAzdufK74d/8yyA8VcsE=;
 b=MS0VfWpB4v+Kc6JIU5bgBTb2nxq3yW6Bf+iTw0t6zB+kbZzZUw8KwOAx/X+c3qhF6UTGVh
 HyVaB4acZoxaK1ELWxWWUZry1Ocn4zWIRDM68YZ6RnQLJWzs0ryyx0JrCrYdA9V+8FfJZy
 rZXC81bSfXZR4aHp5UHKTDRRBJ3RH8A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-cA0GX_VZNim7EJTBbS2jwA-1; Sat,
 16 May 2026 04:00:51 -0400
X-MC-Unique: cA0GX_VZNim7EJTBbS2jwA-1
X-Mimecast-MFC-AGG-ID: cA0GX_VZNim7EJTBbS2jwA_1778918450
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FD561800344
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:00:50 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 263F9180075D; Sat, 16 May 2026 08:00:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:15 +0400
Subject: [PATCH v3 16/24] hw/i386/nitro_enclave: add instance finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-16-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tbNjVBuNQT1J/I99CQO+THdkJr89PRbTP6A2UGBoPgI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPP79zOW1ciGncU8WIwmLvlEl1cIEioq7QzD
 nP3+t2um5+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5YeTEACZdLcwoRhgG2vOzcP3rLROimTjjsFmCG0T6AupTyeTxsj/rFDVfr7kwD52AovpfOi2XTW
 +F0Ys/0vF56lh7WAEDPAvJCvRzhO04MtHBTuPG7P2b21uJqMsl8XCjz15U7rit5wiAqjEAP7DS3
 leV5m8pKBlRuRhAGCeI5pZKmwugdDG1XHkXOUzrFzBayAwjxg6hnOpaceSSWEndBp8ij3pGAb3z
 JXRA93eypixPhkOcAtX9S0Rx5KRCLA6VRgurGtk5kixwucS3nHjQ0/cybNOx0Pm1KRCVnQlgxIk
 EOPy/PUlxI8O8F+LtXmiyx+comNJs2gzqDdYn9XDYakA6mfre97w48WEv3FIN/1KZb5mJBsUGyZ
 qKnhZ637WvV0LQDrfuVsDPQ5Tfuf85xBBqsX+CM2t6mE+dT07TFa68QI0Z2PhMBU6NhCHgp5Yew
 aR4pa4Z5VHYnrqPrbQlXf395Ub09fpA/pAhL9Rd0C8+X+TFVIWPlJPsacdNhYclUT/MSPYSX/lN
 S1e/WKCunwquh22l+3HVBuIrb3HrS8xR8enBd6EidbyKMz/NXtA7HltYBRJcDz4gx59DahX6xPI
 YdqSRBkpiJ2U0Mfu1hwyeBdKqKfEbONu1H/LEuoKR0uUZKHupfEEqXW6UqdrfIH6XXcRW4VpqZw
 3suPoiNT3bdmdzg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


