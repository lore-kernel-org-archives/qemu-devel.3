Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFC4FA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdkp-0000io-Tc; Wed, 22 Apr 2026 16:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkm-0000Kw-OR
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkk-000284-W0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso65379115e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888053; x=1777492853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lef9OChV9qiaAypun+vGLqmkTQZPcx6dACWsaAVRFOY=;
 b=tZbkEcbo3nsN+0sftVO7sKiybw5nSRqX7WSZL8y8hWozXug7Xy575rlHUviXx7YKvI
 asJ0AKUxIyVDAPbPb5PmhCN8bDYi61MdJ9wx3MVgjdKBY4i2rbNA2ZyOLVJrQvQbyQMW
 4QdgDiRAsaj6DVqjurWpiFXPgjCQpXTPktyp0V4KuwevFyXSknkE9PvBkA6D+wVYWlLn
 F9BljmFUjvqu86+PLnouqhhhzlv6d7HJ6g1kAXF0zzLrLs6OjEI3IjT2X0wgH5fxpuTn
 reCRuzGL0XB5SDldowDkPCrICmC3F2bJcbrMiQAPhq5Ai/YxJyOKOISIEgsMxpGXkJb5
 61Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888053; x=1777492853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lef9OChV9qiaAypun+vGLqmkTQZPcx6dACWsaAVRFOY=;
 b=cmbaGCokNqxAvaKK/jy2iWbZRRVSKkbHUMXq5vhh4W6CthQdeoN/wSXvqpWBqIPSi9
 S4XGVWotTStGurnb8u7aAJ7XU0D91n+WMRnTHWC+aRH9VFKnErLqc7EUVgLeQz1MSJMo
 Jl69eFVt/G2OBRL0M0l0mwbSkgyg1kMEQX+FxMTBQuquo1aQc/k4joOnQ9gQ2p6pkrGk
 OYsTMTjVnpMEIZvLQqm2RYlM52yjz4lxTH/D5p/Y6vKHI38d4d85ZwY/F97KZsg9cxt6
 Ft79eMlTrlLVTgVEWDkckq2VOHDt/OUi6dlgvv31uiQqt7NumhbpoWXI10mKVJqdD2iW
 dDFA==
X-Gm-Message-State: AOJu0YxcJfFR+X7ADwylaSwXzDd6R9KsUm+yRv1j2+U2158UYglV+s/m
 M3C1IlE+WmvbFI+ETu4zkUP8RK7tws7XvmrPaPX8eB2ci1Jic0HDJRdjfk+7MAY33YU4c5RrI4u
 higR/Ows=
X-Gm-Gg: AeBDieulEqV+Y9r/2HoI8D1WgSsadqc2NOdBobQNGL7zFLfWWHwuqVkaFQPUV49jE/C
 MD39VetO+IodDpU8Kgh/xbcVtLRcLo8e4eY6DxEhbZU9+YCOVlOiwW1QaQuK2U8P4rYL/RFCK+j
 ZHJuOwWSGBMBuLzE8BKGZ0EJ6cH4gYXOAVRKyr3IWPPkyh23/lmozpNYKVsUl8xZOTBWu0dBFRi
 bWMyGMNqxO+tYPJGe0RGib9B6o1uUXxrL9DeoKWMqQe8Uhmjlpn5u305Mj9Rfd5mPj2LRQhscct
 qvF9wN8BFv0Bm6rk6EHCV+f1q+Q0+6f2A940jtwD5IvHHf3R/iE2Dwo3YmhC2d3dtE31KLPzoyU
 v2FJnpexCONDkfDQWz1RPGR7RKUnqRg2BZq2RrQ2AYsqmh4pbQ4AQQqMXw4jMvwi9jow/6H08q7
 6bOcrFKPqdAr2cF6dg5Z5B3XgYeLrusjzINXSmL9k8sAWy53u19Dp1cCkGfMZRukrTtM3D/UsQy
 DYcRFnL1yw=
X-Received: by 2002:a05:600c:c090:b0:488:c744:49b with SMTP id
 5b1f17b1804b1-488fb74a53dmr250783555e9.7.1776888052999; 
 Wed, 22 Apr 2026 13:00:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5c4b9e8dsm14474505e9.7.2026.04.22.13.00.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:00:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/48] system/memory: Constify various AddressSpace arguments
 (flatview)
Date: Wed, 22 Apr 2026 21:57:24 +0200
Message-ID: <20260422195746.88865-27-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Mark the AddressSpace structure const when it is only accessed
read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260319191017.12636-2-philmd@linaro.org>
---
 include/system/memory.h  | 2 +-
 system/memory-internal.h | 5 +++--
 system/memory.c          | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index d7b18b632d5..1417132f6d9 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1201,7 +1201,7 @@ struct FlatView {
     MemoryRegion *root;
 };
 
-static inline FlatView *address_space_to_flatview(AddressSpace *as)
+static inline FlatView *address_space_to_flatview(const AddressSpace *as)
 {
     return qatomic_rcu_read(&as->current_map);
 }
diff --git a/system/memory-internal.h b/system/memory-internal.h
index 5f0524756eb..0066ffdffb6 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -20,12 +20,13 @@ static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
     return fv->dispatch;
 }
 
-static inline AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as)
+static inline
+AddressSpaceDispatch *address_space_to_dispatch(const AddressSpace *as)
 {
     return flatview_to_dispatch(address_space_to_flatview(as));
 }
 
-FlatView *address_space_get_flatview(AddressSpace *as);
+FlatView *address_space_get_flatview(const AddressSpace *as);
 void flatview_unref(FlatView *view);
 
 extern const MemoryRegionOps unassigned_mem_ops;
diff --git a/system/memory.c b/system/memory.c
index 56f3225b21a..b92f6eb140b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -819,7 +819,7 @@ static void address_space_add_del_ioeventfds(AddressSpace *as,
     }
 }
 
-FlatView *address_space_get_flatview(AddressSpace *as)
+FlatView *address_space_get_flatview(const AddressSpace *as)
 {
     FlatView *view;
 
-- 
2.53.0


