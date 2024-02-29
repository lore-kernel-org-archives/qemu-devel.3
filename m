Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E8AC5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 03:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfWp3-000554-Da; Wed, 28 Feb 2024 22:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rfWp1-00054a-5D
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:10:59 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rfWoz-0001i4-Hp
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:10:58 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29b066ab295so194361a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 19:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709176256; x=1709781056; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qdz/uZG4uzkwPJT4aHJ8RmgPaNaAKgmV2vGQNe8s30c=;
 b=ju6tLcb+o7FZfgdMmoMgm1P11ttCvsMhjbKGeyhMfC8PuYifWLtdBMwiNef59tIPzm
 gB6RuQAyD6EQ8Wz1X+OwZJtommrH/yn5YZxohPDdnodYHEgj5sH9sOpIHwMBMQwQkBb8
 tPV1mderSV3Vx4XZTjOh531a2m2Zu150panz92TiVjAViM33WHGdHO3E3XC3pLhXFSCv
 emhPjYuVkPOLShJC0uQIUrVoomLYl4Nt/gAe/9JLZou/9Twp6z5pbpBsIemhQIZkBX/3
 7ISidxnCfrjBOFXJKoZrtIIxxS8HzVXgOBTVJ4mILEoJutofCbc3b0W84xlMqFBZA6Wl
 8PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709176256; x=1709781056;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qdz/uZG4uzkwPJT4aHJ8RmgPaNaAKgmV2vGQNe8s30c=;
 b=YylMp9uDOCwuG3rVMAlZsnl55PThDuJaSROsDS2MuNxqhY8yumTQjmKAgxPt93Exg4
 B27X/BbC9UDYHpKrbQ6djmfxkx7Ou4RB7QCGl9aDnwdOA/CCuXJ1MJY6IwrI8n3enDHo
 NtqfqDs8z2LmpXSGN/S65AfbN3G4cLMsu8AeA3j2IliCSw6j7O2ogUMjCTzUUN//92aA
 vPao4BKnj953Cixjve8MiAFhlbR+kphLzdw2MU9JsQ6aoCAez/NAKGuATQefq5uCW3dX
 qj8qzVswV/E0Q1PMz7/7imnAvDpKZAc1fjKxaewP0BGKoa3H/A9wkwNwunQLmv/xRBY7
 lKew==
X-Gm-Message-State: AOJu0YyN8cyrX5uJjZ7TklgmshSx//rHw46CkI6RYAhfvlM1sEpZMJXx
 kQzVFij5HfgloQNIi3NxlALgCQRTWu0D/hPlg6v7dbkSte54+hIMfojjiB9u
X-Google-Smtp-Source: AGHT+IEFCm5DUiC2DMjmuoqJ10Wa1+nChg3bkuvM3LHgifd2gEnWQ1BTYsuo187pBeiKqlIIhtoBfg==
X-Received: by 2002:a17:90a:fe90:b0:29b:bc1:40b4 with SMTP id
 co16-20020a17090afe9000b0029b0bc140b4mr604773pjb.36.1709176256037; 
 Wed, 28 Feb 2024 19:10:56 -0800 (PST)
Received: from localhost (220-235-220-130.tpgi.com.au. [220.235.220.130])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a17090ae10d00b0029a8a599584sm270476pjz.13.2024.02.28.19.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 19:10:55 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 13:10:49 +1000
Message-Id: <CZH8EXLWVQDY.2PX5GNIDS3IMK@wheely>
Cc: <qemu-devel@nongnu.org>, "Pavel Dovgalyuk" <Pavel.Dovgalyuk@ispras.ru>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "John Snow" <jsnow@redhat.com>, "Cleber Rosa"
 <crosa@redhat.com>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>,
 "Beraldo Leal" <bleal@redhat.com>
Subject: Re: [PATCH v3 3/9] tests/avocado: excercise scripts/replay-dump.py
 in replay tests
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: aerc 0.15.2
References: <20240226082945.1452499-1-npiggin@gmail.com>
 <20240226082945.1452499-4-npiggin@gmail.com>
 <87frxdd87d.fsf@draig.linaro.org>
In-Reply-To: <87frxdd87d.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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

On Wed Feb 28, 2024 at 5:21 AM AEST, Alex Benn=C3=A9e wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > This runs replay-dump.py after recording a trace, and fails the test if
> > the script fails.
> >
> > replay-dump.py is modified to exit with non-zero if an error is
> > encountered while parsing, to support this.
> >
> > Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  scripts/replay-dump.py         |  6 ++++--
> >  tests/avocado/replay_kernel.py | 16 ++++++++++++++++
> >  tests/avocado/replay_linux.py  | 15 +++++++++++++++
> >  3 files changed, 35 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
> > index b82659cfb6..4ce7ff51cc 100755
> > --- a/scripts/replay-dump.py
> > +++ b/scripts/replay-dump.py
> > @@ -21,6 +21,7 @@
> >  import argparse
> >  import struct
> >  import os
> > +import sys
> >  from collections import namedtuple
> >  from os import path
> > =20
> > @@ -100,7 +101,7 @@ def call_decode(table, index, dumpfile):
> >          print("Could not decode index: %d" % (index))
> >          print("Entry is: %s" % (decoder))
> >          print("Decode Table is:\n%s" % (table))
> > -        return False
> > +        raise(Exception("unknown event"))
> >      else:
> >          return decoder.fn(decoder.eid, decoder.name, dumpfile)
> > =20
> > @@ -121,7 +122,7 @@ def print_event(eid, name, string=3DNone, event_cou=
nt=3DNone):
> >  def decode_unimp(eid, name, _unused_dumpfile):
> >      "Unimplemented decoder, will trigger exit"
> >      print("%s not handled - will now stop" % (name))
> > -    return False
> > +    raise(Exception("unhandled event"))
> > =20
> >  def decode_plain(eid, name, _unused_dumpfile):
> >      "Plain events without additional data"
> > @@ -434,6 +435,7 @@ def decode_file(filename):
> >                                      dumpfile)
> >      except Exception as inst:
> >          print(f"error {inst}")
> > +        sys.exit(1)
> > =20
> >      finally:
> >          print(f"Reached {dumpfile.tell()} of {dumpsize} bytes")
> > diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kern=
el.py
> > index 10d99403a4..9b3ee6726b 100644
> > --- a/tests/avocado/replay_kernel.py
> > +++ b/tests/avocado/replay_kernel.py
> > @@ -13,6 +13,7 @@
> >  import shutil
> >  import logging
> >  import time
> > +import subprocess
> > =20
> >  from avocado import skip
> >  from avocado import skipUnless
> > @@ -22,6 +23,11 @@
> >  from avocado.utils import process
> >  from boot_linux_console import LinuxKernelTest
> > =20
> > +from pathlib import Path
> > +
> > +self_dir =3D Path(__file__).parent
> > +src_dir =3D self_dir.parent.parent
> > +
>
> Whats this for? It doesn't seem to be used.

Thanks for finding it, must be just a leftover from some earlier hack.
I'll take it out.

Thanks,
Nick

