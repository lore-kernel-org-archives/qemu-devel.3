Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4135C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZvRV-0001R3-QF; Thu, 10 Jul 2025 13:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZujq-0008Nj-Do
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:07:19 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZujo-0008OP-1l
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:07:13 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so853491f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752167230; x=1752772030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gTuvH1dt5vpBYw5uT/toR3K2zUXQ7OTXLoFMjuOST4=;
 b=QUT1QRIMp061Eso2qa+m0djUGnIWfKPob7Z6iosA7k83fN7pAsTnA5zMEynJvkjgxB
 3tnndHpaoGE5wRtz3DBWInlCe57hfqHSFCelqFgbMrLa2Agi9V6CFxljntAcx/NUfKI/
 JPDZ3HFKmwW9sdBkpYs5yPVlSKlTu2NCvrtYhYIHXNqPjqX4AD+z1nU66ZN6c/ixtEBm
 PPGhpHCBW3plPBlmzz6i4HZ1GFxszaiHYd6FxemOjFW58PxL5iT/zkYVumJQdrsUglhy
 WdDvP1DMvd9ZLCKJO/e+lkhRxXWVcUUl5cfNeCUViNfV6rOuEetY1wXJB5CsU61bZikf
 9oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752167230; x=1752772030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gTuvH1dt5vpBYw5uT/toR3K2zUXQ7OTXLoFMjuOST4=;
 b=AqsejmcXTfYC5ko+izlCbEqLzL75k8kqpEgNwlfiwPZgF4PG9OCb2TLJeeFA4iTVXr
 poZxhGMrnCdexrkCQ/LTYAGx5AKOpsyOmwbofwYoiMOffaYPMR13npwM+BfH5BZ5/wV9
 3icCdnIoZmALzE/HyHFW/RaAjPleXp3Jd769rxI4qoJgguaGAH0ceNKU3O3NdHHidzjF
 ixVOA0olzFhd/5kZSSxOv1yiVZpHATIfZ6ELNpB+sshSDIKmrzAT8n6SEEO6LSVQxDXZ
 x4siFhYrLqbvs2S20Ea80rplq7scbepDB3oqcdw319beyVobAqRM6vfx7o9wlZR0jooU
 Qaxw==
X-Gm-Message-State: AOJu0YxvipPtgbMyhEqRKty7CMI9dVojwCglhQmLw2h0PznOEHzpvAQf
 plVfdS1Z38sGGKi64QFPWx4lwPc3yzPl6GOEG/tvPg+Ae9p+0NgAbdmO4RQgcWHOIPlS/Ph8RZK
 zD7TE
X-Gm-Gg: ASbGncuZeebGf6XxwUo3sCvxnGsLa1h6GTYk5yCOlDOzMpjRvlpba8Rmaz6z6BqFlfX
 9QsG4RD7c77eg5y9ApyeESYlyCs9wAZAiS8AuoaI4uRG4IkDzK2aAAJEN0tFpk0xHdt6F7h97VW
 DvbN8eEs9CzzWZuDN3sPgAWe5OvDBf+43lTLQdUO3djvK7fuJVtQ0xGMrGhHvRMYEvV1YHWmNUI
 S/inG6Qm4YrNshKE61I9/WEEODOzpnEJppc7UBDgowEcTE6/J6a4Ia3gvTNH6ensODjaNiohirz
 kx8y75gfNY/TDsHcymtsKpSY+Y0cSX/evsH0K7soLM2kQM8v9N6Dix0SCR/sME2I1QKH
X-Google-Smtp-Source: AGHT+IH6UQ5qQtIJGBJZPC8SnI3AhfDJVChHtKFMUtTt2+KON0SsmZ+Xlnbcchh+SuiF2fk9ze+EjQ==
X-Received: by 2002:a05:6000:4b1d:b0:3b4:9b82:d432 with SMTP id
 ffacd0b85a97d-3b5f17f8329mr410354f8f.0.1752167230420; 
 Thu, 10 Jul 2025 10:07:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1924sm2392681f8f.16.2025.07.10.10.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 10:07:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/2] linux-user/gen-vdso: Handle fseek() failure
Date: Thu, 10 Jul 2025 18:07:06 +0100
Message-ID: <20250710170707.1299926-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710170707.1299926-1-peter.maydell@linaro.org>
References: <20250710170707.1299926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Coverity points out that we don't check for fseek() failure in gen-vdso.c,
and so we might pass -1 to malloc(). Add the error checking.

(This is a standalone executable that doesn't link against glib, so
we can't do the easy thing and use g_file_get_contents().)

Coverity: CID 1523742
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/gen-vdso.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/linux-user/gen-vdso.c b/linux-user/gen-vdso.c
index fce9d5cbc3c..1c406d1b10f 100644
--- a/linux-user/gen-vdso.c
+++ b/linux-user/gen-vdso.c
@@ -113,9 +113,16 @@ int main(int argc, char **argv)
      * We expect the vdso to be small, on the order of one page,
      * therefore we do not expect a partial read.
      */
-    fseek(inf, 0, SEEK_END);
+    if (fseek(inf, 0, SEEK_END) < 0) {
+        goto perror_inf;
+    }
     total_len = ftell(inf);
-    fseek(inf, 0, SEEK_SET);
+    if (total_len < 0) {
+        goto perror_inf;
+    }
+    if (fseek(inf, 0, SEEK_SET) < 0) {
+        goto perror_inf;
+    }
 
     buf = malloc(total_len);
     if (buf == NULL) {
-- 
2.43.0


