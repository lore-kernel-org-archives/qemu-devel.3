Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6764CCF8846
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 11:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM2uz-00008t-LO; Thu, 20 Nov 2025 06:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vM2ux-00008A-Vu
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:33:40 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vM2uw-00070J-3T
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:33:39 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b472842981fso99299066b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 03:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763638416; x=1764243216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmHU2ZIXK0EDG5unqIktE68KXbN16oNKcRouNpKYKHo=;
 b=BRNckKf9GsyPsDTg2lXu7HbQ6eSxrP5fqcY6Ebgrf4ISWuQYbEgWRjwRjg9Zy7kqsn
 mSq1n2C8xMixGijXCthf6p8PJCd4/b2faPDtwtcEB73AbAVb2Z0QagUY7fNpg04owull
 F7OxgL0Djp25JTdUkr0WKOIfdKMBNrNn6Nk5khseNyRkTqRYzv3u35LlTWKo9CiorySx
 W4nKshASc2PcwIE3qi7mPDpSIZ8sMXmnSHxP4abvgeHRpodAldD/lDbKd52q61NSiwZb
 LpNli/1xrl/0USeA94OFGuQrl531woMWuFOrwCEbaK53soq53V+SYotUr31DCBpNBSse
 cwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763638416; x=1764243216;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fmHU2ZIXK0EDG5unqIktE68KXbN16oNKcRouNpKYKHo=;
 b=Z141Jo/bh7zSARdKLW83lStMVF+vmiqO/TMLR7JJZM5u323/NumAVhjyoHMxY1vCWp
 XxU3Ox2AKrxTZtjyOm+P0H4Jsf9fBaYEmhdKPJiAG7akPuqAD8g4jn/0qITSd/RGbbU4
 MgvDbkW6shTgU8xm+eEBhlb8IKNjw6EsC1QJNR57xFjMNUg9pBh5GOR5949L28c9bPKz
 7laB2AvFbtvtfsBLbSfAwnYw2EK+4tz9W5T5vwlcA2ckf4ChJ8vFccXeP4exWPWmKXAc
 aVSAhMCHsTGaPty6vkroD6lL/5JUMiFOHfvXycZVDj+U4sGlor9D8+rBVU3myX2ZaBbJ
 7A+g==
X-Gm-Message-State: AOJu0YznBBonGjAhHQVyf/zk9ygeJZOH9jrHtol84W4K3XAC45ygI/m9
 bQ/XF8+CaLkOMl43UTMFn27mRvkUR69sGH/WmjLbd9nkZMEvfHYoyrxcq24mb67crGvjcbPIOTj
 TdB1k
X-Gm-Gg: ASbGncsBB4Rb243XP/NHvBIuT1aS3ldw2m4FcnJxn1VKFu23bIaZynrhB0Zx0F6502/
 TH9wf8VKbJpgItCN1NtTzNiCkrlvahzjiDqgZdQgTP5/2boI/ro8i7yG7uY8gUUEwgpYxwxj8Ia
 irRXWTz0pKYTqDp99HUiNbFQyVBstCr7hy/h423Wm9536Tn9FGIonF/z8bQO6IEBewaVRuIs6mi
 iN3LJ90JUkkIAju6DUIKJUAyLuT1i8ipVwCZLTecb9QDfKeSeB1M2JWU4hPtcwUr6hGLJ/dsBak
 8Ol5ppCqdRvbQHeRm7KB+i/HiNhjeQ46riJl69gtrUwUABxtkXc4H9Toyya6Nh3aEfF0Tuew8+A
 oD3v1El8T0SlN2FYXc3o4ayLH8z+EkduLxzEB5qkzWLPxpFCbi/YpMiPwwmw1dfi64oQD88p9HX
 oobxxQgv1x6rE=
X-Google-Smtp-Source: AGHT+IF35maHJRGBG/IPwNaqZSwB/8+VwrQ8MvEjx7JUkrcmxJSS1g6BJUNa2+K9e0XjUB9kEHPIJQ==
X-Received: by 2002:a17:906:478b:b0:b76:277b:9678 with SMTP id
 a640c23a62f3a-b7654cf1e87mr302400566b.10.1763638416315; 
 Thu, 20 Nov 2025 03:33:36 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7654cdac18sm184097166b.11.2025.11.20.03.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 03:33:35 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 031A25F802;
 Thu, 20 Nov 2025 11:33:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  Halil Pasic <pasic@linux.ibm.com>,  Hendrik
 Brueckner <brueckner@linux.ibm.com>,  Matthew Rosato
 <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v1] MAINTAINERS: s390 maintainer updates
In-Reply-To: <20251120104602.205718-1-david@kernel.org> (David Hildenbrand's
 message of "Thu, 20 Nov 2025 11:46:02 +0100")
References: <20251120104602.205718-1-david@kernel.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Thu, 20 Nov 2025 11:33:35 +0000
Message-ID: <87jyzlhrao.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

"David Hildenbrand (Red Hat)" <david@kernel.org> writes:

> Unfortunately, I don't have a lot of capacity lately to take good care of
> s390 in QEMU like I used to; and it doesn't look like that situation
> will change. So let me convert myself to a reviewer in the s390 areas I
> co-maintain.
>
> Fortunately, we still have two other maintainers for "S390 floating
> interrupt controller", so no action needed on that front.
>
> For the other sections we get two new maintainers: Hendrik will
> maintain "S390 CPU models" and Ilya will co-maintain "S390 TCG CPUs".
>
> Thanks Hendrik and Ilya for stepping up!

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

