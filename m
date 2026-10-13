Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361CECC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGaEc-0008I8-ND; Tue, 13 Oct 2026 06:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGaEb-0008HJ-96
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:59:53 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGaEZ-0007HD-Px
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:59:53 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6711f05fb14so2195075d50.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791889190; cv=none;
 d=google.com; s=arc-20260327;
 b=Q7LJc2DVw+iKzFt6JOBfC6SpZ/iUYU5uMmYtNsIHe06wDZKxbEwzWuvKCgINGDvpFM
 NRbKd+YaZNHChgABdFFa3YAcHJg6SDdZVI8S/Tc/BHQtuWvg8ULTxiumawQS8EwkjvBn
 2lh7GhWc0OOXbcglMEFrc+vvdmwfxM11nyYgBQT/g6cssVWLhdjplVowMcTcyiB2ba5N
 nXqf326cXk6XuSJeobkuBDBC4VCkXrhQAs0OxSHFatMvLjQgHAeC6dSD2aSAocsXuWWn
 7vUZbAnQOiHNPJ4urO+k7NG3xFVDcn1xYCNUA7BuPkfjgprjP28A9Pq8C5FgXJ+TptP0
 wWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qXsrDFTSOZH2nnYCYsJwVarfa/N7mphqo6XUSkBiSKQ=;
 fh=4DgGiyVArPlDM16AzR9IuD5e+oRpdfmGwnpT/we6oy4=;
 b=cDqJTBKhT1+OnW1FvKB+WX7ZbdjeVfoicTn7VcvTmKEJlv1gx11LsmfC27ZtALJWgW
 D5gwD6lSoReax9Lu1ew+77dTsVdX4UJzYHhacbba20d46kOJ3Q5x+dI7pepF2qpbY+DH
 gRmYSEciJH98u7g3oqaD/khYmGnD6z8ZrqXKp3aago13LGpF2wmm09NCohH8pmU+JeCV
 YMZAv2MgxEiK7hS1/ydbko82miVfDbcpbuwJHAA428nP/e6o9KBtnnq8uiAq/AtLoavM
 hY+Q9H6UQLif7ENt+XEgc7rwOuG0XAs1hW0TWML7MGCtsqDgjA7OCsi7RCZZ6TKMxlUJ
 LQaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791889190; x=1792493990; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qXsrDFTSOZH2nnYCYsJwVarfa/N7mphqo6XUSkBiSKQ=;
 b=EucvFAdB0KHiOb++BIuc7lIIJAtipW9B9lflTbCHsUZZEhgnCzUWihnL2KpLbsrU3b
 7zJNO2i+3b6pDzW7IczFfq63SGndNujW/VAB5nCo89laWTx3nKuuRoFr8+7kQ/uibkEV
 trFsfbmfvjR88M/ysGj5pXlOZatEXw1TQEB+/1aigmdqpPX4a1HmbuSZ2uPYZSbkzb1Y
 xy5EiTNFg5+xatdcLXLop4tyry3swrcD9wrReTcPe0tzACDxXfEJE2V9TSy1sj/BWm9W
 8eumVgUKAcZ3SNGTXMZeHGGnqRj8IV0x8tvJaPq9O5ttxcxusTUgtilXH5Lzmp2sxZXb
 1O0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791889190; x=1792493990;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qXsrDFTSOZH2nnYCYsJwVarfa/N7mphqo6XUSkBiSKQ=;
 b=s3NZ/LeJyZrhTs1xq6mmI8pyhfsMXCzNOmTVOPIVFVOrWcbGVfI+Ryo5TTHnxW2fT5
 AeBXup+iPnVAGgUY3wuRuVITnGZm0UwbfHj08WDk2+oW1jVtnrmUP+F5tkH/QNmLn98T
 L7Os/AteOCE7p8d4CRONNz+DrcPeDbnHeXAL0SNcAshuLaK2JqR1CGefP+hOCO5Rwf87
 AVa+MYAVks1A8Un6cag1aT7zAT4m22pDkk7gDN6Hhj9voeuSWM1p+r7FRKiymQ6+Uwce
 M9zc6VYIHEXL1pnJxsO3YW0a3mYqvkGhAjs47XxOaAxJiV7GXzzLcACAkY9hrzp5/+6Q
 fPLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwphK0ovK0XdIvTUTDanlShbmkYtyb0VIKAMyKK0Kzp/O9BgdfUmevqxiTzY0QW2NUgsYMgwWJISDgT@nongnu.org
X-Gm-Message-State: AFq9FYKC4IP6O0iPhPq1Jh4TvPgBzzgR0otxhDDc+m0LbO90E54TZgFk
 3dJY7MVI75sVYBVi9iVkamJlWpLmIMmDFB8At14YIk5BIYIkrcZIE4SW+t+Vwq290bwlY5esRYt
 +ovlSsgVbnmXfQfMRQXmn679k0kvAQ1TeWov2EFVFLA==
