Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B22C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9l7X-0007PP-FV; Thu, 24 Sep 2026 11:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x9l7N-0007P0-U4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:12:15 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x9l7L-0007Zc-TA
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:12:13 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843f22dcb8so1742228f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790262729; x=1790867529; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+PQR+eqxcVamVNTap4NHUqqpbuQIVUPJcDXrPqwwpbA=;
 b=afNQsE1+jaH26Hv+fZyzYeWcE6ahD1Tg9xbFr1SK80BGguP2J3gk9Br7MZsOvYaNfI
 SZRePxolwF/CdLxT6SUZCb7ooMRpUpDRIoA1KBeMl7bqu7+9Xze6bzOK1P2V0ACBXEpj
 Es75fNyKWiE7HfgWuVWqI8EwWC/jwJStnHPMFuE7SgksLPf8DJ/Wh9AyoYaTLtyf/sWg
 0aqAchljVSZ0NN7nkv8Z6hh/WMXGYyfh0EP4IaZO5AV8yFpnu67cquBq9LINVyFX3Ewl
 o2lnmB9R6qs60HTt0DX3wZLlWR1nuBTNc/CtJ+3GrODxHe0YzEnxX5XAY/umjVIBn9H9
 C8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790262729; x=1790867529;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+PQR+eqxcVamVNTap4NHUqqpbuQIVUPJcDXrPqwwpbA=;
 b=X8Noinj6nCEF6GIjs/G9B/vlF419o8DvuKmvepIcvBNTeFiT6/A2RzLJJ9Mbr76+H2
 oR31I400MKiDbE3HFOGt0EFtyQqIUZxQx1b/1JTgSCPBwP5xVexA5ckm5iDocJxfdejC
 79EOcnL3cSQkzzmEvRchVhgyDlHqr21C6PZYMrJVKyRYT4ir282WYPrGs7urJpBANNZE
 XhctcCb2rfAv7Kc9NTAzbh6ra6RtkM8rJkttN//FgOgF546QUXaz6qjjiHwDsGargnOd
 /8Qe8JdHSADtMgDzYzHmcwmoGKHxsRuLasjnTqTnOC0zfB+HjotNcBr9Dbah+nMxudcQ
 D+og==
X-Gm-Message-State: AFuF++lKiy/E5yz7lNz3UgYvp/vvr/Y8Qpb64x7agEbogNCRPOnhzmhN
 yKWFipEmRdB0WeNgtjTbkEVcKJosaHosChkqAuV8+/zzGwHw8p3pt/zrzHbKEdLV15hO52odzny
 p0hdd/DQ=
X-Gm-Gg: AYBFou1fcgLdgFkwGMK+7hh63C7qoLhuD1g093RMqrOzaYuzIt36XNVDgd51Zp9lTgA
 3eZldpVS1vlvbJrCcKn2tYq857ksAdUZNk6IWhvjX+TRf2dnrwYvymgDZe5r31GW9MV9JzNqqBv
 1TlERIoK8XbwIEsdISESi/If6V+RQQh+VEkz0puuwobG3S16drc184YVtbXnN/Kys+dvPiWho4W
 bnLRnHaN5CpNtl8m4TCjwmIj8FcKKmBVE6QnNBmRzAq+UvmYXSjZd5gE0R6udNYiwQX7KfoVc8A
 wNpdEX02+c8xm4MNL6FCbPBJqkz1X44Ft7J2r622fyLNlA0nbGl1CVva9Xfz6Oj9focq0PC2oVL
 JR55Vw32lzHA+oWCUl3PbEWxl+nLIh1Vgl6DkxxvpfoxZfPdaaawm0clQNYyC8KS6tgHehnJJ5U
 C/mZXmHKBIMay5mw68XaiHrA2Qb5NDjR4S9XnO64skwqK7JJSjNlrSvOHDAoUkriQ6h2mN4w==
