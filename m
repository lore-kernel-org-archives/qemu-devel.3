Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F00C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cQr-0001CK-16; Mon, 21 Sep 2026 07:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x8cQY-00019d-Np
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x8cQU-0000cp-TZ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789990991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Yu5Pun8TpaAsM5JnAOFfmjXlNn+RIBfj41050CHIGo=;
 b=C5Dc0j8GhpuSeHH8BCHYl4XinpJh8/F/oFSToj8KMUrnhhrKMpRV3ojzBHxTklcCbwurlx
 hD5g49WNvjSu4XLocBH/r6VJNGp3UW4INs5FQxiRjLcxQlHgDjlhogodn1271WZC9n8eb4
 0ufGuBSi1It0nG5sCxW5+1mYmWwxE8w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-83uAblkkNA2p7wzWCSUgig-1; Mon, 21 Sep 2026 07:43:09 -0400
X-MC-Unique: 83uAblkkNA2p7wzWCSUgig-1
X-Mimecast-MFC-AGG-ID: 83uAblkkNA2p7wzWCSUgig_1789990989
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39533bb224cso5430387a91.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 04:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789990989; cv=none;
 d=google.com; s=arc-20260327;
 b=fH3Qkv2JAwm64XPLNpsURBnBFPo9fm2Ik6CqujG4vmP+HKmpydt27vXGXYz0O6+9I8
 rF2XS6fkvC69zIasqgcQD1b/QP5LvGpNIUZgSaWO3+5/k6cfpGqj/o0zGLgTNpNyUgPN
 X0mUbYwes+GXe2h9a2M/qn5vkW6juW3+NyyyV+RZvZXRiuroZkKF8k0cEBZJ0pPdnQL2
 EuWRhT/IZ4+sljppku+wey9NzkDTPBHSO3AxmK3y0WPvjvE8rG/182oeRq1/WkpbcKtD
 RizH3YZKP157KoLvpuPQle1hVjdYrx86gJyyIPVlKK2adTjM3T6JsNDKUKKLU4ZT4O37
 vZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9Yu5Pun8TpaAsM5JnAOFfmjXlNn+RIBfj41050CHIGo=;
 fh=BsVOr6JM7Ufqvit/YFot8iZyoEhGyXvPhv5ztq6e+Sw=;
 b=LLpUvYQ5Y2WhHbgOOxkc+1wzgM3gYrdjfjHc+r4zDWhuACKmnmep5mLmD4/C1ZXAMR
 4JcNZ06VxqV3Kidx+87RaCAxecALUtdIAqTe0RP2gX9LQWnYrP1tg6OVoHpPwq/ZrATd
 T+WTmFU5U2IO+eGNOicULHiL46l830u3Zi+gDh6GuaLxFPN1fdIbsUZ4oANZuf40NxEW
 /+E9UeZVhOylqKVAMjvleR+lLJVAQWYY+/SPwG5khvSIN6uSfJU4PltYY/GFOnSjE1WX
 pQzwtVYlYPTUQLQg07eHT096CrEequJ5eN+LhjGGNonrJud2hvt2enzVqj0Hbx/PQ1rF
 E7lw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789990989; x=1790595789; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9Yu5Pun8TpaAsM5JnAOFfmjXlNn+RIBfj41050CHIGo=;
 b=QIOw9Z2HP3oPrbOM7En00ub8d6f46eHYtVmmCsKF+1/bUcglsLqFWY8r6oqkcBa3kS
 dFBdyR5ENod0G/PyWAKkmXddkNFKtTpr4PoKZjzXPOUqWmt091Q18u1EM1h2sygojl1k
 +MXuVfyHioi3Y5GP8TjCCzbIPKUIEcog+jUoXYpAxfQOpHUYz+CY21K/qUKIFc4P+QdY
 BOJQ1e2TysYO3W6Rx2FYPi5Agn9A6Z75yDU5jHr7hn6Y2UGfnPz9bOwHO7+lh7oTIBaE
 JQ5jUkHmJrzE5ZzeiHYRs1e2rqOrQzOdrEznQvFGii0kri/J9jTmdY0Duc9CBZitNcLk
 Opng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789990989; x=1790595789;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Yu5Pun8TpaAsM5JnAOFfmjXlNn+RIBfj41050CHIGo=;
 b=jgwrUbe0vwDd88rnwO6oM1V7pDu5DGh2T9P1zNkIiU5Sh7yHantAk6mEUa6fjGJI9p
 m285MxFzu8aU4GTu3+NNG8tihDTDsw7pRJThOVwhI7fpad2Ne58D19pFAarPZf7xcPJn
 bvNRPwx1fTteQlyZqvxfJdHi/6vknyEi/LBoie/ffSfl3XUpxq+82eZ0tRLUn2yzJJN/
 G+thzHIIkAVepLGHOZ/0up8CjFG63vUi2iETTNIirrZyUyDhLQGymlbXl9xjGS4e9vlW
 PcoFyPhoKR9h3sjhwwBowXZSSE1eLmaEsWRTrW8TJhxUYI9Z+r5nbGBwY/NlSRiVpJnW
 OVzA==
