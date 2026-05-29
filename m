Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1020CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 15:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSzEk-0005LV-Bx; Fri, 29 May 2026 11:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSzEj-0005LH-0o
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:35:01 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSzEg-00032c-Vf
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:35:00 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6603d8697d2so2030878d50.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 08:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780068898; cv=none;
 d=google.com; s=arc-20240605;
 b=O/19sZuntONNRMCcEdUE3e/IHpi9yintNwcpU0JL+HeiYRj3H75rWhC3EBXOzgrwsm
 mxurQ2hYll/2CBKrJxBubzjv4K8F9D1kDRLpe5StLh4L50Q38HYEEDJERyuFirpNg/G2
 Wyd1Lee1w1fr83QkSiXbJKeaV4MKLPcjoF/WnG12mdzvqcEFezopFO6GvPz0GU/tuehj
 qwmKyv9kMtAJQHo3cEDKRV7732nkiGGRNn4iDY3KwmVKknqiujC6hc3xyDht3LvOfxc9
 ut7EaCGpvyam5c6rZi6VKnQPWG+i+5/8KdmkdPwNyGYD5JradGPHU0aUNpvWcO44lHEE
 i5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xYO5+E35499nnfAEu5cRcG4C0DUT1zGcsfS5pOwAW4Y=;
 fh=Iq8uftMGiPDUdhuTKd4kxzrYLtdT0FOGCyC0ET3d9ZA=;
 b=I/AkYjsIUm8gvLc9pwScraobjTw21HvpsRTpoAhVIWncdr8CkUJ697U0jL28BBPh0W
 JCE24ll8LrxqTC1sL9ioGLgvo3vwrYJOR7L3wXxudTngfqD0X7vR9vzytOO1rIAXYvp+
 IBCXsknxhawXf05Od/spHedwQJuFwXtPr5UQL3bNtXK+k+ybXQe7BIrYiLrCGK+I7LtE
 5UAecN8cuQSntR3s+K6aCEUZMJ8cmHigy/2QMh5GWFl7222E04zWNhmAeswPghuQaVvw
 5pxB99y7pj63aW9L8d4Q6QcDalKjhYiE5+XPEUZQr4j3SE7bJrKjert33Nj8SRheT4Vv
 KT+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780068898; x=1780673698; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xYO5+E35499nnfAEu5cRcG4C0DUT1zGcsfS5pOwAW4Y=;
 b=nF7Xw9NuiglXgnP3nnoa8rOksBtySOvTT0tgvpy2Qu5UUjEdUgW4dMdjj3WDd6FAyz
 mDE3TjJEQdfHSZQGTuXzlv7jDIWgug0sg7dziK6KsMdpAD44MJ29d2BDBiGQHsFpF5O3
 isCw0L1K9xChsGfR9v0Ysc/HKA0+2jG/dqxdOuBBpplL/AEhaJb5PPVbqPTvT9GETz8H
 W/9Re9jCLI7/lGu4j6oi5XHCzvguAkdYLh6ud6ip+UhN5cpqIJ46PF2tOIlLOqKK7B1D
 C2xv+sGezFqik+aYCKP64CFIaO6ihY1xLRbU5v384gmS0O9IEhHDZfSrRWaAwc7uXZwK
 p0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780068898; x=1780673698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYO5+E35499nnfAEu5cRcG4C0DUT1zGcsfS5pOwAW4Y=;
 b=kXIVe6xBoJ42BZTf6jIniVPghn8OG1FnmdTBV8UJeQrWD3hnxrzEGYRkjR2csYdKQk
 ibqkhCe05kNxF04sf18zP4BntkHx1CoYnF/Mf0CeSdpbLcGNAAUlM6qJBNb9Tq6JQWvk
 UnbWLtYnYjW9VpdTbv3cWkbGD4Xukw+J+5tarql4U3ZH/154cgNH3I6lkMs8KZh/YT8O
 xUH1qStyk03p1ZV5d7PsWPjSGJSgWdvFJ6pzVIL+re/DJebWTsCvtS1I2y6hvkNspWbw
 tGzlaznApPQhc0HJgFwPq2tN3Qf9LHNWsqOdX8zuqWBUbyA83lcy7NVjAW6eE6MYogzR
 Q+/g==
X-Gm-Message-State: AOJu0YytV8Vqlvy/ks08kvTWGgf+zcbF440yCC9rKL+55IolFyKkeLzH
 uWxz8eG0sohvJ2phWdy4sFUuKu5X/hBthRDbcV+p8n8U9vlTKhKDCljfJiar2aZGcvkMrhikvvM
 g+Tf1944/kgHxMrpOkbNjpjVRaFjmDVO6gSSavlNJFA==
