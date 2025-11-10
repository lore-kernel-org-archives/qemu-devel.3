Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6848ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU93-0006Il-Vn; Mon, 10 Nov 2025 10:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU91-0006Dn-Aw
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU8z-0000x8-Qb
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nqhZesfJg+z3U8THtkhPVMymF7wZcq2zgdkzZ1bqHh0=;
 b=KvldD4JZGhkKAFQmkUib/NQ5tN+WUl+f5ONS8UI6cMvrkOCCZpzBA4+2GZtFuk/zcwayq4
 tZTQDEiSb+H2xXy9papaj3mD1I8PW3y21Oo6R1qgZGVa7M8LFhWkTUbdCmhnkCbs6JoMdB
 ByloQgzrOSKxKvfmCFXx4wf6tCR5KeA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-BHK2hOWROyCfRlhiZFKc2A-1; Mon, 10 Nov 2025 10:49:23 -0500
X-MC-Unique: BHK2hOWROyCfRlhiZFKc2A-1
X-Mimecast-MFC-AGG-ID: BHK2hOWROyCfRlhiZFKc2A_1762789762
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477632c240bso29447445e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789762; x=1763394562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqhZesfJg+z3U8THtkhPVMymF7wZcq2zgdkzZ1bqHh0=;
 b=e39vd3/RfRuL8ssF+cpv2fXUMGFAa9va5c3MWdSmCE1h2NoWHiRWw79e2FOO+yArIf
 MilAvFNjE1lTJOgobXj+UNWbCNZJESwa9Wp4cwcIXzIVDVZ2tyUOu0WurDGdUm1JwTgH
 O/DwFEKmcvKDxcKkPxFkvhOz4QeQTtyiCnMoXs6pOOE3AXD1Np09Q7vrwiSPWw/703Rw
 FS1K0Rhqz0jOikAjIbrBr89EPwQTXrIKE6dGjTSV//Zgv7wbJBtv2uFcyLfu1UG68cFp
 2W133KJ7CEO1thDg1klQBBySuMqH1M4wFq0XXePLDAl/3f5PJmwIl5BsPoCLt/5Ah7NA
 Jt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789762; x=1763394562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nqhZesfJg+z3U8THtkhPVMymF7wZcq2zgdkzZ1bqHh0=;
 b=D7TBptwvzi/uoxUT+/r/XDkoIv4/SNjSmbXsxxfH35crVOMhaau6TOaV4b95auNYyF
 JB7Z3c6qlt8TSseghUmpAO4CqIJdLoEaywtn+oZ8skLvoAu7TBWzx0u8HniyWw5/ufKk
 vjwvkLACowmY0tu4zvVfCNQ8ZnLi3g5cRgi4/0uS4jv7U+pwei8WRSLhmIOGKGrv9WFS
 7bXidSOkJ1zIQYzhfINCzD2LCN0ub5tRMHuSMzBKAuc6A5cJUAEnSCS9aZy7dMEsqilE
 SPj4BhUvmLCqS847lS4u6Y12/m1VuXwmJKlQMSrICrT0dat+Dfc4lX2f5X79h2GkKoZE
 0bhw==
X-Gm-Message-State: AOJu0YwgQCKKv4aArFRA75P96nhtFNTgnXPQ1GEtMiUdJRefBJB+W5Te
 0Ey7OUrVfbVdmrzd0VgI2GFzFaluq/9trokA/o/S72BfLE3gQ8OysAmnkPY72h4II31rlAy61CQ
 03oPXotV+RfDPZCVpEEq5YkSBCRPBnx7Ex79VY3CQAccTqBlNKOou02/1
X-Gm-Gg: ASbGncvucllmlK98o272vJ/wJZYcx+mj79RDThDFVpSbjlyGlRRetqBLyk0oNOqN5cV
 45P5P5kFsHI53VRL4/UkI1wmlBbTSBv6cphIt7gqx378ofQvNaels1teYeYidSui4twdwhmkdQ2
 Ls+boyM4HfeT68u7AEYZEDF++mN4n2xlk1UBq9nMCZXslfALfhkQZ3waF6v24bKKe70u8zrmkMA
 kPEEkW3PE5ypJ5QRpoL7oSHIKzU6ybjp6sue5OeedLS1k68bmNf6cJbT3UrSft5Ma+mf/iweb4+
 pkAl8gNjcKB2O/AHWFS2T4LlK+zcrxKeVLxOcU9goL4s4vBVQEgDVLXssaM3NtX9aITJWxYR5VY
 xzwcBGeAeiPCmJ7xAs+DTHtgMs1YpflHwHB1s29XtBMKRrkfCSltHFQ1kxw==
