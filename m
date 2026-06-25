Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0FECDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcjVN-0001ts-ID; Thu, 25 Jun 2026 08:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcjVL-0001sP-Vn
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 08:48:27 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcjVJ-0000ST-BV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 08:48:27 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66421007afeso393363d50.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 05:48:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782391704; cv=none;
 d=google.com; s=arc-20260327;
 b=aWvG2lt46cUmc6tU/WmVayMRMxlYSmIUWsm8XlpgMD8kOe4KKPWU7owF6rHLwLy4rO
 RNBt6l7MNm5asmk0pConkM4oay3jxtCxENZEL7YEulYhS2c3gmSSd1NUmu41iL9WSSTZ
 ks162qEFwoBWbRjDUKHgatz3Qzl8c7gskG1ZzE66uNpWN3kLGq5k9Hv1LTouArv2i80d
 fF7GB/lOtpwUWcSe+WykHwWwb4rQNlkJb2OIrbqCaD6MVYg/3zhNjB8RSW60iSTjj9uR
 k3Q0VOnq25UrSenFJLba+gkzgCXksHYb/bftxhwTJfc8Ck/ztpLYtOSy5XQeHoxLjIBY
 Ddxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2M8Prvp9m3uVSFa8NYFepSbJtbl5vqEVMu3cpQDBjR4=;
 fh=fwToTDh3FCR+4280u2ma+OVkzzhDdisGJFuCLIGUH30=;
 b=iqHmHzTO+Y36GGBwFuGEzSZ/MQ7HWtJnMxLArRZ7d4qpidbmd/Al1wxH5ZcXahF0bM
 Q71INrMgpr0COVsyXkeeByPlAx5NYvBZfpSJcIFzYQfHNkD/9WAdZysgNinDFrTGA8d/
 ++FZ/hGvyTwMkTpAfaOkIzSWjJOf5GnweOP1cj3TUinlFHgSDGgZWWljJ4cn3DtRDJF6
 u04eI4CIWIbHRBPTXxBGLiZNDPFb8/KldM3xNF/KfCxL5gB3C/m0rS3rKan6PRfUUcI9
 FjbTVEvuBdnzTuAZfeMnVsPpahvD6KyDxvUgGTN8WPJNKtlEJHgzk87noObNkd/pvQV0
 0YzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782391704; x=1782996504; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2M8Prvp9m3uVSFa8NYFepSbJtbl5vqEVMu3cpQDBjR4=;
 b=mPWQlUgAkjFxGFDLC8sN7EnwLyUMpNaqN3HqRpw8yQcxmAfRfEDLxy67GqpEa+ryWO
 EXnc51u0RfzmIGls7LH70ZTrrm1CgrysCEzGLqGiox69ncbllNEJsSe9WPCgdCNhUjaU
 cVL07UZGIDDY4CqodUapdZH2R1DqOPBidq5gjCdhnWEa0Ez3Qvph02ahmfbhh7V5T1aw
 mTVjKGYvms8wUvTz2O/3Z0i/BzPNfiTgqK69kVxs+Of1q1MLNASJgywWMw6eQwtWbHjK
 P09TyhAMoNM3KwlEE4KNcrtv7uvWbf2Nw+H2gSegsvZzsc7HG7Kj9bHdY9Ws1p7Cx65P
 danw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782391704; x=1782996504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2M8Prvp9m3uVSFa8NYFepSbJtbl5vqEVMu3cpQDBjR4=;
 b=QvlmcxNCYFUlIlDYIs5cn7XNvb8cJh8oMEA77mgkiuItz86lGQstscn67OeBHCMLe6
 98MAUELAYmYpvx2elKlMC4X+KRdT9adDfe2dHMUKKYqTLwKI5R1RNDNEfkvNCuZcRxAM
 n0DLLPn+t3kGCiQaOcMCfajwMIgvmpMMI6RSmq02AHoIT43vKuf0c81OQEd2wWXQuT2k
 Mlogt74ZNNJ5+jqjZhruwtAFjN+rNR/IwN3vg5jB+6tqM6hxROtvbBpYLpsoII8eQ/IU
 rvxpD1bnokeH8MzV9o6cH0GGLp/YKCWe6FgVZns8Fn3FSCnWWFj9B7crYTfczplp5+lM
 3Qvw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/eFEwe6DQ+m+UNXDVMAK7FBhFcgQ4PVEHyyCJoCR3yoTDx1cf1j6v+lvs8R9lnEQQsdR/JA1nG5ix@nongnu.org
