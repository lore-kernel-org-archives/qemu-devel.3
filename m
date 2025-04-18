Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C08C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 14:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5meN-00077Q-Du; Fri, 18 Apr 2025 10:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u5meF-00075w-QP
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 10:24:59 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u5me3-0007lh-CQ
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 10:24:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so19757005e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 07:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744986279; x=1745591079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CNauYxS5i3NejXWpcBocb0KmTjWnM/MNGrSaA8KpXcQ=;
 b=UjGQmECxiV8Lv8BU20BVSPLJ0CK8lP/n1hRtocMISQvRBlRrZVUT0JDkZhgV669UPK
 Q97L4KqtBisQM7JwQ94JVPgD2nNtH0900QI8LNqy6xUfn3GAT0avz+xfhr1i6usCKmPl
 ndv454gEDdxu/V2K3b8gm81Mh1iJbuREfm/Mmh4C3BaBpEc6sk7tsvsFdS+kiGO8ZA2d
 Opt12jvkucIr4mq/0EKJZoBwGz2vHraNV3nV/xDIcU2TlnYVHVtWxB9QwurzwTtDABzR
 /DFigWFFId1dcmcLbutkyrXmKtLb9ebu1Qp/KLw/lmZhCsoT1IoGScIWZMfFZMbHIYk2
 gjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744986279; x=1745591079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CNauYxS5i3NejXWpcBocb0KmTjWnM/MNGrSaA8KpXcQ=;
 b=udQV0DqyAl3Vg5GYWnHalLdSRK5KrGoEhPXEaMmo+6uBhVkWVLEd8qvdKwkGlDUrwg
 GQHh5cruohlh+DIkLLFuUjYXQLNc84nbHgFEd8H89E9og6N2SHvzRPMCrCVpjnphJLS/
 UESF+oHhZ5GKBKWKqO57kmqQP6rvmwN3YZagdUCSv2MaX+zT0f1w6mCGnKp3VMeSpjWY
 uF9c6hj7emczG1Ar4K1KKLrs9bhAeD+cgirDsBo4b5YpYCzMRjao3H+OEEpwRC6qgr1H
 ouJzNkad4dc1qXw3oxnZhcGvbzhLTCVDrgp6RegZYTLEbeegisIZvZm5F+SGl99zbbDK
 lgjA==
X-Gm-Message-State: AOJu0YwkW/WVm+0piipgnr4e4wGtHRVvJXU9ZmqWgW3UnJ0dUSlr6U2Z
 DcESZG013JABK21UaQA6iC1VpUPBWiTjak9Ecx9PFhs+/MHXRwSklbjAtw==
X-Gm-Gg: ASbGncu01pj49i53/3g6WxX4n0H2K5nEpg2Etngb3AwsUSJFEM+7o82vRB5R28REEj+
 0J2uI8fi9fAwLscSCrKtDFfn15m1D3kmub1ilTxKI91EPuB4fnI+KdpqX4i/nkuStMPnyFlZHYx
 cSVD7QA4rFqOI62iYMTpGR/++RDFm/WcHfyf9FM+F4bKkulQGFqeT9L6j8HiVR7t6FFtsoGPDxL
 2XTDupmtbDDn1fwtroLcKP3MjwMBx7BW9tNtezlW4Zjq63RpZq7WtYe8sI7RpkxcQLeHLTcFIzY
 awQkXaolmDycGoRZMsgcDUyOQPa3zWaxNj2VeYH9zJyHsfbDGVNdMC4lysLbo0z8APaMUowTA1E
 BDTBxfSxqiuLngh9j7FtnmKA=
X-Google-Smtp-Source: AGHT+IEyglDjCUY7Sfk6OxoWMmE6q0s4jUpggol1Z9L3+C3NJkixDNnSAN07AbahT/Y1S9YXBRGYMw==
X-Received: by 2002:a05:6000:144a:b0:39a:c8a8:4fdc with SMTP id
 ffacd0b85a97d-39efba3ffcamr2236359f8f.16.1744986279158; 
 Fri, 18 Apr 2025 07:24:39 -0700 (PDT)
