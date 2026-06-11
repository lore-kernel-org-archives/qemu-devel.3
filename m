Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F82CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXYWV-0000JK-QM; Thu, 11 Jun 2026 02:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYWN-0000GT-KB
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:04:08 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYWL-00076u-Qo
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:04:07 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso4139015f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781157843; x=1781762643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cmPQy9U2EIStzVN78V8uvbju9EYLBNeLdxPb3xfTNzE=;
 b=Fi/CH6sxGq5hC/OCVuC1IHc9TCdoTL/gQduB7XOwZoAI4cS8Bl+MrqjIoLG3umVi0N
 rUSKBYcrTNt0JdAC6ygj+gii33m2gQKiCKZrGev76iiG6PiujzPm3RdneaD3Qh4c4iA8
 dNtYa71myZtuxzWC10wcP3rb1MXYxnXM0QOgF50ZeorOruaFovGdeX3tS4EPbwvOjFaV
 Sy92896BQ9YhWnj527ksxwLBIfHRiaqOhQ+gqJEJihTuskjfyJ2HrEqP/CWUHA1uDQQ9
 Hd+px7PdV8V9opueLUxMNKOlkp8yyN1aZRDZ3g0Fdhkd02kSAkh+jMttzn5SNP5sSUxx
 p15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781157843; x=1781762643;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cmPQy9U2EIStzVN78V8uvbju9EYLBNeLdxPb3xfTNzE=;
 b=fGOOpSwU3fvBsMNU4Z89LG6EVA6BzI4bNhmmdtu1bPuUnjK8eDfj6YpzCARRSRySe9
 4H2MMIyvf98+mtXnTJnA7IGNneYaLvtcWX7nWoZCF3+gB3DWMnbxJgg9aVtOgoN0v0sL
 aL9OPlW6Uuhybu05J0kFZJTa7jsBZPrg0JiofBS48bsk3mk6cwb+PXrkcAyXNHNSEEmb
 62wKNBKChbuunCPkId0kg9llnNhg0mBU7+rWuYmAY/NimivtE6OIoPdkzVjmBuHicXnn
 mLiyUNQXLBSj4Qhd1gu2p8X7y6EEvIRvQqs2z9p/53ElnZcMOquSXDth+J33mGoRmNdA
 KHoA==
X-Gm-Message-State: AOJu0YzJS/UVe+M70d4CO740cwZC417ZIoeSemJ8uoBepQ6TLjtcOldD
 2UUu78dIAlrXeSlmKzuwjIYLwZ44trREwZAW1cm17uLmoUsdx3ESxPM8uuU+7LciChOLxxZoncG
 DXnn3R4I=
X-Gm-Gg: Acq92OHQ8mvJZQpBO/j1pclq+1t6Lsvo3fMwkADrMMqQBIsokywDJ+aA6AIHbFRyD9W
 0SHaZXRwcJqkKRndB3LRCLiii+IbfNVSWxfBb0p9rxf1nFk7WedVAU8M900hfXD2SPfJ+7qteGQ
 cBDf16nGJccadDb/jLlByG2PkjCbWyoc4D76wPpil0o7GaOuHFfE0mQAaMwlp2keIwkHCRjM8/K
 53J/jtY97PvMFv+Cb2iAZyz/I3m1yn09mspkTNlOFPj0Q0wqqe7JZXF+oHT2zAKp6QpyJiIeBj1
 eAFdMyII5sAlCTiE11b8rYIVMMEOqHHxlXUn092DomkhfiAUminTYNBEbME2X19ATxjHRTDF82q
 cHIBAomvT4H5kl/fgr20nFkeRr8PyQIZLezlR9AbM6ODjlZk/l0L6wB9bDNC+yqgbX7vhBU5NYs
 R7uXVEdcCThQcfIO88sf6JhXrAXQCCOQYmlpkaJhsPaWQh4H6nxtw91PxYwAf0CMq8ue6u4DPB0
 8QyS7LqtreG/OTG9yS2XX5VRMeazoDSlvohdqbo7YynTCm1tcno+ecgyJzmzQ==