X-Gm-Message-State: AOJu0YwJMbE/Qv0mnZiBBvvr6Axk2U0NHJMKQwBr5ngutt1qfkOm2/A/
 tpJbiSVJwGohU/aam63Yvh9i6vSZI1a9B+PwF+3Ow96lSQszuUYbpifZbZQOLD/gpVUb4n0Y+LP
 jWKK4KeqRYcn4Dj+HY1qRB8NddDfA9xHOwQl+4halDw==
X-Gm-Gg: AfdE7ckFZJJUYzM2+6eZ9VHAGfUonKbQzeb40IsJ77aMKLYktCzlNTccpxD/6cvCVEc
 LkMat1fXJz0rq/VXl9fPi/cg7fEICb0tHJUJC8bAihGp7+dkOwhZ/vXtkm23BUSFYXWCr8Hp5lU
 PDJVBt2kVWgh8liC70aC1YNPn6LPYpf0s4bjgRKwfLfAd/Vl8/Qyy8kyyXVTeKPv8hUsTs1+RcD
 Mh9RpHn2yAqTglSVPlAqlMbl9e2pF2gLQwk1u67L0OVpTUZ7fLEVYhGsaoyqEI4HaZAP3A38ajJ
 OfW//SDZAuiKbwd5idPbMfyocGg9lUx15B1Pgl6kE5mwvHWo1oLjN48J
X-Received: by 2002:a05:690e:1343:b0:660:5ce2:58e6 with SMTP id
 956f58d0204a3-66487da95b9mr1771538d50.21.1782391703646; Thu, 25 Jun 2026
 05:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260616052552.389021-1-gshan@redhat.com>
 <20260616052552.389021-2-gshan@redhat.com>
 <CAFEAcA-mf14=jpRFHarAbN6AbQwvW=Yu6WB1JiNMsECEdaxD3A@mail.gmail.com>
 <20260625070551-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260625070551-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 13:48:11 +0100
X-Gm-Features: AVVi8CeCovs8jAjvqsIXu3fx-PR-A4o2gQNd6t3Lr2Uz3uu4t4hZRrtwTkB5EkQ
Message-ID: <CAFEAcA8YJZq9TqrUd0zTnewAdVDm5y6UV7BJQZ0C60TZ=RT98Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 peterx@redhat.com, alex@shazbot.org, richard.henderson@linaro.org, 
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com, 
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com, 
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, 
 shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 25 Jun 2026 at 12:07, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jun 25, 2026 at 11:09:26AM +0100, Peter Maydell wrote:
> > This is still wrong. We should not have "x86 magically works
> > and all other hosts do something different" ifdefs. Define what
> > semantics you need and then we can figure out how to
> > implement them.
> >
> > My current thought is that we need to handle accesses of
> > 1, 2, 4 and 8 bytes that are naturally aligned by ensuring that we
> > do exactly one host load/store of that type, and that anything else
> > is "the guest isn't relying on specific semantics here, we can just
> > assume it's plain old RAM and do whatever". That would not
> > require any architecture specific ifdefs.

> Well. X86 is special, as usual. It allows unaligned mmio so
> we really have no way to know an x86 guest does not intend
> just that. That can only be emulated perfectly on x86
> which is sad but I see no reason to actively break it.

What actual hardware will rely on unaligned accesses
appearing to it as single unaligned accesses?

And if we do need this, we need to specify:
- what are the semantics we need to provide?
- what is the use case that relies on these?
Then we can see how closely we can match that.

There's a lot of extra complexity added in here for
something it I don't think is ever going to matter,
and having the most common host architecture take a
totally different codepath from everything else is
a recipe for that other codepath breaking.

-- PMM

