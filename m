Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6631F46C46
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9knG-0005NS-EE; Mon, 06 Apr 2026 10:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9knE-0005Jz-SA
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9knD-0005HH-4r
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775485146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANIkrkW9qLCUsv+omUO8K8xqyF/8AkJPe/ZW6RWrjNo=;
 b=cspm+AxxAqbaLast4VyyHpXONY/8i283PAg4WfCA73GsJm+UiO2HKLjnlaBRpc87cGuSE/
 x48KoGFosKDA8t6dDryVnHXY03Q+3hqBydKHXLwoHDYMBfR9W39W/N6vVSovE837YW0cm6
 kWjgOIl9yCLU9+hpi81OK7f5iFW8Hes=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-BBBJCLqCPbeH-YIYzinuIg-1; Mon, 06 Apr 2026 10:19:05 -0400
X-MC-Unique: BBBJCLqCPbeH-YIYzinuIg-1
X-Mimecast-MFC-AGG-ID: BBBJCLqCPbeH-YIYzinuIg_1775485144
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b24cd2e2b3so43257785ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775485144; x=1776089944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANIkrkW9qLCUsv+omUO8K8xqyF/8AkJPe/ZW6RWrjNo=;
 b=A91zq6QmNV5g7xguHaAViu03u439ncBfVSXePe0LG9yG/TwuPEWYRRKWGjlRevo600
 vRFOsz5/z+SUCC/maPlt3ubMFlhLUVZ49wQtOYhcNnmo/pw129H1BkfSZZIL+WcOFEx0
 aX3SHocDuEpn7QcaTq4+Q7KN8B/gFgYUhB8V2di88GMl6c8F8GOxE1fM7XrXfoM9G20z
 VDn/gJ08JsBP7lmPuZntvETDxNJrw1cIvyAM76azPtcGrJKh350bVOutFLGKHGxXO+/6
 I2fc17rGiL/9cbXyoZiocr/K+jrDMVlCWsm4GNc5IQ3HrDSyTeiOfVXXKl3qwecgIF8R
 JeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485144; x=1776089944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ANIkrkW9qLCUsv+omUO8K8xqyF/8AkJPe/ZW6RWrjNo=;
 b=hTyn7YiSKUT6PYPHn5GLKMEFvu4d+IREtD70vW1rFr9WGpAXMyER8z1Kl9humELuB4
 6c8ehin0hHqds5KMPx5s5AZh8yh9IQ/NWmtnyWGKDVGzWsTTQj/4p12YmlOf7+/Ak5LP
 0gMtA4VemBI+pfchpgMJIS/wvBZq40plcEcvDZNCP/pFIkezseuXSpMHUd4QjxzjtrOz
 pI3LKHmVnG3FG8l7ZIxfAS0SnB02QQzjapuYJm6jy9BTSdEQjznD4Wd/3wXdAHcL6P0w
 f/InYNEYE+E7FvI0P3srQ4nSqqHGuKqETlQcrAKqSU193kfA+IFYKdFxsiI4MxBm5kPZ
 7xRw==
X-Gm-Message-State: AOJu0YyBzjy1RnuPOJ3O13hrdZoWoPdqcSbohEDYrSDjzk3fKjnwGeUA
 A6+V5p8v4FOJapSff35aruABOJjOSNWzc3MFIAdZbFKEl6TnrB2vWzHWCQyqhhyG2lWfFm6oUza
 2dYhzrdLqwgkqTpMrrZsCuiPYkFc5v1+nAPwB3U3EqtvNE/nb+zAu7eHanfkI6Wh6VbOMcNZ5EK
 KWnw4frqZ7WZ3a/3As5McNBQ7inlQ7Rh2xdeZcWxM=
X-Gm-Gg: AeBDiev64axyZ9IiTZS2mV3CDz+2B62i2dictbYva2kCrbqKk6Ze7iGbC7gkUjsO3Fl
 cdqXoCyurny6RddgDfusDPeLENpyz5CBfjG60pVQ56G7YmSSKdMKIDQSh/HIvsi48Sfbf79qVI9
 aO80CEWDZZdy1z0WCLX4CwQ0EF8Zt+fTWoolerXy40ad1GexcKM6pEVihiklHkZ0+m/p80DFomI
 cOyhNtB5dZGcFz3lDO3b43Rw0aI8vFDoM9GoebXk7ox5OqzG1G4PWmp5VFO1X7pU93rB3imw2fU
 w8gdgkaBhJaSqct4zrONRkDAA1tOAYiebF/vZhQECQHu8c89CRzrNUPUmpHFcHtzhtP3a0Uz3U8
 NvQygCXDqjIndOM83Vr82Ug9lnpGNcisZmov00jBhWPOi6uCsz7GZSMS2VB+K+HrkLpE=
X-Received: by 2002:a17:902:c14b:b0:2b0:b075:f2fb with SMTP id
 d9443c01a7336-2b281855cbcmr96500135ad.35.1775485144093; 
 Mon, 06 Apr 2026 07:19:04 -0700 (PDT)
X-Received: by 2002:a17:902:c14b:b0:2b0:b075:f2fb with SMTP id
 d9443c01a7336-2b281855cbcmr96499605ad.35.1775485143247; 
 Mon, 06 Apr 2026 07:19:03 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156732905ad.29.2026.04.06.07.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:19:02 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arun Menon <armenon@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 10/10] tests: Use ML-DSA-87 operations to caused large TPM
 transfers with TIS
Date: Mon,  6 Apr 2026 19:47:35 +0530
Message-ID: <20260406141735.25844-11-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406141735.25844-1-armenon@redhat.com>
References: <20260406141735.25844-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Stefan Berger <stefanb@linux.ibm.com>

Test a large data transfer with the TIS. To do this, first create an
ML-DSA-87 key and sign some data with it. Then receive the 4627 bytes
signature and then send the signature back to have the TPM verify it.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 tests/qtest/tpm-tis-swtpm-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/tpm-tis-swtpm-test.c b/tests/qtest/tpm-tis-swtpm-test.c
index 105e42e21d..56d2a340c9 100644
--- a/tests/qtest/tpm-tis-swtpm-test.c
+++ b/tests/qtest/tpm-tis-swtpm-test.c
@@ -36,6 +36,15 @@ static void tpm_tis_swtpm_test(const void *data)
                         "tpm-tis", NULL);
 }
 
+static void tpm_tis_large_tx_swtpm_test(const void *data)
+{
+    const TestState *ts = data;
+
+    tpm_test_swtpm_large_tx_test(ts->src_tpm_path,
+                                 tpm_tis_transfer,
+                                 "tpm-tis", NULL);
+}
+
 static void tpm_tis_swtpm_migration_test(const void *data)
 {
     const TestState *ts = data;
@@ -57,6 +66,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_data_func("/tpm/tis-swtpm/test", &ts, tpm_tis_swtpm_test);
+    qtest_add_data_func("/tpm/tis-larget-tx-swtpm/test", &ts,
+                        tpm_tis_large_tx_swtpm_test);
     qtest_add_data_func("/tpm/tis-swtpm-migration/test", &ts,
                         tpm_tis_swtpm_migration_test);
     ret = g_test_run();
-- 
2.53.0


