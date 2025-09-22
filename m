Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC258CAC5AA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gBe-0005lV-4J; Mon, 22 Sep 2025 09:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0gBb-0005lB-C5
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:02:31 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0gBY-0001zp-R9
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:02:31 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46cf7bbfda8so7797625e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758546145; x=1759150945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJn90MU8veDsypxIGxdBbWc2vD6fzNI61Rb4fm5v2Z0=;
 b=fzFyp0HYgPoi2Itx0emCbgbbVDbdE+bWSOq0iGpQ1p03Gx5sg8CpHKvZ1+NczpDlf3
 7pKUVq7yx91kL10a497v+55EpIgHNmzg5kMQ1onDthmU6yK1rKxc024JFs7/BUAtFnM5
 UrX19l3JClDQdb2y7avoIxFppXpyAjzysLe/hOvdUrKFowBLVZydWEM9rnfEQMpvpS4V
 Fs/npMNbDRmIMHCVXdY8uFvRQxiG9yFIRx+GShEt53xfwTZoY6lW+tDfk2TyOWCJcmcZ
 H7VGd92W/8ZZ4tPoVEd7J6eFCAxrUmu3rK+1TecCEL5cAH00irqPrnNK4CaZ6eibLx/A
 5bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758546145; x=1759150945;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GJn90MU8veDsypxIGxdBbWc2vD6fzNI61Rb4fm5v2Z0=;
 b=JJfZS2jJ30uNKDVVNqTdyKNvSEecFOQs356Ti8M0OLUfQpKtPMCxr5joummWU/qox1
 wsx5G7r29G48XfQFfc9ye8rA+v3gEc2eBmdyC1urJqdYPCoPOBK3ZOly5xMEeBKAysNu
 QVg2U4CP3pBYa3Xkod7VqOlm3CPajXJYsPdLYbcNW/7eET8dQgE5TDrDZp/b5/gdw2jw
 RhsYpvQZNI+a8zwycR6eb02JLKg5s8gXotXokSLWGbTrhQSk94CAiWk9jVm2g9IJmdyO
 y+MPCTooFqWZoRF4Z4giQI3RFeI8o+zTtgs2BhPAjU0xgjIA/C2eoxfkBBJaxiBlkXz4
 +6nw==
X-Gm-Message-State: AOJu0YyJDOqmQ6lHcAd17KDZ76ELc+1BdC+RU2pAeBpSpiSLHwU1rwBJ
 4SflJFuUqQ2mfjKoQM1PfsbX5coao2IImjehtg5GK55Vp7zJ/cnwZ7x2qaKlj1eylMM=
X-Gm-Gg: ASbGncuVD7oREPCQOQtvwzcwDId3yADa6jjz7drPqkIY0X6gTongs2RtoxwJRKIJdZE
 gllkPt3QUNrQXe5WR+56Ye8HpDfylPb4Z6awaFWwp+gHglmFrPceg66ga4rX6vlVio4VWRvXb+o
 BKcWWijNLiZgg2jrPLqoHgtF+7mXUHnNn7G9aRun56MV+97tHu5Cr8TA0fFQyyADjAysWWblG5R
 4j67mxUs5PgDwMRYNn9SlN12hNajy8oQ2FbMOxdqK/7FiLnT3fUyACYkTQxL5m/FE8+vX8caamH
 oL8gyl2u/vtbqK5cRoUoS9ghc8PVCP3LWZV/MssOj9VVfR4g0FdoJFdrDiGMsQ0JjwMcUbKTFSJ
 oP9k2JgkqJdoS2kJnT/aQCrAK9EqbdvYtsw==
X-Google-Smtp-Source: AGHT+IGxzDoeceFiwysoFacxDtKTA7msm64IqLQMxu2IIk0znNopc/ZcoAM1LldekNGxitdSL0ImHQ==
X-Received: by 2002:a5d:5f82:0:b0:3fe:709b:9d83 with SMTP id
 ffacd0b85a97d-3fe709ba193mr2498909f8f.13.1758546144709; 
 Mon, 22 Sep 2025 06:02:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee073f53c4sm19889504f8f.3.2025.09.22.06.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 06:02:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E0E45F7C4;
 Mon, 22 Sep 2025 14:02:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH 3/4] docs/code-provenance: clarify the scope of AI
 exceptions
In-Reply-To: <20250922113219.32122-4-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 22 Sep 2025 13:32:18 +0200")
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-4-pbonzini@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 14:02:23 +0100
Message-ID: <874isuod28.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

> Using phrasing from https://openinfra.org/legal/ai-policy (with just
> "commit" replaced by "submission", because we do not submit changes
> as commits but rather emails), clarify that the maintainer who bestows
> their blessing on the AI-generated contribution is not responsible
> for its copyright or license status beyond what is required by the
> Developer's Certificate of Origin.
>
> [This is not my preferred phrasing.  I would prefer something lighter
> like "the "Signed-off-by" label in the contribution gives the author
> responsibility".  But for the sake of not reinventing the wheel I am
> keeping the exact works from the OpenInfra policy.]
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.=
rst
> index d435ab145cf..a5838f63649 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -334,6 +334,11 @@ training model and code, to the satisfaction of the =
project maintainers.
>  Maintainers are not allow to grant an exception on their own patch
>  submissions.
>=20=20
> +Even after an exception is granted, the "Signed-off-by" label in the
> +contribution is a statement that the author takes responsibility for the
> +entire contents of the submission, including any parts that were generat=
ed
> +or assisted by AI tools or other tools.
> +

I quite like the LLVM wording which makes expectations clear to the
submitter:

  While the LLVM project has a liberal policy on AI tool use, contributors
  are considered responsible for their contributions. We encourage
  contributors to review all generated code before sending it for review
  to verify its correctness and to understand it so that they can answer
  questions during code review. Reviewing and maintaining generated code
  that the original contributor does not understand is not a good use of
  limited project resources.

It could perhaps be even stronger (must rather than encourage). The key
point to emphasise is we don't want submissions the user of the
generative AI doesn't understand.

While we don't see them because our github lockdown policy auto-closes
PRs we are already seeing a growth in submissions where the authors seem
to have YOLO'd the code generator without really understanding the
changes.

>  Examples of tools impacted by this policy includes GitHub's CoPilot, Ope=
nAI's
>  ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
>  generation agents which are built on top of such tools.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

