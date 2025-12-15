Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62F4D5B866
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 18:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVDlC-0002oB-CL; Mon, 15 Dec 2025 13:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vVDlB-0002nk-DN
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 13:57:29 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vVDl7-0004Q6-OF
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 13:57:29 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso41809455e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 10:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765825043; x=1766429843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6dsbfB55lL70cfof4yycVK0QIlwoXPPbjIaQMXm9Ow=;
 b=wLEAiph4WmjYhMuNUp092zmXol7b+xmngMiPuJzQr9C/mz3IkixqAlXjZHtX3HSMmp
 thE5TxMPg9crLpdpLImII17nS1RzSacNeRQAjLWj64yMzr8DJ3x3tnDMo+cTUASpmyN4
 mbzq7Wx5UrJFp9XXBlibTBMYX03U8aaqGKOEH4bZJF4X1e6km0qVVyTg2lZWM7xiQCbI
 FNq1POAHR/ybb4UC0WxR0rNX3YFrAvhsIJiGvnneqVdz4njm9XylzS+Jx2JuPZnNVCwb
 492hor6RSIsAdFT4HKnPecJm1YgkENWNb6Zk4QKcBCIkgBnJD/egxA+J6AQY/XYBOAlY
 LdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765825043; x=1766429843;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k6dsbfB55lL70cfof4yycVK0QIlwoXPPbjIaQMXm9Ow=;
 b=pnmTqyaSBUJdR39oTBFJOqXHzWYCqtaGIQsvEFsS4cjyiMsOwlrkXxzd74/79UseKr
 JZuevBjCtzzlRAyphnAPK/apz4WBPESLwaX2FBOykwad16WxYOjiGs44IMDLHsWTBvN2
 aE0lyEmncsmWX0ky7Prbxi/NRcCU7inczKN35lJqYFUKg4zBREVuJJGdDX6SkBojjJhn
 IC+7UnSIeopoj5Y2J+zGgtgNOwwVoxw4URk4OYnFYgZfK3nncRzP/quw9qnGpaQUcXE5
 I2I4TXDyZsT1xE8nP48SmogW2tmM3jA8tcubzFeQBdjIm1DYuzmPteIG3VOkLTz6pX+0
 slHQ==
X-Gm-Message-State: AOJu0YwTy4jl7mZSE/RfrIa1Oaty8b/+Y1xt/XESHxjq2pak60W+RdKw
 6i2EC3fsJJbUny6DOojA10AK4gZdXIiwijrrTw4AUKB0fQcXcgAcmy/DZJW+eM/APejZ5EWqVj4
 QqFXk
X-Gm-Gg: AY/fxX4sUIt/tvQO0YfUW8bnliwMHxP/18VN7wadwwJ0cQ6Egv+/pMGA1CeSBnVf/8I
 Fqw7rIU6bgvwZk55zJqtPSjBKAOUH+pUuSoO1H/kdB7fb9o8LrkOD92HBvE/MM7w03Bw8DNypzc
 DKjhU74kJxhB/BHcy35b2PLeCXTVa6wby5HYSF61EdKjjOW+ADLuf88cCTclgjQ1jHkSjvtSE0x
 r7ReeaH/8e3Q8UH8vh/R6jeX5GUEQReQNwFwV+rs3FigznfHXo6131e22YZPkBFrGXSLdU2cOU+
 VhJA0dySgOjTRkewCjQdg8nYmL2blmoinYvVXXMmub21wMUCwdxOpKRnOFus/M3K0uV1CSGwhuY
 S2d5AStH1KhgX4/CxvDR2jllrPBpY3xTCeitkBM/WK3WdlTemrtGWnfeuvSGeUmyONx9LO8K5Xf
 Jm0HMNRYEGcPQ=
X-Google-Smtp-Source: AGHT+IFgYgL7wyWiNZh5f7TBwzd2UtQRw1YL17FL/zCJqFlD1v28fhCSFvZi0LeZKko8kievtNHetg==
X-Received: by 2002:a05:600c:821a:b0:477:fcb:2267 with SMTP id
 5b1f17b1804b1-47a8f89bc9amr132265025e9.8.1765825043346; 
 Mon, 15 Dec 2025 10:57:23 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bd5f896dcsm1020875e9.4.2025.12.15.10.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 10:57:22 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E3A335F856;
 Mon, 15 Dec 2025 18:57:21 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [qemu-web PATCH] reorganize sponsorship page
In-Reply-To: <20251215144027.567313-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 15 Dec 2025 15:40:27 +0100")
References: <20251215144027.567313-1-pbonzini@redhat.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 15 Dec 2025 18:57:21 +0000
Message-ID: <87345bmv3i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Put all CI resources together. Azure was replaced by OSUOSL and AWS.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  sponsors.md | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/sponsors.md b/sponsors.md
> index b68779f..8ac7d45 100644
> --- a/sponsors.md
> +++ b/sponsors.md
> @@ -7,17 +7,17 @@ QEMU has ongoing sponsorship agreements with a number o=
f companies and
>  organizations, who provide resources (software, hardware, monetary) to
>  assist in the project's operations.
>=20=20
> -[Azure](https://azure.microsoft.com/) and [DigitalOcean](https://www.dig=
italocean.com/)
> -provide QEMU and [Patchew](https://patchew.org) with virtual machines and
> -other cloud resources through the [Azure credits for open source
> -projects](https://opensource.microsoft.com/azure-credits/) and [DigitalO=
cean
> -Open Source Credits](https://www.digitalocean.com/open-source/credits-fo=
r-projects)
> -programs.
> +QEMU's continuous integration is supported by:
> +* [AWS](https://aws.amazon.com/) through the [AWS credits for open source
> +  projects](https://aws.amazon.com/blogs/opensource/aws-promotional-cred=
its-open-source-projects/) program
> +* [Digital Ocean](https://digitalocean.com/) through the [DigitalOcean O=
pen
> +  Source Credits](https://www.digitalocean.com/open-source/credits-for-p=
rojects)
> +  program
> +*
> [Equinix](https://www.arm.com/markets/computing-infrastructure/works-on-a=
rm?#Equinix),

This is out of date now, Linaro are hosting the Arm hardware.


> +* [IBM LinuxONE Community Cloud](https://developer.ibm.com/articles/get-=
started-with-ibm-linuxone/)
>=20=20
> -[Equinix](https://www.arm.com/markets/computing-infrastructure/works-on-=
arm?#Equinix),
> -[IBM LinuxONE Community Cloud](https://developer.ibm.com/articles/get-st=
arted-with-ibm-linuxone/)
> -and the [Oregon State University Open Source Labs](https://www.osuosl.or=
g)
> -also provide QEMU with access to compute hosts.
> +The [Oregon State University Open Source Labs](https://www.osuosl.org)
> +provides QEMU and [Patchew](https://patchew.org) with access to compute =
hosts.
>=20=20
>  Downloads are hosted by [GNOME](https://gnome.org/).

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

