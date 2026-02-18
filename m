Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A59E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfv-0004Uv-8y; Wed, 18 Feb 2026 08:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfs-0004Tg-IU
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:33:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfq-0006Gr-6F
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNvEZCKQBML5r/dspX+6G5O18jEO5qroU9rPnlPzYk8=;
 b=fv90111kYsykrqv7n38ENW24g+LNcZHmK4DoHmCe5b8N6pzsAkgZQam9JDxzPFu3q2VjBL
 ejVTd1kzzQfT0ohk+zDpES8/6AZwrHvveAezRjYz3AcHXhHtnRgO0PtBcQcwjXI9aOdqbf
 irVsML3RwG5Lxwbjv9V65IzB/AGjQR0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-W5f0M2MqPl-0YwikU6JvrQ-1; Wed, 18 Feb 2026 08:27:35 -0500
X-MC-Unique: W5f0M2MqPl-0YwikU6JvrQ-1
X-Mimecast-MFC-AGG-ID: W5f0M2MqPl-0YwikU6JvrQ_1771421254
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-437812b8bb0so3427380f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421254; x=1772026054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNvEZCKQBML5r/dspX+6G5O18jEO5qroU9rPnlPzYk8=;
 b=URyUR9rx3NzPOkIT1chhZgt1JJn1AEuXlgJaUUW3mTHEharwQfEmGNt3UiKKhC+FEU
 QAxguTq3qjVYcv94223krUYFqMbZE7ivDnIqO4v15/NvVnln6bJSkAR26PogGbdUnLrU
 MQtuhsE7XVtga6aBJa/evyS/Ylkvjd7nEYs4On1Ufivx1UIbVL/PzelKHWePNpT3U/DL
 3eT7NfvzSlbQn075eqsPp1WTXq/VrbwKMwrbhNLg3A0WpVTSo+1Yyextw3bFkbE1biby
 4SVsudHOwagtXnNgQQiTYwmtf4u4qwGy6WcW2QYp/aenXfCCQ5m8bCW60aH270mihrsq
 jVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421254; x=1772026054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sNvEZCKQBML5r/dspX+6G5O18jEO5qroU9rPnlPzYk8=;
 b=cZhqr7wobwMBnx/nG6BP3UJO2VPm97SsseIlc3E6hq45GejYOynti8H6h5mZQM+1G4
 XsF74GJFnR+I1kpqR/kKmZUx8a+neMffAOExa6K1aIddZCEA4JT13UOzGv2f3TUi32Cb
 r+YLxQMJTSsw0/e+MNlEfNwOtGBME7JmsHBgFpYUWiDysMMYdy4S9lTkHl3+GoIsouTx
 5ykAdsMDn2EkjO4kqJAacykpIVqer/k0RAqaFvRFrA9/Mcx9xYq55kTBV2B+CeehSZny
 02VV//9SyHQzi+O+/RMKpTu7jsQj+RQESXwxf3nxfmJx+kkLytziWzer67HNekxbv1Tr
 DF3Q==
X-Gm-Message-State: AOJu0YykRvrz2ryPXh5TEBHjhuOP3s3O7huX3SLfcKOmWYEPRCiGlhKo
 /YfzSM5cCLBOlfB3fFitiGqecvM0qUnyIjLrpp+8eXpCmTFtmMsSDrGxrZ9NuQ0pU7PRmOUYDDI
 zZwn7v58Ga7UK8008AfkAUgxMD+XXDig9/nh+uM8j48Bq2noCXNAeoZ8k
X-Gm-Gg: AZuq6aLXjOUeMAPILBqyhI0IRaY6bvE8DYAZvAO3lDP0Fy+j/2v6zmA+/I8yMKbSb3L
 WXpuV0YiE3f9L+cLjBOR4oChZvrsAL9CXbgzQ35LvglovlrEht9wAeF+EMmDyW/FnTzfyuoWS2z
 BI8dnLCS6OuQ1AWJintnmXR7CoTLmPXZjkAHvJ5AEKhT5u00fbvG8kzRqY+hWz0f4uhWEWz4nQD
 +YSCXN6gdf/7xWu0SSYGp3oICAE0fhIEnNJL2hk7w0M/BrFxezuU+FXoKEyEEIc12TqiSzI1zlH
 YGChuAba6/mlJZ1g9UzeS1fMK9fNpmj/R2xQbJX0EFBhGIMHJ6jpv5e2YEuoFNiKyI5xIkedI4i
 E/OQAgP+XPxGyOCiY5Rb0SEA5tLQD+qTkJZPl75prrIynUOoX6GWQzNhYRjGZcUHVAt9bcgM81p
 MHiHQC
X-Received: by 2002:a05:6000:2482:b0:432:586f:2a9d with SMTP id
 ffacd0b85a97d-43958e3bdffmr3519284f8f.32.1771421254216; 
 Wed, 18 Feb 2026 05:27:34 -0800 (PST)
X-Received: by 2002:a05:6000:2482:b0:432:586f:2a9d with SMTP id
 ffacd0b85a97d-43958e3bdffmr3519217f8f.32.1771421253744; 
 Wed, 18 Feb 2026 05:27:33 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d46sm42800451f8f.32.2026.02.18.05.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:32 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 20/24] iotests/307: Test multi-thread export interface
Date: Wed, 18 Feb 2026 14:26:29 +0100
Message-ID: <20260218132633.29748-21-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
2.53.0


