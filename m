Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8E6C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2aj-00012m-IE; Wed, 02 Jul 2025 14:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2ad-000124-0b
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:53:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2aX-0001R4-0C
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:53:50 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-453426170b6so1006135e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482422; x=1752087222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fPb3mcKHQMn+mt9R0xeKlU7lt/6avmr2iZZUVi63QQ=;
 b=EiKASSlzyHyGT1YS2DXx9a6WkqGKqgFWAVe1LnuiSAqvzmqqQCu6ucS9XLxpciiBkq
 LfEDhCBnJJi7DsrdIy/R+K2IXuXYtdGEKIxMgACZPEEfc4xY/VkRfKHULh3ahVJAwoQo
 iNb7BHqBx5UZxVQ18RwPiFJEcfdi1RxTkOVybWkb5JEcRNJ+89B8evwIgplCzDF+e9fB
 /OQEz7WyOg/g4Mo3bXFf5QWrF0+QhppBj+u2BufW8Sd+PygUBjBC+jqap20nGQa1a4hD
 fU9HL8e5ssO8MWDs7LItV6kKUyGxWg/T2sTk40eQkeuGbtoKP48CiJZ8PAlOfcDqZKGj
 qbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482422; x=1752087222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4fPb3mcKHQMn+mt9R0xeKlU7lt/6avmr2iZZUVi63QQ=;
 b=tEA3IiCzz5LF96UjcnGxCXZGD005MVHWULg/FQXY34ZyHljnKsMznCIr1LIYHVRajv
 gwdwf4BE+eqHcB5vOVyoTDBsCxKLW16x7ZkEqy82DanuRJGNsNZsxnFsYj9teg+5petN
 0iVqS+6rgSrMwgKLN9MM1+oY8ch8Oiv3o/EYxRdjkTMoLhMxTeqnIESEVNzKNvrcQpRn
 nT12XQFY5k2hXrAFJscglLVqugUTDpyPjk9rU9Jj2TKuR5MKQ+EoYdHZA9VrlvY+H/Vo
 2yGKAonoOPKuf5jX3XdHwwY8LQqxT4fXzBVtAzG6IRLrISgibvTL/i0ubHjoShct9s/E
 yMgg==
X-Gm-Message-State: AOJu0YzFO/3O/3YwoAd4Rqb2XoRD0FtHN/ZGHErISo+QjdInUbrvUk23
 2xXvbLQgTMxf5t74KTp2obdIc04WHhSIqKTpT/SjdXySD5yySHVo7Xq/unPHUBVxFWWe+8IwXm8
 a2cHm
X-Gm-Gg: ASbGncvMM/c2dT6OnQ6+RubsmaAJBw7JNPwijLjWnRd9RN3DG2wN9ZBCbsia9pIGwMz
 FLKJ5vYM0m8awK3B9vO/aHqDhHHh+TzKkGZtYogAqfdIoHcdwo0Vr1Rc3XpgcA84Ukb17NFW15P
 jITLe+5gzZQTA3NHXJsyMQWhk62S5p3ypItMa2tcMDCoFA2de2w/Fwy/f/Vzlsu9LKidwGGjcCZ
 LKHmNWl4JUeF++g8sawminAnPRrRlUbaKl63NFJ5skgaLHkJAuVAdw0D4SHXq1cEn84j4LKvakE
 KI7iLjmUQOrEpyG6sdlCzeRHP0LXgflL/lFxzJCpnmdxek26TII2o0gco/rdKuX47K3l6ISDBMk
 XqSdEmzSPLGgzrlck27+WQ20k0bTKMxQTJQQu
X-Google-Smtp-Source: AGHT+IGiwJBzVQSvKxxxKmQZX9H0bxxesKSOyUa5G/F9z3wh3rsTEfCw3bdS0B5a8CHNa1ean5+gbw==
X-Received: by 2002:a05:6000:43d4:20b0:3a4:da0e:517a with SMTP id
 ffacd0b85a97d-3b3449df6fdmr6005f8f.23.1751482422440; 
 Wed, 02 Jul 2025 11:53:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e72c1sm16535120f8f.1.2025.07.02.11.53.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:53:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 01/65] system/runstate: Document
 qemu_add_vm_change_state_handler()
Date: Wed,  2 Jul 2025 20:52:23 +0200
Message-ID: <20250702185332.43650-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/runstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/system/runstate.h b/include/system/runstate.h
index fdd5c4a5172..b6e8d6beab7 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -14,6 +14,16 @@ void runstate_replay_enable(void);
 typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
 typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, RunState state);
 
+/**
+ * qemu_add_vm_change_state_handler:
+ * @cb: the callback to invoke
+ * @opaque: user data passed to the callback
+ *
+ * Register a callback function that is invoked when the vm starts or stops
+ * running.
+ *
+ * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
+ */
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque);
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
-- 
2.49.0


