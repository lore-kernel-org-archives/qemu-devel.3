Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE7ECFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 09:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxkW8-0001OV-OO; Mon, 07 Oct 2024 05:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sxkW6-0001Np-I8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:59:02 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sxkW4-0006fi-UY
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:59:02 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a994c322aefso185149566b.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728295139; x=1728899939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hFSWfOa+YvFLhvTLy01OtkwcwFDP+uGo6d+bULQ2/a0=;
 b=rHdz3OUbauB8QLybwLDWqn1shx5kdrPqSv6ZDY3ToOBzM4OGteaBSASXO5L3Uh8Odv
 iqGYKgtcxgDUVfnCOJ8hai7dFl27BucUUdi9w7hpivqpnKL+JQlAWyVC99fRVbXTKEmL
 KB5pUvQP52LrKZh742E1l87wOoayAlk2xVGI/JOO2v+g4GooqOZg7UBbW0s0SSlczQuh
 VdL1PwrNmAeGi4Y7ODyh1Mfl5w/7ev0muGwtgkB6ZHJABOEhVwrhJtBTff4YHcJGxL/H
 Z2dAOCB6gjUxHq7G9oxvCTIv+BxcG8ntIulF+G/VbTFJT3XuuPSZo2B3fXSvV3mpgUn1
 BD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728295139; x=1728899939;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hFSWfOa+YvFLhvTLy01OtkwcwFDP+uGo6d+bULQ2/a0=;
 b=LgG5aY4baCCytwS0PvdM9Znes3MIDFU7ZPwRT6Gvh9Uog6ObH3tRmKWBnnHYgm7c1a
 GdC0DbGgFZNEaWVYxR7nJ9ZfLgCIJpAAHqY+BhTw0JwHy8J0/90d+HnWe1EUXTHUDpa8
 uUcfoORE8p03hOt0MdkgRPZQsAOBnLtoe00eNCwRDx1nGgHs3ncwTUss7/IhdPIqQjEa
 YcbJXSSbfJ+QnjeO/w55bm2rld1CzvYbfcwlj15Hpxi73HVBOUNLUMt+H6J9Z5iiFZ3j
 jHil9WEl6Od9D61bUQtELg398uCGDmMkDQ3Tur1ezSv3dz16ct5qt0Kz+lDKY3y1K5OZ
 3MCg==
X-Gm-Message-State: AOJu0Yx9CzinoVf22hfIgSPvnMNBCf2HYWxz+uAQ8PTFHX1gjMDw6siy
 hKKrNqeAwPf+glhw6FoQ9tp9t6clARwxtE8M1lljItxK0hED4MoHpAeStYKkjVw=
X-Google-Smtp-Source: AGHT+IG65qXj4Koi5pZwLyEPXkjAtcazG3RQu/qgd03GiED5ip5hp7iEN3BXYfoD0k3JtAKvcQtlvQ==
X-Received: by 2002:a17:907:25c7:b0:a8d:4cec:fcec with SMTP id
 a640c23a62f3a-a990a21d5cbmr1657414466b.26.1728295138999; 
 Mon, 07 Oct 2024 02:58:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05f395esm2989533a12.84.2024.10.07.02.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 02:58:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 789D95F875;
 Mon,  7 Oct 2024 10:58:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v2 0/2] meson: ensure we enable CMPXCHG128 on x86_64
In-Reply-To: <20241007084342.1264048-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 7 Oct 2024 10:43:40 +0200")
References: <20241007084342.1264048-1-pbonzini@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 07 Oct 2024 10:58:56 +0100
Message-ID: <87y130w7xb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

> Alex discovered that CMPXCHG128 was not enabled when building for
> x86_64, resulting in slow execution for wide atomic instructions,
> creating a huge contention when combined with a high number of cpus
> (found while booting android aarch64 guest on x86_64 host).
>
> The problem is that even though we enable -mcx16 option for x86_64, this
> is not used when testing for CMPXCHG128. Thus, we silently turn it off.
>
> x86_64 is the only architecture adding machine flags for now, so the
> problem is limited to this host architecture.  However, the problem
> is generic, so define a new variable for all the -m options, so that
> they can be used for other such tests in the future.
>
> Based-on: <20241004223715.1275428-1-pierrick.bouvier@linaro.org>
> Supersedes: <20241004220123.978938-1-pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

