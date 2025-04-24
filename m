Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11651C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 23:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8601-0003Ds-Cq; Thu, 24 Apr 2025 19:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zr-0003BK-0r
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:49 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zp-000877-1P
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:46 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so1511812b3a.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 16:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745537323; x=1746142123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9F27FfUGwswIcGWG8chjG9ToIwjCIEVz8dw0HLVPgHE=;
 b=L0GlAsmT3vGmi4m7O8dDyWN/udjovaSDCmgMEn0sjrH0THkOKNUSoR198gMJ4moBCk
 bT8tBCqFRALgUIUZeMofWSi5/64TbFbsJHvSvGIa3UTo2MBh8BRcRh39uph87kIgbrQk
 4Y9ieh24swtkgN8f4bXyc7S4kk0ogposVU4g0Zb+zzNhy2Y98woopfFe6bwCnocJqCEA
 jQVL3QUZGdg9ytNXe15YGgNE/u7jZjpTVCJQydXKrFgVWEQmhBPQA3NPyY4vAdytWPqh
 jQvBdTiGVDS7oVjmZ5kFdN3Ovr08O4QIqh13ERRxpmggvVh4uHjQW0pVxOOdUfQFih//
 XSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745537323; x=1746142123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9F27FfUGwswIcGWG8chjG9ToIwjCIEVz8dw0HLVPgHE=;
 b=YjJz7nOeaZtC6AJUPxF8KMs8kUlPbaV6Sagwvwu9p10hWMzDB7lr8KW4IMZnPbK0jv
 9/bAsQYUT7g/hln59M4GD2vH3hZqIMlVw+prWbhqEQrx1jKUS8WY1JXIanEouSEsgbLa
 Cj/4gayw5mHEMrk2r771dn2XUxnSmDdT33fXNDk4giSQhu5/tl7LpjGW/bZhAvs6elsW
 2sHAX7oCY4KsywiJVu4AWWNfpLA3MuVLodDD3BmPlHeTKkhrvF6Xd8G8dYHzoalqDw0E
 ywkCgZNKJLEY6ysMXQtN/rxFXGCmQlqf1WJofBPmmYTRzwU9NqCqoV6fWR9U1eKSpmbH
 hjqw==
X-Gm-Message-State: AOJu0YyStIUrtNckSpcN9g3ZDAM0VUo31yHfvgadYC1y+mlmXPvv0Vp3
 KPP2Fh5aUsjZmlgrQkWljBo6zVDd5ZgrrtFdF5xRnWOdFkXdqZ52bP8YMFr/EWA58HwKW0NvdP1
 siFs=
X-Gm-Gg: ASbGncvyrD7wUBBDrjzAbNNiYdnYXNkT9GAdQwM2MocBOISKXKeM56BqLJV/9KZsZAI
 aluNHWqWmECHXeF5s+lQvoGrymZgZWW9/XpLtP2flwezOTPVb5dOSy0yHzO/1P06FL/bdIFgTFq
 9gewX/yO457RNK3XsJGUJsIGRd/4EMw2PabHBcCb4r0NImuv3hhIOYhdrGY7LG5lkcZg/El481x
 uEqWm4bSgQUb7N+D+u1zn6+zG3SMjuwKoPPDDdxk6ReN9MlNZGuc/3eTuHbcqSVsyPKsyD883P9
 ExMLrRZmH+q+iN3TMqZuCl4yi5HejMq71PYQ6LN8
X-Google-Smtp-Source: AGHT+IGTEY7MSJpredylN4itwF9/84/LanVtitV9Z2CqdqmWmpF6ViT61vcHfc8hWB/Eeei44AL6kg==
X-Received: by 2002:a05:6a00:cce:b0:739:4723:c4d7 with SMTP id
 d2e1a72fcca58-73fd8e53d55mr114431b3a.22.1745537323708; 
 Thu, 24 Apr 2025 16:28:43 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25accfbesm2044318b3a.177.2025.04.24.16.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 16:28:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, philmd@linaro.org, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH v5 6/8] hw/hyperv/hyperv_testdev: common compilation unit
Date: Thu, 24 Apr 2025 16:28:27 -0700
Message-Id: <20250424232829.141163-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
References: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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
index 5acd709bdd5..ef5a596c8ab 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,5 +1,5 @@
 specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
-specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
+system_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
-- 
2.39.5


