Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4845DC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeaY-000301-Ob; Fri, 17 Jul 2026 05:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lufia@lufia.org>) id 1wkcIU-0004RV-3Q
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 02:43:46 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lufia@lufia.org>) id 1wkcIS-00053O-2R
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 02:43:45 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5aeae771c49so8610984e87.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 23:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784270620; cv=none;
 d=google.com; s=arc-20260327;
 b=BTlEWrdoccCGpznI2P4CBDE/jDyuzWmFR6D9vzhZx2sirZR+TihqNcJ4BKaEr83824
 N6ycydjOGzsspx0ULVypXaHWy+Mq7UiKE/jz43X4fDF+Ag/qnuovZ/+N2x7IiTexjPqS
 4Hw3tuVFX3a2ydF6KL9rg2948E/Z318emajyoPVd+icmRlcN8oPf+lIYdO/2VReDlAQ8
 ArwUf/hWmOuHUqn6jgQI0kRakmTx7VVU8qRzkYN/xiytPpnW7OK+LzFGK0qDnWyXfN9T
 y8jM1U8pWcT4A2c/91OFXZbU4r4FiG4fTommYtP5dTBVN+SDbi1HTrtlHxwhkpmSEr3e
 yvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=EKbyG3+SiwTROHcMwe8+lh1F+tMXCsXm64BeyFHW07A=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=DX9t/045JsYRUqSTZyNjxziyDXnCFtisOhaFSS07SmpRk5c+h6S3ZFqOHu+JY5G11d
 GIT+exs+ajaYD6eNTUIGInM4UnEW5pOAYzXmwTE7HkRiEsmXx5nsMXPIpIWyfKE81+Zh
 qouNvUixzMks5DyypZhcFqHPdTGyQriKCXRVabuWiIW4FgiJR4kPFTZXjPznSB0nK3Gg
 s+BYqOyykjOejFJA/fR5LI6KrMpT6iofiX8WKFMFB84yxfV4VJhmUUfoNrDsJFvWexlH
 ilTVhSTrdKK1YDcfzvuwqBYzkZgSkn049IiChkrIWg7fBv6RjrgXo0Ndv/ODcHea45Hm
 CJJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lufia-org.20251104.gappssmtp.com; s=20251104; t=1784270620; x=1784875420;
 darn=nongnu.org; 
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EKbyG3+SiwTROHcMwe8+lh1F+tMXCsXm64BeyFHW07A=;
 b=B9BlLfvwLpA1cr5FS9xo5FoZnOI0rMRZZzmpsR2wR2gzX8WvGEcgzgZAGjm8wQ8QpN
 CocY21BLWnYBBORohnS3QzEU9J+aB+YyBVcn9Ax3noWLMloep+mZHLo1BgqZRqRhtf+A
 UPMX1UZCiJEGHwHNoWj+kK+SdZIMP1tolt1iNMsn7RVfRVOT9iOQWeqNjZOXuHfLFgHr
 WQ0YWfc0nrnkWlYynOkd5EkcP9ALhUQcvuDMRt5A5H50WRdwL4Szo0tRs4Q6c4ejsbIy
 j+oOEKpdoSDylIWXlTNmxEKTwWiARBIn5Dm8wZ6//KCL98efZMZ3aBOB2+IFDfvhgXkd
 Jeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784270620; x=1784875420;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EKbyG3+SiwTROHcMwe8+lh1F+tMXCsXm64BeyFHW07A=;
 b=VkZTX7fed0A/bvmgw0nxMZHcMx7oRFpDwlC5U4W15ovYu5WfOdH4XIEDSULg+1goyP
 gOTMr9qSxsx2Sg5QA7tOX22RFts+x1KPXy4bQK/hGBGXmmUxNSd0XhwPUUVQpRrR1Qza
 7Z1ILyfisjNuzGRPfxvabKOqCgwHBhZHdvlfvpicHG75H4akIiMFdUQs35Vi4K8A4w7O
 3pQHWn9wrhtu4uuLbEkSCTWosJqaIiDDJVWC/xXtW1I10wli32dxZdp81l1hSLjBudNh
 4MHlDVNoBP3Ob+zPQvaaEeGxXcppcMiMSQyOGcoCBxyIHDi077WY1EsD4hvcCrrmU8wd
 osxw==
X-Gm-Message-State: AOJu0Yxnio3+iXNqv8q8SS3wG67hgfMz3M1vecDueQxDRGAc7vnxFoPX
 diYvonnhG1EE0hmLaHn+mEWGNUVAjNugyUVpIdMNG5daR4XHvQdONNMrDheVen6QrTOvpDEf4+c
 QwOgbE/MCgJJ9bW13MimZgp4IDZNktAvxdcA4F69bu9y8/aR1d9zSVYKFNA==
