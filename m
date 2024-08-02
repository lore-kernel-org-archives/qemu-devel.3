Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720AAC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29p-0002Jc-0k; Fri, 02 Aug 2024 19:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29l-00024Q-HP
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:57 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29j-0004JB-LL
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:57 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81fd1e1d38bso100892439f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643074; x=1723247874;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxMMYdUIWV7BpRLm7ZCMIQipXwTZjxzuoSHO0vQ0wkg=;
 b=SQ1KV4Ef2K1ALJpMrxtJH8Y+H3hRJa922zdfzx5woN4S9FO+5hwrtqAyVxPKGShxT8
 w6iRryQEGYW0wFy3Nk/OSXRMOPfI3xG4LPo0mv9XQPbcd+FZzB3Kzkdbi1g2+Y0815a9
 zJ/+xe8Ftl9oc91ZAspktksNIV0K7t8sQLxoe4Xdh5dLhTQ4Jr41cStBTnVmABVNigSt
 0nbp090Nd/v82UD4PTZ0WNpemvGi+WNakzc0iW3CqLaFOzxBPks8hDRufR7UWMlkDKps
 Qsx4hzuSvjQQbU/1hgo9MkCdyzKnqku1UNEp37JpKbVxkFOVtLYiTxRtM5JgE07exOqj
 FEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643074; x=1723247874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxMMYdUIWV7BpRLm7ZCMIQipXwTZjxzuoSHO0vQ0wkg=;
 b=VWblmrtNVf0TxG4r3U73Wh/KRguYIJjpeky7H/DWkmEdFm+EcDThKGmES+HukniUUM
 qu51ADmezY3VPoDdb3wgFdXIZEr8UegP/8eOgHKssPfVTHB3Qlfq3inNCGMFzt10rASW
 q/hO/dwz/1tZ0WuahdPcD7HVNpV6EGlVZ6Vh4MS16/pXzZEXDfKD+4y9BT8bpmPkvBuw
 8FcFBlejlJydujuAaMjhYFLWCGa92ZJgofMTojNyzEUOv/OQfjQf2i0yX38DnPe8Ptcf
 lTYaNvPLu2S53EO7OvXu8S1PBBFfcSzO6u2kz7Y2TOvZByMYPA9KAXf4C32bsEFAd3fS
 xo1g==
X-Gm-Message-State: AOJu0YxFuiYT1YNsaAlqn3NfBHmuFurgbBWKdFkKqHstv9/PJGb2mhhZ
 z2OamCD9+4HzxITGATGhpqkn9Oo0WmCf1858PVRlhced+JNegSpFnL/wpJFSKV41mUP7rZl1BFN
 fPTI=
X-Google-Smtp-Source: AGHT+IGOtmJw+WDFJLDwZQOmXBDlkxuSSUI+xcUIY8OIa5mLiv99XnDwXo+CCxGno1/WCschjBcdRg==
X-Received: by 2002:a05:6602:641f:b0:7f7:e273:a97d with SMTP id
 ca18e2360f4ac-81fd437a1d5mr638006239f.9.1722643074290; 
 Fri, 02 Aug 2024 16:57:54 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:53 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 14/17] bsd-user: target_mmap*: change prot to target_prot
Date: Fri,  2 Aug 2024 17:56:14 -0600
Message-ID: <20240802235617.7971-15-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d29;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd29.google.com
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

