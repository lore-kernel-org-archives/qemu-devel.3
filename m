Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8E3CA0FE1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 12:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk0ZJ-0001XM-H7; Fri, 30 Aug 2024 08:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk0ZH-0001W5-2L
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 08:17:31 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk0ZF-0005Aa-2Z
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 08:17:30 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c0abaae174so1869877a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725020247; x=1725625047; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tu1t9FnsE6fQVQuE8hdSa9kLIDpBwJ7Swc/EN1UK/Pg=;
 b=yKEW9qRCP5wyF78bV3arx3rBQCxaqC+xArhc+PWXGVJQe7S9XxcdTOVJirFrvGzT0K
 sk080O65qBjQAWbHfMcX50/9Im5A3+z6lRLoryf9je3wGUVyYSfePJvgr0+gZLcP+t53
 PVkLQBb7MQNTMlWB/x+S0b4RXWwgeun+sboG2e4fY90XFNDPSle7r5Y9IJMaNNNFL7IS
 L2xS0ZidFm8KnVW48YGEs8485yeiu/DNvEKa4eSEHK2vYIdDRliC+7I6wEW3eB40bihP
 tHAcZFACJkMF8wdQeaSR0tIy6HAXTxcPBDv2GqBItRH2H4h44C00Fh0ZqOtFwuc9/lMN
 ifkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725020247; x=1725625047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tu1t9FnsE6fQVQuE8hdSa9kLIDpBwJ7Swc/EN1UK/Pg=;
 b=CUN2LrnVm37klZXRc5cVCigvfk/z1Buti2iE5yH83ABtlx5CPOjH7uiVqh07qYqCs9
 GxsH+zxHY2R1PDGlr38YHmTeOF6FAUPg4446Bws++sBj71K7ZPayNOQZITZ/AsLztlia
 /lnaxfP1JbiUf++5H7kRUR1ggTustJsghBH2d8B1hGsQGtYzF3L2YOXjQEXBHU/Qry6Z
 BOJ2Dep+cwobjSOvj29ksPGRjS0GB1u+s+eM93h4iVb8fBgI7fBCOkAbAoiQ9borCDbs
 M39SfvA196yZKaOxWCYIwTNOXB35tySZYsJXl4iHTThr5ayFGESMw9s3ZL4Yg4BxIl+G
 GiAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb4en98211oiNJ1xsXVenyxKvOpRT+QGF7NNiCL2DJO8sgp9LXCnE6P9rJ6a3ckZHYPZsXxWxXPN5a@nongnu.org
X-Gm-Message-State: AOJu0YxOpAiIndQNNp8iOZa4bjHEmTHpaEvkSw5o8/5ubVMkGGKWPbvb
 1x5javw2j0/0XlONutf8kMsuHaWOecHI/crDYzCbR3PLmlmIBOFfljLZ/E4nm8hVjTshRCRIsih
 9yEy53ONWZv3iK5mb62vKL6soHmor+C+mMkoMeA==
X-Google-Smtp-Source: AGHT+IGjXApYzUm8JnCh4vkdgDfzC8Hoqymk/dHgKYp1+2jEwQihG28GFH7KD3oj1WnD2oax4YgmTjYVQFlOANj9Avg=
X-Received: by 2002:a05:6402:5ca:b0:5be:f1a7:c2cd with SMTP id
 4fb4d7f45d1cf-5c21ed9e786mr5822339a12.31.1725020246851; Fri, 30 Aug 2024
 05:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
 <172483282308.162301.11735420619446380771@t14-nrb.local>
 <CAFEAcA9c1pAE7gttju5ib470ZhEMjd1=UMjLuhS+gXohnLs=Xw@mail.gmail.com>
 <172499689329.6066.495009881329074086@t14-nrb.local>
 <CAFEAcA8nTAPi9wr5h_V_GZkVV9f-YDV19mi9yybry0wxMyh6Eg@mail.gmail.com>
 <172501900133.6066.3071687086903215470@t14-nrb.local>
 <CAFEAcA-FG0V0=MNf6sszGW-_Z8PdNv5DWZbLyiF3CCyTt8NUxQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-FG0V0=MNf6sszGW-_Z8PdNv5DWZbLyiF3CCyTt8NUxQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Aug 2024 13:17:16 +0100
Message-ID: <CAFEAcA8WC7K_r2rOwPm=5HtYs99OTprkCZah_-g8PTEX8e10cQ@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw, cpu to
 three-phase reset, and followup cleanup
To: Nico Boehr <nrb@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Michael Mueller <mimu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 30 Aug 2024 at 13:04, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 30 Aug 2024 at 12:56, Nico Boehr <nrb@linux.ibm.com> wrote:
> >
> > Quoting Peter Maydell (2024-08-30 12:01:47)
> > > I ran overnight with none of the patchset applied, and it never
> > > failed (as expected). Running with just the first virtio-ccw
> > > patch does fall over fairly quickly. So something's up with
> > > that patch, which is curious because that's the one I thought
> > > was a straightforward conversion without any complications :-)
> > >
> > > I'll investigate further today, I have the beginnings of a
> > > theory about what might be happening...
> >
> > Thanks for taking the time, Peter! Let me know when you have insights.
>
> I think I've found the problem, I'm just testing it to see if it
> does properly fix the intermittent.

> The fix is to add an extra patch at the start of the
> series. Once I've tested this I'll send out a v2 of the series,
> maybe also adding the cleanup RTH suggested in one of the later
> patches.

By the way, how would you like this series to go upstream?
I can think of three options:
 * you take the whole thing through the s390 tree
 * I take the whole thing through my tree
 * you take the s390 specific patches, and I take the
   remaining reset-cleanup patches once those have landed

Any preference?

thanks
-- PMM

