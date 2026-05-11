Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA29FCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSgN-0005OZ-NA; Mon, 11 May 2026 11:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMSgG-0005Ny-Uu
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:36:30 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMSgE-0000aL-Pi
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:36:28 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-651bc83e74aso4587599d50.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778513785; cv=none;
 d=google.com; s=arc-20240605;
 b=hk+mIGYAkuQl5zT57SM1D5Q3nJWBl6/6CCs6NU5kXTimlptSnGioruIuJkUfhd3YYg
 v6/DKf7wIANiPbzifMZAnBo5swCJg2crhyhMvIzv2Bh/hQoFJVO19MqNlDUG90aVRkD3
 Jdkkw7rQWtpdfzDPz1Na/NYGwEr5oaDcoy3Zoxlvks9F9UjxymoDtxAv2eFbJJT6cmx/
 FCMqhvbQDayhw7JdoMkTf+F1pXH/skFelftAqHPimZUpiZibRwIGpAOucMyNqMKZ4Cue
 JC4wB3c7kd+DA4asiNDb0JP6O7U0peAYAyVGWwQ2jNGJwJ4b3VVt3fG5ePTDN2qS/oC3
 ny6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UAXPTf+CBdH/seoN2jt9okJOk9gv4Sm3p0JA94C8E0Y=;
 fh=8jLQ9BF8TzoH/ErGnlkH4vSIZ9SpUVgmQkqZ4x0ADis=;
 b=lJBNKMaB6sbxZ68T2/fIVs0fiO9hP8qKpPrFIo59sE2eY2VkiGh4inQmG01AjwBhDt
 7aUuuTsnK0ZP1SkmagGGxsj7O7fvuloyodcdL4vGJVdWPJI3lcxZM2v6GmgqTWn3e+GR
 261NPIPHliNVhQuqm2hZklk/hfrb1RbnnBgw/Tt5nHwavb4dxSS5LiXryMNnZywbnZss
 ENvs0v3iNVwGSKctRx+EmBQF4lZqDus7x9P8kPQKcQP9WgTTvAGXYVRI0rYcZ1hlKTP3
 29nB8xQ4ZlvtPgUBlJTylYJPkysZU0RQkvCQX3ywtmf9QLVjc3tmzKQJQao4mVdY/uPJ
 3IFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778513785; x=1779118585; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UAXPTf+CBdH/seoN2jt9okJOk9gv4Sm3p0JA94C8E0Y=;
 b=l8L8ZbtyyuzYBrDDCiKyo95HMujsmvNOFC+ClhrJss6WZmKlI0u+hE2mUMRsASIMFJ
 fu9E0OBxwfPHHPJ+wBaAc9kHIW9yOD1diawZIMuOrzfkF1x3ErcUNPD7v1tZAGKJpHeF
 1bf8SA7WEX2rR3LAz6/+QPQXRGq5W8DFMc37TMCPEg+Gf+j4XrcPUJW17G6W0L2H4ueU
 v8Xe1HwM1guZhbw+80E1nGHuPUlp0k9VZXcM6G6ZZRoqOeyJji9SqiOOOEwVGWIYGQCc
 sZqvtK8Ou81iD7zNXkSKUt2zA2npAFdU6yYcCiAboM9X0ZF872/9yGO8qTMANUMGFXdy
 q14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778513785; x=1779118585;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAXPTf+CBdH/seoN2jt9okJOk9gv4Sm3p0JA94C8E0Y=;
 b=JlRsoyLYQX8N1zdmBm9EsA3S87H0qfkMAc0iOm+w/Q4H2tTekHo0qOcAy2gSQQs+Nt
 GtuNKfa/qFRSZO4joExxsgWJ95oj8eyBbfo3w8ywgnbhEXfuxLhIKtBS5XQg6mjFVV31
 gJvmaKMEWk8ZmanDvEelMRYphy3mQXP0ahQs+pw2TEtzrOuiYZKJCm1pO3ObUYl0CCLi
 EWVxxbR13jkQ78uZdBhwFyJQhVTP80z3sPHRIn2PuxUlAkPxM4XrYj0PYZfuqnb7djy+
 P6Ym9CNtlfrdDGpNCqSPkHX7GCc2iBsYZGusWPuB8zEsmQemDoLRgT/6RqVS9OUiPtyQ
 igUw==
