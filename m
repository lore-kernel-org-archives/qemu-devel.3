Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52A3CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOh-0004LH-7T; Sat, 30 Aug 2025 11:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us15E-00020n-Kc
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us15C-0000be-TI
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUNUdhp/2kvl0t2rlFqMP5IKnOgcmAf+2Ax3cFj3WDc=;
 b=fJ3cSmUCHhgYG2zexZuKwguEyr8F7zC8MA/eXuD3rvqzvlo3ba21CdZ83d/Cs3jaLsF08P
 Xr3U1NskItlVZO177whlfVQ0zFaGA2UQO7/SQz0CeZ3LWmFGOIBBpvU9REWZxTI9C3QNUc
 QrtCg0f7I1wzwNFZmtkhDB2mA0epye8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-oZtP84KqOYS8ZYaEbJ0DKQ-1; Fri, 29 Aug 2025 11:32:04 -0400
X-MC-Unique: oZtP84KqOYS8ZYaEbJ0DKQ-1
X-Mimecast-MFC-AGG-ID: oZtP84KqOYS8ZYaEbJ0DKQ_1756481524
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b7d497abbso9700525e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481523; x=1757086323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUNUdhp/2kvl0t2rlFqMP5IKnOgcmAf+2Ax3cFj3WDc=;
 b=BXx3QMVqAODrtTc2r3LpRnE4by6u5OPUtLvPhNsAviEJd9BTzJdCx1vQEPCbhKPZJn
 lLDSGFv2bO2qGtWplNux5i1+UPI9PqfPLLPaKiUB7D94ULubs5qnCkL+X/6H2C7piRHN
 7HlkXH32iNL64Lbd8Xbg/0gxBfZCXAZavATbVQj0VyGuo88uBG1j/E5YUgHmWjrt8ZDP
 8fPYMErI/xlcAIJrTrwB0FMk2nClv0JTgvKNjLe9O5vH2YxBMbSRzf2Yk86uy53NZCBZ
 toQ+vrS9ERL8OM2TUWFdV2WyFOik3kDoJVk1rfN8tQZM3gm5zA3GPEPHgTS4FKu/FaUd
 3xsw==
X-Gm-Message-State: AOJu0YyhDoyW+Rs72ZHHYUA+6RZxahUIi15+KUqNtjrnBdcGSduxd85W
 ItRd33rP55FFkRBiqnSL+9I3zEUDTR/0K/DqH8ulyNalmQz1vYjp4qrxlx7WFYIgncWCxNqhMh8
 8gROPhH4/I1nQhQs9/tjImMcCE9lB2a9Rk1uA12Tloq3Da7S0cB3yQHqPNUiIk4uaupvFaUSIPg
 n5tO6RNXY4GChFPbfxBXeQyVksdBclybr7qFuq5fan
X-Gm-Gg: ASbGncvzZQvNcsXY69OdHB+jnhakeMLi3hVLesyRIJMZ8tVBOPZJBXQW5zjKA8NjK/D
 z6rn5vXY9Shk51u0BrAUJ0ltNhAHqD9BKFcFex+YUa3Mo0Az2Ud7Kt13z8DWmn4NX5/8MS1a41t
 Lbws8rsMnk2Pi8nBylooudLIJIMkMh0cwAARNKdpj2Jr9nr8WUhqiyr81Y6bUly4UOrVyF5g+xv
 kdrUY+hEwBc9pTpJ/BLNuTYApVwxSsyg5jBcLNsKhUkJfCGUVkoZDlgdhTvE9XmEsy9dXvzGL6y
 +C4wNBHcqz/jHCsBYQqF0WJ4uV3QBL8bAEaB4ReuS9U8MSFDyRNCytRtaWH6Da9jMPswfrYx5G9
 2V+JSscCL3mEfnSW97m2Hk38YZSzArpPPDpFUz7jYmz0=
X-Received: by 2002:a05:600c:1c0c:b0:458:bda4:43df with SMTP id
 5b1f17b1804b1-45b727a2c43mr93391755e9.17.1756481522667; 
 Fri, 29 Aug 2025 08:32:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiKA5+9WcGOj9LIZVY6JkHxRNRVWnG6VPlf9GCNQzCnQ7A6Jqm4X+VAmtCmBqxZuKvwfqvRg==
X-Received: by 2002:a05:600c:1c0c:b0:458:bda4:43df with SMTP id
 5b1f17b1804b1-45b727a2c43mr93391485e9.17.1756481522204; 
 Fri, 29 Aug 2025 08:32:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf340b3f6esm3712275f8f.54.2025.08.29.08.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:32:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH 18/18] tcg/user: do not set exit_request gratuitously
Date: Fri, 29 Aug 2025 17:31:15 +0200
Message-ID: <20250829153115.1590048-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829152909.1589668-1-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Whenever user-mode emulation needs to go all the way out of the cpu
exec loop, it uses cpu_exit(), which already sets cpu->exit_request.

Therefore, there is no need for tcg_kick_vcpu_thread() to set
cpu->exit_request again outside system emulation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ad94f96b252..7c20d9db122 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -751,6 +751,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 
 void tcg_kick_vcpu_thread(CPUState *cpu)
 {
+#ifndef CONFIG_USER_ONLY
     /*
      * Ensure cpu_exec will see the reason why the exit request was set.
      * FIXME: this is not always needed.  Other accelerators instead
@@ -758,6 +759,7 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
      * CPU thread; see kvm_arch_pre_run() for example.
      */
     qatomic_store_release(&cpu->exit_request, true);
+#endif
 
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
-- 
2.51.0


