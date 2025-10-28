Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D95CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmec-0008EJ-Vp; Tue, 28 Oct 2025 12:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeK-00085x-FF
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeD-0003ap-9h
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bHq9mmLlrYs9rcZFc5mEPJ7OIilm7sukDYP8D9Whs5g=;
 b=UZfJYUQpEorIsiyakVZO0v4x0vWcXSPhyY7aqiztxUpnTz5i0TyXboG2knV+mzFqrCYRxi
 08ZgacYUZ75HuQ5178vl2em6XRJP/wwXjfgr4BHnSwbP8ghjw2dRSTpxWSoN2Ua04MRghH
 ZyjTsBWQDcuaOA5nNPDKgnEs3t5DIwo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-lA01VmRHPA2PdcMlJczPGQ-1; Tue, 28 Oct 2025 12:34:09 -0400
X-MC-Unique: lA01VmRHPA2PdcMlJczPGQ-1
X-Mimecast-MFC-AGG-ID: lA01VmRHPA2PdcMlJczPGQ_1761669248
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4770dea2551so64727835e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669248; x=1762274048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bHq9mmLlrYs9rcZFc5mEPJ7OIilm7sukDYP8D9Whs5g=;
 b=t1c9HwLD6OGwpxOfEw+1JwDBRAAOAsH47NeiCZSgU33v54PbUek2gTXNP3iEqoOoQU
 3THr7kgrdtqTOITFLjJOozqoShwg9HdDugmm4yY1Onwq8CwLoHc85gYBSmoEY/uNMEDd
 4TXQ3YaDDqZ0Mfk/Fc2i50yuAS9qcQB/hlPId2B0fQXeYoIDM8So/0Vu6dGwv/0Vng+p
 /d6Eu+2FQUBqFjrh0dhaSw0LSjpp8IV4MOgFcmltyFa8yF50g3z4QW75cVc3qjYQamRl
 il0571EM8okqko8FxUeylgkIyBvAeeMVSI0ZgSVjE5T+Bp68riazDhWhWg0o+CYifOs2
 ciBw==
X-Gm-Message-State: AOJu0Yw2bz3Cdq9uyHP9LSh180EQqZMJAdEqt1jpDTrQ237Gj7tHI4co
 03HVkn+F45/Kxix3kpCPHAFJHWgUfdmJEUM8VNND8jQ5d28YMKPtgySsDsChrKgZZeBXg66EpEd
 192GeU5sl8hQzK8JdmIywONbCNDTPjhTsBbtALjRThPFsrw/bjDJhaDTT
X-Gm-Gg: ASbGncvCoEYlUzgD5jZzcwv8oJiSdoJZrUnzbb/ndiEOYV2922Rl7qd8/hSFpIcxpuy
 WKMJAnjtOnEAwyLpX13IOIcVV4lxgjVMwdUXfY7VdeB4l49JCGo4NFAgv0g96LPCT0KwOdr5S4K
 uF01TNyINwG++eDkY/sLNYSyyzYaIOVGrFlbM2YTA14guiwu2fEppryiS3i7CqeSENmUnOmXgnC
 2vcydOtfopGoM0k9zdOClALI254oZj4wYIwmW/ZK3Vv383glQo5N89mMJRVKOyrNRua7Q4qNdPG
 rPpRavigWh2rf/EbANRxDAKrkz7iq0YtjVV0xzF581PE6L9NhlfBAKzfI3+pn7hCzDyCM6hfyJO
 tKs1ebSBJHMuIMKuoN2kUjEI2v3e/zlJThEhnNZOvu52SeRUaaAMtgIaISg==
X-Received: by 2002:a05:600c:4ec8:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-4771e18d791mr1188445e9.17.1761669247971; 
 Tue, 28 Oct 2025 09:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFScE3eHeyARGVLAKjMGFdU+ElWS1sPV1QuWOU4oXxhPd5Src8DwUHVXB9YzJdUAGOEiG4ByA==
X-Received: by 2002:a05:600c:4ec8:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-4771e18d791mr1188105e9.17.1761669247478; 
 Tue, 28 Oct 2025 09:34:07 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771904fc1bsm22117125e9.11.2025.10.28.09.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:34:05 -0700 (PDT)
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
Subject: [PATCH 06/16] gluster: Do not move coroutine into BDS context
Date: Tue, 28 Oct 2025 17:33:32 +0100
Message-ID: <20251028163343.116249-7-hreitz@redhat.com>
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

The request coroutine may not run in the BDS AioContext.  We should wake
it in its own context, not move it.

With that, we can remove GlusterAIOCB.aio_context.

Also add a comment why aio_co_schedule() is safe to use in this way.

**Note:** Due to a lack of a gluster set-up, I have not tested this
commit.  It seemed safe enough to send anyway, just maybe not to
qemu-stable.  To be clear, I don’t know of any user-visible bugs that
would arise from the state without this patch; the request coroutine is
moved into the main BDS AioContext, which feels wrong, but I’m not sure
whether it can actually produce hard bugs.

I’ll leave it to others’ opinions whether to keep or drop this patch
under these circumstances.

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
2.51.0


