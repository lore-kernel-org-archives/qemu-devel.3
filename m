Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9607FC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 11:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVVg7-0003T6-2M; Thu, 01 Feb 2024 06:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVVfx-0003HE-Ue
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 06:56:19 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVVfh-0003aR-Ig
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 06:56:12 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d07d74bdeeso2787761fa.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 03:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706788552; x=1707393352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQg+YxVx7YVUdjzoWcNsVTdniYUBxvxHDaB8H5+ilsA=;
 b=rfSAYEPRaaE7TcvAfsqP3SkrWkLYjuPkmz+1XmWit5vaLIM3LX2qz6m4RycXVVzVDV
 5hlIt4h1vYTtfwg2qHNCxKNaxwKGiPgophzZhehzvecaDx5ENyY4lyT8bkkAHJUC6dkf
 r4wGpDqUZrScqDjwuYyitLdqg/CglJSTtRear+HzuzoIExpclyBYbhxodMhXNAFFaKYm
 WRjz9eXI+qYxTynW62f2rzuIaU92o8kwSVFMlCOM5osn1zq8voOk9EXJ2PQgbCJIuD+C
 jtjyxqnSNN/R9FKfmQI4gXWVYXFf32FktDBQCL8D8Tx+AyZ7++A9BHB7FyxlRIsZInIk
 bxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706788552; x=1707393352;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WQg+YxVx7YVUdjzoWcNsVTdniYUBxvxHDaB8H5+ilsA=;
 b=D9EWWurIh85sm/a+nRk1xlQPqrqpMYQyXOjWvR5ud2hZ7iqujMcJQHY52fLuAL1ijZ
 sfGfNs5rmkdJfiCWvQLgMn3z7EWGESX+6gVOgvgD2csG8az0CxKoGw3gGe0/xJy9/p/F
 W0W6tVTXkisTQLleGiR803WRKo7zvpxBtsYVQsNHxRYcojAHo1pjb9tQ/zHZAyKXQo0L
 UAhN/dQB+H9DTnqW9RjYM/aBfI18kW0lqvkvdJqTaEa7H7QRKf3kGASYhT51sOu36s/h
 pnWEfTDc9Gz+x5iRbMHSkvDkjzSEXJrZKJyTYEXOdk2bTJCjbA6cN/ih51eCJik0ZYU/
 jJpA==
X-Gm-Message-State: AOJu0YxcozyPiK2sgeFnbxbGvVUUJNDu7ozKJF/+CBZVILNP0gE5V4AP
 qBxG3/OgM5Cfr0nRLnsJYwOrIOPsCKs2dY3v3k0Pm07Qb298hvLB624GvCyKiivNOtcpaqGzvRI
 p
X-Google-Smtp-Source: AGHT+IEtRf+AEGiWNM4oCcu+nLpz/NCqAA8/WXp6g+jhNYnH7SPdDFzcZh4+Q5ip7b6hM+nqc3HG4A==
X-Received: by 2002:a2e:a682:0:b0:2cf:1b96:5af5 with SMTP id
 q2-20020a2ea682000000b002cf1b965af5mr1137561lje.17.1706788551911; 
 Thu, 01 Feb 2024 03:55:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v7-20020a5d4a47000000b0033aef37ec94sm9984105wrs.113.2024.02.01.03.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 03:55:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 15D355F7AF;
 Thu,  1 Feb 2024 11:55:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] kconfig: use "select" to enable semihosting
In-Reply-To: <20240129115809.1039924-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 29 Jan 2024 12:58:09 +0100")
References: <20240129115809.1039924-1-pbonzini@redhat.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 01 Feb 2024 11:55:51 +0000
Message-ID: <87o7d0mm9k.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Just like all other dependencies, these can be expressed in Kconfig
> files rather than in the default configurations.

Queued to semihosting/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

