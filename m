Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F75BCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 07:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyeV-0001do-SQ; Mon, 01 Sep 2025 03:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usyeS-0001cs-E6
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:08:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usyeO-0007pV-5c
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:08:28 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3cdc54cabb1so1613336f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 00:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756710501; x=1757315301; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ih8uTqWscBRx2OoRWvU0eyBD1Y+8aNV1KRoVMepk1w4=;
 b=pEaZOPCtIRUfT1wQV982XnrFARcYrR49Cq8qW7Z6YgC1wmb++owXfF70X9GNvrD2BG
 1FsAi79/uWF+hpcZuw+zBnAte9w9rsiQEHIMVQXEDHb/RUA+ZiNBBmGkB1vU376W/gTc
 OYpIYXVwf0dFy5bvdy+cO7xskIzc0PSw3q9PRzktQ9BVNzLrJJqxTC88TBHHIaxg6QkN
 FKahwxtohmNBFF9hakgV1mS11h59XkY6/RiQjttL8UUbziocYlb9ctrJjR64RvFCjsQE
 yOgXW2M59x0/MDiypGvDns6XLiVuDLMMlUWoQIHrUDYUajZs9qRMBd9d27Mn0M38rdbj
 RsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756710501; x=1757315301;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ih8uTqWscBRx2OoRWvU0eyBD1Y+8aNV1KRoVMepk1w4=;
 b=Zv50xBfdi+vpeu+LxInRqPR0WsIALEX6uohKG0Bd/B2qGuXXQ+hMcPNntNRYMSlSTG
 i9hNx60fxJLLywJbf2ZQNMe02Kckpw8b0BGgRDcMbNJEyhilYSTfRlLQhjlP76C17kV5
 xI3fZA10YwIrj33rV/WhLx0k5+hfq6cApRQamdPqewpOPY6rRQVmsXFtCMDNiYo7dkkA
 MwHNu/Df4PrEsW1xtwdOP445vElng17Digh1xaptfoYYbpi7VR6yn2i+J2Cmk/N49XI3
 QjN6APKURt84wTdzzUG+mrvsuZXiS52yNK26NSBZS7tH54Eqr2acTxIHtdw1F9u9LGKu
 QxPA==
X-Gm-Message-State: AOJu0YwooxF1dTe3EnBa7zywJvD9L9jnxhyZrQytbOA7i7n+1aVT72/A
 bA55BupoO8RiJaUZWuPlRhf7pjBphmFFU5ema2qe71CvsnaVqTJIkFDCs23Riz3GSQa/UHUzllW
 DzBCe
X-Gm-Gg: ASbGncsZtKgwkm8+DKyyVbP84wLJIZ918tZa92nCQVF1qqvFTUx4iSJIX6xnqYmbSAn
 q2PG+Zq8hJjFDxPa5AuwJqSEqYTryMgZRHywLC73fCofZwHlP6qjFmckIXNgzGDN7z6shy8tBlc
 KOzd7gbW16G744fLVIaZSFQE4pxrQQLgq/AB7KUF14Ej1/mFPFAFqQqFKTKrkkXT6T2OGGxPs70
 57pyIrTosLGIshDdKnFKHR/1ovLJ12OEdBPhbieTbykJmbZjy35C+gIya+C5qaq0HvwaTqg8KCn
 toy4eEqOj7vrzLS7OIn0uKZX2hLwb0dRzeJ5DkKe8FPvCbATJTfy8J1W5fCQSkNt+nUSKfezl81
 QQlmEzNqNyS2upP4wLD3H6fKU7yXMxDP6XQxC3rI8f9ILRviBlewxQYV5tKjepq0Trz416BU0
X-Google-Smtp-Source: AGHT+IHFE+xmPrv5+Hq/4QZhXw+5LAQYAn/8JAFDpEy4b0A+JddD71JyYQH4bxGhzd+Sr6vVSeFM2g==
X-Received: by 2002:a5d:5d86:0:b0:3d7:2284:b06 with SMTP id
 ffacd0b85a97d-3d722841157mr1304881f8f.24.1756710501025; 
 Mon, 01 Sep 2025 00:08:21 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fc3fasm13819030f8f.5.2025.09.01.00.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 00:08:20 -0700 (PDT)
