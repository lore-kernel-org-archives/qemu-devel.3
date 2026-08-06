Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041E2C56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 18:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws35X-0006oi-1T; Thu, 06 Aug 2026 14:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrhilke@google.com>)
 id 1ws35T-0006ns-En
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 14:45:04 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jrhilke@google.com>)
 id 1ws35R-0006Ol-Dt
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 14:45:02 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5aeb688ae83so1083e87.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 11:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786041898; cv=none;
 d=google.com; s=arc-20260327;
 b=mtPsRWS4WCJd4exkHi/CbctZq/t/qWVaOg/Zk00JsX+UdCL7Cg15MMOG+eRqsDz+32
 RSbRZuzfvtEdnrWz/a7RMRaOxP9FfX2vPXRTN5VyhZATsvXWmxkNXLz1zWzcfZxiiA/N
 425UpfFYy/+SKogmT1xo3xmqqXqP8W/zTusy4SU0/celLJKqxzv5Zu3TQM35FwJmvTVF
 CDz/IZKK8Kc0+ld3MIW/HMxhH9yIiu6RXEaF5PhR3iVLmi2RoRsn2RyJNPPvLuh9Gj/+
 Y8c7hIBFda28MqQh+WI9numimADL7vYoz5nK+E1ZewgdLW/qkW9JgfplreyC3CjMz3vM
 ueaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K/K+nR+w/5stnRp5ocGOONqii0tl0Bi7HfSfe1YpIYs=;
 fh=BlSbxCYHD3ACHkMNG5Xeu+0s1dGcY3MQ4fYonKBXRSw=;
 b=PoDg7o4MBKZ9uXh1l3LMFkT2IvCxnJaEyADvbRgsrW3pS1X5FNiYTqu1oYcHsJbHQ4
 20uGKPZfS+YmvWSf4IHXoN8enLUn+xS6F2eZMZupi2ryIc2JYfsiF0tebf3bDFFGgjKf
 +3E9PlPNwGPPNYmWgURLUJKfLVzXMSkmFCiocs1w7iZ78s37b30t3est3kjTJg7t+/kb
 g0Nm2Z5rdANga7OZRBHTJTj97PHgi29kraFRSGksV9t4i6+vA9rNu981NOWwvbaw5EC6
 f45pPssG4MrltCELS2InKTadsxpq33l45HtFSbMRWCPNJpFXcYAbgzihtfO3X9mdHui3
 4mAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786041898; x=1786646698; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K/K+nR+w/5stnRp5ocGOONqii0tl0Bi7HfSfe1YpIYs=;
 b=mw18CZXlgw3wlZZS68C976YobRGf9sJb7eLKHUqejY5ox5V3ueqVw9U3dt8X7+IzPu
 upPq5mmGnD80lYnp07F1Y8Z8G5RYor2OYFTeJLFur9jFR99EtyzkqfWr3FnfdJR/W4Xk
 7Mabc9VioDz6wpj3vh/DQ7pSJyl79+TPBFB++cyEITLXdJwB0pShKWZcdkvPxzWEYs78
 nLZObcqiz1GULoDULYfOW70f2DvJRi5la+dTlPpfh8oJpx5g0lJuImX6+KernEieuzE2
 OC8606NYsQPHzf04/GIVaAwcCP/8w0ViteB8Bt07Cp41QGZbrEV2uQhmxZyIC+vGWltO
 0/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786041898; x=1786646698;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K/K+nR+w/5stnRp5ocGOONqii0tl0Bi7HfSfe1YpIYs=;
 b=Kl78CpsrPq0srrc/6BJiUlJGGi79+JKSSCJ6/I8/g1uSvORGDOUkVmYJjsXGq1GEZH
 4L7dQfv2VL8q23JgfNDZgz+CqI41eMCEvmSaZ+scebGItCsUoeXD3yWZfLQqcqlK3HJ8
 GqJuPSORTQ5Fr18dfXFEDdHLWq+qA06euyX++Sv6B1kYxVtNIecFG+YdH6xQchGwRvzi
 DA7L5l/9a1IPxpgdpH5eLHZ5TCKr2E2z0bPaC1H1VKw34AWCxS56DI9ePELzKe1VEWLc
 x10Mff9iKmsN7sIsH60U8GMFzz47XAvcTz5UMNpVBryd1Ss7Yz2sZA2WpyH/C47HCCTX
 ZXbQ==
X-Gm-Message-State: AOJu0YxIsKwmzN4HnNUgRBA+51P9YVH8hRkt5bQQSvKNBon+kkKh00/o
 s6TxWyNF3DvhZMeU5AOgWVSGaxso1dCZDu3iRCOr+BPORyfFvkJuXcLPAKx4SANfjawwvnGOxPO
 cRzfn528GSGU2IHyO3Lsl5Iirc9QLadrXhfdwfC4=
