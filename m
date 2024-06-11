Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCDAC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGz9G-0004P0-7y; Tue, 11 Jun 2024 06:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sGz9E-0004Oj-7K
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:54:40 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sGz9C-0006HK-IV
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:54:39 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-705959a2dfbso1582486b3a.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718103277; x=1718708077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBdgPgKkmgZSuf9w2O/T649Zg5uKBaf7W90uQ0iAef0=;
 b=a/rA+aPuY7c8amEz4XjQUGMqy/LjSArRInEK1Fg9lR6RpEH42+7xCjXfQOwx7vTeYh
 rMK4UaiLxjULTGyj6Rm+O5ITBwxBVZZfgFp3liYkm7qvj8OcLz4rqyNIt6o25gAFFbLr
 VmM0JAJQ/19W2H7RgVaSTat2PDxxVOlPkiN6sI/qYjb9zeb/pxEansEsaYOTlwOb9utL
 vovJtXu+jTupAfdqt71Kf9kmJ43WlPf3rbVPBxhB6l5RARcaxW/zwbVv1K9hZ3qiYKiF
 K3Pw+uPedgqkonoo2lnp0qrTJVx/oEsiB0PXSzIPNP94DXbg+LNorwyDxZ7KO72abExR
 nygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718103277; x=1718708077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBdgPgKkmgZSuf9w2O/T649Zg5uKBaf7W90uQ0iAef0=;
 b=mEjwW3JeK5qVJPTq45c1PhAiwO5iuCUjS5bOyCFRf7La4TPbAHoGSJFtqmqbinADjP
 P336hKLsJUOu6st+J9EQSMfih6a5o/MtxCzLg7kViFgE2t2i20GKawr6mA7+3lqoJshZ
 ocjaj90k5LpkbNCd6avipGpfA7WMjIo08jTuEO6jHJM89E5IP5UHTiItmROeCSMqrJ4t
 xegi/HZGI6pJFbhh/G/Nsn9Ia2ACjUugiodyjQcUoBHVgkVA8axJNEGjhoeLuX1w/Eoh
 0tB/UjIkFs8V0qYrDt3WwcMO3qx324b9PWLgx6fRjTqkbDgSqmS+d1Ff8SfEEgpW3tsh
 0jfA==
X-Gm-Message-State: AOJu0YySjX2ICD2crFk0D1n0Dn7m9JXndJqEIZxj9xq3M0J4qc/5Hwso
 G/9cvxq2tk6FBgxjklcOoGDOAfkxKODSe20NLFxIWcBMouxxg5SL9lhrxrc5LY4qc7E5gWzckpw
 iqnA=
X-Google-Smtp-Source: AGHT+IHrd3MUJFxEj6cdUqJj62K91vJSNAR77pyi8jnopSqmpAbJftj0I1A4yt+pSapSs0ogiDC/pw==
X-Received: by 2002:a05:6a20:4321:b0:1ac:dead:68 with SMTP id
 adf61e73a8af0-1b86bdb579amr2921607637.24.1718103275578; 
 Tue, 11 Jun 2024 03:54:35 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7042488212dsm5605381b3a.15.2024.06.11.03.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 03:54:35 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, zhenwei pi <pizhenwei@bytedance.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/2] meson: Remove libibumad dependence
Date: Tue, 11 Jun 2024 18:54:26 +0800
Message-Id: <20240611105427.61395-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611105427.61395-1-pizhenwei@bytedance.com>
References: <20240611105427.61395-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x42f.google.com
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

RDMA based migration has no dependence on libumad. libibverbs and
librdmacm are enough.
libumad was used by rdmacm-mux which has been already removed. It's
remained mistakenly.

Fixes: 1dfd42c4264b ("hw/rdma: Remove deprecated pvrdma device and rdmacm-mux helper")
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 meson.build | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index ec59effca2..226b97ea26 100644
--- a/meson.build
+++ b/meson.build
@@ -1885,11 +1885,9 @@ endif
 
 rdma = not_found
 if not get_option('rdma').auto() or have_system
-  libumad = cc.find_library('ibumad', required: get_option('rdma'))
   rdma_libs = [cc.find_library('rdmacm', has_headers: ['rdma/rdma_cma.h'],
                                required: get_option('rdma')),
-               cc.find_library('ibverbs', required: get_option('rdma')),
-               libumad]
+               cc.find_library('ibverbs', required: get_option('rdma'))]
   rdma = declare_dependency(dependencies: rdma_libs)
   foreach lib: rdma_libs
     if not lib.found()
-- 
2.34.1


