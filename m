Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C58CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 16:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux6yu-0004BH-Lf; Fri, 12 Sep 2025 12:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ux6yr-0003zs-Ns
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 12:50:37 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ux6ym-0000AY-4U
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 12:50:37 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-72485e14efbso12984177b3.3
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757695830; x=1758300630; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kZZ2T9UOlyWo2/Fv57TNDm/aMnOlGEdEA+7yELhCDM=;
 b=xwpyo4Qkg6MHUCkvhPttVqY4XFpIby8jApdWpHTzFMUdGsLCWLuWyFzFcsNR2cFFpv
 zGue4v8MlCHgePfR2FchCZHR2t65e2G4XWZH/KpVT8abHVdjhR5v1vfVv26sGhwIQNNJ
 qqqjjz0Wtx8hv/aij6vDM6GRJOAuqtidbvtYitRxERT+58PevspGqzPRQgQvXxmpCW/P
 JAEjbIAfwI5dqtO+HQnlvWbu8CyrdRmu4g6yX4lE5LZKyYwUR0aIvdAahR3mKegNNmZE
 hTFlwEwGfvwauTxoyYREuZsWchr0uHqOunDHtQh8LcK07FEDlGHaf5PZCGFXbLAVnip7
 N5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757695830; x=1758300630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+kZZ2T9UOlyWo2/Fv57TNDm/aMnOlGEdEA+7yELhCDM=;
 b=G3/je79RwZsYaeSWzVtpCztv3x2Peo5Scqrm6ES8NkG1xCz6rCoiGxMCXvtOfOSEiz
 9SYpEaFkMPt9/R47YWJ1ogU3+h+9w7pwbR7e5+lfXyOP3ScSDOPKnJ+bpLbfGZJYJhXH
 ssszqgkFW84XT2P7S0y2tGVCRhm4O7SdFBOKv3CWOR2erKwlDYThI6NEaD7fonfBbEQo
 zjQqCfKalznd9hu9BrU6i2VcAKWvqtgOxUccCJy97yGkHdebAwmPNyE9BtxkRgy3XNyl
 qyox/9fdoD3Zqt2vILtWXGPCQHby0s1QSwHuGPO8njdZf+4yw+csc/I4hVoPaflq7Mek
 j1Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmv42cI68Ps5PIFc7JcOmz5DKTCIysr2K4YBMSm14Npx5W8c1GOQ2Qyfh3ZcUpI9kNcP5c8l0FlkzZ@nongnu.org
X-Gm-Message-State: AOJu0YwtQHMwMBoxXwB73l4Ovih/iEHoyEMK7APvY3cKIASXYLkouYC/
 G+qVqa0AbYiGteppdnGHVVcEJVicU1njL0mUBqtEDijXPcxw40wb87Fhxutwt3PLh1n3pmrnpZl
 hI+DB6azQjnMLodvP27dPYHpgTMo/ujme0iOhrtwNXQ==
X-Gm-Gg: ASbGncv7geJd9Glmg21DW+ZMfgDBKbmZqGXsE6qhFUFQOHpm0CYxLK9odHOzYwuy4RD
 B6lhmKcoffb2UxDKy5Dvf5Ik5YPjRlHez2sUAGpqhjxx3BnALCESSJZxscPgx2j12btgkyGmDqm
 iLV27r4zAtzQetsY1s0eSwLozjE3tPinAL2u+hNtkdxzaXxAbTBZGJeYtsfdlHOWe1Cy5nEs7A/
 c73A8EWWbSlGtUNLGI=
X-Google-Smtp-Source: AGHT+IFp81WeNcFb7MRuA84hGznaQWU/8s3iRlaYh0Meh2Yn8zomG0jriDaJHSOvL/ZB/c3SReNk0B1WWLdvrj/K83s=
X-Received: by 2002:a05:690c:a012:b0:730:c83b:e9f2 with SMTP id
 00721157ae682-730c83c14b2mr21655167b3.37.1757695830176; Fri, 12 Sep 2025
 09:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <aL7CsSppNc-WZFY-@redhat.com>
 <a6320118-84f0-4088-82de-7192be6093cd@linaro.org>
 <aMQzD0m3QluWzlmh@redhat.com> <871pob64iv.fsf@draig.linaro.org>
 <aMRJ6nfXF2l7iu7b@redhat.com>
In-Reply-To: <aMRJ6nfXF2l7iu7b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Sep 2025 17:50:18 +0100
X-Gm-Features: Ac12FXx4E0BId-0fc-ViiDMLWNcqfd9YV-1uoLsyuOoSLuHKE2jDTsjCPlKx5lw
Message-ID: <CAFEAcA9u1v3=BwrC3Vuo4mk+H+5bCcYcQ0FNeT15z44HALaA8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 thuth@redhat.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 12 Sept 2025 at 17:27, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> Well if 'easy' is our goal, then we can just copy the gdbmi.py
> file from avocado into our test suite. It didn't originate in
> avocado to begin with, they copied it from its orignal repo
> to then port it to py3. The only real downside with gdbmi is
> that the machine level protocol is ugly to read, but I'll take
> that over this current patch, as I think the reverse debugging
> stuff is a match for the functional test suite, and moving to
> the tcg tests still leaves us with the unpleasant interaction
> and debugging issue that I've described - they're just hidden
> from the functional test suite, but still impacting QEMU as a
> whole.

If we're doing programmatic driving of GDB then the machine
interface sounds like the better choice for the task anyway...

-- PMM

