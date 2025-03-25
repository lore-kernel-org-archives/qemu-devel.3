Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BB5C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txCzY-0000bM-CG; Tue, 25 Mar 2025 18:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txCzW-0000ag-Kw
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:26 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txCzV-0006v0-4j
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:26 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39127512371so4138193f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942603; x=1743547403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYc6dMHLoDeNtKrCf+LG0joQxNLfS1rrchv/hf06HXc=;
 b=nj0qulVevYq+b6YzJpT1+8WYjH/zIqJlUiKOpWIUKYcY67lsfXuVQnPE5HgiTTM28n
 xL0mPzcEa8XrR6IrTCKpVWPWCXxzcdqVVfHIT443aJ5VQvyloLT7UeJMkGBakhkdQZy3
 9XXaJjSPHS2jlBaDMRymziW6Yoo+y/RyqB6yYOe567iYEDl6GCxuxRusXOlB62nqft58
 YBuPh1RT/Db0HG8XdZHHeRhwXL7X6LKPYV6dM4edqeLuqhgXEcs168rpY+x76J9aFq/V
 wWeP+6nbWhYv9WbUt+hTkSjsGr8nnwKHss5g3avCE1lWnzpRtIHO4npcYwN+yKb1SSjr
 dvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942603; x=1743547403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYc6dMHLoDeNtKrCf+LG0joQxNLfS1rrchv/hf06HXc=;
 b=nS6A/7Tyyg8/pSWBJOep1yh8gNJ0sCr469+T5oxElh+Ty+CABEa+kM7H7YRkgoFtr0
 pkJiKOt48MXi8ojevVnEVebeNtFFOeDcMYaaNM8c6YBquPn6CtSlFwsSimYikRAUHbWy
 8X2dq4v4Wyq3WUAqpJrddT6MRRCNrFSkqrzu5VI8KjU+r8OJ8j/3kY/V2x/2rXJdpYuK
 imoIsLALMS2xrn6eCAxJoD7/UydnAV60tj2++/7XgLFK1tlM50QMGqwAdpupr3seUeUn
 Ld58QrpDXQZzAsWUhmQ4MWbdtlFE/qzt95fMLTQTcoT9P85q9C9lBT2V9yT0Tnu6y8sz
 JJRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn/Vtlgu2zSwtUdhr4McdllLLrFIJE+1phMqYOevDVV9RkEFjoKbncWGUKXFRA2DBD+KXykQaZ9I9R@nongnu.org
X-Gm-Message-State: AOJu0Ywa8CLDFuwgl2v+3ksXmv5loL4e1Q+JEay7hPSMTcLVtxUvFBTY
 E0/Fbgb5Y8UzFUOCsFWghD5LDT9Y+pdxKw1+0JftqOJjwlcR0e+c5rHy1UG+c6Y=
X-Gm-Gg: ASbGncsDV0Rrl24yt3aglx5zs+I4Ia5xwX4PKFCvAQ+lxr0ijlDyvBc5jLoLIAqsFgF
 KV+o8QQblt47S5ZyEANTNOhfOQavPTDJGtPWXfeAtn34G+STc97A2nZD8ZWpjA1G0f+By+FIWlV
 w8NqRDOF94jSpCYzIcsu/0m/87r6yyRf0MDqOxeIvwvSsf/Xff13/HbzLrZvV0lq/bbWGLGlvCZ
 T+kLDQhBzDAwFkDJSWoFXSkM1YMLx+xG7r/78XWpe4TX/xqr62yhY1rzhNXKLCkMokcLoWBKC0V
 qZERAJsOKnRFz/HeBpLEaGC2PIGZIqfhamS25ujDeDhvSv3ypJRZ+CvmrW8qBgsSsJbapKFGs+h
 a5RF37p4SpFvEJdGvUoU=
X-Google-Smtp-Source: AGHT+IHbWP2NpLXngbCuea+R9kz0i2z8NoiPhWa6Yi42iOs8SNBqD0IPdP6EbjFlajk1W60GizPPYQ==
X-Received: by 2002:a5d:59ab:0:b0:391:3fd2:610f with SMTP id
 ffacd0b85a97d-3997f8fea42mr17215939f8f.13.1742942603446; 
 Tue, 25 Mar 2025 15:43:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d74b48b90sm15360315e9.14.2025.03.25.15.43.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 15:43:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 02/12] hw/block/m25p80: Categorize and add description
Date: Tue, 25 Mar 2025 23:43:00 +0100
Message-ID: <20250325224310.8785-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325224310.8785-1-philmd@linaro.org>
References: <20250325224310.8785-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/block/m25p80.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index b84c6afb327..0887c103e4f 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1870,7 +1870,9 @@ static void m25p80_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_m25p80;
     device_class_set_props(dc, m25p80_properties);
     device_class_set_legacy_reset(dc, m25p80_reset);
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     mc->pi = data;
+    dc->desc = "Serial Flash";
 }
 
 static const TypeInfo m25p80_info = {
-- 
2.47.1


