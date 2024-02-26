Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8626C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 06:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reUem-0002O4-73; Mon, 26 Feb 2024 01:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reUej-0002NQ-Uq
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:40:06 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reUeh-0004vQ-DO
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:40:04 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso28233265ad.2
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 22:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708929599; x=1709534399; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NkEcHBjUCcnwDk4fGmBsFSOuqO+L+gewo6t4yLKtY0=;
 b=RyEpfzEDSvqBdKhDB4a+4muoanJkkQ0OAAgyjoZZ8c7ahLOnFApJkJ06GQ15ohzK4H
 qqDo2v5oA69NoKOW0tNnEAe3EppMmImgTmr5/8up65bSp8BOEJ6ZBiKWOYMBRQZWrFJ5
 1w9/8JtGCRgZP22OsVP3dBoA4bE48GZKoDyqDaO9lgMKvY9danY7ojhb81cZxdBJh8iK
 LaF7uaRsZqLT309HdNxDW65trIAl4G2nbePtkJBzKdmcmqZwzBYkBboJfB5FwsYdwYyC
 MZu/86qaR/svQn7JFGMVuPX6zeUgC/sSihnq6QkqGtIRNNzkVtrqrz6KRnQFV6FdiEaN
 wpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708929599; x=1709534399;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/NkEcHBjUCcnwDk4fGmBsFSOuqO+L+gewo6t4yLKtY0=;
 b=pfxqSGKrJtOtvp2kK7YM3EWx5FYCGOnlhCnsW7tZUvICvz8x0iEBc+Nrf9TdTxw5Pc
 +yms5Rip/kyVduCnE1gWCMTVbnlp4igYxL0wBW4QSda3laJJ7HP/vxwqTdGUery8H6vg
 LfBfynpYH4WxtyXI4Mgt5abNqcl7WqeQCm5DcLWtLO1N99M5gKGAMn70d4FpooPo770+
 ruOToT71aXDGl1FitvR3cTavA6vYIY70OhKq8mq0KoAM+w9pXesYkaZkRqHfteV2BrDV
 YsMU2eKfuAewOJzQd9FPLELWvQ1bYum2ScVyNi+JA3Z+E8PbPimTe4HuFpvJZaPLjJTx
 BhEw==
X-Gm-Message-State: AOJu0YyQ7gCfb7lX4SCl/bH/r6bfV+tDdU0I+Y3qhMOdmlYkjJsUWFJt
 bAgX7Ai2BaaLeA5a9ce7p88+H/OYbnR7S6qaO6WSkdcwlrYum4O1UsXqPiNX
X-Google-Smtp-Source: AGHT+IGPRZfLHS3DtZekPzcaZYloARxS4FKgOAzgBYIf9Lrnq1gTbH0bszC7mdIDem4/hSqBrRPKXA==
X-Received: by 2002:a17:902:e844:b0:1db:e78e:b38d with SMTP id
 t4-20020a170902e84400b001dbe78eb38dmr8536843plg.18.1708929599270; 
 Sun, 25 Feb 2024 22:39:59 -0800 (PST)
Received: from localhost ([1.146.74.212]) by smtp.gmail.com with ESMTPSA id
 jb1-20020a170903258100b001db5753e8b8sm3166984plb.218.2024.02.25.22.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 22:39:58 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Feb 2024 16:39:51 +1000
Message-Id: <CZESZCGZ5VE5.2ILQXAT261OX@wheely>
Cc: <qemu-devel@nongnu.org>, "Pavel Dovgalyuk" <Pavel.Dovgalyuk@ispras.ru>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "Cleber
 Rosa" <crosa@redhat.com>, "Wainer dos Santos Moschetta"
 <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>
Subject: Re: [PATCH v2 2/4] scripts/replay-dump.py: Update to current rr
 record format
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "John Snow" <jsnow@redhat.com>
X-Mailer: aerc 0.15.2
References: <20240125160835.480488-1-npiggin@gmail.com>
 <20240125160835.480488-3-npiggin@gmail.com>
 <CAFn=p-aB94Y+WSJOdHOsxmrrETy-W76KK4z1qY05QCq2dzV=zg@mail.gmail.com>
In-Reply-To: <CAFn=p-aB94Y+WSJOdHOsxmrrETy-W76KK4z1qY05QCq2dzV=zg@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Jan 31, 2024 at 7:36 AM AEST, John Snow wrote:
> On Thu, Jan 25, 2024 at 11:09=E2=80=AFAM Nicholas Piggin <npiggin@gmail.c=
om> wrote:
> >
> > The v12 format support for replay-dump has a few issues still. This
> > fixes async decoding; adds event, shutdown, and end decoding; fixes
> > audio in / out events, fixes checkpoint checking of following async
> > events.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  scripts/replay-dump.py | 132 ++++++++++++++++++++++++++++++-----------
> >  1 file changed, 98 insertions(+), 34 deletions(-)
> >
> > diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
> > index d668193e79..35732da08f 100755
> > --- a/scripts/replay-dump.py
> > +++ b/scripts/replay-dump.py
> > @@ -20,6 +20,7 @@
> >
> >  import argparse
> >  import struct
> > +import os
> >  from collections import namedtuple
> >  from os import path
> >
> > @@ -63,6 +64,10 @@ def read_byte(fin):
> >      "Read a single byte"
> >      return struct.unpack('>B', fin.read(1))[0]
> >
> > +def read_bytes(fin, nr):
> > +    "Read a nr bytes"
>
> Existing problem in this file, but please use """triple quotes""" for
> docstrings.

Just coming back to this, sorry, was struggling a bit with ppc merge :/

> > +    return fin.read(nr)
> > +
>
> Does it really save a lot of typing to alias fin.read(1) to
> read_bytes(fin, 1) ...?

Not really, I'll squash it.

>
> >  def read_event(fin):
> >      "Read a single byte event, but save some state"
> >      if replay_state.already_read:
> > @@ -134,6 +139,18 @@ def swallow_async_qword(eid, name, dumpfile):
> >      print("  %s(%d) @ %d" % (name, eid, step_id))
> >      return True
> >
> > +def swallow_bytes(eid, name, dumpfile, nr):
> > +    "Swallow nr bytes of data without looking at it"
> > +    dumpfile.seek(nr, os.SEEK_CUR)
> > +    return True
> > +
>
> Why bother returning a bool if it's not based on any condition? Add an
> error check or just drop the return value.
>
> > +def decode_exception(eid, name, dumpfile):
> > +    print_event(eid, name)
> > +    return True
> > +
>
> I suppose in this case, the return is to fit a common signature.

Yes that's why I did it, but it actually can't fit in the normal
decoder pattern because a nr has to be supplied as well. I'll
change it as you say.

Thanks,
Nick

