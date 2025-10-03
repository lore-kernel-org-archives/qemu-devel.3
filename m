Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3643BCCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTC-00077o-Ou; Thu, 02 Oct 2025 23:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTA-00076L-Rh
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:33 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WT3-0001Eg-LA
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:32 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3304dd2f119so1493221a91.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462097; x=1760066897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEi5+3ZB5Bq/0qBmS/O/DQ+AkLgmhexYNY8zelmkyHc=;
 b=dMDyexXNwGAahdLLZQewbGOtEIHpMm3o7/8mpLl27FBONcLtXjTa1XtC1XMvspINBb
 tnq8gnlTSwUB7dBPnn4qKgDUyXiOOUd8ZIB0LpzcR74kOg/E5GGqKwwKBt8t7vPPZ9Kg
 KsDHAA6iP+9mW9aZPsLiEpWhAdyNZGUOgJ7jU25O+7qBKfYkOceeO2MZTOvWtUlesZoi
 3hre07oyEbXG0E26etBGRUTIGqmwtYmh5fjX08Xo+ATzwmGWOpkWJOq2QzoO6CeDj5dC
 f3nOL1oeT18RtCdTKAK6WWVqQJQPnRW0ov6TGZssRY957YIBp3iQ7EyWV2ga/nCx+kzg
 wWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462097; x=1760066897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEi5+3ZB5Bq/0qBmS/O/DQ+AkLgmhexYNY8zelmkyHc=;
 b=B+8lJmRPLBei/2TN+1eWhgI8NvIIDrGiB1yZM7HGw6NB1Qg9I/KOHV5qs30VbxEG5q
 sWSPoyzrmD0wr08ZP6OE6c/Qexra8kMLSgoZQ830i9ezkqaTSfOnuSTyqrlcmPl2NWUw
 yXKTrYlKCQEB0nT/E7v4sD5kYK4iScWD5+hVkpss8XrB8218CQ15FoqlhjeZwlYGKiU4
 JUhZfQL0PqqAwvY9dRJ998mEYsJjQ6P7T3LtAHAq9loIYNwy0hhKSIiYElFnbXU2x6Nt
 frN4qo3rKzM0aWrEW1f0WEWunJv0hnLjP2YrtKiAhvt0nyG6NnrmsacpzQiOV7d0wUuR
 7QhA==
X-Gm-Message-State: AOJu0YztnSFJX/qz9LpNqdRpmnKvm6XxRPSkggFyLRQRlh+tf7enT7e9
 RExA/FlJKsUl+JXaE+5E/r51zJnfQJU2cAm8f2DGpVR6FTsi+obzhDnfYCytQQ==
X-Gm-Gg: ASbGnctiqYTgiM5V7Z743Lyu9+pGNuNV8C3qCMRAyHIevl5ft2OB7Xkb10AsKmmd4kE
 HTPC4x2O7yeF69NQDxaNkQdYdWAciGnqSEBQD1v9L5BMNq3GZ1sPVBn53uzgwLh8UCGxHU9h6IY
 U6BnhoPAN4/VCHur+uLxE7WAkFy2e2Zeq1RW3PQWYq6uynJChh82SCNCCYOJTHrFsd56sfA7biq
 2eAv48v3HvOLCpplQ/XIQBKxHk4KWWpV5xBPVyN2Tkm/61fl0mDzIGHXOhcjyl0loKgz+enmZKV
 4Um5hlR+dPKEMhcrJEn3Uj10Nb9pUdz8Np28xbGntAt/6cMwDWlRC1QHz+YeLl2Bg7SJnrj0NHw
 zbWM9kQXlBN1247AbozgkQH2gl0/sLCWSnM32jbkg7LPQjN+UUB9NcdlAZgd5FFr/PaFjLeAIL3
 wbgnWKJbuSBvNtbc0dHS6XPhXxKbPKu4QGBvswWA+CSxZKdxbbCili
X-Google-Smtp-Source: AGHT+IEIApwg9KKZlvlCxsva6yueQzPeT84N1V1CnLL/t3rBQpcYKNnt53luezdE+8aJJG9hBDXPyg==
X-Received: by 2002:a17:90b:1b50:b0:330:7a11:f111 with SMTP id
 98e67ed59e1d1-339c27bfa9amr1787350a91.35.1759462097388; 
 Thu, 02 Oct 2025 20:28:17 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, TANG Tiancheng <lyndra@linux.alibaba.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/26] hw/intc: Save timers array in RISC-V mtimer VMState
Date: Fri,  3 Oct 2025 13:27:04 +1000
Message-ID: <20251003032718.1324734-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: TANG Tiancheng <lyndra@linux.alibaba.com>

The current 'timecmp' field in vmstate_riscv_mtimer is insufficient to keep
timers functional after migration.

If an mtimer's entry in 'mtimer->timers' is active at the time the snapshot
is taken, it means riscv_aclint_mtimer_write_timecmp() has written to
'mtimecmp' and scheduled a timer into QEMU's main loop 'timer_list'.

During snapshot save, these active timers must also be migrated; otherwise,
after snapshot load there is no mechanism to restore 'mtimer->timers' back
into the 'timer_list', and any pending timer events would be lost.

QEMU's migration framework commonly uses VMSTATE_TIMER_xxx macros to save
and restore 'QEMUTimer' variables. However, 'timers' is a pointer array
with variable length, and vmstate.h did not previously provide a helper
macro for such type.

This commit adds a new macro, 'VMSTATE_TIMER_PTR_VARRAY', to handle saving
and restoring a variable-length array of 'QEMUTimer *'. We then use this
macro to migrate the 'mtimer->timers' array, ensuring that timer events
remain scheduled correctly after snapshot load.

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250911-timers-v3-3-60508f640050@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/intc/riscv_aclint.h | 4 ++++
 hw/intc/riscv_aclint.c         | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclint.h
index 693415eb6d..4b7406eec0 100644
--- a/include/hw/intc/riscv_aclint.h
+++ b/include/hw/intc/riscv_aclint.h
@@ -80,4 +80,8 @@ enum {
     RISCV_ACLINT_SWI_SIZE              = 0x4000
 };
 
+#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                        \
+VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
+                                                        QEMUTimer *)
+
 #endif
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 318a9c8248..9f4c36e965 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -323,13 +323,15 @@ static void riscv_aclint_mtimer_reset_enter(Object *obj, ResetType type)
 
 static const VMStateDescription vmstate_riscv_mtimer = {
     .name = "riscv_mtimer",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
             VMSTATE_UINT64(time_delta, RISCVAclintMTimerState),
             VMSTATE_VARRAY_UINT32(timecmp, RISCVAclintMTimerState,
                                   num_harts, 0,
                                   vmstate_info_uint64, uint64_t),
+            VMSTATE_TIMER_PTR_VARRAY(timers, RISCVAclintMTimerState,
+                                     num_harts),
             VMSTATE_END_OF_LIST()
         }
 };
-- 
2.51.0


