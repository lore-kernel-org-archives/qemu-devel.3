Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940C0C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 15:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtk4-0006Te-2w; Tue, 13 Aug 2024 11:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdtk0-0006Sz-59
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:47:20 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdtjy-0008Gp-3U
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:47:19 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a1337cfbb5so7402776a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 08:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723564036; x=1724168836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LkrkS0J1FXoijWPQPF/2pKx2498EQMIu/XKyV4dQRkg=;
 b=lYDxZTNFZYIwhEPqkQmYzxPYSZWZZTvk/+FXCH9OlVjskUtrvrKbrZZSB26muCqjMa
 GXPF+NHNDDJ9kVaWVBnv4p+j5LgqzFOCHwpysEJBbF7mxkvIZdK+kWHdANdiRg/iO+fJ
 Cn+RCdfa+dQEAZq7M9DKOupVP3woOAuwQPQoTlcKAdWks2G1aB5DsTRNFCP1OO7PowGi
 yzXbtdUaLRulmLJxXmYuJATpSgqwL+oQaCPxIOTniruE3+B7AjAVaBoka2M203LC6/aL
 wZqQ5Dx4W7fDbQAwoRwAIhwrTX76MIoRIQSYeZqnxtwwp4psh9Bkoi2MnrPMyLsTXm2r
 uhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723564036; x=1724168836;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LkrkS0J1FXoijWPQPF/2pKx2498EQMIu/XKyV4dQRkg=;
 b=S2Br8/YPwfoY11ZiVIezNJWCRAFSkZNBrJ1pa5SkTGB/ZvcUkpWnHpBnOhNhB9yWXT
 MK3JUqsDHHhs2m8Wig/iDhopHgWOj3zxMuGa7puN2Xy+QzxgtMSuC7x6I0E9bI9UQVlE
 zW6+l0jg7Mlqy7dNPQ9sf5h0CTuGSQxlAKhO5ok/caEwRQKD5jkmeNJW4cYb3BhWV3NE
 QVvlHMGcs3YazolXZrAJ5Yb/cE5EoPZ4ewyUNCKRwOK79p/uMkpqUJ1E4H2OxablBiZ6
 tgjlYBDFga5zCMcre1N3yivcB8Sq+1YWxB+08xL02EWZthhOxbZzseNLm2lnJ0dYBbqn
 rTbw==
X-Gm-Message-State: AOJu0YwhxWB7hBoC4U4pUBjfe1tmwVdaAYskc9iVIJfn4O4VR4AZtF9A
 MPrsNeqAt+C3bcNbd6HE0n2R5tccU+jItAmN8EiO981aMUuXr7YF51G7sL/Oa9Y=
X-Google-Smtp-Source: AGHT+IHN4mhDzDd/7/WEUnQAB/Ty6sF1qyoggi8CwK2yWzBao/ysV0Jcf5qO5LT/mF7HCwVPQWlduA==
X-Received: by 2002:a17:907:9448:b0:a7a:a46e:dc3f with SMTP id
 a640c23a62f3a-a80ed2c51ccmr289766166b.45.1723564035382; 
 Tue, 13 Aug 2024 08:47:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3fb155asm78425866b.81.2024.08.13.08.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 08:47:14 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E7C6E5F7A3;
 Tue, 13 Aug 2024 16:47:13 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v2 1/1] plugins: fix race condition with scoreboards
In-Reply-To: <20240812220748.95167-2-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 12 Aug 2024 15:07:48 -0700")
References: <20240812220748.95167-1-pierrick.bouvier@linaro.org>
 <20240812220748.95167-2-pierrick.bouvier@linaro.org>
Date: Tue, 13 Aug 2024 16:47:13 +0100
Message-ID: <877ccka0hq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> A deadlock can be created if a new vcpu (a) triggers a scoreboard
> reallocation, and another vcpu (b) wants to create a new scoreboard at
> the same time.
>
> In this case, (a) holds the plugin lock, and starts an exclusive
> section, waiting for (b). But at the same time, (b) is waiting for
> plugin lock.
>
> The solution is to drop the lock before entering the exclusive section.
>
> This bug can be easily reproduced by creating a callback for any tb
> exec, that allocates a new scoreboard. In this case, as soon as we reach
> more than 16 vcpus, the deadlock occurs.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2344
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Queued to maintainer/for-9.1, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