X-Gm-Gg: AfdE7ck16OzfPZsh5YQhXj5xgHka3+UCbrubFozCqmncWD2s1dVjPw4tL8teVpz3+8A
 c6IPGbPT3S49RnKpp4D3HBdMeW355Kc31LwiN/zkOlmJScgiX+cEskM7WfojfiI2t2uuVtamHOQ
 aajAP5FpW4ErYPuKK35tFmw4myhpPWDHl/10qtv8zf0Ez2SKYKH17VYY+hmBB9vRb5MSFlBjfe3
 5M8viR1xruqb4oZzyKKDV263pRGhtGW7VoTD3e3SNdc9Ho/8aQUqWlSyQdQ
X-Received: by 2002:a05:6512:8354:b0:5ae:b7bc:27a6 with SMTP id
 2adb3069b0e04-5b28f859360mr185760e87.2.1784270620171; Thu, 16 Jul 2026
 23:43:40 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 17 Jul 2026 15:43:26 +0900
X-Gm-Features: AUfX_mytOJj9EI1hl-xqswg-1jqIjlhz2m0pqX14t6RonVPuoZHe3k3p9xZuET4
Message-ID: <CAFMepcnmdskwDZ6dN2wEEK=ve5B8hzghfrbUcGkQxCHGCDXVVA@mail.gmail.com>
Subject: [PATCH] hw/9pfs: add support ORCLOSE flag to create and open request
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=lufia@lufia.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 17 Jul 2026 05:10:33 -0400
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
Reply-to:  Kyohei Kadota <lufia@lufia.org>
From:  Kyohei Kadota via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

9P, and its successor 9P2000, allows ORCLOSE flag to both open- and
create-request.
When 9pclient requests close(fid) operation to the 9pserver, and if
the fid has ORCLOSE flag,
9pserver deletes the file, which is pointed of the fid, from
9pserver's filesystem.

However, the 9P specification does not allow any directories to be
specified ORCLOSE flag.

Signed-off-by: KADOTA, Kyohei <lufia@lufia.org>
---
 hw/9pfs/9p.c | 17 +++++++++++++++++
 hw/9pfs/9p.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 3119f01117..6fff57cc47 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -416,6 +416,9 @@ static int coroutine_fn free_fid(V9fsPDU *pdu,
V9fsFidState *fidp)
         if (fidp->fs.fd != -1) {
             retval = v9fs_co_close(pdu, &fidp->fs);
         }
+        if (retval >= 0 && fidp->orclose) {
+            retval = v9fs_co_remove(pdu, &fidp->path);
+        }
     } else if (fidp->fid_type == P9_FID_DIR) {
         if (fidp->fs.dir.stream != NULL) {
             retval = v9fs_co_closedir(pdu, &fidp->fs);
@@ -2164,6 +2167,10 @@ static void coroutine_fn v9fs_open(void *opaque)
         goto out;
     }
     if (S_ISDIR(stbuf.st_mode)) {
+        if (mode & Orclose) {
+            err = -EINVAL;
+            goto out;
+        }
         err = v9fs_co_opendir(pdu, fidp);
         if (err < 0) {
             goto out;
@@ -2193,6 +2200,9 @@ static void coroutine_fn v9fs_open(void *opaque)
         }
         fidp->fid_type = P9_FID_FILE;
         fidp->open_flags = flags;
+        if (mode & Orclose) {
+            fidp->orclose = true;
+        }
         if (flags & O_EXCL) {
             /*
              * We let the host file system do O_EXCL check
@@ -2959,6 +2969,10 @@ static void coroutine_fn v9fs_create(void *opaque)
         goto out;
     }
     if (perm & P9_STAT_MODE_DIR) {
+        if (mode & Orclose) {
+            err = -EINVAL;
+            goto out;
+        }
         err = v9fs_co_mkdir(pdu, fidp, &name, perm & 0777,
                             fidp->uid, -1, &stbuf);
         if (err < 0) {
@@ -3083,6 +3097,9 @@ static void coroutine_fn v9fs_create(void *opaque)
         }
         fidp->fid_type = P9_FID_FILE;
         fidp->open_flags = omode_to_uflags(mode);
+        if (mode & Orclose) {
+            fidp->orclose = true;
+        }
         if (fidp->open_flags & O_EXCL) {
             /*
              * We let the host file system do O_EXCL check
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 1a309664f6..16730cbd93 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -276,6 +276,7 @@ struct V9fsFidState {
     V9fsFidOpenState fs;
     V9fsFidOpenState fs_reclaim;
     int flags;
+    bool orclose;
     int open_flags;
     uid_t uid;
     int ref;
-- 
2.55.0

