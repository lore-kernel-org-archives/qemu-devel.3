Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9021E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 14:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDEL-0001RH-2x; Thu, 05 Dec 2024 09:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJDEI-0001QP-UZ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 09:53:23 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJDEF-0007TN-VU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 09:53:22 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so1204797a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 06:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733410398; x=1734015198; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgbjCCB16SErebcpkCcosJNhLesM5Vw3w3bIxhw/pzQ=;
 b=kn7hAABt2bIW6UpOdYlFJ7Qy1j2OhXlLnITc9DJ5/zEU1I3v58KdgoM7SQM8uJxrRP
 H6PSGdd+kMS3l2WF6JgfgodjWKIo7DIW7TOjjjl7oGxuzBZcVd0RB0yxGXcsgu97mWCC
 Hhx8wBFgovIX3fxoUSDuibFX2DrYVquiAcVTEQuMQ7JKky3NY2W/Ghjsh8zi7vzJgL9a
 e6VByeUZwhuqdRcRGNV8L9pE8hct1WtKBOefTIdxbwWGWnQnMgIRoxM1LR4F6UdUVWOk
 2e1n40T4PifEAVs/rRslAUakqWJxb2MB7YPfyEI/hQcDgxhx79tMzlVuCj767Zb7gnpI
 fPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733410398; x=1734015198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgbjCCB16SErebcpkCcosJNhLesM5Vw3w3bIxhw/pzQ=;
 b=dGogUWek2m95H3Zu4i37M30ETAWFy8WPvPd+UR+fSlDozK6t6N2vavbghLa4VNVXlF
 CxY7lQQzLbJAO7srSjcaBYCHEt9Qj3qNsbeVOU/82x9/dgDKmtWW8CH8xfTDGV4oOm53
 61Crg2rfz5LUSKaxNlKTO5L1bc6l6HHqylZb4m2r3xeZDgX/v2JP5eIWgghwXRq8whoq
 kuOSzBs6sjRkjKkEOEq/fpNv8+Sr3OS81pB1K3cm7+DMacTRVj9HqGiSI6p4SpFL7IDz
 1GHM+6dVWNQx1sPkHMIk+fSSO4XdWnaAy3aMZxEz0Jat/kxC1gP+fgehQc6pSwrTTvBI
 vwuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyOhS9F3dmWFGpu37tmJq/3L/hDi8gT9q7KVUO5nh5p/FvRdlFwWTbixV3A0V07PkCy/eMZnd7yzbm@nongnu.org
X-Gm-Message-State: AOJu0YwnXTOb9tibjtiH0icOl522LTPQOdDEUX2VNyPVeI+UXKtNG2vC
 SrSBeJOamS2XwG+YYrK7bi2sdLD0mVX9iwvWhbs7WvA8eey2MxD8hnIX2QIQSKtrpEerBk7fDts
 bBZtscD5KSaITMZ1JYiLrZckZUyi6vr/rpn5CLg==
X-Gm-Gg: ASbGncsVvQB+j80EMQ7D3JBTJIvTsj8unj4ZdiybMnbVLALaOooq7XGbTaWL6G5IjQn
 RfI3R1x9Ztd79SqdH9fe7PovNVywaVemD
X-Google-Smtp-Source: AGHT+IFQLhPKoyeH2ruPHxdJJMFM6DWqYU7GRP3j6nFSiCR8YyU9eJqiblIOfYqvSAORNLB+nakw3cpl896yRf6Bqr4=
X-Received: by 2002:a05:6402:5206:b0:5d1:3da:e6c with SMTP id
 4fb4d7f45d1cf-5d10cb556b8mr12211020a12.10.1733410398025; Thu, 05 Dec 2024
 06:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20241126084928.252067-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA_SkZ+ew8AAVpBHuw-9YW4S5wFbB0Vqx+dBzXf97JGDGw@mail.gmail.com>
 <cd635753-4e2c-42d6-bb7b-d558d90f59d7@linaro.org>
 <2106db77-88fb-4113-ae09-9bf77bce6ad7@quicinc.com>
 <c4245af0-3dd4-4cf6-a786-c15fa079ad05@linaro.org>
 <18ba737f-d669-4e6a-8319-fb5052223b26@linaro.org>
In-Reply-To: <18ba737f-d669-4e6a-8319-fb5052223b26@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 14:53:07 +0000
Message-ID: <CAFEAcA-P5P4AJidWcGgUScBTe9-K_C4Qm9N2o2XWnfiT81LU=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: bump default memory size to 2GB
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Mathieu Poirier <mathieu.poirier@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 5 Dec 2024 at 10:14, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 4.12.2024 o 21:50, Philippe Mathieu-Daud=C3=A9 pisze:
> > On 4/12/24 13:17, Leif Lindholm wrote:
> >> On 2024-12-02 10:53, Marcin Juszkiewicz wrote:
> >>> W dniu 26.11.2024 o 14:14, Peter Maydell pisze:
> >>>> On Tue, 26 Nov 2024 at 08:49, Marcin Juszkiewicz
> >>>> <marcin.juszkiewicz@linaro.org> wrote:
> >>>>>
> >>>>> We are working on adding RME support to SBSA Reference Platform.
> >>>>> When RME is enabled then RMM (Realm Managment Monitor) takes 1072MB=
 of
> >>>>> memory for own use. Which ends with firmware panic on 1GB machine.
> >>>>
> >>>> Reasonable change, but isn't it also a bug in the RMM that it
> >>>> grabs 1GB of RAM regardless of how much RAM the machine
> >>>> actually has?
> >>>
> >>> I think that the goal is "get it working" first and then optimize.
> >>
> >> I agree on a different platform this could feel quite hacky, but in
> >> reality even 2GB falls within "ridiculously low for an SBSA platform".
> >>
> >> If we're worried about overhead for CI jobs that do not require the
> >> feature, we could always conditionalize it on RME being enabled. But
> >> I'd be happy to wait and see.
> >
> > I'd rather do that, since it is as simple as:
>
> This is sbsa-ref not sbc-ref. Let it just have that 2GB of ram. None of
> existing SBSA systems comes with such low amount.

Yes, I think I agree here. Changing the default RAM size
based on whether the CPU does or does not have a particular
feature is unusual and not something we do on other board
types, and it definitely doesn't match the general intention
that sbsa-ref is a "looks like real hardware" machine.

The problem with using 2GB, though, is that it doesn't
work on 32-bit hosts, which have a max of 2047MB (and
if you try larger then hw/core/machine.c will error out with
"at most 2047 MB RAM can be simulated").

As a result we have several board types which have an ifdef
to say "limit the RAM size to 1GB if HOST_LONG_BITS is 32".

(I think this limit primarily derives from ramptr_t
being defined as a uintptr_t, but also trying to malloc
2GB on a 32-bit host is unlikely to work very well.)

thanks
-- PMM