X-Received: by 2002:a5d:584a:0:b0:441:1e1e:a050 with SMTP id
 ffacd0b85a97d-46067583a97mr1608215f8f.16.1781157843264; 
 Wed, 10 Jun 2026 23:04:03 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dcbdsm65392950f8f.7.2026.06.10.23.04.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 23:04:02 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:03:18 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 20/25] plugins: add userdata to
 qemu_plugin_register_vcpu_syscall_filter_cb
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-21-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-21-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgge6p.2iqd89ffv7g2z@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> include/plugins/qemu-plugin.h | 8 ++++++--
> plugins/api.c                 | 5 +++--
> plugins/core.c                | 2 +-
> tests/tcg/plugins/setpc.c     | 4 ++--
> tests/tcg/plugins/syscall.c   | 4 ++--
> 5 files changed, 14 insertions(+), 9 deletions(-)
>
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index c38ae7db1b3..33d6f8e0b7d 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -863,6 +863,7 @@ typedef void
>  * @a7: the 7th syscall argument
>  * @a8: the 8th syscall argument
>  * @sysret: reference of the syscall return value, must set this if filtered
>+ * @userdata: user data for callback
>  *
>  * Returns true if you want to filter this syscall (i.e. stop it being
>  * handled further), otherwise returns false.
>@@ -872,7 +873,8 @@ typedef bool
>                                         int64_t num, uint64_t a1, uint64_t a2,
>                                         uint64_t a3, uint64_t a4, uint64_t a5,
>                                         uint64_t a6, uint64_t a7, uint64_t a8,
>-                                        uint64_t *sysret);
>+                                        uint64_t *sysret,
>+                                        void *userdata);
> 
> /**
>  * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callback
>@@ -906,6 +908,7 @@ void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
>  * callback
>  * @id: plugin id
>  * @cb: callback of type qemu_plugin_vcpu_syscall_filter_cb_t
>+ * @userdata: user data for callback
>  *
>  * This registers a callback for every syscall executed by the guest. The @cb
>  * function is executed before a syscall is handled by the host. If the
>@@ -916,7 +919,8 @@ void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
> QEMU_PLUGIN_API
> void
> qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
>-                                            qemu_plugin_vcpu_syscall_filter_cb_t cb);
>+                                            qemu_plugin_vcpu_syscall_filter_cb_t cb,
>+                                            void *userdata);
> 
> /**
>  * qemu_plugin_register_vcpu_syscall_ret_cb() - register a syscall entry
>diff --git a/plugins/api.c b/plugins/api.c
>index a72cec541dc..f2176be5304 100644
>--- a/plugins/api.c
>+++ b/plugins/api.c
>@@ -217,9 +217,10 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
> 
> void
> qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
>-                                            qemu_plugin_vcpu_syscall_filter_cb_t cb)
>+                                            qemu_plugin_vcpu_syscall_filter_cb_t cb,
>+                                            void *userdata)
> {
>-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER, cb);
>+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER, cb, userdata);
> }
> 
> /*
>diff --git a/plugins/core.c b/plugins/core.c
>index 987e49b89cd..fe292a098da 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -590,7 +590,7 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
>         qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
> 
>         if (func(cpu->cpu_index, num, a1, a2, a3, a4,
>-                 a5, a6, a7, a8, sysret)) {
>+                 a5, a6, a7, a8, sysret, cb->udata)) {
>             filtered = true;
>             break;
>         }
>diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
>index 9bb5bf0f5f7..7c78f182f01 100644
>--- a/tests/tcg/plugins/setpc.c
>+++ b/tests/tcg/plugins/setpc.c
>@@ -27,7 +27,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
>                                 int64_t num, uint64_t a1, uint64_t a2,
>                                 uint64_t a3, uint64_t a4, uint64_t a5,
>                                 uint64_t a6, uint64_t a7, uint64_t a8,
>-                                uint64_t *sysret)
>+                                uint64_t *sysret, void *userdata)
> {
>     if (num == MAGIC_SYSCALL) {
>         if (a1 == SETPC) {
>@@ -99,7 +99,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                            int argc, char **argv)
> {
> 
>-    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
>+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter, NULL);
>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     return 0;
> }
>diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
>index 2afd71895e3..410fe617804 100644
>--- a/tests/tcg/plugins/syscall.c
>+++ b/tests/tcg/plugins/syscall.c
>@@ -175,7 +175,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
>                                 int64_t num, uint64_t a1, uint64_t a2,
>                                 uint64_t a3, uint64_t a4, uint64_t a5,
>                                 uint64_t a6, uint64_t a7, uint64_t a8,
>-                                uint64_t *sysret)
>+                                uint64_t *sysret, void *userdata)
> {
>     /* Special syscall to test the filter functionality. */
>     if (num == 4096 && a1 == 0x66CCFF) {
>@@ -274,7 +274,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> 
>     qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall, NULL);
>     qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
>-    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
>+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>     return 0;
> }
>-- 
>2.43.0
>
>

