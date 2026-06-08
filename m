Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7BECD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaCI-0007TT-JE; Mon, 08 Jun 2026 09:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWaCH-0007Sf-5e
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:39:21 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWaCF-0007Co-Bt
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:39:20 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-660e9fe3c3aso1945443d50.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925958; cv=none;
 d=google.com; s=arc-20240605;
 b=VyIxJi4cpw0mtA2jRBLpDSq3fQySPCa/A6kbYtOTB4SDnVKwYhCAxLGq4jsxrqdhfc
 ISGXqihtNarTvLiJKtvzCrtAEusGzW8HR+WpLpN6gz5eXzom5VgZY6W6TKlAM7qhWruQ
 i56EJVDPf5oaXXhRaV0oUdwruXye3bQ7USIH5zyYVG98aO3qrftfEnGmlGfp3X6Z/0r7
 f41C4lu889Qv1v50q+vP4iDxMyZZjXM1Rm9wvdECK7lpesE99CfzyW19IaQ7yhyBmPIn
 P3eWFOtq4nOwQ7IkNX+5F/1kGntbQK1IskHG7AExmb12XC+bPhl7FA1M6KfeXlj4zcah
 AFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bgw819L225sUfHFAGQ+icgMrtfDNcSYppuYFRj/q2Js=;
 fh=n8voE+KzJeWxBhKYZ4cXm0Dt8COf3qzb0U8Ea57bets=;
 b=gs67LKxeNkN4MNzqmmo7AnoQGtHt/Oo9eCOr573B99mnPIoUdN47U1/Gev424pJC6n
 fSV5C2OPwaIgSJ07j9VP2yWfcgDj5j1JYihtz8qD9bie/7K4bd66oUb6ILe9TEChpUIV
 Zi35JMfAt6xO2GKa4N6ZeFJL1DE9TDef9Z8pbAuFv+VoDZOwUREbJuhGrGAnMZL9N9pc
 ZaSetlDWnjrip9V2KHsRmPQAsuHjnC09b7OBmwBdXQWfei/y3IHu5GtrXkfbvImb2n1A
 KjozASNAQ9wuBwYywLaEeEgpDPJBSIiyiAUlK1eJF/TlLGAwwRa7EBu+4OLEn8sfgjaI
 QKYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780925958; x=1781530758; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bgw819L225sUfHFAGQ+icgMrtfDNcSYppuYFRj/q2Js=;
 b=Rvp+KReaPgJyAOqDkmyL6n9FzQ4oHMBfmTXpFcYChbRFI6QT5tJ1vIVm6ckndV+SbR
 VsV0WiMj7CsRZ+KBpAqsgSEszDYCbu65KFkRjxhXQoYFZr9IwMF0HMcgTxRXAudsQ32l
 kxU1Emz4E+sBVVIh/O6UZ+8JggLxmHlSswk3k/FcQqoUCANF/IXz49P3X2a2ILHIY2sp
 oP8ulUF6Vw3xbQ5aaZenk1mBvrwb5JqjqmjBaEZ5mWqQqLiybvYM6rtJ4guCtuuNSJ82
 wGVUn+YYcUh7QQPHMlQcRx2laF5tCvl5n6C+SecyN8oGEXiVw2eGvfcMkjGEYNlI0Ywf
 Z6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925958; x=1781530758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bgw819L225sUfHFAGQ+icgMrtfDNcSYppuYFRj/q2Js=;
 b=YGMgQlxD2L9RrkqPldq0ZrKgEzcpIeysadBQNGM44bYbdAoX0UcULrVTzNvI4jZifC
 08WJ5k5gVzWW5NQBYiSBa1OXNIjm0djV9fTkBas97nl9VaPZTwCSR6KhIX3TCOsSoq7o
 D27ysaNX5iILBCMTSqIZy03boWSKrRYqFurGeSByBoA+90VfBRNav/ymC+4ji7Oqje18
 Pzl9wAN5KJap0/4hmT5AMIl7y60HqsN/MgQDkMuPz/p2diObny7GHGJtao0hUD2beXWv
 bwfM/dY0dyJQ4kwro/SMbYeZJcjf7KIKCer2VIjAbEiucr8S52oKD3XgCgY3+pcZA8gB
 QeJw==
X-Gm-Message-State: AOJu0YzIkds73vfmwnoBIEHQhSHMUX4r6amLZLgxkh2yVZUmfuxhe0n4
 FpQMrWa3WSqDQreHAHqEpjiz3eUOjIwK8WxBJ/DX1E0nOg+vKxMIlDQ/U8zRL2Do4EmK2sim+ro
 cAoEO7ymy1ZSqItr9VEDZjRT+y29wFbJPu0TWTjqWpg==