X-Received: by 2002:a05:600c:35d1:b0:477:7d94:9d05 with SMTP id
 5b1f17b1804b1-4777d949e90mr26984185e9.35.1762789761742; 
 Mon, 10 Nov 2025 07:49:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZExgFwiUxE1AUva6CmMz2LTGjZWaUziDKl4XN59PsAtzc5wzdD16+HlBbXn89wq4jeby4Rw==
X-Received: by 2002:a05:600c:35d1:b0:477:7d94:9d05 with SMTP id
 5b1f17b1804b1-4777d949e90mr26983775e9.35.1762789761330; 
 Mon, 10 Nov 2025 07:49:21 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cd45466sm323132855e9.0.2025.11.10.07.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:19 -0800 (PST)
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
Subject: [PATCH v2 06/19] gluster: Do not move coroutine into BDS context
Date: Mon, 10 Nov 2025 16:48:41 +0100
Message-ID: <20251110154854.151484-7-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The request coroutine may not run in the BDS AioContext.  We should wake
it in its own context, not move it.

With that, we can remove GlusterAIOCB.aio_context.

Also add a comment why aio_co_schedule() is safe to use in this way.

**Note:** Due to a lack of a gluster set-up, I have not tested this
commit.  It seemed safe enough to send anyway, just maybe not to
qemu-stable.  To be clear, I don’t know of any user-visible bugs that
would arise from the state without this patch; the request coroutine is
moved into the main BDS AioContext, so guest device completion code will
run in a different context than where the request started, which can’t
be good, but I haven’t actually confirmed any bugs (due to not being
able to test it).

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/gluster.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 89abd40f31..4fb25b2c6d 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -56,7 +56,6 @@ typedef struct GlusterAIOCB {
     int64_t size;
     int ret;
     Coroutine *coroutine;
-    AioContext *aio_context;
 } GlusterAIOCB;
 
 typedef struct BDRVGlusterState {
@@ -743,7 +742,17 @@ static void gluster_finish_aiocb(struct glfs_fd *fd, ssize_t ret,
         acb->ret = -EIO; /* Partial read/write - fail it */
     }
 
-    aio_co_schedule(acb->aio_context, acb->coroutine);
+    /*
+     * Safe to call: The coroutine will yield exactly once awaiting this
+     * scheduling, and the context is its own context, so it will be scheduled
+     * once it does yield.
+     *
+     * (aio_co_wake() would call qemu_get_current_aio_context() to check whether
+     * we are in the same context, but we are not in a qemu thread, so we cannot
+     * do that.  Use aio_co_schedule() directly.)
+     */
+    aio_co_schedule(qemu_coroutine_get_aio_context(acb->coroutine),
+                    acb->coroutine);
 }
 
 static void qemu_gluster_parse_flags(int bdrv_flags, int *open_flags)
@@ -1006,7 +1015,6 @@ static coroutine_fn int qemu_gluster_co_pwrite_zeroes(BlockDriverState *bs,
     acb.size = bytes;
     acb.ret = 0;
     acb.coroutine = qemu_coroutine_self();
-    acb.aio_context = bdrv_get_aio_context(bs);
 
     ret = glfs_zerofill_async(s->fd, offset, bytes, gluster_finish_aiocb, &acb);
     if (ret < 0) {
@@ -1184,7 +1192,6 @@ static coroutine_fn int qemu_gluster_co_rw(BlockDriverState *bs,
     acb.size = size;
     acb.ret = 0;
     acb.coroutine = qemu_coroutine_self();
-    acb.aio_context = bdrv_get_aio_context(bs);
 
     if (write) {
         ret = glfs_pwritev_async(s->fd, qiov->iov, qiov->niov, offset, 0,
@@ -1251,7 +1258,6 @@ static coroutine_fn int qemu_gluster_co_flush_to_disk(BlockDriverState *bs)
     acb.size = 0;
     acb.ret = 0;
     acb.coroutine = qemu_coroutine_self();
-    acb.aio_context = bdrv_get_aio_context(bs);
 
     ret = glfs_fsync_async(s->fd, gluster_finish_aiocb, &acb);
     if (ret < 0) {
@@ -1299,7 +1305,6 @@ static coroutine_fn int qemu_gluster_co_pdiscard(BlockDriverState *bs,
     acb.size = 0;
     acb.ret = 0;
     acb.coroutine = qemu_coroutine_self();
-    acb.aio_context = bdrv_get_aio_context(bs);
 
     ret = glfs_discard_async(s->fd, offset, bytes, gluster_finish_aiocb, &acb);
     if (ret < 0) {
-- 
2.51.1


