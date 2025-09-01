Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF37CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 07:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyaI-0007dq-Tb; Mon, 01 Sep 2025 03:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usya6-0007cb-A9
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:04:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usya1-0006Vv-RH
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:03:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b84367affso16364345e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 00:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756710226; x=1757315026; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o+3rlOKdIUKXFEwmKIoxnv0gIFKp7w/edm8Fp83tHwY=;
 b=mwge1U3TcTpGYYHAORnlSuiizCNsS3GdMjqxOzqyrunV2XdOZhp6xmQJnHIDqaKD7O
 oypbRrIIO08E/etiU7t0gDNPSMUs3rk2E6osz/bkZaqtTByKI9ORuUS83cN1noQ+CueG
 BIbgveBkbcyokocJt0cH4ZLKPBm3VbyM0lyuecknVwkRKL8qRzFSiCJezlZCeJUdKqL6
 ZTgD7Vi92QEMaXrHYu1tAPzo1UJh+BuufvSSNOYtpczntFdi8PdIKCzo+j28+p6X3bNo
 hdZT/Zu9u0ZuxmJousck9ogltXcilXsaKa8Tj6EX8BJeQ9jJle4hPX/YZJzPaID+/mFE
 cszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756710226; x=1757315026;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+3rlOKdIUKXFEwmKIoxnv0gIFKp7w/edm8Fp83tHwY=;
 b=JNW0bvh4dKRzgBHSyhgkWd9oo8UC3b80tzIOwuZJ6QijeLCUuUx3Bq0P1Z86qFOcRJ
 cigqx2VWvMYPxtsuTIRgsVVdoEwua4u7ca6IOnhl70XTooxWi3sSF+ZEt1o7Yuk1lHtH
 clwwxmiwkFjpX8XpdLlZqZQcOE3aHGYOTa1umxlDEquK4PBgjaVH9B8flKwrjx0Jhuco
 Snj11lLIstM7I7aNIHsaSP8bCG53LTtC0TAWzThypAvcUC5zITRTqFv286OJTDbf8/Ct
 b6DQD1/tdNVP5oUYditr/E/kvbVHYMEgpaLh2sVJwgeM8NolUx+9llzNQC2JuLro4Nng
 5P2w==
X-Gm-Message-State: AOJu0YxfW2x91leVy3v6iXCyAZ/HHhB0nw7zfEw4E1n+mvn+Dc4AvtFv
 /Zj1vFWxieqnemFr+hugtqW+XjyjxPKICG1dUuJN5mg7+di58iwHo1ZWN+fBABkoOZDADsIu60y
 XwktK
X-Gm-Gg: ASbGncuN+GnP0/JwDvHm1HTcvLpcozi2Gc575OQn+JyGZqGUpIKO4vd0QZ1fo5e4TSH
 ytYLzdz9v9I+asZAkkeimw6olJKxPuK2g8SoGMYy3Qw5tcPZiWB1ZFMHyL8rKokkdtNiKqjaK4e
 aKjZu0fE9hHBXBBOrdHRA1a7xFpprO7bkCNqCc7Zie1/1vJvmqml1OxYoHcVejsKN+O7jvRMrIL
 HykZnvVWJnkFcRbgv9ndswElR3BLtBinqpnH8nTIqwvBvrwfALiFVKbyECLcI8XptrrskPEI/0J
 f/j/0fPUuTCWIE88nxKUb0JgKRAvUY6KB745IGs0GKMTw0tOZcpw94yVdOpj9hv11BCQ+H6G4MN
 68w8KsTlju4EHlyJhbZOPlvumTi3yx7/87u7hxkXiqzmrqBQkGDVEN1+/62SHWWm5MFHIBSAZ19
 e2nWhKX0A=
X-Google-Smtp-Source: AGHT+IH03lXsnblJAdg3HJxvtv39ibpVUtE1e9UrVzHWQ2z2c20E0XrVmAVIohqpGOt1S1OtjXdh/g==
X-Received: by 2002:a05:600c:1f85:b0:45b:5f99:191c with SMTP id
 5b1f17b1804b1-45b8555ca8dmr51847655e9.12.1756710225755; 
 Mon, 01 Sep 2025 00:03:45 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm10210045e9.19.2025.09.01.00.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 00:03:45 -0700 (PDT)
Date: Mon, 01 Sep 2025 10:02:25 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 42/61] target/arm: Add raw_read128, raw_write128
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-47-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-47-richard.henderson@linaro.org>
Message-ID: <t1wea8.1rkhpind9mj9o@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
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

On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/cpregs.h |  5 +++++
> target/arm/helper.c | 17 +++++++++++++++++
> 2 files changed, 22 insertions(+)
>
>diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
>index 90f14dbb18..0d8c45b60c 100644
>--- a/target/arm/cpregs.h
>+++ b/target/arm/cpregs.h
>@@ -21,6 +21,7 @@
> #ifndef TARGET_ARM_CPREGS_H
> #define TARGET_ARM_CPREGS_H
> 
>+#include "qemu/int128.h"
> #include "hw/registerfields.h"
> #include "exec/memop.h"
> #include "target/arm/kvm-consts.h"
>@@ -1065,6 +1066,10 @@ uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri);
> /* CPWriteFn that just writes the value to ri->fieldoffset */
> void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value);
> 
>+/* Likewise for 128-bit fields. */
>+Int128 raw_read128(CPUARMState *env, const ARMCPRegInfo *opaque);
>+void raw_write128(CPUARMState *env, const ARMCPRegInfo *opaque, Int128 value);
>+
> /*
>  * CPResetFn that does nothing, for use if no reset is required even
>  * if fieldoffset is non zero.
>diff --git a/target/arm/helper.c b/target/arm/helper.c
>index 18af67742d..7568b78c49 100644
>--- a/target/arm/helper.c
>+++ b/target/arm/helper.c
>@@ -59,6 +59,8 @@ int compare_u64(const void *a, const void *b)
>     (*(uint32_t *)((char *)(env) + (ri)->fieldoffset))
> #define CPREG_FIELD64(env, ri) \
>     (*(uint64_t *)((char *)(env) + (ri)->fieldoffset))
>+#define CPREG_FIELD128(env, ri) \
>+    (*(Int128 *)((char *)(env) + (ri)->fieldoffset))
> 
> uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri)
> {
>@@ -88,8 +90,23 @@ void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>     }
> }
> 
>+Int128 raw_read128(CPUARMState *env, const ARMCPRegInfo *ri)
>+{
>+    assert(ri->type & ARM_CP_128BIT);
>+    assert(ri->fieldoffset);
>+    return CPREG_FIELD128(env, ri);
>+}
>+
>+void raw_write128(CPUARMState *env, const ARMCPRegInfo *ri, Int128 value)
>+{
>+    assert(ri->type & ARM_CP_128BIT);
>+    assert(ri->fieldoffset);
>+    CPREG_FIELD128(env, ri) = value;
>+}
>+
> #undef CPREG_FIELD32
> #undef CPREG_FIELD64
>+#undef CPREG_FIELD128
> 
> static void *raw_ptr(CPUARMState *env, const ARMCPRegInfo *ri)
> {
>-- 
>2.43.0
>
>

