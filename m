Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A124C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgmg-0006oN-60; Mon, 24 Jun 2024 06:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmd-0006mT-QI
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:47 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmY-0007ed-MN
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:47 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57d0f929f79so3586197a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719224319; x=1719829119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePkIYhsbktpF3GtdyBZ/LusJJnuJUmhkpUEHT+S8oig=;
 b=Z+5XkD//EQxpM8WsA8LQ4Blzu1du2VFdCxRdbl4R/rqgN+2C3U8pDMqiO5Jo9k3ikV
 0vooL+W9vuJ6Am5P1vxrM6pg1E8zQyX1HaCyJXN4tLp6E9AvOxt+EsNM19clU82R8rSv
 MKgDlLlFkj5IojL0nLjJEM8AEbOefdIsAHPCH6N+Mmz3ULaTT6l2Vv768X/ItMJBM3Ga
 aAWTodcytRtSSFs2t5neonl9mcKW+L/teO5IV45UA+AX85tl0hMAmQosiJUpr07STfc3
 qgZB3U4d16eqLxo4OsTX1n2wL3MwVZyPIaS6w3yhLl+Kj6E7ZCRkXOzPc0gvHd7QfCWb
 fnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224319; x=1719829119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePkIYhsbktpF3GtdyBZ/LusJJnuJUmhkpUEHT+S8oig=;
 b=hUzlEP+o+7r6xHsqcHXnT5LrDjLIYALtUxRKEDSTRWB1IQzyPSIEOjPRbmkl87svJO
 bEih46LxLOIPSmcuj8fxqFTPRCapDruSovfz3EcQb9FtevIcLPzrU+yRod+FRWHo5PZa
 KgG7Rw8/BzsPgTOXXL0vtpuBqq4CL13KQQkkTy5Jo+WsW0lGCPj54Lhg+XvA1r1tnbjf
 O2J3cTmCsb4x0TS05BDEu+i4rPzuze/QYvFs31MsAvT7/T+VVln7cfVKUaHOnqBzb/vj
 iFp0a+xlUcBDX1FIsaGSBFKoCzuaYBBFXTxnpmw27H6tkW8eYC9iTaBz0W/asQ7FYOPx
 Jr/A==
X-Gm-Message-State: AOJu0YxqlxQdQjdIOXIV2LHH2NJ+C8GyU1CBOdc67mxmDiygWuQ1ArIL
 7SPExgySczII1+WKsD7HRwyvEjZR5S+QZGX7W+dkLrSCLvEaXwn+k8y+2fzlRI0=
X-Google-Smtp-Source: AGHT+IFzzeAFBHPFAtDV5Zt5xhcNoBENB2qO1dBQe8+FvKsnsYzi6Ci2uVRv+cHGW+5UYWtKpiCzwA==
X-Received: by 2002:a17:906:fc1b:b0:a6f:4be5:a65a with SMTP id
 a640c23a62f3a-a7245b73ffemr244048966b.45.1719224318719; 
 Mon, 24 Jun 2024 03:18:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a725b092fc4sm53108866b.35.2024.06.24.03.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:18:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9AE395FA16;
 Mon, 24 Jun 2024 11:18:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 03/12] plugins: Ensure register handles are not NULL
Date: Mon, 24 Jun 2024 11:18:27 +0100
Message-Id: <20240624101836.193761-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624101836.193761-1-alex.bennee@linaro.org>
References: <20240624101836.193761-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Ensure register handles are not NULL so that a plugin can assume NULL is
invalid as a register handle.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240229-null-v1-1-e716501d981e@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240620152220.2192768-4-alex.bennee@linaro.org>

diff --git a/plugins/api.c b/plugins/api.c
index 5a0a7f8c71..6bdb26bbe3 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -507,7 +507,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
         }
 
         /* Create a record for the plugin */
-        desc.handle = GINT_TO_POINTER(grd->gdb_reg);
+        desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
@@ -528,7 +528,7 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 {
     g_assert(current_cpu);
 
-    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg));
+    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
 }
 
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
-- 
2.39.2


