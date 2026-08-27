Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D668C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaxq-0004gu-12; Thu, 27 Aug 2026 10:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzaxo-0004gI-9s
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:20:20 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzaxl-00082c-EZ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:20:20 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c252ff776efso166470666b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787840414; cv=none;
 d=google.com; s=arc-20260327;
 b=nLTCN2os0MMxYxf5YcOlIzOipwjjhSf3ar/6yCAuy2fKNUG7HqZthQ7a+2FMExh1/h
 y3bfWk4ksG1Htud8h3mHQYGEFid6vte8b8T5BPglirZpNzc4U2GBxG051jHd3aRShzTD
 jCOUQTqae2IRaXhDz5CEKLEqXw6ld4jhXiiPvfgiLmY6ugB3ck2l8VcaHjt2Mw7ni5KP
 eTpc9IFTWl/BMG71vTZPwqc4AM+apUY84com5Ud+Zyf2N5OLYVrPsSnYDnEeiDL8NwK0
 csq/d+VM98Bmi5bRt3i1ATfbkXe0w21tMtcmbG7FSLCqFzCNGvQZmHuAXk7O7cbxKmAJ
 o1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jo5QvHdCL1a8NnANUDEcncw8+Elfzj8WFiScGEWgQFk=;
 fh=HHJG3smXVTWhMM7DRA3kmgmaBHQdX+R9lSKkkokQYMs=;
 b=oTaEPs0yPdNxG1Z2yXnJO5gQM2bVrYL97nnl0rGqMim/wYBzmOBMLdipT3WryS8aOu
 Q/HuWIzekoyygiCZTr+zMbIWS7YVh8qTuUZNd13tuBy2nSMzE5q3RNxyeLC/mG1MJ/d5
 9JHLpsz46htPo+GXyMxAPjNDsJesTzRplFolml9gAisZI1JZiubZaZibMjJVfb2miRMB
 9sC7DdrX18P31XdzW7JkyIHlhZUZZ/ApryXzuWv2q2kg+G6VxMkXQem3O+NS1hEzqbkK
 f872/tTM1xRnz8gVYtygiiQYR0EILy85x2NAuV0HaF92IGdB3lk/nr+6P5/h7nbxbQUi
 gQgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787840414; x=1788445214; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jo5QvHdCL1a8NnANUDEcncw8+Elfzj8WFiScGEWgQFk=;
 b=jpQBGpvpj4b+AKiooW9OXIadCoezKEK4zweuBLeox2Fq/tPnZ5cPJcdbYjyYhau+1p
 tohMYsYr6M0pWv7FODuN7oo5eYXTI9hcCyZFiSw/GHh6gDfqlWN2BkI080u3X9pL5o1J
 0hU0vpAUYNNdWSyp+KQWRLbuTvb6NIRSModREtPK1scVcXIlgHMMn9rga0dXwqYoH4H6
 MpJGVF63sfj+4uP5au1VGFayqb1NPwzzZKN9Qk+CPmdCxHd60W5dE+6c+c9oaHgiXA4Z
 /UI4/yGxphMaSzP1wf6W72NDxZOkPdGUnd8WLz4SXJ+o5Hastke31kzDrrJpago7UUdF
 I4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840414; x=1788445214;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jo5QvHdCL1a8NnANUDEcncw8+Elfzj8WFiScGEWgQFk=;
 b=CRqrnoNvep17Fg2MNogMC1XXFgtXq3ZqkcDufVu6RAdVVRbNPbADHIHDRo5ThvOnA0
 YJx5Q7zF7llVquT9v27kkLDKUWsXhept2+Qs3SYchLxouV8EZXBkUl4P3DIH7WwSwsHK
 WG1ohVwXcvTPMLkoyryqhFdObb+Rg71yO2H+0mk7OEsO+Yk7ebCiBEv3RJBpTAhOLl2J
 e8FqMzQYw+RdvGSby7q39Kny8+rzgONgrG0IiPMVFX+VdN0qlsEzWHLhlTHOrwYWQBWq
 tpX4WagL3LBw48WsZFQKSskBnAUOw9v0BzqlvUnJhnsHCFLSbN+wVzoTuBnk/CViHWVF
 xMkA==
X-Gm-Message-State: AFuF++mxuAt8GgIw8woMpuXRzR8gXJajjeQ0DL0Ho9dHX1ieKxvtnawm
 0MNK5v7WVLMQcJ/lwDCoPbZdUqhWtwbwNehsLGvf272uhlTZCqZfJHssSkvYmfiPcFtGY2YBD3r
 uUvDIk0SixCgDkTzW6UydQbO4dfxx5jxxQ4YsCrhx3Q==
X-Gm-Gg: AR+sD11CXQ6P1kE2slSA1rubITGeWLXZV1TmDKGar+QHNLMRlVLvBFA/+oI2KGw+pAU
 7Fxa25L7Mho2HpJP84TVwice6FUSG2tAmk4plC4w7pdcDh5TzaDkhrmo/qVo4o4MDDIeMpIk0rH
 RFkBzocOXDg92vBzEzTiSrod2EJIcs+EENhbw5OsU5MKxFDmWsV5M/GPyAx6gnb+2fMKOiiRRQf
 OsF5dJfLQuQ/dnyGAoiGoFDQHEN28uXyv32W/f0FdzvdSh4JE1rUrGHeoT8mgkO0XqpyDlwm9Pj
 XafPSRurZ3gM2LSMBEpyNF7cc8d/ityM1J0r77iCN+K9Hh1XJTXLa4oE175WpPxHK5hvETAZohm
 I9n88cfbubhX2vy4ezEaM3eYQer9g
X-Received: by 2002:a17:907:3ea8:b0:c25:35cd:fdb2 with SMTP id
 a640c23a62f3a-c253602a2bfmr582938666b.7.1787840413382; Thu, 27 Aug 2026
 07:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260821213536.433273-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260821213536.433273-1-pierrick.bouvier@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 15:20:00 +0100
X-Gm-Features: AcwNN1W-CDmOnrz8puj-d53M2XjGvXbnyFRB6QxQbp8bjPZiwY25hBg7XfbY3IE
Message-ID: <CAFEAcA-gqJb-1k3viJng4V3uKFs+j4L5-_x=6Cgz_GP4crpzPA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/tcg/cpu32: make compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Fri, 21 Aug 2026 at 22:35, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> We just need to remove TARGET_AARCH64. Simply expose all the code and
> conditionnally register types.
> This fixes single-binary with arm + aarch64 targets.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

RTH has proposed an alternative in
https://patchew.org/QEMU/20260827041557.775080-1-richard.henderson@linaro.org/20260827041557.775080-3-richard.henderson@linaro.org/
 -- are you OK with that approach instead, or do you prefer this patch?

thanks
-- PMM

