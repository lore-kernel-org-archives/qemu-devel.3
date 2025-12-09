Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A90ED3B7FF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0b6-0006fh-Md; Tue, 09 Dec 2025 11:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aP-0006Ee-0R
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aM-0001wf-Cl
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765297744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJaYaFltwSQdIY80FzVnQT3/OB3Zazi46H3jIifn4cI=;
 b=jDU85HOpjPQ0wrfHAJEaIOOr4/kGl5BdleZMVlHHpqBEPwvh5QW9L1iy0DdI2ZPL/TNkDL
 GoQt9OBdijIBM0o30z97G7Zb8YTx7husBrkqaojGAIy3bLzb8dVSTtZuydcUsxnNa7njpT
 I5eVkkdAfzkgSGBiMZ+GEuys7JLAU0w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-S2XDPmbyMGa1n6fYQF_meA-1; Tue, 09 Dec 2025 11:29:03 -0500
X-MC-Unique: S2XDPmbyMGa1n6fYQF_meA-1
X-Mimecast-MFC-AGG-ID: S2XDPmbyMGa1n6fYQF_meA_1765297743
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b8738fb141so514378985a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765297742; x=1765902542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJaYaFltwSQdIY80FzVnQT3/OB3Zazi46H3jIifn4cI=;
 b=NAJBIunMnlNVySw86PeVmSeWoFGnmNiTYUoVPQgBZkzr8gl9FdVsYdLlUteoljoktR
 EaQM/vLwN6/mc5m42EycGzCGi+Qcxaysw2lW7ibz5AC67ONvXObbrYucRPijggPPu7cN
 1CCZfVMW72aCgqTxgqQS/3SFmeLrXhwd+MD9osVeePmJPfg4erltUWTeH0WpHHWilfua
 +L1JgzwPkOoBEH5WY1hrhEFdYuNfvTEmr2sIs+QCjiXRhdZhcDWh+emxo/KZcAPTM2p/
 5K+hiVUQaCV6mTcs1slPE56WW9ixXdw+HmYfB5vMwv+CeOsRThYiL+5jpAUc5JNMTwbc
 rMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297742; x=1765902542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KJaYaFltwSQdIY80FzVnQT3/OB3Zazi46H3jIifn4cI=;
 b=rzFFrH+AkrPM96W9Z79oiTKQz0zxGkH4DUWK9tEo7fUy4cPFnsLFD+OV0nPMkm52QA
 W9ncRH1ut4NuXulu+h0spvdRGrf7XAcR40ACKiliwkiZSVVGzd8M8PqyKeSf8Y9xDCrj
 NPQ0/cDUAi4R7gFSS42b6MP2JcRmvK8AtQQGCzmSngpQgE5JZnVteido9CLIvhgP/B/J
 lssH8svcj156x62VR06npcgoyzpff0yNLHQc4nEmeFteba4XYVMaHhjWvYTPZTQLLhSp
 PR0U35sDtpEkdr6dhZwlFQs2ZAOCm6It4+P1MftMNZi6v78NY7T5XYG32yza70MImkR4
 faIw==
X-Gm-Message-State: AOJu0Yx7GE7VsjC1bcFb+Jv0m+PyZvTBMg9iZnCPuySeOolxO8Skdi9H
 PIezg5Ww85Un8EBX44k3Y2orL5Dowhd4O0Dxkw/E4HomCHigDjttfTQlZ6t318j1y5Puzc9dTHi
 U6EdAkCuIsSWqLIXBnTfbck/6/xd6UEP7sm0cJtj27+/8esORR2qFxZCsx0mY+oG+5nwVi+B375
 JTzT5UarGK20FHLjzN80iJYLlvQyIZFwPKYjZJ6Q==
X-Gm-Gg: ASbGncu8Mp5SK2I4NUvZUCpdcnwd6dMG81Xr3nddFmwxOeatt2o5o1GRb/fpQdrsTzZ
 FUx7tq0cR96C5MdywvxW6CPDfbmXGZbzRq2V3nTjwvXUUP/TTEh5CVXNwP/7fYNl79uvqPiVLa5
 3d6eoW2Q22oaSS32+Dutwkfosp9L4go1opmlrii8dozOZMtpX71Crwhe6oHeTkmAQ8jxfQSma28
 5QsN6/E+a8C7jfE0XU5VqqSZZhgPvDCFuWN9f8vOKxGAtGdRgd8hty+7cYqHUOGJQmg6MlZLZ+t
 N4r/5hKHTnv6OiVvJP/nZ7zy53dDCps8Y4AV5NOrfPRdjGCNwM2DaaCwgg8aLDuvYODCX6JKCDo
 aoEo=
