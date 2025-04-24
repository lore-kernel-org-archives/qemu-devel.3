Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A428FC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 23:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8601-0003Dv-Cl; Thu, 24 Apr 2025 19:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zq-0003BJ-PL
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zo-000871-AB
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:45 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso1752011b3a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 16:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745537323; x=1746142123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWZd7ZFPXeg1oTJFx/lxzeskCkUEMUuswiCEr0poukA=;
 b=oBHsd65Zucoxvc0XuaDw2b86WmQe3SWlbbazFlS/d74zdMPv1/Ea0nV5mLsmRw8TOX
 zWqGtVxG1GRu0kbi+Ium+Wr6z780QuUw72tAyqShuJ7H+r7Qqvw6z/6PN/vZ1xTu9HM7
 QfaBg3U54Z1Bop52KdEyGKMPvAmRC9nOlhGhqjLoZ+vQqYH+hvvuZzrlvkc7vg94X2MQ
 cMUziv1WmDEZ+BgCmGrs75YSXwLGACinogPeu0+48R4SNhXm7UijtFTABuQxVPZF3qJ/
 5+7k5asAhU4/OQTtQv3cqqZOdR6q+PYI73NJ1edxJ5NygQt6zKyrVsw7w0GrjZhpV8lo
 SzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745537323; x=1746142123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DWZd7ZFPXeg1oTJFx/lxzeskCkUEMUuswiCEr0poukA=;
 b=vGvJX48uTtX+sguVpzlTzhRdh8mevRNDy146xmmHp8KxTQQt1ujc76AOI0UflcYs9g
 pS0wFYzOHYnQp9KRHZyD62tv+eoymE274JMGSwxhS0HTvGq6eWqjeRIvBvULzq7yEAif
 WF/p6eQQ/685uRdHU1pCfSSlnrCLsAtrLGtJO6V0llqIzCV6r+uapANhS4ejXaQF2PDQ
 yTDx78uD1aptAVNhCeMuAL+oS+ow9jl6QDDHFnt0baQLzQWiOgWC7Ag8K/GQiutzr8nY
 ThmCBry8XM1t6Ao6p7rOgbxOvwygE0O/InjO6tr53qMaFFG8QGQyZyE9/WkDgfRBpqii
 bXfA==
X-Gm-Message-State: AOJu0YzNp3N0rEUGT1j3XIciKQswuhvFDxybWxqEjcKcmeRyiAUNjtP/
 b8nCA7M6gBfotEEXo0tYk8NFDlNxg47mRhkKdY+THIYPsO99aCZsgKh40zBVCkzFJ5R4CnsoOJL
 FwI4=
X-Gm-Gg: ASbGncsHxGHbmSGtMekq5vfBFIDBjC36EocQ/qogVshGuA9uEdhyjshascN132gAW/o
 BDVzMR1vDn6ZEzw1ZblOqfYe3Jh9Dm57fO0JWtCWf4vRD+cU2DbDIPU7Tng0+4WfAosqlmnNfEu
 7qkXeQecEsU0zPVj2l21jDAAuqGi9Hr5TjM3GWoVUUlAce0cvuaHNqzOBQ7P+8qlyg+e52JlDP2
 CQ1CHLW0TZrri8fEzJYr1S4V48iubNGQeujaG3tspauj0pJ5BQD9XJxmZOMsRdQKAxo+8lU2ysj
 uF4RU9OJJ3ppjHfUh9jv5QzKsloayjMZKLhZuyHx
X-Google-Smtp-Source: AGHT+IHUeAU9jg7fjJObe8hCoNYEdqjCS8GEtZp7KBDMKRkvfiCPytcC+P5/ygxZ7lW0ZTirnPOC8A==
X-Received: by 2002:a05:6a00:2306:b0:736:4e14:8ec5 with SMTP id
 d2e1a72fcca58-73fd7cba6d9mr127621b3a.11.1745537322839; 
 Thu, 24 Apr 2025 16:28:42 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25accfbesm2044318b3a.177.2025.04.24.16.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 16:28:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, philmd@linaro.org, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH v5 5/8] hw/hyperv/balloon: common balloon compilation units
Date: Thu, 24 Apr 2025 16:28:26 -0700
Message-Id: <20250424232829.141163-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
References: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index a9f2045a9af..5acd709bdd5 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -2,5 +2,5 @@ specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
-specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
+system_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.39.5


