Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB9EE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswUu-0002hV-65; Thu, 19 Feb 2026 00:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUs-0002fd-QP
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:42 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUr-0001TE-6U
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:42 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-678b85b972dso212404eaf.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478560; x=1772083360;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0R9osrusvMqOtfeu461Tq5czaq6FMTAxple3ghg+3rU=;
 b=Fu4uZCC+0Mo4MdFGthmnpHTrfzSv3q/C7V8nLnUnBqrzAu7BiFF4YlexSzKeIDClEL
 SjTXAQsN82+IpF/nBQpDN5Gyo+XDx7r/O4QuMOSZ8SEQAKSXxL3qv2jl47+xmFyxQ89S
 93E0R6uOArTf0IQ92ueqPPsvMPi7/np9JsRduyYqckpY+tpQOc4Pru8KRxSJdyhTjjZg
 Gf26VrFPt+Dd9P1gJ879UFgsQbFiDmYFt5NnsRYcSHm6roBur1OXNY+9AA7jT3r0RTe+
 sU9tEsDKymKPj7Vcap25wFnWU1cSJi/xVL2kybecEooJNcyvbVdL7fe7Tn9ReZqKejlb
 T5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478560; x=1772083360;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0R9osrusvMqOtfeu461Tq5czaq6FMTAxple3ghg+3rU=;
 b=Y0M+SbPnWODOAdaUULFA13+3Qe5C+/E4pvmqdr7y7dSxJ7I7WGkrmdNZ/rsp59jj/L
 wb5nHMsCScZV1c36bximi+flyYTcgotnBuect1gRSLLHFZHe5WVBaoluKVmEqTG+s2kd
 PQL6vtfbBXT7ocJfqxXz4MM+fC8ETlj/SC1l+SvshEJStXgZpaZDZQW6/Ma9AKqa3FH0
 lrVMlsxC4cV0tNro6KmE9+YmwWI+ElNmYvqzqDtNrYz/EIbUPRM5brl57J2hBpM66vYY
 PxJ2QS5qfmKxBA7BJniWWHufuUP85fAPaJvtp4vdjrOemoKkIS6gFjVxjTYLIpM5Jv4P
 U3Cw==
X-Gm-Message-State: AOJu0YxdlP4NOQHKyFUb/uA+fYyCOm67zL9otIysBaOWu6GhxfoSamQ3
 YfZh6Bay3PmMeRamSb6WMpJY7O6ZeRjHYWp++7hNlnh3YK2zi6IkoJOIMTtn4yp0wq4=
X-Gm-Gg: AZuq6aK+UvBCINMno/hzCVjZVsBPC3aF9OQcBuLBEeqYp18AC3N8Uk3drLtgbmTLaAg
 2OK4cSrZZaGxUDSQQvCAyL6OW07wVn5Nge+MYmB+71I5AwM+7JggCAnbXuiBMaCsbfU1b/UX0Jo
 DZMmo7BYbn/JmlkJOr+axV1TtjjPfnceGurdMw2vLeq9rjSMO9/dZCZuWobRrSkRbLeUNYUhayO
 gMuZVPPYiiU2+0ZskEv8aqS4lHiHGY8t7MQo+xiaA/yUCvTLVf1F1U9jA2AKq/npvK+Kr9HmeyE
 iQezEngTmfWIbKHzM6wQ9nBNZt/085EHaH6tYWd5wXHPTqtLw2tgzI1Jt0mJmQcJSSQjhpDP0X4
 /8bbEqq1GvtAJ98S2HEgPAA9SY/hOB9C1h6T70myg6shwUu0pgvO3YhwJL2Y+RYIaOyuLc/kv+9
 yfH01ax42Bcw==
X-Received: by 2002:a05:6820:1c94:b0:662:b703:c63a with SMTP id
 006d021491bc7-67858fe7efemr8426335eaf.7.1771478559883; 
 Wed, 18 Feb 2026 21:22:39 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:39 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:27 -0700
Subject: [PATCH v3 04/24] bsd-user: Add target_uuid structure for uuidgen
 syscall
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-4-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=7q8w7XEaRecIKFdkMtineBuFnLZB0KTZoHDJ/HelWDA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4rmmi+4q/f7HIu8vvIBXYpUVT8vDvS5tuSK
 bSOLOU6ciiJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeKwAKCRBsHNEofbAR
 ADCSD/9+vH6031CtFcgyFBWCuQ7Z0GZxCI+MrCpMPMZBJuN49gEDuWAtijrKdvK5RBNsMHz1La9
 PBCAPsSG+Lxx2Xc0bXv+ekNP8cELZ7yGsTsisY+tE4BXBoTRjgbWh/ru1EgSu2TB+gpJSz6ijTN
 jEusieH17ppLZOniV8b1GEMVx9ZhBIFklCGYTSwlm4o7axgDpGy6yQsaTwOwwgcJwaunbP2kslR
 IfnMm1MQJXC7zfEU0+BZ88Cf21bAmul///WoxB92b8SXbNXmo0QJt37G3cBPBi1KaDT4yi0pNVp
 24ifeZuGfP8pSdvm2CgzQNBtITTGrknuzGXaiHiO/T8/UODUIp8xuwZXVnM7Zl2+ZRlmJRe0j0s
 +jDfSVeyzci5owhjAKUE4WMc+zywDAMd5unmVe8PZYiHn+7vqmyIQ6dyGtjtXNRP64vhaGrGqq5
 /3mRF7gIaXgnXSk0thwZApoNhSQYmAau2jm96Fxkzq/f8VuENrpWuytk9uIgSXQhWj5LIaZz7aV
 h2Ytr2EkCQWkP2f8Gtfk0iJa3+jCkwZ48VA2bq41Xm6UKYAUsMiNt8P4a3t80FdRJ2C6qONQEL4
 kYxficCMAzZMwkUgKIaGjfg3VtlKv50t/Z6rBvrWTbsP+cbpZPX5m5MFXNRsPLWoqoThFpdCE0h
 Y83nE/KhILLAaKw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add the target ABI definition for struct uuid, needed for uuidgen(2)
syscall emulation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 92fec12acd..972bcc425e 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -503,6 +503,20 @@ struct target_procctl_reaper_kill {
     uint32_t rk_pad0[15];
 };
 
+/*
+ * sys/uuid.h
+ */
+#define TARGET_UUID_NODE_LEN    6
+
+struct target_uuid {
+    uint32_t    time_low;
+    uint16_t    time_mid;
+    uint16_t    time_hi_and_version;
+    uint8_t     clock_seq_hi_and_reserved;
+    uint8_t     clock_seq_low;
+    uint8_t     node[TARGET_UUID_NODE_LEN];
+};
+
 
 #define safe_syscall0(type, name) \
 type safe_##name(void) \

-- 
2.52.0


