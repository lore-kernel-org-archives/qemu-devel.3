Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A635F4180B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcFb-0001u7-OL; Mon, 09 Mar 2026 11:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcF9-0001No-Ht
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:10:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcF7-0008Ta-Ck
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773069000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNvEZCKQBML5r/dspX+6G5O18jEO5qroU9rPnlPzYk8=;
 b=AXrq72qB/A0CPEKzJliOvxDsOd292vMDEEcWSThsJeSu4sdUydmihNcOW81bqxz6ZcMj7Y
 aSvgretfSuvopssTmMTjzVxwb2T6WTF7FBCLz+E2VGb+UiwpZ8pWdnZXqyOFXfEpm4VxM0
 JLaoFyHuXTf0eE+ZNnbFazofnG4e1Lg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-HMQN7ZShN7m17X3eKEUwSA-1; Mon, 09 Mar 2026 11:09:59 -0400
X-MC-Unique: HMQN7ZShN7m17X3eKEUwSA-1
X-Mimecast-MFC-AGG-ID: HMQN7ZShN7m17X3eKEUwSA_1773068998
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso138898795e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068998; x=1773673798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNvEZCKQBML5r/dspX+6G5O18jEO5qroU9rPnlPzYk8=;
 b=N8exZiqEagUDzUyj1VxYlFnefWhKAXfx2sWf8HYGezyh876kYJN2D8ddgbt5w8N7F+
 pP85PLGRSBGcsCQcUFUo3HH2AaSUVqJR+/81gka5MUGBsjFxSsVX9ZTHZEQNtYHbTHz+
 qe5CNxPMdcGH42kh4oqabeUgrIEtnLvU0fzOQxyQv2toffqClU/sX8/JhFj8tX9sCugu
 X/Hv9zV06XtB9t3ya24pS/lr1yLhrNpl95QfKksjmxcGV+47+5NB4hdj4YA9ZuHoayeM
 8TBsxLAMbR75PkQAUN4Jaa4nC5YYA7nxg0oZ2tfymNIBh6miptNKBrhhhL0ogRjfT1JI
 vYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068998; x=1773673798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sNvEZCKQBML5r/dspX+6G5O18jEO5qroU9rPnlPzYk8=;
 b=KRm8vwhXbE8HMrXCKY8Sn3u4BGN/7E3m26ByDuPcMSEBOPrWtT8pq7qeuwuQmhaI2z
 oVykNbofHvF+9lhJlJdZJMQvZtiNXVhhFm6c2N5wRl9uuMj0rvK0kW7dDvq1oJbHzFV0
 0E3mKVCRi2MGlOnV8/Yaro+GEmTXeBERIh1VIdlTgTWeSKYRp45XSrZky7uDRIp3h1kX
 DtNO0wN5/pnMQ/90i/by7ir4fK9QRqsljnIGARuUdZcC8hX9MJMxUgkSviy8bmeQm9Or
 uH9oab+6rquSZEktt1gw+2DoASOWqexgWP8kitxDQxwcbrzAkyEckzn5Ry92QbpZvYkg
 65vQ==
X-Gm-Message-State: AOJu0Yy5jBS6ggkgPazWfBOPi8uSRqKM3ccFN2f8jb8Qar9tuJ4w7kaw
 KRzZ1SPlyZLpBXDGPgrXZfj5kAWFLiTcNnXcnLaGYzjxSb6ENh/KhPnaqMwKOYpRfE0r+gN9jos
 yJOHu1hCru2T9CWxvvrX6d+uOE9F5lFCdw8P7IyI8y6OhCwxzlYUnXrUY0eXGFptm
X-Gm-Gg: ATEYQzzfDeehMsgJFzw8ThaUxBAIdcDg10FJP0pZrqvjG3voVgdvvbnbLn4ZlaCxZt5
 HIVPT2vhxWky1fscOSuVZG9URNyUdimT1m8FzZrY/9LJZDfYcpFbpB7KsOOnGiMe94Wz4SajyhO
 6N+SY/9qiSPinmNDdi3mHF+VM8renRUAp2bC9vSXV02N+ez6J4+V0LKUCWyw2LxYPetUvFPyKLu
 keYzAhm9ZfiPudePgeiEPhNaJBETyZpGGy/cDR3zicgLNuMRAiVpqjHmKR+Bx0JQc6kD30mb62W
 LREDI41crBovIBxx9HKEU+wehn/8DS1CJ0BL+ALA1VSLkgM2Vtq4JmXWl2icxtL4n+amY1jLu2R
 ZlY9+qtxrBNwxnXQST/0III9OuLMmMdvNl65Gkhmr6DkXWPbmmFAG1w7ariKPUdCszil3Y4Wrz/
 l4yUZO
X-Received: by 2002:a05:600c:a0d:b0:485:1878:7b8c with SMTP id
 5b1f17b1804b1-4852695b6fcmr184342135e9.18.1773068998028; 
 Mon, 09 Mar 2026 08:09:58 -0700 (PDT)
X-Received: by 2002:a05:600c:a0d:b0:485:1878:7b8c with SMTP id
 5b1f17b1804b1-4852695b6fcmr184341545e9.18.1773068997581; 
 Mon, 09 Mar 2026 08:09:57 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852f6994a1sm159561035e9.9.2026.03.09.08.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:56 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 21/25] iotests/307: Test multi-thread export interface
Date: Mon,  9 Mar 2026 16:08:52 +0100
Message-ID: <20260309150856.26800-22-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


