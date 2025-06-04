Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E78C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoBh-0008TC-3S; Wed, 04 Jun 2025 09:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoBL-0007my-HD
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoBJ-0004qH-Rv
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4miDEcFeoLMzpknUkidzUiT3tY62ZBbQkI2NJpJaCbA=;
 b=OlCzIEgWRXoGh3xzelxXUDgvVI+5pP6FD5JJ+5ps3jNRpI67UOMrxR7iCFM0JR9TJLcyqP
 P29VfQ9vSOls8cT/y+PeA+rmauP3kChdPcfdRa9rZJUCf2dHOqSE7+zSyToeyrR2TJGPwO
 I4lpRLMx7weNHgh+Fi+xO0Yj6hpTD2M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-5Er05GSVMKCvDgWv41rx_g-1; Wed, 04 Jun 2025 09:29:23 -0400
X-MC-Unique: 5Er05GSVMKCvDgWv41rx_g-1
X-Mimecast-MFC-AGG-ID: 5Er05GSVMKCvDgWv41rx_g_1749043762
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450d50eacafso37761905e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043762; x=1749648562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4miDEcFeoLMzpknUkidzUiT3tY62ZBbQkI2NJpJaCbA=;
 b=stKWlOPUKB3oy6OICZmkl9UGHFxTuJl88G0gbxJR5jd3kDZp5ppB4z55/i2CuYB0iY
 kuJOQktZrxKfEMqq4/01ReGUeEjcWoLusXxcPT35XO9GqFUjyCbjkDPiA3eMY7Pf0Pyy
 rGEBci10b9nkdGsQhggGU/pYJ3gtDAkE0aNv0nn3qqZYMnr5AJsWk0CXziDVwNIErr1i
 E0Ij8BkOGUZNacvxwvMzAvfwWJbEleB6dHSWxwBGPRGHc37ZKT7SxGzYCSjjpO5enqNu
 E17V9Gt2t3vZgRQQrn3vsO30TDuUJtfSJs6e5MFwYmt9L8KkB4OuWYiBFE3tP+Ql5zjq
 JEnA==
X-Gm-Message-State: AOJu0YzeFpW4aIDm95TUVr0s1yPuq9d9PygO/Ag29E9RfLoyOleABh9U
 Y/XYxYjp+d8PHyXibPnpAxy459niISSKHB9PK7r+q0MLoHO5zTOFu29/dsSyHLVZtUPdbxEFcga
 Dl0UoR7umPAM7IhVkM7MNL2+tl4sGqLXesb9FeZCgWYwdHP2ZgOcuFPfL
X-Gm-Gg: ASbGncszRNK7Yg3kuvKyXQnFnO74sv+1nmsJa/Ha3qCCH1ahC9D5eZ2OYngdynpON2Z
 YLgK3J+5fE5/d/QdsO07g0ZMn6Y/nHW3LSXZgJB4GS8Ef2CwPNGB6aWXqUHKFle+TLzt/yudsPd
 NI5WXMuerThvcp0cgNe8Kf4JU9Juw9w5d0bf5RM6wPhIxT+mbMPtQnIqMcF1NygsefExul4Bnb4
 otpcLGNtcySZB0KUDYIn2UIFxqN3lNwNhZIWDNSLoNHh8gH2QEMpypTDmLhdGtf9aOmbLmRBkey
 ku+J5FrMqTn7Fm5hxCvwDdOLqR4RHGMq6jCNJczflX4IsyZ3HZoAtg/LvTA3bEBWpGA0pQ==
X-Received: by 2002:a05:600c:1d98:b0:450:d012:df7a with SMTP id
 5b1f17b1804b1-451f0b2c818mr22908915e9.28.1749043762218; 
 Wed, 04 Jun 2025 06:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvMKI1dxknh5BKz3n4T3J8PadTzJksKiHEk4yb0mPA/27k0SNofcBuhKidEmRrfJp0XAH+9g==
X-Received: by 2002:a05:600c:1d98:b0:450:d012:df7a with SMTP id
 5b1f17b1804b1-451f0b2c818mr22908705e9.28.1749043761657; 
 Wed, 04 Jun 2025 06:29:21 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa2493sm197073305e9.16.2025.06.04.06.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:29:19 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 17/21] iotests/307: Test multi-thread export interface
