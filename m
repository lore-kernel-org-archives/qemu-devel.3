Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB13C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wer7o-0006S9-Px; Wed, 01 Jul 2026 05:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wenf5-0008TC-8l
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:39:03 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wenf2-0004IF-TH
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:39:02 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8475eca3a66so245543b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782884337; cv=none;
 d=google.com; s=arc-20260327;
 b=Qbd9AI7OgtzymVF++zQy+m6wkFXkncaTNBNIB20kXvb1E8BBZtklnfpdOeNSCDjoYY
 nndo65o9+BjVGMd8oGvgCJTErzySCzcnqUlUMQCiUNpJhm9lDH1t9HPtvR9hLykq9YWo
 yx/tkYKQfvNp3YfnrjlIguheGQrIJmVqGFknFMkz+O0WJBSuM+138c99L/sH6OwUD/a5
 nUQrTVVpPZ8voD2q9jUGKB7f4eLeZU2/7Wcep0AEaaOlqhQzzWZT2BdIS+73OG1gj48N
 ZZP0Xj1dfzLbIpa/Rs2R3FIyFY7hsaomCwtHEFj2JztlXCfiJ/mALCjAg23AZKvyHCi4
 o1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2tGjOoVjR/8nFMMUnv40ozYvFgs90qmTPu5OwPCZMig=;
 fh=lyeb/miAe8uwD1JGoqa3DkmppHBCFOu8N+3uBDFEx4k=;
 b=qjYlzgwEMD0vDJ1uXZzU26EgYuYLcd04VY0l5VQ90YQAeE0mlJop1MB9/8UbppGa1y
 gC/TIkiCUWen0NPjRAwXD2Xro2NMrU2VZSlXwViCC7QAFuzoQMpaFC3uMQAWwjwHKgIP
 8pF455vS8kdqjgudrKoRFQh0UQe/MPyqw0X6Vnk0nywG0x04LvxKSu11stVZACdkkzHD
 8rEnufAxyWh7hwaeelHlUajhdemF16SnzEIjYd6qvLAIzCU42DLgl+GKIU/pJVRjtMVK
 uh4lziMxP2so1Lgg0+znYonLaSR1MUaAzCtTsaknMg1TA1GuleZDOln4X6HGXK16TX/V
 vuYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782884337; x=1783489137; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2tGjOoVjR/8nFMMUnv40ozYvFgs90qmTPu5OwPCZMig=;
 b=b0anI8ir0qXZ7Knb+cBEcqcrw56rmJmKpY2QI7gFI1urRuc+4JXJOPAv+EqW9/WMfd
 S/lTuhMGTxO1V7Mo289mT24JuIei5wlKN/L26j/QtDyYxcoVl6BPniMi/BdKS3razn/Q
 0oT+4uy5QEAeNlSu5B4hTAEaguCh8JDHAc/ByzSExRKUlvOCMPjuDXpvzpTetjJm1X+D
 JHSQz93pvxH5uNg7hzpJMrEiZKJ4/sWJfZz4Djkg5ePW5vGWjbijgFe9BlZNVat2N8c9
 WL27JxsxnJfi0jz3Uv8lfVMA5Ow8PK5Z18GcL5sTNETxN/eoGreCOHyu0+w9BTmrkKaB
 5G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782884337; x=1783489137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tGjOoVjR/8nFMMUnv40ozYvFgs90qmTPu5OwPCZMig=;
 b=hvTU5PYZrMlVtLLo0MgcJxB4qpRLtMxmYSrE/ADWKyZr7MxqCF+08MC8Hg6p4cU83U
 v8gnmecCHaM2dxMdQaOB2qcP47Q3KrTWzoDYNdmxU3ki5Rv88DvR3rZeGJFuZLOQLCc5
 0UTEJucnifeRfFBAucY25gmuA/pyBzW3zJIHOjLSGwOEMu24/hZFvglJfE0hqBbjNGeZ
 MXPjFWe9FNedZrDLwNvnPxfEtHbPtcmqlEbDTjcD4cbcIVrkmqRlC8IFTYUv1jWmaz98
 9uVvbEDS85bxxLemfQsLFGnUwhn/oUU7Y45wjqBGHlLJUno1pSFRBEQ/NOkGYIOAYYeR
 UJyQ==
X-Gm-Message-State: AOJu0YwGNR5NcJ8C9ien4D6anHAPKvTThMnEFOHc7shSN6oOiBBUPPMo
 dKSbgnUcpDzkHQ8wdDCgNPI5SPAHDX7VtfAnJxnCQ2bvFRAbEDz7h9jnmLKQ0IB8ZfePRv48aqF
 2+0JupgFuN4U5ETKmm6REjpohv1DUJu0=
X-Gm-Gg: AfdE7cm5VPXJBtKNYIQ65yj5tNhyuBhVEF2MiXVq/NN2COvvRv7dcbvz4QN9vdQNIwT
 fmunBFUWTDW15Q5/WJm7znTS5bjz3YL+Ujr40zBYPa0mnehQQ7/1BOSKwaS72jcl7mKYN8sh/7s
 i1zn33xM4UMSz4Mu6QN1Dtio1fA3uY5oqRe1LGm3anpCnIpDYUVIEQXGp0BGC2oG0BnpHBHhWqG
 ZmUYRWK7w2QcNrNpqSR66vS7RgFNDUzusDk4veymO9O2Iy0zQIH6ehdM6g2yD36Uu5mGCLfetJw
 AgEclloZjNY=
X-Received: by 2002:a05:6a00:2a0e:b0:82f:9407:d167 with SMTP id
 d2e1a72fcca58-847c09c8386mr129950b3a.38.1782884336637; Tue, 30 Jun 2026
 22:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
 <CAFEAcA8R1RXrGo2xov-4gKLQXX=FTVKoK1rGuxuYmBo9e8SN_g@mail.gmail.com>
In-Reply-To: <CAFEAcA8R1RXrGo2xov-4gKLQXX=FTVKoK1rGuxuYmBo9e8SN_g@mail.gmail.com>
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Tue, 30 Jun 2026 22:38:45 -0700
X-Gm-Features: AVVi8CeOBtZJTvsljiabzMR8Fo81rmvNVpq8-chsg7c0ssTUY6z7FEJUK5wsM14
Message-ID: <CA+1f7BD2pVP2ByBRbwbHBRWNNuZHKdM_7xSVSmPztEWw1BbVbw@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] target/arm: add support for MTE4
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=brookmangabriel@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 01 Jul 2026 05:20:53 -0400
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

Sorry, repeating as I forgot to include the mailing list:

Hello,

According to ARM developer, FEAT_MTE4 only implies the existence of
its 4 subfeatures, plus FEAT_MTE2, and MTE_PERM, all of which are now
implemented. There are no features that MTE4 guarantees that aren't
either already present or introduced by my series. This means that we
can now claim to implement FEAT_MTE4, and close the issue.

We can also add it to emulation.rst. My apologies -- I can't do that
right now because of my current role, but it should be a trivial
one-liner for whoever picks it up.

Thanks,
Gabriel

