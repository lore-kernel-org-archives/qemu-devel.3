Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD97C27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwnn-0005jD-GJ; Tue, 11 Jun 2024 04:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sGwnl-0005ix-Ns
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:24:21 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sGwnj-0003Go-Ou
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:24:21 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c9cc681ee0so2763710b6e.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 01:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718094254; x=1718699054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dqp/2xkEK3HcQoW/eJvtXy5zbjbqjYqv4hVWB9wiNd4=;
 b=faigxlizNT2Hau091vMqzGndCnkD3ldX+gDRQWSF8AfS7wMIEeOGbuuXEDN4Hpyvm5
 +InC+7ug0g1ZYf97CY0/bR907W3Ec4olcYGCtHDg73zw0IWTof2YrMofPeAi6buL9vP9
 CTmGMtcyHxy3KIPC9xVb9yyM2X2HhBoSQqR1MRv7cAou7l1BlHJYzfvp+NAU4rZlB1xD
 fHQ+cRXNKSihXwehX3SA0Fqz4zq6KFcIiwSmSWqhiWLAsKFPd9cfj6HA/9uHXgr3yTXZ
 a8203+OzcvXjflYPThgyvr8gPqU2AFz/8g68tABO4D1rDtP4Wc7/alude/n9wyB6Ma4P
 Dl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718094254; x=1718699054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dqp/2xkEK3HcQoW/eJvtXy5zbjbqjYqv4hVWB9wiNd4=;
 b=UpoOOcjVqHpTR7UcVeGg6QraAMjhNpduHXYQawnjT07RWQT2/hDXp+H7YAkaMazIyT
 /fPeu3Ez63XhM+N+g5MWdpRrjcdp8AjVVuNOeeH/ITF66hQ7JmygbhmuklbWu2zYV2LZ
 VZOMujVIWWUTMxmQr6M6nunBj5vu34FkfalcB6GgOmKA2PfUzAWEZ01fu94/7qTaEZVM
 WWVzRMGhAUv3kVJi5rUzAVtQD/dL7obZcC7EvK3Y9ys4ezzqF2yiQ3O9ToSg8E2/23g5
 aY7OE+6Qq1mNQRNAk26DV14kCqLwb8k4z94w+odKMndclj8rpKSgwRVKMt19S04MWtK8
 2cWQ==
X-Gm-Message-State: AOJu0YwXz2QCbf+TtMHR3Ipp43LRfdvg2L/x/XIVg91QlNZsHxr7Z62s
 PnFYMqWzQPB9s9Jiao4JHqnETVRIBFIJ5wHAuu8MWPY99mS2D3lVQKYFnTY8UJTFprbWQxMSppb
 0k9c=
X-Google-Smtp-Source: AGHT+IFWHaiZzcCQeEGaJAtIyNWu4jYGHZU/k4odGim8s2juCoJOs3X6EfLoI5IcGkgHkE/eyV2vuw==
X-Received: by 2002:a05:6808:114f:b0:3d2:24cc:edb2 with SMTP id
 5614622812f47-3d224ccee42mr6760811b6e.21.1718094254154; 
 Tue, 11 Jun 2024 01:24:14 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.14])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70421e6453csm5340790b3a.205.2024.06.11.01.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 01:24:13 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, zhenwei pi <pizhenwei@bytedance.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] meson: Remove libumad dependence
Date: Tue, 11 Jun 2024 16:24:07 +0800
Message-Id: <20240611082407.57154-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=pizhenwei@bytedance.com; helo=mail-oi1-x232.google.com
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

RDMA based migration has no dependence on libumad, libibverbs and
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