Received: from localhost.localdomain (89-138-169-5.bb.netvision.net.il.
 [89.138.169.5]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43315esm2870430f8f.26.2025.04.18.07.24.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 07:24:38 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Richard Jones" <rjones@redhat.com>, "Eric Blake" <eblake@redhat.com>,
 Nir Soffer <nirsof@gmail.com>
Subject: [PATCH] io: Set unix socket buffers on macOS
Date: Fri, 18 Apr 2025 17:24:36 +0300
Message-Id: <20250418142436.6121-1-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Testing with qemu-nbd shows that computing a hash of an image via
qemu-nbd is 5-7 times faster with this change.

Tested with 2 qemu-nbd processes:

    $ ./qemu-nbd-after -r -t -e 0 -f raw -k /tmp/after.sock /var/tmp/bench/data-10g.img &
    $ ./qemu-nbd-before -r -t -e 0 -f raw -k /tmp/before.sock /var/tmp/bench/data-10g.img &

With nbdcopy, using 4 NBD connections:

    $ hyperfine -w 3 "./nbdcopy --blkhash 'nbd+unix:///?socket=/tmp/before.sock' null:"
                     "./nbdcopy --blkhash 'nbd+unix:///?socket=/tmp/after.sock' null:"
    Benchmark 1: ./nbdcopy --blkhash 'nbd+unix:///?socket=/tmp/before.sock' null:
      Time (mean ± σ):      8.670 s ±  0.025 s    [User: 5.670 s, System: 7.113 s]
      Range (min … max):    8.620 s …  8.703 s    10 runs

    Benchmark 2: ./nbdcopy --blkhash 'nbd+unix:///?socket=/tmp/after.sock' null:
      Time (mean ± σ):      1.839 s ±  0.008 s    [User: 4.651 s, System: 1.882 s]
      Range (min … max):    1.830 s …  1.853 s    10 runs

    Summary
      ./nbdcopy --blkhash 'nbd+unix:///?socket=/tmp/after.sock' null: ran
        4.72 ± 0.02 times faster than ./nbdcopy --blkhash 'nbd+unix:///?socket=/tmp/before.sock' null:

With blksum, using one NBD connection:

    $ hyperfine -w 3 "blksum 'nbd+unix:///?socket=/tmp/before.sock'" \
                     "blksum 'nbd+unix:///?socket=/tmp/after.sock'"
    Benchmark 1: blksum 'nbd+unix:///?socket=/tmp/before.sock'
      Time (mean ± σ):     13.606 s ±  0.081 s    [User: 5.799 s, System: 6.231 s]
      Range (min … max):   13.516 s … 13.785 s    10 runs

    Benchmark 2: blksum 'nbd+unix:///?socket=/tmp/after.sock'
      Time (mean ± σ):      1.946 s ±  0.017 s    [User: 4.541 s, System: 1.481 s]
      Range (min … max):    1.912 s …  1.979 s    10 runs

    Summary
      blksum 'nbd+unix:///?socket=/tmp/after.sock' ran
        6.99 ± 0.07 times faster than blksum 'nbd+unix:///?socket=/tmp/before.sock'

This will improve other usage of unix domain sockets on macOS, I tested
only qemu-nbd.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 io/channel-socket.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 608bcf066e..b858659764 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -410,6 +410,19 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
     }
 #endif /* WIN32 */
 
+#if __APPLE__
+    /* On macOS we need to tune unix domain socket buffer for best performance.
+     * Apple recommends sizing the receive buffer at 4 times the size of the
+     * send buffer.
+     */
+    if (cioc->localAddr.ss_family == AF_UNIX) {
+        const int sndbuf_size = 1024 * 1024;
+        const int rcvbuf_size = 4 * sndbuf_size;
+        setsockopt(cioc->fd, SOL_SOCKET, SO_SNDBUF, &sndbuf_size, sizeof(sndbuf_size));
+        setsockopt(cioc->fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf_size, sizeof(rcvbuf_size));
+    }
+#endif /* __APPLE__ */
+
     qio_channel_set_feature(QIO_CHANNEL(cioc),
                             QIO_CHANNEL_FEATURE_READ_MSG_PEEK);
 
-- 
2.39.5 (Apple Git-154)


