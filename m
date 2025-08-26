Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96180CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 12:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsO3-0004yq-0C; Tue, 26 Aug 2025 08:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uqsNf-0004kb-IP
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:02:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uqsNR-000524-JI
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:02:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45b629c8035so11330265e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 05:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756209727; x=1756814527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oWYxQE1xA9zM1fslapkRH9/o5p8p0SBqOfminunBLo=;
 b=J/XvP+wsV1GX7EvKOwPJLMnHtY1YnhkOh3GGxRtvSBkmj9yJApOGVRM0jUoR3/rf3z
 6eqyuhkm84gGB5tP5FKtE1R0VabjYonWnssa7akkugS2kmS2kW8kHvyIqqPK7b/aGrMO
 +mFGD0/8b6WoNkWkt6mW7AhuwTJWxeTShckr7YDkr9fKHDFyJql6X2MJtfUYrf5aeht1
 4cLpupQsYVV3pCObedGr9Ohyw8VnW6sdYtssRaMblDowqbkqyrLJEaOiIrjnXrd9ToJI
 LHN3+bLeGfRal4nurTuQF5Z14HAFukFAwk/zR5rXOR0FvC0+nEYqGXkrV48NHEMjfkY5
 eRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756209727; x=1756814527;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2oWYxQE1xA9zM1fslapkRH9/o5p8p0SBqOfminunBLo=;
 b=R1xH2okbjW7166yDNGksSxmSyK8aXhUCelLZg6phqCCa/v//3B8ypupZnExaJ51NIK
 MOviJx5XBeGSwx6NciTkEavb8qoQwE0SaZdH59AhFARIYy0XV8ehAUUYwAMlGvV5oe/C
 ofyoC6BG//HuRX8LgSEKrAV6/NTNvJ+HzddD4fGQpfgCeAxkZ0XBQbJkuyVTARqmqZ+9
 JFFDDPZsmmQkhHFkho9lIdAPDKVbk27CMjCPVQ6cb63UuGsEO8Mgh3F8A5UVZa5MuIFe
 5+Mcv4gGnxytlsndhukfrCxQ/NL8aKTN5pLoeiw95GxZDMcAQ/Rhm8QU+K/TkBl9iY1d
 IsQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQSSn5cvqXxVdKV9ZcCXdue5RtYB0fOvLyBavnPyvhUdmWTvijqDhu34nQuOgr3AT8iF2cjUyydgmG@nongnu.org
X-Gm-Message-State: AOJu0YxMUREb0GBAY+ULt7PXGfc9fn4eyzc1vTtvvcc60rpsEjkNikZC
 Je//ai6IMpb6cb48PrxxQE7J6vjWfSP4UTSd+DB6TxXtR9kahlL7z/woFerrCkYIiLk=
X-Gm-Gg: ASbGnctfSWSkUoMJaESxKzGodjnIVY76n1XtMSTCikQ74YwOqRBLtX1zFy4oSW4y1iJ
 jMFy/auFRKmFX8Jd+dEBifF053xERdy8fZ/uJ6IguOUDvU+zNWBS4PulKTAR4J5jifun9fbvFmx
 Huzf+fw8CZZsLLeK4bHPLFvWm9RZiQ50sE9J9jM2KMY9f8m7RXMlniS4kfo1iPddv4XkSMd82vy
 A81iTGFJgHhYQ9wic0/X268f+1rWzFF+OKm/CkVPcJ5Rv9FNVSPrF5SYv0hUm5g/jGE8s6S+kR2
 T88JJbXaxHsXqN52IbNeer0mEQ4pjVsVfvEG+5KgC6jT/LGRgkXaHTCfOWgc01c8ZepWE4diiVK
 K+q2MgzgsFEdwUpVKU77EXC/5osQPeevJJg==
X-Google-Smtp-Source: AGHT+IEyTsigtZPgbhvpx+MuI5EopTwKZjdoMifD1NTSeNO2daXO9CQzMNBjpRdj5UTuY7k2V4tUsw==
X-Received: by 2002:a05:600c:3b04:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-45b517e9d34mr148656765e9.30.1756209726803; 
 Tue, 26 Aug 2025 05:02:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66b6985bsm14737615e9.2.2025.08.26.05.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 05:02:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E51785F80C;
 Tue, 26 Aug 2025 13:02:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 richard.henderson@linaro.org,  kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] kvm/kvm-all: make kvm_park/unpark_vcpu local to
 kvm-all.c
In-Reply-To: <20250826132322.7571b918@fedora> (Igor Mammedov's message of
 "Tue, 26 Aug 2025 13:23:22 +0200")
References: <20250815065445.8978-1-anisinha@redhat.com>
 <20250826132322.7571b918@fedora>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 26 Aug 2025 13:02:03 +0100
Message-ID: <87cy8i1ebo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Igor Mammedov <imammedo@redhat.com> writes:

> On Fri, 15 Aug 2025 12:24:45 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
>
>> kvm_park_vcpu() and kvm_unpark_vcpu() is only used in kvm-all.c. Declare=
 it
>> static, remove it from common header file and make it local to kvm-all.c
>>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>
> Reviewed-by: Ani Sinha <anisinha@redhat.com>

?

I assume you meant reviewed by Igor but I'm not sure what b4 will do
now.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

