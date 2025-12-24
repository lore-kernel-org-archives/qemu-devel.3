Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5965CE7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQi4-00017N-NJ; Wed, 24 Dec 2025 10:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQhp-0000nG-SF
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:23:22 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQhn-0004fy-Ru
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:23:17 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b7636c96b9aso1068835166b.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589794; x=1767194594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+LBKH6mpM3QJZ+LjMWVH1Zu0cPNjKfwSazzmUt2kNQ=;
 b=DNWPD7idFlGek8f7I9B3L15SDSVcJDMTniWqSey03mU/fhI+SWf9AeXjK27eWLQTiP
 9hYstKGQKt3dF6EVhfpdL3blyQfJRsfypi47gT2o91m3dbQPOGGre3Q5Ak7jAhKemok2
 BMIieY3wVWzdhAP78uieLneyJhzAkubSrGyemRFiVKxSuPBf3i6BeAX5Y2/bzw8n/The
 EGk2+FQwgQsrutiztQSZJx7qW3Pjo07SffegmUqve10kVU4L42n0aHVO1SAjRboUQz6q
 839cnvQ/REDp6kjbZBELh3jpnmyDWiiv62zNAMYkuBisovMWnxhJwZ6+DkhvlxsVHYV9
 ddAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589794; x=1767194594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U+LBKH6mpM3QJZ+LjMWVH1Zu0cPNjKfwSazzmUt2kNQ=;
 b=C0w/KhFfG82YddeDoHoRRYjv882d5w/iKB6J4x/Y4Ity2mPv35HxrHKeYidk/L1WiW
 upOIeHwPjOPps+c7eR8FSHqYrMehKR9PbP11aDyTfZqh129cPcn3AUBgVD9zwIdNGmHU
 ihfuTQXT42OugcytF5FOIdS8ph1sutE0yBbiBpldR2NhdR/CqEzVCjr7tF1p6jxgDvoI
 P96+/Xi2l9uiKWJTGJ1+HDsCJ9IaRIlcKHcl7VujS0p8gtOgnTMb/ukLyr5eCHkuOhGO
 sRtoCuFoZkSGybH+tPbmeFgmQkFgkh5YcsTNcOhLDP/8NLCH54IWQgy80GnGbAvLtV8N
 bpnQ==
X-Gm-Message-State: AOJu0YwdALoj1hMzh64aOp2zqNAiLh46w3kuv0/UPrOVMXdUMkN4L8zF
 rCX8yWtyZ41ACtQXUXl+SzWXR94haTBt91h9yzmjz/VDShQxSVGiRDBWnBz3v0EAzC3U7UmiK/V
 d1DisMs8=
X-Gm-Gg: AY/fxX6UgHds8HSOZy99f/QQAjvwsi+AE+6em304vfjwiCqOuNkhbu+BRCbNsveEykk
 zEOyXkXn25SaVCkeRer7UeKBQx+JsXY5yTspmVperu3GAldtEYNjLe3QouHofmUGsJKAy7JZrfy
 5KY+vP5100NwUmnOmJc9ocOgFT2YWon67B0CRPEvsOKihNp4mkwd+VlYSSDbqo5ku2r3l5r4+ka
 kquCcn3LF863JVobm+nCQgWRrArZxR6QfQoOdhcMQKR8anfhl4O4YW6x87J8YJoW2R+JeTLq9xf
 cc9qkHS2aTRG9LUZyfWmyk7CSxd1qq1uau/G8IrBkac7SRXz9qJU2eqVKPRqLhHip88ixooKfn4
 cs14zgXhWnzsVRwsWOB9dBMBoznZX+i5aVZcb8PZlSbjoshK1TsT6NQCP4cc4K2NPQzq/l9bgol
 7seGM8/ayGxtsfOQIfIBvOCHU2x7HkE8aMeiZg17psELiFQPTSiSxqyMsaltUw
X-Google-Smtp-Source: AGHT+IER9qDMge+R9LicmrUcgrJ1Lid1gEk94rX0A6fw0cJSU3LVrO23WghTKJRQcWA34vS5/U+wrA==
X-Received: by 2002:a17:907:1c17:b0:b76:da45:e3d6 with SMTP id
 a640c23a62f3a-b8036f60c66mr1862916066b.16.1766589794059; 
 Wed, 24 Dec 2025 07:23:14 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a614b7sm1809241266b.1.2025.12.24.07.23.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:23:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 06/25] system/memory: Inline address_space_stq_internal()
Date: Wed, 24 Dec 2025 16:21:49 +0100
Message-ID: <20251224152210.87880-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

As its name suggests, address_space_stq_internal() is an
internal method which can be inlined like all the other
ones in this file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/memory_ldst.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index b45bfecd137..d5776678edf 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -422,7 +422,7 @@ void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
                                DEVICE_BIG_ENDIAN);
 }
 
-static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
+static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs,
     MemTxResult *result, enum device_endian endian)
 {
-- 
2.52.0


