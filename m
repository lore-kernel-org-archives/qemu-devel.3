Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9EAF46443
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w24nn-0006aU-AN; Mon, 16 Mar 2026 06:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w24nm-0006aM-Dg
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:03:58 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w24nk-0002A9-47
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:03:58 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ae222d87dso3953185d50.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773655434; cv=none;
 d=google.com; s=arc-20240605;
 b=b9XEPt0dwsLltDcINwVQF6wvcoz/liWB3SxeGIdwMD8wvkAkqEeaRLrCM6MZ5vNdK8
 W5sx9PylgEN6O3vdDEJJwXvleIXY6HjEf5OJ1PUGNH7eWCImeGsVHDXP1g/cemo1f2Z5
 o8Y6oIBEycnrCvrZqQp56mjb59Xom6nziX+KzVhJfODGXh/I+E6qWvXrFKkuuEfYcaAY
 PCGcZgPSaBn4cpv7HtKnYX+Dn2kyJRwOS8Xx0ULyquAAVN0vwbO9E/x0UsuYO0gjNQ/F
 S6VBaN6RwvND7lOm6vcUueQFSCyw8DhW6bO6Z318ARR9OKkTVlvZu4a2HgaudmjgLqtu
 CDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QMjwR+3A0zoR78qUeJC54K+owBw17ThO5GWy0KKIqo8=;
 fh=lTCOS5Qr4vhZk38Dz3Tej6IeAt18e06YOSVXoufduIo=;
 b=OmnqmrePsisTKYIdsqFzyGExfUa02+UBfBKpaqA5D3aeJyaI0qh4y5zyk/M+mC+bDo
 Z7WfVbLz8Yu2FhJFoHm/zkBxVBjlCjETQD90PWs7OL+gL7+NwwbehGBMFno6Hn5/J9fW
 +sSdX+0v7/ZZSYBnlUvV6Bwe2cVEMPZDs+YFyfpc7yMLNWbE3/Ek82zUE/B0rb1TIE9Y
 tm/z1Jp/Keaf1wi+Rqx2NOM9BdOWhvxWFcTk3W41p+EToK6EvBDOBfwZtYWQWybsDlGY
 BwbmsQHZV1y+t2MNR2w8PsJ9aKbImUo+5xO+xxQwyQCsNa3OGqFvrNMs1VcQQwT4s2aq
 r4qw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773655434; x=1774260234; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMjwR+3A0zoR78qUeJC54K+owBw17ThO5GWy0KKIqo8=;
 b=mEvMlL3ZdqF0LFy4DXl8VlVPjvPxObX3aWUwJbsB56PxLqHFuM4ksdj4lZIPRz4GIf
 TaY6S6rIIw7Ay3cqwD3IwpqNxGiLkRgFlq1zOEQepHl3PizEURT1AN2AVtk70ovLVdLN
 mUT8KtNAUJ4Zkj/zgnqj31syXFn0eHhxu7TVFh0Zi1H5SW5K4ezIm32XAJuhUrUq72db
 IcFMcM332UI4piSSTqnR2CZ5s6mdVxYmjHLyYnvnzzsSbZihXA1KPlFijqAXJotjvLy7
 S6iflIKkSvnCVtYA19/gBHOS1PBzexWT24Gn0FDfFSL3Y/RdIWWPfg9U7utNcnNDsOyV
 TSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773655434; x=1774260234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QMjwR+3A0zoR78qUeJC54K+owBw17ThO5GWy0KKIqo8=;
 b=UmyyJ9x7SBircniyHM/QTa6Wq67EzHmGLUFbHHS74Za5Beerxm50i+iKT4vQiRJ2U+
 9u1ou8lqHNiKRvo0Fy+IbpxcFTT3VOJZ42jjuJPFx/ml6uXtDZltCcKpFPfzAqPWVzLL
 EwWFhuw+lI/4wJNInfgBLomAGFtLSIOCNi3qeLr5mjnVbF1I1qy7cJa+F2OgO5gR+efX
 ZjrICHovdHM+xe3JHGlWGLHIet+KS4YlSDrQnx39SYkqkJcRgruPIuVg7RD6BtKEUYff
 z0BmLUQ+ClbaQiUkQo1cuY/CZZCkcGoVDChD+XTCrXSYYhoGr7V6HEsuVdHpOvJIcLGQ
 9/xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUssM0yf5hSWYjmmMylngUiiDs19MXu4hf0JgkAIeHdfXm7xNf0B2bXNGh7Z8Lye7xBqKyCHh00t/EE@nongnu.org
