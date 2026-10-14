Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEB5CC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyVd-0006eB-4S; Wed, 14 Oct 2026 08:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dennylin0707@gmail.com>)
 id 1xGtXb-0001YJ-Ci
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 03:36:47 -0400
Received: from mail-oi2-x05.google.com ([2607:f8b0:4864:32::5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dennylin0707@gmail.com>)
 id 1xGtXZ-0005YE-ST
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 03:36:47 -0400
Received: by mail-oi2-x05.google.com with SMTP id
 5614622812f47-4f3f1adebb0so35802b6e.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:36:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791963402; cv=none;
 d=google.com; s=arc-20260327;
 b=DYjktgeSC7seRskLwETkEfBmiMeVUiSLscRVeVkartSyrAjHPXXTDrxawj51h3MBCs
 d8gVYyRtTzKCpWQtaEVJa5xTS9v3M5VbQuITqb6CH2qyvoFhEvfdCvtx5LhwImnaR/TQ
 MT7uKxz8+HqoJWfvG741rFNfDFCq+l6/OL2+A9/KXZLUcvlXVJyTsCnWS1pOJYPT9/ru
 kArPHjJvbd7IXYjD5NfawnYgvgo+gjdSnJ6nmbMD2dDHhF+/w2oVqXZi0/SH2YPaUqPx
 q2nQWbijOX6SV6zxCvMG69fQR7+jATxd3h3fk954vHKk/RAmhLXjiSWAWfvvAN0IyLii
 Ljfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4UvGsQhIqbnODU9UlJC8QhO7eiqrSWQbpIpWOiMEMAU=;
 fh=TzfskRGa/6C5EpqINbGNdUAjd9sbShQ0gR80QPWZhUo=;
 b=sxFIJMYJ2uEQ8KSyzRhnWJ1/TmKhR/zM1GLaCVL7s3G+Cw/AxWbYfaHPXkySEmq54r
 IwcaSTP1/jl77qs3fuqTPTl4aWRxsEByTYBTMo76RV/ipUE3YinXu7F1KKw7px6VzpSR
 xYi5EcBpUmc86zXSEQmCTDtSs1mU7sSOzhWwieDf/5/KdeeE0eLiTV01A0b5g9+ZZHdF
 uFlVL2QLQxcvWu/JaxPJRrdNRLFqRGymC++S0iMVFkFHXofxkRoXaBIzNG/HG4yg+f6t
 +30swnu6wiXkSieC46MPjk2o5Xe9FMLZkoniGolU/V6bDX3i2UwXakIPxJ3b+jJe2aiV
 PLlQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791963402; x=1792568202; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4UvGsQhIqbnODU9UlJC8QhO7eiqrSWQbpIpWOiMEMAU=;
 b=evcU7Hdo1PPgqatfLY86Q4UEKBiLD+TZn9k05jL8DqFLLwBktqlMEoKrHCyt7MpG4T
 LaXgLznRoyI7XBdieXMb2xJyOvJZ4r9xB9Doj/j5tsxpr3rKjYiAvzAmgafkoxP8U/Fs
 IuXbzvGJ7kUjPdG9dC9AmmpS0AQKh0Q3o5xuiJDNPVcvKOcewO3nCv8BFALbETE8qntV
 kNWkwtmkL+TVw8aQmHySk64LdOQKphRPVZsO/NlmNc8izyPG1DIUvwnVaoba8nlnMVC9
 GxDDRg66jPCz7CV5euGQ+twn4zqC++2EZKDiRhcSmsKlVs3vtMsh20OHXps0HdWQHv9N
 NmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791963402; x=1792568202;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4UvGsQhIqbnODU9UlJC8QhO7eiqrSWQbpIpWOiMEMAU=;
 b=z3j2hsZUmYcLEB9ckwSIST/TJ1b89yH88Blq210cGvdYGV2otwVN45GZ83IJ91ByKS
 m8FAIXM5p+qqIBfqobe/dvzRlhxP23Xyn+26bPOMIbE+TzomIzS5pFKYM/5+Go3V3M1g
 RxZzA4zaJPafFI6yGBoDVis1pOBVNL0kvoXd/uWWkcZwh8ekRKlYdvvXHwmu/a4MqZU1
 wWCQHF/JqYW2eH2ruh5C5TLpJg7HkJ9OL65kRwImU/4C0K1gwPLGfc5LIaoDwAGzynqX
 0ZscuGp3VwttF7zKBwMpoxAGwWHbI89blFQufgnoVcuLjg0pXHyOlL+68+q6F7lAd2dM
 qdmA==
X-Gm-Message-State: AFq9FYJXyJlnfLf+rJz6tNw4PMK3ofsHyHPpLYcbFEEcupuepTF+LXP3
 N4FOHVFULUzMqFKeMzC8d/saJ6s9kfNd9jE87bPzO8BzyTwLgeDp2ezca1AVHnRhL7JWleJqByE
 Q8EKrgX6bcdmQFb4s9O6buhnbcXlOUYk=
X-Gm-Gg: AYBFou2eof7QUiVjkrBPAbqAJ62CeclAwu2ma7u+Jsn9WffgkBakQorl4tLImF/4s2l
 1o88F0kmVIfMCwrluwzAHD+W1Mg0DGNeXnXPwwe9EAJsiYopN7g87IY04ceKJf8F6APDfRsNhmK
 LqR83LQxBLr8OBJgWExPslo91cwOO5pGBGFncbQYVKnyjYEcgn9l04GbuCrGZgG/le0ff9bOgq3
 /uyYhV3JH9FkDyMgoECkOsrLANO2RVlXAewLim2zp/g4pj9wv6jwk2FPrV6VRCq9Yv2ZrfiAadz
 jouqRUTgUBsuRX8w+KqjA5wROpSH5ofyTCyQuaha40J7KlIDAleO/nwUjMvgdq9eJDGYkBzsbjA
 KyXFRYKlSYlhF
X-Received: by 2002:a05:6808:1386:b0:4b3:7efc:e970 with SMTP id
 5614622812f47-50c4246097emr15724688b6e.5.1791963402131; Wed, 14 Oct 2026
 00:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20261010192520.37355-1-dennylin0707@gmail.com>
 <e9cac01d-468e-4f9d-9288-024ca7574114@linaro.org>
In-Reply-To: <e9cac01d-468e-4f9d-9288-024ca7574114@linaro.org>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Wed, 14 Oct 2026 00:36:30 -0700
X-Gm-Features: AclHuK-FzhjEtLvbRRcXeC2k1aRmHIQVnSI_pctKj2AdnF4mJCaW4co7FFegVlU
Message-ID: <CAGEkeHdJ_5Hnvqn2ctQyH_OUyBZnoyxiOpCV1UhdgHLN_nXAhA@mail.gmail.com>
Subject: Re: [PATCH] target/i386/tcg: Clear cc_op_dirty after UCOMI
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:32::5;
 envelope-from=dennylin0707@gmail.com; helo=mail-oi2-x05.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Oct 2026 08:54:55 -0400
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

> If there's something you're trying to fix, explain that.

For XOR -> UCOMISD -> JMP, I see CC_OP_EFLAGS stored twice: once by
the helper and again at the jump because cc_op_dirty is still set.

Could you point out which state-tracking invariant clearing it here
would violate?

Thanks,
Hungyu

