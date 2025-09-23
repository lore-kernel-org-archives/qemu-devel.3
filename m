Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D854CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13CJ-0008Rh-Bo; Tue, 23 Sep 2025 09:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v13C3-0008Mj-AD
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 09:36:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v13Bp-0000mF-4r
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 09:36:27 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso27679345e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758634562; x=1759239362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfUtgFeSbjMRyCAmZlAogG0hou7P3YxK0T9Pbp0hsN0=;
 b=rMo0Nwt+dL5QJJJzhsiEsDSGTLGdjvmkb/iOvxaMoJ98fGhsmxUSCXBKjntluYi0/W
 4Yb6cIoa5a3lXhCYsGYdaCag0ehPJENvdSHxu7/BWEyXHc2aoYBQIqss9Eu5eLTLFp+M
 BdeiJZ4ocWLWSol/7AOg2NLDiwAv+TSaCpcNNDa4KpUwgq2UBN/ubBS+yofoiccrOS5N
 tWUAfwqEf4U3Z1+00h6j+5dg5fUC1+ZWaYB1VivmoSg9rUc5M2ugFQrOpeUyl36oP0cg
 ApOKhlq7uDQmSyp32V7ZVM55YpN1wTzV2AyawKg4Go4oStvXaDyZme41AVqfNy+rMyK8
 O4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758634562; x=1759239362;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PfUtgFeSbjMRyCAmZlAogG0hou7P3YxK0T9Pbp0hsN0=;
 b=turcgqF0RgxtmpJexUlmpqkG/2+YPu21e+zkG7KTe3sP6/bJETBgKo+k3HH2bCJCiD
 LGQVOM+HlJtTdC2KN6j0xo4y1FhDw5RNfwvSdUV9PeErh5htVt71Yhoo/QZyl+CmmrwW
 yWbOZRT9hnltKpU7u8bTmFJljUHJ3M7ecJWm3h+4E5z/wQ8BJ6PTXiBvhFuJn+/qDYAK
 rVBWHa5ostU50Jlx1jGpwYsu3x7s5s4qkkggHKijskUVgAm9WFffd+SF4hBDp06LpHd2
 dkdMo5cUmsWuchoo+5seKtVza67PVEWUpyQJT4d67VelztT6wjAHQxU6W0koUfUeKit3
 tlNQ==
X-Gm-Message-State: AOJu0YwVkEwS2snX38DxMCV1J1i5rjFkzTT8WGWllkW7ePTZ97pY9fCH
 Im/yYqG7ddEH7t36oBdWISh98EG+BJOqj0zof4RuUkk0VNtO+v1HQGxfw3ACV83O84Y=
X-Gm-Gg: ASbGnctdt7CWoOFeNBhuw6CVwXbsMgbDgBnrC5kGOfALIGCZIsDUYaYwAU9XanwuxfT
 w9IQgauaF/S08emgnWBF5TLruLZTUuowI0POveFGSvjcYLmzamOuTLi5+E5X3Uj6bo3YszEo7Uy
 1AK1EpzqRffXw0vXu1LK/RADIf2PehMFjOwlCxOPAo1Vz8xBR6Lx95yfpFZgPYqVttcMDoFuN3h
 Lafe3hL/+sMdlI7vVZBSqksZUyvfUhkCYpcd43tWbdhbLeYlbP5k675pEI18HwKUF0mh4v/sfbx
 ZFmc9zniffigSOdNsKxHFG0YD/QMVVru0aGGblaNOuNEQIqfLj9nP4h5B+lJBhzjancuiJo5bog
 oTHfLBAQpubDB1m6zTPGYtNZ2qz3J9alhjg==
X-Google-Smtp-Source: AGHT+IFru5XOFoGpQltCHL+uwZ29k5D8S/2Af362p8XHi2BvCKhKMPKczQ1Pa1ffcnvO59bIkiJkFA==
X-Received: by 2002:a05:600c:4fc7:b0:45f:286e:49a8 with SMTP id
 5b1f17b1804b1-46e1e0564famr31599495e9.30.1758634562413; 
 Tue, 23 Sep 2025 06:36:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3fe9dbf13f3sm8139152f8f.50.2025.09.23.06.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 06:36:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DFC355F8AD;
 Tue, 23 Sep 2025 14:36:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-trivial@nongnu.org
Subject: Re: [PATCH] docs/specs/spdm.rst: Fix typo in x86_64 architecture name
In-Reply-To: <20250923120118.858581-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 23 Sep 2025 13:01:18 +0100")
References: <20250923120118.858581-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 23 Sep 2025 14:36:00 +0100
Message-ID: <87bjn1mgu7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The spdm.rst docs call the 64-bit x86 architecture "x64-64".
> This is a typo; correct it to our canonical name for the
> architecture, "x86_64".
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