X-Received: by 2002:a5d:5f8e:0:b0:486:e737:d94b with SMTP id
 ffacd0b85a97d-48871974c2fmr4649174f8f.51.1790262728797; 
 Thu, 24 Sep 2026 08:12:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488688893a0sm16171123f8f.32.2026.09.24.08.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 08:12:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D0BEE5F832;
 Thu, 24 Sep 2026 16:12:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [qemu-web PATCH] contribute: define clear limits on bug report
 volume
In-Reply-To: <20260924135634.2626603-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 24 Sep 2026 14:56:34
 +0100")
References: <20260924135634.2626603-1-berrange@redhat.com>
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Thu, 24 Sep 2026 16:12:02 +0100
Message-ID: <877bkaznst.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Recently QEMU has received a denial of service attack on
> its bug tracker in the form of 120 reports in 10 minutes,
> and now repeated by another reporter in the form of 50
> reports in the same day.
>
> Prior to switching security disclosures to the bug tracker,
> single reporters have submited 18, 22, and 114 bug reports.
>
> None of this is sustainable. It is an effective denial of
> service attack on the project maintainers' time. Every bug
> report is a TODO item added to someone's workload.
>
> It is time to put hard limits on how many bugs, discovered
> with assitance of automated tools, we are willing to accept
> in a givenm time frame.
>
> This patch proposal suggests
>
>  * No more than 5 bugs per week, per reporter
>  * No more than 10 bugs are permitted to be open at any
>    time, per reporter.
>
> This is explicitly scoped to bugs discovered with the assistance
> of automated tools. Bugs where a human puts in exclusively
> personal time / effort to discover a problem are not limited.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  contribute/report-a-bug.md | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> index b506f9f..8fb7b0b 100644
> --- a/contribute/report-a-bug.md
> +++ b/contribute/report-a-bug.md
> @@ -32,6 +32,43 @@ on GitLab, taking into account the following guidance.
>    triage of their output to validate all findings and reproducer
>    scenarios prior to submitting a bug report.
>=20=20
> +* QEMU policy forbids the bulk filing of large numbers of
> +  bug disclosures that were generated with automated tools
> +  (AI/LLM, static analysis, fuzers). Such actions are not
> +  a benefit to the project, placing an unsustainable burden
> +  on maintainers.
> +
> +  * **No more than 5 bug/security reports, discovered
> +    with assistance of automated tools, are permitted
> +    to be filed per week, per reporter.**
> +  * **No more than 10 bug/security reports, discovered
> +    with assistance of automated tools are permitted
> +    to be open at any time, per reporter.**
> +  * Reporters must refrain from filing any reports
> +    that would cause these thresholds to be exceeded
> +    without first obtaining explicit prior permission
> +    from project maintainers.
> +  * Reporters are **required** to respond to triage
> +    comments from maintainers on bugs related to
> +    automated tools on a timely basis.
> +  * If at any time, the project maintainers request
> +    the reporter to stop filing bug reports discovered
> +    with assistance of automated tools, this must be
> +    honoured.
> +
> +  Ignoring any of the above rules may lead to the bugs being
> +  mass closed without further triage, even if valid reports.
> +  In cases where the filing limits are grossly exceeded,
> +  the reporter's GitLab account may be reported for abuse
> +  (spam), potentially leading to termination.
> +
> +  If intending to file large numbers of bug disclosures
> +  in aggregate, reporters are expected to invest their
> +  time in writing patches, providing the patches for
> +  review, and then further responding to feedback and
> +  iterating on the patches until a maintainer accepts
> +  them for it.
> +
>  * Reproduce the problem directly with a QEMU command-line. Avoid
>    frontends and management stacks, to ensure that the bug is in
>    QEMU itself and not in a frontend and make it easier for

It comes across as quite a draconian limit but to be honest after a 6
months of dealing with this flood I'm less inclined to be polite about
it:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

