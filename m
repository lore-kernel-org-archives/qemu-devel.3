Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB118C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSww-0001I0-FK; Thu, 27 Aug 2026 01:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSwt-0001Ha-UD
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:46:52 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSws-0005PB-GL
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:46:51 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so2172524b3a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787809609; cv=none;
 d=google.com; s=arc-20260327;
 b=LaVeBC5yUfe2VI/hb2fgfJVh0+SWQHdZvNhU/6aMU4XXA0dLOB2czgUgzd4PBWcUgw
 ZZIm9aCsHtenEfE2scsmMR0UYON9t/+PSCnf6EyNs5C0lunAspuGCa4XWKNf67vbTpju
 wYMyZ4wz/xW5Mmk7HeszPhlXnafRUkmIozOdLPalgfs6BoDcN7ExT4nzC7ZgLWih0mh7
 N53xPTkU3YxpY3n/0RsSj16VCq49DQJsuWF86WQznjAkkHHl3VohCOgPt4PxmurPrVd8
 /L9nH34arzhIloWNQWYWYgDUPPNmCnqh33+pv7mLng2aaDnFveM0yLuC6BgalL2p/YfM
 INmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1dOySquZnaRcu2Tc4GwfYHtKNDq9HC6ufjQdTdUApGI=;
 fh=Per2Qv/4GGtpnoasDFXjOSn0I4kYI1g5zM44b59yZOQ=;
 b=So8GYWCpuVY8nim/+Ycr7PfrdVUERHeiiSEgM0tpErIbso3V+ysAXiO3Xdlu8Avjii
 mgYp2hIuSkILgtyOho0S4BxR3gmYFtO7UmH+bz3YAt2G8fnMTp26BmCtnTe1LF3ZyQsE
 waWmIxfucROhadI98E08iTh/UNMcmsG5EQLWBv2l20EJjAi8XmhH4gkNxi6+va+C+R8p
 DmuwFmTzGxYED3Na4jkil3YSBx+jPzZDkrubIAvhKYDUwSPA2qsWMhRVvoQm+Ce7znyP
 FWaHXjU58bvtJ7sGxz2EC4uCDIyvNLhnhdQlAX2aKkZbp5kI//4gT1V938Iq5IPZXWeg
 Q6AQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1787809609; x=1788414409; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1dOySquZnaRcu2Tc4GwfYHtKNDq9HC6ufjQdTdUApGI=;
 b=QDACbv3SCRqdTpKmfvcTLCFju0qPwKEje8RrRIqaxOQd+Xb92KnMNxbOh5BrrBvs8c
 VOSKOKg68PY/42uJ+/KEVRyHRJHR3UMngkLnGO0+OJ+vwsMohfhZkNGblcJIC3VKWcdm
 W4gY2xj2gUFNR2B7hW00A2b/lARXO5Q/p3uZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787809609; x=1788414409;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1dOySquZnaRcu2Tc4GwfYHtKNDq9HC6ufjQdTdUApGI=;
 b=C3xxN2QrFxKUr9ZMk/rEslRxy02sH1xXktKB8+UVXGSBQ1KtEHjCtH0+vqyLCT967y
 tfLw6bWCxe24PlLPo3E7RYVtAOSsTDhjf49OwD2N4CCukfmcFRdZLsXKmeZ5CK9otw3S
 KtGAgHzBEGTuEg2ctIMuMZ7i68fWkNSgfq0LcprvHmxF7uPnmf4+nMp8fz4NU0SJmr0h
 HsLdIwOxiQwmzoPLzUfhRwGwRtBnPvyEfosD6fz2kXqoclIg5UKM1eYVogak56nH35xg
 XOJPWYr2qkrUhdqt42VuDsgvdBGcNXPmHeLNTZVb7LMdrlTiXb+oN5uiXywT3S069hbg
 UFOg==
X-Gm-Message-State: AFuF++kgoLmpMmZvpwO4PDUbmDa44w5SqrFUXtfw2cac3GWSU8g3sCb/
 LeKHDZbmFp+Astd0v8fcMR4W+libohSpLF0Gi+K+RVhlyc8xdF60k1/Uuba3F0O4f6Lmr7JiLCs
 U2Gtw2z2YNk23Dp/Lofhua81I4O0+ius=
X-Gm-Gg: AR+sD11jhy+hYbPkb0Dp9B1w+O20iQRyhVJ1yjlqxjaQ9S+a5e5Q8Zuvp1uN/Wp+GC8
 sfPXOqbXTeQ72pE//9JP1SbHj2WOTnaxrGPR4oStPOsjZAbM/QqgOiq/CE6+HitZ6m4UjnmvP+T
 1Mr5vjf/u44ifR+3gnaXu+qwWXG80vxkFplDr7f4E7rGZwHumrMsb7gWXdKMteVeCR39Rg9ymtY
 TtxyDxZkjPUqOoi2Wlm3Ce6CMXhIhvV0gcni/6LaUzDni8OuwPAfpQ5z+AhjE+fnjN570O5IG+u
 tOi5z39klw6l5ayQqML7F8vqNAfwjBNTHIqg3chUAO67ahFxwjXyoeC6Fy2Si1D/vC101hGBMil
 2E8gmjOCdrxzLAUKdWnShd9DzU0swVgeNGwhAnGJDWWm/BBxbhMg6izqp/LVeZDE+Zel4nOImn7
 mO9y1YvPNbYii8sn20
X-Received: by 2002:a05:6a20:430b:b0:3c3:6928:8b25 with SMTP id
 adf61e73a8af0-3cf84e51a6fmr20427296637.17.1787809608982; Wed, 26 Aug 2026
 22:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
 <20260826214643.122728-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260826214643.122728-4-daniel.barboza@oss.qualcomm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 27 Aug 2026 15:16:34 +0930
X-Gm-Features: AcwNN1XXt83t0JB989tICpdk_xnw3R7q5OlnnK_r3HRhx3Dvq9_JNHwYGsWNaVo
Message-ID: <CACPK8Xf44J9SYKc+fXbr5P1S5AgTHzBxsD7pj+VXgmwYXiM=Bw@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_syscon()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

On Thu, 27 Aug 2026 at 07:16, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The soon to be added riscv-server-ref board will declare a syscon FDT
> similar to what the 'virt' board already does.
>
> It won't have a 'sifive,test0' and 'sifive,test1' compat string though,
> hence we'll add a flag to enable/disable these additional properties.

Is there a good reason to retain the test0 and test1 compatibles?
Seems like a good time to clean them up.

