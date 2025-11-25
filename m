Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B44DD0E6F9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNuR5-0002JK-Fz; Tue, 25 Nov 2025 09:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNuQv-0002Gu-8E
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:54:25 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNuQp-0007wb-8T
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:54:18 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-429c7869704so4708260f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 06:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764082452; x=1764687252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzPG+ratvKsStn2we9tXTLSVMfGsBoF9Gw5V0jsTxtQ=;
 b=gJ2ttglwOvB62cBLoL9CHxTn1jLdgyvv0JSVV5Q6CJTFLbvUU0Vbvp6cpp5XwqrROu
 Madnidiy8gf1QfY0zNmR7ixdpwCG936kf68oP86xOQ+F5wuMpR5XH5gpjfy0g6rVqQoD
 3UenUW/MzJMCtgK1TphHmyn8A8qhmpf5rY/e9Hm4n0ZC5QtwglC6sdTvxYX/lCNb4fZo
 /9B9HGrYCOooTPc5eKdBkJNAaBf/3w+moRYp3WxDkxbamE4EjEpzwir9J/MDF9fYPISd
 v5Vo08CpyeJGD5T+xgkZ8j3FiTKlH6FafHkCprdlAhk22ABIJr2vUsx5VGwk6jiv1N3m
 QfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764082452; x=1764687252;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nzPG+ratvKsStn2we9tXTLSVMfGsBoF9Gw5V0jsTxtQ=;
 b=GnV9OE3PgNNWEunnWGLQaWQYvBojzsxCSlNP12CsnZsUNA7T1xWLSVCgG7UKmHq5NE
 jlGlrPtH863vyz2aHwH+NeVk2FNH39WOUiVoclaVmBXbuk45M8aJhoqeQ9jg+YonAhEV
 2nFsSDeE7WLlGDWGnHpO0ytxkqT43+vwu5n0ZPnAPSjlM5M+/LFSwaqo/5rMgLbWZyY6
 iJnhDjjd7fMcfWWOxOAmRChCScKlUS4Cx2G3syEx4LY190Yf0hl5EkDzmpkmtU26Nuc1
 5V/fdb1qEmKCM44w0Plc8JlKELkc+6IeV3An+EZPOgShRmi64IiI73sQC8htlcTBd6dV
 oCoA==
X-Gm-Message-State: AOJu0YyaV8aU7hMf2QR11hRCk7wNY6uPGGJKnlojiMpa7nM0Lq1BDoDy
 yzEh5ZGdnhxv8XJagHXODPhhiMjtQgwk3eIf6YiPpBx8mmxL90wHcvq4wOzXapnMrWI=
X-Gm-Gg: ASbGnctRi9JKPK7FXwMHgsDBDvoBFo2bZTbOb4pZABIbsYnnelufDfuBRE4swXI+kO4
 kNwIoWOmiIkyNhi6qX1RGml6pHtXLti2z5rh6E46S0orwPxgIl5svzkc6IkZMh8z7HlteaVaCJ/
 wMiW/iCjbKYAMBOh43lxN77v8RP3falKvATA7WHDlURWLiBzUxK/s2b1FmMesMbYaOgTNb/Qlye
 UKGw8HtSCum5olQ4hCOE/+/0XnewB21uXP1QMuVf69OKMDp4zq0bmH+Zm17T3O4pJDgYk5RDOm1
 8qiYfaK5nFJlA7tyx8YtVJHp8HZaI88Y63mcjmF78AIjZCvKtOZebAowZ4eAk1lxj/8KypSuF7E
 aodgCc2NVf7qUKDvAqijGjsdyvemLevAoAAHIhO+7vZ8ORFm8WbDVZfgXAUJzwD7ObEfE1zb0Xs
 BqZp2x0tNQz+s=
X-Google-Smtp-Source: AGHT+IHXdUcRDiQ30FeUFTYG7z+NOp2VRMEO2qtTmpJEm+gyeaVqlhCqqWsg7GmO9eElk+vtKOdNCQ==
X-Received: by 2002:a5d:5d85:0:b0:429:c851:69ab with SMTP id
 ffacd0b85a97d-42e0f35a730mr3145287f8f.55.1764082452339; 
 Tue, 25 Nov 2025 06:54:12 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8c47sm36083595f8f.38.2025.11.25.06.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 06:54:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F12A75F7EF;
 Tue, 25 Nov 2025 14:54:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 1/3] docs/system/generic-loader: Clarify behaviour of
 cpu-num
In-Reply-To: <20251125143141.216056-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 25 Nov 2025 14:31:39 +0000")
References: <20251125143141.216056-1-peter.maydell@linaro.org>
 <20251125143141.216056-2-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 25 Nov 2025 14:54:10 +0000
Message-ID: <87fra26u3x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The cpu-num suboption to the generic loader has two effects when
> it is used with -device loader,file=3D<file>:
>  * it specifies which CPU to load the data through
>  * it specifies which CPU gets its PC set to the file's entry point
>
> Our documentation is not very clear about what happens if you don't
> pass this suboption.  The default is that we pick the first CPU to
> load the data, but we don't set the PC for any CPU, so the "If not
> specified, the default is CPU 0" is confusing: it applies for loading
> but not for the PC setting.
>
> Clarify the text to make it clearer that the option has two effects
> and the default behaviour is different for the two effects.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

