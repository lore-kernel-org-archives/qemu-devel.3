Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CF9C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treqY-0008MW-43; Mon, 10 Mar 2025 11:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1treqU-000841-A2
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:15:10 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1treqQ-000879-6u
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:15:08 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-390effd3e85so3838778f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741619698; x=1742224498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjyeW5Nt8o0UjpeWcNjmceOtbUr0M3LV9xv1HVnRIgs=;
 b=mLZ143dBTnh7gSPOcy1JkJ/9Sb+Rvc+HZWxiJcxg9Dhf3tU+viYaiKCSdfHxzjuMnv
 X4JN/VyFqwshP0679Q8sklqGOk2otUF/TsajHYKLeqCP+lLdCfEZ5WhfqPfAc5orhfty
 dndpwkyimf6eo62lIktKJLlZ4WiKjrg81SuyJkXXlEHxJ5bsJlEZQNw1Fi15s5lQqirK
 aIY4RF4Hinv0rTla/5pDNPCgquvD3kZIkcfqboqW6eUewqKcwx7eoVMOE+JmJnq5k6hT
 fE+arY4Mflx9mix1XmWpIGPdtTVzVynBvSdN0bB7xVCxI2QgaVC+5592R0MMvNjHyxhe
 wXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741619698; x=1742224498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjyeW5Nt8o0UjpeWcNjmceOtbUr0M3LV9xv1HVnRIgs=;
 b=OiheI8QD3kzTdf/rWJXCNwh+82hYZW2K2rDid4SeJGz7rPHXFZOMvzZ1YiPU9Od0iu
 RsgGBEAyV53xvp04TKXOsUqYvn+ZpMtJII1NV8txoMevfClzsJjRl89bE1HzjEiAJuyn
 H6+1OMyzTxpFEcsAuGPZ2VbZK2o4C0X4F/1r5MKjCxqv+DdE/QtntImego0EG9IM4f9f
 gskeSLqvRANtR7Dfb+BoGsRX7Uz16Rq9exgaU0IfigKWevLdfrouiTHK3/pxLGD0NJiq
 /7VMPKfJyQ/09sjs4Mc0SZ8GhIdzQuvi9q2wMiQr3P51eYhq6KzX9b5P474YTGWUg1uf
 E4ag==
X-Gm-Message-State: AOJu0YzAscUeTU6av0wFXD1D+DWHuj5b0UyQOjWgUJVEoG9v26YF4nSc
 4QLCnn4017jrVJpvg/JxZfO6EnUW/wxyswiExkFqSupzGqGPcKsQnqyHqbbsNZ/xRoUbZOAq2ZM
 6xt8=
X-Gm-Gg: ASbGncs7Glw2Lh1ojJAEIbbEb/7Kw+Cf/+b/97Dld0Xeo5C7POc+BPgwKrq1qv9v4jG
 L/MSj0a6wcJPXhJlGQuNRatjDsgNTylI8Ds2dwSg6FZn3IyB5SM9KgvYP0nEggM1OhOSrxeylgU
 14BT1u3U2FyxxVGaDyWgFeskZGcVc5ZGpqpF6WU1pMwVyi0qPgzQfFPzGf4XrGu0cuE+SRQA1ME
 OTMaYPb/ZEVDk2XoAksjd9qutuYYozOiRaYSkIsi2C5YvdglMo8EgN9ydIAkWQRKGmhGcF4Uh1u
 37pKjRc/tJhLhm/wXAbx5ezEW4fyjwiCjS3H1QBKSjkU9wJA1pVk17DYgKTyV23wRK/CS/hnmQq
 vcNA4U91h37o+m45OGB4=
X-Google-Smtp-Source: AGHT+IE1w7dyWCtAPeN1pjwXeUw1lyJH9uz35BpvIAACms6Ibp24qpioddKGgCf87iLeWmMsLxCaSg==
X-Received: by 2002:a5d:5f4e:0:b0:391:fcc:9ee8 with SMTP id
 ffacd0b85a97d-39132d6bc06mr8314088f8f.23.1741619696600; 
 Mon, 10 Mar 2025 08:14:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103f41sm15004792f8f.85.2025.03.10.08.14.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Mar 2025 08:14:42 -0700 (PDT)
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
Subject: [PATCH v3 3/4] hw/s390x/ccw: Have CCW machine implement a
 qmp_dump_skeys() callback
Date: Mon, 10 Mar 2025 16:14:13 +0100
Message-ID: <20250310151414.11550-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310151414.11550-1-philmd@linaro.org>
References: <20250310151414.11550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation to make @dump-skeys command generic,
extract s390_qmp_dump_skeys() out of qmp_dump_skeys().
Register it as CCW qmp_dump_skeys() callback.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/s390x/storage-keys.h | 1 +
 hw/s390x/s390-skeys.c           | 7 ++++++-
 hw/s390x/s390-virtio-ccw.c      | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-keys.h
index fb766d4631b..ac303001f57 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -122,6 +122,7 @@ int s390_skeys_set(S390SKeysState *ks, uint64_t start_gfn,
 
 S390SKeysState *s390_get_skeys_device(void);
 
+void s390_qmp_dump_skeys(const char *filename, Error **errp);
 void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
 void hmp_info_skeys(Monitor *mon, const QDict *qdict);
 
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 0d3d4f74b4c..fd1123b0f35 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -142,7 +142,7 @@ void hmp_dump_skeys(Monitor *mon, const QDict *qdict)
     }
 }
 
-void qmp_dump_skeys(const char *filename, Error **errp)
+void s390_qmp_dump_skeys(const char *filename, Error **errp)
 {
     S390SKeysState *ss = s390_get_skeys_device();
     S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
@@ -219,6 +219,11 @@ out:
     fclose(f);
 }
 
+void qmp_dump_skeys(const char *filename, Error **errp)
+{
+    s390_qmp_dump_skeys(filename, errp);
+}
+
 static bool qemu_s390_skeys_are_enabled(S390SKeysState *ss)
 {
     QEMUS390SKeysState *skeys = QEMU_S390_SKEYS(ss);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a9b3db19f63..104cd1c79eb 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -809,6 +809,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     NMIClass *nc = NMI_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
     S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
+    DumpSKeysInterface *dsi = DUMP_SKEYS_INTERFACE_CLASS(oc);
 
     s390mc->hpage_1m_allowed = true;
     s390mc->max_threads = 1;
@@ -834,6 +835,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     nc->nmi_monitor_handler = s390_nmi;
     mc->default_ram_id = "s390.ram";
     mc->default_nic = "virtio-net-ccw";
+    dsi->qmp_dump_skeys = s390_qmp_dump_skeys;
 
     object_class_property_add_bool(oc, "aes-key-wrap",
                                    machine_get_aes_key_wrap,
@@ -875,6 +877,7 @@ static const TypeInfo ccw_machine_info = {
     .interfaces = (InterfaceInfo[]) {
         { TYPE_NMI },
         { TYPE_HOTPLUG_HANDLER},
+        { TYPE_DUMP_SKEYS_INTERFACE},
         { }
     },
 };
-- 
2.47.1


