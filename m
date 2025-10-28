Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4145CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmee-0008Ft-9g; Tue, 28 Oct 2025 12:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeJ-00085N-NW
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeE-0003cw-Ol
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSxoatfzMDx1FQebyVCdNFm5edJW1MYIL+ghwwVgSOQ=;
 b=BIE8iGJG5cyS8DoF3bE89oQ2nXDkB+ixA9voyP+7Fvh5+yhzZrENRAVcpyHEp2L4rnr29b
 nb8ZRiwk+JO9qRq63wUylipPb0Yk3AedQg9ypDFvXi8Rw+N0KHk5UER+5WMXUi49mz2lNs
 /SGf4G/i3Js6nmitSmIzX5uQoVLfyC8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-0KjXFGZZOiuKF8KhynkSow-1; Tue, 28 Oct 2025 12:34:11 -0400
X-MC-Unique: 0KjXFGZZOiuKF8KhynkSow-1
X-Mimecast-MFC-AGG-ID: 0KjXFGZZOiuKF8KhynkSow_1761669251
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-426ce339084so5874113f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669251; x=1762274051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tSxoatfzMDx1FQebyVCdNFm5edJW1MYIL+ghwwVgSOQ=;
 b=TmIYIsgCaLvqIn7DcJccnsQ61KZG49Ss3wFfnzYdS5bm0kYbG/T54+mV7UKQmEoFQM
 GNUZF0DRAhr4q1KPvLLI0NZzI2BCZcjHU/wuMgovDZjpDyD6uFvnJ61BGgebnl0aLxMe
 2JiY4yfGb7DJGjMHR+/zjt7T4tpz/Ii0KWgNe1JtS8VuEnG6seJilVGjaT+QhzqgHLl3
 ipXnIkgBi/DC+IkHS7lXu2LSvBrjr5toI2CX5adyFD5glqWUae4yjNj/73nBIg3+w4Fo
 Vi1MN8aVWvxk70PVJQL9snyzwcVqCItONjGCz5u8hLgGzAhpQ13ImBRGgrHiIXUKLCOA
 +xhw==
X-Gm-Message-State: AOJu0YwpBmzGyo0TW0H0cFgON9/9SasXYvHYOY22PQz/u2QZiUCb6zYS
 wpaEH+rvi+DwD73257ztoY/a5ltEDhUaC8RlH9AcBhII3fNdFPu0MFitX4vOhPMeYP15GFnBpQA
 xOYkFPLgAVvqyQkTRCWQmH81UtVEFeiFyPcLKA8eJyokcLCh9frP+4Tep
X-Gm-Gg: ASbGncuDOy6p3z7OlDM29pIJ2HImd2sGWPCVem1TL0tHBjcnQV0WW4ftWe15Mvq5RaE
 hBm2XcEz2FU1+ai14zjEIENaRGst7fpp5GxtbJLAEiu9Q5L/NVnd8P8U9Gs9gGezvo/gYEN3+Wt
 rGhXIn1dLXGhnosyGqRWfaemv69P2p7Wpcz/erEnXRjXOYl1ZblXMBpy+kd4IihJYPdJ827LrRk
 wtyH5Tl1DEqN3+Nwj3qTaBof+Oz631lsGpFgNj1omsc5+DsplC6GQ6QKv9+uOmWJZFI6JYRxX6Y
 UzdAK+RMkjzBzV64d/dNDktxVqEUg+iT8MOOIhjPgTsJc+UGaSjZv4FlTt8F53H7o+RtHZoZxTT
 JyND6MB6EqBuKFJzSYKgRP1vzokK2Fy7/hzjGe1sVQxyuw86HrPgxVTid9A==
X-Received: by 2002:a05:6000:2203:b0:428:4004:8241 with SMTP id
 ffacd0b85a97d-429a7e7a0cfmr3969482f8f.40.1761669250659; 
 Tue, 28 Oct 2025 09:34:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2+ewm7VHCtLLYz9cH7gOPSYYbQqSCMh7D7394XVxx5QepaxmUdddXXKSFR9JTD7DTITjuSQ==
X-Received: by 2002:a05:6000:2203:b0:428:4004:8241 with SMTP id
 ffacd0b85a97d-429a7e7a0cfmr3969446f8f.40.1761669250205; 
 Tue, 28 Oct 2025 09:34:10 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5768sm21837119f8f.24.2025.10.28.09.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:34:08 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH 07/16] nvme: Kick and check completions in BDS context
Date: Tue, 28 Oct 2025 17:33:33 +0100
Message-ID: <20251028163343.116249-8-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

nvme_process_completion() must run in the main BDS context, so schedule
a BH for requests that aren’t there.

The context in which we kick does not matter, but let’s just keep kick
and process_completion together for simplicity’s sake.

(For what it’s worth, a quick fio bandwidth test indicates that on my
test hardware, if anything, this may be a bit better than kicking
immediately before scheduling a pure nvme_process_completion() BH.  But
I wouldn’t take more from those results than that it doesn’t really seem
to matter either way.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/nvme.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 8df53ee4ca..7ed5f570bc 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -481,7 +481,7 @@ static void nvme_trace_command(const NvmeCmd *cmd)
     }
 }
 
-static void nvme_deferred_fn(void *opaque)
+static void nvme_kick_and_check_completions(void *opaque)
 {
     NVMeQueuePair *q = opaque;
 
@@ -490,6 +490,18 @@ static void nvme_deferred_fn(void *opaque)
     nvme_process_completion(q);
 }
 
+static void nvme_deferred_fn(void *opaque)
+{
+    NVMeQueuePair *q = opaque;
+
+    if (qemu_get_current_aio_context() == q->s->aio_context) {
+        nvme_kick_and_check_completions(q);
+    } else {
+        aio_bh_schedule_oneshot(q->s->aio_context,
+                                nvme_kick_and_check_completions, q);
+    }
+}
+
 static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
                                 NvmeCmd *cmd, BlockCompletionFunc cb,
                                 void *opaque)
-- 
2.51.0


