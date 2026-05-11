Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DDECD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSUJ-0002Bf-1u; Mon, 11 May 2026 11:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMSUG-0002BS-OS
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:24:04 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMSUE-0005qF-77
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:24:04 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-654672a6d68so4712090d50.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:24:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778513041; cv=none;
 d=google.com; s=arc-20240605;
 b=js0l91RIGBrIcCeKPHFv2mUVkVAHGDYhbgeu3tOLzqNxzSEEiRTuOHuEZykI0Rf21r
 5CDCd5UZ+Za3F2f36Un8BMW0QnjUY1bTp6OH9QpIfcg4EnoYFaiyzIXd6Y9oHW3xEDyV
 bRJJbpPqPrmVBjZOOaSxa9Mb6Oih9STXlY0zAwFwRQsCfiMekRFJVTIDjvR2ItzrD+/V
 2TG6U1OjcuvCk/CTyhiZY4qdrX8zBCteeS0+Dp50C0iwxYozS4hKJ2SUQPkGa5isamJw
 CpsWvTR1yyqnXun7TxH8SadedhN6FL/kBAS/tfRuUamdhge8qtBATJZjiMTXR0oIL7VL
 LIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=to9I4K59RgZvD9XQWzyiEINMzDjtVGDcdCilotWikqo=;
 fh=dQ/zZpV/UjydPHFW9W5tzZ2JBGcDD7yNEbkrz1Ql57s=;
 b=ZcsClMnEWi49aU1817oDHSXB9J3wrhyVLA1DhC2rVBwnVLKpaCMQCjWZBfOA6MM3zB
 OBmtMmLu7+IIsKRKafY4TDIb++KEwDofeDwJIPuDogFSyPhzGsTcPNOqDg8CsZV78v5i
 XfPA+TfAj4h6gzccnr16tfqntsZ5GtgpGU2q54AxpPD+TwF/yG2+jk7A5qlPmd5JoUMC
 uYDtTCUkte3nJwDxVlgXtYFOMD6zAslhWLMRWlU3JeiIrFWwIjiKqk+3dTpqvMNe+a2z
 P1jWw2StPNZdnyfoyRWcugf8MBTSPv7OJM45wALo4gTDnfWsId5Tb2ll/Qha+5Q/FJ0o
 cirA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778513041; x=1779117841; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=to9I4K59RgZvD9XQWzyiEINMzDjtVGDcdCilotWikqo=;
 b=O/gxyWP8C3bDGJKF+ygZOTREnC6rRP1oVIG/aW2ABVUQJ2uZl+F07JUDzjGdIFvihS
 yLdkwJdikt+wlYwcXAHmeyhGRD8vT3YkNrWR7STjUmMFXyTnJvgaw/pMJ9N/0lUMT+yq
 WRHNms/CfcMyvzkbhVpUn5B84kAM//4BLJDfDZJwDuOZDbum/UeW6lbHnFsP+VuUmv2G
 bYv+06ISw8QtzcLIEzsn1x/1etNuZ1R4if7quZjHcTJPm5/Al86HmvJIDqWZLk39g1aw
 mXjRXb6DMD41bcqP2MYmmSlhGehcmQKy6DcDGmt0EAbKtMmiCzAY7MKr05PJam8Nai76
 Pbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778513041; x=1779117841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=to9I4K59RgZvD9XQWzyiEINMzDjtVGDcdCilotWikqo=;
 b=GxwF9VQ2Izhg2pYTKB28ywNqCM7JHkqVa14yrj7YnfH+EpnEX2aH2pHmprbGL2cpVR
 dkPR1NfBZlC1VH2NwLO2zY75hGYMo7Sh8xp3x+9AwIMbNeudu1GJPpUtuxIaVnqMk+oS
 FFvIAtUEdAd2sxOJqCi81+cIb7ExZ4kRmGjUfVICg3aCwLkQpqFkEEyo1Tqbb8pr0AZa
 dY5pDoZynH6V+ifOQNlFIeYikRT8+DhXps3pecJtErjc0tbhTB8eOjN54JYwSyVVehl4
 2Wj5HuBq6ZBrSBk/A6T3KttE6iX1fMDBkJ1/6wCG2cv32ruiC/0UsKTiW+fKUujmz0P7
 jlTg==
