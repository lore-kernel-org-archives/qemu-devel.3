Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CFFCFC5EB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 18:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syxh9-0005Q3-VT; Thu, 10 Oct 2024 14:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1syxh6-0005OK-Lt
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 14:15:24 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1syxh1-0008IK-Qi
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 14:15:22 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a93c1cc74fdso198693266b.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728584116; x=1729188916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9CMcOuhrXcb+zysEC+MmRHuy2mC8m43Wjaaf23b6hs=;
 b=lis0T6s7tIA9DxNUfMtDiV82A9WzEf/wlaOERtifphBCmRa29+R+WqeAGL30OXXYvx
 pNRMTdVayPl8kVFqjD0OfT0gXK7tK36y0WYA8tR6DvZ7V0k8v6Lx3G9PDHlIOW6zvTrm
 or2JyCSFDwXiYpxirGzIIBY3jcjTJ+0TKEFfHc/sfBdLWyPZQgzHm2dCB8FseYMs7lQS
 EJMG0MkEo9Iq7lGFqxkFy2WT4vjpEHbpkebsD24KByI+UMgzIlx4qIpRMq9z9GLzY5Me
 lDMh9sCzrh38s8A/vYfpeFY1yqA0BoE48aMDEAytRwDpPRfgOn2JC4hfyp+XSEnJ/wwv
 Iupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728584116; x=1729188916;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L9CMcOuhrXcb+zysEC+MmRHuy2mC8m43Wjaaf23b6hs=;
 b=apGBrxs8BBIM0uvwtg4Z2LpxkUBBR3a5J5P2aUMndAPU1klBZVbwQHnQYeR7ZgOf8d
 K3+FMek23Q4MU/3noDaSlH4y8pUbKclUtUGEg7aTlwE3UIu1Yzs5J+FjndZBdCrOF1Tm
 BuBoGr9vwoodjxNjRxFVfJjcJKW82J5IT+GbIxrEhgeeOC+ZVbiG/Ci05gUFWoCwVQtO
 AlAQPgCORNl2gjnM9DDUa9e3TVSbnUZ6QJOBNjbxFhslRAu6XNIqMYJ89T2OcLJAjQBi
 pPLkvXN517DIL8tQrRzOhVkj363S1aXSIeM2zgESi8xYoDIFqVO9QdYjc2WccC2xnlBW
 biZw==
X-Gm-Message-State: AOJu0YzCOPLC4Rv9hqksy1NFlySFZi4k//UaT/0V6Q6qh7ywPWPbbXzk
 5iamSEfh4ARLCSXicRQCu5dtkVLeit64O2OkdDT3/ZZjlUZskNZHRr6D86eqj5I=
X-Google-Smtp-Source: AGHT+IHwrZv55FRafeOJR5/RyaqLTtUrRfo6fXSS/p6v8qcgXb7YAfmQb0KO4v6ccCYV71453KlpPw==
X-Received: by 2002:a17:907:9724:b0:a8d:3338:a48c with SMTP id
 a640c23a62f3a-a998d11a538mr616823566b.7.1728584115903; 
 Thu, 10 Oct 2024 11:15:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f35f4fsm121995866b.88.2024.10.10.11.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 11:15:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6A9B65F879;
 Thu, 10 Oct 2024 19:15:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3 2/2] gdbstub/helpers: Introduce ldtul_$endian_p()
 helpers
In-Reply-To: <20241010175246.15779-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 10 Oct 2024 14:52:46
 -0300")
References: <20241010175246.15779-1-philmd@linaro.org>
 <20241010175246.15779-3-philmd@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 10 Oct 2024 19:15:14 +0100
Message-ID: <87a5fbsu31.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Introduce ldtul_le_p() and ldtul_be_p() to use directly
> in place of ldtul_p() when a target endianness is fixed.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

