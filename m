Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523CEEC049D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMl9-00030g-U8; Tue, 03 Mar 2026 05:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMl7-00030G-RI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:13:45 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMl3-0005wP-PH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:13:44 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so4724030d50.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:13:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772532815; cv=none;
 d=google.com; s=arc-20240605;
 b=d7sN1LhV1RwkCwf9eOH3lumfXGFZ7ouHsFbwzelFfia9izQj1ESbLRxPTTdPKXsLrK
 fMIjOCdJS7zGtNcrRoG1akykii60JBij8g+YMip9WQDZ61xbkb818e3gO+/oXgJdOxoK
 QkICWZsMpj2OsFpAhShIXANsaqi+gM1m5u2ryQX0uGrZCp+m6vsXOxP7hLQ0CDve/8xO
 TydMKnMG9emZPdu8zJ/oJ6Xtpjy8T0uLOCPD/BxhRLEW3mjg5WRxM8UZh0+6+gK/3YRm
 MsN79tpo50Ofpo8YBKBYPR5nz3FNaoxDl5zQvLGQuq1hZSdEUKa0cCAJ3z4L0WdHsBS4
 s95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PAt/YTPKXaSvB81mXMyecr1xovNhVg3Nx2IXd1SSsKU=;
 fh=N4M1apqvy6J5mG202hBRfksK+AWX7PFtLp8tS7+ly2Y=;
 b=OVUYDJQVq5x3imLF8OTNhRwq5UgGTD6pwxCRn072e/q/4BS2paHKJ+l5R1kdtujfOC
 jSgp6w50yss/aKrA6LsCKsoepSjt3o572SJ+zDdCWKqkEQTeGSLp5w7nbns5pobSo5zm
 Dr2TKyOxWSJHF34arucdzAieu+WBSAFIBL2m0U4uNSlbdZf5isRFICCc1E+XDt+eJE2s
 elv1l8mSpvtqRBpq/1qxiFxU5Q9RSMYWwFK8D42VgYlRWGh1sbvC6ZHP5sp/Ejt0Kbyp
 5squtlj0O3m3sErP84lEVajJy6ieBSfwz86+QWDPLGJ4veDWYkUtDKqcxeIsr2l4dUyw
 pZdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772532815; x=1773137615; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PAt/YTPKXaSvB81mXMyecr1xovNhVg3Nx2IXd1SSsKU=;
 b=GWJ1Rgw6dlk/H2q5XUYN68hGALyc6Q6cK4UV2NFBzEq7uKysfo8E7MjwKgnkc/kPUp
 /koS36YhmQ9NTKaq00oGQQS8thgQ2ZXUvI5FqNATba7PjsJj8o8gGDne4WAiPht0oS8P
 1cZkKpB4d+6odmhyimjB2Qrdp+oNSxTgvS72WZeoc1qYruWwnilX2G7AV+4Ven0DTEvV
 UToCMuTK/oVOmbd7Djrq5P+UdBx92vQNLH6O9YrurdP8xkmveH9Px9Lkd7ggeaULjplg
 7erdwtymWg7g3rfxKYi+uBaMlRRWWz5fepY/5KWMxlMP+Zs6bOyLpxESrZiJ76poecyP
 gWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772532815; x=1773137615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAt/YTPKXaSvB81mXMyecr1xovNhVg3Nx2IXd1SSsKU=;
 b=fsXQ3ilCqYkTIIXnpJxDLI3Bkx06nLBZIwhizWOD5+m9DgZZVCrs02t8fi9RzzsFKP
 2e80I/pFoIvFU40NA0Ze5Yfy2Z6IEiXa6IeP1ZFcqWtHAq7vblNCmPU4JkZMUVpK1SV+
 NvncKEC1s+dHqmcQ94IPExhiksFtqtCaXPkVcxvnDN96A96t1z3FWxD8bWUFcb3oHf1A
 meIHnDYU6kNwEXGh7xqSJou4KpITNhXw5oODNHdXa2NtLmqBexe+OY9Eqs68kZvlZENR
 vBF+swqyYDki/ktMg2fYbFFCwpNuBc6emHtHGQ7NQrxlZO6DMQdIXRnlMDLclHbwsfKN
 76rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUna1Se1nWri60aoIl5bHX/lqZkg6dOU7uhQLO+fiZU5WqwbZ6mpF4Cu5ktcFTiRXAmxlqvaULXaL/z@nongnu.org
X-Gm-Message-State: AOJu0YzHsff3nfaNtVWiDbc4V+s45eCmvavWvy40l/Vwev/xEevNnN/B
 khuRp+cuGpoQWt19p5KgHR4UzYBPh7c46UW5Bp++SRlzF1/OcVEQ5SRz05OcslfHmCWK02q2eIJ
 8hK5zC8gOW32whza6Aq3NvfF3pajWSuNqQWeuI1Pv8s4m2TeEp29h
X-Gm-Gg: ATEYQzzeurnE3VyfW98Li0x7h6wnBgP8KVaaflO8ZMK+GQH+SZE4jWv/SSq+us2g0qh
 6MKyKYZLUK8qlMAWdKvW55ng2ZrSQv3LdmSc/BL3JYIW8XGjCaRay9X4qW4szDTntEsfgX6ubzA
 d0AbxbDx7CDxLWTnB3TYIknKqfnzP4FomOBuh24xRRuFtkNJqANSGQXieFRMLVtvjmVe9W2i7+W
 0XqoT9zbn1b8L3dmsnQgMJtSDSw//HJbN/GigqFohg3NvZV45QCnVVaaV7KuEqtT6qGlIkWxilM
 2JlWAReGrhaUTklQ7DcK9aF7xQ4895/hLmH7lKIgbyTqQ6Mv0ZsJBS8wo1K++cCj++k=
X-Received: by 2002:a05:690e:1917:b0:64c:ed5a:d1bc with SMTP id
 956f58d0204a3-64ced5ad512mr1040335d50.45.1772532814778; Tue, 03 Mar 2026
 02:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20260303-sme2-hvf-v6-0-b473702d8287@linaro.org>
 <d5dfad54-ef20-444d-821b-724540d052c4@linaro.org>
In-Reply-To: <d5dfad54-ef20-444d-821b-724540d052c4@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 10:13:23 +0000
X-Gm-Features: AaiRm53WDZkJJnyISGgFF2do2ewYBuKWfHQo6LmXaImPPTLs9NNVMBUmkHLJzgc
Message-ID: <CAFEAcA8uNUwFE2PCHxmq8go7TrTn00ujhNH97ReuVuUy=vOLTQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] arm/hvf: Add SME2 support
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 3 Mar 2026 at 07:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/3/26 18:42, Manos Pitsidianakis wrote:
> > Manos Pitsidianakis (2):
> >        hvf/arm: handle FEAT_SME2 migration
> >        hvf/arm: expose FEAT_SME2 to guest if available
> >
> >   target/arm/hvf/hvf.c           | 312 +++++++++++++++++++++++++++++++++++++++--
> >   target/arm/hvf/hvf_sme_stubs.h | 158 +++++++++++++++++++++
> >   target/arm/hvf/sysreg.c.inc    |   8 ++
> >   target/arm/hvf_arm.h           |  41 ++++++
> >   target/arm/machine.c           |   2 +-
> >   5 files changed, 505 insertions(+), 16 deletions(-)
> > ---
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

