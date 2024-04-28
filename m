Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B75AC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 11:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s12Rl-0004W2-3t; Sun, 28 Apr 2024 07:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s12Re-0004VX-Bo
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 07:11:46 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s12RY-0000Yx-JN
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 07:11:45 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e3f17c6491so29479235ad.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 04:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714302699; x=1714907499;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y4j4qahPhXI8W1nFLvgESJ5yiEJJetyEtcZElI8DFI0=;
 b=jjw2wNZy5R1sf8ZQ9qiM1FT+FmT9HVO6jrX0c/H1pkJb2nRowNhbgBPE5IFLTmn9Kl
 KP73RAMlReT0U0aQIz2f3serCSn9YN+j7mDrcQvkvKxLoT8iEre0L6iHRtNrHZI4ZJrT
 0KdfXt5jmbDT5ojY7d57qEti1F5Smcppt5/Pbk/oNCMr2CMxV9R6wm/Br1tubIhCdk9W
 i0gRoJolu76veF0yKDphVYCvTBYrNtlKDd3xY7I+i/296HQ4DFAX/Jx43A7ELdxyy28k
 S6+xiBblJNYLLAm1eStTJVdRLrY5h3G9bRMoAC+62/++aftHzF+u7Px7k1/yMhDTPnzP
 PWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714302699; x=1714907499;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y4j4qahPhXI8W1nFLvgESJ5yiEJJetyEtcZElI8DFI0=;
 b=n/+BAq0EB+p6aXHcfXtRZEqGAdlYimOv1AMdzS7JV86A1alg8O0OxIjDLf77bVTcx7
 tbbnscfCOEV7GwpahdW6fBUzM6Do67bpEMMPY+GJJDy1ASULFVMASbL6tsqz/4nyjkgP
 HWGKEe5fU/8taLqC4bypUWNb+P2HTtwn6mi4khAcB2Dj+S+jahIt+bY2NsZ+TvFGLrHK
 J9T2nOw9WLBY5DKrhClfGnYyP9w5NcH+pZxSqVRrJ1RjJR76cdoTJa8XX5Z61YAuGqk1
 FrbjGyYUAKQn+Y5RWZj2I2wXHQ1AeSAutYiWRpOQ1YC8qUpiOjtZpsYKHiiKkU0JFLhL
 7/Rg==
X-Gm-Message-State: AOJu0YyuiJRAi/1fwPf6pk/y+/KEGSn1bMHGhJM5kmm0f+suA2fNzf1n
 SQcyNsN4FhjkKNG9//8nV9UudfcynHQJ/l1o0b10EuJyhh3DD0Qj12/lg49h5no=
X-Google-Smtp-Source: AGHT+IEY5WuXMmWs7PZ20KBXgM6dKXvXvK2Egj4lPLmCIGezrThWUSj1AXJMv+N/X9bZFy3q1Iz/Wg==
X-Received: by 2002:a17:902:b283:b0:1e0:2995:c330 with SMTP id
 u3-20020a170902b28300b001e02995c330mr7548354plr.63.1714302699289; 
 Sun, 28 Apr 2024 04:11:39 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 s8-20020a170902ea0800b001e853d9bb42sm2258111plg.196.2024.04.28.04.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 04:11:39 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 20:11:22 +0900
Subject: [PATCH 1/2] util/iov: Do not assert offset is in iov
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-iov-v1-1-7b2dd601d80b@daynix.com>
References: <20240428-iov-v1-0-7b2dd601d80b@daynix.com>
In-Reply-To: <20240428-iov-v1-0-7b2dd601d80b@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
---
 include/qemu/iov.h | 5 +++--
 util/iov.c         | 5 -----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 63a1c01965d1..33548058d2ee 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -30,7 +30,7 @@ size_t iov_size(const struct iovec *iov, const unsigned int iov_cnt);
  * only part of data will be copied, up to the end of the iovec.
  * Number of bytes actually copied will be returned, which is
  *  min(bytes, iov_size(iov)-offset)
- * `Offset' must point to the inside of iovec.
+ * Returns 0 when `offset' points to the outside of iovec.
  */
 size_t iov_from_buf_full(const struct iovec *iov, unsigned int iov_cnt,
                          size_t offset, const void *buf, size_t bytes);
@@ -66,11 +66,12 @@ iov_to_buf(const struct iovec *iov, const unsigned int iov_cnt,
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
index 7e73948f5e3d..a523b406b7f8 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -36,7 +36,6 @@ size_t iov_from_buf_full(const struct iovec *iov, unsigned int iov_cnt,
             offset -= iov[i].iov_len;
         }
     }
-    assert(offset == 0);
     return done;
 }
 
@@ -55,7 +54,6 @@ size_t iov_to_buf_full(const struct iovec *iov, const unsigned int iov_cnt,
             offset -= iov[i].iov_len;
         }
     }
-    assert(offset == 0);
     return done;
 }
 
@@ -74,7 +72,6 @@ size_t iov_memset(const struct iovec *iov, const unsigned int iov_cnt,
             offset -= iov[i].iov_len;
         }
     }
-    assert(offset == 0);
     return done;
 }
 
@@ -266,7 +263,6 @@ unsigned iov_copy(struct iovec *dst_iov, unsigned int dst_iov_cnt,
         bytes -= len;
         offset = 0;
     }
-    assert(offset == 0);
     return j;
 }
 
@@ -337,7 +333,6 @@ size_t qemu_iovec_concat_iov(QEMUIOVector *dst,
             soffset -= src_iov[i].iov_len;
         }
     }
-    assert(soffset == 0); /* offset beyond end of src */
 
     return done;
 }

-- 
2.44.0


