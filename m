Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ACBC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 12:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trcA3-0005jI-Gz; Mon, 10 Mar 2025 08:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1trc9x-0005gg-AP
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1trc9v-0004xz-1C
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741609381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWKu7IdPiikQnaEb+/ecY7BEpPi35/LOHKqPa+4vPpo=;
 b=eXV3Qy1c5Fk/N5B6D/9RjD19OGfthTNkAtwaBXT9NCuN36KFWK1AF15ycfz/P3yL22m812
 IS4jFVEQKMha6/TlU78d7RbOVGqrwXq3o+Qa3PrGvBBRm/EdAdQwmxXNe3LWhRecgAoLAb
 0LWx+sdEesxRErDSPq1UpRMnfWEB/tw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-yHONpBx6ORKpPZBBDGbPaQ-1; Mon,
 10 Mar 2025 08:23:00 -0400
X-MC-Unique: yHONpBx6ORKpPZBBDGbPaQ-1
X-Mimecast-MFC-AGG-ID: yHONpBx6ORKpPZBBDGbPaQ_1741609379
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34B8C1800258; Mon, 10 Mar 2025 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C4F21800373; Mon, 10 Mar 2025 12:22:56 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 3/5] util/iov: Do not assert offset is in iov
Date: Mon, 10 Mar 2025 20:22:38 +0800
Message-ID: <20250310122240.2908-4-jasowang@redhat.com>
In-Reply-To: <20250310122240.2908-1-jasowang@redhat.com>
References: <20250310122240.2908-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

iov_from_buf(), iov_to_buf(), iov_memset(), and iov_copy() asserts
that the given offset fits in the iov while tolerating the specified
number of bytes to operate with to be greater than the size of iov.
This is inconsistent so remove the assertions.

Asserting the offset fits in the iov makes sense if it is expected that
there are other operations that process the content before the offset
and the content is processed in order. Under this expectation, the
offset should point to the end of bytes that are previously processed
and fit in the iov. However, this expectation depends on the details of
the caller, and did not hold true at least one case and required code to
check iov_size(), which is added with commit 83ddb3dbba2e
("hw/net/net_tx_pkt: Fix overrun in update_sctp_checksum()").

Adding such a check is inefficient and error-prone. These functions
already tolerate the specified number of bytes to operate with to be
greater than the size of iov to avoid such checks so remove the
assertions to tolerate invalid offset as well. They return the number of
bytes they operated with so their callers can still check the returned
value to ensure there are sufficient space at the given offset.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/qemu/iov.h | 5 +++--
 util/iov.c         | 5 -----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 44f9db5cee..9535673c13 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -31,7 +31,7 @@ size_t iov_size(const struct iovec *iov, const unsigned int iov_cnt);
  * only part of data will be copied, up to the end of the iovec.
  * Number of bytes actually copied will be returned, which is
  *  min(bytes, iov_size(iov)-offset)
- * `Offset' must point to the inside of iovec.
+ * Returns 0 when `offset' points to the outside of iovec.
  */
 size_t iov_from_buf_full(const struct iovec *iov, unsigned int iov_cnt,
                          size_t offset, const void *buf, size_t bytes);
@@ -67,11 +67,12 @@ iov_to_buf(const struct iovec *iov, const unsigned int iov_cnt,
 /**
  * Set data bytes pointed out by iovec `iov' of size `iov_cnt' elements,
  * starting at byte offset `start', to value `fillc', repeating it
- * `bytes' number of times.  `Offset' must point to the inside of iovec.
+ * `bytes' number of times.
  * If `bytes' is large enough, only last bytes portion of iovec,
  * up to the end of it, will be filled with the specified value.
  * Function return actual number of bytes processed, which is
  * min(size, iov_size(iov) - offset).
+ * Returns 0 when `offset' points to the outside of iovec.
  */
 size_t iov_memset(const struct iovec *iov, const unsigned int iov_cnt,
                   size_t offset, int fillc, size_t bytes);
diff --git a/util/iov.c b/util/iov.c
index 7777116123..f8536f0474 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -37,7 +37,6 @@ size_t iov_from_buf_full(const struct iovec *iov, unsigned int iov_cnt,
             offset -= iov[i].iov_len;
         }
     }
-    assert(offset == 0);
     return done;
 }
 
@@ -56,7 +55,6 @@ size_t iov_to_buf_full(const struct iovec *iov, const unsigned int iov_cnt,
             offset -= iov[i].iov_len;
         }
     }
-    assert(offset == 0);
     return done;
 }
 
@@ -75,7 +73,6 @@ size_t iov_memset(const struct iovec *iov, const unsigned int iov_cnt,
             offset -= iov[i].iov_len;
         }
     }
-    assert(offset == 0);
     return done;
 }
 
@@ -277,7 +274,6 @@ unsigned iov_copy(struct iovec *dst_iov, unsigned int dst_iov_cnt,
         bytes -= len;
         offset = 0;
     }
-    assert(offset == 0);
     return j;
 }
 
@@ -348,7 +344,6 @@ size_t qemu_iovec_concat_iov(QEMUIOVector *dst,
             soffset -= src_iov[i].iov_len;
         }
     }
-    assert(soffset == 0); /* offset beyond end of src */
 
     return done;
 }
-- 
2.42.0


