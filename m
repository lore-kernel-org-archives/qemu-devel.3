Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8D3E64007
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECl8-0006So-8O; Thu, 21 Nov 2024 14:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECl5-0006SJ-Gm
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECl3-0002Yf-P4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09qVDtV8+X8joyoLsYEjsugdMH7ZxlNybCqke+Rx6OQ=;
 b=PKT2mvxBtpO6WfQtqeW2+vqRniw9YkcP4mvda9NYKsgQcmIB8n6UrYGeIuBo1V9lAxEwVo
 3TWMAwsfZ26a5J6BUM/Av+usCo20HEblFdPX4q1KZRbRlBaLpvB00gw03nPGv5I4qK3WXm
 BgIW7gKw0JCcpOwBxgCVAmn7RLjY9FI=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-len4P6ppNjuPe2WspEB_EQ-1; Thu, 21 Nov 2024 14:22:28 -0500
X-MC-Unique: len4P6ppNjuPe2WspEB_EQ-1
X-Mimecast-MFC-AGG-ID: len4P6ppNjuPe2WspEB_EQ
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-83ab369a523so126975639f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216947; x=1732821747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09qVDtV8+X8joyoLsYEjsugdMH7ZxlNybCqke+Rx6OQ=;
 b=mRWbChEsNHLULfQvoOHEaRk13dEk82Ecs7x72XDuZ9q7arV0/kP4Yq8snUuIyvOhqi
 cErxAwaORkcdkEUGxTXKZlgyLxUG1gM7xznEuR8PSWaFIKv5bRIOOj+sQ+xbFAg39ICz
 cUDx56nLPxVyJWVHambOURx8GoT682JN3nuqoi1eGV7+Lpq/GSvnv/RMvt64jyZUEp2j
 fQWI8RqriotS8uc+KIrk6Y5T6zutCif7UCPpFbOLV876yMB9Ry/qPfB9/cAHwL4MBnOW
 4u999vS1+cFwwPu//F45P1Yw/T00l9Yq+ZfHq42TK2oXJ1I66MSBfyDOTRCtl//XwOfv
 sKyw==
X-Gm-Message-State: AOJu0Yw8iqoRXfCvuwAPkJrZrCJ423wKED+j8nOmb5ykUC40yx6cUC+9
 pder35aWlsNmlfHqLk0tWkdpnewgYG14bPpGubVYQJX3B68U23tfTVdg096YcOA2yK0qvO8ugcG
 GchxPMtVihpBew6yHVuArU5EogwcYZqgp7Uesamr+24gnAaYSXR/L3pqO6uZTUHBcKX4rj1eimA
 4L+FjPmYMIMh7swYdTqnQ8SOXsdtbbBFCeXw==
X-Gm-Gg: ASbGncuBmB887nC8Mrp/Pyd5frjdwZdqwIaEU7drbBPUCqmUATUIQVynhDLprLHnptI
 OyKiltm+R6sVbtQAtggms5iu/4zm6Vv7gHDFpaW9TOy+dTDfC82Hxo5AWmtOhODYMQuGjc4iWqM
 /amCrCNK6uCu9ACaPclG1GaUrHOHFvunGfTWjqi1gGevL8ArZvFGf0Vg/NQWo2AU9wBy6jf0g4b
 Gpo7G2f5H7Kw3ISLM0qbXhMHglprMyq1klqGgZasVD0ZjOSd/g57KflCyK2beikuMDz1dbSTH++
 onVWow5C855Bwi/PAbKO6f9HaQ==
X-Received: by 2002:a05:6602:154d:b0:83a:872f:4b98 with SMTP id
 ca18e2360f4ac-83ecdc44f29mr10843739f.2.1732216947123; 
 Thu, 21 Nov 2024 11:22:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGdfiMZqSHprSPJo6ciJj7VtcqnP9zLzTP0uWTYoy3dP0ye2D7P7kHsUqOzEA56o8WYjW8VA==
X-Received: by 2002:a05:6602:154d:b0:83a:872f:4b98 with SMTP id
 ca18e2360f4ac-83ecdc44f29mr10841439f.2.1732216946834; 
 Thu, 21 Nov 2024 11:22:26 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:25 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 13/13] qom: Remove container_get()
Date: Thu, 21 Nov 2024 14:22:02 -0500
Message-ID: <20241121192202.4155849-14-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
References: <20241121192202.4155849-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Now there's no user of container_get(), remove it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object.h | 11 -----------
 qom/container.c      | 23 -----------------------
 2 files changed, 34 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 4eeee7f7c4..f3a887e34f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2031,17 +2031,6 @@ int object_child_foreach(Object *obj, int (*fn)(Object *child, void *opaque),
 int object_child_foreach_recursive(Object *obj,
                                    int (*fn)(Object *child, void *opaque),
                                    void *opaque);
-/**
- * container_get:
- * @root: root of the #path, e.g., object_get_root()
- * @path: path to the container
- *
- * Return a container object whose path is @path.  Create more containers
- * along the path if necessary.
- *
- * Returns: the container object.
- */
-Object *container_get(Object *root, const char *path);
 
 /**
  * object_property_add_new_container:
diff --git a/qom/container.c b/qom/container.c
index 20ab74b0e8..38a27ec1ed 100644
--- a/qom/container.c
+++ b/qom/container.c
@@ -34,27 +34,4 @@ Object *object_property_add_new_container(Object *obj, const char *name)
     return child;
 }
 
-Object *container_get(Object *root, const char *path)
-{
-    Object *obj, *child;
-    char **parts;
-    int i;
-
-    parts = g_strsplit(path, "/", 0);
-    assert(parts != NULL && parts[0] != NULL && !parts[0][0]);
-    obj = root;
-
-    for (i = 1; parts[i] != NULL; i++, obj = child) {
-        child = object_resolve_path_component(obj, parts[i]);
-        if (!child) {
-            child = object_property_add_new_container(obj, parts[i]);
-        }
-    }
-
-    g_strfreev(parts);
-
-    return obj;
-}
-
-
 type_init(container_register_types)
-- 
2.45.0


