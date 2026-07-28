Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3940C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wodYl-0004Di-Jk; Tue, 28 Jul 2026 04:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wodYk-0004D5-29
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:53:10 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wodYi-0005tg-Dy
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:53:09 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-664c6304683so3375974d50.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785228787; cv=none;
 d=google.com; s=arc-20260327;
 b=m6Vrvqz4eNCC9piwgm6dxZbUgaxkDH4jnJkz/DX1c5zsS9s7m9y9gcQlVQdKoFVz2G
 AiKqhHfplH0kqRiOPtOT+kieaN8aTDRun+Xzn8RudORRAifS38hOVdpx8loYCXfRWe1D
 0LBHfMbV2+ay1K8vZr6uC+CP3qrJ8AhWaQGoVNdMu0hNWClN/EC1LnE73/rbhgQTnPt5
 DFau73ixkrVhZV1A0975T/Kk4sClXhMhgZ7zjt68lb3awU6aeRdj2679uMpO52ChwiW4
 E4Eg4PpUX0wMdv7r1QJnvQ4AuNepdqEk7RZN245GdynZBaN+8N6+UuFQyHyckP473lAS
 eNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9nhd/cDyN21eQWwaO/mvyaQxyj43TTi12ejFrpBe9Ds=;
 fh=YG1pRJdCyEO9Oscc0oc/JMCNarb96HqgFtCqsRzM8wg=;
 b=lyFOTEBTNkNF7ZWCm3FYmzI3CFHsDrI/NE/8s0BFojKJrTzWVE1bRaMtSa936QyKvx
 0l0/9ybH5RUKqVzyS+A2bLA+5a5KR7X0+Nfeb2hFs5E8UoOh/FMH97SL5GDGBcgmq9Oh
 6C4Ca1zf+A2dPdCwdFKFjNhomXtAuRrcL9dHL3XblQTurAbDcXNnP1qkY6PMjLO539rJ
 TZr8axZaXAxl0mdrmOZETAROTPF4oz45rjGPAeiYhfAnn+NM2oov5gGRqsNQgcGecUAG
 uy1TzLU65IHcs1exRXZMRdTy4X/QV3f+V0Ra0oX7jqOJ1JyONRQ/WRdFk+lY9wCRxeby
 SNaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785228787; x=1785833587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9nhd/cDyN21eQWwaO/mvyaQxyj43TTi12ejFrpBe9Ds=;
 b=izzQoPt4xjqZBA1OV1SJWIO4t7otcYcKESdLAqFCO/xQC/yAEpYQqVAlQSKpOCXRn1
 F6SfuqDowDxeKJ4Zsl7F8hCEDGj90VmBk+PcpjjLl7NKNpTfR2nuQ4uHI9AksLi6FKBr
 twyAdmor6oLKxtkwKqI2f9XAN+ejZjCLYP/83/5v3kYbXDeybQ146XAib1Gfzv/b6bQO
 HVsrs0kJyPQgr4y9jWzr14QXExKOVOpOrRDWuVt4AvXj0UrXYOpuXzVin2C3WYd7XiAF
 tq4Zb7G5vRSv+RG/MrAOJaAaQySd+5BgaEdubyaFrwfv5SnR3ITHzVStoOyeokSoqL/J
 sHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785228787; x=1785833587;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9nhd/cDyN21eQWwaO/mvyaQxyj43TTi12ejFrpBe9Ds=;
 b=LuYqPQZZ0uPasTMmsj5azg84FMs0ceOxo02Q0zcwpfaAfgBexJmY/ZmPLxZp+tHRKh
 sfT5cltS7+z+nUEzAd7bsM+xyL635f3p/ASv+wVl7wiIJGHUeVRYPQ6War8EMjmQydss
 1mjcCuIvutbBjorgfQgjwkxXEXUwxJ3QTLlchnTCYOmIFXsSlqxd83pAztp9UI96s7AG
 3togO7U28RXcKG3juL6gp5XWEn1RYe9gXhf9iyUSqTzNZUoerFDvx3M9jA25LqGiBkjU
 /zrNxtLUySdmwmL2HtolFtPa8WyTN+7OjsPZWrANkXDgOeZ7ujsHyE7wGKWqNywo03HS
 Xr5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUDeOh4+iUK+YEbaXobywdFvZW7NIjDAnMoeEed26oQszJDJDhI8a/RvMVugRL6M7SnQ31MMvh1QQk@nongnu.org
