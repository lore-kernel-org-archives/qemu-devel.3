Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EF9CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXYUq-0007Pm-Sf; Thu, 11 Jun 2026 02:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYUo-0007Nb-Aw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:02:30 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYUm-0006bG-EH
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:02:30 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ee5cdbd28so297710f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781157746; x=1781762546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2XcHyIV+vCsopBLeeIyFRcyAQJyR6pLF2IyKO0aKzdI=;
 b=d01mhKNkIutj02VNtklJ4m3KmCuBH0TkBBChfI+9GUG1AOPL5mlhpT4Tx2k0WU1fXd
 ebBKdWUryz0QtfBXdHjny137zlmuxC78PRxRyLy8UbjAcoghwFHVeqaA+ZQzVG8bSdEk
 7Ee9/5eCTcE3MOId/G2pixoImiZZAGtonjeDskRUw3HVymzwT5hga3ypRQQQQok7/moh
 BPaLmS/T2jYBuQdkJSNVWRXWB/AvdBp7mfAizFflFoTgD/GaZkUnZetVImrcW6CQ5IMf
 SyhA6X98zFeMXJj9EON70WBHBX9mubDZOHKKuuKj8gSyS4eXYhtEThWjCrGcMpgF44E5
 Tp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781157746; x=1781762546;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2XcHyIV+vCsopBLeeIyFRcyAQJyR6pLF2IyKO0aKzdI=;
 b=JecQlDsyl95OHAC3azKJrQgSgTaGu5ZulMSsh7VUEvb0yM4RZREVkL6F1pwdu4H9Bx
 KN9JFNimno3aW+wMdHrludGSFCINcTqIYfIBAkcmip3ZC41a4e2dkZHcc9U33TqSxUWw
 fU3JL2LX/MXYgMtvhUOIy8N+tFZuUmX5CC2eYEfGzK4blhnwknTu0/BShqrt0jHLkWGV
 863BL3L3rMAOFGeb2Fyo13bCZ2z7nLaCgv8kLKSq2fLU5LmeRwui7txQY2sGK7IHhULt
 ecKRQ+wQudMTnNFfwjiqmtQ+of460jJw8CFs0QHOxL7GoM2CMA2rb35nuDj/3+0m6S9f
 su2g==
X-Gm-Message-State: AOJu0Yy+AtMGp2Rb0Z/keIvmb/5rjUXO2uE6ZHiPqtqajzYp8QEyM6+i
 53hucUKKt3wPTPNB9p1Ali6OOVN4JOXWFyRMXExuds4ML1GPu7M/ec0TTmft2pI2SVYmsQVeFA+
 c9l4ZmH4=
X-Gm-Gg: Acq92OEtu/2SOJqACgmn+LH0QbFfEDHJqzsxVVVbcfh0ycsy6UgLx5dFZC02ui9Xfnq
 v/p6X0uHELbtojf38QhT/S1dZ22eXNuB9ILqo2rbpR/vc26jXRIDB0iKr09qp/RDtbGKUd+xdmK
 4Tr0xM8iHLEwEZUYRO3i6IPsegb6RVtRkGV62eFiRek5dAKJY5TBflBubBnsShUtGdVM+k48Jww
 l5fWAY1bTrlYPOfOQs3j6TfSQLcxtQX62bz9R+adz9QetebqYTFW/Mg9B1DVzjdGGUlR0EAp87U
 dK9oWwFT2sp4uskJIWg4z0tJdUPWaRxyXN7IjWqAG2xI/ERgFtZ8QtYw1a1CVEUuR+LAs3sam5f
 WCgFqLxyiI4zEU4+UzJzwu2h4SQz/pQskkZRYoC1D0Sx8OBS/Gkb+DdElWVM6M4sQqshPNcuAw6
 sGXIV2qrFyIz74mrGcdLQIr4RVHtgvFZJ/2lai80Nx0IadavoZXcCKlH4DOGclfTV/CO6x7hNxf
 6xzE2kLMMqO9iPedzNAn5wP07OD23L5YjduuY4YngDna9j7GJeF6qWZO0AuzA==