Date: Mon, 01 Sep 2025 10:05:22 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 43/61] target/arm: Add read_raw_cp_reg128,
 write_raw_cp_reg128
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-48-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-48-richard.henderson@linaro.org>
Message-ID: <t1wehv.qggqnsgrk7ur@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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

On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>Add the functions and update raw_accessors_invalid to match.
>Add assertions for !ARM_CP_128BIT in read_raw_cp_reg and
>write_raw_cp_reg.
>
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/cpregs.h |  1 +
> target/arm/helper.c | 43 +++++++++++++++++++++++++++++++++++++++----
> 2 files changed, 40 insertions(+), 4 deletions(-)
>
>diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
>index 0d8c45b60c..bd26a4a260 100644
>--- a/target/arm/cpregs.h
>+++ b/target/arm/cpregs.h
>@@ -1097,6 +1097,7 @@ static inline bool cp_access_ok(int current_el,
> 
> /* Raw read of a coprocessor register (as needed for migration, etc) */
> uint64_t read_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri);
>+Int128 read_raw_cp_reg128(CPUARMState *env, const ARMCPRegInfo *ri);
> 
> /*
>  * Return true if the cp register encoding is in the "feature ID space" as
>diff --git a/target/arm/helper.c b/target/arm/helper.c
>index 7568b78c49..3efc14da3a 100644
>--- a/target/arm/helper.c
>+++ b/target/arm/helper.c
>@@ -115,6 +115,7 @@ static void *raw_ptr(CPUARMState *env, const ARMCPRegInfo *ri)
> 
> uint64_t read_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri)
> {
>+    assert(!(ri->type & ARM_CP_128BIT));
>     /* Raw read of a coprocessor register (as needed for migration, etc). */
>     if (ri->type & ARM_CP_CONST) {
>         return ri->resetvalue;
>@@ -130,6 +131,7 @@ uint64_t read_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri)
> static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
>                              uint64_t v)
> {
>+    assert(!(ri->type & ARM_CP_128BIT));
>     /*
>      * Raw write of a coprocessor register (as needed for migration, etc).
>      * Note that constant registers are treated as write-ignored; the
>@@ -147,6 +149,32 @@ static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
>     }
> }
> 
>+Int128 read_raw_cp_reg128(CPUARMState *env, const ARMCPRegInfo *ri)
>+{
>+    assert(ri->type & ARM_CP_128BIT);
>+    if (ri->raw_read128fn) {
>+        return ri->raw_read128fn(env, ri);
>+    } else if (ri->read128fn) {
>+        return ri->read128fn(env, ri);
>+    } else {
>+        return raw_read128(env, ri);
>+    }
>+}
>+
>+__attribute__((unused))
>+static void write_raw_cp_reg128(CPUARMState *env, const ARMCPRegInfo *ri,
>+                                Int128 v)
>+{
>+    assert(ri->type & ARM_CP_128BIT);
>+    if (ri->raw_write128fn) {
>+        ri->raw_write128fn(env, ri, v);
>+    } else if (ri->write128fn) {
>+        ri->write128fn(env, ri, v);
>+    } else {
>+        raw_write128(env, ri, v);
>+    }
>+}
>+
> static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
> {
>    /*
>@@ -161,12 +189,19 @@ static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
>     * The tests here line up with the conditions in read/write_raw_cp_reg()
>     * and assertions in raw_read()/raw_write().
>     */
>-    if ((ri->type & ARM_CP_CONST) ||
>-        ri->fieldoffset ||
>-        ((ri->raw_writefn || ri->writefn) && (ri->raw_readfn || ri->readfn))) {
>+    if (ri->type & ARM_CP_CONST) {
>+        return ri->type & ARM_CP_128BIT;
>+    }
>+    if (ri->fieldoffset) {
>         return false;
>     }
>-    return true;
>+    if (ri->type & ARM_CP_128BIT) {
>+        return !((ri->raw_write128fn || ri->write128fn) &&
>+                 (ri->raw_read128fn || ri->read128fn));
>+    } else {
>+        return !((ri->raw_writefn || ri->writefn) &&
>+                 (ri->raw_readfn || ri->readfn));
>+    }
> }
> 
> bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
>-- 
>2.43.0
>
>

