Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BAEF46139
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4h9r-0006bH-TN; Mon, 23 Mar 2026 11:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4h9k-0006Zj-3g
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:25:28 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4h9i-0002wt-BR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:25:27 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-79a46260385so3439257b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 08:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774279524; cv=none;
 d=google.com; s=arc-20240605;
 b=Ay+IvQRfLuNj99k8Lldd0NJqQw4q8Z4t24njYnBWqGJnG0TvcZjr1GvLPLL0EBZf15
 ZHos1MpYqOLCLyR5ie9TeBUq0VkbIwOWMgngwB2y2qy+cOiDShLcNUMbw99Uu2Gd3oN+
 PgMIFvvmSfr1I4GcNZHl9qq3iZ+eONw+z94upaO914ha4w1eBoozQ1tSWTtdOeR1V6oO
 /dhg3Pyv+KDtokkxlSgXstw7xr+qCs0mNThJw7VanYzV/wZthTpT5N/iDSeni+Jel8ut
 1fcdGyvofD/P4OHWIlb/Lf+RKnc30N1jRCaWQLgBFwjBIg1t1PmEmzHRjVIVAwNGofwC
 GsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E8qW0zsK+rUnQLR4W4uc8v09s3ivi1irOgw/UH62E9Q=;
 fh=Cj3JRfgXXZ0yfArZxnQNlKgg3RP+BmJc+pmlGdXrQ3c=;
 b=T019essHMC9zEv0gtP0Af0aWH2UyPdHaWUE/fRTs7Xg67p9hGf1jer8HHHEPbnl2Kh
 d/ID+uKk2vamz1KDvDorvE5eywWHQKFrgL8cdPJB0IgxLU41uqyO1X3dyW3iqgB4cKUY
 ZKqiKuCgjl+UjsDDXvUnC9NyRDhyN0wjopFaeVuQX4zDjVU2OaRfmbngUjgh1ZeB/S/G
 X+E0TQ3AHMBLAWyN5TQ3/+99tV1hQ1tYwWKzclwr8CLty5uiqFUXOulWSV7i8i2+6cNN
 IjarChpX8wpD/enS345Y59TVDlpWg9Pt66StO/sK/iViNr19ycvZhZ7Dw3+ZfDiipb6u
 hhXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774279524; x=1774884324; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8qW0zsK+rUnQLR4W4uc8v09s3ivi1irOgw/UH62E9Q=;
 b=gVXsNnR8OEBjnLfhssx+92Vwogne1E6ETG66N4KA+rBYVak/KCh5vlhBnXxGj4MiIL
 dSzdInlL3zCSpPwdr0mb2vifFSzRLoNEfUHMzyt/IL1ecHAgznbUbya/NgnDpKCNUhzg
 aGS/t05k/nE9COfiisRtzw8f2hNamhD7nHgr3bKKIGSTKLpqltKPlMd4q1tD3l5D433J
 MU1jIe/Nd/mHHg0yDDv6Pzr7ItIL7TAkyyHrIp8dAsuS8dKZvUAmF9XomfLzfszklZWm
 l3zRhOrL4FLu+GyjrZYEJ5sMdMgOK19owaFlaSVR6Kk+ZCAFZv4Qrr74vzgHvKbq5l+D
 v2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774279524; x=1774884324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E8qW0zsK+rUnQLR4W4uc8v09s3ivi1irOgw/UH62E9Q=;
 b=rGeWiXJ3vNd/musKfQyVRk+Mie38e4lMtEZze8aSCEt6w9TMSs10jc2v4A87tMk9L1
 WFueY/+hWTRmamHKpgzoUJ1cAOvmutuGNSh7agY7xAKWRPjARXam1NCAfjnxGUQWGIda
 JWxG7649KLVTYCi0xNBAvABhDeEcMEDZZZ8U3FMxfApG3qxtshbEEozRrL5mX++wEI8Y
 OBZEjO5zkmAmnBYZ3aLcRvZVW9LOYkPdba5Ylp8gdNBl/XR44QsqEs0YXiJIArCiIFbd
 P/hlJGcMbd7HUyM28HJyGYdJaHfHKcOllFjuh4RK6HBjh1nLkUh72FL7Qsk85+ly/h2/
 r7yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ68GRIeq5UmfzBfb38ICmFRzN7Ex9+MDb1Ia7dfBoMCcshwo9/XWOqzLyWcRR/HpcAz57+d3swu3r@nongnu.org
