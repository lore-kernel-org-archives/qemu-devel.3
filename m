Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E33CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 11:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqVGC-0006e5-BS; Mon, 25 Aug 2025 07:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqVGA-0006dt-J5
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:21:10 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqVG7-0004XX-BS
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:21:10 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-333f901b2d2so33229471fa.2
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 04:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756120863; x=1756725663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/wNKiUWQPQWrwtUVptPrKABFj3ih74SKl52sRfasgs=;
 b=ZBh4gyfPv3IwP8szDt0UA/+qPWS71xzce3fzyUcKw7RDhmRbbTwqa3m2tNNYRFoaku
 rOA+sSRSiov62c3KsKhVMo3NI/jhIJg9X2LiaVje1jxJs5nu8tHPhhgQZyPX8Orix4uG
 BVUk/N1wa1x7Q+hPA132OLGI42k9wc6Zunh3phH4VP57+6JAgfRY5cUMeKohF+/qWxFE
 eOTjID6ErbGbHk1vPjtMgRhyQ34lcLePmc5teSIsLqiDVAyD7/UpwwdrxVm/HOBvTS7C
 c9sJtBZv5hWFN2BwOhEWDy2aGZ1l/kpLfoN/JfRmjA5tK2s/mJMfhxFdG7SivkEmv8SG
 mAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756120863; x=1756725663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/wNKiUWQPQWrwtUVptPrKABFj3ih74SKl52sRfasgs=;
 b=V0b439BtAaWXP+vybDNmPNCwg5Rc9MTkhYeMnkWMqYH+3HIFX8jL2/BpVfC7uQSCpL
 JxGYlvwcgmXM1SYUrZmfE5ewOGOzqf3zhL0qmBbGeHiWHGZ+sOqFNQN2hD1Yh2vu+nSg
 F/RzsP/0NnLlu543/wTsgkI2j4jHj66SFuXb7QROOZ43jEMQGnHhQA+69y/UU0oI777Y
 kchhFmC6jWsKFe97afm10lld749t0LB7esnkwqdjfYEM0Yx44omqzcYznnSxCzrn7Mmw
 5ZnsVQi+TxPwCaQ9r/roxUd0wH+WEGQLyVOvo0MKgVPEmC17OJ/PIPCxynoy3XMhT9g3
 EAig==
X-Gm-Message-State: AOJu0YwNmvuV8HQhXUjmw/C7rTSfIz848wSUtFSePu8K02HzWFw/0kOB
 /r5d25JclbZYjBU9OJJ+BU2sGb0VUe99a63ghRu3MWbkqP45Qe23qRoCQ1jMS0B9
X-Gm-Gg: ASbGncuzTVqhG6jsc/+uupD4TYyW2uATDXNyi56yVSNaDyXz8Hoim9jRkUGH35/lI5V
 l/sq7l8d2F9LrXe6TcWjBHr/tFdjYRFvOJrfjL1vspNgHUBZLyayij1VkpGBskKWb2JuVZfw8bt
 aNIKDuOUEkOGLMCnBdFGPdKy8u5ZIcybdC/i8CeSA/MlrOUaLPLGC6DcW9MIb5/98hZVfzvhzE/
 Mtk71Yj6VQWw+TbMmV9dYJ6+vGsEYN1ZmNs3h6kQkiRacd4Flcma9nYh8SKENbSO268A5+0lRct
 Mr/6+cBjq2SbMTBebclZyhDw6mzrpXZPl8tlv0OI7LVeTK4GmrvmOVT06Fta9V/k047uuFmjLI9
 97nFfSTVWYu7MaVDG6fpANA2NAlbOgL2meHLodC5m3JslHEl+k0jiU0LL2Lbyj3d7Flo9hA==
X-Google-Smtp-Source: AGHT+IGWv1qPZyMlRZ8E7IYtvGKKYGPvGiL6vhw8UUpQlH3d88I+32XOxp+hKrLymcqXLxbptyNMzQ==
X-Received: by 2002:a05:651c:545:b0:32a:dcc7:f99e with SMTP id
 38308e7fff4ca-33650f63d93mr37808621fa.22.1756120863124; 
 Mon, 25 Aug 2025 04:21:03 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3365e07d4b7sm16007001fa.0.2025.08.25.04.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 04:21:01 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: richard.henderson@linaro.org,
	philmd@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v2 1/3] target/microblaze: Remove unused arg from check_divz()
Date: Mon, 25 Aug 2025 13:20:49 +0200
Message-ID: <20250825112051.4155931-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825112051.4155931-1-edgar.iglesias@gmail.com>
References: <20250825112051.4155931-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Remove unused arg from check_divz(). No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/op_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index b8365b3b1d..470526ee92 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -69,7 +69,7 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
     cpu_loop_exit(cs);
 }
 
-static bool check_divz(CPUMBState *env, uint32_t a, uint32_t b, uintptr_t ra)
+static bool check_divz(CPUMBState *env, uint32_t b, uintptr_t ra)
 {
     if (unlikely(b == 0)) {
         env->msr |= MSR_DZ;
@@ -89,7 +89,7 @@ static bool check_divz(CPUMBState *env, uint32_t a, uint32_t b, uintptr_t ra)
 
 uint32_t helper_divs(CPUMBState *env, uint32_t a, uint32_t b)
 {
-    if (!check_divz(env, a, b, GETPC())) {
+    if (!check_divz(env, b, GETPC())) {
         return 0;
     }
     return (int32_t)a / (int32_t)b;
@@ -97,7 +97,7 @@ uint32_t helper_divs(CPUMBState *env, uint32_t a, uint32_t b)
 
 uint32_t helper_divu(CPUMBState *env, uint32_t a, uint32_t b)
 {
-    if (!check_divz(env, a, b, GETPC())) {
+    if (!check_divz(env, b, GETPC())) {
         return 0;
     }
     return a / b;
-- 
2.43.0


