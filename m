Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FF9D32D96
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXav-00011h-7v; Fri, 05 Dec 2025 10:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRXab-0000wv-NQ
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:19:23 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRXaY-0002nf-Ve
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:19:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso21849895e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764947957; x=1765552757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqKjTbWjcxZgKeHqWJxvfn7jvGBAh8pXS5IS9GM/Ulw=;
 b=iWOK5qLkPk5i//9nGjyuqbrhcow9raViFt0dueow9xry5Mkk+5qp5AP4/gYk2ijchS
 j3FOJcQ575aMUsRl/7BVVaqS5Gop/115rtAlC6LOlDrPdZ68RJrCbRw8Wmcsbj3f3AuV
 PSdwPLPEgpnPZ5CCig94GwCxioZ1/pi1YsZJOf0MTVvCzJt8OVY/eQ1DWLMZDmCntcZ+
 XM5AOPkXfVf5OHa0jnp4htWgpP05ty/EP+srNCeKK1fzTFdOzG5NNrnsJVYi+O2VGNFX
 fYwNc0wOv0LdD11fv9TnDyQpmYsqLh0ZfhK3UeysZ86zA8jCiFlwxjHmRle9LdY/02vX
 Lb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947957; x=1765552757;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pqKjTbWjcxZgKeHqWJxvfn7jvGBAh8pXS5IS9GM/Ulw=;
 b=lpJ4ndkaBjhT0AqG7lpccT4TVDbWYlV9mPgDHIEp3qUfSKABoETSMeppr79jWm7qlO
 IVkg4guplPc+BArsGsF+8bV36GlfxyDYUvXd3G/2niCeL9r/A++5H0qY/D2WYi0qmXaF
 zUHtXloN5OCZ8HfLfCnX1X1ekEeBWsvwZmXKjbM35SJ5FFD3TWTOoxkBR1Gt2p+zHpyq
 fVHPPJxf82bbjazGg8sNZfu5KV1C+WQN/ZP1K6I8LIqYpSrnksVT9Ur0+i3HlWMfD7mw
 ajg0a+aGOKCuKX4jWnWK78RD+xm4fAl+PQU/SeElBBMflX1OhbO158Fdcc9nBqYThQVQ
 Rsgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJBddPBWWrXeRFMEEApzEvVvKv2Wxf3lfMqRToD4uXyA2C3Liq5Fp5Ox9rp0SReEPqD1c8wCcp5pyv@nongnu.org
X-Gm-Message-State: AOJu0YzMqFhsl2s/E3GTJnDTQ2HXIeevM9l3TnqbplQeCQy/C4wURGjZ
 mXKYE7PEItJdNeyKhHknShw4ZViAn/nt7e/3TwbBem/xRtcH/NbfuZScx+zCstcD0Ls=
X-Gm-Gg: ASbGnctpdJB0St9Ne8hxKB4am4Aq3thXmxAxhoAVG4Rpz/Ps1fpLOGf/6EZ2xf8t/1P
 8AjFAbRdU4cD8QZt4WgSWnLpFWW0nJrGcgEvA8vkiIxTEMEDuUyk40maoVIJ8GkGwwHmuyh3fdZ
 k+ItXQHEwMgakEkJBwR1CyqpER+Rpr62RSUdC3oinTW9uNjh3bO3l4zJ3vEWSxh0zT5dqqQNDwV
 mGMlNVS3fRkrULw9nOhbm0wIEuOBr8SksX4Y5uCY+Y4ipaQZFWoKET650B9lBFkVLuFT/ob+xKf
 qIGhCKSsazandI3/audITKpj3qXCnf5pGeQGOoOuSX7lDAdELe8phixc3KRakjSesBt6h4aey+Y
 vClWXWuREEesVEzmy5Ox5aGXI+DFihGFnQMVhKNYXaPmrHiNYsvTuZLhzBtZKC/Dimd1J6gU6dr
 G1+xkP/9oTx6sZ0FyqCo6xRg==
X-Google-Smtp-Source: AGHT+IGbh5nMGdxvi3hlugWCViWFUfqVJ3JHspuMEvWqOFqkdy2s8KUOmL3kEoI/d3/2fvDvHR8MmA==
X-Received: by 2002:a05:600c:2f97:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-4792eb1a02emr56026355e9.8.1764947957417; 
 Fri, 05 Dec 2025 07:19:17 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310a6d9dsm87943635e9.2.2025.12.05.07.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 07:19:16 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 297A85F7F6;
 Fri, 05 Dec 2025 15:19:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qemu-iotests: Check for a functional "secret"
 object before using it
In-Reply-To: <20251205130014.693799-1-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 5 Dec 2025 14:00:14 +0100")
References: <20251205130014.693799-1-thuth@redhat.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 05 Dec 2025 15:19:16 +0000
Message-ID: <87y0nhq7m3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> QEMU iotests 049, 134 and 158 are currently failing if you compiled
> QEMU without the crypto libraries. Thus make sure that the "secret"
> object is really usable and skip the tests otherwise.
>
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued to pr/051225-10.2-final-fixes-1, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

