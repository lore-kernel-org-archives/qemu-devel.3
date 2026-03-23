Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B62F483F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 21:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4mXw-0004Wp-4k; Mon, 23 Mar 2026 17:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4mXu-0004WG-Mo
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 17:10:46 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4mXt-0002xE-2z
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 17:10:46 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-798374d0f44so79686597b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 14:10:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774300243; cv=none;
 d=google.com; s=arc-20240605;
 b=Bbk4rIWHfR9WCzl82LFSdP4D0qWkzhwaegb0UeahlW0wR6Q+QyL8ssfkOywdS07IhJ
 bR3u2Fi/NJ3nLrmcfoENlPM2IdZ+78ZdhsL0PyWz8gVzeqt5fg+BytpkYm41qnxzEfA7
 /cZ8shwV0TZdIYeJJJ62evKiM2DuJS6E8oBXFGdN5tn2Rzubpaqi3cNFeoJQqvRPK+aZ
 KnKPBTl7tpAnQ4Vq09A5CgfrKK9BBQkPD1CTN2/ODbOBmwYTPjFzgv4lGPuOpp1IcyQc
 OdBryzDaC3V59uRjkNChE57aamMkCKswAiXffK6EYEPzBmWdda4pnr6vFCaUhOdmNwZX
 x3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+VkP2Ok3TrhK9DJqpqJO4krnnwLSGahL3oNcBXnzt7c=;
 fh=xs+JQ5uZLyXWRuUSJrpKUyUTXEek7M3sh/uDI/iKp30=;
 b=eQRv9utE/l4rGtnEuWpTyiPOh+YHLKJ6wcL/frf4/Bsi4m8vUxKnJvNRjL/zFPGui4
 TmvjqkvNwJH9m1IJMdPV1uiLMfPLKnt3fb9pH3YAK192SFfb2u6pVh6lnCgKqlvh169M
 EGxzum25XnpN+TT/eQfCVTZhUSGiWF3Fd+kUWjwKl8RvC20xYXh2qCL/RSpjnCW4okMu
 bCxyUrM76mHW4Tm7gmIvCaSdYeY7GP+JUKp9AQBcsCul12IQtne+w1Nb98nIEMQX0ONm
 bzKoAEBM5Jmwfk8hkUx6TcEz3+6ubJHTegqNnV2nOOj9RvgvJwrnbX+JXAcvccJP4VAW
 +ecQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774300243; x=1774905043; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+VkP2Ok3TrhK9DJqpqJO4krnnwLSGahL3oNcBXnzt7c=;
 b=NAuM78+GKKn9k7iBaoepZVJtIjco/qCiGxk/pJ6/+D0RrlBh6jM0ONKhGIFLfuHbFB
 VtUKNJEoaZlgKGOfgvNhoEO7uhf+jVAlRiXjrJ4FoRdXvoTBz7Oti0k0s62JCRELm7Ri
 E1XckPXqztcA+TKjtYtnXQ9IRiw7bbBuf0qU3poZXhv3j9IiGptAYCBAWXZRpoRVVXV7
 j/Qzo2FuXFagirjIjpW2bpG2c12DeVPy1taFXjvomLFq0HkUh1Fq+pa66CUjn5gETlB6
 rIs1XAiyeH/AsTWEEfMI+MjWj73xSq5lTmGp0tUXd9X+tMjGTca2/KbZE+PhKurIr1OW
 CHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774300243; x=1774905043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VkP2Ok3TrhK9DJqpqJO4krnnwLSGahL3oNcBXnzt7c=;
 b=I2QKbgWRr4SOI+OJkawO1+5AAYIYwHjnCPU9SBOv4L1BSYou1emtmZHoBHkDBlFlBR
 e363Q4JGu4BUWKksV20rWcTVauwBI3oilvl4fp7cE+WKHjLtY7xYnVTViwR99fyQiE8V
 PiCbkcomLHO/TH8WyQAxUSndf8aA5ZR4+wAUBEUrs+Do2UCSvMvWWQhew9eqgZmvH96f
 Y1O65zyPpR86Yu3nKj07v4XDDdrC6wvBA5XcPtLLULRW/0ulh4GRA9zQbZ6TXEJZmWbw
 fKq/bQCmKyTD6+ZuCzJH2NxmdpJq/oLnlGB0gB63n3P84a+Xp2kop+cjegcDzZZA5+2z
 2ulQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLlthdLHCnT2W7HtPQ0r47mInzeQZEJynFwCbLUgCqJ2dE5YP0xSERrAik+kgvYYJlikNazrAOS2rd@nongnu.org
