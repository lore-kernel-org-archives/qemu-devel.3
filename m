Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485ACC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNB7c-0001JB-3o; Thu, 05 Jun 2025 09:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNB7a-0001IM-DN
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 09:59:06 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNB7U-00055x-T8
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 09:59:02 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-606fdbd20afso1943952a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 06:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749131939; x=1749736739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUg03zcbNxZ6kqV2FHZ/pzV/KffKuFq0brd2f7OP50Q=;
 b=fjEgi6UAFKdU/7tv8PSM88nNyHQV7e0MIiU503ny28QuNsI1OuMnPFSAy4LMpmajG1
 NPQQdF9swu/btldZXnMgGeffHgIBjiUJIwF2NvxBAj9fjVWO8Ayz4uuSbfgd4UwWmxFk
 WO7dFayR6CfwCfm0z4r7j3WXbM02VObfNpigFfObm58t3L5OuWAt2xwuJxsmyP7Vlbtt
 Lq6LNyctxjLEs8d9wu7X8yYEAsmAQDrollRcGOr7W5ygwHMNrr5tqlVM0T01nrY1gQUg
 +Wzz1mPdOZp/F59gZm0mkwsgLvAbdr0haL2Jace7HGzZrg26Zi9jkMQx6psCa6KHH9mW
 1Bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749131939; x=1749736739;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uUg03zcbNxZ6kqV2FHZ/pzV/KffKuFq0brd2f7OP50Q=;
 b=seHUOPD5QpKabQYdUoKBCmu465fyFTE4zPlGa0+4Qclgo3XdsgKbt/WZKGkYo0a7/P
 YhBpXZh3noy0XMC9YAx8JCW4E+R0hsMLQqjkbwOQTBJW6w70IudjdKFeR6j7zIahRw5G
 5EPGIHgYmZZXnMtRyjDJvN1QFZM73D+xHp6Q44SCcvrKpKd2B8/v4VPf+ToKC9fVhNQW
 +PE6olaGCGPGT23lQSTVGQ97JSxs2Yd9e7rHq0OH0SYyOjJ28SDPDKHJYhGcAFN2/lNw
 85gri094c5Ccsu5hOsXQ+bhYIIOQRgBAg4/kxNDQIcygrTk7kwu8pjii98cq/fGvd2qT
 DLpg==
X-Gm-Message-State: AOJu0YwCT4UMAJLLxKeMplZQeAyATshOGJ5+xpLE4/2aDqM7rMB4lX0+
 3xxdIOre7aIaOUs79vevDaLKzRSCqNhbMvpxQaDUSo0uVfUnxW3oXKODZCvPdV/jyz0=
X-Gm-Gg: ASbGncv34P87+nqLxK+q9NurD4zjsWYEBMrIw5Wk71L02bko1fFGSK0WZAEBlYx/kX2
 aaAZihzm1yuxKRy5qrkbJJ+w+WU/DpjKFF/udIdf5bN3m68Ibti4JubJnen9ERN7tDWngoTLShb
 tEkuFVvaH9eQlTDA+344epkqVle3a/eGsTmNji1trSx2VL5yEgOtbUaSm9eEmg5+yS71cKcZh81
 HfCMCy1PTSeurB1/0+ydtsvq6ViirS+39ijt74bL8ygFe8YXkYj8Egz9uAUPo7G4XhfrQG6qKTd
 vwP5SzPoBVlQfc5E7hFFCbdVuBEt+uYRCbjZV8uhq80Hr1GH6dkr
X-Google-Smtp-Source: AGHT+IFvS48CMm0W7XpgNc1n35yUw1W4A+uJE4wq5bR/PMbxPq5dq/c1DoeyNE+0rOqK4jOsA9+vJg==
X-Received: by 2002:a05:6402:2684:b0:602:1d01:286a with SMTP id
 4fb4d7f45d1cf-606e944ee43mr6771155a12.6.1749131938702; 
 Thu, 05 Jun 2025 06:58:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-606f93ae786sm2210158a12.24.2025.06.05.06.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 06:58:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 486315F782;
 Thu, 05 Jun 2025 14:58:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Alexander Graf <agraf@csgraf.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Stefan Hajnoczi
 <stefanha@gmail.com>
Subject: Re: [PATCH v4 3/3] docs: define policy forbidding use of AI code
 generators
In-Reply-To: <20250605105219.261925-4-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 5 Jun 2025 12:52:19 +0200")
References: <20250605105219.261925-1-armbru@redhat.com>
 <20250605105219.261925-4-armbru@redhat.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 05 Jun 2025 14:58:57 +0100
Message-ID: <87y0u65ly6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> There has been an explosion of interest in so called AI code
> generators. Thus far though, this is has not been matched by a broadly
> accepted legal interpretation of the licensing implications for code
> generator outputs. While the vendors may claim there is no problem and
> a free choice of license is possible, they have an inherent conflict
> of interest in promoting this interpretation. More broadly there is,
> as yet, no broad consensus on the licensing implications of code
> generators trained on inputs under a wide variety of licenses
>
> The DCO requires contributors to assert they have the right to
> contribute under the designated project license. Given the lack of
> consensus on the licensing of AI code generator output, it is not
> considered credible to assert compliance with the DCO clause (b) or (c)
> where a patch includes such generated code.
>
> This patch thus defines a policy that the QEMU project will currently
> not accept contributions where use of AI code generators is either
> known, or suspected.
>
> These are early days of AI-assisted software development. The legal
> questions will be resolved eventually. The tools will mature, and we
> can expect some to become safely usable in free software projects.
> The policy we set now must be for today, and be open to revision. It's
> best to start strict and safe, then relax.
>
> Meanwhile requests for exceptions can also be considered on a case by
> case basis.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@gmail.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