X-Gm-Gg: AR+sD124Oe58zRsEyuY2KhwF7ePzk0nIV8L56Ti920JYIOIO6jY0PUtbI7fODL0UVz/
 BcBw6yS338hMtv3q5h923FWFSoY5mfppL7iXMQo9Derkz+Do7UTK5U+LfLxpeoVhuzoIH9Wx6vn
 UbJu19+eNwtOhh4Hz6VyFvEef2RtkHA+GYT2VrVT4y55G48uA2YASKlLyFhEroyChXQZjJBUZpw
 kmfZXCzY5cItmPz7vVC9QEsM3vqGbS/zBK7DLCmsvW1EBhSKvq81I4Lr/lN8Jrs+/Z0M6VDyu2J
 En1OAK5but8zhD0LQoAy6RRthi97si3taHexnZCWi0mYkcQFyp8Zrw==
X-Received: by 2002:a05:6512:224d:b0:5b1:4fd9:ac with SMTP id
 2adb3069b0e04-5b304d87899mr24261e87.3.1786041897407; Thu, 06 Aug 2026
 11:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260623-igb-trl-v8-0-c9b1fc6c3304@google.com>
 <ff0bcd39-afd6-4842-9cd5-3e39e56ec901@rsg.ci.i.u-tokyo.ac.jp>
 <CAAdrzjtjVyG-yV+MnZ5wtgef3UQ-MLCWZtHh9feeBK4ek4YXJg@mail.gmail.com>
 <f2c35b50-264d-4268-bd0e-dd52fe6269bf@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <f2c35b50-264d-4268-bd0e-dd52fe6269bf@rsg.ci.i.u-tokyo.ac.jp>
From: Josh Hilke <jrhilke@google.com>
Date: Thu, 6 Aug 2026 11:44:45 -0700
X-Gm-Features: AUfX_my8tcOWYXkcnFIGSAOS28duyp9I-xwWg66BvioXlmemZed-QTGIFYOK8Bs
Message-ID: <CAAdrzjvgpkSO14HZnRz2_X78LriOqo4G5ePwyh_4guKE8HWZCg@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] igb: Implement Transmit Rate Limiting (TRL)
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Vipin Sharma <vipinsh@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=jrhilke@google.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Which version will this be added to?

Regards,
Josh Hilke

On Tue, Jun 30, 2026 at 12:52=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/06/30 3:11, Josh Hilke wrote:
> > Do I need to push a v9 to include your "Reviewed-by" tag?
>
> No. I think this series is ready to pull along with other network patches=
.
>
> Regards,
> Akihiko Odaki
>
> >
> > Thanks,
> > Josh
> >
> > On Wed, Jun 24, 2026 at 1:18=E2=80=AFAM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> On 2026/06/24 0:05, Josh Hilke wrote:
> >>> This is v8 of a patch series implementing the Transmit Rate Limiter (=
TRL) feature for
> >>> the Intel 82576 (igb) network device emulation in QEMU.
> >>>
> >>> v7: https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg05440.ht=
ml
> >>>
> >>> Changelog:
> >>>
> >>> v8:
> >>>     - Fix extraneous whitespace modifications.
> >>>     - Use muldiv64() in igb_trl_calculate_delay().
> >>>     - Fix comment for rate factor in igb_trl_calculate_delay().>
> >>> Signed-off-by: Josh Hilke <jrhilke@google.com>
> >>
> >> For the whole series:
> >>
> >> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>> ---
> >>> Josh Hilke (7):
> >>>         igb: Define TRL registers and core state
> >>>         igb: Add VMState support for TRL state
> >>>         igb: Implement TRL register write and configuration
> >>>         igb: Refactor TX path to return processed byte count
> >>>         igb: Implement TRL throttling and timer resumption
> >>>         igb: Add QTest for Transmit Rate Limiter register multiplexin=
g
> >>>         igb: Add QTest for Transmit Rate Limiter traffic throttling
> >>>
> >>>    hw/net/igb.c           |  43 +++++++++++
> >>>    hw/net/igb_common.h    |   1 +
> >>>    hw/net/igb_core.c      | 142 ++++++++++++++++++++++++++++++++--
> >>>    hw/net/igb_core.h      |  12 +++
> >>>    hw/net/igb_regs.h      |   5 ++
> >>>    tests/qtest/igb-test.c | 206 +++++++++++++++++++++++++++++++++++++=
++++++++++++
> >>>    6 files changed, 404 insertions(+), 5 deletions(-)
> >>> ---
> >>> base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
> >>> change-id: 20260608-igb-trl-19be198da6f2
> >>>
> >>> Best regards,
> >>
>