X-Gm-Message-State: AOJu0YwfyQn9xdhRa5KL/WgQ1BmevD3NSabYK+bC3ZZnZLt1/Xh8bKjg
 iFf8cCa71PvHGOflSakC7KjlPnf3c1WNdXw/M9MVp8WOaoYAlQyEpHDdUPA7+FuhQhtQzjvQmud
 DodM2eJc4kiJt3P51yJTXkzU79C1jueElc+df4O5VmA==
X-Gm-Gg: Acq92OGq4oUIKdfNkveQCtvandqi6KlMaGCzTLge/dA8elU5NjJ/kiONzcE4DNN9hDD
 jeamduL2seiFLT5Qa+ENzTfgHHdo0VFAmDVzqJYWu+T4VSIPYk7ZJ4t4r6SQg0+SMsURKfwjSDg
 aMn56M4JJ1HHaZcaGUSTpTK6yVvY7abKvYBH+Wa7UR6AgHtmGoULD0roGfNBAxcewtITPVJGuui
 5fly4eItZ2cedUkH0f09vw16C+0tJ1Mg5/hRkpBx0UQgNLkRxUpYDzbKeVCWGlyPQ3biR5OYr4h
 8kIvqVZA0oU7ZF2mKTVWplMPPyGxjJOYA6YYChGT0Ziehc+5ZapbLRF/mX6cvcPUgqui8BOH7Zz
 Rwg==
X-Received: by 2002:a05:690e:b4d:b0:65c:2ac8:ec43 with SMTP id
 956f58d0204a3-65c79c962f5mr25447022d50.19.1778513785088; Mon, 11 May 2026
 08:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260511141049.1293449-1-peterx@redhat.com>
 <CAFEAcA88Ui1tG0PEwbwSnSBMaywMJEy5bLLVwXvGdW_06pgJ0w@mail.gmail.com>
 <agHs1PcxZYJtba4W@x1.local> <agHzQnXFQbnam-RF@x1.local>
 <CAFEAcA8L_BgfHEUnJhWCJ9-aMPUadbvQWGrF2UAW8vE53JP=6A@mail.gmail.com>
 <agH19jdl3UYZeStj@x1.local>
In-Reply-To: <agH19jdl3UYZeStj@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 16:36:13 +0100
X-Gm-Features: AVHnY4JQSc0rnYnUBxAznQHPOxf88Ui8ZteeVZ1ECPNd6yeWW0sTnVtUTOaLYI0
Message-ID: <CAFEAcA9TaEdhofTbR++PSV4PFxYZyapJSz2-fsqORNMG31ifdg@mail.gmail.com>
Subject: Re: [PATCH] migration: Fix possible division by zero on calc expected
 downtime
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Mon, 11 May 2026 at 16:30, Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, May 11, 2026 at 04:24:24PM +0100, Peter Maydell wrote:
> > > This actually fails to fix the ubsan issue and I can still reproduce,
> > > because the ubsan issue was a Nan reported, where it seems when Nan found
> > > in normal such evaluations it'll return FALSE.  I'll need to use:
> > >
> > >         if (expected < (double)INT64_MAX) {
> > >             return (int64_t)expected;
> > >         }
> > >
> >
> > Hmm, how do we get a NaN ?
>
> When mbps is zero (when it reproduces here).  I have the comment in v2
> explaining it.

Oh, I think I see -- we get the NaN if both s->mbps == 0 and
also mig_stats.dirty_bytes_last_sync == 0, because that's 0 / 0,
which is NaN. If only s->mbps == 0 but dirty_bytes_last_sync is
not zero, then we get +Inf.

thanks
-- PMM