X-Gm-Gg: Acq92OGDReprWFO3ayyXENXajkx+891pWQ7gsogxtz11qgA1ARo7frfjyn/pR98PV1B
 xQoeALwvBx6B89Hw3tVgZUT9/i+8J26+WXA58Lz/LTTWRfBkh0AcGdwhlv4XObFXJ1e/nKiIXcf
 tpmEAgMkRzmuqzCxcrhwVYzDzP7Kl7IMs/hXsfT4MnLX/OBjKV0EI84IHojGSnX5e3LF/Hgpn74
 rPHN6mdxOV0lSWl+5ogywHoUk6vHMKIH6+CEpOMmWkWdfadw1xK9SARUspqDXy+QmP/AT1Wne2H
 2dXto3jvoOPaxGQIm35RvV4FRkFruaEla/nvxNpf06y8AdydsMSKF+6djrjcbjKygdEOzEbfJIZ
 VeA==
X-Received: by 2002:a05:690e:13ca:b0:64a:ef61:188c with SMTP id
 956f58d0204a3-66052f7a536mr2612871d50.47.1780068897424; Fri, 29 May 2026
 08:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260529094619.1034458-1-pbonzini@redhat.com>
In-Reply-To: <20260529094619.1034458-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 16:34:45 +0100
X-Gm-Features: AVHnY4Kn-UOejuQfmL25KozDAn_MF-VYXrrFhhoWGVXfanXtt_ksjrny2c7bRdI
Message-ID: <CAFEAcA_EWR_MjH1arCdi2y0saZ-Hc7zRAK97YTeEcesVRb9Rtg@mail.gmail.com>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <bonzini@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Fri, 29 May 2026 at 10:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify.
>
> The concern that motivated the policy is unchanged, and it is worth stating
> precisely: the DCO is about whether the submitter has the legal right to
> contribute the code, not about "creative expression".  While the status of
> LLM output seems to be converging towards non-copyrightability, questions
> around unintentional reproduction of copyrighted code are still open.
> What has shifted is the balance of risk:
>
> - projects accepting AI-assisted content have not run into serious
>   legal trouble so far, which suggests the probability of the risk
>   materializing is not high;
>
> - other organizations, such as Red Hat[1], have assessed the risk as
>   acceptable -- though a community of individual developers does not
>   have the legal backing of a company, and even an unfounded dispute
>   would be a long-lasting distraction from work on QEMU.
>
> Nevertheless, even Red Hat mentions that "the possibility of occasional
> replication cannot be ignored".  In QEMU's view, attentiveness and
> oversight are not a practical way to address this; yet as a copyleft
> project, copyright and code provenance are of utmost importance to us.
> Therefore, it remains prudent to only permit AI assistance where the
> ramifications of copyright violations are at least easy to revert and
> unlikely to spread: tests, documentation, mechanical changes, and small
> bug fixes.  Core code that other things depend on, and that cannot
> simply be thrown away once a problem is noticed long after the fact,
> stays off-limits without prior agreement from a maintainer.

This all makes sense to me, except for the part where we allow
a maintainer to say "actually it's OK". Where our justification
for not wanting AI contributions rests on "it's too much burden
on maintainers to have to deal with and review it", allowing an
individual maintainer to say "I'm OK with that burden in this case
or for this particular contribution" logically follows as a
possible relaxation. But if as a project we want to limit the
blast-radius if we find we have to rip out a hypothetical tainted
contribution, shouldn't that mean that we hold that as a project-wide
line, rather than leaving it up to the opinion of the individual
maintainer ?

> Related to this, and already visible in the incredible uptick in
> security reports, is the question of maintainer burnout and the shift in
> effort from the author to the reviewer of the code.  AI lowers the cost of
> producing a patch but does nothing to lower the cost of understanding and
> reviewing one; if anything it raises it, since a reviewer can no longer
> assume that the submitter has reasoned through every line.  The limits
> above work just as much to keep the volume of review work sustainable.
>
> Revise the policy according to the above considerations, and introduce the
> "AI-used-for:" trailer as a record of where AI was used.  The standard is
> slightly different from the more usual "Assisted-by"; the intention is for
> the metadata to provide more information for reviewers to judge the result.
>
> In any case, use of AI does not relax any other contribution requirement:
> authors still comply with the DCO and take responsibility for the whole
> patch via Signed-off-by.
>
> [Commit message largely based on
>  https://lore.kernel.org/qemu-devel/ahXbxzB4C_lr6b0N@redhat.com/, by
>  Kevin Wolf. - Paolo]

> +**Documentation and code comments**
> +  While AI can help draft text, it still requires significant human
> +  oversight.  Pay attention to the organization and flow of the generated
> +  text, and strictly fact-check all technical details as LLMs are prone
> +  to being confidently wrong.

I think the application to documentation and comments is the part
I'm least enthusiastic about here. For changes to code, we have at
least some guardrails on the AI output, in the fact that it has to
compile and to pass tests. For changes to documentation, the
only guardrails are human eyeballs.

Also both comments and documentation ideally are a record of
what we intended the behaviour to be. If an LLM is effectively
autogenerating something documentation-shaped from the code we
lose that.

-- PMM

