Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80549C3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6oi-0004vT-OY; Tue, 25 Mar 2025 12:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6oP-0004Zm-5W
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6oN-0007SQ-47
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gh+riUJHAn43i3neBpAg2kBaqXyzek2lfyG6O1xMac=;
 b=EGVbQHfMX60THwjfqEH5cRQJs78GQ3QodrOyvSSSChSC4TLn+W02AAyaM1U5xaYucEzvv/
 arilaS01RGjF6OCvwypPOsQSjMvpA6+5SzjQ4Vp52eCVkv7kkJra56fKcM8jOASnxs1qqD
 PWpP7dSM+CHyUXCzml75H+t0FoemveI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-I8NwrMEjMb2gAv-656oELw-1; Tue, 25 Mar 2025 12:07:26 -0400
X-MC-Unique: I8NwrMEjMb2gAv-656oELw-1
X-Mimecast-MFC-AGG-ID: I8NwrMEjMb2gAv-656oELw_1742918845
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39131851046so2517744f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918845; x=1743523645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gh+riUJHAn43i3neBpAg2kBaqXyzek2lfyG6O1xMac=;
 b=l1vdMMF4LdzXLY9U6viGGEci1ZA52z9Nz6UVRr+Nip4UqYRNjHPtvfcuBAUZgyDyqm
 j7+AHgpX70PeqtxU4dKR4XTqnC/4oPPl0Z+hcHbg71TfKOAJIlKbf3XFme99YCFT2Uth
 2Z9o0Ge/7Ovzpw5Hz5XpVS22SoLnDOq4fMnwbSe7pDubXU5VNoQZD0195WLue+IWw1kJ
 8XJpm8pXZQv0nzTbNRpyOtrD4obON/3UtoD1WCMNvvReGnGqwJe6tBSfqF9fSA+7Ig9y
 G1IvR9eFI6RM8oK/pb9qeKV4dLGs3nSWpU3gxV3eo8ap3fKD1sQyDFxS/xkdS+EBumJh
 av/g==
X-Gm-Message-State: AOJu0YyyF5ULO2WaPA/OmLHtk9vFkvTd8qKoFE6MKEyqmNEEIFQ5bPTj
 9FAUeHrANokYj85fqX8nB2ODZ0DS3GujoZPvEyrO2/WI5fyftOTyBh8rHYApvqrsQ31j1CL5GI5
 DGGABVH2UEUiEDcwUS66WATdIdQs8DFmIlLAPOWANvhF55C+bM2hv
X-Gm-Gg: ASbGncunhfjF+32Rm4MXQSxLAuabOt+4GDPD2dTjpONbrsS2HdXwKxYtSKDyjOrQRsQ
 xfAa259Kw6SdEioVQtFOWM4CuzxjiqYIX/29gxgPkpUHl3MtiKPPy87vPbD3Xjbfs2isfDhNz7h
 oZeOFv2bu/zOiR/5YUeOrUq4E2KyNUcAfflxdKL5OlX5rCyXEGkZyn4XA8mWA1bY+8gsVhcqGQl
 cNXtab8XfgFGJNWpes/AwY4cMKw0uJyA1NV36ytKk3F/klXjPFT4Vxr2uQBXVxhaBr0J/+LLfs2
 Cw/yf6jaSJYDNmH78WAKeEggV+hDle6wkRL6RIAeU1faeMgEcrmRRZL9fIcjNtLG2HdK0rjbOA=
 =
X-Received: by 2002:a5d:5f8c:0:b0:391:275a:273f with SMTP id
 ffacd0b85a97d-3997f8f6089mr14869808f8f.4.1742918845110; 
 Tue, 25 Mar 2025 09:07:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5D0xrWkxlEClrr2p2DL62m+X3C+u0kcvDOMwMgPl9A6x+og7fc3oMXy9l4SSs2p5R7lp33A==
X-Received: by 2002:a5d:5f8c:0:b0:391:275a:273f with SMTP id
 ffacd0b85a97d-3997f8f6089mr14869757f8f.4.1742918844634; 
 Tue, 25 Mar 2025 09:07:24 -0700 (PDT)
Received: from localhost
 (p200300cfd74f9db6ee8035b86ef736e5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9db6:ee80:35b8:6ef7:36e5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed793sm209097485e9.39.2025.03.25.09.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:07:22 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 10/15] fuse: Add halted flag
Date: Tue, 25 Mar 2025 17:06:50 +0100
Message-ID: <20250325160655.119407-9-hreitz@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325160529.117543-1-hreitz@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a flag that we will want when processing FUSE requests
ourselves: When the kernel sends us e.g. a truncated request (i.e. we
receive less data than the request's indicated length), we cannot rely
on subsequent data to be valid.  Then, we are going to set this flag,
halting all FUSE request processing.

We plan to only use this flag in cases that would effectively be kernel
bugs.

(Right now, the flag is unused because libfuse still does our request
processing.)

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index e50dd91d3e..3dd50badb3 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -53,6 +53,13 @@ typedef struct FuseExport {
     unsigned int in_flight; /* atomic */
     bool mounted, fd_handler_set_up;
 
+    /*
+     * Set when there was an unrecoverable error and no requests should be read
+     * from the device anymore (basically only in case of something we would
+     * consider a kernel bug)
+     */
+    bool halted;
+
     char *mountpoint;
     bool writable;
     bool growable;
@@ -69,6 +76,7 @@ static const struct fuse_lowlevel_ops fuse_ops;
 
 static void fuse_export_shutdown(BlockExport *exp);
 static void fuse_export_delete(BlockExport *exp);
+static void fuse_export_halt(FuseExport *exp) G_GNUC_UNUSED;
 
 static void init_exports_table(void);
 
@@ -99,6 +107,10 @@ static void fuse_dec_in_flight(FuseExport *exp)
 
 static void fuse_attach_handlers(FuseExport *exp)
 {
+    if (exp->halted) {
+        return;
+    }
+
     aio_set_fd_handler(exp->common.ctx,
                        fuse_session_fd(exp->fuse_session),
                        read_from_fuse_export, NULL, NULL, NULL, exp);
@@ -316,6 +328,10 @@ static void read_from_fuse_export(void *opaque)
     FuseExport *exp = opaque;
     int ret;
 
+    if (unlikely(exp->halted)) {
+        return;
+    }
+
     fuse_inc_in_flight(exp);
 
     do {
@@ -374,6 +390,20 @@ static void fuse_export_delete(BlockExport *blk_exp)
     g_free(exp->mountpoint);
 }
 
+/**
+ * Halt the export: Detach FD handlers, and set exp->halted to true, preventing
+ * fuse_attach_handlers() from re-attaching them, therefore stopping all further
+ * request processing.
+ *
+ * Call this function when an unrecoverable error happens that makes processing
+ * all future requests unreliable.
+ */
+static void fuse_export_halt(FuseExport *exp)
+{
+    exp->halted = true;
+    fuse_detach_handlers(exp);
+}
+
 /**
  * Check whether @path points to a regular file.  If not, put an
  * appropriate message into *errp.
-- 
2.48.1


