Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEC6C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqqB-0005qW-1t; Mon, 22 Jul 2024 07:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq9-0005iA-2V
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:25 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq7-0002S0-Ch
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:24 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5a10bb7b237so3415590a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646261; x=1722251061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUepoQkJbTEdFdSk4GA6KAzs4URRnm4V9SeWpypNLMA=;
 b=yobLrQ96S33VR/w0VHi5hvI56kMEX/b2+bE22ik6Hj9w2A8YEFntd3xXCBIaGfW3j0
 8P45FtH68Xx4IXENO3X8DqZfjWUZ9vj5o7VvGI8soBCUGa54odPihJSesbtZa3Kx6rky
 QpfYnKzabwo339RQhNchZlYsjZxPbvkpt6UOlh0PIoAZCiIyj7GQ9tOpcVlRId6kEIkM
 AVpZNqCysnGJAhkZFCQZ5PPM20ZOvCILGq/JbUrWMPf9iddwW9HfVkJWe0kAisSXMEm8
 J4ubUnmHYp6VEbaydGz7L1/IEu3n+caInBHm2vMWMsHw2in3H2jHgyA1egOmLDV+lo5F
 FMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646261; x=1722251061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUepoQkJbTEdFdSk4GA6KAzs4URRnm4V9SeWpypNLMA=;
 b=XSseW87WffNvC5W659T80jQ3DUnMDIloC4442sELOYX3S5M6PbbLrI0J49zYl1OcG5
 IKjLXk+KRcXu1giDlq9v1XHTQDSiIWfgnyOeksLk7lTtp7CICLbFqzDvhP3vnHPWWwCX
 Sv7rkn6ADRNK8O4Etsp0aaXbSKEqDlGEMZ2ZTdMy0NwgOnb4jW04JXY+a55ITv5vQkqO
 P/xmo9ohvYe/INM00iPWies1tc3Q1wl3W01WpZes7IM1VmOrHeVt8IiZEZ7Ngaxx+ZJM
 ChyhMQGEz5GPgqXDT5DJIlqs7x0z8x95gfnW0y1pP44r9tx/qFyuspxEPz3PvsOEBK0T
 4TeA==
X-Gm-Message-State: AOJu0YyvmsUstSGCFO+KRuCE5JapZR8FmFB5TlX3qlOMjR2aJKJZgoZZ
 KFB2w6bRXe4ASKitYo56PyqmD4xyLYSYbUST0kSvKbGfVqUqGcAubYFblhQJBxI=
X-Google-Smtp-Source: AGHT+IGHGUGYbCwIwElDnZU2JS9vqSfQ0LG915eoJKSKTfxOXPJa5yG3Yu/9adCIShQWZYPfLcgJUA==
X-Received: by 2002:a17:906:6a06:b0:a77:b664:c078 with SMTP id
 a640c23a62f3a-a7a4c010bcemr469474066b.27.1721646260391; 
 Mon, 22 Jul 2024 04:04:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c94a9e0sm409565266b.188.2024.07.22.04.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 15DD95F9F4;
 Mon, 22 Jul 2024 12:04:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 05/16] plugins: fix mem callback array size
Date: Mon, 22 Jul 2024 12:04:02 +0100
Message-Id: <20240722110413.118418-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

data was correctly copied, but size of array was not set
(g_array_sized_new only reserves memory, but does not set size).

As a result, callbacks were not called for code path relying on
plugin_register_vcpu_mem_cb().

Found when trying to trigger mem access callbacks for atomic
instructions.

Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240706191335.878142-2-pierrick.bouvier@linaro.org>
Message-Id: <20240718094523.1198645-6-alex.bennee@linaro.org>

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b6bae32b99..ec89a085b4 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -85,8 +85,7 @@ static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
     len = insn->mem_cbs->len;
     arr = g_array_sized_new(false, false,
                             sizeof(struct qemu_plugin_dyn_cb), len);
-    memcpy(arr->data, insn->mem_cbs->data,
-           len * sizeof(struct qemu_plugin_dyn_cb));
+    g_array_append_vals(arr, insn->mem_cbs->data, len);
     qemu_plugin_add_dyn_cb_arr(arr);
 
     tcg_gen_st_ptr(tcg_constant_ptr((intptr_t)arr), tcg_env,
-- 
2.39.2


