Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDB4C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LVd-0005Pf-Qi; Tue, 01 Sep 2026 06:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1LVc-0005PG-5o
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:14:28 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1LVZ-0001Yr-5x
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:14:27 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-836cb2fa1bcso43105337b3.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 03:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788257663; cv=none;
 d=google.com; s=arc-20260327;
 b=Cxscwm6k3yWHJwlbLJl8O0lyl5bmfZl7JB+7PgtkdcWjTU9GMezxUnNJqWrvU4DBiQ
 yuvyhJzj/rgm7cmCiPHyUE3Q1ubwxd5jsKAml4niOPuW3uO0W9bFXGpI9ebl7qVe3NjU
 eH6l5tRaYMTpwv1gvzLf2wH8IWEeKsIdYfu/Op14X8+yaIhqyl7bUCdYbm7dGXb97JUr
 cZfEPZX1IJ91TAWpd57LNhVWMxFxgYNhUfQIHlnv0I5tforS7l5IMkrE5m2KUahEvkZz
 URqvZljnm6TTxOboJ+SotP9qlwnVdzTq/K+qUYSlQjTW7UUveqmRoe1ks0KoOguOntDG
 vLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KnNuzHTlFW19LATbQ4M185tMctY24YSTtJ2O5qH2bgQ=;
 fh=21kckvfCsPMogHS8UiR7ok8RY3qQQJ9OdcmVsCccRHc=;
 b=gYo/jEbZZin8lBXGfyVlRZnW0u4BaP1qtfFNxAHtTmvnZNMalI02tHKceRix3YCLpm
 72EBXVE9VDi2b8nQN6oxgolXiSKyYMpmhvVBUUborvqVpuXissSp6jHyfLvy7DyGnjV7
 fSSZtK/oNFVQf2c7502Ycqu5+T+z1KtwJI/pDTBqIkEQyEZ5J3kvl1SFp1nDfe7e7bhw
 lD7qesQbs7DK7MHpQYW4vK0gR9DNHsdVCb5vbSyKCskTD3JOJlIHUYxSwFeVYQ6msv/n
 k9vCgTVIpbEuL+/0iIEYfw3R5Tqlg8HVZQkUWkrUGf72KPHNXnIns7BZLh7FnrXWSolR
 jj0g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788257663; x=1788862463; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KnNuzHTlFW19LATbQ4M185tMctY24YSTtJ2O5qH2bgQ=;
 b=o9Kmj3ExRsB3RGiHocDQYF7uvbP04Q+YpA9gFQZlmdhsjZRhllG9GFue/61HZTqi2c
 JbM3Z5iUlddM0z8oOukJYcroV3Z8tMLVWS80KTl7ysHGxLGxSwB1El90MKLUYQG4nPcE
 wyqFGOC0XeS2kkLlz0V1/eLBSjJj0JRu61AUhck6oB7yxK9V4xghU6pDGums2Nqugn3G
 x+QzG4B4A9mPZcUm1PQd4hQ/fZ9va7OlX5+IRYZ32m8QsLvWasJkKmxYv+3ddB3meoRY
 FDv1TKq9ksnzyCHenXLTJZG/7WiqkMT8ji+5uaO8jK1MIxcwPkLfr2D5Fcrqe8Nig8WG
 vmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788257663; x=1788862463;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KnNuzHTlFW19LATbQ4M185tMctY24YSTtJ2O5qH2bgQ=;
 b=eLPkUVodUX3gqqIkkmOyZpAC5Y88iYImnkaqNjyYUTlb/j6QP5zePLiadqAFry1O4/
 F2wwGu30DgctuUzpI1Mlp7Do8/t1CATmQDybKQ/qXhuu1+ey4q5BQnKV+wW8pTnGA5rn
 V9d5NCSa1qKBWqtO9j/2eVMD+vKbvcPcfjcOeA55SSeAt2VlwF6a1FQJ/123GHfJiQEC
 y3kdY/kcM2b02UfdOwOsLhF37xT+O4r/Y3hpGYaZCGeQe3nhNffWbT0VmPbCN24S1jGn
 9W/gvJfG57ir3jCwFARZHGYnz8vQg3N5aGTVN6E9oCKGm7CxtQ0yi0UntiWYZu2fdCqh
 XeXw==