X-Gm-Gg: Acq92OFNnpuI1vPL5LE4rOIloLyhCGlxMr7MuzWwkUtDm0NEavMDi/29OizlnGVYpZ1
 hv1VfKxjxPazlnxXNHu3xrgzGW/vRuVfgTZru9uUIA+8Pr6l9HeuBRs94048BAMXnwMAFIXVEs6
 RUFQj+5lP2a+cKrvnPJxoshBNJfLHd/akCexPNc5QxS4zMqQ3gshWERGYywEoAY7dvezffDyAu/
 A87xMgM79wZWnNGYll40r/M/O2Nrj+GUTu7khojjCsLGTlmlEYAxyaGyD6d2L+8hny4yvN6f2S1
 IajVclRtnZhGePh9ffyKG/JOIEmb+016XG1WCdbJB7efPW+SsaTGN/pgkI/DYEUfBe/I9EWnbLi
 Qhg==
X-Received: by 2002:a53:bb91:0:b0:660:eada:ea0e with SMTP id
 956f58d0204a3-66106fe6ed4mr10677533d50.39.1780925957730; Mon, 08 Jun 2026
 06:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260604165048.457860-1-berrange@redhat.com>
 <20260604165048.457860-4-berrange@redhat.com>
In-Reply-To: <20260604165048.457860-4-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 14:39:06 +0100
X-Gm-Features: AVVi8Ce7N9w4x3ZC3qYxKuvRH_bGOcWC7I8SBp8RpIEZ2UUQO0JLw1Te5QirYD0
Message-ID: <CAFEAcA_4sKbosaDRSStAWdD73jTvXGnEraRDR1FbfWXun7oLkg@mail.gmail.com>
Subject: Re: [qemu-web RFC 3/3] contribute: switch security process to gitlab
 confidential issues
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Thu, 4 Jun 2026 at 17:51, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> It is no longer viable to handle the incredible volumes of
> AI assisted security disclosures via email, nor are extended
> embargos practical or useful.
>
> Remove all information about the current security process and
> instruct reporters to use 'confidential' issues. In contrast
> to the old highly restrictive "need to know" approach, the
> new approach makes all security issues visible to all QEMU
> maintainers immediately.
>
> The focus is on making issues public as soon as possible with
> a viable patch. Co-ordinated disclosure will no longer be
> attempted and nor will requests to embargoes be accepted.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Since I'm not directly involved with the security process, I
don't have a strong view here and I trust your judgement that
this is going to work better. I have a couple of minor
suggestions below.

> +## How to disclosure a potential issues

"How to disclose potential issues"

> +
> +**The QEMU project no longer accepts security issue disclosures via emai=
l.**
> +
> +New disclosures must follow the [report a bug](report-a-bug.html)
> +process to file a GitLab work item for each potential issue, ***marking
> +it as "*confidential*" prior to submission.***
> +
> +If unsure of the security implications of an issue, err on the side
> +of caution and mark it as "*confidential*" initially.

"err on the side of caution" doesn't seem to me to interact
very well with "we get a ton of not very well filtered AI reports".
I think we should probably emphasise here that we expect the
submitter to read our description of the virtualization vs
non-virtualization use cases and not report bugs that clearly
don't fall under the virtualization case as confidential.
At the moment the text below says that it's the people on the
receiving end that do that as part of triage.

The old text started up-front with:

-Note that not all areas of QEMU are considered to provide a security
-boundary. Consult the guidance [...]

"People who send us bad security reports" and "people who don't
read the documentation about our security process and policy"
probably has a strong overlap, but I think it's still worth
making sure we have the emphasis pretty strongly on "you as
the submitter are expected to not report things we're going to
instantly triage out as not-security-bugs".

> +## Triage process
> +
> + * A maintainer will evaluate the circumstances of the issue
> +   to determine if it can be misused for malicious purposes.
> +
> + * If there is no potential for meaningful exploit, the disclosure
> +   should be switched to the public bug report process by removing
> +   the "*confidential*" marker.
> +
> + * If confirmed as a security flaw, a maintainer will request

"request" seems a stray word here ?

> +   add the **"cve::required"** GitLab label to the GitLab work item,
> +   which indicates the need for a CNA to allocate a CVE.

thanks
-- PMM