Adopt the linux-user convention of using target_prot for passed in
protections. no functional change.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/mmap.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index d34075c5c64..2118972f073 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -152,7 +152,7 @@ error:
  */
 static int mmap_frag(abi_ulong real_start,
                      abi_ulong start, abi_ulong end,
-                     int prot, int flags, int fd, abi_ulong offset)
+                     int target_prot, int flags, int fd, abi_ulong offset)
 {
     abi_ulong real_end, addr;
     void *host_start;
@@ -170,20 +170,20 @@ static int mmap_frag(abi_ulong real_start,
 
     if (prot1 == 0) {
         /* no page was there, so we allocate one. See also above. */
-        void *p = mmap(host_start, qemu_host_page_size, prot,
+        void *p = mmap(host_start, qemu_host_page_size, target_prot,
                        flags | ((fd != -1) ? MAP_ANON : 0), -1, 0);
         if (p == MAP_FAILED)
             return -1;
-        prot1 = prot;
+        prot1 = target_prot;
     }
     prot1 &= PAGE_RWX;
 
-    prot_new = prot | prot1;
+    prot_new = target_prot | prot1;
     if (fd != -1) {
         /* msync() won't work here, so we return an error if write is
            possible while it is a shared mapping */
         if ((flags & TARGET_BSD_MAP_FLAGMASK) == MAP_SHARED &&
-            (prot & PROT_WRITE))
+            (target_prot & PROT_WRITE))
             return -1;
 
         /* adjust protection to be able to read */
@@ -367,7 +367,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
 }
 
 /* NOTE: all the constants are the HOST ones */
-abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
+abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      int flags, int fd, off_t offset)
 {
     abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_len;
@@ -377,9 +377,9 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         qemu_log("mmap: start=0x" TARGET_ABI_FMT_lx
                  " len=0x" TARGET_ABI_FMT_lx " prot=%c%c%c flags=",
                  start, len,
-                 prot & PROT_READ ? 'r' : '-',
-                 prot & PROT_WRITE ? 'w' : '-',
-                 prot & PROT_EXEC ? 'x' : '-');
+                 target_prot & PROT_READ ? 'r' : '-',
+                 target_prot & PROT_WRITE ? 'w' : '-',
+                 target_prot & PROT_EXEC ? 'x' : '-');
         if (flags & MAP_ALIGNMENT_MASK) {
             qemu_log("MAP_ALIGNED(%u) ",
                      (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIFT);
@@ -416,13 +416,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         goto fail;
     }
     if (flags & MAP_STACK) {
-        if ((fd != -1) || ((prot & (PROT_READ | PROT_WRITE)) !=
-                    (PROT_READ | PROT_WRITE))) {
+        if (fd != -1 ||
+            ((target_prot & (PROT_READ | PROT_WRITE)) !=
+             (PROT_READ | PROT_WRITE))) {
             errno = EINVAL;
             goto fail;
         }
     }
-    if ((flags & MAP_GUARD) && (prot != PROT_NONE || fd != -1 ||
+    if ((flags & MAP_GUARD) && (target_prot != PROT_NONE || fd != -1 ||
         offset != 0 || (flags & (MAP_SHARED | MAP_PRIVATE |
         /* MAP_PREFAULT | */ /* MAP_PREFAULT not in mman.h */
         MAP_PREFAULT_READ | MAP_ANON | MAP_STACK)) != 0)) {
@@ -512,14 +513,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
          * especially important if qemu_host_page_size >
          * qemu_real_host_page_size
          */
-        p = mmap(g2h_untagged(start), host_len, prot,
+        p = mmap(g2h_untagged(start), host_len, target_prot,
                  flags | MAP_FIXED | ((fd != -1) ? MAP_ANON : 0), -1, 0);
         if (p == MAP_FAILED)
             goto fail;
         /* update start so that it points to the file position at 'offset' */
         host_start = (unsigned long)p;
         if (fd != -1) {
-            p = mmap(g2h_untagged(start), len, prot,
+            p = mmap(g2h_untagged(start), len, target_prot,
                      flags | MAP_FIXED, fd, host_offset);
             if (p == MAP_FAILED) {
                 munmap(g2h_untagged(start), host_len);
@@ -557,11 +558,11 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
              * possible while it is a shared mapping
              */
             if ((flags & TARGET_BSD_MAP_FLAGMASK) == MAP_SHARED &&
-                (prot & PROT_WRITE)) {
+                (target_prot & PROT_WRITE)) {
                 errno = EINVAL;
                 goto fail;
             }
-            retaddr = target_mmap(start, len, prot | PROT_WRITE,
+            retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
                                   MAP_FIXED | MAP_PRIVATE | MAP_ANON,
                                   -1, 0);
             if (retaddr == -1)
@@ -569,8 +570,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
             if (pread(fd, g2h_untagged(start), len, offset) == -1) {
                 goto fail;
             }
-            if (!(prot & PROT_WRITE)) {
-                ret = target_mprotect(start, len, prot);
+            if (!(target_prot & PROT_WRITE)) {
+                ret = target_mprotect(start, len, target_prot);
                 assert(ret == 0);
             }
             goto the_end;
@@ -587,13 +588,13 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
             if (real_end == real_start + qemu_host_page_size) {
                 /* one single host page */
                 ret = mmap_frag(real_start, start, end,
-                                prot, flags, fd, offset);
+                                target_prot, flags, fd, offset);
                 if (ret == -1)
                     goto fail;
                 goto the_end1;
             }
             ret = mmap_frag(real_start, start, real_start + qemu_host_page_size,
-                            prot, flags, fd, offset);
+                            target_prot, flags, fd, offset);
             if (ret == -1)
                 goto fail;
             real_start += qemu_host_page_size;
@@ -602,7 +603,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         if (end < real_end) {
             ret = mmap_frag(real_end - qemu_host_page_size,
                             real_end - qemu_host_page_size, end,
-                            prot, flags, fd,
+                            target_prot, flags, fd,
                             offset + real_end - qemu_host_page_size - start);
             if (ret == -1)
                 goto fail;
@@ -618,13 +619,13 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
             else
                 offset1 = offset + real_start - start;
             p = mmap(g2h_untagged(real_start), real_end - real_start,
-                     prot, flags, fd, offset1);
+                     target_prot, flags, fd, offset1);
             if (p == MAP_FAILED)
                 goto fail;
         }
     }
  the_end1:
-    page_set_flags(start, start + len - 1, prot | PAGE_VALID);
+    page_set_flags(start, start + len - 1, target_prot | PAGE_VALID);
  the_end:
 #ifdef DEBUG_MMAP
     printf("ret=0x" TARGET_ABI_FMT_lx "\n", start);
-- 
2.45.1


