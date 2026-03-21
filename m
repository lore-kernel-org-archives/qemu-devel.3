Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1870B1099B58
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 00:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3kWe-0005R3-AE; Fri, 20 Mar 2026 20:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3kWd-0005Qr-1E
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 20:49:11 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3kWb-00025V-HF
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 20:49:10 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35b97ed057cso684991a91.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 17:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774054147; x=1774658947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Vn78SmAAKLbz3+kHLOEDEuAaN8ZeC+NU4A6mFcmLx8=;
 b=MFrxdr7PfbLJ9SKsElFlsyx408sS2LhE5YFhZ1IcfockPDKibiRKCQHymh0cni9WJ3
 qdgPsHqTvDvxQsCjp6KVwgD4i7639EwjZFpiyNbK66jEtCSBbuRL3Go2SNx6Au+92e2P
 5IWwKTMIZYNUwztU38jorDdAv58fJrkd6cDkauZ1tTvkBXK164p69VP3rph+QbGfzKmd
 tSgov0hhRJLw8swufbMogeeY+O6ifsT1sCxn2lMFN4W5MxvAlmmdO/gQXxpnsAFf8X2p
 d+vgfRQt8/3flr5J5DH8mf45gkaNtuXP8bpGHyJpkk3VFHqLYG33eaaYsobmlIo6AXzY
 SVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774054147; x=1774658947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Vn78SmAAKLbz3+kHLOEDEuAaN8ZeC+NU4A6mFcmLx8=;
 b=gwwoDwexd1zrmu2w7THm5DRn6hJn6j9IlDjZdYLyzPp3Pux9HtDWp3ncHurWgUtT+x
 1OmeGNOYSAPn6H+BVRqVjb1biL7+Vi9Sjozx8TJku6CMpDmny4t8ZiwuFkqgYvkGwtqO
 VfCbNLV2TC6qbcUZHYKY3FreEemuvPv/0BJBV4OEbjQK8Mse/KDhJqI2K74gzUNXkfdz
 nsi1Vjo1Chr167hRxiLgctpZzSjPlMC7utVHzWOsU4Y3yu2BlXKzmchmWVOdR/3W2Ak+
 xm3uYz8H9tY82DrP7NYZ3GCSQHSJVdM9YIY5L+vQD4sLb76NT7v4dae73PVVLs8EyMsE
 OZ+g==
X-Gm-Message-State: AOJu0YzmjxAdOOcXqkphQDFvut1VSeDff3tWddGqDeZfT9oUQ7X+Hoyu
 he5DxMrLgNFG/6bxukSEo04puOwrq5/oelGrsnillPBNdXueBEzFD0woTur5fQ==
X-Gm-Gg: ATEYQzworgzYgV+tsT8XH1/NLIv6cweY4AXKtFA47nRXhlQ1KseD1AGFfyvBYDXENHb
 IZFr1bhz2ReeqXTBf03z9i5hPJyIeLockmHAAL5jLamuRS1ppZ6zRtxjjrp5Dn1FIahz7OCUImU
 ZxXt3BF/GszXM5y/i9vXecwJyaLh3EXtPESLRCAHy8FwlHvzfHxZ5tGE8XYiNUOP3YGyA9kw3Lo
 iqIyRhOoQK0rLX07HOp8jLI8hYoaFY/v5SeYO3ykHu1KhWymISR7w5OUSBFKMV1n9lKNOBNYGmw
 HTiIfH5N2Q34VIjdmJVS7x0R+0WnIi4BUwCCTyuvcUMlZTRrKatafi/LX88WW2dkjmmw3cLu+XL
 T2kJ4xvq5yAMTrasPMJXJWxpMZHw/0AeriZdmXPAy+pJG2lGUK6rHQ43CdY2k7HwZZmQXg0Vchh
 f1lmlhXyg0sdxMzLHQxirKiXR57vNiAFkxMsf7e4da+as66KJqO9anPfeFOnpNkgDFi1bg
X-Received: by 2002:a17:903:2984:b0:2b0:5ae9:ee4 with SMTP id
 d9443c01a7336-2b0826d8307mr43580205ad.5.1774054147270; 
 Fri, 20 Mar 2026 17:49:07 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083527f84sm34637685ad.18.2026.03.20.17.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 17:49:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH 2/3] linux-user: Fix unlock_user API usage
Date: Sat, 21 Mar 2026 10:48:35 +1000
Message-ID: <20260321004836.500390-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321004836.500390-1-npiggin@gmail.com>
References: <20260321004836.500390-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix errors in unlock_user() calls:
- unlock_user() with len=1 instead of len=written
- unlock_user() with len=1 instead of len=0
- unlock_user() with len=0 instead of len=1

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 linux-user/linuxload.c | 2 +-
 linux-user/syscall.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
index 85d700953e..79416a94c9 100644
--- a/linux-user/linuxload.c
+++ b/linux-user/linuxload.c
@@ -19,7 +19,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src, unsigned long len)
         return -TARGET_EFAULT;
     }
     memcpy(host_ptr, src, len);
-    unlock_user(host_ptr, dest, 1);
+    unlock_user(host_ptr, dest, len);
     return 0;
 }
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7832a1aba5..13b8bd9ed3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2989,7 +2989,7 @@ get_timeout:
             if (put_user_u32(lv, optlen)) {
                 return -TARGET_EFAULT;
             }
-            unlock_user(results, optval_addr, 0);
+            unlock_user(results, optval_addr, len);
             break;
         }
 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
@@ -4006,7 +4006,7 @@ static inline abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
         __put_user((*host_array)[i], &array[i]);
     }
     g_free(*host_array);
-    unlock_user(array, target_addr, 1);
+    unlock_user(array, target_addr, nsems * sizeof(unsigned short));
 
     return 0;
 }
@@ -7888,7 +7888,7 @@ static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
     host_sevp->sigev_notify = tswap32(target_sevp->sigev_notify);
     host_sevp->sigev_notify_thread_id = tswap32(target_sevp->_sigev_un._tid);
 
-    unlock_user_struct(target_sevp, target_addr, 1);
+    unlock_user_struct(target_sevp, target_addr, 0);
     return 0;
 }
 
-- 
2.51.0