X-Gm-Message-State: AOJu0YzVPR4WI20ClJhvNqkiTEwXUtwHnPza5lygfbqoq0yBBfa4kyd7
 MDP1KusiEQqpupZCb4X1NLEV9Fz8kyk11rqBgo+u3uvVhhntH48cS1cJIEuOrQ5EuIdAnSVdzHx
 2jJBLO3Rw/liqHdr4ZBPORmZaDYa1wPw=
X-Gm-Gg: AR+sD10LxmeqanN86jyAdRVtS29Q6AzIc0so4g5l5R2bIpbPqyKzbkBFBXv2sMQA967
 6n31d6gB8TEuYLqP4EQ2E9QAV0z+Fbethn9itvdRXwBJ3kQmeOL8jk1eWQRz5kEz7NMQhGmdbHy
 eCku2ZSYMGk9q9rQMKDyYYBGSDrHRz1Ku0KS7B/aku0wP+XzR/Q45BqijQa8weqX8ufPbkxLqns
 VvSV4mQ46PijPXvLVoy6X51IwTm5xA8uUGLXLaT2HlDo+AM1Dqu5Iea/y5BWg==
X-Received: by 2002:a05:690c:690a:b0:81d:bc5:4624 with SMTP id
 00721157ae682-81f99258bd4mr6005947b3.25.1785228786942; Tue, 28 Jul 2026
 01:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260719211923.1079282-1-shentey@gmail.com>
 <20260719211923.1079282-3-shentey@gmail.com>
 <CAEUhbmWhqc+_7MQA3Y9ZG9vwBjsbE4-w3tsx7Ep1CbBHze3Mcw@mail.gmail.com>
 <897E12B2-A6E5-4524-9983-FA861A7FDDD3@gmail.com>
 <CAEUhbmXT9ajeFMz8_1GsCWZJU-FmkYXTPZd-pfYQ2A45Qm7hFQ@mail.gmail.com>
 <D1B4AD96-B24C-4448-9B83-8D319997E768@gmail.com>
 <26ad904f-7f15-4ccb-a9c0-3c3bc279a283@oss.qualcomm.com>
 <d4ed43db-6c6b-4269-b6da-38320d340cc6@oss.qualcomm.com>
