Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104EBC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 14:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9QTA-0005pu-8d; Tue, 21 May 2024 10:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1s9QT8-0005pe-Md
 for qemu-devel@nongnu.org; Tue, 21 May 2024 10:27:58 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1s9QT7-0000tT-4q
 for qemu-devel@nongnu.org; Tue, 21 May 2024 10:27:58 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51f60817e34so6296322e87.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716301675; x=1716906475; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubf3YY7h8HA/Th7rv7qXSzRcba9AvT5uw2wTqdvAHSk=;
 b=Vnm9HWcM8wRCbBZ1ee4yLOnBTWCL4MXomX4NTrzOK7agflABOsy5JM2hIKNaZfCziu
 7+LB1Pe2YtU8HhgeY7hh+/ma349ED46bgWdctH1RxstsIDfam1FzLGtZkY5iNcY3vL3I
 SVOo3Z3pm30dQsnMnEG2z/+hAV78W9sNRtg7Kknm4rBfvk3YI10L8e6/rx1UxEQ4ieXV
 hHoUnsdlt9UI3cK+1Yq1TmPr3Xy9tJoUsH7ONXsVhj5oGN0qG0GjQryLlY+EkaZm9xBI
 AIZFkCLXX5rbeyP6hK3VXgWAPCjH7dzMSkoztqbWQ89Qdnxh/KH8Tb1icMSYy1neTdi8
 kq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716301675; x=1716906475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubf3YY7h8HA/Th7rv7qXSzRcba9AvT5uw2wTqdvAHSk=;
 b=q+Ka8F+bZbYusd/6rVtuAbasRthRoWeLTx9Jqm+y2/cSuY7PtISdSCE/67bd22rcMs
 /Zn6xAmBQqdZpyj48AYlzOLFsub7GcRQhYlxXkn1KQvSH44eFbAJ61z8gccuYdFWc/91
 RQMEO3BBbfAGITYDiwRtEsrWebYdLhXf/i7iswUvOS++oIaVKOvOrUXn5SxUv8Ul+Mzt
 nGSz0gNig44cqfzSp3+EyjxdYRjNFAMEEQB1ZHvZKoZS7uoSPhxxXxfJI9b2SH/1iFJh
 FFbhlnUUSrjx9YL8eBGhoAIv/RoK4YlynGTybKhSQ6SW1Xx+NZwfry4hu9WyQIMK9nfB
 rN/Q==
X-Gm-Message-State: AOJu0YxVTnvkF1fdBdBgsV401ET1vYi9uDb3ZuQ9fcsLapopgBEhE09R
 hU/GeCHr9/lzqVlGUnm+JddXjIu4KilIc24XeTvllyY+srK+C9LCwS98AYBhDTLeW/jDno5vr65
 u0MxQ3uaau7XLbB4JteUsYssB53U8dw==
X-Google-Smtp-Source: AGHT+IEdTDFDKEEWdL1txoWICOSIr4tjnNmbMIxkka+XBzXf8A9OVsqzic/cbJmbpQWOpCMsEMedAhzCO7PsMvVfl4U=
X-Received: by 2002:a05:6512:3a83:b0:51a:c8bb:fcf7 with SMTP id
 2adb3069b0e04-5220fa7208dmr24821029e87.3.1716301674335; Tue, 21 May 2024
 07:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240516162230.937047-1-berrange@redhat.com>
In-Reply-To: <20240516162230.937047-1-berrange@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 21 May 2024 10:27:30 -0400
Message-ID: <CAJSP0QXNBoRQvCP_tEDfK3V=+xaPkKZKjAcPjxFrEuU2gF4RHA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] docs: define policy forbidding use of "AI" / LLM
 code generators
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=stefanha@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, 16 May 2024 at 12:23, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> This patch kicks the hornet's nest of AI / LLM code generators.
>
> With the increasing interest in code generators in recent times,
> it is inevitable that QEMU contributions will include AI generated
> code. Thus far we have remained silent on the matter. Given that
> everyone knows these tools exist, our current position has to be
> considered tacit acceptance of the use of AI generated code in QEMU.
>
> The question for the project is whether that is a good position for
> QEMU to take or not ?
>
> IANAL, but I like to think I'm reasonably proficient at understanding
> open source licensing. I am not inherantly against the use of AI tools,
> rather I am anti-risk. I also want to see OSS licenses respected and
> complied with.
>
> AFAICT at its current state of (im)maturity the question of licensing
> of AI code generator output does not have a broadly accepted / settled
> legal position. This is an inherant bias/self-interest from the vendors
> promoting their usage, who tend to minimize/dismiss the legal questions.
> From my POV, this puts such tools in a position of elevated legal risk.
>
> Given the fuzziness over the legal position of generated code from
> such tools, I don't consider it credible (today) for a contributor
> to assert compliance with the DCO terms (b) or (c) (which is a stated
> pre-requisite for QEMU accepting patches) when a patch includes (or is
> derived from) AI generated code.
>
> By implication, I think that QEMU must (for now) explicitly decline
> to (knowingly) accept AI generated code.
>
> Perhaps a few years down the line the legal uncertainty will have
> reduced and we can re-evaluate this policy.
>
> Discuss...

Although this policy is unenforceable, I think it's a valid position
to take until the legal situation becomes clear.

Acked-by: Stefan Hajnoczi <stefanha@gmail.com>

