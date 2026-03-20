Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E35C108B8E6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3WVy-0002dq-Kq; Fri, 20 Mar 2026 05:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3WVY-0002Pj-Do
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:51:08 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3WVW-0005QI-Hk
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:51:08 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64e9f79cae8so1425792d50.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774000264; cv=none;
 d=google.com; s=arc-20240605;
 b=Q5++Y/M/rpp7dDZWCKshbV8B0C/fejYz3yKPyA1E3jYwjY+OMdhvxhfEcb+kUa5aB6
 QByac9ehvCAG9BnJXMc7+EHIPDM+9koF7JTK8zxo4A9UqASDZlqvSYZQmwgnrlzL9XRA
 CBVfi7BbvOfDlqkFwXiWPZoKeRzSiE10+Pu8QRtbCwaSu0zEwNDHR1G0zKcgIY5bgufB
 ePakYWciwA0G+Bo/VTas7ppxCAvLYX61rP1URMIMq38MbVcIdi7to6VABG990/PUXOdc
 lqq8YEYwiR1pjsslKny4ZvI2Mv0YxXfTO6Ug+tSyynjUsv2PVR+ZPgwZ9l5t7pTMhQ42
 8/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k49lmc10GwSqyOqdF6+WBDogs4D/xKr6E+uJttr6DbI=;
 fh=L9H4KD3rYqpb1JDjzoxTzryIUg9sQ/XorfmSDTfLHJg=;
 b=B7qTUcNWVTEsD2kyZ1+pKosf8r3S3R/u2/AoVKmIeIB3b8bQbEdVYT6lqzbIsaqzhN
 iKDFhm5vMu2r1yKV316XJqwQZvUIMbfEHIL6iggfQhyiwHbDvZ2OoorZF1z7WslxwPjk
 M11SL8WZH7kV7zDA7+tIJVGwmOlfiUKij9KvU59mN/ManvxSeaYDjgKc0jfglzgYiEIi
 1qiuxymQfd/7PT1abtAvtw84JICBAtn6vbPMsWyIVywB8d/D8S/krJ3usWKxcgOL3Icd
 yFe3fKgflI2W4+k3WTrLsUZqU1tffEL2aInY4Tm/Krv07F1vB1t1vERv49Bk5lG55AQB
 xRdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774000264; x=1774605064; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k49lmc10GwSqyOqdF6+WBDogs4D/xKr6E+uJttr6DbI=;
 b=K86D287oklx62xu1e1mwNuMcCof9ZHVXM0t2ssigSd1a5dG5b4kbzbmFHk2oUsKQxe
 icgbcm+xwdu9R8yjLTHlsSyZnGiKVWz4V6q4bM/zUnNpu40gUX1HQlH1fgt9xgQSnmYO
 OYTpzYORrv9UrBbzutqwvGI6bsoi0S7F2ALrZQyPT/KPDQQrToHS5pKxCog1ix2C5dZn
 FxMP6FrYVDJi6SLmKqfEl9nHdKUkbsAktGiSWxpFrJwSnoo81+ZizTeLJQTqCB5CAMzA
 VCWbInOO1WQk8htb+NiRPUJ+Ioz9V4NSDrrM/pElH6Ir86tAA6dvtllb0AaT294AxdrN
 j3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774000264; x=1774605064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k49lmc10GwSqyOqdF6+WBDogs4D/xKr6E+uJttr6DbI=;
 b=aVIskso8hZ4yJ9+ZlvB0WhCE+qMhQ8d51FAuVYW3VtR/bVLNNDMJ8MmTL5P/S6w6dW
 ChJa1NIBgGnn0TAsEo5L/qArNM82f7YCA9RuI62fK5V/jtuQtz1u/8saQovARK2nsoUu
 epjoonynCjfyvkSj+0knQC0KK20v+4o54qU2CU1nHpsyI9UWaL+kJAM0KwMe8aAE5+YZ
 XTuEFt4b/U6iZJOO8jkycBTvT18sb1tA6c5flN3fgx8wNh+ktE0Y+7TSvwBC6DkKjYYZ
 pGGu5cuZCeFyB0IOLsVYaIP+xUBTm6ronoSF1lAQIIcEEy0APyZ1OJX/KCMyCsN9DedQ
 G/iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqMXtI3nDINbdDVIz4kFuj9iflleEPEAFXUzL8gyLiv7LGTrJ9EWIOxSjgbjMljfy5kh1XgckGC5yD@nongnu.org
X-Gm-Message-State: AOJu0YytJngIGhgZupgKR2BvVoXsojucC6seaBWenLsMKSb5XH9qJ3CB
 in9w6AskWQlp+tGRWuh/bkuxcw8fjnNy6Rk08o9KsF4UT2H88LkCEBfFmldtFtWd42cN5NXd1cT
 lf9Ehq/RF51C5s/letClXkr/rCbfZIx5mS34/xZd2iw==
