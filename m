Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192ECC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJOQ-0006XB-0n; Tue, 06 May 2025 10:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJON-0006WV-Ci
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:31 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOL-00012n-P5
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:31 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso4202958f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542128; x=1747146928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ko9NrQnF0SFd6dLTc0vMfxfU32MTZU1FDAMfmJHWSSA=;
 b=kyQZeT0yEh58+/y4f8ab8nnUmQFZp1wFOCrNuNHVVOlTbVBpVdNhHGehPw0MS2R51D
 vSBCVXsaGtLLJT0GRZd+hc4+gV6zanJt1DM1PZZY4rBWZ0C1vRSTABmwY4DhJkThOqw3
 7xYDNyoAgLwucEV5oM4CGe6NVEsLqvgXNvA26JzhIbANj3atptuqdkgWMCPrd8M5r/pQ
 Js0Z2ltJ4pBKJNufUHcjZ2X+F7ypjLzybfgnrUp8AA+DTbE+ybefnV7iECx0CDF7pT7K
 cQu97IugLVvPTiLrbROkJwuHwtQgz5Uyhwi2gHmA47GPQuxo6pQE5iGOYKxW0wm0DYeW
 c4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542128; x=1747146928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ko9NrQnF0SFd6dLTc0vMfxfU32MTZU1FDAMfmJHWSSA=;
 b=W4xoQVNcMXnA5CO1vEK+kijZBnxk8h0zhd8X5b8+Xb3MgxXQO76BqiW7LgwIsJ21/q
 XH9NwqJ3H+j39kmMSi5B08/L4QStjS/nL6q0vInM5q2dJ/oRFke3wQZhPiB0Zxrd5jja
 3YVJxgPBdBi+uKjPysCcthRTkCCL+JaJ8tat2zoh6b0eSGUtMEQA/rG7gUTR6Re5kXHA
 W1CFedbx9I1+g5OBtMxvDqZyTOlaT5VFIjpCUnZOB0HlCu83Dfe3bv5q5IEkY9sQEwxY
 Wems0fl79W5FZlacMavsRvdSSzycRUlPHZlLbTrMv8p7L9EJQhsBM2MHRLQp2Ha2A8Ao
 91Pw==
X-Gm-Message-State: AOJu0Yy0JhisK6HAnYK/UKwJ2g6eLBBJcphiwy8O1V/QVhENX62afv1v
 It9uHFY1Ho7z9XhkZlwKlt6IgWuTjA+L6mjOa7W8BiWYarY88PSw2IEIbSGKWeSVpthpdcjqD0E
 h
X-Gm-Gg: ASbGncsbuzgPyyU75ilpgyoSzaCJEShP928Xj7l/A5fk/aO3VcbaQPDnBuOro3Ub2vo
 L2KHY7OZmRdvNPXI4X+nIp/xQ0L+zjXmFozmTD8gOTVcMgmTM1eNt8OGb2KwNdBwi1c5w105GBp
 4q4vnBR4noELtT3hFB4egV+kjeNEabXeuYlS/fTVDA9NsWef/4B4caDklejEHAFZvZ3yRXG8D1j
 HMEnuK2Q0D2rYMQTYJli+S8QLGEc4qDth2LtkY9cv93/uZDe8ODLo+WlBBusSqXasQN7oUDSrpw
 Nu5FBj0Y+wPz+3WhkOyuSHZ+UCa9larm/HGd8NH4w2SkRxi2/mEFpQSoWEN0krD4hRhC1LSTXy+
 kyw99zGuGZS4vNYAqRc+0
X-Google-Smtp-Source: AGHT+IEA5pwXBKqHkKJLH9INhOqmWtkMf2jhnxzq5ph0VEt1k+m2qBKVUQCJM4MWvUTwVKc9LKNXmg==
X-Received: by 2002:a05:6000:2204:b0:3a0:7c91:4aaf with SMTP id
 ffacd0b85a97d-3a0ab5b10ecmr3175700f8f.19.1746542127776; 
 Tue, 06 May 2025 07:35:27 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89d150fsm170630755e9.15.2025.05.06.07.35.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:35:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/22] qom/object: Fix typo in comment
Date: Tue,  6 May 2025 16:34:52 +0200
Message-ID: <20250506143512.4315-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Fix duplicate preposition in comment.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250504215639.54860-5-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qom/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 664f0f24ae8..7b013f40a0c 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -485,7 +485,7 @@ bool object_apply_global_props(Object *obj, const GPtrArray *props,
  * Slot 0: accelerator's global property defaults
  * Slot 1: machine's global property defaults
  * Slot 2: global properties from legacy command line option
- * Each is a GPtrArray of of GlobalProperty.
+ * Each is a GPtrArray of GlobalProperty.
  * Applied in order, later entries override earlier ones.
  */
 static GPtrArray *object_compat_props[3];
-- 
2.47.1


