Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A84FCD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzy3-0003Tv-VL; Fri, 15 May 2026 17:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzy1-0003Fs-Nx
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:09 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxz-0003Cp-Kp
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:08 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-479eb8bcacbso289833b6e.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880066; x=1779484866;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xfIdAZa/61ftnRZpLmFUfpLUwk5YAIKg50gmXCXnAwk=;
 b=Ui8s7lHUsoSdupqTdfDhJlPvb7ozHgcjCsPh++sE1onHfdhqv7DsAUsx1X+qoYh+iR
 NsNEx+4Up/T6ZiafK9QpDgUYggMDpjaUna6EQG+8KLlwOMFKb2CO4EHDd65aZz+6OJEl
 CZ0bYfdyHdFhHglyQfsnvMPqpSuDVzyxivnK+yCRle85Hoh61TtXB50uXIH461MXKlxg
 KMK3qdj2bo4KAtKS/Rs9jtU7msaOmFOcQ/eSp2LnsgVA2eENVhUMZQA1KAbtJZPZk7yx
 AyftI2VrNIklT45aFxZNpjSdJzRLobOQL0OCZsH9AFIRYoQjOjSAbnjcqRmApyBK4Ygh
 3N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880066; x=1779484866;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xfIdAZa/61ftnRZpLmFUfpLUwk5YAIKg50gmXCXnAwk=;
 b=DFHVYQKQTPpJnZLBHJbpojXj145Z/nrzrLJ2rQntejzyAB1R4GC7QR4EAmykYik6G4
 xaeZNtGDqWaU9TuWnB16eocfOwl6YRkgMfywBwkNB5L8Kx/Vv5osb46yAjizjhx33iwe
 5BBjHPF+Ie82WkiCPDYrVEb+0Gypabb0ZgIXQdJ5Vi7kwpf6gqIpdK/HRb3YYVaFXENo
 +uEbx0q4jqq6I15HUZbvkdU4bevNpmzlRuj4YS1sZn6gQGJD4jrHyHQO6IysrDo1NREI
 fUAXS2ouN8JaPb/K0/ZMPgh6VBv84r0gLzfhH4ErPHgH1MDKYQx3deKszBR/GHcjvtq9
 a5dw==
X-Gm-Message-State: AOJu0YwMpBARr3WaEt6a+lvvJbF3np8bvnPUjIn98r88BFgYLoXG39RB
 RUHjmzXU6WXQh3bYBdmF+ZKTsCfu5kVBXqn3Cb2aTtH37WSZLxX9BQZ47SidTNM6wEvtWFTJpOM
 MOJ+qc20=
X-Gm-Gg: Acq92OHp5NwKH2tb2CqKk69+o/I5IBnHeSjW5MODV3kjtwSTDIvAOZa5hFK2GQij9Aj
 owvKBzPKU/jb5YaHlVJqmayLoaGvBtzcrbtS8WpgtSym4lRUrEp9jGvNCey6DGtUZbrCeEBYLtf
 S3QBZpH0W4OhQVpKRtS2LKSgCJSYL9K2KX1yJYz1TNbet/ABRkh6mbxDv1YViMKAnO4y0zDIP9o
 CbHVkv9L1+x8ZiAi5vFQ3QDNnzC42ueYtP+MQceBfXLB0DnYkuU6W34zABKuVBt2XHYO/qsGOKg
 XUtbyr6z8LyoYLSblchPhO01m5BegEnWUn+Fg6rCsSF/51BplCKTkDgR0TUo4NGRr4Qm8TylF/H
 zBVUwMR+QHIkpYeVjyuw2FPLxZYIXkjEWIExoqLgk2GSzTCSv1SJS8qrdROpzgyMxoS8/bQ6iN/
 MvIb9UVJSTjo1nVz6NmprP
X-Received: by 2002:a05:6808:d4f:b0:47a:4fd:9606 with SMTP id
 5614622812f47-482e57c665dmr3943275b6e.23.1778880066475; 
 Fri, 15 May 2026 14:21:06 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:21:05 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:20:00 -0600