Date: Wed,  4 Jun 2025 15:28:09 +0200
Message-ID: <20250604132813.359438-18-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Test the QAPI interface for multi-threaded exports.  None of our exports
currently support multi-threading, so it's always an error in the end,
but we can still test the specific errors.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/qemu-iotests/307     | 47 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/307.out | 18 +++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/tests/qemu-iotests/307 b/tests/qemu-iotests/307
index b429b5aa50..f6ee3ebec0 100755
--- a/tests/qemu-iotests/307
+++ b/tests/qemu-iotests/307
@@ -142,5 +142,52 @@ with iotests.FilePath('image') as img, \
     vm.qmp_log('query-block-exports')
     iotests.qemu_nbd_list_log('-k', socket)
 
+    iotests.log('\n=== Using multi-thread with NBD ===')
+
+    # Actual multi-threading; (currently) not supported by NBD
+    vm.qmp_log('block-export-add',
+               id='export0',
+               type='nbd',
+               node_name='fmt',
+               iothread=['iothread0', 'iothread1'])
+
+    # Should be treated the same way as actual multi-threading, even if there's
+    # only a single thread
+    vm.qmp_log('block-export-add',
+               id='export0',
+               type='nbd',
+               node_name='fmt',
+               iothread=['iothread0'])
+
+    iotests.log('\n=== Empty thread list')
+
+    # Simply not allowed
+    vm.qmp_log('block-export-add',
+               id='export0',
+               type='nbd',
+               node_name='fmt',
+               iothread=[])
+
+    iotests.log('\n=== Non-existent thread name in list')
+
+    # Expect an error, even if NBD does not support multi-threading, because the
+    # list is parsed before being passed to NBD
+    vm.qmp_log('block-export-add',
+               id='export0',
+               type='nbd',
+               node_name='fmt',
+               iothread=['iothread0', 'nothread', 'iothread1'])
+
+    iotests.log('\n=== Multi-thread with fixed-iothread')
+
+    # With multi-threading, there is no single context to give the BDS, so it is
+    # just left where it is.  fixed-iothread does not make sense then.
+    vm.qmp_log('block-export-add',
+               id='export0',
+               type='nbd',
+               node_name='fmt',
+               iothread=['iothread0', 'iothread1'],
+               fixed_iothread=True)
+
     iotests.log('\n=== Shut down QEMU ===')
     vm.shutdown()
diff --git a/tests/qemu-iotests/307.out b/tests/qemu-iotests/307.out
index f645f3315f..a9b37d3ac1 100644
--- a/tests/qemu-iotests/307.out
+++ b/tests/qemu-iotests/307.out
@@ -134,4 +134,22 @@ read failed: Input/output error
 exports available: 0
 
 
+=== Using multi-thread with NBD ===
+{"execute": "block-export-add", "arguments": {"id": "export0", "iothread": ["iothread0", "iothread1"], "node-name": "fmt", "type": "nbd"}}
+{"error": {"class": "GenericError", "desc": "NBD export does not support multi-threading"}}
+{"execute": "block-export-add", "arguments": {"id": "export0", "iothread": ["iothread0"], "node-name": "fmt", "type": "nbd"}}
+{"error": {"class": "GenericError", "desc": "NBD export does not support multi-threading"}}
+
+=== Empty thread list
+{"execute": "block-export-add", "arguments": {"id": "export0", "iothread": [], "node-name": "fmt", "type": "nbd"}}
+{"error": {"class": "GenericError", "desc": "The set of I/O threads must not be empty"}}
+
+=== Non-existent thread name in list
+{"execute": "block-export-add", "arguments": {"id": "export0", "iothread": ["iothread0", "nothread", "iothread1"], "node-name": "fmt", "type": "nbd"}}
+{"error": {"class": "GenericError", "desc": "iothread \"nothread\" not found"}}
+
+=== Multi-thread with fixed-iothread
+{"execute": "block-export-add", "arguments": {"fixed-iothread": true, "id": "export0", "iothread": ["iothread0", "iothread1"], "node-name": "fmt", "type": "nbd"}}
+{"error": {"class": "GenericError", "desc": "Cannot use fixed-iothread for a multi-threaded export"}}
+
 === Shut down QEMU ===
-- 
2.49.0


