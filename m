Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECDCC982D0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89zG-0006Sx-V6; Sun, 20 Sep 2026 01:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zF-0006SZ-JK
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:13 -0400
Received: from mail-oi2-x21.google.com ([2607:f8b0:4864:32::21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zE-0002C1-1y
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:13 -0400
Received: by mail-oi2-x21.google.com with SMTP id
 46e09a7af769-7f65ebea805so1206578a34.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881671; x=1790486471;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4S8ObIZ0ZdCK2DHrcD1SKXFh0ESjjLBn5wR6nr/jH30=;
 b=YdboXc5hiFA2ZBC0AR9vprorsQwLtxuepiu7CDMNX+i4S8trtaJozvYTknmG9l8zVQ
 tdpeZE0mc0Fb5qQnLha4TR+LMJh/Ri8b1fA7n5nGkGysuq3iPEnYKme4uwZn+yeb0U1B
 p1vy/TWHTg2ULdJfzpM5OF2wHeX485i83rp6ImBnbJu4g6G724x7D1zUAb1/ZDUhkJRK
 p6W/camCQmCRmMOnP3H1QFd0+EGlYi/RH6IAVyeNhEAEf7lewPlHCz/arkxCw5RWN1Uc
 cIkR+XrGj4cP8DSu0ZRnot1yXAWESsBCER0tS3oyxHNpR+8kC172X5HN8JMYh+7vJAzY
 m7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881671; x=1790486471;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4S8ObIZ0ZdCK2DHrcD1SKXFh0ESjjLBn5wR6nr/jH30=;
 b=mgUSY636+uutTlXZ+THI/qptSHMvQ/YXJXrDz2Mt8Y4fMOjSRSC9JOrFaDmUgI6fOl
 o196lDr+fYsjuBVb/r6DTdjXNDnRF4BR3ubAuhFsF6es3ZTpHO+rwJ7xeZpIyyd4cTub
 HdJF6lDd7yqXL47771I2RlYibVSXirqmYySB52cyuu3l7qFhzHdFZo6hFSBkrwYVptvz
 O3T3frGDVg+UwqiMgyrP+ECAWQd422zmQp0KiJ3q+Xh/Qb1EIMX1+c8sswhOvnNDULRn
 rUjWIm742hEo0zzdCDdC8QolnaNzu8tDUQeMt6SwiwYglaCnK9gO9ULZ+RaoxL9rR5Ll
 t4KQ==
X-Gm-Message-State: AFuF++muFkl9ngRwI2R2wCNZEHboDth34fO3VflChM2UOFqhgMfSvy7Q
 idZyYbPhIMuvY1vTcA5ucsmgudPFN8K+1Cl4Eyf6CG1vaHLa6LzNoIqQNNEU4L4xagU=
X-Gm-Gg: AYBFou0jOXtufNA+0ZXe0foUWvq4o2Bzd0op17nOhR5hobPmYmgohxAtjloyIhodUN6
 QGKe+QLG6mRYo37ValpD6NObYSLE65YdpSPiq2B6B4bbE8yfTBom8aa1NYY7WWXdFNMoe+gmJ33
 zvJtZFXZcK79kvUXQ35fi3PfMAMoCHDb1sr3Opb3Vu/HX1DE3epECxqAUnC5THvW84amQBR3J1J
 Buvqnr9nMfNRV33bk6kKfR2JCr2W9LXVyrPW+d3sGxI143QRmL9hW7FTREUEGoToOm5t5G3IEKl
 tf/VEu2TMtFYtMHsLdE9iy4MX/HCcZqw2qoHsNrWuKPBrc33ZBOfuTY5hHnldF+uEVCj7BCE0+D
 BGxjB8yi2UT6gnnrJMFcMfroUp/NrN3W3nOIowEW+w7k93X3fTO6Qnz21rUrXxPfeitKookXfm0
 8Th29oQ3VsgNPBfMmgPzfYI2XrndmnROYsLZbCvTAyT4TanJqGLwXTrYpO3Q==
X-Received: by 2002:a05:6820:f021:b0:6c9:80d8:a205 with SMTP id
 006d021491bc7-6ca9d554091mr7678724eaf.66.1789881670749; 
 Sat, 19 Sep 2026 22:21:10 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:10 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:44 -0600
Subject: [PATCH 08/14] bsd-user: Fix MAP_TYPE definition.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-8-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Hz0H3RYGpbFw/VwjLCLVuaBzYOuoHfnxLIP6OvfwOos=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20wlkoUZhvwhxjVog6OIF8GkaKPsVir/rTgR
 zans/gDfWmJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQCVShAAzs3/frBYByYZ0dZUq+IRdartEeDwJw1
 pn5+crg5AAkwOjgP2G5ERMf1O/NM3D+CTlRaIdk2X+5thrAbZOzuAUOhat+Zt65M00jvZToKPRC
 5Nwe/kbNM7H5CnNdwSq4OUM1lJH017lSA1fa/6/gTdlrSEFYX+bsn8nE53N9b3pFjSZmUgLzaPn
 6xc/PYPqgkBb/lY0tooxAQbO83jhD93LyY6MgO+S6N6vFl/adKgBdMyJ1tWuAbhICMEATrTKDdr
 zH8VUplfh4brEoDVVAy8r2/WeqgMBVfCsfdP33Mb1GxgepTJyaAj6e0xevtRdIq0pkVEtLBjGB/
 3cIQ4mVXmxWmejlAJ+frgjbvSmSFmzO0N9HbqvCP62bHKT9n0xv2Okhppe7F8uS32MPX3CUm18l
 Vl7wHy7X+fHjjeXGv+W2ZSYdhB9gqv6Ix6FSGSAPFW1Plz9pGjxmRh/1V5m4y0qmToa5d5SxTL8
 qHe+wt7Bph1xG46LmqtmFI3O7OhE6O5tkJ9GsPBU8k6kqCmXJAzAJhHMjHi9jFAPE11L9cimtxB
 M4cIsdsVhtE7NNaHCLTFqRdLokTEJAGSEmDki8pQc4sOPa4lQL2OYM2wKmXUa3r+EOE6AtU5QoI
 lMk1EYz/yWuABZx9anpYU/LzaI6YND1z0IfFgBKu9W4GY6dJhFMk=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::21;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x21.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

The 0xf I think was copied from the Linux headers a long time ago, since
BSD doesn't define this. In FreeBSD, there's only two bits of this low
nibble that are used for the sharing type (linux has 2 more types
encoded in these low bits). The kernel rejects bogus flags (0xc part of
0xf mask), so it's better to have just these two bits here.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 506aea3e27..c4fd5f5589 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -121,7 +121,14 @@ struct target_msgbuf {
 /*
  *  sys/mman.h
  */
-#define MAP_TYPE                        0xf
+/*
+ * FreeBSD doesn't define this, but Linux does. In Linux, it's only MAP_PRIVATE
+ * and MAP_SHARED and a few Linux-specific types (0xf). FreeBSD allows other
+ * types of mapping with MAP_ANON, MAP_GUARD, and MAP_STACK. The mask on Linux
+ * excludes these: They don't have MAP_GUARD, and MAP_STACK and MAP_ANON have
+ * similar flags with different names that aren't in it's 0xf MAP_TYPE.
+ */
+#define MAP_TYPE (MAP_PRIVATE | MAP_SHARED)
 
 /*
  * sys/time.h

-- 
2.55.0


