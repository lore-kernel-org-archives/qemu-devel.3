Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FDAD4899D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjwr-0001oo-R1; Fri, 16 Jan 2026 08:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjwq-0001nh-IQ
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:33:08 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjwp-0006gQ-17
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:33:08 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-790992528f6so18761897b3.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 05:33:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768570386; cv=none;
 d=google.com; s=arc-20240605;
 b=Rb1Pi6mMSAA748LaYbt/Kw+OtT3VjxeVhVG0UaYnZaKe62EYsfNrihaJsjv6V6PyBC
 +9mKI2iVLeN3bRhQpiWbw8sxocAoQVZi2HnjSQkdvoxHKPzjSOB/TFmalmMcpKs38UzA
 laQttD3e0Rm8K+6SICrtUYISXWESD6FG6ov0wu8dMoWpir7hTwHeOZ8sCgEijri98zTf
 yyImOJPL+vuFVJml43mN18Jh+ExcrG8GoNToSurWOI4JRBp8xUqfm538OIIyeSwzq2Qs
 d7aFZZPDr07huwk16MBrRfp23rwSezdoeGDAexMUwUytxx5eR3Ki+nvbCLoORiEX2WyG
 1dRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nYsJzwPuBc+PJYwI10SmXf93PH3tryFGEAWTJ4id3WE=;
 fh=iXi1O36oA6iH3LqUvSBFe0Cjxqz9C3gK/kHWpPzH6bo=;
 b=eNNcxvmO2SmE7CAFIu/rrRA+4rEo7lHR3sDcTfkNrL67dyPcN+EtjfXBcPBvvN3np9
 TZ7Kp/sv6qUxKn43FG50ehr7CPnXjzqRN9NjY0EHWuBtv9AEIqSmkdNG3jt3KBKMKUn7
 Lid0yYqwA2X1z5QpjrjT6KY+rW1pqrfGjeDLzSfnMHCdeZV9SMtL46LOlG9hTxKDlWMp
 DG7kCkB23qCWWBpSi2Hw1vnN1uCb06BGChxXzxvkxW7mq1ouNvntNgKO81RGMXWP2f2X
 ANKXQnjzg+swYzWdIPSFfamqrsL21yVkxhaWhk+H91SsHgNPK/HtSoCL5mzS+10OBlmW
 B81Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768570386; x=1769175186; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nYsJzwPuBc+PJYwI10SmXf93PH3tryFGEAWTJ4id3WE=;
 b=UuHmi3a4b4AxtCxVT5JtUTwijGUvVQYFN2PyhOYnRosjMQMcLvbQnF0E69lj1shRaV
 /c1mKzyUa7p2QE2O9ak1RsVQpVQFVu9Vgiva8WHwlrdnFuQsFSdVhrix5XQ0M2oYJ8iv
 XMvWRWeHyOgj5SrPOyxkWhk159H0PComsow58aejlo7zfiPI4X+1Tk2bGUEI3c4ZArYv
 EyQoVasR7BIjs6WS5+asyBJfQkj21yVCabNvN4nxIOQVJlpqBX0a3FqU8MB/mWFMdETq
 wcBYL7UpzEl80huSCZZd0C5pdI2T03UC8ZZTtlf1hZhm2KWVKS3i5M+NqN3dl7tZbOVo
 Bmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768570386; x=1769175186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYsJzwPuBc+PJYwI10SmXf93PH3tryFGEAWTJ4id3WE=;
 b=VM0xgxMeh6vO9cGqjF4v6uMkB2bBv91Qy1Aocrl9+NdHjWHrw19ZCAFNvLDb22ZSWT
 pmwrjXpa7zsR+qVgG8qpv7TBPnd0OLE9dro4hW27pHLkDHofpjbjYabCWPUX6yvhaMS7
 P9P2XFPlqPbERClar7obsppaEHmqPsof2DRCcjO5wriy3Q7wLs/Pdg/g9RcNwAveteOS
 EeMWL+PSPa5ZDGSk1HTmB0KsPekwrJmMR8GPVJy4bTXw/qEdUUDuWtX3MjKfOVCDEIAQ
 Wl0isNhA+LKZYggDic+buPfg0Zv+9K8j3/28K3yZQdABCq7XRAP0LF6WOb9UCfexCnll
 6uIw==
