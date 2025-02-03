Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA7DC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 09:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tesUD-00044S-0z; Mon, 03 Feb 2025 04:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tesTc-000423-1E
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 04:10:44 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tesTZ-0006HE-ON
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 04:10:43 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d3dce16a3dso7724799a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 01:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738573838; x=1739178638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8IFgjnbLXYUmyCyHgCzhUoZAycBBhgBMbfVJQjv22A=;
 b=LVIk6Qym3ipITCjFIvT0gaOGP2uNa098N8d2ZUDf2lKl9JMUP+Jcgj2tfCbbq5n1Oi
 ujLKq5eJ4fMSWCP51wTkJ0Y+85yuaPd3AGaxSFFfNa8FVGABNENG4nlec9u4z9/stTP0
 sunhd0TukgldnmZS6/XpcSUkqp72oZd6N9kGbbazHvzoYQjIHddInkkSCYcSMsokdj/c
 2WEB+UbupwzJAnURdhjs2BgbygjmEiGPJrIlN4/LrAy9RNJPxnmUtjMDr22mwNNUF1Tz
 +7XSCsoL2QjdGrwbyvZ3u4U5u7EpHkylebOUcjKfrkCCOd4iCfX9WtCHiABjnDQbI/xt
 //zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738573838; x=1739178638;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M8IFgjnbLXYUmyCyHgCzhUoZAycBBhgBMbfVJQjv22A=;
 b=k4ZMEp/hMUbcfnY8CAYV2chr4bEwNVjvV9J6Aizikk6J95LIGfKFhkH9xzUsb09x1Z
 AAqiNdNMLVP7X+5y6Y6iEAgpLZEu6e1AZ3OU6r07q0VMlJhSkTq/5Jm6XquldLVqO+gB
 s5JH4svmextOPiP4Yfh8XzTbkhTDZyJzsbB7wlhf4CdUPwX290MEaKzjLVkp2rDhPsCw
 mMXm8h8zVyc7sFfEU+sRWEP2polpo9afGHPWT00nOQho3fhLPNDdhmax2cr7V28795hg
 0zKCaVPnDp/TxEQo6z0xAS2hnNn1seEnIdkHGRmC40G90pZ4s+8dsVUy1hC9BUvJJzj5
 IdVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhh7/00IcxTxsPC0XaqtYhGTVU8KbCZ5KyTIzGyobWDKq0xpb6PTYfaXu8DYNdnh/DfISwXBlNqGbJ@nongnu.org
X-Gm-Message-State: AOJu0YxlCFPYTYRBi/1rlhFdVWeZAVYoBWyvn3DL4KhGVAc4eJVk9dLS
 fl/oedsB09wcqmscmXYtC5aaqfCg4Rt/HewqIiVXr/qWVYm28v+V/aVn2SAqlFQ=
X-Gm-Gg: ASbGncv6+/TcZVPIP8SLaLPzk+1GeOeLO4IaZPGKOIlRYk1NGz+OxTlaOrcO1F6pGDF
 2F8QevPSLkZd5V1DlCZho+J/jOoCEMwKgc9l6POOdhfu0RyzrUaSaMFVS0BydiVO3AACpd6LDw3
 bOF2tYqAY35Ij4die13w2FDVyIuPdosVk6UdYgo9XjIPK58UBrEaMcpk7x5gEwY0hQ6WECyt85B
 Ksd4k+C/nznB2OT2dj3/x42ybNuujwiiz9E//WWU3sxYKuqeQCdCYO0U6mJ1SKxcGzaDpFk/Kok
 wRnJ5Dtxuv+XME0rPw==
X-Google-Smtp-Source: AGHT+IFZnLjLc1+oNeluVxDYbmtjP3RY2CrlYCWxxhe+2cUakHbXCvLioIAF69W8802SF84hkhV24Q==
X-Received: by 2002:a05:6402:428c:b0:5dc:80ba:ddb1 with SMTP id
 4fb4d7f45d1cf-5dc80bae62amr15083556a12.14.1738573838505; 
 Mon, 03 Feb 2025 01:10:38 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc723e9f9csm7407658a12.28.2025.02.03.01.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 01:10:37 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF1B25F9DD;
 Mon,  3 Feb 2025 09:10:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  qemu-devel@nongnu.org,
 stefanha@redhat.com,  pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk,  Liviu Ionescu <ilg@livius.net>
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
In-Reply-To: <CAFEAcA_CfVfypS5yUtT3V34CDxmAqx7wYnDoKPfHq-o=54GgAg@mail.gmail.com>
 (Peter Maydell's message of "Wed, 29 Jan 2025 12:23:47 +0000")
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
 <87plk72tvr.fsf@draig.linaro.org>
 <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
 <Z5ii-ueFt5-5Brxz@redhat.com>
 <8c0eea44-d0bf-4b86-9b1b-1c2082ab2df9@linaro.org>
 <9bf6d4b0-7a89-4110-a1e1-46bbdb2fc793@linaro.org>
 <c13e207e-06a5-4f40-b319-f4f2e59d919a@redhat.com>
 <CAFEAcA_CfVfypS5yUtT3V34CDxmAqx7wYnDoKPfHq-o=54GgAg@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 09:10:36 +0000
Message-ID: <87cyfzfl6b.fsf@draig.linaro.org>
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

> On Wed, 29 Jan 2025 at 06:23, Thomas Huth <thuth@redhat.com> wrote:
>> So unless someone complains immediately with a good reason, I'm also in
>> favor of marking it as deprecated now. If then someone complains during =
the
>> deprecation period, we still can reconsider and remove the deprecation n=
ote
>> again.
>
> Well, I mean the reason would be that I suspect we do still have
> users who are using QEMU for some purposes on 32-bit arm hosts.
> That doesn't mean they're trying to run massively complex or
> high memory guests or that they care that our whole test suite
> doesn't run.
>
> I'm not really strongly opposed to dropping 32-bit host support,
> but I don't think a thread on qemu-devel is exactly likely to
> get the attention of the people who might be using this
> functionality. (You could argue that functionality without
> representation among the developer community is fair game
> for being dumped even if it has users, of course.)

FWIW random internet poll:

  https://mastodon.org.uk/deck/@stsquad/113905257703721811

26% 32 bit
74% 64 bit

with 41 respondents.

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

