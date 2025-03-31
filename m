Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0A9C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL9D-0003xY-Ug; Mon, 31 Mar 2025 15:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8u-000344-GJ
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8s-0003T4-L5
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so33830995e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450593; x=1744055393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=edC8SjUvZyJ+hQNsoUTkUYXPs+9FX/UDXWtKI6uhvY4=;
 b=Djqi1TsivdxIMmtYpRgz1Y7fwkqC6be5WKaPAaV4MvmxeDiPY/VUkkBtth1ysQDDXV
 Gp5CtBMkmTlgX/+pqDPLh0lI+6mnmwlbdGBy+I5L+IJ1vKkYBSlEbC5qmvfzOxx4CNFT
 A8bjuwkE85+XRSSJY4ZuTuMTCEUSZ32I5l2t3aEUmWWooQ600/HAPLHPVmKOLjpEXeKQ
 QCMhxTG+nyS+2BSuRIgHmRdzS76nOW+3TXa3rnF6RtCHiBwkMZhSJJvhU+kHvH69DfJK
 WekcuzSva8EEgnHV2VpXNOaUk5jEU7O3+e9oSMLW/cwJFko6N7fGnp6xxzbGXyvi6vym
 cDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450593; x=1744055393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edC8SjUvZyJ+hQNsoUTkUYXPs+9FX/UDXWtKI6uhvY4=;
 b=DGmuL47CyaascDtocsfGyNFexXYKTccA13L2a0bOd9wxk0SQQluMNJZ7wcvUWUOy5g
 6Ln5t8BP0fDh1HnEaWKl7ZUCD4y8sndZiUM6CQlYYduatc2aQpEKbxIz1oyS5lCVfbVH
 tmvrA/Axw3XCg1fM+M3qAw82CJVAHLljD9Mgd9OadDHGaz1N23SlRfuy8cPCpSVPvvNh
 lMOutLCNEo3ZANkaDQ9GEuARZ0EIrljwqAE+mGPVO+pR6MvqZvnFWxQoTeWb01cCltnd
 ODRYdp/oLEGMjVuoliOd5SXb/WUiokWFPBfhV3NezMVbCYcKpEUYFQbwhjqpRo+oRi2K
 +0NA==
X-Gm-Message-State: AOJu0YxG7iwh0FSOFxvB/t8eA99V2V1M/VqP9V6W2MfXrDQby60avuZZ
 rMNiu8JaMzTSSzayTiF0N8aFRXg5X02kGMtfjulH4NOXx9cuBNPlgxLsQ0ttMBhh8yqmk5DzZqr
 H
X-Gm-Gg: ASbGncu5qQ2rkv/qw6jQTacL4yzJsYggl8y8xOEJRD7KCJi5wcSTJwUJJWccjg31riI
 E1mdc4vP6CafzSXZpnYIE+wvKuhD6aIKsT4RA9a5ljz9LmZzw62cMgyFj3YA5/f0faxeF/oG3Gp
 nAmeytlveFR6gn1H0Crq3fryWFhDOuYkz9kujRqabvIpqXAI81guUfZcyp0FKJebje7+x/vUu2i
 laCZL7vsgXc+IvBFS0+z5fcRiasP8KnRFKsjjOejLQ+idp6bmQ7FrFgFb62fgo74cmfcqBLAHgO
 2ZqDBadFywID0En0btfXYW8/tlXubVDPskjGWNohInlU3xP7CNSYAPfSEM9EFRybWyYW4+U5WrU
 ygjj9d0WqfjeYsvyeto0=
X-Google-Smtp-Source: AGHT+IFEnhJS+2GTTiioocUzdKhb0TfqoE459dDnBlJOa8n5vx6sByDBYOs4E2HnbNkV+x/qFgSUZA==
X-Received: by 2002:a05:600c:511a:b0:43d:683:8caa with SMTP id
 5b1f17b1804b1-43db61ff43fmr102786595e9.15.1743450592739; 
 Mon, 31 Mar 2025 12:49:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm12269140f8f.10.2025.03.31.12.49.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:49:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/23] target/hppa: Remove duplicated CPU_RESOLVING_TYPE
 definition
Date: Mon, 31 Mar 2025 21:48:16 +0200
Message-ID: <20250331194822.77309-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The CPU_RESOLVING_TYPE definition was added in commit
0dacec874fa ("cpu: add CPU_RESOLVING_TYPE macro"), but
then added again in commit d3ae32d4d20. Remove the
duplication.

Fixes: d3ae32d4d20 ("target/hppa: Implement cpu_list")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250321184200.4329-1-philmd@linaro.org>
---
 target/hppa/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7be4a1d3800..8b36642b591 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -391,6 +391,4 @@ void hppa_cpu_alarm_timer(void *);
 #endif
 G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra);
 
-#define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
-
 #endif /* HPPA_CPU_H */
-- 
2.47.1