X-Gm-Gg: ATEYQzyvOM+F0hzUJDCLkf/jj6jyKi+aghOUbbdemiMNFZ68E/cR8aY8szGomZkwSiv
 GtM+lQojumV6eu4mFgosOynff/bnjZKauqFsplOg9Ohl5isHo4u1ScjfYtR85DzT8rw20Hr1XLj
 MCWNrX2CuwwjadbdlBKkECF2hg3c0lH4nwN6IIaRfbRMql5Qea7HObg/fdAeVh+ibZQO6s0NW3l
 3N2jKf9NHS0pGPltnxqTADi0Nw8iViSW8ApeLivgzEK50E1SQ6gMDMVH7k9sUpihHpYMFqvNDek
 RLF3slLI22Hd8W5a2AtjkFTXLxo+awtnOTJIJjCc2GhHIRvc9xFD6ddys49IUuPC4cs=
X-Received: by 2002:a53:b442:0:b0:64e:a119:cb50 with SMTP id
 956f58d0204a3-64eaa6843f8mr1898898d50.3.1774000263968; Fri, 20 Mar 2026
 02:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260310162622.333137-1-kwolf@redhat.com>
 <20260310162622.333137-27-kwolf@redhat.com>
 <CAFEAcA_c_LOZmeMc7PvcUK4PgyAbzvrcVt3VyALRLtY6ECbpEg@mail.gmail.com>
 <abLmCCB-Wjn-mqh1@redhat.com>
 <CAFEAcA9caqp+JP_cq7Q0P3EPgWywd8BJCrngAKEBh6i2G7uJ1w@mail.gmail.com>
 <abLuKyQp20ZO1Rm-@redhat.com>
In-Reply-To: <abLuKyQp20ZO1Rm-@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 09:50:51 +0000
X-Gm-Features: AaiRm50cr6gc0Q7Zx3dKJbxklUNCTlAo6cQCawVcFSiIucjwhK-5-pisjOIiTAA
Message-ID: <CAFEAcA_hYSFZGvB5sYQj_WkWx2ma0qm3z1ABzKCVr3Nv_HAC4g@mail.gmail.com>
Subject: Re: [PULL 26/28] block/nfs: add support for libnfs v6
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Peter Lieven <pl@dlhnet.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

I just noticed I forgot to cc Peter Lieven on this email -- sorry
about that.

On Thu, 12 Mar 2026 at 16:47, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 12.03.2026 um 17:19 hat Peter Maydell geschrieben:
> > On Thu, 12 Mar 2026 at 16:13, Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > Am 12.03.2026 um 10:41 hat Peter Maydell geschrieben:
> > > > On Tue, 10 Mar 2026 at 16:30, Kevin Wolf <kwolf@redhat.com> wrote:
> > > > >
> > > > > From: Peter Lieven <pl@dlhnet.de>
> > > > >
> > > > > libnfs v6 added a new api structure for read and write requests.
> > > > >
> > > > > This effectively also adds zero copy read support for cases where
> > > > > the qiov coming from the block layer has only one vector.
> > > > >
> > > > > The .brdv_refresh_limits implementation is needed because libnfs v6
> > > > > silently dropped support for splitting large read/write request into
> > > > > chunks.
> > > > >
> > > > > Signed-off-by: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> > > > > Signed-off-by: Peter Lieven <pl@dlhnet.de>
> > > > > Message-ID: <20260306142840.72923-1-pl@dlhnet.de>
> > > > > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > >
> > > >
> > > > Hi; Coverity reports a potential issue with this code
> > > > (CID 1645631):

> > > > > +    if (my_buffer) {
> > > > > +        if (task.ret > 0) {
> > > > > +            qemu_iovec_from_buf(iov, 0, buf, task.ret);
> > > >
> > > > ...and down here we use 'buf', but Coverity thinks it might be NULL
> > > > because we only returned -ENOMEM above for a NULL buffer if bytes == 0.
> > > > So we might be here with bytes == 0 and buf == NULL.
> > >
> > > Yes, buf might be NULL, but copying 0 bytes from NULL isn't a problem
> > > because you don't actually dereference the pointer then.
> > >
> > > I think the part that Coverity doesn't understand is probably that
> > > task.ret is limited to bytes (i.e. 0 in this case).

> > > > Maybe we can't get here, but maybe it would be simpler to handle
> > > > the "asked to read 0 bytes" case directly without calling into the
> > > > nfs library or allocating a 0 byte buffer?

> > > We could have an 'if (!bytes) { return 0; }' at the start of the
> > > function if we want to.

> > Mmm. Let me know if you'd prefer me to mark this issue in
> > Coverity as a false positive rather than changing the code.
>
> I don't really mind either way. If someone posts a patch, I'll apply it
> (though not sure if that would be only for 11.1 at this point).

So what is the conclusion here -- do we want to change the code,
or are we happy with it as it is and want to tell Coverity this
is a false positive?

thanks
-- PMM

