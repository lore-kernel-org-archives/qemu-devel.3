Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4562D743E6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDshk-0000Dz-4X; Wed, 20 Nov 2024 16:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshj-0000DL-1L
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshd-0006Uk-05
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732139852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0jDqqudCxAu71oFUQRU0Kfl+jPW1gD7xhuPkzFbPVs=;
 b=Mmgh+ITom1MWPPsCG0nay3L/JhSkArd/KeSdMcXC3VGe9byf1wKTbQbDq5J4Akq9i36k9R
 eImp24DO/3wIzh+EP6n1idpYcLUnWytCs+VFs9SwgwwWQwrxZ9EigF9jEX825gL6V05IFz
 BKPmEqEZVjKOa1zFLsKgBUltBTDLstQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-5cv0xMfWMMiX2kJdCf1-Lw-1; Wed, 20 Nov 2024 16:57:30 -0500
X-MC-Unique: 5cv0xMfWMMiX2kJdCf1-Lw-1
X-Mimecast-MFC-AGG-ID: 5cv0xMfWMMiX2kJdCf1-Lw
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-71a3da16d58so240519a34.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139849; x=1732744649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0jDqqudCxAu71oFUQRU0Kfl+jPW1gD7xhuPkzFbPVs=;
 b=RJpa1rvAs4yBr8+6N24z7rKLjRVMEtOQ4DopgnmTVkBSb7EiaL8aDWQ1eOQSUgswsJ
 Dy2fVwJZ2fhv8sZqfhA5K06tcL4ZSSY7DA4Xn1UJTwefFlSnFra1UcdsK/yFLURTY3Mq
 0Rv4qsPCqGUoph6sTQz/01a2LIuHZHNCFHzLDqoKFVlg4+gflKpEGkRzLNlTp7ag1hc3
 rkxM/2GSma2S0JKp8Y36OCzQQmN7ruHOjDxHYI+5oXTlmzdtlZZSOnaGeX0TKQXpoQ3F
 B8sFnan64raMKyiAp7LwQ3WxCMPyzag1zPKCbIuJCHKIt4EqeoO0db9qAtg/TVM70VPg
 P7mA==
X-Gm-Message-State: AOJu0YzQ9dX9UGbwrYkGiXs9dd9B7UbXHgD+fUcWZJG3/X4XYVwosanz
 uwZzTdd5qD/I+YxoXEiHRb0ffYu0ZfJzhiCTUYGrsbdysQDKJwtdsAZEuVTi/ccOkVgfef8wira
 Jn7QQi9Uh4CpYGeJwgBfElOp4xZ0xLn3tyiYEUlEcEZqaEJpglpfP5Q9nEHWHEa6rsM13h0Qwki
 nmvyB4Esk7FGXHpqfCwzSNxvn5OD7kJ30r/g==
X-Gm-Gg: ASbGncuP+0UREEI3doQdNDv+JcSdIPUG53f6G+tnyttAJwcdMq2PmcTpRFBZP5O9oGe
 DQX0Y8O7fw80ts0ZZ4j/w9BLraO+t/6qHl0eA8T3kc5vzJq/F2U4AhG3C6BFte+NYcfc+odjL4G
 k1Pdz8YDkRrtFf8855Vr/m1XB2Hoh8jhO45mhOKLugfWgk1/fZSY7ygcK697TsNL8EKEiGxhe1n
 lODAxs5Q/g7cIByAt4fyLuGrWAiXBrD6yu0VsUWDfYO/MT22L5yEzNm+LY0aNRVtq6yZ1mZ53F1
 UvrJ9x500O+IVegaaSXndBwCKg==
X-Received: by 2002:a05:6358:7aa:b0:1bc:58bc:ff14 with SMTP id
 e5c5f4694b2df-1ca664947femr337723255d.10.1732139849302; 
 Wed, 20 Nov 2024 13:57:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo9MBMpx+CJGTi9ic34jdBJyCvTF74aN8KAHGuB04iBGFPopNgBUzSPsjJBXNqKPvOe6W90w==
X-Received: by 2002:a05:6358:7aa:b0:1bc:58bc:ff14 with SMTP id
 e5c5f4694b2df-1ca664947femr337721055d.10.1732139848923; 
 Wed, 20 Nov 2024 13:57:28 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-464680d6826sm14632881cf.15.2024.11.20.13.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 13:57:27 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 11/12] qom: Add object_get_container()
Date: Wed, 20 Nov 2024 16:57:02 -0500
Message-ID: <20241120215703.3918445-12-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241120215703.3918445-1-peterx@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a helper to fetch a root container (under object_get_root()).  Sanity
check on the type of the object.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object.h | 10 ++++++++++
 qom/object.c         | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 41ef53241e..87b13f9681 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1524,6 +1524,16 @@ const char *object_property_get_type(Object *obj, const char *name,
  */
 Object *object_get_root(void);
 
+/**
+ * object_get_container:
+ * @name: the name of container to lookup
+ *
+ * Lookup a root level container.
+ *
+ * Returns: the container with @name.
+ */
+Object *object_get_container(const char *name);
+
 
 /**
  * object_get_objects_root:
diff --git a/qom/object.c b/qom/object.c
index 810e6f2bd9..cf66803a6a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1748,6 +1748,16 @@ static Object *object_root_initialize(void)
     return root;
 }
 
+Object *object_get_container(const char *name)
+{
+    Object *container;
+
+    container = object_resolve_path_component(object_get_root(), name);
+    assert(object_dynamic_cast(container, TYPE_CONTAINER));
+
+    return container;
+}
+
 Object *object_get_root(void)
 {
     static Object *root;
-- 
2.45.0


