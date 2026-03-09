Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70566F417EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbye-0006HA-4R; Mon, 09 Mar 2026 10:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzbxB-0004MA-F4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:51:32 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzbwy-0005l1-Jo
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:51:17 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64c9c8f8783so12055302d50.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:51:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773067874; cv=none;
 d=google.com; s=arc-20240605;
 b=VvB+fpWcf9FwGl9GDmSVB6zNyFCIU6JulMtlW/9g7vc78MlWet1DIvB8o/Gy5jiqRI
 rekfJLKmGmmzziz6zKoUXLynw8UIr3+E0aKUxBUVUn6rPjNylC3jB/fN7/ZPNyKjFWaY
 8Miyi6FKBopmM77PXvss0TTnATiKz3jPJEHPB2owegMvlMqEK2RT8P0pU29MKK4Vyfb8
 ECiib877wnQTRD7vEWdmykbwEF1zmMPbNytHSc93TTVle/bk6O4UDN5AnrAnL9IzMkNw
 9MMpyKu1GYIm4fjG/H0D8ewPUM1ITsDC1CvgtzRgehaUVTF7IoZXpVuF8B+8kSemL6RE
 6aaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hyrcphOVQL0dygw133ui1GYrItXGc/yKS+jiTYl45dU=;
 fh=XsCuyVCClwzC3g0/HjNJCl0xXBoL/U1P9oiWgF34MTI=;
 b=AoBFdX8javuvVORUa51CweBMTwUUl+rS8Ro9BpZNoQMXZPyOaMlcaYcRsVZrGj9qYf
 6dMk/n/S+0OpkUMw+XhUSdPLjy71X3OG0gGUpTLD324HNKVCKEoh/Xoz+5qKzz+x90xn
 DiOBvf1QWXgHWWiHF/3W0xEMSiBLpSVPCP4NG47/XHvHceakfhkKvEaRYsj/Qdt4NRhi
 l1GtOnjupzJZMn42o55wNOyH2TfzS5U+JqsjfkFzJOLcrbSWfw3Baz3CBZIjdTfutbmK
 ugSQ10jLxFG8dRO2X0zKUX4SfS4+MSHs9y59mC1Li7/6aoEMABXAqrV1pjWGTQebqhTt
 N3IQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067874; x=1773672674; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyrcphOVQL0dygw133ui1GYrItXGc/yKS+jiTYl45dU=;
 b=W1H5+WAC7gW7fAu/9HxCvE7Pyiig6edhPJHa7MN/ehU8bhYXj94NY8wm/qw9Efa/bm
 FoJ6XT2kDUNll23ZcyFpYHurpzsymqU7xK0CqJR/l2RdoQMlZPquTdPu0P3DTYNIi2eY
 oSJMS+XMSWBfv2JwT97FnEB6y330eZ1LHroj+SfR4wfnzRQzc5ddrdpX/uEyLP9txp1P
 kQP9f5T2EroN7yyua7Z8Kzsd7qdEoaPjNDjpanSg6/7gHZrtZ4KrZMWd7CKD510hhuO/
 f2DMo8B/+n+itzuXZDJ9Luy8LK2WKDOMvzi9cQ1HmlkyD8Po4k3tbfNkjnVlpQjd6yiz
 R0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067874; x=1773672674;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hyrcphOVQL0dygw133ui1GYrItXGc/yKS+jiTYl45dU=;
 b=vp1HvRlvJ/01F60izO95vTVWUU1sMQT5j4L6jQI3hPwu3NVbXihOimdXxFKu3of+bY
 XyvING0RP8tZScKgS3TWUB+AaSJD2LM3VWkUPj5J1oH1beAN0mOlQJyJ6xozFWtBRVcI
 03dcYoXmxdVKsPzw8+tVNWBS1F83n4IcHiL3lMkl8oNmQjhDHB8PDs89AnvlbvtlhkYl
 oTvTchbAYJSl2a8nyuEpmIjoP+QhtNZt5Ys5rI5hCue3KK9ygRPd+5Mbs5uPGmQMoxLO
 CwuoOgYP8LX3WzeDGBuzPq4GoekShkvqhgIIfXl1SA0kvRnhQc9tl4Ho/Fo96jYFh/U8
 nQDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVneWxvHlwkXU7PQl1OUVS5Ii9uVFZhMvYfnz3E1e7TIz4Do8CRP8SOjNpASG/y+XYWHJARrVrwAEX6@nongnu.org
