Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC9AD3B7F6
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 10:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFW3w-0006x2-T7; Mon, 25 Nov 2024 05:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFW3u-0006wE-2w
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 05:11:23 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFW3r-00016U-5u
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 05:11:21 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa549f2fa32so151893166b.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 02:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732529476; x=1733134276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/lZMEnbhR9qsmWCm5bRH1d2VMPYciSXvkPZfmK5k/k=;
 b=Ao9aJYlmt9FUXgC+pbjwMviYYFBJqVlmDICtpfShLGzMKfoSSCASDtF1x1FrQ7JDXZ
 9MJNW1s5HMt3vxFVDDKZwYE9GaBu6UP74Ma4RQqfcvEke04vp6g6L5jGQ8aYA0stPL20
 gtPXUIXPu0j7f0WTkpDfymobcSmgcOOuAQUwGLUVVElbg2aN/QqP4u5RpCaGJsKH6tFW
 AP/SI2G25w2RGoP+zOCiP3T34oa1rVu9v2nVDfnttUvZ2vf49xlwm/XG4KNWDlykSY0T
 mAoj1lFl7GJN7H8FcmpZX1Jl+Vb9PfDbJDh19ZdFSkee9gagB0DnMP19AaWdWKizZs8i
 mscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732529476; x=1733134276;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R/lZMEnbhR9qsmWCm5bRH1d2VMPYciSXvkPZfmK5k/k=;
 b=YZd7OhuSfJ9cL56ZIJWpatZNtfdYT5TAyjexqPdtrP7o9YByfkPAxDUCzkDijXhtuX
 R9xt6XxRDQogc6NEnqEoJRyq7zZOrJEw+IX84pf2sLdMVoyfT/jUdnl7qqrFgti3NHTB
 lhieaCY9VIEl3d7VwIntH/EAeekJe08yuK81j+lOD9/LK6jhwK0eaJ9aFb2hdhumfu3r
 PIXyHln9le8ZVy7MHV0fLBlJxmaPgGcDR6r1rbBkhcviZ3E2nyUfunmXfjtQVns5M41h
 aYCX+CWT0b1FOjtbeymErBTxtOFhFWP5z9wlVouvcpQe85gUTkAGUMWcGcijF2tpZdUw
 AYIA==
X-Gm-Message-State: AOJu0YwEjbGrEUqPf2LsOZx4g2LweYEtfinOu0x2lX0GHvTC5WDRZyuG
 X95ZsSnRGPx4At1x31+GyxrbFU4YLxZROyRTWkPnNUoWmDaZ8b63xgmPd8CxKMA=
X-Gm-Gg: ASbGnctszjd1m0EnEQfl/WeNqCYBmsnHeO/3Ehlp1+UtChR59kSo6iEsOL3jNmnOzCU
 hqOUtRmQtBVtfwahhnGhS9LbeFHaqz3kIfd8fJeSy5xGv5vV+8F4gcqszsdK60LAwinv6X3SkZb
 4AV9s2g3GKkmeSQUCFiQONpocTNBQpLUuowIpXZNtE9BbrIORcTQFRD5WrvuSgVWKRhjKOTM8Wd
 DpeP3Pg7DuXJXCIJsqD32U049FFrNhSSU5gQAeMzMa/34Df
X-Google-Smtp-Source: AGHT+IEWk61DilDF6TTNEr5fHU0Ws9aAbrLhF/YB2A0f3xte/bGgmss5xIZ/CYpJwP6ZoJYNWVhuQA==
X-Received: by 2002:a17:907:9306:b0:a9a:55de:11f4 with SMTP id
 a640c23a62f3a-aa509c00fddmr1118939866b.54.1732529476274; 
 Mon, 25 Nov 2024 02:11:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa552066e39sm108718066b.6.2024.11.25.02.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 02:11:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5D2D85F869;
 Mon, 25 Nov 2024 10:11:13 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Steven Lee <steven_lee@aspeedtech.com>,  Troy
 Lee <leetroy@gmail.com>,  Jamin Lin <jamin_lin@aspeedtech.com>,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Joel Stanley <joel@jms.id.au>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 0/3] tests/functional: Finish conversion of Aspeed tests
In-Reply-To: <20241122090322.1934697-1-clg@redhat.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater"'s
 message of "Fri, 22 Nov 2024 10:03:19 +0100")
References: <20241122090322.1934697-1-clg@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 25 Nov 2024 10:11:13 +0000
Message-ID: <87y117d3ni.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> Hello,
>
> This series completes the conversion of the Aspeed tests to the new
> functional framework and removes the workarounds for capturing the
> console output.

Queued to pr/251124-9.2-rc2-updates-1, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

