Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6428C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDGc-0007gh-QO; Wed, 26 Aug 2026 09:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDGV-0007fF-Kv
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:02:06 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDGR-0008L8-UK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:02:01 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a5e866bca0so988091a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 06:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787749318; x=1788354118; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=shLgIjrhVAQNRCocDYxkG93wp5XREMwXAvEW0xFWpCY=;
 b=vYe44IFtPVgULw9/rRogZ6obN0Iohy3v8cJBAWlcz8PUrtQ2LT+NnpWKgbpX+uew0A
 EWikLFV73jW5dMdTvTyJAnqiMpDljPwkyg/kUCEiSWxlP9yRfnLFERkiezigm39lOKlk
 H4jM39SvB7Ajeaqf02rREWpYPs8/ULbn/BvuH93sdXec9CE0S4wFPQEADH/lHe45+7lo
 GezpFIwYzY16sGr2N9BMnA+ptOg9VKei5ZjtQO2X0m2+SH/mFDLLbAZFK3a/qnGGenFr
 FE95AbRhZfSvN6h3C2vW1dKciEQ8mzqNZsDYCfCRnvQv5qf5/mdg476QcKZbxtycS1a8
 mW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749318; x=1788354118;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=shLgIjrhVAQNRCocDYxkG93wp5XREMwXAvEW0xFWpCY=;
 b=GlTc+Jk9y9fvbtvXniD2UTebtMylPnJ+4nFIIxV7ZyaARw03Jc66G3BWdrvQgG376H
 RZ8xSNrM6zWOpZaIzqvUNQIsk/1WY0EPHdvNXjR9AQI3OqXL6ObWsdMU4jb5J3E/2Unw
 1lSMhyY8TB2JDliE8EwfuKsLXRhVOaRRDQAH576phUkQ5TyfZkhpjMDgaiBT9iK2GK8R
 NUEgfNy6GCzoCxh3DW4c/zTscsAADmAOs2z4jbluq4b/EPUdwKTLjLHCLL+ex5B1RjdN
 1G03MkwUMk0tpec+HRj/2LY5KR3Kw/8DfVJRSeQNYbMv4XNvmNRazPdWaZ3BgibmoXPn
 DvAQ==
X-Gm-Message-State: AFuF++mH1jr291Zdsh+32gGrn0lAbL1GLZvwUnCJrnHRNFGB6uPW8OKX
 lmN85bTYeNOKRnnTzR1zdWAX9Gi1yvJe7lvUTIffk9J9e5YvxpFjZpxQ7dfGmLANwFw=
X-Gm-Gg: AR+sD12OPI0BQOrhGrmmAidnlTTPu1tTp5xfDTUgpIIyzIR+1A5/yTGGDT58eSgUlaP
 QiG44+VhcMwrD5yfsQe6Y4cHwDLgIa7x0gK8fsiieDLGElKkdW0e2r8ATY2U4eXOWfxaoYV7KDd
 zS3pryQRvndmm1CdYM6rYkuODxy66HLCQcgNLsYRX/dlWlzpUhGVu+yNvvkBcCpNzhm9n6LEYdf
 0pYqOaoUJiHsBr7e8wYn/DqO89yVotEcPsWbwgThpOoTwpipQdNT01u8GLG5wxzfzhp7owaBeX+
 dFl46F3f3taLJnW8udiQ4hzEP4CXvRn6mabCT7zr0Jj5gHMq+E+QpcZ6DWQ42wrOx3FCGD8rzbJ
 rwAfIwbK5xJnx0qHSv13SbE6LyT3RVrk0YfZX4i7AuP7M7UIGJIU0aaN36c3fxwzyhZEcDptOBL
 IjkdRG+QZU8Rr6YybcdV4K7k6j4ouYN+66d6XqVTXlG9GOEaSev2D0zNrYrZWq
X-Received: by 2002:a05:6402:5041:b0:6a4:b50:f8f2 with SMTP id
 4fb4d7f45d1cf-6a5df653ed4mr8402527a12.16.1787749318194; 
 Wed, 26 Aug 2026 06:01:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deb030bcsm5627659a12.31.2026.08.26.06.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:01:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D88CF5F81E;
 Wed, 26 Aug 2026 14:01:55 +0100 (BST)
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
Subject: Re: [PATCH v7 041/104] tests/tcg/aarch64/system/gpc-test.c: remove
 unused variables
In-Reply-To: <20260818192309.22169-42-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 18 Aug 2026 19:22:05 +0000")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-42-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 26 Aug 2026 14:01:55 +0100
Message-ID: <87o6epnigs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

