Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF66E98FDD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAm0g-0006II-TV; Thu, 09 Apr 2026 05:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAm0d-0006Ha-QQ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:49:11 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAm0Z-0005C1-9O
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:49:11 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6501c9903edso692207d50.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 02:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775728145; cv=none;
 d=google.com; s=arc-20240605;
 b=jhk6poPHRm/KKqjARUN1DSHCiDPnsY4LXnRsZCUk98VSZFwmpDYqGTeqWdwakbNuFj
 5212qzJFtvbqDd+R065IIgblOd7nxltouEASJnxVAOM6wau5k19d0sW121wqeC8yoEN1
 lB60rNtxaswHDDU6k3AJAXp4iVslH+AQ+3HXbyloOmH/HKO2BDUpZqYbhdyC80znNjLQ
 E56bUCcaf2q/JeWm0xjyXw80VcPwWp66gtQK3InQKngHHSKQd4dybg6oXvQBZryRH9Kv
 qxOd3Mt4ryrXG3Zs/mE+HhmPkes5/fOZxl+X1whZoJ7uREeT2hQPAWPw9W0lsA0ZbcHm
 T7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9zn86JHhpN2jvahbIxWbyAQR8YtwYAv7STXLiG4C72o=;
 fh=02SfmqVGy2oFA8bZbxp1GjutBIClQLGPcYudBWQ5+5w=;
 b=NDCkFEhtWgWdTS/gQ1xZx6SX8pdy99NmGpv8PRuU1XIfBhBZ3kN72RQMrEImU565J3
 mBdmt8gvUTq5gv1iNQqXRneXtgOj0AucMu6Et94RYcoQvo1FSPQYXMmiGcBxohvt6y5x
 536/mixfof3jsL++sdK83w5k9eo1Cm6RKmSUF04StsOIY+m/mlClWB7jCZVVmgfKVIl3
 j8Kv+obORlif4kmR8QUkD+qL478jmfB65Mx6q2pCHUNAwMQKeGfsz/7Pr+VsfiAmaqCS
 NT544zfTE8bzQxZSWqEeW2nz4WiZXsdWE3qzEFSAuxelbAkXa+g2vveUQUgZLQ+eyq/s
 mOxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775728145; x=1776332945; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9zn86JHhpN2jvahbIxWbyAQR8YtwYAv7STXLiG4C72o=;
 b=rIw+zJxsfqe9VDspnUWzhFn4udxfo6B3RRlNB7GgwPVCPJEWQR/uo/b1nygs0H8KBI
 XihRJSUmG7khjdm39ioLFwXtwjGVUHsRo4WLalpwQ9ggG2vlBhWJFsTYFfwMPUVZs8fs
 mHFEEUKNMLJNnA0RtjTRlagy2hCdOxZkpzIKpy5DyF2lTPMcpwxSrnw+CesWarwQWP0c
 wMj8n/aVqXEjdU3egAGdA4ZeINajTaun4YhOs/a0qZvmxQjQ+1XvAcLSkrhurQonzEdY
 Cr72/QerQEHeOB360ZRytw+sDOuFw4lAVjDX/+dH57gn/A3qMZ1H4jLSQbxNhsUfm7MP
 8zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775728145; x=1776332945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zn86JHhpN2jvahbIxWbyAQR8YtwYAv7STXLiG4C72o=;
 b=cdaXA4dW7ByHC3/hMgYwLKdTT/B6yskvmzS3y2Q2GV2OuFVntlx2pfxJkH/lN/cDCx
 5myvkhz6z4WD46EstV3iqToSUjrtCXiTtpD1XdLlCQadDJTeccmiInxkHE0smpZbYMnS
 SRC9hMrc0HXo4eFAbIs8VcUOS8NA5jUzBDCeCwWUbQhti+oXqnWYRZCNhCMNgCnA1lF6
 /Y9xiF44JNrPgaj0vGQc0WZat+GxEaeRsXKRiIHf5Rdqflo3w2RZi7ikS6Z1vBiyp9Se
 JpBf3vaclb7etNHfKCY3Z6//KEGwFqVeK5+mRyonCsruDbSEufY/Xi5aVOJhCdEyivi8
 72MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEu81PXM7h5qaDGOTlosHXt0AE9V3C6umz8wf2tQ52+YJFwFBRktooQzQ+XIky8SotiIFPY9DY2DIR@nongnu.org
