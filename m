Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2489AFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABVJ-0006xU-Hk; Tue, 07 Apr 2026 14:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wABTh-0003JO-C9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:45 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wA4u1-0000Lp-Pg
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 07:47:31 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6501d32b04bso5253410d50.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 04:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775562448; cv=none;
 d=google.com; s=arc-20240605;
 b=kiS3W1TGltZUw7dfvTnNX7zQTL2Dnk0qKZV8iS9jsnPREO3sC2Q0/acokzIVFe4UrJ
 eWZBW2TkD+JZPXVQ71fJyVRQz3ImJ+S8WEhgKZDZ2P2PBwTT05lkh46ydYS0e85vl8nk
 1NWeNk21qac9ZdrBrUOmT2efQQbfQpUfW2BFNDgBDIF8y+wQ2OGH9jPALLomRr41MKDi
 fphjcs4vVzrIfx5EArSNv/AU7IkDWs4z5FA9VoTt0A88oic6z6lsC2rxyv02pPXTmOEa
 RJvE1RpJjfv7azGwk6UpBtt0vseRYPzvmWTvpq6viHkYOekNNiuCrXAMS504jB3QFpkp
 iM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YA/IjXKbtftLtGGdnliZ4f26x908xHKp64DpGoEvv9w=;
 fh=dfq9Nlv9apZ0mqoRhpll2oVGgP/uIHNwai9G20DqlwM=;
 b=bpR6arkNgJ8cnnuEE5aa3Ini3OctUNTrQdUdgtvxXMgUUfBmQL+2ndRxfiwwc2cc8r
 SwVZ5XYaAVRmhuOaNQv+wPZuRMVC/dVnZ9gGPPHEUxgpp/YPEjeN+Uo3HrpNj1WJgtYB
 uKWBRYl6bI8cK+3wKV4nluv7gQ3V8o9iRTh8m92ojA2QMcY4coqpd4zcFFnQig6P8Hi1
 ZZBAjLSaBcUV5tZFPMm87g3HHhJdn7lY1yYzRUID1YCpiaQuIu3jHWGvh36CGBnYoyKL
 MgSo2Q/wPHTu0zd1aqtMZTGDfba6wa5/6vFchvtPB8+b0cpWZO19vlPBg2/5hYDtgpgx
 swgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775562448; x=1776167248; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YA/IjXKbtftLtGGdnliZ4f26x908xHKp64DpGoEvv9w=;
 b=djsMJ1LVbz9gmiiaRuBsLYa+D5rg0Dj9v85HJRWtHn9GijFIoGeM2nOphRYFtAeSek
 s3mw5VAOJB8OWDlczaBrskVfFCuSw8i2W9Lvf5r7hS6/d0vi8TyHYwVe3xNKLzwApvQy
 /ijzmxcI0M6VfkpQ/LvTxMu1AnorGInlW9Ij/QDBM/lvq7t25rzPj+Adr1oQdf746A/h
 aw2jEV72L92R0b95iAxkG4NbXC+FRnQfwbOiLvTIxWHWwXVyLyKTn8989rIv6Worc9SQ
 bt92OuYtVCQDzrVJObcqOxEzMs+F07tSiXKIiUNXtTANaDWT6IZafsLQapoVtVy9kWu1
 xxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775562448; x=1776167248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YA/IjXKbtftLtGGdnliZ4f26x908xHKp64DpGoEvv9w=;
 b=qZ4QPHv80jnD0zFSQEZ5pAJEKOrw9tLnk4CllK9az+lQQSXPH1B3NXPggbACBiVzaq
 yjhNHVdayVgv3dS5hr+F4i73+PutkFGWgqR9ABWzS6pSXX26NeSF2dpbSJXMvldSEyD3
 ZprE7T8avxuWyUPmT2nxZCbdg8ztVoE9GQv/6nd935pjEuXrk9Rjzjl0TsR6pYa3raId
 K7M4dcr4zm5kLErs+zjtdzBc9q1nDf/a/q3wMsfv8JGleDSO4v0oYgAle5IZhAfcl4rI
 znoBzqAd0j02xiWQT535ry/b7wfYq3LViSJuxFTVO7DzqKzKod+mJzp6HebybhaDiZ45
 cKRA==
