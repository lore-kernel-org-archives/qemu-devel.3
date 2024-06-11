Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BEEC27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 09:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGxnL-0003uB-8m; Tue, 11 Jun 2024 05:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sGxnJ-0003tc-6H
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:27:57 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sGxnG-0007LX-5X
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:27:56 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c9c36db8eeso433985b6e.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718098072; x=1718702872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVuScrtvPF/iWEyJKjrN4nergyjN2l8nKSdK5qVeQXg=;
 b=IVQV8LxxfhliT9uus5vp9gGd33JM6/o4vNdRvE7MRKjpadhLU2Xq2BWwY90sWsHhe/
 2uthpJ7Uovw/10Zpa/IMPmpjnU7aH/1D1VV2QFTW4jZYnehD1YLv94XaH/6mXc95rrpB
 bf7MkZZDoUPQl/LmByPfkX3gBRk4HPbpljjVWzYsFYwE385sLwZ2eP07PfUER9gnSkk6
 wHuP7ZnLkzTkXpsOqX7xCIZLozJXqevLKI9b2pX1F3vgdyPTF+stolrkkay22z43IEZq
 Wv9Vwy1ONO9wSF9EJzCYsK3w4Bf70hL3Zwas2+vaS9X1wkKVlYzixtzlHp2xrjrLacAi
 Meag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718098072; x=1718702872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVuScrtvPF/iWEyJKjrN4nergyjN2l8nKSdK5qVeQXg=;
 b=c87GDP6vHU5uFYO59+09hVsSZn1ou9mdD9X6ky4LSSfoc+2ATKMYP8ukG0d0fmO+Ld
 8Etsd7NizJ8s9aRmLxycHvnsGbQqr7YS2hFwTV3HsGfdegRaJHr6CPdKHsxln7fJKoa6
 yMZn+rG+oMNMZX5R6Z7GpRI8r9fzDm00+zct/Mm/bCDIJ3itso/dXX6PUVbOZx2ah/u1
 doeiNuW2qvr9oMsJG1VvG2iAd1J5FuXwFjEn82T9CjWvWWSY78VR6vRUjeHDzxjMqFAW
 /TxOEeeS7tAPwY///192Boc+zptCBr3jvSq9hUK3AZALiI6RP6OcWeTk9xRS6jKxB9uD
 hFqQ==
X-Gm-Message-State: AOJu0YwhvV5VDcEaw4UG+Jmta15jrcbz6ltkEbp8lTJZteIMeaeEQXlg
 U/2JC82AstylV/n2JELKmmq+0rnDDyoMei4ON7q03/ON8FUpZ3Lg/dfJzqIpMZZyJqBGPDAKKgJ
 to8o=
X-Google-Smtp-Source: AGHT+IHZ/YZS58CyiB9yf8noA5DGwn3LYMw4csyOx9OQzIP/sHz3t0K/l/orsLUuie0X4D3yKq6orw==
X-Received: by 2002:a05:6870:638e:b0:254:affe:5a09 with SMTP id
 586e51a60fabf-254affea8a0mr7723769fac.3.1718098072285; 
 Tue, 11 Jun 2024 02:27:52 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7041cda06f4sm5871153b3a.75.2024.06.11.02.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 02:27:51 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, zhenwei pi <pizhenwei@bytedance.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/1] meson: Remove libibumad dependence
Date: Tue, 11 Jun 2024 17:27:43 +0800
Message-Id: <20240611092743.59255-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611092743.59255-1-pizhenwei@bytedance.com>
References: <20240611092743.59255-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=pizhenwei@bytedance.com; helo=mail-oi1-x22d.google.com
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
 meson.build                     | 4 +---
 tests/lcitool/projects/qemu.yml | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

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
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 070d7f4706..0c85784259 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -47,7 +47,6 @@ packages:
  - libfdt
  - libffi
  - libgcrypt
- - libibumad
  - libibverbs
  - libiscsi
  - libjemalloc
-- 
2.34.1


