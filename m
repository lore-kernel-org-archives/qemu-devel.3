Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAD8CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbKR-00006i-86; Thu, 11 Jun 2026 05:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKP-00006B-BC
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKN-0004Te-UR
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dl3afpPZ5Vol+WdiE3UW2bUQGBhPNSG8m6dmBjmprSc=;
 b=dFANiiP/LLDgM3sR1U6ktXZvjWxBH+JHATJl+rUEhBb0ApNuEGPvNXBp6u0hVK+eiu1xWR
 GJqzNBVOn6C+dNekGay6ehhQDhORK2rZArSOZ4J3tzCEhiZrJPKY/iMRtp2jGcBzqlnd/D
 Ld9F0ibe9RI5fUKrpKFyVXYqOSD0k7o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-Py1wVDQLPaiciuuJ_df3-A-1; Thu,
 11 Jun 2026 05:03:51 -0400
X-MC-Unique: Py1wVDQLPaiciuuJ_df3-A-1
X-Mimecast-MFC-AGG-ID: Py1wVDQLPaiciuuJ_df3-A_1781168629
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 554351955E7D; Thu, 11 Jun 2026 09:03:49 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A68B7180029C; Thu, 11 Jun 2026 09:03:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:17 +0400
Subject: [PATCH v3 02/35] build-sys: build with -fno-omit-frame-pointer
 with ASAN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-2-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=836;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6MUlQar/gSPmID3QiOuS0gGUGfBPIRS3cXVDlzKv9Pc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnncRQmnB13J0B0TKJjEVpdy9CFl3jiwhMzG/
 5ZsAJ/xahuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53AAKCRDa6OEJdZac
 5RtoD/9kcLstQMdLK1GEbX+78+4CKTMD5cHjnV/XgEaWNiXWJk7GBVT4eVDNT9IHf+aFpEIFW/e
 cJie/VX/tax3U2gmVE7LUTPa/OSa5EQ5cOhrTtJraw80btD+vsE3jTGrqKaz25a7H+F+a25/Kwg
 E91iG7K5o2E++zG3Xup07TOyZk7dG+4M7QGQo3Ie7sOMNw1GGCVSjSiQuUAZakHsu27OcsGU9K4
 3bnPRxM7nvaApV/VKsr1mXww1Ok6N0duBh9SOWk6HOxpkxxo7BoIqwHYBvYb/T8MOkQg++Ra7MG
 N9rynQd/sFN7ZJS9J05r/bXvWC4QnvOK8DTtqxX5cldcq3LrMJZgezgyeBdKOLn6o/5NKPeq9l5
 N/Y7aB8rf1bIdQx2VkDi8kYlS4V++pNv2nG3bvtXtPb/xRMLVGTQGBoHnyV78otFdiP42gGDp+2
 ltJpyooCPoJA+sEgF8NjTESmeL4/O8xacI70ooIyC5tysa4bCeQCOD1aQ/wASG4F3xSttm/Rmtq
 4qfH8zO2ingTrI9OEXLG+BljfZ/ShW7Vj/1ZOrVD8e7nlSfePT3EGMfwkC7+99xdBxhUHXMBwlj
 AtFgqrqg6VrJjELDlg1SzWKS/3oyCD9GxPq+h+Kk3LlvAwR+hoXJmwUm2Kp160qJPyZSl5d92sc
 N3V8e1IaufpuQug==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On fc44, LSan fails to suppress leak:qemu_irq_intercept_in, because
the backtrace isn't deep enough.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 19e123423b5..3711483b95e 100644
--- a/meson.build
+++ b/meson.build
@@ -545,6 +545,8 @@ if get_option('asan')
   if cc.has_argument('-fsanitize=address')
     qemu_cflags = ['-fsanitize=address'] + qemu_cflags
     qemu_ldflags = ['-fsanitize=address'] + qemu_ldflags
+    # Ensure complete stack traces for LSan suppressions to match correctly.
+    qemu_cflags += ['-fno-omit-frame-pointer']
   else
     error('Your compiler does not support -fsanitize=address')
   endif

-- 
2.54.0