Subject: [PATCH 61/66] bsd-user: freebsd_rw_rdlock and freebsd_rw_wrlock
 fix missed decrement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-61-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3778; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=D53YgxUSSQOw0EYmx8h0jJgKb6MEpMryLTgDI8lySks=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43oC8PzfuJ8dsr8SOW6MsMA4y0bDXQ553b1L
 kfhrdcnfnmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN6AAKCRBsHNEofbAR
 AL7ID/9iFtnzeN7O1onz8D7JCKcMlliuydaTS2tDC9mwEeECYeZioNY0vtU9zMjaW/ZiDICX4jM
 tmvG3AUq764r+/esWcWtAiFEFVNwCwEeQJ+w42rYnQWBk69rCdrTcu0Oy11V/yOVQGCrZGOWAZ2
 SVbVACMfty5Hv1MhGWtdjLbqdCfXiRUiy1JcP7kXlV1kqz4ndw4brDYDZZDgZeO69Pbp9aW0koA
 wKYyyya/bgzrF3/U6RlvNdk2DCtVYLfs7XtlBiH0QVBU03M1MVx5fLHEntNV/mXBEQVzMxStGpN
 ZbaY+EZc3KYpY5gRkF/CGhLU+Pz/VCrKKkCbmpx4aEQ9T1/atGDsM46xFjEH/NxneR7xAQ1KZ55
 n99VY4kjtbo0EIfjjBXVutbuZCtISAKJtPXX/kENjPFhbjM/SnwecZ8IUz2bib6cS5lVL2ICDkW
 Yn5luFgvfONaDt4bv+8hLqWH+FKB4p/1EsWaJ7PC5YC161BI/Gb+PgRc9fjAlOyODwwOUMgg1X6
 rdbjAcLSJD7hHGuoB2v7PFbAmxai1cES2lFKWgaJnPtbAeqpTp6YAd/g3L/dvgUEZ3Q3Z1Y5dE9
 V3sCvFfqDeCOkSIREkNjaXg17ZfLRYexMTFo10+DscihNZvXR1t5WIAqjAVN+ZT5HsYdKdSSNGI
 rkTRD6Lg94gOIxg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x231.google.com
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

When we get an error from _umtx_wait_uint in the !_UMTX_OPTIMIZED case,
relock the variable and do the decrement.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index f90f13076f..a36c5ceccf 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -1264,6 +1264,7 @@ abi_long freebsd_rw_rdlock(abi_ulong target_addr, long fflag, size_t tsz,
             __get_user(blocked_readers, &target_urwlock->rw_blocked_readers);
         }
 
+        ret = 0;
         while (state & wrflags) {
             /* sleep/wait */
             unlock_user_struct(target_urwlock, target_addr, 1);
@@ -1274,7 +1275,11 @@ abi_long freebsd_rw_rdlock(abi_ulong target_addr, long fflag, size_t tsz,
             ret = _umtx_wait_uint(&target_urwlock->rw_state, tswap32(state),
                     tsz, t, __func__);
             if (is_error(ret)) {
-                return ret;
+                if (!lock_user_struct(VERIFY_WRITE, target_urwlock,
+                                      target_addr, 0)) {
+                    return ret;
+                }
+                goto rdlock_decrement;
             }
             if (!lock_user_struct(VERIFY_WRITE, target_urwlock, target_addr,
                         0)) {
@@ -1284,6 +1289,7 @@ abi_long freebsd_rw_rdlock(abi_ulong target_addr, long fflag, size_t tsz,
         }
 
         /* decrease read waiter count */
+rdlock_decrement:
         __get_user(blocked_readers, &target_urwlock->rw_blocked_readers);
         while (!tcmpset_32(&target_urwlock->rw_blocked_readers,
                     blocked_readers, (blocked_readers - 1))) {
@@ -1297,6 +1303,9 @@ abi_long freebsd_rw_rdlock(abi_ulong target_addr, long fflag, size_t tsz,
                 __get_user(state, &target_urwlock->rw_state);
             }
         }
+        if (is_error(ret)) {
+            return ret;
+        }
     }
 #endif /* _UMTX_OPTIMIZED */
 }
@@ -1365,6 +1374,7 @@ abi_long freebsd_rw_wrlock(abi_ulong target_addr, long fflag, size_t tsz,
         }
 
         /* sleep */
+        ret = 0;
         while ((state & TARGET_URWLOCK_WRITE_OWNER) ||
                 (TARGET_URWLOCK_READER_COUNT(state) != 0)) {
             unlock_user_struct(target_urwlock, target_addr, 1);
@@ -1375,7 +1385,11 @@ abi_long freebsd_rw_wrlock(abi_ulong target_addr, long fflag, size_t tsz,
             ret = _umtx_wait_uint(&target_urwlock->rw_state,
                         tswap32(state), tsz, t, __func__);
             if (is_error(ret)) {
-                return ret;
+                if (!lock_user_struct(VERIFY_WRITE, target_urwlock,
+                                      target_addr, 0)) {
+                    return ret;
+                }
+                goto wrlock_decrement;
             }
             if (!lock_user_struct(VERIFY_WRITE, target_urwlock, target_addr,
                         0)) {
@@ -1385,6 +1399,7 @@ abi_long freebsd_rw_wrlock(abi_ulong target_addr, long fflag, size_t tsz,
         }
 
         /* decrease the write waiter count */
+wrlock_decrement:
         __get_user(blocked_writers, &target_urwlock->rw_blocked_writers);
         while (!tcmpset_32(&target_urwlock->rw_blocked_writers,
                     blocked_writers, (blocked_writers - 1))) {
@@ -1401,6 +1416,9 @@ abi_long freebsd_rw_wrlock(abi_ulong target_addr, long fflag, size_t tsz,
         } else {
             blocked_readers = 0;
         }
+        if (is_error(ret)) {
+            return ret;
+        }
     }
 #endif /* _UMTX_OPTIMIZED */
 }

-- 
2.52.0


