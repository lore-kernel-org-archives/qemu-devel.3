Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F98ECDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGZQ-000787-P3; Wed, 24 Jun 2026 01:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZO-00076U-CH
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZN-0006La-0D
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782280480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSxZKxqrJVYUG9v1bZKPhHIbfbJ0pdhQC07vvjbSt1k=;
 b=emWgyeJoxUmpznzLP7zMU8gyLaLPZUOVvOP+Fg3KOWaD5xoOlWt+oX4qFpB55ATznFXs35
 hXfZupyfyzhB/agBXnTj9IVh3pibDpi/f0xa5+UoLa/3mXJstmaYK+P55OD5TYGzhhQQYS
 nrJXRH5e6atZRzvvn/D6TuKvCOkrDAw=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-MPpsxJgMOIaK5NDERqeSnw-1; Wed, 24 Jun 2026 01:54:38 -0400
X-MC-Unique: MPpsxJgMOIaK5NDERqeSnw-1
X-Mimecast-MFC-AGG-ID: MPpsxJgMOIaK5NDERqeSnw_1782280477
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c5978b108so1744720eec.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 22:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782280477; x=1782885277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSxZKxqrJVYUG9v1bZKPhHIbfbJ0pdhQC07vvjbSt1k=;
 b=e/7sdQSvlouB9ZJRvQAQS2vc3ea9+gz1iJKPCNMXo6zBZ5/TKxiOlGGbvl+GO6YNGA
 I0qcrEo6QJopTXCaKoILzw26Gyv0bjEn7qgoLuImwEqCsMIdi5tBLJk2ghW4Rjcd684m
 zR8va2ErYoeLQPmsCL2ptdo4/8D8IjRJpsttK7GOVksk/ZNWdnt1f/JXPyRVRlBjax4e
 mEewFptEKMhfPsavTH50jiaFMyWQhLXqEmty8VsM/eUnpdGacAPjPI6wBoqj39mlonPi
 ay15eoDZ9CZ50L6doHZ0KGIzFvACC6fTJMMwutaLSYw4SyOetfiU+FpBEOVrb6rqeLVi
 jMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782280477; x=1782885277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FSxZKxqrJVYUG9v1bZKPhHIbfbJ0pdhQC07vvjbSt1k=;
 b=J8wAbyrh8fcn5j7ytnFKQXgJVONEA5fQItyA6ck8OTwHYv7/j45JN9d5NiTv5PCFzY
 4cHGy2pD74qcN2T3yoXwqF2ySRhrUd9pL8twXiFE6vv4xuGMzRIQKfDVdhkV1v4M28f9
 1u42mVzoYFTjoTcmGlCi8xd+iRa6dLRqbTgHHXbIMj1GeTOtl4PxpgxzYWgjonk0zxMQ
 SabzjM1lxGBEmxohMlQu3kgEBQPls69oKMlzqJbVAIQ4ufoDFlN+a+RoiZOKlpiHM9AT
 de/R5x09KOYePk1QSO1veCDveyGqbewn5zIR/yOzVsBa1Ipv9tyks2LNlxzNGvtLIs+K
 7T7A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZ5Pc5Rh0ltTSBXin6D+OpNka0Q2EhhokeKlkMweuuxgpq1kHoi6x7/7lYsHdhCSqDkS12cUpWluRt@nongnu.org
X-Gm-Message-State: AOJu0Yw6wv6UdTr1C07XHZX9F22L3dLM9jo4SdGM2Odnb66ec9lE2xKP
 UGw/oei5Vqvtjfjb2ftdbbtHXis2XCx5go0WZZPLyy6PzjqRgCUVouCsmPI99APzj+jGxDH7U+M
 qp1Do2n6txZPsAsEzos2B1TS2/SLxjDRGRcMMNHLj7fxfUdVzed+7u3pQ3BNUrryH
X-Gm-Gg: AfdE7clVm+X6XzmO6NLxQ8Y9/QFHsoug2K3vyUsEp9OE85521NEoNjsbmuQMqcaH32O
 8EaU+bUK/PvZon04322Of3pGTjlZeoaRo6idgkKtRU8a/zD6gLZHfJV6gLD7B7d3uinMSU5hqv3
 um1QbcF+l9N+T6Pa4pUeYI1IOTEXOWUA06Fyp0R9aLEm4OJDEdPuom/QCovHBLudZUxF2Akz/Gg
 zpY6ft99cUrVKEUzP+1Y8fthjxf1zqhO5vQewHXQJGRGg+D8T/6OnMgkRbPqfXB0LJUIyk5SujM
 IF+OgZ0Ly1eKxI6GrD1TIuHzxBaWc7MZtoHfAP6QeomVxKf5CEhZptqXhvqlvSRiPbRPp8XhHNX
 clY9uY7FxBc+k1lzN7Jto/A6jEwn4MoqNE0AmYMNMQlNC
X-Received: by 2002:a05:7300:8607:b0:30c:536e:3a95 with SMTP id
 5a478bee46e88-30c68c41dacmr1997334eec.2.1782280477059; 
 Tue, 23 Jun 2026 22:54:37 -0700 (PDT)
X-Received: by 2002:a05:7300:8607:b0:30c:536e:3a95 with SMTP id
 5a478bee46e88-30c68c41dacmr1997316eec.2.1782280476515; 
 Tue, 23 Jun 2026 22:54:36 -0700 (PDT)
Received: from rhel9-box.lan ([110.227.100.91])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d6edsm21075803eec.14.2026.06.23.22.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 22:54:36 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v1 8/8] Update MAINTAINERS
Date: Wed, 24 Jun 2026 11:23:30 +0530
Message-ID: <20260624055339.46862-9-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260624055339.46862-1-anisinha@redhat.com>
References: <20260624055339.46862-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

Add maintainers for vm-launch-update device and associated documentation and
test code.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93df53d87f..98b63b40d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2773,6 +2773,18 @@ F: include/hw/acpi/vmgenid.h
 F: docs/specs/vmgenid.rst
 F: tests/qtest/vmgenid-test.c
 
+VM Launch Update
+M: Ani Sinha <anisinha@redhat.com>
+M: Gerd Hoffman <kraxel@redhat.com>
+S: Maintained
+F: hw/misc/vmlaunchupdate.c
+F: include/hw/misc/vmlaunchupdate.h
+F: docs/specs/vmlaunchupdate.rst
+F: tests/functional/aarch64/test_vm_launch_update_aarch.py
+F: tests/functional/x86_64/test_vm_launch_update.py
+F: tests/qtest/launchupdate-test.c
+F: tests/data/igvm/*
+
 LED
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
-- 
2.42.0