X-Received: by 2002:a05:6000:61c:b0:45e:f43f:128a with SMTP id
 ffacd0b85a97d-46067be1a8amr1218101f8f.7.1781157745910; 
 Wed, 10 Jun 2026 23:02:25 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35fd33sm84222604f8f.35.2026.06.10.23.02.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 23:02:25 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:00:49 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 18/25] plugins: add userdata to
 qemu_plugin_register_vcpu_syscall_cb
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-19-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-19-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgge40.bxa62azpxlb9@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 03 Jun 2026 23:51, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---
> include/plugins/qemu-plugin.h | 8 ++++++--
> plugins/api.c                 | 5 +++--
> plugins/core.c                | 2 +-
> tests/tcg/plugins/syscall.c   | 5 +++--
> 4 files changed, 13 insertions(+), 7 deletions(-)
>
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index d82d996bce6..909f19b7128 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -840,12 +840,14 @@ void qemu_plugin_update_ns(const void *handle, int64_t time);
>  * @a6: the 6th syscall argument
>  * @a7: the 7th syscall argument
>  * @a8: the 8th syscall argument
>+ * @userdata: user data for callback
>  */
> typedef void
> (*qemu_plugin_vcpu_syscall_cb_t)(unsigned int vcpu_index,
>                                  int64_t num, uint64_t a1, uint64_t a2,
>                                  uint64_t a3, uint64_t a4, uint64_t a5,
>-                                 uint64_t a6, uint64_t a7, uint64_t a8);
>+                                 uint64_t a6, uint64_t a7, uint64_t a8,
>+                                 void *userdata);
> 
> /**
>  * typedef qemu_plugin_vcpu_syscall_filter_cb_t - vCPU syscall filter callback
>@@ -891,13 +893,15 @@ typedef void
>  * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry callback
>  * @id: plugin id
>  * @cb: callback of type qemu_plugin_vcpu_syscall_cb_t
>+ * @userdata: user data for callback

Suggestion: I noticed in some patches you say "for @cb" and sometimes 
"for callback", if you re-spin this series you could make them 
consistent if you wish.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  *
>  * This registers a callback for every syscall executed by the guest. The @cb
>  * function is executed before a syscall is handled by the host.
>  */
> QEMU_PLUGIN_API
> void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
>-                                          qemu_plugin_vcpu_syscall_cb_t cb);
>+                                          qemu_plugin_vcpu_syscall_cb_t cb,
>+                                          void *userdata);
> 
> /**
>  * qemu_plugin_register_vcpu_syscall_filter_cb() - register a syscall filter
>diff --git a/plugins/api.c b/plugins/api.c
>index 774b1b80214..a72cec541dc 100644
>--- a/plugins/api.c
>+++ b/plugins/api.c
>@@ -202,9 +202,10 @@ void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
> }
> 
> void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
>-                                          qemu_plugin_vcpu_syscall_cb_t cb)
>+                                          qemu_plugin_vcpu_syscall_cb_t cb,
>+                                          void *userdata)
> {
>-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL, cb);
>+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_SYSCALL, cb, userdata);
> }
> 
> void
>diff --git a/plugins/core.c b/plugins/core.c
>index 878fc47cbe1..45136bf950a 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -533,7 +533,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
>         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
> 
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>-        func(cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
>+        func(cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8, cb->udata);
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>     }
> }
>diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
>index bfe12ad5558..8a823acfca7 100644
>--- a/tests/tcg/plugins/syscall.c
>+++ b/tests/tcg/plugins/syscall.c
>@@ -128,7 +128,8 @@ static void hexdump(const GByteArray *data)
> static void vcpu_syscall(unsigned int vcpu_index,
>                          int64_t num, uint64_t a1, uint64_t a2,
>                          uint64_t a3, uint64_t a4, uint64_t a5,
>-                         uint64_t a6, uint64_t a7, uint64_t a8)
>+                         uint64_t a6, uint64_t a7, uint64_t a8,
>+                         void *userdata)
> {
>     if (statistics) {
>         SyscallStats *entry;
>@@ -271,7 +272,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>         memory_buffer = g_byte_array_new();
>     }
> 
>-    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
>+    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall, NULL);
>     qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
>     qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>-- 
>2.43.0
>
>