X-Gm-Message-State: AOJu0YxDk0j/6hGXJzBIkKX1BwAl0zoeTnFfiTnDgEmCthXIOQQ2hs+p
 kBZ610BoYuqIelzpSrRG/xEQX+QsxMgJu3xtSBkULxj5Jp0W3qjjAB1IzEEXlv6k4xHB7bK5N4q
 SRSgzsEYZMZ2NEXgjjJ03y4t1R5Ufg8W4X3rZKl8wDSWdsz/8K88fDMo=
X-Gm-Gg: AeBDiesLI4AylJHaA1zenjNYkaxk5zrg0/r2TBgEjPRk0LH+tBmRektwpUjF8ZBUThb
 j2OyEEhHAYZfSnjhmKzBDW7GE9emetjLw475+ZAcx438/F58I5m4H2dBkhA9WqJLpqlAeTQVBuY
 AFf/sYPcZx5fFb4VPJcmZZmycPExod/OmkGQdCVVHdZzOyItTFYbIZJMQMAheADIxk9U7ZFAplK
 Uw3LSMafoimYn//qSYy0hJAkA4S8iskoQrMkE7u54T3d8CHPkc+UgR2Ym2Tu3gk0pOx/NevYgMi
 O9mweVtubI6QzHp+SMmAkmYw4dOJu2qXnpngbhy2dJ6CXCcrxtIR0kZN1v1oK25ubz8=
X-Received: by 2002:a05:690e:1557:20b0:650:3bbc:5375 with SMTP id
 956f58d0204a3-651875cb041mr1973757d50.17.1775728144514; Thu, 09 Apr 2026
 02:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260310162622.333137-1-kwolf@redhat.com>
 <20260310162622.333137-27-kwolf@redhat.com>
 <CAFEAcA_c_LOZmeMc7PvcUK4PgyAbzvrcVt3VyALRLtY6ECbpEg@mail.gmail.com>
 <abLmCCB-Wjn-mqh1@redhat.com>
 <CAFEAcA9caqp+JP_cq7Q0P3EPgWywd8BJCrngAKEBh6i2G7uJ1w@mail.gmail.com>
 <abLuKyQp20ZO1Rm-@redhat.com>
 <CAFEAcA_hYSFZGvB5sYQj_WkWx2ma0qm3z1ABzKCVr3Nv_HAC4g@mail.gmail.com>
In-Reply-To: <CAFEAcA_hYSFZGvB5sYQj_WkWx2ma0qm3z1ABzKCVr3Nv_HAC4g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 10:48:51 +0100
X-Gm-Features: AQROBzCAWcDZp79WzSdNxQ91fSqOkKxd59dp69Y_nsIiRZ3speb5TzdPOJYJ9vE
Message-ID: <CAFEAcA_o5x1yFDo9tsf+Kr_Hw5NJumtZLSYXzNiNU0D5aGiRxw@mail.gmail.com>
Subject: Re: [PULL 26/28] block/nfs: add support for libnfs v6
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Peter Lieven <pl@dlhnet.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Fri, 20 Mar 2026 at 09:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> I just noticed I forgot to cc Peter Lieven on this email -- sorry
> about that.
>
> On Thu, 12 Mar 2026 at 16:47, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 12.03.2026 um 17:19 hat Peter Maydell geschrieben:
> > > On Thu, 12 Mar 2026 at 16:13, Kevin Wolf <kwolf@redhat.com> wrote:
> > > >
> > > > Am 12.03.2026 um 10:41 hat Peter Maydell geschrieben:
> > > > > Maybe we can't get here, but maybe it would be simpler to handle
> > > > > the "asked to read 0 bytes" case directly without calling into the
> > > > > nfs library or allocating a 0 byte buffer?
>
> > > > We could have an 'if (!bytes) { return 0; }' at the start of the
> > > > function if we want to.
>
> > > Mmm. Let me know if you'd prefer me to mark this issue in
> > > Coverity as a false positive rather than changing the code.
> >
> > I don't really mind either way. If someone posts a patch, I'll apply it
> > (though not sure if that would be only for 11.1 at this point).
>
> So what is the conclusion here -- do we want to change the code,
> or are we happy with it as it is and want to tell Coverity this
> is a false positive?

Ping. I would like to know whether we want to make a change here,
or if I should mark this as a false-positive in Coverity.

thanks
-- PMM

