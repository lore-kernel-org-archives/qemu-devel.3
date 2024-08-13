Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0EAC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy9t-0007po-Vc; Tue, 13 Aug 2024 16:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy9q-0007br-4G
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:30:18 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy9m-0007h8-W8
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:30:17 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a728f74c23dso650427366b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723581009; x=1724185809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSADMN12Nw21+GOzmibenkJLReuL6R8Ic7sSt3Nh96Q=;
 b=I4hrz39Uj77eae4gpRyGdB3bD39XFZjBxDIEZNdSSZcTi8P9Xf3U3538UKlDVecmUa
 h8VaLefziNgF0KpwADjV7SjvpUorfiMp/mN17milKoy+ORw5EeTfB5GZQjIJX+1m4JG0
 8nuFiUQvTwBh1o8Rq8/PfH0uQ4GCnm+ntokydAGpXN8B6z0sTuGlTXj4dB3JNKJpG4Td
 huGttiIJoE+ZykqnMr9rOQjNf8cTwqG8viC7sAlyoiYZozLgu3TiEP8VoTeca8f4YIhh
 0xbKeNmOt/K5CwCWdOA+wBmGXv7crxNSkrRn1Z5zystAUTlC9/Kgl7b5cDnuELUOoKal
 BhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723581009; x=1724185809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSADMN12Nw21+GOzmibenkJLReuL6R8Ic7sSt3Nh96Q=;
 b=rfMvPYHVpz65I9Xf5Yoqa5jA4x0UahOsGPqsBkbhCktcIxA4yqJCB5dCNJ9FvjLaqk
 5oWSqL21BfGIaEsm4TD4U3SidWpKjs6mljitmYlxp6nuEcUc1bOK+l7/xasuXTzoOgCB
 eYp0L2rSX0blU5LzeRDZc+CX8sw62XE/K0RCQhAB7/P9m92BA3LbL3w2ExEgJklYfir8
 gxv98M1PPJuY0CA7zLBKxMPiYTpk7lJHfHccEcW+UEWdX/t0UuG4eX9z8rlA0pNYJGIc
 eLVILwynl0Wb1tExTuITJSHlrlQIl/vWW0uDkSBHUcAZ2KkhBgR3wPw4mmAr0ZuhHUEl
 ac7A==
X-Gm-Message-State: AOJu0YyR3uiSISvyiuNobaKSHjIRoA3bWkQbZH2INUtvlZuli7WrxQsT
 M8FbgPSBxsKiHn8Cm0zrllp5m62MKiZ4BXdSbho/b5rsM2KfO+6pd6Jv1K7Wo/I=
X-Google-Smtp-Source: AGHT+IF2NgFFUaQ5gFbiOqfH7vQ9P62+OjgyYVDmvKgygXvhJsOgUVm56mfdRn+KJhR8B47o6vlqiQ==
X-Received: by 2002:a17:907:1b19:b0:a80:f840:9004 with SMTP id
 a640c23a62f3a-a8366c1eca6mr35463466b.12.1723581008771; 
 Tue, 13 Aug 2024 13:30:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3fa69c3sm96997266b.55.2024.08.13.13.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:30:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2456F604E8;
 Tue, 13 Aug 2024 21:23:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 18/21] savevm: Fix load_snapshot error path crash
Date: Tue, 13 Aug 2024 21:23:26 +0100
Message-Id: <20240813202329.1237572-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

An error path missed setting *errp, which can cause a NULL deref.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20240813050638.446172-11-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 migration/savevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 85958d7b09..6bb404b9c8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3288,6 +3288,7 @@ bool load_snapshot(const char *name, const char *vmstate,
     /* Don't even try to load empty VM states */
     ret = bdrv_snapshot_find(bs_vm_state, &sn, name);
     if (ret < 0) {
+        error_setg(errp, "Snapshot can not be found");
         return false;
     } else if (sn.vm_state_size == 0) {
         error_setg(errp, "This is a disk-only snapshot. Revert to it "
-- 
2.39.2