X-Gm-Message-State: AFuF++lCrnY3XAgkY8XFaAtWbs3OFZbBjlDJ3oLIjb8vUQoYeOq1XHjj
 veR1a5G+E4QsT7nsQFWRO2PCqR8euaf3u0jk/xLmdf/2UrFdnvGYNBTdMHId/Cemco2JtbVkeJw
 OM2JD1thYRpfb0Ym/9f/4aYeXXJS8yz/wVF23DGaQ33SW1lXlaoXFAIMiX3eLorj8VA00h5dH1v
 O4N5V7KZ1Obf5meb2J9JHP7EF766/IaHQ=
X-Gm-Gg: AYBFou3HUVHJz17TGx2HDqereQUhxLbOc+MiRQvRzOuQRoysBKSk8y9xf37xESZAgLO
 IlGXeABs32L/7gqA9wT9JLGT4M+OUmx+jYaIdYpRfyF1yLJ1Hvl268IhGa/Al5BeiHMwkGcYbGR
 V35H6SPr/liQofpvzwi4wVCbmxRG8yR65tAfAz5OytifWi23/rF75Ip4GG/rHWV4Oz1vxwcHdyC
 y7UlG1Xj059KhJG+u3rzj2f477wernwOTqoyvZSFmb4PueamHWOtV9yce7md2xA4IY1EjXCdPXz
 /w==
X-Received: by 2002:a17:90b:1d48:b0:39d:ec42:df69 with SMTP id
 98e67ed59e1d1-39e54f9da82mr14794193a91.20.1789990988515; 
 Mon, 21 Sep 2026 04:43:08 -0700 (PDT)
X-Received: by 2002:a17:90b:1d48:b0:39d:ec42:df69 with SMTP id
 98e67ed59e1d1-39e54f9da82mr14794176a91.20.1789990988013; Mon, 21 Sep 2026
 04:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
 <20260829-nohmp-v1-21-4dcc2b4b0055@redhat.com>
 <aqvp5H5FvEao80BV@redhat.com>
In-Reply-To: <aqvp5H5FvEao80BV@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 21 Sep 2026 15:42:56 +0400
X-Gm-Features: AcwNN1Umy2ghaORnxbcjtYFSI4DNS-1wSPfc7LIwov0iYNd1wbtdtsIrOxW09kk
Message-ID: <CAMxuvaxCRHhvuHSiz+u8N=V53KGdbUCvPVk-6prtEZtp6wcL-g@mail.gmail.com>
Subject: Re: [GIT PULL 21/50] qemu-io: propagate errors through Error API
 instead of printf
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi

On Thu, Sep 17, 2026 at 5:23=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Am 28.08.2026 um 22:42 hat Marc-Andr=C3=A9 Lureau geschrieben:
> > Convert the qemu-io command infrastructure to use QEMU's Error API
> > (Error **errp) for error propagation instead of printing directly to
> > stdout/stderr via printf/fprintf.
> >
> > The cfunc_t typedef, all ~35 command functions, the dispatcher chain
> > (command/init_check_command/qemuio_command), and helper functions
> > (parse_pattern, create_iovec, qemu_io_alloc_from_file) all gain an
> > Error **errp parameter. Async completion callbacks (aio_read_done,
> > aio_write_done, aio_discard_done) use error_report() since they have
> > no Error path back to the caller.
> >
> > Update tests:
> > - error_report_err() prepends qemu-io: prefix
> > - copy-before-write: check the HMP return value, rather than stdio
> > - other tests: update to check JSON {"return": "Error: error text"}
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Message-ID: <20260828-qemu-no-hmp-v5-21-9227de146347@redhat.com>
>
> This was not a great change, it results in a mess for qemu-io output.
>
> When used from HMP, success output still ends up on stdout, but (some)
> errors go to the monitor instead now. Some commands may even get their
> output split across both stdout and the monitor. The old experience
> wasn't great (everything should have gone to the monitor instead of
> having everything in the terminal), but the new one is terrible.
>
> Please fix the inconsistency or revert.

I agree; initially, I was converting each test to QMP, but I had to
postpone this because the series became too big. Time to finish it.

>
> > diff --git a/tests/qemu-iotests/004.out b/tests/qemu-iotests/004.out
> > index fb8593289f51..37da6024809f 100644
> > --- a/tests/qemu-iotests/004.out
> > +++ b/tests/qemu-iotests/004.out
> > @@ -6,36 +6,36 @@ wrote 1048576/1048576 bytes at offset 133169152
> >  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >
> >  write into image boundary
> > -write failed: Input/output error
> > +qemu-io: write failed: Input/output error
> >  [...]
>
> Instead changing the output of all test outputs to include an
> unnecessary and inconsistently applied "qemu-io" prefix, it would have
> been better to disable the prefix after command line parsing.
>
> qemu-io is still primarily an interactive program, and constantly
> printing the name of the program you're interacting with has little
> value.
>

Make sense

I'll send a series asap


