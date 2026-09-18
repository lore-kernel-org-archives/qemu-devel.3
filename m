Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7059FC88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QBD-0006fe-DI; Fri, 18 Sep 2026 00:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAt-0006GA-U1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:26:14 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAs-0004QN-JI
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:26:11 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7f4f0d37dc4so162264a34.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705559; x=1790310359;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6DETv+CjgZyBFHWbhuSop809p8a2VDLtxX9l7nrrCw0=;
 b=MZvu28slp6Bcb3wBVv/QvFSm0ABG76u5G/p70IPLhtY2TEH+p+T1I1WRheScGklqPM
 3pgOGXHbv7djpQq1yEXjM+nVSt/gP4QuNp2HnNZlig9mWOHEOTNjzOlI2cL+fR/t55em
 Y6moyT0OUTtekr5Yxfg3IQdFagArfcIY/2fGLpeV+ET+pCII3gLT/xA5SAmjFUYepsiS
 sa33RTbQmjl1JS6ZL1dcSw67GIXUo9iTQvVv5sgoyWY2GJ53kFaku/mZbmG887eN7Bsd
 Ukg7/rznxr5Q8y1lSYAImFbIZ6de+JvxJxf+jl+ic79tJRILjLxY9Url7tn8InGE0W5d
 iXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705559; x=1790310359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6DETv+CjgZyBFHWbhuSop809p8a2VDLtxX9l7nrrCw0=;
 b=aaV49WEqxG9SdstsGe79v5IPQzLvaQ2agtLpiJQ6hIamDpsnb+ZtfjySN3gCsP6cqY
 q3ZIHe0j8dBHfarok+W4nRjwQB3s9m5xyZJyvIe6BZz8sab7xJOQ72wfDlH9hI4kPU6W
 5AE8/TASzQRbmS+CA0G3vI7OBcTTCnmIaFqyJV941EDke7KWyfW47UOFRa2rQnCfTBe4
 e/TvQsZeVYy1MwHzA1fFtPKs32vhzUm6C+drdfrhovoD7Hqa2zSh2Lh4Zfjrfbaxw/Bz
 +nvjjV1QmCUngA21uwOTlMNdfIIKT9dzN0TYeTwrxQBtMIc0hq1LFMrZPRam+ays6ums
 9+bw==
X-Gm-Message-State: AFuF++mGQCPHpXOCxomCRghFXZ9E7QfyVDTNbpiGC+4dAr4rwkFW/XA8
 aFiSHjPuVgVrnkw7lanTsNMNUYAZklrTRMfXHAIOYejhYppg5a0DgwuYzt1VOR6qHlHDmSHCuNb
 QD+Mon+w=
X-Gm-Gg: AYBFou16kdZ9ImSgLcEZPU1LvAyqQSaW4/MqAKCpN+UIc/gJU6F7UjMVVP69KtrJPBI
 +sqD4Hoa8/XfmA5mHby4UkB8ZBbLDEGSz2lErzJv3flHRNCMjqBkSxzJPCts2gc00FEf35904DA
 SAf11dHUiVFKMCsHzfq7KvbGhSxB/vzQzg2ZD6PCyTEtB3AX7JKpyyUvTfMhttwrvL3b/aNdI2m
 oOl8eB5LSjjNwZ3QosiwCkqbyMEjXvYkVHzNJWrG+d9QLndKe9U8c/1yhliu6InUDM5bujQ3w28
 Q8ZBtt1HSjmiI6bTdiB8hCmrt9CBy06ZzMzqV8LuWBJ0zSALdl61vNN66oqtMJKY0Rx0GS84VTG
 RJDONHHxO/83F+jphrP0yN6Oqm+8ltmjnkhurTVBgaIv51w2fuTtgthC5mkIv9BWeiMVYxniCOj
 7h7obFtra12YTDMYRXq0641ne2L52GXF9h/eDZI97IyEj5wOxj+W9i+wxx2g==
X-Received: by 2002:a05:6830:6306:b0:807:70aa:b2ac with SMTP id
 46e09a7af769-80de2ddd1d3mr1605606a34.22.1789705559439; 
 Thu, 17 Sep 2026 21:25:59 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:58 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 40/41] bsd-user: Move qemu_guest_random_seed_main to same as
 linux-user
Date: Thu, 17 Sep 2026 22:24:21 -0600
Message-ID: <20260918042422.38713-41-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
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

Linux-user initializes this before doing the environment stuff. Go ahead
and move it there for consistency, though it doesn't matter since we
don't use it until later.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 2fbbfc3d86..13cd752b99 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -541,9 +541,6 @@ int main(int argc, char **argv)
         do_strace = 1;
     }
 
-    target_environ = envlist_to_environ(envlist, NULL);
-    envlist_free(envlist);
-
     {
         Error *err = NULL;
         if (seed_optarg != NULL) {
@@ -557,6 +554,9 @@ int main(int argc, char **argv)
         }
     }
 
+    target_environ = envlist_to_environ(envlist, NULL);
+    envlist_free(envlist);
+
     /*
      * Now that page sizes are configured we can do
      * proper page alignment for guest_base.
-- 
2.55.0