X-Gm-Message-State: AOJu0YyJKCQJz8Y/nrn8OfVCWco4inDdF7LVZPBNJ820iZ7g7S1GAJsQ
 MD/B7aK1aGPyX0uZH9YgzYkujO0VM9W+/fqteOKA2JpLA53FuL1VgG00RMaf4IIt4yEZf7AOsu9
 mxXRlowIWc5Ujd/N58TrFS4RidtF971YI0ITUVE5wOQ==
X-Gm-Gg: ATEYQzzwtqv7CYgfGHPY3Vx06tF/6i+0772y73REZLPPXWWCbeGjcZGV9s/Q3QT0nh2
 FqUxuAHeGjwNal3s/s4Iz+le7oMvHXbSUt6pkMS+YngKKJTm1POOI8dNxVTTA06hxSZUuE1d4kl
 g9k+a6gfbmtNCj8KuRaoTQ1iMg5zaYcRY/e/qo4bijn5M7KNV9loqc1kyKRFm9SgL1SA2D+XqSZ
 fm5QXL7OB2WsEnDgXL2MhPAj2ya/EknFQKXENQcpJSubCby6sLO2ggSCoSD+FmKOpEDE99J6kxq
 2RoTkHO4ssHW6j8z+mDogLhPwkkSKjQ93KTpaMtAxkTO5NpF+/woSCSF0C1ZiaTLvSU=
X-Received: by 2002:a53:d30d:0:b0:64c:efd3:ba85 with SMTP id
 956f58d0204a3-64e6306612amr8980984d50.41.1773655433844; Mon, 16 Mar 2026
 03:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
 <20260311-semihosting-cpu-tswap-v3-2-8e239575ec08@eonerc.rwth-aachen.de>
 <bde55593-a51d-421c-bfa5-4a0c774f4b61@linaro.org>
 <CAFEAcA_Qvo86Ek2W7xGQqGP94400c7wx-C0=zpBUF5NoM2jhfQ@mail.gmail.com>
 <80ad84b1-0c4d-45de-93d4-90a471f7f751@linaro.org>
 <CAFEAcA9-umnREmEpWLV5hhXkfXZWqmMqpt3DAL2kUe1spttyKg@mail.gmail.com>
 <241781d8-667e-486d-bc01-b01c0620e6cd@linaro.org>
In-Reply-To: <241781d8-667e-486d-bc01-b01c0620e6cd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 10:03:42 +0000
X-Gm-Features: AaiRm52Ph7_P31m1ynOP9DY9Igb_39F6oUCWMr1FyN01Nm_XGHvV6cni4SOIenw
Message-ID: <CAFEAcA8v7Tc1iW3w-Dxum5nVq1-BirsMH9rWx2EJkGSLYThihw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] include/exec: Provide the cpu_internal_tswap()
 functions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>, 
 qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Sun, 15 Mar 2026 at 14:07, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 13/3/26 09:51, Peter Maydell wrote:
> > No, these ones are here so that when when a test does a read
> > or write of non-byte width data (e.g. via "writel 0x8000 0x12345678")
> > we send it into the memory system in the endianness that it
> > expects, so that it arrives at the device as "write of width 4
> > with value 0x12345678". That is, we want to match it to the
> > system endianness, because that's what we want to cancel out
> > the swapping done in adjust_endianness() in system/memory.c.
>
> What do you mean by "system endianness"? The default endianness picked
> for a particular qemu-system-foo binary?

I mean whether TARGET_BIG_ENDIAN is set -- the effective
endianness of the whole system, which affects whether
the core memory system thinks it needs to byteswap data
that passes through it.

That's different from what the CPU does internally for things like
Arm CPSR.E. An Arm system is always little-endian at the
system level, regardless of CPSR.E. Setting CPSR.E just makes
the CPU byteswap data before sending it out of the CPU to the
system. (That's how it works in hardware as well as QEMU.)

thanks
-- PMM

