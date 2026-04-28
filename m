Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210B0FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHjQh-0002Qv-En; Tue, 28 Apr 2026 10:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wHjQf-0002Q7-Ks
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:28:49 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wHjQd-0005aS-8R
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:28:49 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so18914805a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 07:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777386525; cv=none;
 d=google.com; s=arc-20240605;
 b=jlJfqkKCyzoIXtQjjvrZ3a/5sRcEt9xw0yduZC/fu62gt7A6R505P5rIlmmTwlvVE/
 HGFwpC8UqeshrwMfTXTq2q9pZ6v71HqHIHSL3lwDllNkAYnlacGJ1QFHFwQidr4yF5jz
 gpLaTTesCSoUenozRHsMRGkC04Jl0M28OKb00MYrDofC+o8B1V13ug6BRuV+/Os5J6HB
 E5lnif9xos6hujBvLUgyym4O1VKwsqtAkGnzFp30ZyJcmOJyZUmpn0NZaydwwdFaf9UY
 DaQhNlDPeHQq7Hpl5u1CLc89I55KdP3f+E3DfGykq1eP+fWdxE6EgdWmhAVep0rW+Lqe
 OE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RYOY/bLGnb4mWoU/OY7ZFCy2IKSSYa+HxyuO8c5Tzxw=;
 fh=inp2XsE/DZ7vK5DmmrRMrmm7e0WoAwpRuNF3uVrFuWk=;
 b=RGx1Oxfsw7GlO4YWyWkRbIe1sHEFIJnWbwzFfkpkzchuu7nEJ1k8DNeBI5DZKg1Pbw
 h0xTdZ1KNXYVctdDHfMAhP87/LXdxHbxRn+riusMrSw6wTaPZuq0jw2nw3DxSnh36fxw
 W1w0ZalF60VIMemKSVtvgrMNT2I2XWiIrWpEK1pVFIn4gubznqjW5NNuyf4iF4TGBNfG
 TRS4l1Z2BD/usV0hijwDeE5s7jx6erwfW6It2cxLBoIZJrj8Q2BBDdV09jId7vaVWLQc
 UK20EnMbXQBB5h1BiRGMovoDoZ2Gic/+f9wekPbd9BLlX6NnK0YjzP2tP/mEnW6c3ox4
 +5/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777386525; x=1777991325; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYOY/bLGnb4mWoU/OY7ZFCy2IKSSYa+HxyuO8c5Tzxw=;
 b=Hgcd0iSwOMAKLsOxd+6l+c/4sRioZLQKYLNEIRNS7L6zFH0pp7SlswpMKhpfJyyWVL
 UfNl4yewqWB450DWHR5JYLts0siI4JHOSPnS67q7fevMUCjPNwabzTG3ChjVC2Sws+D7
 73sWTqrNMHeagSix1tnTEL878tIgre3Kv6m5IsK+4n8RSvc3rSO2xZhrdiIW/QFet1+q
 mhpIWaNeXfmVaHfldu1RDFtH8Z+3jcuVGk9scqQwXpb+ObaWeylWuy94SkdoNfr6EK8Z
 hx4ALHlfMq93RJhT7FL5fvKirtUJNCH9RJbl3RADn36f++5VyBdteDW3lHPC0+6PZjDf
 TEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777386525; x=1777991325;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RYOY/bLGnb4mWoU/OY7ZFCy2IKSSYa+HxyuO8c5Tzxw=;
 b=EX3Uv9xIcaHGfq5Eik1wNPWi0qRc144UcC7Xr+euQlsNOLtcsp5QJQiNGz/yPgHhDX
 QoENSXQFBMRj+ARr7DP7gHqg7/vWrj/UiBxiGjl1fK7sem6WIht1h/PVdpsLlGKj8cm7
 JJRSqUgRGZOpmAYmmiiL9Ek1LwyUP+Z1MmWU7GktjouDOx08fgExQOKPtFsOqnMe+vyx
 OgtXFOMEJNP8y3Ah3GMbVbYocDsy1TDLF22c4U8mSi5AJbnmOZS+aSIh5K2zevlHK9iT
 oY+Q8SCI4UF10oC4S6peXsUot6LVo66LZC3c0I+tFC6YE9RMI2lV/AmxnJo14swjcUh/
 WNdQ==
X-Gm-Message-State: AOJu0YyuZFI4EayoHD7vXmUTRG1tgmBQHZBAxaOBR2J3J1FQQOMqSnYa
 t94wsmJukmAfWatRxRdtxYvnMRFb0miN9LrfCbvNfku8RbG/j+Vl+ZvfKAVSF5/oib0EMzgWAzn
 hDLfo6kK5iUBqjlG9z7sve0N7H0q2nm4=
X-Gm-Gg: AeBDieulUqQ1mfQgmsD/eWDJjbmcd4zE4XGangogCR67lHfm0aC7IAv1eFcA6Qp3c7O
 /8P4m1wKViAz+ujGyl5rT0XC+AISa+DVOizVeXhfl1abGD4B+wVuZdL8nxhHoUhXasOmlbJ4CMU
 5gDmGCEXFQg7p6wMHnQBQnz+noQj0hsq6dOzthSRla+J9hKGMiRTkPKAOV0AV1qQJ5Tf7n+ucVX
 IMCuyP72NdtpUQPFlVEhOn5HHBRiyE1xRjcFLWmxLeZInR7ZpMtHHzQXJOUcNgqZlnsmsoeT3of
 lo4D9TI0/2eC22/S/vDa1WVEmsV84yBQovj/4oXSIPpdHth8YXvbb66uGaY=
X-Received: by 2002:a05:6402:1ed3:b0:672:5255:af77 with SMTP id
 4fb4d7f45d1cf-679bb07ee71mr1982304a12.13.1777386524494; Tue, 28 Apr 2026
 07:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260428081303.990973-1-marcandre.lureau@redhat.com>
 <20260428081303.990973-9-marcandre.lureau@redhat.com>
In-Reply-To: <20260428081303.990973-9-marcandre.lureau@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 28 Apr 2026 10:28:32 -0400
X-Gm-Features: AVHnY4Jmh-XBh9OrnMlY2iCW1hoL0ExMevskFSExN-SDnKJrlB8WX0t3_BRuqoI
Message-ID: <CAJSP0QUjFupVz1uXuxgxbvTrmf_gqzV6tSg1tmuq_Lp7qGVyjw@mail.gmail.com>
Subject: Re: [PULL 08/15] ui/console: return completion status from gfx_update
 callback
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, 
 Jan Kiszka <jan.kiszka@web.de>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Laurent Vivier <laurent@vivier.eu>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "open list:Musicpal" <qemu-arm@nongnu.org>,
 "open list:sam460ex" <qemu-ppc@nongnu.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Marc-Andr=C3=A9,
This patch changes the .gfx_update callback prototype and fails to
compile due to the following recently-merged commit:

commit 5ef60a3787e8e0dccf30dae3704d4f5249160e7d
Author: Yucai Liu <1486344514@qq.com>
Date:   Sun Apr 12 19:02:39 2026 +0800

    hw/display: Add i.MX6UL LCDIF device model

Please rebase on qemu.git/master, fix the build, and send another
revision of this pull request. Thanks!

Stefan