X-Gm-Message-State: AOJu0YzqDfgXcZ5Bd8ulwsgA/Gd8xUcssoBdIWrTvpBgbfMrXyFiUs+Y
 Av9Ge/qAq4lJYONltfcx1O5Vr1P0aewYMHDBfqxtNAnt1HezcGgx26+UTja8lIqwPcjp7g+Tm5X
 wFCCtzX4JGycTFiGj3xdjJ1B+PjB8pkO/p6aH+nCnlA==
X-Gm-Gg: ATEYQzww5DyqqIkUIVLwhebgKyHVJegE3qtR/5GyFXWt1IDNoieXeaUQyz69D6BTdMQ
 J4xFepO4n4umpaP9xk0xK05XdiyqDX6lOkS3nzk3vRcqILL6Seq5OzG366tAwX4/3XP3q48a2P8
 zEvakP+ifzR7OzChfTGOKZekMPr5kA/RMfxpAfMdd1p8y5JzwcmNEW5Jpc91P3Lvno6rGTTqCnU
 fiwd28PYsu+NeQQKAauddywg1A58uwZYzhExY4GJJ5jBBraRTuGg7/DydCqHaqpS94SMndEsXbo
 54+eXR6E5dERVrSEBLD7+LM65lN9kJpDfMwHveRK14mNVdIT3VemcVZIO4LNm3TRles=
X-Received: by 2002:a05:690c:c4f9:b0:79a:b49a:cb4e with SMTP id
 00721157ae682-79ac2e74e58mr12123267b3.6.1774300243463; Mon, 23 Mar 2026
 14:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260318174522.87902-1-sw@weilnetz.de>
 <CAFEAcA--mf5DoEkvPi+9M5zHhxhqOScX4hWKowcR49zE5iwFnA@mail.gmail.com>
 <a3b30fca-f7ea-4408-8e5a-a84ead4a3c8c@tls.msk.ru>
In-Reply-To: <a3b30fca-f7ea-4408-8e5a-a84ead4a3c8c@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 21:10:31 +0000
X-Gm-Features: AaiRm50N4gmEhi3k4GkdXxbEWwD-BCNxS1SaII6zE5Ws_Z1YgXu0jxPVBWj5_IE
Message-ID: <CAFEAcA-0C509rKSqGLniyqGFDKxG6b+MnQzo6c_mQ43DLWSU3Q@mail.gmail.com>
Subject: Re: [PATCH for-11.0.0] Fix include statement for u2f-emu.h
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Mon, 23 Mar 2026 at 17:22, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 23.03.2026 20:12, Peter Maydell wrote:
>
> > Hi, Stefan. Could I ask you to try a tweak to your git config
> > which (assuming you use git-send-email) I hope will fix the problem
> > where the mailing list rewrites the From headers of your emails
> > to "Stefan Weil via qemu development <qemu-devel@nongnu.org>" and
> > then when a maintainer picks them up they need to manually adjust
> > the git commit author line ?
> >
> > This is the suggestion that our .mailmap has:
> >
> > # If the mailing list munges your emails, use:
> > #   git config sendemail.from '"Your Name" <your.email@example.com>'
> > # the use of "" in that line will differ from the typically unquoted
> > # 'git config user.name', which in turn is sufficient for 'git send-email'
> > # to add an extra From: line in the body of your email that takes
> > # precedence over any munged From: in the mail's headers.
> > # See https://lists.openembedded.org/g/openembedded-core/message/166515
> > # and https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg06784.html
> >
> > Hopefully that will help...
>
> It might help if the original email did not have From: header at all.
> But I doubt that was the case here, as From-less emails (messages w/o
> From: header) gets dropped almost everywhere, so there should be
> delivery probs for other places too.

The point about the change is that it puts a From line in
the *body* of the email. git will pay attention to that if
it is there and ignore the incorrect email-header From: header.

> > (I don't really understand why our mailing list still does some
> > address rewriting -- I thought we had configured it so it never
> > changes the mails any more and so shouldn't need to rewrite senders,
> > but a few people still seem to have their addresses rewritten :-( )
>
> I guess most uses who's From addresses gets rewritten have DKIM set up.
> Your domain definitely does use DKIM signing, and so is mine.

Yeah, but the theory was that the mailing list should not need
to ever rewrite emails, regardless of whether DKIM is set up or not.

-- PMM