X-Gm-Message-State: AOJu0YyL3wFtmxq+8eUJTmned5o5wh6a0fYdDDPRr3YipBrxheR6CwMH
 QlRUAHZA2SGPi8/GdWffm1RXkz65h1wv9NJf/T99PXO3Qw0ujd9M2mp9Bmwj13CNGhGdcwg6oKU
 g2laG8i3ZnUdhPhhgFWC7eXko0gp4OxaPA799QD6S4w==
X-Gm-Gg: Acq92OG+JLXw6XTghFp+Fe/mCt4gO8mC443nlZ99k9TY8fglAZt20TSQLLSiN3iUXQy
 PBnMpaNm8SMtvBN2NBHUlFalcpBAG3yle44+YuY7yUlw66iWetkpKbyuv7LjDl8KxggTv6hNH77
 QyrPD8iaDzuCLkqQ4cs3MV2ASlW7aytMvDqV1sqO3TxOshxZ5TN5bimcUaci1U6Qr7ta51dpt6P
 FUUkxpO8j9Fykslu7YTrrViZs40GKpBGoOqZrsnLq2+m+uRMEx53jHjtby+YZ0dE4xmYTT6iAJy
 UzQWRLWxXlvzChZWZyzrTXDd9jWA0SbRXyDFHEu2VnwUoFM+U78nfkyPBwi8isf/3zl4GOezmsD
 9Fg==
X-Received: by 2002:a05:690e:1505:b0:65d:4429:b6b3 with SMTP id
 956f58d0204a3-65d4429e005mr18652219d50.30.1778513040835; Mon, 11 May 2026
 08:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260501115506.3792110-1-peter.maydell@linaro.org>
 <CAFEAcA8QA32mcVOU+iB7Go40h_RwEtYKyZcOQT4nv1nEY92v+w@mail.gmail.com>
 <agHyrU3vDP73rLzw@redhat.com>
In-Reply-To: <agHyrU3vDP73rLzw@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 16:23:48 +0100
X-Gm-Features: AVHnY4LSvzo4xUwLBicLXDuWuUJzPcNsuG12DZ0s76UqM8UK1WgibL2rugLqsOU
Message-ID: <CAFEAcA_NwBiOSdC+3wKc8sLQ0JQueMDFK7UbMZ+4M6pn3yTCRw@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/qemu_test/asset.py: Don't use setxattr
 when it doesn't exist
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 11 May 2026 at 16:16, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, May 11, 2026 at 03:47:33PM +0100, Peter Maydell wrote:
> > On Fri, 1 May 2026 at 12:55, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> > >
> > > The Python os.setxattr() API is Linux-specific, so trying to use
> > > it on other OSes triggers a failure:
> > >
> > >   File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
> > > line 227, in fetch
> > >     os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> > >     ^^^^^^^^^^^
> > > AttributeError: module 'os' has no attribute 'setxattr'
> > >
> > > Since we only set the attributes here for informational
> > > purposes, skip them when os.setxattr() isn't available.
> > >
> > > Cc: qemu-stable@nongnu.org
> > > Fixes: 9903217a4ed013 ("tests/functional: add a module for handling a=
sset download & caching")
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > Is anybody going to pick this up via their tree, or should
> > I just put it into target-arm.next ?
>
> I have it for my misc queue, but if you want to send a PR now then
> consider it to havve
>
>   Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I probably won't have a full pullreq ready to send until the
end of the week, so feel free to keep it in your queue.

thanks
-- PMM

