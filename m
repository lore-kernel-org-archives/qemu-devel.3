Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063FAC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNoC-0005U8-Bm; Thu, 03 Jul 2025 13:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoB-0005Ty-14
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:15 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNo7-0007rq-Iy
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:14 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso25213f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751563986; x=1752168786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThHRepOjVOPYIURDCNeQdikGEVpKaGb//EjFvlftJxg=;
 b=M6hku2GWwGT7EyvdP/u5bWuY2zTOkG8H/QodQjqNOLTq+ky+iQrzwrn1rAHanTF7/v
 svIgpDPBKfFrp9fGX7QmPx+bbdDnErMWVqj07rHE4N4boxc15rU+LfKnUdJANKXHoGbm
 JV5cBqNFpQvCFCVwJKYeak+XrNVVKsSu0U9SwYt0pVlGW3C85cPujNqBGCPpTAnkyNp4
 LhHTy32VsmWqENvFSg3Jvf00NDbPzFpM6MVw07C6os0SbZ2UYvFHuRGjCgT91iDQgMC1
 GZnAdyirgVU/BxNuYvbaO/3fxK+6yl85Fw6zX5e0DK02gvu3TpK2VLastLa1gnb524rr
 5Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751563986; x=1752168786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThHRepOjVOPYIURDCNeQdikGEVpKaGb//EjFvlftJxg=;
 b=RebolDGD66gAdj9ZU3HYOpsW43LzBBHshGXWnG8H8yUgb/wPL5fTPN1hPki2SSKeXb
 iDmtJ9TbirLjlRfX5Rh9V39Xdc8mxTA0+2t1fzZDrSjIo8pfRubve84ATkTQce6fGVfR
 8s4PKMTZ8QIK7ekGU16sfAsqpqULJkbJiM9aWh8epCrFa8A5QJBjHPcv6X37MxVuReK3
 g3U5bD851BkuETps9wlLZZC/Kv81jI7TBkIvpYQpQEbB625dezVt6wJYH1U+ILIFWqR4
 OeUDfY2vD8BJ8+49D3/88ul4sWh0aP+03HUM8UhkkfAIwDS2Z7y3Pp9J26Z/QYTljL5y
 uftg==
X-Gm-Message-State: AOJu0YwwU88SSggfzH9IgL6b4XKuLOatOqzgBn7aH1/LDWpDsNqJq4+c
 NYJe2Jl8D0QakBt1FauSMr2ZJAaw6kB6KOD47NLiY292U7huAI6ugTbA2iedUTcU+ziCKhOXJ4l
 rCWh4+4o=
X-Gm-Gg: ASbGnct7kSuk5w66i9OwCi+NNDxj3C1sP4DA+Nc6e5qcpBnsc+JWv6iG9X0s9nEtEsx
 8FWTAfRKkB1j8qWZkeE1pm6sYTFIhvH67mgYSrK11IlaRHsWaZsx+y0tq/WD1mGhDWnYiZtL0Sk
 cSL2ovDRZ3ucsd1uDV/Qn66GvbtBsNnJO/mSl/aQViIzMtwHr20NRwpYcSuChdTN/1KmZy/L7++
 Fy/LnJRvOTZopGqMZRzGDhJcWz5WPmBiVLIzwutIrZH2JShjVsCXAw2MOp18nZCkd0B2W+kGqj+
 xsakLkOKYjebPnwBgaiFgRt+ydMJf8oOBxV/EizQB1l9F8rbv8+q8bfv+Y+LgBq7fXjPXLuV1nm
 jCra8SI/TdyHm+8FIquAXpp03Dg3wbJd76vPptwQqmOb3IDw=
X-Google-Smtp-Source: AGHT+IH6KOAtvl8q6DlatJDHasb9EU1TBbGw8lJ1wPPJqkjkx9wRjZ16SeGeECqWtsbjqISs7d7OFw==
X-Received: by 2002:a05:6000:188f:b0:3a5:85cb:e9f3 with SMTP id
 ffacd0b85a97d-3b1fd74c288mr6377571f8f.12.1751563985878; 
 Thu, 03 Jul 2025 10:33:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453a85b3e2bsm45499325e9.0.2025.07.03.10.33.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:33:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 03/39] system/runstate: Document
 qemu_add_vm_change_state_handler()
Date: Thu,  3 Jul 2025 19:32:09 +0200
Message-ID: <20250703173248.44995-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