X-Received: by 2002:a05:620a:942:b0:8b9:fcc6:6473 with SMTP id
 af79cd13be357-8b9fcc66fbamr168243885a.33.1765297742476; 
 Tue, 09 Dec 2025 08:29:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuymeKwjwKhSW+kL4yXQNHaFnT91M8L+XPc401fRlqcbsaM75YorIVzbszh+kkysJISl4amQ==
X-Received: by 2002:a05:620a:942:b0:8b9:fcc6:6473 with SMTP id
 af79cd13be357-8b9fcc66fbamr168237485a.33.1765297741757; 
 Tue, 09 Dec 2025 08:29:01 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f334d8sm131110256d6.10.2025.12.09.08.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:29:01 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH RFC 01/10] qom: Introduce object-compat
Date: Tue,  9 Dec 2025 11:28:48 -0500
Message-ID: <20251209162857.857593-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209162857.857593-1-peterx@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU provides machine compat properties so that old machine types can
define device properties, which will be compatible with old QEMU binaris.

This is the core of how QEMU manages VM ABI across migrations between
different versions of QEMUs.

It used to almost only work for qdev, which was almost enough.  There were
already outliers showed up:

  - do_configure_accelerator()
  - host_memory_backend_post_init()
  - sev_guest_instance_init()

They all invoke object_apply_compat_props() explicitly, because they want
to benefit from the machine compat properties too, just like normal qdevs.
However they're not qdev, hence they need explicit code to support it.

MigrationState object is another example that wants to use similar feature
of qdev.  That was previously done by making TYPE_MIGRATION inherit
TYPE_DEVICE.  See comments for migration_type.  That's working but weird,
e.g. people may question what "-device migration" means..

Nowadays, there're more demands of that, e.g., what if we want to allow
compat properties to be applied to device backends ([1,2])?

Maybe it's time to think about extending the compat properties to a root
class so that more objects can inherit.

This patch introduces object-compat, which is almost object except that it
also allows apply machine compat properties on top.  Then any object that
is not qdev but wants to benefit from machine compat properties can opt-in.

[1] https://lore.kernel.org/r/20251030203116.870742-1-vsementsov@yandex-team.ru
[2] https://lore.kernel.org/r/d986f0ac-a0ae-44f6-b7a5-e002b7d3226e@yandex-team.ru

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object.h |  1 +
 qom/object.c         | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 26df6137b9..e5b3116ad5 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -26,6 +26,7 @@ typedef struct InterfaceClass InterfaceClass;
 typedef struct InterfaceInfo InterfaceInfo;
 
 #define TYPE_OBJECT "object"
+#define TYPE_OBJECT_COMPAT "object-compat"
 #define TYPE_CONTAINER "container"
 
 typedef struct ObjectProperty ObjectProperty;
diff --git a/qom/object.c b/qom/object.c
index 4f32c1aba7..581c041b08 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2893,6 +2893,11 @@ void object_class_property_set_description(ObjectClass *klass,
     op->description = g_strdup(description);
 }
 
+static void object_compat_post_init(Object *obj)
+{
+    object_apply_compat_props(obj);
+}
+
 static void object_class_init(ObjectClass *klass, const void *data)
 {
     object_class_property_add_str(klass, "type", object_get_type,
@@ -2914,8 +2919,17 @@ static void register_types(void)
         .abstract = true,
     };
 
+    static const TypeInfo object_compat_info = {
+        .parent = TYPE_OBJECT,
+        .name = TYPE_OBJECT_COMPAT,
+        .instance_size = sizeof(Object),
+        .instance_post_init = object_compat_post_init,
+        .abstract = true,
+    };
+
     type_interface = type_register_internal(&interface_info);
     type_register_internal(&object_info);
+    type_register_internal(&object_compat_info);
 }
 
 type_init(register_types)
-- 
2.50.1