X-Gm-Message-State: AOJu0Ywsz1EX3LZ14ZyoBfMTiFrA1GZXJaobB2wdjSdgUvi0uyIaE1W6
 90r7nhpWb+xB5XeEAnkaoXhzKjLBcrNq7//KtQ+FIalvKtJXy2YpzY/f6rVB4J3TMNGmf39rqej
 CuOD8fW5U6KVI0pM1wuXy8WXMYxvJOjynOX8UCMzklg==
X-Gm-Gg: ATEYQzx/RXIKAgV5Ou39HQVyXD/ofzsV12wMHKLNkdVnj3MtYxRRaRSJznf3mzt001k
 dbQRuPwQbPFPSmfRuEE9NydK4ckB4rMiQSgVP2An/mbFSrBsD5dVAUpepCSjn1fk527Q16V876V
 QM27SVZvMWzvbPDhqnjLqzpsHjWhVhFL5qclyQyhDQ7nqqiX+/h2TiVFoKVQkS2gCXSnLmSIXaa
 7Ob1iRTse8EAxwFbueguedvwAWDai0H5OoqWU+LHh3O0mFHzUzh6WoGbd2UuayFoWb3m5xlR14c
 ZOj4RNQiqSwdJWY32/Az9BR9+8+pdRkJWEcezE/+G42WdSjhgHppNibPPWTmrFPqL7TDUX3lHhN
 urA==
X-Received: by 2002:a05:690c:c4e8:b0:79a:3a33:942 with SMTP id
 00721157ae682-79a90bc99c4mr141604247b3.31.1774279523669; Mon, 23 Mar 2026
 08:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260323131531.1976-1-junjie.cao@intel.com>
 <acFDFHsh8Rjhfncc@redhat.com>
 <CAFEAcA88mHqmM8Pmm0Gbbeu4ugBV8snenZh7bvjSSruUtRcywQ@mail.gmail.com>
 <20260323095706-mutt-send-email-mst@kernel.org> <acFUnqeSF2RMDiIe@redhat.com>
In-Reply-To: <acFUnqeSF2RMDiIe@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 15:25:10 +0000
X-Gm-Features: AaiRm50GFWTQRhMiXjbZVTGPpq0t-EYnYu8pGOT5hoyCozq4b7DL-2pVQz432n0
Message-ID: <CAFEAcA_QV3k9bbayQh76-ASdHiJeWNSGY32DeDZJ0UrrC-WXLg@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: validate RSS indirections_len in post_load
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Junjie Cao <junjie.cao@intel.com>,
 qemu-devel@nongnu.org, 
 jasowang@redhat.com, yuri.benditovich@daynix.com, akihiko.odaki@daynix.com, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Mon, 23 Mar 2026 at 14:56, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Mar 23, 2026 at 09:57:24AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Mar 23, 2026 at 01:53:53PM +0000, Peter Maydell wrote:
> > > On Mon, 23 Mar 2026 at 13:43, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > > >
> > > > On Mon, Mar 23, 2026 at 09:15:31PM +0800, Junjie Cao wrote:
> > > > > virtio_net_handle_rss() enforces that indirections_len is a non-z=
ero
> > > > > power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
> > > > > virtio_net_rss_post_load() applies none of these checks to values
> > > > > restored from the migration stream.
> > > > >
> > > > > A crafted migration stream can set indirections_len to 0.  Even i=
f it
> > > >
> > > > The migration stream originating from the source QEMU is trusted.
> > >
> > > Is it? In https://www.qemu.org/docs/master/system/security.html we sa=
y:
> > >
> > > # The following entities are untrusted, meaning that they may be bugg=
y
> > > # or malicious:
> > >
> > > #  * Guest
> > > #  * User-facing interfaces (e.g. VNC, SPICE, WebSocket)
> > > #  * Network protocols (e.g. NBD, live migration)
> > > #  * User-supplied files (e.g. disk images, kernels, device trees)
> > > #  * Passthrough devices (e.g. PCI, USB)
> > >
> > > which explicitly lists "live migration" as an untrusted entity.
> > >
> > > I would definitely be extremely cautious about having a threat
> > > model where I had to distrust inbound migration data, but the
> > > above does suggest we aim to handle that, and we have I think
> > > in the past taken patches which add sanity-checking to the
> > > migration data.
> >
> > And we even assigned a low priority CVEs to these.
>
> Do you have an example of that ?

Here's one from last year:
https://access.redhat.com/security/cve/cve-2025-54566

I vaguely recall we had a set of them some years ago too
(probably somebody specifically looking for flaws in the
category). https://access.redhat.com/security/cve/cve-2013-4536
might be an example of that.

-- PMM

