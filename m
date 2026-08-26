Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABE2C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDGY-0007dR-5s; Wed, 26 Aug 2026 09:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDGK-0007cw-JS
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:01:52 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDGH-0008JV-TZ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:01:51 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so1712697a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 06:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787749308; x=1788354108; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AFCQSnLOxzXDKYpHHmLjDQoJM8U1BdFSRI8z94i9XPw=;
 b=zwK1HTiL+Udb9SDg+fPRGJ2QgXwCqywJUTMd8JBhR6z08FCXDpDMuMtOS5+NSLsFd8
 94auwUUTYHsCd3FlyoipO1+rZ7SuTW6gsyQgnXn7ijlmIUu8oty0EFn8R3NPum6DW93D
 u/nevzQesSegivxWQp49U06Pv/f7v36+2+z950qO8f7x3D3p6cyjxY271Qj0vYLSUa1u
 NtL5BPtuc5JfZsq/NEKmXH8fDRaRGkHCEbnHwCW5Po21mKSfMKEtg8/aBg8tDNv0/HMx
 qDQUsZHB6cxjeyFbZ2zu4zJWmwFO+lnhZg/AexdgGfcvG6jMXBGU3UqSPiFOR4H8M52l
 1J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749308; x=1788354108;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AFCQSnLOxzXDKYpHHmLjDQoJM8U1BdFSRI8z94i9XPw=;
 b=jgKCO4r9EPyEU1WZRwR0+yULQdeZiHFG2V6XiuKpAJDUC7P8+EyZvoVcT+t6Bv9L/L
 0vZE1Vq91nlIbKLRvLtTcRfYOPOe6K5Me8oww4wtm6TlOLzpanUdQestTL67y4rEuyvo
 Qe4EnkVn7ryd6ugyKdDS6bIl2W7I6jrl8bINuNYXHDJxT+mUc+RkYU/rX7Zd6BGMOREu
 m6tN0yeoxl6IQ4xUoitMwPpzEqX+XNRUiniLEtQAMuRhkgOAtvTxC4lKGDIEHSEGZNpm
 VTrx+n6CK11YbNJ5YwqIEU3g248MF73urmWF6nE2ipjr5ryYVJ0DSrVSij3vTQ5pC6oo
 Vf2g==
X-Gm-Message-State: AFuF++k4REak4zHt7nNZzgaeiwyNmjfGbMDzMzmn9fsyz6QAOeUzcfqW
 kb6rgpNU13e/vahuwbPkx19HIsK3fkQjwWr3rbwZmtnaIrZpOvteyyI6MKDZ7x8O4ns=
X-Gm-Gg: AR+sD10VpDCu1jvIbmdHFDVx/zrlKHQ9SxE2GqTrILr7ukgfpRrgzujtCXmR2mfOjvc
 45Oxnm32yWyY37BotQ6k24N/JO8Idg0NndGasDwfPzLb/6xSC5w8sfAgLP0akHyQ/i6TvFUQMgq
 gN9L2PGhyZfmRtaMGxAObkd+t7F3mUc5YTG/n3FRlZ31HIaaSMJ3ER3FfsNBi4hTSJGXCRwIzEZ
 0A4bxw+6Vh+2EmCMhycrw9hQtj4ler8LABNU30sWX7UJKUr7ixegrjgYGDmS3oLdK9PyOwj+ACM
 WLU46T1qdXxppuv9kAhsxe+Ro81D0UN/4Pbaar9Tt5JxDQy1vht15UIImIVL3bZjlZcdLMgFC9F
 oTJ6LZvTD2GZqFSL+5nxlSrXRP9xTjJUMxLzhoqa2/rcYtIMzMOZoTMn9Uu8iQNlWlVyqyFeBXA
 X7l6J7LCNfqjxVpw1ZguJT4ljHYm/K4fhknQ7saE+VA5lkDNfncioHLmWEgbbB
X-Received: by 2002:a17:907:97d5:b0:c20:d90b:2cb1 with SMTP id
 a640c23a62f3a-c250bc14b44mr798719166b.0.1787749307657; 
 Wed, 26 Aug 2026 06:01:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d6acasm551837866b.9.2026.08.26.06.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:01:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A38CD5F81E;
 Wed, 26 Aug 2026 14:01:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Helge
 Deller <deller@gmx.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Aniket
 Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v7 043/104] tests/tcg/aarch64_be: user tests
In-Reply-To: <20260818192309.22169-44-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 18 Aug 2026 19:22:07 +0000")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-44-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 26 Aug 2026 14:01:44 +0100
Message-ID: <87tsohnih3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

