Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC43CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0d11-0004wi-9Y; Mon, 22 Sep 2025 05:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0czw-0002Z4-Dk
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:38:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0czF-0000h8-Pp
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:38:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so10933715e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533849; x=1759138649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+a3CcA7uLenSBTz2VMDBFRvLVHxH8fqsvjG7VIzS+i8=;
 b=slf88DH95zqEECNUrRazB52Lmp233bhb3NvOSOT1VGZiC85DbYfwDBp1g/HefOPaGq
 naJiwha6eI/I8WBSTo11XSsWMH4yFQ15/mZDoXbW+lokAs+uD0wEuWUtjs47v9uamL3/
 0fOlAPKvsxpmBf/u9VFx9yAyCo7ZUweLyRbcibNnORX7qGYAXIYG+saSHqucqL3k1u1/
 6FnHOn7Rd3IC0r7zYe0btLOsPDrYPhE0y+mfy76uiY3lNzk7Yk/m1N9xkP/MUsSCXFYW
 18nYAWx/8KLEI6RvXdkswsqeyyIWIHCsyBLSZFGU7KInWSUHrPgBRIy7k33fb0iQn0A2
 Pfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533849; x=1759138649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+a3CcA7uLenSBTz2VMDBFRvLVHxH8fqsvjG7VIzS+i8=;
 b=b3EtdlI8DvxI+GOLTeIUsxojpZIlbRICRDG+ge1sqYnq2mIdTdGAs8mVjky7IoKuaP
 nQmnOl7EcqU8u31UcP/KhZezFfb6zgTw03eC/NmrdkzB7oV6w4YI8IsmI1a7Oxa6xFwV
 b+bnUWqETBWBYecJaHhgXSsJ1oMCaRsHnicKwrP83fpEY42WrkOk+3IP/1a0PBSdaOPE
 RKnm/WEcqmegBCYtZFFIcNp6ra8ia+QoMHGORSDMFkN8hGpY99040I27EJXxNZyCB9NB
 unbVqMFKkSO9tHrKO7Gc9pgyfhTqJ0EJTgsjcDSPFnc3/YdXFw0mNibo+x6DffA43XdP
 iswQ==
X-Gm-Message-State: AOJu0YzeBLKAn5vGm4ENdoZQMMq1ySVgOAnabSxbxJA22RjOQNjVx1PA
 aqYOtzZe2JJ/D76Nyu+S5xlMSozZwf8R3nPaM0iDmPOj0a+74P+FRDH1yRQh2P36YUI=
X-Gm-Gg: ASbGncurkMHxelx50VryZn0WDJXLQjws6n8YlBE0yYRZY21dFJFx+Ok+zZAFwQ4m07k
 sIOFfEomHgdqEp3OWfR7Ukc9F8l9XU+UpGncJtaJTdr+RaQ+tKatWZaZ43iE3Xvouqpp0C2883X
 qDbPAzzjvv6tmxcfTq2D9Jzf/UiorMKUuJiYE0wmMtpqnnIX2boQ7x+OStbaC6qyOjgyctvSghy
 jzpMl+FejRD7wGiZ44HCDtCkxeSSyePKSWfjSj2YHqysfUsSjnhd4FId3GXyJFXhEVCAZDuvh4A
 Q74znv6uXoR35SN5hSZBs4dAy+O4rMCY+7H0OOoM41LPqLKWMcMk1vXgwuzrDDaVNN3PM4JHAHf
 c9xDJUSm7fLj9PiUjw/hQXQm+NVTu23DpGg==
X-Google-Smtp-Source: AGHT+IG3ndmsjU4bbWOAnoNWNzTnJGA31mG1EG0SJnedwU7MQSfWvmNHUqcLH2HPNn1H1Dx3vzcDVg==
X-Received: by 2002:a05:6000:2c06:b0:3ec:d78d:8fcc with SMTP id
 ffacd0b85a97d-3ee7e1059d7mr10967822f8f.14.1758533848798; 
 Mon, 22 Sep 2025 02:37:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f61703b206sm8925031f8f.6.2025.09.22.02.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:37:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 15CBF5FA1B;
 Mon, 22 Sep 2025 10:37:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 16/25] contrib/plugins/execlog: Explicitly check for
 qemu_plugin_read_register() failure
Date: Mon, 22 Sep 2025 10:37:01 +0100
Message-ID: <20250922093711.2768983-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922093711.2768983-1-alex.bennee@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In insn_check_regs() we don't explicitly check whether
qemu_plugin_read_register() failed, which confuses Coverity into
thinking that sz can be -1 in the memcmp().  In fact the assertion
that sz == reg->last->len means this can't happen, but it's clearer
to both humans and Coverity if we explicitly assert that sz > 0, as
we already do in init_vcpu_register().

Coverity: CID 1611901, 1611902
Fixes: af6e4e0a22c1 ("contrib/plugins: extend execlog to track register changes")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250710144543.1187715-1-peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/execlog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 06ec76d6e9a..811f3203199 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -95,6 +95,7 @@ static void insn_check_regs(CPU *cpu)
 
         g_byte_array_set_size(reg->new, 0);
         sz = qemu_plugin_read_register(reg->handle, reg->new);
+        g_assert(sz > 0);
         g_assert(sz == reg->last->len);
 
         if (memcmp(reg->last->data, reg->new->data, sz)) {
-- 
2.47.3


