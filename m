Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5277C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaX-0000oU-UZ; Tue, 27 Feb 2024 08:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaI-0000jU-Ny
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:27 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaG-0002rk-U9
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:26 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d27fef509eso38015811fa.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040803; x=1709645603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=no1yxF9QVzDWCiPK1PcrjBYtl68uz4bzwyJtwJFIo0s=;
 b=qAkMtt9YeVMkY7NqDuwUEFs1X/walUnQBlsN5wXcN/owHivp1GrrMQlRLjLGxmYb5E
 Z3kvBbReG336hskZ7QTsnpaHaPbzDlwGjnnLoZZe/LqQqwVHMROAdRPpnbGtmVxMjm6z
 8VMN6milsiExrbaW6rYzYb5aZk7fyBUfZ6pEaTcRbLSgDC0Anh4ZNuf7WTxmHwdc4Abw
 En4m0+IsaUC/1zgjIzQJiaB5RkX7pBBwkhslWtcH5lGCGhqS+JkI4t0pP42/Xt1KWikr
 fPl0gyfF+VZ34hOWNb+ZGXlar6oHYUbEmeFg9l2enIOppFWBANKIuoYDkEazMfaaIgwF
 Hb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040803; x=1709645603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=no1yxF9QVzDWCiPK1PcrjBYtl68uz4bzwyJtwJFIo0s=;
 b=eyXn9sg/qfBU/hirxre4sgBA//2hCKDM30DlrZUOZw/8cv0zknFi+NP+cQ/Gq4FzOQ
 rkr327EqcCfT5cmd7yUI6uczk/grlLEDCZfbOlKzEooM4/NcAa38KQD82gHmt0XkUXAb
 Fguv/qOlY4gKibC4CDcknR/hSJBseLrAqUuodL9rGvPYOFdMRmB7vkBS4kw97UQccaVi
 +OTIeJapzxNIwtb5/Tk/R3DJfARKPnqD1w5K5pTAc2g5b1erDrlQcHv1FqvKy6wUKRZm
 Ae0+6ovpclgIAaQJQDJs4CMvjkcRY129RaHRbBb5ERnPO6s2Eb3vaLgsh/kT0+dtkGlI
 QTjA==
X-Gm-Message-State: AOJu0Yy0sygK8FvGdIIg0/kA1LvLD85BT0KjsMATR4Jf3r8MJxvonlGy
 maS9TlMbY1ynylEqzPNcXOR7AfIDAkqsKVZ5y1P7DBEEcqxYAMnEK16at9wdAZ14AYn3CWu1xSo
 r
X-Google-Smtp-Source: AGHT+IEMLdZLHX3Gofzv/34gtfKVItRlyrJhiHK6ayiJBz8+l8htyfPyuAcJ0DvCid0fkbpxA4Bu7g==
X-Received: by 2002:a05:651c:556:b0:2d2:a443:9c64 with SMTP id
 q22-20020a05651c055600b002d2a4439c64mr851055ljp.45.1709040801748; 
 Tue, 27 Feb 2024 05:33:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/45] arm/ptw: Handle atomic updates of page tables entries in
 MMIO during PTW.
Date: Tue, 27 Feb 2024 13:32:41 +0000
Message-Id: <20240227133314.1721857-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm far from confident this handling here is correct. Hence
RFC.  In particular not sure on what locks I should hold for this
to be even moderately safe.

The function already appears to be inconsistent in what it returns
as the CONFIG_ATOMIC64 block returns the endian converted 'eventual'
value of the cmpxchg whereas the TCG_OVERSIZED_GUEST case returns
the previous value.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-id: 20240219161229.11776-1-Jonathan.Cameron@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5eb3577bcd5..ba1a27ca2b5 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -711,8 +711,68 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
     void *host = ptw->out_host;
 
     if (unlikely(!host)) {
-        fi->type = ARMFault_UnsuppAtomicUpdate;
-        return 0;
+        /* Page table in MMIO Memory Region */
+        CPUState *cs = env_cpu(env);
+        MemTxAttrs attrs = {
+            .space = ptw->out_space,
+            .secure = arm_space_is_secure(ptw->out_space),
+        };
+        AddressSpace *as = arm_addressspace(cs, attrs);
+        MemTxResult result = MEMTX_OK;
+        bool need_lock = !bql_locked();
+
+        if (need_lock) {
+            bql_lock();
+        }
+        if (ptw->out_be) {
+            cur_val = address_space_ldq_be(as, ptw->out_phys, attrs, &result);
+            if (unlikely(result != MEMTX_OK)) {
+                fi->type = ARMFault_SyncExternalOnWalk;
+                fi->ea = arm_extabort_type(result);
+                if (need_lock) {
+                    bql_unlock();
+                }
+                return old_val;
+            }
+            if (cur_val == old_val) {
+                address_space_stq_be(as, ptw->out_phys, new_val, attrs, &result);
+                if (unlikely(result != MEMTX_OK)) {
+                    fi->type = ARMFault_SyncExternalOnWalk;
+                    fi->ea = arm_extabort_type(result);
+                    if (need_lock) {
+                        bql_unlock();
+                    }
+                    return old_val;
+                }
+                cur_val = new_val;
+            }
+        } else {
+            cur_val = address_space_ldq_le(as, ptw->out_phys, attrs, &result);
+            if (unlikely(result != MEMTX_OK)) {
+                fi->type = ARMFault_SyncExternalOnWalk;
+                fi->ea = arm_extabort_type(result);
+                if (need_lock) {
+                    bql_unlock();
+                }
+                return old_val;
+            }
+            if (cur_val == old_val) {
+                address_space_stq_le(as, ptw->out_phys, new_val, attrs, &result);
+                if (unlikely(result != MEMTX_OK)) {
+                    fi->type = ARMFault_SyncExternalOnWalk;
+                    fi->ea = arm_extabort_type(result);
+                    if (need_lock) {
+                        bql_unlock();
+                    }
+                    return old_val;
+                }
+                cur_val = new_val;
+            }
+        }
+        if (need_lock) {
+            bql_unlock();
+        }
+        return cur_val;
     }
 
     /*
-- 
2.34.1


