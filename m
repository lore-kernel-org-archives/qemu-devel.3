Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E665F4180B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEu-00012O-9A; Mon, 09 Mar 2026 11:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEs-00011T-DZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEq-0008PL-Pf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xXGf9wQuXiSKLxPb3FYIBG/K87QsiFd36ndnCqGkII=;
 b=fLQ+GQplGHP3p6Z7uGoI2IVgV6LJ9xw/+0vhgAnHbMmFHRmig7sO28ycfJ05LQcBGWO8AR
 /6qPcLYnBOOim9OX3Zk6N7kyj+HzmCxzP+qzXrvuzz+SwLwHvLosTNu5+43tky6CTGXTKV
 rUmPTxi+VqdIdRkTXxEmpYwsa4Fhbbk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-LupnWIeUN--q_pRA87t46g-1; Mon, 09 Mar 2026 11:09:43 -0400
X-MC-Unique: LupnWIeUN--q_pRA87t46g-1
X-Mimecast-MFC-AGG-ID: LupnWIeUN--q_pRA87t46g_1773068982
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439da07c5bfso2601790f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068982; x=1773673782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xXGf9wQuXiSKLxPb3FYIBG/K87QsiFd36ndnCqGkII=;
 b=DpgqGevAQ0PGt1RAw82xCF0+fPv/P4k5cA+GhhoBsVNUBKein3yG6LVWGw5yrnu2WZ
 WlJp4CegF0eYa4dD/fL4avihMfY0yZX7nNpn3JMa2QZMVRc154cHGOM1lqhK8HRc2gAE
 vERUk/D7lCNzPtxDs2PAsDtbwmh273BDGTCKtXcO7meaCHFWm5LvXEBxmyBcz6SiQL0n
 mLOxljMbCxgFViZSPiA/NM/TxsIFycL+v74JhhoeDuUMU9+M92esbgQX2D011Q5Cqn8Z
 kxMz40spugBIS8GdLz71jpcQaTmIsMOxFzi6gFJAyQdMHdTFQLKyxKjXwfzdzaiu5feg
 mUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068982; x=1773673782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8xXGf9wQuXiSKLxPb3FYIBG/K87QsiFd36ndnCqGkII=;
 b=t5QmIXarkuS7KBdONd+JJSQkD2FA2Su9qrwYKUzDdrA4iwFQNcHwtBj0DJDOrj+s4V
 MyIJRnRiTmdeGjCGYZagD+oPXhLCk36tCYZGibrVgnBOUpPbuFK5wCQHztkuKrx8So/p
 gAwuPlN6p+uOqqpTtA3GJ6rv3rVmgbNn5Nd8lZiQzVDVcUNKscltJGOhQ8rYRl4Yir5W
 XlN1tTQTg1hlFtBI/993NtX5AFRwJJ2V66K1mBCcrsJYedPD/r1lWJsOrWmoF9wzLB20
 B1ZSliaCd3t1BXo5KWcUjp/bVyIJfrrs8odU/q78qvqlaEA79dqdaabZYnXn+w98vaUV
 t5SQ==
X-Gm-Message-State: AOJu0YwdlNNcNRt8jTJPljZEjJAVxT/p7cImnJ6HzcZ971gUdQfJtijS
 LK8EQOgSjhs7CRlI1+xOM1ab1O3CPdB2O3ZZgK5mA7Fj3rXAdYO4PIcj6ItpEXLztWROXCrFnVX
 d1TwnLS1gcqkPFa6SRyTYK8fP1TmEPlevYDeYLXFKReq9TqbVIGHy3X8Q
