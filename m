Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69779C5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHsQ-00087h-Vb; Tue, 18 Aug 2026 07:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHsP-00082Y-3s
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHsM-0006r2-Hr
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8eiDleDtfrhAgkertOjCf3whXAGLIviACpGTa46lzg=;
 b=GUbx4MW9O6/YK751EtlAKdTSGuVmEmzhEygruClvRRpPHtmWGwGL+S+sLFy53H7SlGSB13
 bfu2iVY8u8wbTP8k246AvwdML9RlPE2vL7l9hKzPqFOPbSLWzaxpe8n/L30JLM5sH/u/Un
 eTeCYpP1LDK8Z6B8ABS2zAuCKpxYIFE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-Ura1zaYuOe2bIq2ByB5IXA-1; Tue,
 18 Aug 2026 07:20:58 -0400
X-MC-Unique: Ura1zaYuOe2bIq2ByB5IXA-1
X-Mimecast-MFC-AGG-ID: Ura1zaYuOe2bIq2ByB5IXA_1787052057
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8248C1800876; Tue, 18 Aug 2026 11:20:57 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC0DA3000239; Tue, 18 Aug 2026 11:20:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:00 +0400
Subject: [PATCH v3 33/74] accel/tcg: fix "tb-size" property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-33-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=915;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=r7jOmDM2VfKk4c7CwaQ+PlJRgw9qCSE15EwVLQ1TMuE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD25Q4pW8nt8zaG+gYoKqelk1XnPAWTyng9Ac
 h9FNWL9LWeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uQAKCRDa6OEJdZac
 5feWD/9t7gx2BowdvKHH2Kwjro0NpFzvHK4a0FtiFaHP9LVhs3/+N386onWPLOnGiwtkP38Ui6m
 UKzSBTc86p0Tvyeq1iUcZG/RGNN1vWwFmk9vHr85mCnHTmX/0jLuZ9mTj0Anm042zEQT7YLxBMm
 j2Fw7rWWFVyW7PBQUebyPfggRgAUb4abEd13TRMKvmg5Z8vpyHIax/5iv28g2BWNfDK276gywg0
 8yA1rJbVRWp1Ln5OdADM/D41SrmGGXq2UOFWUP9ODbn+tNMOS+MNeHmHOaudTonQXHZkPf0yrWo
 c1Wac7nGVJJ5ev5XWaIYrbNvH9AsPI2BEnoSNyALQZq8w2nqnToAbFEneydN2TlBzzqN7AL0UsR
 ffF8ILFjvPGzf6/KNEjPAFp+CWhJgiAxA7ulcPNwmYMB+i3xXVNys5QDIyWs5YRqTIr9mk/B3xG
 sj6SsmvnXX+x/stLicmtHRHekADdybbni4EwzQW7Zj9AJ8p+5YxnXrkXWnGRF6EvGHztpmq7zuB
 EqWp2njgvKcoXvG8lQVdaTlBmkW1yKKkDrmJedsr9FYsvLkNu/GBreXeg2ZcfA5DUCLe3+lCc+R
 GAjKEBiNSnY+1ILUP5UJ/C4jZ23341nQ06Qzd63FtNWZcFTraFfcfSx8q5jIjksPbeqZCorvqPz
 p9HKtpebyW37zZA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

The getter and setter use visit_type_uint32, not visit_type_int.

Fixes: fe174132478b ("tcg: add "-accel tcg,tb-size" and deprecate "-tb-size"")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/tcg/tcg-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 7186c10cf022..767e8805552f 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -270,7 +270,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
                                   tcg_get_thread,
                                   tcg_set_thread);
 
-    object_class_property_add(oc, "tb-size", "int",
+    object_class_property_add(oc, "tb-size", "uint32",
         tcg_get_tb_size, tcg_set_tb_size,
         NULL, NULL);
     object_class_property_set_description(oc, "tb-size",

-- 
2.55.0.543.g5ebe2ebe4ea8


