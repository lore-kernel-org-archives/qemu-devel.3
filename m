Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE789C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treqP-0007j1-UU; Mon, 10 Mar 2025 11:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1treqB-0007SZ-Cy
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:14:54 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1treq5-000856-5Z
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:14:50 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so1024218f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741619678; x=1742224478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDJL7i+c1E6l5ov//Lc/b1BwrtAv+NZufrTUDULsf10=;
 b=IrmRlbK2dWqQmGaRbpyyTTCoCJWfiC/5kAmdT7ZPwC/CrPvuxA35GW1HYHPT5HbRP2
 63dYrjBDAHANidJ/5aECG1P73W6dPzcxNnIL8pkAOf3YV6QlCp8psV9Qe80wUcmfPu1H
 9MjTPt/2WwfsHbK1mDsG+53+4bEMMPS7L5OO3HYmaWuFmcPIBRUJ3NKYKf11eY/ZF9HQ
 nOS7HHNeYk0Pg9UYX2/pA4OrjQQzlMoBqhc974nB9FRsxglDUbVpxyX9PYrbkpEG3WWL
 hW/vl45KTFhV/j6xa0W93xDuM50xncXmasvX6sN9oN2Gl2YPJoP541ff/+et1b/T1gf7
 6Hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741619678; x=1742224478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDJL7i+c1E6l5ov//Lc/b1BwrtAv+NZufrTUDULsf10=;
 b=jyam2fepbgifrVTMIOuFFCcPYgv3VlVfPSvRrMRQTrWzSEuGMzen71DqnUfiQuyj2X
 KKVSiC5QCrCII1Fu/3SSU1k46BZ7dgo8UUy8F7t8PPhMBqpgX//EIkZxx0/BVdaIJn9R
 VvAsfb/9LCavfzborrx5lxMsqpNmrmYeLoovgs9J1ApEr3RTqRVKa/URwOE2shh/w1x3
 aNHdcMr7A8WYZbJyBeU/O/ZASspgvk0KwVqFxbQeeHF4d1DEjQQxyM2obAeXUesta1As
 HZJ/1A1nd5fwjehtgNKpgVq4EEau+9WowPjZmEZjVtLERy/3XKdZoB5n8+gAVBMWJ/rA
 /fJA==
X-Gm-Message-State: AOJu0YwyY2p4CRnFzJRWeVG/ryEZDU4DusJAeczrqvdLIvsxrtv0zkuY
 OvPaeP2g1O8thq6KpARH26Pi3KAN4BpVu+w6h5iNaVhoglvGZp4Ur78eiz3rKct9pOnBAZ1DCXd
 ewv4=
X-Gm-Gg: ASbGncvck+BNUHsimVaJXhjXkbJi7iIhYUs/AumpqUh/XjC7tQEi2V2CiJwfrRirh6T
 FG6dEQf9E+vNSzEmrN4G7fVTXvADPX9xqeBPGwHxmmU/mkjrG32W9F49sMAZFW4iA6afax3Yc4M
 Zmz1hZpUkhMPzCSlPg81I8FRbsnWbVtWIeTkKtdoU92SW/Ap20aK2yvjDHgX4j9W4A+dzmjjVt2
 WBQ5tu7DpVEUnBl0iczV2ExE5wikc01sM2PLV/n4mGYjslK9mOByXHU5iUSVFjH+1d6asXuzMTm
 NcQtTdCO/QPoc0H+5nkroroe/L9jtxdJ6A4wCWGSOTp4BFZOVlCOsxSV90Q0dVaG6/njqVBakWk
 uE1WLduGAblNLSrbYVAs=
X-Google-Smtp-Source: AGHT+IFsyguKP2GMT8eYs2RSgRt0j4AYcapjlVVCRaQjDMms6aY99J17kWTso8GmmPXpxAFz/9ayrQ==
X-Received: by 2002:a05:6000:1fab:b0:390:e8e4:7e3e with SMTP id
 ffacd0b85a97d-39132d07284mr7971050f8f.6.1741619678009; 
 Mon, 10 Mar 2025 08:14:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c102b62sm14947780f8f.84.2025.03.10.08.14.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Mar 2025 08:14:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 2/4] hw/s390x/skeys: Introduce TYPE_DUMP_SKEYS_INTERFACE
Date: Mon, 10 Mar 2025 16:14:12 +0100
Message-ID: <20250310151414.11550-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310151414.11550-1-philmd@linaro.org>
References: <20250310151414.11550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The storage keys are part of the machine memory.

Introduce the TYPE_DUMP_SKEYS_INTERFACE type,
allowing machine using storage keys to dump them
when a DumpSKeysInterface::qmp_dump_skeys() callback
is provided.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/s390x/storage-keys.h | 15 +++++++++++++++
 hw/s390x/s390-skeys.c           |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-keys.h
index 408d2815d4d..fb766d4631b 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -125,4 +125,19 @@ S390SKeysState *s390_get_skeys_device(void);
 void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
 void hmp_info_skeys(Monitor *mon, const QDict *qdict);
 
+#define TYPE_DUMP_SKEYS_INTERFACE "dump-skeys-interface"
+
+typedef struct DumpSKeysInterface DumpSKeysInterface;
+DECLARE_CLASS_CHECKERS(DumpSKeysInterface, DUMP_SKEYS_INTERFACE,
+                       TYPE_DUMP_SKEYS_INTERFACE)
+
+struct DumpSKeysInterface {
+    InterfaceClass parent_class;
+
+    /**
+     * @qmp_dump_skeys: Callback to dump guest's storage keys to @filename.
+     */
+    void (*qmp_dump_skeys)(const char *filename, Error **errp);
+};
+
 #endif /* S390_STORAGE_KEYS_H */
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index d50e71b927a..0d3d4f74b4c 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -474,6 +474,11 @@ static void s390_skeys_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo s390_skeys_types[] = {
+    {
+        .name           = TYPE_DUMP_SKEYS_INTERFACE,
+        .parent         = TYPE_INTERFACE,
+        .class_size     = sizeof(DumpSKeysInterface),
+    },
     {
         .name           = TYPE_S390_SKEYS,
         .parent         = TYPE_DEVICE,
-- 
2.47.1