X-Gm-Gg: ATEYQzxzaC81lGVrCTTreUdCxgd1iylY1wUVxW2KHF3WT4WIyLe06/TX9NL9F0OLPYX
 xpRMs10foC6jtHtMJ85toGf2JTefd+gSKrVJRqBh9FH9s0Co2Nbqi4CrWSVNxRGFa9sa9VjR/x8
 iM6SKMoaYAnYllSheI8rddT8WBEId4ZjI4uwmQiSp74LvOrNfCcCLLhgyLTAPIYJuNFDiyqtGrT
 2Iy1jFs2NLY2TeuIneB0QDvqvBQs16YbF9tMSuntz58MQTaWXYD7l58XTvbZvHFOTX8fBUcLcZZ
 rjefZhC4gb9GlebkDlRPQMOnvqTg/P0I8Txi3B1gX/eAO+prwKcJkD8Umz+xGTu61gHcge2qGkt
 ITMVCY2XRNrcPQeBN6dS2j6TglLLUHK6sL6ePuck8LEAEVKczowDMNrbhk7RSmoVGloEP2bF2SO
 /FzlFl
X-Received: by 2002:a05:6000:400e:b0:437:745f:a6b8 with SMTP id
 ffacd0b85a97d-439da34819dmr18284675f8f.9.1773068981730; 
 Mon, 09 Mar 2026 08:09:41 -0700 (PDT)
X-Received: by 2002:a05:6000:400e:b0:437:745f:a6b8 with SMTP id
 ffacd0b85a97d-439da34819dmr18284621f8f.9.1773068981183; 
 Mon, 09 Mar 2026 08:09:41 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2bdf8sm28465745f8f.25.2026.03.09.08.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:39 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 15/25] block: Move qemu_fcntl_addfl() into osdep.c
Date: Mon,  9 Mar 2026 16:08:46 +0100
Message-ID: <20260309150856.26800-16-hreitz@redhat.com>
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

Move file-posix's helper to add a flag (or a set of flags) to an FD's
existing set of flags into osdep.c for other places to use.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/qemu/osdep.h |  1 +
 block/file-posix.c   | 17 +----------------
 util/osdep.c         | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index b384b5b506..f151578b5c 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -633,6 +633,7 @@ int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
 int qemu_unlock_fd(int fd, int64_t start, int64_t len);
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
 bool qemu_has_ofd_lock(void);
+int qemu_fcntl_addfl(int fd, int flag);
 #endif
 
 bool qemu_has_direct_io(void);
diff --git a/block/file-posix.c b/block/file-posix.c
index 6265d2e248..e49b13d6ab 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1056,21 +1056,6 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
     return ret;
 }
 
-/* Sets a specific flag */
-static int fcntl_setfl(int fd, int flag)
-{
-    int flags;
-
-    flags = fcntl(fd, F_GETFL);
-    if (flags == -1) {
-        return -errno;
-    }
-    if (fcntl(fd, F_SETFL, flags | flag) == -1) {
-        return -errno;
-    }
-    return 0;
-}
-
 static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
                                  int *open_flags, uint64_t perm, Error **errp)
 {
@@ -1109,7 +1094,7 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
         /* dup the original fd */
         fd = qemu_dup(s->fd);
         if (fd >= 0) {
-            ret = fcntl_setfl(fd, *open_flags);
+            ret = qemu_fcntl_addfl(fd, *open_flags);
             if (ret) {
                 qemu_close(fd);
                 fd = -1;
diff --git a/util/osdep.c b/util/osdep.c
index 770369831b..000e7daac8 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -280,6 +280,24 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
         return fl.l_type == F_UNLCK ? 0 : -EAGAIN;
     }
 }
+
+/**
+ * Set the given flag(s) (fcntl GETFL/SETFL) on the given FD, while retaining
+ * other flags.
+ */
+int qemu_fcntl_addfl(int fd, int flag)
+{
+    int flags;
+
+    flags = fcntl(fd, F_GETFL);
+    if (flags == -1) {
+        return -errno;
+    }
+    if (fcntl(fd, F_SETFL, flags | flag) == -1) {
+        return -errno;
+    }
+    return 0;
+}
 #endif
 
 bool qemu_has_direct_io(void)
-- 
2.53.0


