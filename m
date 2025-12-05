Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343D4D33980
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXbC-0001eK-8X; Fri, 05 Dec 2025 10:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRXbA-0001dD-Ia
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:19:56 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRXb9-0002tc-2I
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:19:56 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42e2e5da5fcso1470617f8f.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764947993; x=1765552793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CI9UVXr56IN5uu9EFIFK5/excuI1xzH8tleWMraUFLU=;
 b=lcRlpORiiL5WQMndSXNQFm7as3//uuDd4n6pDt3QMGNwxO/agDJn0F/WHZOavbY6WX
 BumWiZhW/vEdLN9kW+yL8TIu6EuOqbVZME0Bi0kES6ddTxayIFVmaei6/ZXu3AagqOeF
 lgE8UJtbTCRzDWX+4R17BTfIeEUqvBZ+wR0eLP7WO0elWJxqJDPdYTdMWeo4yZwCQa1L
 BHxuWH4IvygbP8oPg6/kNzRkGVraOq7oL780zM/s8nujxma90Jm8ipndtOnRPs019mD6
 isGv9vcj27nOt2jWHBXzORp2N7awdl+ly2ZKcOM6jdj5MeUGeUU+MrGA4qBnZlONTSsd
 936w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947994; x=1765552794;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CI9UVXr56IN5uu9EFIFK5/excuI1xzH8tleWMraUFLU=;
 b=rTjkIz41jdzozy1GJD8nY0z8JshrXYXruClpuWHsQ+6DbIf95zMypS0NAMSwp6nZK6
 5Jryjz+FCUhkIHYJv3OO+AsaZkDqmbRhdjA0iO9zCADpILZU+XtvsyUXjS/kf6pLs8Dt
 hkIXpvD4BabzUtlX/j6BzSwEGDU+6EyXK8oNHe2zDI8lk22BE0mmrgEGLktXpN0yFSgt
 txVCtO6FiDijXH/L50xAYPJ3krvLj29T82wS8E94LbxSKe/WOvfyfzSDX8hyuQkA6+e2
 /MapuVOhpfXrff1RLW2JI6V+DMbtqPEwRvavncEb6XCiTeQ/gB+q46FqSed1FW2lHjbN
 +VTg==
X-Gm-Message-State: AOJu0YwcJOi/2ZldgYDoQVBL5h5t8noz7OIRvcrMlEsOFwEol42vxG64
 Tyy2Oq9nDgj8ye3DQSMrTqexMYP3BXganvRUW5G0bB3VMHU+t/Vy68tyvjXnhCjZMnLkNjf1rpP
 P9WHH
X-Gm-Gg: ASbGncsRPg+MGAS1bLcbQJ8qJipvC9BQNjJZaU8UCNqq5TLas+cgw+C/kpg9uSmk71R
 j+ykSaLSpRKotAety+fHoUIgRz3sD7mV/NksvvAohiNFSvdKnZXIwURsm9iXJ96IH9gGYDr0WOQ
 6tl+NxOYWLM+Dn+m7a4D0uCIOz7v69+bqhVUFCHAjuwNpfK3VoGZQYQv39G9oVxEaN7WNX1hbt0
 NYFDvrVWN+r+/YH1p5LSwt/GWPgJ3qjHRprc2XuimtH8MDKXdV8MlUzHLFB5A+S+3mBWHdvrcsW
 FECkch7a2uHZdeGLFFhENXWjOixEl6u5huow81Nqe3h1hIbGrqDgYSKPTlbvF+WoPBZp4FqDWFz
 wqys/cg97yCaNbBIjfKfdjJHnPElXOi/CQ8oRpTLs+aod28PocqatLsyC5QiskoLgg07L1k5YXa
 i3C5DWMl30dm4=
X-Google-Smtp-Source: AGHT+IGajw2AG7VCRdWAztdwRe4VbU5QIusNwFLrS9CKF4Y1gQVqATEpmA3em5sa6GIZKbJnaGDe9A==
X-Received: by 2002:adf:fe08:0:b0:42f:8816:6e55 with SMTP id
 ffacd0b85a97d-42f88166e96mr401270f8f.63.1764947993596; 
 Fri, 05 Dec 2025 07:19:53 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7ca4f219sm8944048f8f.0.2025.12.05.07.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 07:19:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5D3315F7F6;
 Fri, 05 Dec 2025 15:19:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  qemu-stable@nongnu.org
Subject: Re: [PATCH for 10.2?] gitlab-ci.d/cirrus: Update the FreeBSD job to
 v14.3
In-Reply-To: <20251204205025.2423326-1-mjt@tls.msk.ru> (Michael Tokarev's
 message of "Thu, 4 Dec 2025 23:50:23 +0300")
References: <20251204205025.2423326-1-mjt@tls.msk.ru>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 05 Dec 2025 15:19:52 +0000
Message-ID: <87sedpq7l3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> The FreeBSD 14.2 job fails since the image disappeared
> from the cloud.  We already bumped FreeBSD image to 14.3
> in tests/vm in c8958b7eb4 (part of v10.1.0).
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Queued to pr/051225-10.2-final-fixes-1, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