X-Gm-Message-State: AFuF++nEaBC3SC+iuSPHMMBpyvAyqk4GlktLf8LGgFg40KGniHyGnebj
 mrlpV79vpZsfvfRgh83XIR24W6bR347oVOMHFJLJIJPtXViZHbFxyTA2nMdMfLy4QCAtJerW/fS
 yG3DUAELmij98hGmGk0RpRGiQcGViY+kh9hV+HadQHQ==
X-Gm-Gg: AYBFou3yZcJvNlHiLucIADo7oh/+gr9MetBXA7GN1yP58IyI/Wgp5PaN7KLurPn4qck
 ozMk5MG9NYaS+sFSilGbghn+49bdz00kH+e66BrfCCiCdlQH8UeJ2hfiZA9eX319sMCLeuY1aFp
 pR1qlh+cAK58AnEvUZKWzSR9KsjqNzJpB4uAfARUkHJkb0wU9u1A4zNapA7/aQ6PhLgPReQmRFl
 DsMIyHOWVoHsmU7icQQPfAiMWSvOMR7ChywqV+JO4dfyYuiR5t6RYcnlNs1XVxFQw8J38qz5xGf
 eJjVkmcPdxF2zVGOyIwcnr/x2MrtzNEzd9xgitehNg4d8ekKqL2TSbbTqUvTOC+ETrLfZnnCjTl
 /epZsXwNy5jyfQUq6r7m+7uddDdLGkw==
X-Received: by 2002:a05:690c:1b:b0:860:a41:cc74 with SMTP id
 00721157ae682-8600a41ce3amr103545157b3.20.1788257663321; Tue, 01 Sep 2026
 03:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260224181440.832943-1-jsnow@redhat.com>
 <20260224181440.832943-8-jsnow@redhat.com>
In-Reply-To: <20260224181440.832943-8-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 11:14:12 +0100
X-Gm-Features: AcwNN1UIe7votucxA_21qLaryygIMyk0KO88ZveTMcKZ_qI5ruumopjStkTyJow
Message-ID: <CAFEAcA_r9n9e10WWqikiNwocrLPTDEofk8gxpi3_7RuA5yu0-w@mail.gmail.com>
Subject: Re: [PULL v2 07/19] iotests: tolerate being run outside of pyvenv
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kyle Evans <kevans@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Warner Losh <imp@bsdimp.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ed Maste <emaste@freebsd.org>, 
 qemu-block@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 24 Feb 2026 at 18:15, John Snow <jsnow@redhat.com> wrote:
>
> Modify the iotests environment preparation so that it can detect when it
> is being run outside of the configure-time virtual environment and give
> a warning to the user, suggesting the use of the meson run script
> instead.


> +        if self.python != str(venv_python):
> +            runpath = os.path.join(self.build_root, "run")
> +            cmd = ' '.join(shlex.quote(x) for x in sys.argv)
> +            print(
> +                "\n\033[93m\033[1mWARNING\033[0m: "
> +                "iotests is being run from outside of the configure-time "
> +                "python virtual environment\n\n"
> +                f"current python: {self.python}\n"
> +                f"pyvenv python:  {venv_python}\n\n"
> +                "Individual python tests will be executed inside the pyvenv,\n"
> +                "but the test runner will continue to run outside.\n\n"
> +                "\033[1mPlease use the meson run script:\033[0m\n"
> +                f"\t{runpath} {cmd}\n",
> +                file=sys.stderr
> +            )
> +            self.python = str(venv_python)

I just noticed that our CI triggers this warning, e.g. in
the block: [parallels] job:

https://gitlab.com/qemu-project/qemu/-/jobs/16226916350

WARNING: iotests is being run from outside of the configure-time
python virtual environment
current python: /builds/qemu-project/qemu/build/pyvenv/bin/python3.11
pyvenv python:  /builds/qemu-project/qemu/build/pyvenv/bin/python3

Presumably something here needs to be fixed so we run our own
tests in the way that they expect to be run ? Or does the warning
need to be adjusted so it doesn't complain about the difference
between executing the same python as "python3.11" vs "python3" ?

(The actual failure of the job I think is unrelated, it's just the
reason I was looking at the log file and noticed teh warning).

thanks
-- PMM

