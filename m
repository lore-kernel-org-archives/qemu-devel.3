Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2317CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvol-0002Nd-KL; Tue, 23 Jun 2026 03:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvok-0002NR-46
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvoi-0007su-H6
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+HZdqqrd0luKP2zM9aSu8MqpsVYDB3E/9BW4+J/ZDE=;
 b=GhT4dJdPzeIWxTDfMraCD6ggsmY38+KP3ulqk3AAOIFy7j3cl3NuqrHL9NRuyuLt2aU6Wi
 4xvEljxvUV2mETwEX7c4/XwtQJaP6Qu7dNMMoaj3NWMbpToJ0q4/GDJeSRGXZSdfWTNZjE
 dadY6leGRvbbxaFqqXDgfgSx5cPRk2I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-qxnKdC2CM2idnVtqmpoKXw-1; Tue,
 23 Jun 2026 03:45:03 -0400
X-MC-Unique: qxnKdC2CM2idnVtqmpoKXw-1
X-Mimecast-MFC-AGG-ID: qxnKdC2CM2idnVtqmpoKXw_1782200702
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09F451800598; Tue, 23 Jun 2026 07:45:02 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66E7618005B6; Tue, 23 Jun 2026 07:44:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:19 +0400
Subject: [PATCH v4 04/34] scripts/lsan_suppressions: suppress fontconfig leaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-4-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjldLBAacgkr5eJY+xctiJsshyMZy58oZRETf
 tORIRCs1KSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XQAKCRDa6OEJdZac
 5YrGD/4+LXrgMxeN/sgbaHBTsjXMwKNsIolikeox8fmo3hidI7H5cS//ulvliZjcXkSr9pHm3aq
 CY+LmcdQlTfzvuQ3Bw9OhAIoRpE0uGxvEXPLLRNCpjHAD4QpNblDUpu2y+22GidR8QXw/GEM4s/
 4J7Uvb7DuK+sK13v/hDuHQkdrDD2AZcfaYR27oCcD3+MLLtKqSwfj3SSKfzB7DSPfQCtJdcVFpe
 2ofPnglI7nU/bkOr/L5Rjfcf+YgxdLTGZUhVfs6lGlrJI7KTLnhQOtkTBL3HcddXYqJealEvr3S
 u4dKf5Sfk7pEYTthKGOl5enxPIXIqGg0x2BMCRWqpB+iYmAKenlIMirIvaufQKynPytLkTaxSiW
 83Bc0JVKOnzzSWCVGVuL//F2/YneXekUNSosksbrqKb9WMKjhwpCY2MFETjV2quC9cn2U6rXBYx
 Jy5CzWR03HVOt6mxg/nlI05z527vOObHpKOQztHTSGJQ0nSLTXSSXxun5c3/7E9uiuW5Zr/Dwtr
 grGpju2V+qZOAalEBGRiJajKZXRxU4UXRFGMURZFjrchF1KRT42XSXM/LYgQHTz9kU9+ZEJKWkK
 vk00KNvs2OWgyRZrzkNUdo78fWEr2H2KrUph6XWGH4tUMoloeR12+Qsv25k+CS888b89j/jkO2f
 n0oje9ujfzcVV4g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


