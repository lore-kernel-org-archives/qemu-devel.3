Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E7EC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1p6f-000879-6B; Wed, 02 Sep 2026 13:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1p6c-00086s-3e
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:50:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1p6a-0004Dm-8A
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:50:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b0d8bc2aaso12940355e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788371434; x=1788976234; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QyOibfLIkvxX3VHUscMoeACDdmBr1w7iwyrDHgfNxqs=;
 b=Ux7FIe8i923uRRw63FgA3C16gvmfpiDuTNRY5CBxRNqBY/Opo4nzsND4rjOICMYW8S
 hl41iJA/HrpwbRKiMJ9AFC/r23AdBX1UuTr+ahF4zh7d9Fm4wT8twrwFqZXWTI0zL7lU
 k+7fhHAOe+gWXub1sYN/Pj6dj+jTINGDJhOkAq36zkaQWISelhz1P/OEhHpweCX6tT6Y
 hZLMlDH3W58uAPENx1CZgU1QZwVp/stiXnssqdayGhyDU3LxXKXGO+euVIU9Zxqrw1tI
 drqBfg3xsIBYl1p4Ez4q3zRAGsl5rAUIlF6VE6iOSxCIxgGhFrWzFH7OlKfvMuzK2Ry+
 kfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788371434; x=1788976234;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QyOibfLIkvxX3VHUscMoeACDdmBr1w7iwyrDHgfNxqs=;
 b=gglx2D4VZmgeAtesUfpcHI+L3z7IbH4LG4uzzoBtHmC2IG7iQMARzSVc4Y4nYb0mtZ
 SjMlGLwYvNl7gtf8hZHLFmsbMITA24P4kt8KlLehmdlq74Nxqb9qybr/KcctzuzSduef
 tDeY5p0b+ZzfepkfLRK1gEPEOCAHhCdhjUCvww4DQ9PBBfheH3AIeS1e1sZEf0Bs7vhm
 wBP+FQrFyOupF+v3SIbhAB3VvKI9av03SK6mbcgyVFqGK01X93nYDLsztgahd4BQPLzH
 xp/kty3Oto+WbK0aYrdaNxIhJvQnlC7aG2EneTqXxsmdtSUY1H3rfQvA7S4kgoA5tlp6
 elzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUt6jKmvbikwXa3w+b7280JcgWnKYjYYrind+OgbHNLVFt6xeEJee+FF9mu6W/wfZn6VX9lWjbOXyY@nongnu.org
X-Gm-Message-State: AFuF++lEsWaOY5VQyauDIopl7IEFRLnnExvB38r5kfjEll0QIemy7Rx2
 igbq+gSM5TAM1bman1u45RumsfbNJF6vtnbJPtQXndgwFMItMtS95P/NcmX6Lr+eeNc=
X-Gm-Gg: AR+sD12WnKUIKhmNzqIhk6TdeC6rbcOW8kkkFpYZK2msfIxmUryWGbjR0TY+A3CNT6a
 /53tEISOyOAzMw8bQ4X3afitLdX+6pDMjEThS09nppTNgJF8lKtw2KcrAItcKH7tyb1Z3lSH2kO
 wTehk/dLkPuT731OzyCvEbk7KJQy4pplnHf+apkYSBxQlm85aDfPSvr9UbubHmRzJVvE6el6WVC
 O0yWd+YJVwTRb8d2Q8LUc3iOSPhVsQkNHE4Crp6di3BCyRtpOYA0rSIUqVe21e7yQJ3GDXuas3h
 KeglDAoIG3/erEwp4Ch1YIZdNL48Sim0QyyQQFxRDgb+Yxr+A3KA/eblPGnoq3SJhnektXJt4S4
 tutdIrZL+Gw0NI3iRcbYIaso5uwHMJjvf7PbYay/VJSUwmHDzV/z7yO1tfbuPmsnhtMuozI7yAr
 Vn8RMWOQcfH/JGffywj+rP39p84qm/w0Nv4uE+hOkEO5Lr+j4Bovk4Kxl+RZYJm+W6JB0qzuU=
X-Received: by 2002:a05:600c:4fc8:b0:49c:c96a:d36b with SMTP id
 5b1f17b1804b1-49ce581f269mr124313285e9.12.1788371434502; 
 Wed, 02 Sep 2026 10:50:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm8018625e9.13.2026.09.02.10.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:50:33 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D4F85F85F;
 Wed, 02 Sep 2026 18:50:32 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  "Michael S
 . Tsirkin" <mst@redhat.com>,  Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Kevin Wolf
 <kwolf@redhat.com>,  Warner Losh <imp@bsdimp.com>,  Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH v2 0/4] docs/devel, AGENTS.md: a completely new
 policy on AI-generated contributions
In-Reply-To: <CAFEAcA8s=P6_SUFss9AikhfpLrFOi8p81idM6YZ=De-Z488RCQ@mail.gmail.com>
 (Peter Maydell's message of "Wed, 2 Sep 2026 16:54:11 +0100")
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <CAFEAcA8s=P6_SUFss9AikhfpLrFOi8p81idM6YZ=De-Z488RCQ@mail.gmail.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 02 Sep 2026 18:50:32 +0100
Message-ID: <874ig7r193.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

> On Tue, 1 Sept 2026 at 17:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> WARNING: this is *intentionally* a full U-turn from the previous policy
>> and discussions.  This is not a refusal of the arguments presented in
>> those discussions.  It is also a request for comments, and not something
>> that is ready to go.
>
>
>> Paolo Bonzini (4):
>>   docs/devel: introduce a new policy on AI-generated contributions
>>   AGENTS.md: Let agents know what the participation rules are
>>   AGENTS.md: make the human part of the design process
>>   agents: add CLAUDE.md and GEMINI.md
>
> Could somebody write a short AGENTS.md which is *just* an
> encoding of *current* AI policy, please? I think this is now
> the second series that provides an AGENTS.md as part of
> doing something more ambitious. But right now we have nothing
> at all, which means we have no guard against users who have
> missed our AI policy asking an LLM to generate code that they
> intend to submit upstream.

Can anyone test their agents against:

  20260902174942.614254-1-alex.bennee@linaro.org


>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