In-Reply-To: <d4ed43db-6c6b-4269-b6da-38320d340cc6@oss.qualcomm.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 28 Jul 2026 16:52:54 +0800
X-Gm-Features: AUfX_myCTwhAqnIvEnEdNS-E53DTZNwtt4OMwBsv33S7Xdn39KvRVu8BAdY-SiE
Message-ID: <CAEUhbmXmK_g2Ds5ij2VQmiYWx7AjqQ3qPRhYaKttZUtAd-5dKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdhci: Extract uSDHC-specific quirk
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Jul 28, 2026 at 4:15=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi Bin,
>
> On 21/7/26 12:42, Philippe Mathieu-Daud=C3=83=C2=A9 wrote:
> > On 21/7/26 12:29, Bernhard Beschow wrote:
> >>
> >>
> >> Am 21. Juli 2026 08:38:19 UTC schrieb Bin Meng <bmeng.cn@gmail.com>:
> >>> Hi Bernhard,
> >>>
> >>> On Tue, Jul 21, 2026 at 5:11=E2=80=AFAM Bernhard Beschow <shentey@gma=
il.com>
> >>> wrote:
> >>>>
> >>>>
> >>>>
> >>>> Am 20. Juli 2026 14:50:24 UTC schrieb Bin Meng <bmeng.cn@gmail.com>:
> >>>>
> >>>> Hi Bin,
> >>>>
> >>>> Thanks for yor reviews and R-b tags!
> >>>>
> >>>>> On Mon, Jul 20, 2026 at 5:19=E2=80=AFAM Bernhard Beschow
> >>>>> <shentey@gmail.com> wrote:
> >>>>>>
> >>>>>> In Linux, the ESDHC_MIX_CTRL qirk is guarded by esdhc_is_usdhc()
> >>>>>> while
> >>>>>> the eSDHC code path uses the standard SDHC interface. Extract the
> >>>>>> quirk
> >>>>>> into a new `usdhc_write()` function.
> >>>>>>
> >>>>>> Fixes file system corruption on emulated i.MX53 where Linux'
> >>>>>> esdhc_is_usdhc() returns false. The same likely happens on e500 an=
d
> >>>>>> imx25-pdk machines.
> >>>>>>
> >>>>>> Fixes: 75e98bc4f859 ("hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE")
> >>>>>> cc: qemu-stable
> >>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> >>>>>> ---
> >>>>>>   hw/sd/sdhci.c | 73 ++++++++++++++++++++++++++++++
> >>>>>> +--------------------
> >>>>>>   1 file changed, 44 insertions(+), 29 deletions(-)
> >>>>>>
> >>>>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> >>>>>> index c86dfa281f..e58a610397 100644
> >>>>>> --- a/hw/sd/sdhci.c
> >>>>>> +++ b/hw/sd/sdhci.c
> >>>>>> @@ -1795,34 +1795,6 @@ esdhc_write(void *opaque, hwaddr offset,
> >>>>>> uint64_t val, unsigned size)
> >>>>>>           sdhci_write(opaque, offset, value, size);
> >>>>>>           break;
> >>>>>>
> >>>>>> -    case ESDHC_MIX_CTRL:
> >>>>>> -        /*
> >>>>>> -         * So, when SD/MMC stack in Linux tries to write to
> >>>>>> "Transfer
> >>>>>> -         * Mode Register", ESDHC i.MX quirk code will translate i=
t
> >>>>>> -         * into a write to ESDHC_MIX_CTRL, so we do the opposite =
in
> >>>>>> -         * order to get where we started
> >>>>>> -         *
> >>>>>> -         * Note that Auto CMD23 Enable bit is located in a wrong
> >>>>>> place
> >>>>>> -         * on i.MX, but since it is not used by QEMU we do not ca=
re.
> >>>>>> -         *
> >>>>>> -         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...=
)
> >>>>>> -         * here because it will result in a call to
> >>>>>> -         * sdhci_send_command(s) which we don't want.
> >>>>>> -         *
> >>>>>> -         */
> >>>>>> -        s->trnmod =3D value & UINT16_MAX;
> >>>>>> -        break;
> >>>>>> -    case SDHC_TRNMOD:
> >>>>>
> >>>>> Looks like this register is not eSDHC specific?
> >>>>
> >>>> Not quite sure what you mean exactly. The SDHC_TRNMOD isn't eSDHC
> >>>> specific but as per the comment above trnmod partial handling is
> >>>> deferred here, i.e. needs to be intercepted.
> >>>
> >>> If I read the Linux driver correctly, I think we should do something
> >>> like below when writing to SDHC_TRNMOD:
> >>>
> >>>   case SDHC_TRNMOD:
> >>>       if (is_usdhc) {
> >>>           val |=3D s->trnmod;
> >>>       }
> >>>       sdhci_write(opaque, offset, val, size);
> >>>       break;
> >>>
> >>> Because for eSDHC, the transfer mode is already passed in the value,
> >>> and oring previous s->trnmod may cause some bits being set to old
> >>> previous value unexpectedly. Please double check.
> >>
> >> By moving out of esdhc_write() into a dedicated usdhc_write() method
> >> we achieve exactly that, no?
>
> What is your final tought, should we proceed with v2?

Yes, I think so.

Regards,
Bin