X-Gm-Gg: AYBFou3ewJWRbuu0EYYfEkx/pqwL93IcfjfaNLxQQ16yWj6FcmwUqitFyGlcnZe5IiP
 KsIZI47lTz2JTt5ev3qFl5u8Q4YatPtAY63N0ktCH2QWLmnudJyezp/i5TfAXiIS7px31rh2rDo
 pbaNNMgF98bI9NbvumTJyuaVgsvYrsb8KDRD9xC9Lm/LpmnX92R69cEJnWb1sspG5uFq7T+PLqn
 dolKCmlFLTbEKAytxH+nYNdbJfcQ+I99osY6dRgkRa8ojWiBUaVZCqLbiURQEd19XFRxrusHUQn
 Pyks/20lfRgXiDLavBmkQ9siQ1l4A9HSx1SLHwGXDRESTZOLhVx9pFhdOzHeJyMIySi5nHW83tO
 jbkgmNvC9wXrTPVCJx0UbCmGyLjwoWXuxvHcVE0I=
X-Received: by 2002:a05:690e:1382:b0:674:d78:4bd with SMTP id
 956f58d0204a3-67935edbb67mr4663568d50.5.1791889190242; Tue, 13 Oct 2026
 03:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-69-peter.maydell@linaro.org>
 <a693c8e2-5a15-429c-9427-d8dc68096830@oss.qualcomm.com>
In-Reply-To: <a693c8e2-5a15-429c-9427-d8dc68096830@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 11:59:38 +0100
X-Gm-Features: AclHuK_ExD1SGWuwIeu__Vzs2Rl_4PS5eDK_QEyJPcMZPE8ClCJr9l19-7Nhb0g
Message-ID: <CAFEAcA-tPmwaNyPnp6Oq27uvhvv5rVVQFEuBdhvv8mTe+dCV1g@mail.gmail.com>
Subject: Re: [PATCH 68/86] hw/intc/arm_gicv5: Implement gicv5_set_resident()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
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

On Tue, 13 Oct 2026 at 11:54, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 13/10/26 10:39, Peter Maydell wrote:
> > When the GICv5 CPU interface wants to make a VPE resident, it calls
> > gicv5_set_resident(). Currently that is a do-nothing placeholder;
> > implement the required behaviour of tracking on the IRS side that
> > the VPE is resident on this CPU, and remembering the information
> > about the doorbell interrupt.
> >
> > For each CPU, we keep a note of the current VPE that is resident (if
> > any), so we have an easy way to get to that information given the CPU
> > index in functions like gicv5_set_priority().  Since the only way to
> > make a VPE invalid is to make the entire VM invalid, we only need to
> > set this info in gicv5_set_resident() and then clear it when a VM
> > becomes invalid or the whole VM table is made invalid.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/intc/arm_gicv5.c         | 115 +++++++++++++++++++++++++++++++++++=
-
> >   hw/intc/trace-events        |   2 +
> >   include/hw/intc/arm_gicv5.h |   5 ++
>
> (please enable scripts/git.orderfile to ease mailing list code review)

Done.

> > @@ -1566,6 +1649,8 @@ static void irs_vmt_baser_write(GICv5 *s, GICv5Do=
main domain, uint64_t value)
> >               return;
> >           }
> >           irs_clean_vm_cache(cs, &s->vmt_config[domain]);
> > +        /* No VPE is now resident on any CPU */
> > +        memset(s->res_vpe, 0, sizeof(VPE) * cs->num_cpus);
>
> res_vpe is declared as:
>
>    VPE **res_vpe;
>
> so IIUC we should use sizeof(*VPE), or the sizeof(*s->res_vpe)
> used below to keep the same style.

Yes. I found and fixed this bug in the reset code path, which is why
that part is different, but didn't notice I still had the same bug here.
We should use the same thing we do below (it makes it more obvious that
the type is correct than using "VPE*", I think).

> >           cs->irs_vmt_baser[domain] =3D FIELD_DP64(cs->irs_vmt_baser[do=
main],
> >                                                  IRS_VMT_BASER, VALID, =
valid);
>
>
> > @@ -2884,6 +2985,11 @@ static void gicv5_reset_hold(Object *obj, ResetT=
ype type)
> >               g_hash_table_remove_all(s->vmt_config[i].vm_cache);
> >           }
> >       }
> > +
> > +    if (s->res_vpe) {
> > +        /* No VPE is now resident on any CPU */
> > +        memset(s->res_vpe, 0, sizeof(*s->res_vpe) * cs->num_cpus);
>
> OK.

thanks
-- PMM