X-Gm-Message-State: AOJu0Yy+JG4KwElMJrL/FHMsjzrFQKr/fGoeQqPN/5/ytCOE2x82dVfr
 eaOfqS5F3xk7sco0oCY0OhlVlzOE196zSkk3JT9eAAneE/7ZXxlQmbRULNv5bHVyQQVgI9zX3OL
 Pwo8mRGgP01gfwF/LgB9pgjCsqzEOfZ9WyaG5u9GjtQ==
X-Gm-Gg: AeBDietFtLZ9N1A+AXvWGTQso+EygE/Qs2dTiCRkQ2vyQXH5bNA2llAxGIaDjnpbm+X
 RsA3yf2nIBwoYOelJ1+cPSGvvrliAw6PcE9yN7prjTztjxnBA4ZD2T7Odo624DhTNVgpkXSadoA
 6QZmh6m5gKSa5WKtkGDZiobmgc/WeMkjSU6W4Oukbi89YVIJqctURWFYjsVgX/QNYkWh8mJJVp+
 +y6c0+ntfrFhMrI7wdacEb7eMJFNUXU6ikrsC1PsYPpw/Skq3nD3ARKZ6V7BsxEHEDDMJ4U53xq
 xVvvs0wdrWMd76kkwJAM6oeLKrp/nJR/YLJpSOSfdpv/qQkGzCaECr7qnwLxYl+xrHGFW/40661
 G5w==
X-Received: by 2002:a05:690e:148d:b0:649:b943:2ca9 with SMTP id
 956f58d0204a3-650487c0cfcmr15851318d50.33.1775562447937; Tue, 07 Apr 2026
 04:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260405112410.603223-1-alex.bennee@linaro.org>
In-Reply-To: <20260405112410.603223-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2026 12:47:15 +0100
X-Gm-Features: AQROBzAVcKcR5pZuhVa87CGx7iDK0yX6ZxPvZOGFBbLaE0qyC9ebipBSgzTDV1U
Message-ID: <CAFEAcA8+wurZTEAs0YzN-uDkmXKur5AD9wLWY5R0tTLRdu6Cfg@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: fix fault_s1ns for stage 2 faults
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Sun, 5 Apr 2026 at 12:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The computation of s1ns was simply wrong. For Stage 2 faults, it
> should indicate whether the faulting IPA is in the Non-Secure IPA
> space. Correct the logic to check for ARMSS_NonSecure and drop the
> extraneous s2_mmu_idx test. The actual writing of HPFAR_EL2.NS is
> already gated by arm_is_secure_below_el3(env).
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2568
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This seems worth Cc: stable.

This is correct code-wise but we also need to update some
comments elsewhere. I'm going to squash this in:

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 8ec2750847..9684506592 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -740,7 +740,10 @@ typedef enum ARMGPCF {
  * @paddr_space: physical address space that caused a fault for gpc
  * @stage2: True if we faulted at stage 2
  * @s1ptw: True if we faulted at stage 2 while doing a stage 1 page-table =
walk
- * @s1ns: True if we faulted on a non-secure IPA while in secure state
+ * @s1ns: True if we faulted on a non-secure IPA. Note that (unlike the
+ * HPFAR_EL2.NS bit) this is set for any stage 2 fault for an NS IPA, so
+ * code must check that this is for a fault taken to Secure EL2 before
+ * propagating s1ns to HPFAR_EL2.NS.
  * @ea: True if we should set the EA (external abort type) bit in syndrome
  */
 typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index bbbfc34f6c..7b993bb5b3 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -613,7 +613,10 @@ static bool fault_s1ns(ARMSecuritySpace space,
ARMMMUIdx s2_mmu_idx)
     /*
      * For stage 2 faults, S1NS indicates whether the faulting IPA is
      * in the Non-Secure (true) or Secure (false) IPA space. For all
-     * other kinds of fault, it is false.
+     * other kinds of fault, it is false. Note that we do not
+     * distinguish "s2 fault on NS IPA taken to Secure EL2" from
+     * "s2 fault on NS IPA taken to NS EL2 or Realm EL2" here, but
+     * instead do that when setting HPFAR_EL2.NS.
      */
     return space =3D=3D ARMSS_NonSecure && regime_is_stage2(s2_mmu_idx);
 }

thanks
-- PMM

