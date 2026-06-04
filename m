Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20D6CD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHDv-0007GM-6y; Thu, 04 Jun 2026 19:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVHDt-0007GD-Pl
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVHDs-0006Lk-71
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780614695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4AJ2lM9BNCEoaE5QIbvpYTcvEcCw4/TXdXr1P6/G5f4=;
 b=LI6ahxZGFYzRbkcRnhT6G/U0zdOSU+mAveWnEvY3OhrU+u1gaNQPDmuupS+/C2Bex0ApAW
 uK53o6VZ62pm4YNfXU2KUFqhAmvwdGtycoXJeN1+UWHh4cY0oMvY0fyt3cYuyPpwg8NZvE
 Duj/VH+UgTJHxV7bzGHUX2mdHpYsm74=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-C7UL9CyUPZS02J-PMPc92w-1; Thu, 04 Jun 2026 19:11:34 -0400
X-MC-Unique: C7UL9CyUPZS02J-PMPc92w-1
X-Mimecast-MFC-AGG-ID: C7UL9CyUPZS02J-PMPc92w_1780614693
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9157b94a014so111074985a.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780614693; x=1781219493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AJ2lM9BNCEoaE5QIbvpYTcvEcCw4/TXdXr1P6/G5f4=;
 b=s6HCdkU4veQCmhtiw44HXdQ7jqUqqqAUnXTy5bmgAn+Rv6jtkyn97xXUWOVA/zkl81
 DmI6eyykojMsb9dNzxhkzgz20fft2iRIp9OnK/R7FOz00r0VRRcfeyb1F7/jLIPs6+Nu
 ykCCrHzCh+uGdNvrkPX+H8J8WuykfS4Jj5q2E5hlpso6O4+M5iq2cMzdRica5ejDCIFJ
 8exwBE8LvPCrwwaM6zn8JDfnULpDIglYgPCiLtV5Yo1EgOiCxppd6MKNycZK55LRMN42
 g7Tpwj5osIMNKcjjuCvcy57TdGuS/82ChRbJ1ubhcyTpavYBHIMpWGgUIy3/sQBij210
 nwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780614693; x=1781219493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4AJ2lM9BNCEoaE5QIbvpYTcvEcCw4/TXdXr1P6/G5f4=;
 b=IUMtqkzrpw+4mUwuPeY4q7GxVyMhoo7jpT9NPk/5Ewz8f2+KKgf1Y1+TX4XXeVe8u3
 1avqvmJJAJRgzSci+sWxk0zvcB9Foc19Q+95lWh7IFB6F8Io9wNb7IQPBU39vCGJPWFi
 rIrg2S0Y+LGNepibc7mNXjg40/N84neB18f/4z8SQE+hymc0N7ZuAKJDnYBkTvK5KajI
 sPbDf6Y7TnVwftNkWmiOQ6McThJHb2mgsyIC4D6sCPeT5XkVvimdzttHdurAefKA0y7E
 FuLSEkEU+9/KbWGmhUcqhUyjPahBgam1+R4Ahx1lTj4PLBPZnFWxyhao8A0vP79lgJU6
 hkDg==
X-Gm-Message-State: AOJu0YyzzzeSS9Xcz1wwGUr3DLx6gMWPxrjptwikMgIaAGlvsPsDWzbk
 aNO8JTpiuIWYt7U76xHEla6WubBTjnl4dS5PJBDOn2CB/vMvfMNcjeW57h8IJTsDc2jelDLd/M0
 +FFlmV+iNi1HoqDTa+BXSzWjhuPejAY6hoqMGQK2AGMlBHahhaxVxD+oUkO5J9YlqPAhQY1zXXD
 iJ9zruRb4yetKKKqLu54OI5BmrOgNfZN3A3mfjBQ==
X-Gm-Gg: Acq92OGc/KfeqTybN2j/8dOHBI9pXsWvF3ArSH2VcvuIN7PxaJmrmQ0AT1VtdNPIIq8
 Pta0ZOzQn6LU6uQw3YaRacluY/cZwXy0N82oMRrKSs13AYlZm/tXexHRF2xfdqgmpuGkmDSoulX
 yN1x3fe9HJg//9Gn8SO4o8rYTs+IrzsGIPhtoc1RUb3Kvd4WhSiYEn1OGMHeNS2zX+oM8pfZyrs
 BxB9aVvsCqUj4aFTn5Z7OesSQzf+qUauQn75c3mrsfKD3Gcqh/umKeCe+t5PpiHWE7CSbnVUHU4
 vEAw6oZ8dbnqL+Btlt2MRewW+NVbbrUqQ069MHS2jA86ZSXJiyZewD7emjM+mDIs+lQXd4PZtAn
 KNWMu+pWKS8qFo/jOOYd6IyY=
X-Received: by 2002:a05:620a:1a1e:b0:915:80e8:67d1 with SMTP id
 af79cd13be357-915a9df5a98mr228326085a.56.1780614693470; 
 Thu, 04 Jun 2026 16:11:33 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1e:b0:915:80e8:67d1 with SMTP id
 af79cd13be357-915a9df5a98mr228311885a.56.1780614692780; 
 Thu, 04 Jun 2026 16:11:32 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a37cab6sm707617285a.22.2026.06.04.16.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:11:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Sana Sharma <sansshar@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 2/4] qdev: Introduce helper object_apply_globals()
Date: Thu,  4 Jun 2026 19:11:16 -0400
Message-ID: <20260604231118.1584889-3-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604231118.1584889-1-peterx@redhat.com>
References: <20260604231118.1584889-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The helper allows one object to apply anything from -global command lines
to an object.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/core/qdev-properties.h | 1 +
 hw/core/qdev-properties.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index eba5436e53..779acb31b6 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -268,6 +268,7 @@ const GlobalProperty *qdev_find_global_prop(Object *obj,
                                             const char *name);
 int qdev_prop_check_globals(void);
 void qdev_prop_set_globals(DeviceState *dev);
+void object_apply_globals(Object *obj);
 void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
                                     const char *name, const char *value);
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 8f870c85fc..a91c2ad101 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1045,6 +1045,11 @@ void qdev_prop_set_globals(DeviceState *dev)
                               dev->hotplugged ? NULL : &error_fatal);
 }
 
+void object_apply_globals(Object *obj)
+{
+    object_apply_global_props(obj, global_props(), &error_fatal);
+}
+
 /* --- 64bit unsigned int 'size' type --- */
 
 static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
-- 
2.53.0