X-Gm-Message-State: AOJu0YyM7gG14W3T+eJvY91CJURbS68gvwMgZCmLddaC0INj5083zAsM
 pNSv146ETTs3rUP4yFceZW0jHyDAUFMkZlvgzRTkIhieJ6BXfWFkKfQeleIq9CrC/SqBi3QXdOw
 CfhdQqwurtVRxpln0YIsgkcVrR+LueE5GLLe7bTYZoQ==
X-Gm-Gg: AY/fxX6EUhhy8LbBd7iZ5zWnjns7tyo1aGaoQH68mEdVbT5TC3srGNv/qJKn9BeBXDw
 mQ34tu0MZnA8QW6Wz3r0Ax/c0MxaWVp0JgFi9zcujqYfnmrfLib+relnev2d/rq6wIN/SZ4+iWt
 pr06/GnKWTeEAu+fe0ND/BtJ98DNRfRF3yn29qy2Nsp10OWSGl3cRl9yF4pkqCHKfLamg8Wc6vd
 otnun0lfvjH5KomPA5tV3aZzrIIwK2DTAU0JSE+xPXEpcZ6rSPp8fF+iLtUaSEwRX0h5+nUdn9/
 O86wj+D3wRtCUOU5WyjiLD4=
X-Received: by 2002:a05:690c:2784:b0:786:4fbb:645 with SMTP id
 00721157ae682-793c52509c5mr28642627b3.19.1768570385794; Fri, 16 Jan 2026
 05:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20260116124005.925382-1-peter.maydell@linaro.org>
 <20260116124005.925382-6-peter.maydell@linaro.org>
 <87a4ydwuty.fsf@pond.sub.org>
In-Reply-To: <87a4ydwuty.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Jan 2026 13:32:53 +0000
X-Gm-Features: AZwV_Qg67UjCW0UBvmsX_N4yfWBCJxznYxyVjCBCwRXTvcw4kO1fBqw_Ph7ecLY
Message-ID: <CAFEAcA80HGxbESO8FwrHy967yXtVG1KMas=mWekaS436rrSamA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] scripts/clean-includes: Give the args in git
 commit messages
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 16 Jan 2026 at 13:28, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > If clean-includes is creating a git commit for its changes,
> > currently it says only "created with scripts/clean-includes".
> > Add the command line arguments the user passed us, as useful
> > extra information.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  scripts/clean-includes | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/clean-includes b/scripts/clean-includes
> > index a45421d2ff..b16eec0a5c 100755
> > --- a/scripts/clean-includes
> > +++ b/scripts/clean-includes
> > @@ -42,6 +42,28 @@
> >  GIT=no
> >  DUPHEAD=no
> >
> > +# Save the original arguments in case we want to put them in
> > +# a git commit message, quoted for the shell so that we handle
> > +# args with spaces/metacharacters correctly.
> > +# The quote_sh() function is the same one we use in configure.
>
> Not quite, configure's is
>
>    quote_sh() {
>        printf "%s" "$1" | sed "s,','\\\\'',g; s,.*,'&',"
>    }
>
> > +
> > +quote_sh() {
> > +    for arg in "$@"; do
> > +        printf "%s" "$arg" | sed "s,','\\\\'',g; s,.*,'&',"
> > +    done
> > +}
>
> Is the loop intentional?  We seem to always call the function with
> exactly one argument.

Whoops, no -- I was iterating around trying to get something
working and didn't notice that I'd left that loop in place.
The quote_sh() function should match the configure one.

-- PMM