X-Gm-Message-State: AOJu0Yy0xMW8P6ceaFhJVkuN8dxQrc9ieUXDfB+03wWNehM8VF0U1AMC
 L9FwlIqh6Z0V9/2B00wnALn/j8+/QPCVPSosIA4TJVH6bKV9uG309UPDvoImweMm4B/uhI3dyzQ
 4XEPHCqcCgKrFqQ5AjULJHw3m2S+aUApt5+FX/4VRrg==
X-Gm-Gg: ATEYQzx2o6WkqWMQ1JT9nxzwJW0nna8lbtQAjs5b805MiPKMJe52FMeCB8eZT2Z24s2
 6S7RX/7J6WhUfn6vSeRj7TCq8LgUWwW9FwLH7NwsLXCI1sGydBnGkFrRkqPPq7sB1RzUGe84q5H
 lIGtQtrfrsDPuKX8uImKMK9HbH2xedbByZ7U9wcjjajO60yxTWoosFIfnY0F44LIN+vCORq2oJn
 e87gVHrA93O1OJYKZAmUt5uf0zgyvQWSHJiWqKyovSEJ6ue0wTirsQAzYXi9YybcF4bVDP5c+rs
 /j8g6bTQaBa4bTGbTxJIj//UHS2OCTX2dp1ZEqcOZfGyYN4j2aDZkyf6EVaehuPYn5ql93iSoMZ
 aUQ==
X-Received: by 2002:a05:690e:1c0b:b0:63f:96d7:a369 with SMTP id
 956f58d0204a3-64d15683e56mr10455915d50.28.1773067874392; Mon, 09 Mar 2026
 07:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
 <CAFEAcA8PwXsmYGsPDyctxm7Ud78VYB_3nFazxvTXpu=HsGTnzw@mail.gmail.com>
 <d884b7c9-5bc6-4b5f-a45b-43716fdb2268@linaro.org>
In-Reply-To: <d884b7c9-5bc6-4b5f-a45b-43716fdb2268@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 14:51:02 +0000
X-Gm-Features: AaiRm514tvpBTvZmWewmuD4gt8IYodAb29ajq0kPuiea7UvPPBkwcYMySeMBwDc
Message-ID: <CAFEAcA-Ji3o6qZSTevUdVVZBforcjo4uOhjDRsUPJe+qJ=bKPw@mail.gmail.com>
Subject: Re: [PATCH 0/4] ui: fix small leaks in -display dbus
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 9 Mar 2026 at 14:21, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 8/3/26 14:25, Peter Maydell wrote:
> > On Thu, 22 Jan 2026 at 11:33, <marcandre.lureau@redhat.com> wrote:
> >>
> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >>
> >>
> >> Marc-Andr=C3=A9 Lureau (4):
> >>    tests: fix leaks in dbus-display-test
> >>    ui/dbus: fix leak regression
> >>    ui/dbus: fix Unix.Map proxy leak
> >>    ui/dbus: fix pixman cleanup
> >>
> >>   tests/qtest/dbus-display-test.c |  9 +++++++++
> >>   ui/dbus-listener.c              | 11 +++++------
> >>   2 files changed, 14 insertions(+), 6 deletions(-)
> >
> > I don't know the code well enough to review more than the
> > two really obvious ones, but this series fixes all the leaks I
> > see in the dbus-display-test test.
>
> Is this statement equivalent to:
>
> Tested-by: Peter Maydell <peter.maydell@linaro.org>

I thought about that, but I decided against it, because
I have not tested the actual dbus functionality at all;
I only ran 'make check'. For all I know the tests could have
fixed the leaks and broken something for users :-)

-- PMM

