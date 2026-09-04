Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4331DC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Qwm-0001lv-DP; Fri, 04 Sep 2026 06:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1x2Qwi-0001lH-R8
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:14:58 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1x2Qwh-0000GL-Ik
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:14:56 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6b1bcd9e00bso598863eaf.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 03:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788516894; cv=none;
 d=google.com; s=arc-20260327;
 b=BwTqpkJjWeeeg5pkRCPwKPnohKmzLTPMpuAYbjP7LL1n7n9CaEI0iNKlSqJnGAduP7
 Bv0UCsobLt2ct0X2F5OhXph1AapN6EOgQscyoasolpVoFUt7KR26IfK6U/BUnN8J6eR2
 YpWcUKh6mscGM1Yrj61F9Ct4yIUtIiPFsSmVI/d/9TzLe905tABOgkLVrFt8RZUFeKEu
 JW2mR3dCgCO45XWc3E1I68BAK/wEXE7wnkN+LGlIX1cuKmBGD2p7/DOBSK9wscHEGxMD
 cBykZZo3tOkkIynswjaM0+zzSI2eA5LMmwatHw0N9VL7Yo+zmaQIb0vdl9RdXZj14aHs
 1QUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vcopo0+o9sRHwQEzwQ/Ixtcnp0CYp97tTFcMfvsEbCA=;
 fh=yGWAaXXYYQtYW+LCE7nyqmcq5QIuKbScqyYf4NVD8c4=;
 b=btY6LMV6fO6sX4vlsiTBsReRSUKRd+q2ycwg8LFWfZwPocy/INGZHNnj1otEkbuL1O
 XzYAtpwYUknMaf3UWBUuAZunu7X7DOsgeUDruKXY92RCxpaL4vjYAUZRuHSaiYoTgvuZ
 VCJ2+/qhzhACARl4Fzr/3IWGFshWgT21kfgSAkx/UnL/08CrY7oyNXoP7PAZcB3Lcaa/
 zVQ0u/n3Kfgk5Z8cBnLZE3dwbkI2+91DR+RxN/TrID99as8siMMSk0HCaYqmkzjnBa+a
 fEvrqiLrzoQNEiyrM3KmcbXr2VbOd/M93jgI6ymuClNHRx/Z8fV6m1uBS3ZAidhfJQ+X
 43MQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788516894; x=1789121694; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Vcopo0+o9sRHwQEzwQ/Ixtcnp0CYp97tTFcMfvsEbCA=;
 b=YNb+Z8zL4M9cjbpr4vsRcE6Lmc+PgxUk+ar7ucS6THbjsE5SD9x5BUycbuZutV5n8N
 F+ACdoY4mIEIhBWafi72IP6tf6CU9hqh5o5mvVYIDpY7rRjush9i0xrmjAHHYe+r4doG
 EtXIxzenxLyAcgod66nfVQIX5UtrR+ArThSVD/YvFC+u87Bd4mxQegwbnYNGE3bEFbpO
 mN9gCPPUVd+ap28T3qJ8arxsID+4CE+qhXFXqFhAL5HulvbC1CWCl3bZGIMFx2rBFnMN
 1ZjLe6vjDixj9IxuE17vGKwViaILp0h4PNtYjemHM3G8VTVzBkGH6gDAwTuWqYSng1dy
 kfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788516894; x=1789121694;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Vcopo0+o9sRHwQEzwQ/Ixtcnp0CYp97tTFcMfvsEbCA=;
 b=pSriwjD5OtbgFCIsS5CYitW6nMHmPk+dO/KCwaA+RxRIU2jTHs4m5KtzcuUslVzdv5
 pvyd5COjMktTAbZ1tJ7WqOhScm+x/wnM3osc2HH2WrEZytLB1QyWt2+WASMTuQ2FbhRx
 X3TG2BJhhQ6TLWRGz0EvLj9TsK3ox4xcsz71onJE7bBg8jcH70UdNS7zj+c7cQZG3srY
 4gKQl5dp4KLR/pI3W7LMf6nclTaPTYCVyCjw4mfukSCn2NXxGM7EGA35tTZrKuDpvw2d
 Fkt7zGD+xnLgn9AyiXDLVPR3ziZaejJrxYaY80CbaNq1PQLqoscP1O2bHXiRpybAdtxq
 B9nw==
X-Gm-Message-State: AFuF++nOg4wQ3ZPCveO1wWfVMXtfql70ZnNNqmIxZhLADeprtuN/k+vm
 LOXEx/hZ5dgdh1ob2jg8rG3UUG0LypP+s7xzCbjOnAz8AcMf5biD0qXYJ7f5LivVKO0O56regys
 Ki/2AmH0M5URy1WwAVZTT4AI8CdzAt1f8Cc6Lo4o=
X-Gm-Gg: AYBFou3zgr/f87rVFt1G7kvq6geFgSKfse1nFBq0hCyEdX6yV6vaYtkGneknxkTKcbT
 7MmtrvEnyZd3pz89DqiuzBjYGQFxc73+/saDmYGy2m6BaT8h845lghaZeyPoBH5+rmo5327sa/L
 LWbX2KtAb6OBV1uQKjpv/m5UzRMCBHai9GUKtIU06IigfbpbnasrwoI8yauINsydRHnROyZrrza
 qN201T1AZtxY32Jitk7LF9UoRE6AfQVh34BtCH3HIm6VXwsJdw9intbtMcSs9ASsx8Nijqr+r3V
 VTtWSxdk7FoRNERcHUNTRwMEfG/ZhD4/a7XTAABptUXQhZqQ0sXYG2+xl13d32/lG4/n6H1Lapz
 A
X-Received: by 2002:a05:6820:82a:b0:6b1:4cfe:ea6 with SMTP id
 006d021491bc7-6b6fd1ca1b8mr3716649eaf.32.1788516894017; Fri, 04 Sep 2026
 03:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260818145837.550059-1-apolivodaa433@gmail.com>
In-Reply-To: <20260818145837.550059-1-apolivodaa433@gmail.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Fri, 4 Sep 2026 20:14:42 +1000
X-Gm-Features: AcwNN1V2Z_fXg3ZcsNKu99yZSOXf7IEMVFvhFdhiMTrIqq9In5F9_ZWbeUXqUTk
Message-ID: <CAGscdFtxdLVkw5OvycvqvnncT6wPfhOd5ptyDHSjA1zLpJNj-g@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Mark MOVNTI as not valid with prefixes 0x66, 
 0xF2, 0xF3
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=apolivodaa433@gmail.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, PYZOR_CHECK=1.392,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

ping
https://lore.kernel.org/qemu-devel/20260818145837.550059-1-apolivodaa433@gmail.com/T/

