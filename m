Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076F4CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWS-0008Ca-F7; Wed, 06 May 2026 22:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVo-0007X7-MH
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:31:00 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVk-0000a0-Qr
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:50 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7de4ed0593fso189333a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121044; x=1778725844;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3OaXMborORMMatPmIFsXY7DKnDgCYWPTloY74MIZzQ=;
 b=CAKdtio5Jhad+4PHG/FsONpkYoSk30gXPSEWYCa7Flj+WBag/F83nET8+eb0KXAUiw
 2C5g2l5XJZ0LlVqcwHkMDqIJhgovi88t7Z1wXaYcFnVzquBZs8K/qwVp1juqjbd14/E2
 PV2iJzKcA1ipysOt54eXeQ3i6sq+pH3J/2aGZQi3VpOjFHVMFOukm/uiFe2YbZYNzyY6
 DlMn2ThxDSIDQL09lTGqNx9OkYbQbZTqI2dZ7Tq/2RK063uB5vkqN2QMgzTlYZ2PgTpz
 qY/Wcx3PKOEqkiYdomcHH7C0zizcCH4l6TlMqvD8rcXu6OpWR3qLeh4AR9lMA1cN2xjV
 FdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121044; x=1778725844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l3OaXMborORMMatPmIFsXY7DKnDgCYWPTloY74MIZzQ=;
 b=tB3tY1T+KPVYWHV32n88I4PSDbE25d5C4W0nc/q2nuUjcb43G39tTXXWGVubkU2084
 rr5XOLykXI/yNmbCVjW/1OTxYAFZnyyNQaWHfYBv8TM+zAxceRUqI2O0shBX8BRFcT+F
 WuqHAc0ZOPUk4MobT/NQU4or31f+ZApoUdFqZuYtAPiI8sk62ixIpZTLzJnHMZ1tNedC
 CdECk+C6EMEuevpqMx6C6D0IMhoVIY+b+SyoH80a/pvNNsZ0OuwVuc4x1nrDzVKz7Wum
 HrajwHOom/FcqB6IiaqQ/FhISHF7lyU+Fj99iTlIVb15/lFA6++cGfcDciu30ObQGNZx
 5MVg==
X-Gm-Message-State: AOJu0YwnyqHJZvp10iqp3h+2VvWiDYhxPRFado8n59tkB9zmkOOfOcm7
 euo6akKlBXFkL686V79TjPjvlrjC4JVEUYGEvj8EtkKUW2aPO92YE7c3S4LMk4iU0P6dLvY+OWP
 N3YYu+NI=
X-Gm-Gg: AeBDieuaS/SMyPB6uTjzx3/RBH+QNCliRctuniWojfv0MxSyPg67DCiZruwy/dR4KMI
 4RlFhmZSvown8vdkIbfv75Vw7b28th565S4ED5SvQb/UJPrVrARHT4QUv5CmP2r5tneOpOwcjBz
 bOGvZwEc/VN0JYx03fQuVGMQ4r8IV2/v1AsTDwzQNQ3RfQDuPgfbL+/dnpEwAfEz9k1riBGJy6I
 Bhfos6Z/0xZ1mbXQGOnY4HPku9iG+bv0XvWTtOD6GOn0r1diF2rwbX3OJ6h63FPU1gdHQn58Ma1
 qxVYRQc8W5C8/L+jVidz/B5Tq04BSbNLrkCr/yptEgyyPTFS067pSBS3G/x8l6log0pMG3l3HTZ
 Teg9oxWRfzkSIrvbhj/oMRN2OxpfaK+oEpq+LniKuEroVGCRPSxRu/NTR9WcaxTwXVeU+AFel4K
 H8/+TOETQne8tjBZ0GPMQ6
X-Received: by 2002:a05:6830:82d3:b0:7d7:faef:fa0 with SMTP id
 46e09a7af769-7e1dee30c64mr3660824a34.3.1778121044589; 
 Wed, 06 May 2026 19:30:44 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:44 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 22/25] bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int function
Date: Wed,  6 May 2026 20:28:24 -0600
Message-ID: <20260507022827.44499-23-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x336.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add special handler for IPv6 interface request ioctls that take
a sockaddr_in6 structure as input and return an integer flag value,
such as SIOCGIFAFLAG_IN6 and SIOCGIFALIFETIME_IN6.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index d2eb9105fc..8d25d84dbe 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -260,3 +260,35 @@ static void target_to_host_sockaddr_in6(struct sockaddr_in6 *hsa_in6,
     memcpy(&hsa_in6->sin6_addr, &tsa_in6->sin6_addr, 16);
     __get_user(hsa_in6->sin6_scope_id, &tsa_in6->sin6_scope_id);
 }
+
+/*
+ * For ioctl()'s such as SIOCGIFAFLAG_IN6 and SIOCGIFALIFETIME_IN6 that
+ * passes a struct sockaddr_in6 in and gets an int out using
+ * struct in6_ifreq.
+ */
+static abi_long do_ioctl_in6_ifreq_sockaddr_int(const IOCTLEntry *ie,
+        uint8_t *buf_temp, int fd, abi_long cmd, abi_long arg)
+{
+    abi_long ret;
+    struct target_in6_ifreq *tin6ifreq;
+    struct target_sockaddr_in6 *tsa_in6;
+    struct in6_ifreq hin6ifreq;
+    struct sockaddr_in6 *hsa_in6 = &hin6ifreq.ifr_ifru.ifru_addr;
+
+    tin6ifreq = lock_user(VERIFY_WRITE, arg, sizeof(*tin6ifreq), 1);
+    if (tin6ifreq == NULL) {
+        return -TARGET_EFAULT;
+    }
+    memcpy(hin6ifreq.ifr_name, tin6ifreq->ifr_name, IFNAMSIZ);
+    tsa_in6 = &tin6ifreq->ifr_ifru.ifru_addr;
+    target_to_host_sockaddr_in6(hsa_in6, tsa_in6);
+
+    ret = get_errno(safe_ioctl(fd, ie->host_cmd, &hin6ifreq));
+    if (!is_error(ret)) {
+        put_user_s32(hin6ifreq.ifr_ifru.ifru_flags6,
+                arg + offsetof(struct target_in6_ifreq, ifr_ifru.ifru_flags6));
+    }
+    unlock_user(tin6ifreq, arg, sizeof(*tin6ifreq));
+
+    return ret;
+}
-- 
2.52.0


