Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D68BCD98D4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbKe-0000C8-93; Thu, 11 Jun 2026 05:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKd-0000Bg-14
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKY-0004bS-G3
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+HZdqqrd0luKP2zM9aSu8MqpsVYDB3E/9BW4+J/ZDE=;
 b=gDk66Mu1t3Ndkjli2mFoiKhRBoCumO7m001ueNh3OV6NdmHgjvcSWKe7KbTEDzPElj+U3j
 wRKePFO64d0xvxVTTMKwaygKqjFzHBnm/VUmGBUCkpPs8JKS0uf+6TfPPbj0XRC9xRBrKs
 mTCrherWvH3qP4UwID/K2UIyv3Qvsgo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-8QUC_fXiMGS3BfIOu83P3g-1; Thu,
 11 Jun 2026 05:04:02 -0400
X-MC-Unique: 8QUC_fXiMGS3BfIOu83P3g-1
X-Mimecast-MFC-AGG-ID: 8QUC_fXiMGS3BfIOu83P3g_1781168641
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCFBA1956064; Thu, 11 Jun 2026 09:04:00 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81A861954B0D; Thu, 11 Jun 2026 09:03:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:19 +0400
Subject: [PATCH v3 04/35] scripts/lsan_suppressions: suppress fontconfig leaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-4-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=898;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wrh0d0W1JMMRcWG4uHoQU8DwdCsMZB8Ib76jiTAFaYU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnnddhP/U7iHrrxlMy6Umd4tz6l49LfJERww4
 upMRbKPDHOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53QAKCRDa6OEJdZac
 5SuqD/oDn6OinbCwq+QW+dX7iRQjtwLXRIg28Ng4ZYuGBCkzNE39VgYKHHLP6TAoJJ8qFg0EBhw
 1XWiBtwlLDjQuIFpE0XmnGGwUhkNfy9Z3DmiC3GZTwCmz89KWzwt1etIseWTWZ9f1yyIT5qZzDM
 SwNL5ucicTou7ZQQFm+mcNZrsaY5Odwk/glyMlqFqwrgEQ2ZvsFPGx9jUoOW5q0YwZ4WOqpK0GE
 dDi78rBrQaXldxLwvXQt3E4hKM9c+jtLSHSKCo/ugP7ywAMC8V4pI/3wLWJ9a/MotFP37cCrgQ9
 WzNGrN4pLpUGrvTgdYBCsRu1k7btiex81HRq2Mw5pghGrLZyDDebjHrXmG1B3C2UKzsaEEVD8WO
 a9Mmm+lAwu4ESCIWksUdadieTXBcnt+IFZ+SUcyXkry7I+CR+6jUBToU9AUlBIDsO7svpAyqNBt
 /Lu51iYXxXvvvrhSjaAsaRZI1sqvvVo20kyzfn+OUp1cysqCKrPU294mbHb1i7yc9xfqW85WgbC
 LoMWgsjYO9SeQuYYwb3zPnI6v8L20F4bfMtnnv2Tt9/9rHOM8lDHZznwZ1Q0ISHedWnUiwgRNq7
 G0vPMlvMQBBHH62s5qugDP9Q30vVsrhBPQT0CUhQqPzQI9scy+g7yuRjNSy1a9GXpDnfshD4rRz
 KUbbbwVe7GUDGGQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Those are annoying reports for gtk/sdl etc.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/lsan_suppressions.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
index 30256bc6d01..f3b827facff 100644
--- a/scripts/lsan_suppressions.txt
+++ b/scripts/lsan_suppressions.txt
@@ -10,6 +10,10 @@ leak:/lib64/libtcmalloc_minimal.so.4
 # libxkbcommon also leaks in qemu-keymap
 leak:/lib64/libxkbcommon.so.0
 
+# libfontconfig leaks are notorious, for ex
+# https://gitlab.freedesktop.org/fontconfig/fontconfig/-/work_items/519
+leak:libfontconfig.so
+
 # g_set_user_dirs() deliberately leaks the previous cached g_get_user_*
 # values. This is documented in upstream glib's valgrind-format
 # suppression file:

-- 
2.54.0


