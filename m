Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953D3D743E6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDshY-0008TI-VH; Wed, 20 Nov 2024 16:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshU-0008LO-Pp
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshS-0006TN-PE
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732139846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RUD/75mbaWwn03RfqmIGYTLyWheX+4TPboJRY2WclVE=;
 b=fqCnA9ZDNeMxnFha1NVcPPGbyAykCyPYVscz0VmmcYkvTfHfzpuCdIKIygON91zEU9S4au
 C2f3OxdI/OVchqPz2332XxsmxWxy16rGYEIw4MXYE8Gt/SvN5ELva1yt8CkB5CZhKKPXIc
 cZk30vOPpESJpT7vcopvSZAT5ADEhAM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-Jo10uGCKMr-bUZlYDy-yHA-1; Wed, 20 Nov 2024 16:57:24 -0500
X-MC-Unique: Jo10uGCKMr-bUZlYDy-yHA-1
X-Mimecast-MFC-AGG-ID: Jo10uGCKMr-bUZlYDy-yHA
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-46360a97a99so3370731cf.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139843; x=1732744643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUD/75mbaWwn03RfqmIGYTLyWheX+4TPboJRY2WclVE=;
 b=P3RhouwtsWz+g9KL04TxDo1a7LK0kt6VKS4CLPz91pK6D3nWtQDBOPklgHaZz9TUZF
 lokhxmDekhJQQzrN3eqC6I87+lmDJ3AUiWLOyopeKfJGB2LqbYP96/npPy2lzvzvXm4E
 clwtFD3IoeaiZKYdSlBgOqvOuwjGhe7fBA3nHJ+GoZd5nsuT+hDMn182TCVeutnVlqhw
 TgW37iueQnW9vE0jSD+U9IIKfwKfcqcJziTIseLpi3p5/f8rZeHz+6L6m0NygK6bXGdA
 20y0J7HLyMjKUdnSdIL/9qLzgGpWbgmiipFsXp9cQhC5oVSprpNgGtOoLCxS/bXPADrJ
 RIJA==
X-Gm-Message-State: AOJu0YxiM26clSAeHxRIAwWngYgV09/Zu9k0fgNPu28x6oHRO4IyVWN7
 2VT40fdDmSPHNCsoyuh99NhaUvYhvOJ7VFRHEZ0sIgqcKpPbe+TV6NEnTllpppDT6xIL2sp2QK8
 nCtjNGh59ppZlKrXcujs8q6pLRXNW5UwkifIDcOG/EYZwaT5UGCeprBw+h6YXCYX7ESx/LZ23DX
 G2Zvo//CptA5rwvL8Nt3h0BfTUDoUJ8acDfQ==
X-Gm-Gg: ASbGncuPgCHTaBq3qNiDI2QczpAA4I+955jBAVWrIPUZHliEx7upXOd6j39sDIRLYMD
 YOmrzmYK8Bz1hrGv2IQAuWYqQv+1JAZGt/R+j9tbS+tGbs5v4DAeCQW4r42E6SC/ykJs9/mRfst
 kVanSk+Hwn9etT1Ju0yMdnXfJjmaHBfLysnVcisIWNX+Uw5BZYclGg3kjFCJiBaRaagzADftcLL
 ItgoczzchRwyXWDMRYqrrsQN5ws49i2a23IYlbdYi/cZc9ipxi9XWDF2L2IDGuNRf+qHkngqjuT
 ChDVDnsR50w1auS4yxoshsbqbg==
X-Received: by 2002:a05:622a:14d2:b0:458:5ed8:628 with SMTP id
 d75a77b69052e-464777e2232mr59002371cf.2.1732139843622; 
 Wed, 20 Nov 2024 13:57:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrC2z4vGUqPgvRExvNJVpIY1AFRTKu3DMVYSLro3WVe+B1QpGlLkd0XbuTt8jH4ALDwOj7XA==
X-Received: by 2002:a05:622a:14d2:b0:458:5ed8:628 with SMTP id
 d75a77b69052e-464777e2232mr59002081cf.2.1732139843259; 
 Wed, 20 Nov 2024 13:57:23 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-464680d6826sm14632881cf.15.2024.11.20.13.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 13:57:22 -0800 (PST)
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
Subject: [PATCH 08/12] qdev: Make qdev_get_machine() not use container_get()
Date: Wed, 20 Nov 2024 16:56:59 -0500
Message-ID: <20241120215703.3918445-9-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241120215703.3918445-1-peterx@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

Currently, qdev_get_machine() has a slight misuse on container_get(), as
the helper says "get a container" but in reality the goal is to get the
machine object.  It is still a "container" but not strictly.

Note that it _may_ get a container (at "/machine") in our current unit test
of test-qdev-global-props.c before all these changes, but it's probably
unexpected and worked by accident.

Switch to an explicit object_resolve_path_component(), with a side benefit
that qdev_get_machine() can happen a lot, and we don't need to split the
string ("/machine") every time.  This also paves way for making the helper
container_get() never try to return a non-container at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/qdev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 5f13111b77..c869c47a27 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -817,7 +817,13 @@ Object *qdev_get_machine(void)
     static Object *dev;
 
     if (dev == NULL) {
-        dev = container_get(object_get_root(), "/machine");
+        /*
+         * NOTE: when the machine is not yet created, this helper will
+         * also keep the cached object untouched and return NULL.  The next
+         * invoke of the helper will try to look for the machine again.
+         * It'll only cache the pointer when it's found the first time.
+         */
+        dev = object_resolve_path_component(object_get_root(), "machine");
     }
 
     return dev;
-- 
2.45.0


