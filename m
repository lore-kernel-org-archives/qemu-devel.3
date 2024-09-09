Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE7DECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 10:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snbly-0005Y7-Ma; Mon, 09 Sep 2024 06:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snblu-0005XI-IV
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:37:26 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snbls-0003PC-SB
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:37:26 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c245c62362so5585054a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 03:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725878241; x=1726483041; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XjFEgy19yyLp6jpaMsAKjA+mYUvu39E/IAgn23t4bOg=;
 b=tbaD/07aW21pCGZkcnTDBmKhAAjcV4HflKNXf9BdIwNm5fbZ4GQFCY8pcAmT2E+6XI
 9q2Ini30pLG00xVCmiU3+8tWn0/swgW8GWMzkCyb3208wBgP2jYebCWA0avPxvpyS/Qt
 249vryHugA2ftQXg0wQnLw4Pv3mGUEy+c9N5oJOK2gBNSz07eb/lNz8HRo2dmB7yXb6m
 EY22c6JNXHPLznezM7IrdBnZ/ZNRGC2/wJZlKvrvy5uUEcJCPrYQ1YnQeDbUqBBlYMwH
 vF90lbSIt7ayfP1tzGanQgvX1NHjEfb1Zb/qZAyDiQYSEaDkCMqai056OLzyYo680cLU
 bRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725878241; x=1726483041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XjFEgy19yyLp6jpaMsAKjA+mYUvu39E/IAgn23t4bOg=;
 b=Tm9f+BRxABKkndon/zWErxWymsV0Jo8qlBNtszFyqmuRK3B7+hSyMulJUxpixNJ7tZ
 3YVasTznjFujCRCr5c5PAx16YqzcQIsVtYmvmYj8Tr4eisJjOIaEv5icNTtp446+7vMZ
 ajfuxtfmy5gi30JO/ntXzvYUPvWWvN30YivdiYRB74nHetpfN+5sQ1iB+5FL5TiUoD7v
 Gd5y6OYwhgLDZUGlBcKpivUZGY/DM5tQRZs+LuUJKHTxGWGzX0gnvOU6rMcO984TRuoM
 92zsN1lEyTG43mC9Fzi5lEpIPkjgW6H7IwJgtlnrHH1TUwPDsKWQxb5pcXd6oqhpAOpC
 t/aQ==
X-Gm-Message-State: AOJu0Yx1+zndmyDMXbSxAcC5oktg9/ojSrmpV7g3kAztElsZK1IJHUl3
 jP1h3Ci8z/c1qw8L8dwhuVj35Xstv5d47qpUTSuuKo9YOBI7vsnW1XBgE9DS3qyopNGV6cd2grl
 uxpfECM6oQ3R0Ce9CgRrSNMznJffbac0rVa4v0w==
X-Google-Smtp-Source: AGHT+IFID4n6BW8y9iFssS2etEoiZhGY2K4BGVS2Off6ofRBssA+3mQ3NIoKBgfghOxeRwxLPIUV+X/yiP06O/0FisI=
X-Received: by 2002:a05:6402:43ce:b0:5bf:2577:4346 with SMTP id
 4fb4d7f45d1cf-5c3dc79a821mr8141936a12.15.1725878241221; Mon, 09 Sep 2024
 03:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240904124417.14565-1-farosas@suse.de>
 <20240904124417.14565-28-farosas@suse.de>
 <CAFEAcA_F2qrSAacY=V5Hez1qFGuNW0-XqL2LQ=Y_UKYuHEJWhw@mail.gmail.com>
In-Reply-To: <CAFEAcA_F2qrSAacY=V5Hez1qFGuNW0-XqL2LQ=Y_UKYuHEJWhw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2024 11:37:10 +0100
Message-ID: <CAFEAcA9jKK2_D9nSFAUk_EH3A7ZNCn_3FM==AmuJw4cqHnMfkw@mail.gmail.com>
Subject: Re: [PULL 27/34] migration/multifd: Move nocomp code into
 multifd-nocomp.c
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 9 Sept 2024 at 11:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 4 Sept 2024 at 13:48, Fabiano Rosas <farosas@suse.de> wrote:
> >
> > In preparation for adding new payload types to multifd, move most of
> > the no-compression code into multifd-nocomp.c. Let's try to keep a
> > semblance of layering by not mixing general multifd control flow with
> > the details of transmitting pages of ram.
> >
> > There are still some pieces leftover, namely the p->normal, p->zero,
> > etc variables that we use for zero page tracking and the packet
> > allocation which is heavily dependent on the ram code.
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> I know Coverity has only flagged this up because the
> code has moved, but it seems like a good place to ask
> the question:
>
> > +void multifd_ram_fill_packet(MultiFDSendParams *p)
> > +{
> > +    MultiFDPacket_t *packet = p->packet;
> > +    MultiFDPages_t *pages = &p->data->u.ram;
> > +    uint32_t zero_num = pages->num - pages->normal_num;
> > +
> > +    packet->pages_alloc = cpu_to_be32(multifd_ram_page_count());
> > +    packet->normal_pages = cpu_to_be32(pages->normal_num);
> > +    packet->zero_pages = cpu_to_be32(zero_num);
> > +
> > +    if (pages->block) {
> > +        strncpy(packet->ramblock, pages->block->idstr, 256);
>
> Coverity points out that when we fill in the RAMBlock::idstr
> here, if packet->ramblock is not NUL terminated then we won't
> NUL-terminate idstr either (CID 1560071).
>
> Is this really what is intended?
>
> Perhaps
>          pstrncpy(packet->ramblock, sizeof(packet->ramblock),
>                   pages->block->idstr);
>
> would be better?
>
> (pstrncpy will always NUL-terminate, and won't pointlessly
> zero-fill the space after the string in the destination.)

Whoops, the name of the function I'm trying to recommend
is "pstrcpy", not "pstrncpy" :-)

-- PMM

