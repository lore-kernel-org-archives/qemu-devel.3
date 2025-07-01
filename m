Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161A2C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQo-0005Zb-5O; Tue, 01 Jul 2025 07:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQm-0005YL-NE
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQk-0003dC-TB
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4miDEcFeoLMzpknUkidzUiT3tY62ZBbQkI2NJpJaCbA=;
 b=Y1iSDwbnbJUoPV72i9CphkP486nnsKnt7MmY0W+soGk8NR1psWylnKR88/YstUrZvIZEbm
 V4TwYdbxEwkKdl+qyLxD/au3LYvv6dfHo12Qf9+7+eD03NSTEu0FWEFl4d3/yjI3M+I6Gg
 R0jM7bnMPypd0bP2qaoyI4Xe8O5zm04=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-sqi_68arMOGFrf7IZRz2zg-1; Tue, 01 Jul 2025 07:45:39 -0400
X-MC-Unique: sqi_68arMOGFrf7IZRz2zg-1
X-Mimecast-MFC-AGG-ID: sqi_68arMOGFrf7IZRz2zg_1751370338
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso1918926f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370338; x=1751975138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4miDEcFeoLMzpknUkidzUiT3tY62ZBbQkI2NJpJaCbA=;
 b=rtN6LSHgADriw7x4uJd4athL75XKh9mCMMqYH8Ts4X/Rm8PPZjQH6hV2wqUgC8ynaM
 d1Ap58hoE+w8egN3idWfDPOsVZU3MUp2cN1R7VRpw8jEixKafl2P4KBkFEk5dPXSJDG4
 EFSdAfV/ivLb4xs4PWKDxYlWS6sKVbgPsVybSUWrRF+6EX6Wd5meY+4FKgFym5g3OPls
 cMBGUO6OVFz2n7q/bOnWg+jmvNHt428anZfCUW3xVq45UMHFspSubalD9uQfMvFPaBeA
 SwGNV9UXKhtcjXvTd1MOjoMPu0HpGgc+VCuIn7wbQfEzB0Cj/74hz6nrmKxSB/EMG7fs
 aR+Q==
X-Gm-Message-State: AOJu0YzmnD6EvvO/7KWka0lrHNS49td+4i/7iqpZW1mRHKSU0Kts907t
 QLQiDpI8qMHwd1IwFqfDgc/oNMSlEdgUMRB+bAl1vydAsVwFdSBDNTgVFoHrlRVcbJDoIifuY8i
 NGs4GurgLxRkroF/ZVimrJZodUkGo7tmNHSSYbEv4Y31DQhuO4MSBJqda
X-Gm-Gg: ASbGncsXDrdInQZgb2/XWDl05CV7DXT2usgdbqAen4CTRh8oseTpE7+/DuaKSL7bXXa
 7w/93M/7hTF7yAH3mKlhGHq/0NdVfat9praXaK+zAuIrYI/WGnQQsdHLzFC9/BdWoxMBz8LcL+X
 4A9VoRfT3sD3tjWYhoa3oZBxoCRkbPXZ7OO7isHIGqI5ELTrnff/1ku0jfApSy0PbntzzOJpvR/
 nHJX8jwY0ZIVYc0lKQLToJrGy7O02HMNWK97AZ+mHG1iS4/X1REKBRNjDsZM8dY+pdyrg9otzNL
 148ozM3hTmOWaD4pbUuw0Cs6uDEtlFe/wA36/TkSo5v4Y0yZHZbymg0WAuwPksIy6qrKaknkS9Y
 ba9pW
X-Received: by 2002:a05:6000:1a8f:b0:3a5:541c:b40f with SMTP id
 ffacd0b85a97d-3a8f435e1c6mr14693127f8f.9.1751370338426; 
 Tue, 01 Jul 2025 04:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdyOJrCwa0ubmb30ykhye4/88RrVgFLz2TEVMayQUNJdMxh5VJ8LZYxRvx6LgwKJmvq68epA==
X-Received: by 2002:a05:6000:1a8f:b0:3a5:541c:b40f with SMTP id
 ffacd0b85a97d-3a8f435e1c6mr14693091f8f.9.1751370337938; 
 Tue, 01 Jul 2025 04:45:37 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52a35sm13228925f8f.57.2025.07.01.04.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:45:36 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 17/21] iotests/307: Test multi-thread export interface
Date: Tue,  1 Jul 2025 13:44:33 +0200
Message-ID: <20250701114437.207419-18-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


