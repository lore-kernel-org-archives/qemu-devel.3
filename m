Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BE0CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 14:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIosv-0001y5-UO; Fri, 01 May 2026 10:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIosi-0001uh-Cd
 for qemu-devel@nongnu.org; Fri, 01 May 2026 10:30:16 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIosg-00031o-OX
 for qemu-devel@nongnu.org; Fri, 01 May 2026 10:30:16 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-65c396d3b36so305163d50.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 07:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777645813; cv=none;
 d=google.com; s=arc-20240605;
 b=HTE+M0TzJwNIlUiPNUgYgjjwrvRUvpY2ubUA9yxbggqL/RVifxMm355M49ULi2FaEb
 FUfV9lntjycfPf2JZwe5Sc/wwobWdee4iwrp/SATq1vtQ3qS89EwLakkQaDEnlPJL2tr
 GPoTTL2rRLfHxMMt5f0OjMNRMwbG6CV9f5c8p2cFvULJRL2d1rCxtHuxIa41Y3/Xxp5a
 OnC97jgUn+fITVv617Di1efwrQyQ/sWo4lChBqf6cQiKjunY3lKGo9JQ/+C4/Sd/07gZ
 6AML2Uc+u5lym1NXi0FFPX21WedJYHCXgEN3kqLAmvLWOzVrUCiLOpgopUxlyvCjPPbC
 fRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yMFHiJ4MZZzu1s7IKs+b7jPJPkyjQ7l8xdqj0fWs6tA=;
 fh=dEVg6uwYItpHJeEckWeY1SAUI6gUXVUgBtGRd8UKX7A=;
 b=O+cD3mj9iNDFAUA+ZMP/M3qV2u6gcsEJFD+SOanO6QjYEsqzREzv9k4gDKkljK3dI4
 HH8Slek7/SAxrjLNLLprkTPHCRkF44jlu8PSZFJshxcBz6y8t46kxqy+qKpJfzUxx/Ou
 fFn1hRtjBMCI3p2L/RVWBL6Z7n71D3uLSO0PSkJVKhDWf3ceC2HNr+AXWBnlA/gxVOLF
 mxvBg+wKZy6Wuoe/WHYg2uj++eS3TigIzjiJhxaaqhzYkKDxEG0iNwAr1W311SaxoWdT
 bbg/XyZkKuY1IeVjE6DrbQNJK25nq3vsGXTF/WOJJBr/eIqGivs8DMdYgZAWpbYpinFg
 fG/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777645813; x=1778250613; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yMFHiJ4MZZzu1s7IKs+b7jPJPkyjQ7l8xdqj0fWs6tA=;
 b=BFXn59vWvFIGYOwWsks6SkFlYGYaJ++jNVVdKLZHrCLQUrEtYzrqVNaHiLjXg7kUk7
 f93/lo6no9Q9QpTuza+FcOPqz8fOftcLYhFudXBIRv+ivLlJrSguhp1J2G126eXc8R37
 4oZyqYwNjRM+dynF81BliEag2owPEdo9Ssy/Yxf/qmSXMB+vyiMuqPeELbSXiSv9mDOw
 jfV2/bqlQ71ut5za3MaSyI2xd53iHju22I2YX2GLT0LwZ29GouMPyC2OOtJ+Cy4mWnOu
 PSbagmqUfJQgTbGr4/gZrk7NeqFCALey0vHzMp5K/48p/It56h67uKE4+up59ZulXxhb
 ZgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777645813; x=1778250613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMFHiJ4MZZzu1s7IKs+b7jPJPkyjQ7l8xdqj0fWs6tA=;
 b=S0Ur9ZMW5Mr12xCnSh8g9h2Nnn84gmWcnuJD3oOsn9nApZ94eVGBvu3gE345TeJxk8
 5jRmAeb7iHDAg/RwCsbZT51Qce1O+3NkoUAIrl6dOQ2itHypHX/OLc4BnhQunYYmrPP3
 RO+me28K9utoStSTZigPRYKypupWia2iKYH0baXWsd1rksX+gesd4JYvdPOxHPpGqniu
 Qp1Lk9ZtZTuofmza4YqxFMXewkPG6PZzMu0uo6y8TX8x7jrkeeFhLDZXOkvgDa+hIgh+
 hbjbnK/GO++nB/FB+CIaE13E1W9LegrMB3eO/zNJeO9gqzoYBykAYgKMEMU2r8L27L5+
 aoHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WNMV4fksTCWt7RDL/BZozrbo+VaHEkkN476y65nrq7SFpq6BNxnq8WmT3ZORo2A7XBXCnmwwkgtkE@nongnu.org
X-Gm-Message-State: AOJu0YxbU1uS3i6OadoRaihEu4rcHLCQoD4fIXgmi22ngU+xGcojmRdW
 cM2u78nTQ0M++QGmtJULfKJ5CKs/rFP81VePw3Orki6zydWBOlUmSbIfnCAqcssaToZKzxCSzaQ
 cQu/Lp3ZGRV0EL0CupKdKMqjrGm7x2XMRoJIWCUVJ2w==
X-Gm-Gg: AeBDiesSyWXtMB3AougFbilIHhu+QBzrNG80omAaq9qRdKbTQ7NYXKSDVaPrueqLzQq
 pfbDE9y0niUwGDyXZhQQjl3Inpp5e4dSMqLmR+rXqxUFz8xoK7BB4hQ/jK6hhGQMNQhStuQdmRu
 qra09wlChOPda5sA+D3DYaLZNjMag0GvG9do86LsKZ3x9OQ2ZXuw1Kka+HuDdmiVdD1gP2lsBJu
 uRWsEGvavpxFNzgcuK9WG+8xkuv2SA4kpZolcyWYux/zOdFp2N4rppH4UicAm0ogKzpwIR3y99Q
 rQ7K05NphR5zeqkBXC1cnu/NmhGHkEgoPrWPTIGWCeVp25BBRgoCwLoGs5aDvoH/E8XAxMs2pg5
 JrA==
X-Received: by 2002:a05:690e:d44:b0:650:1ac4:65ea with SMTP id
 956f58d0204a3-65c18c78c12mr5510656d50.22.1777645813190; Fri, 01 May 2026
 07:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-4-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
 <CAD=n3R15=vCCgQQhEWXPRc91T-8a02JJs2t9s88dVDLqTi_QZw@mail.gmail.com>
In-Reply-To: <CAD=n3R15=vCCgQQhEWXPRc91T-8a02JJs2t9s88dVDLqTi_QZw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2026 15:30:02 +0100
X-Gm-Features: AVHnY4Lvd5bC5Bjb5B0gowbRniZvoDTtU_MpQnrflj-3wpCwSJ354tivCPjGs_A
Message-ID: <CAFEAcA8ZcpUPGRPAsRgfaBd5xpXdCVuyNeoWubFKMLTdcoekSQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] hw/riscv: server platform reference machine
To: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Cc: Alistair Francis <alistair23@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Fei Wu <wu.fei9@sanechips.com.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Fri, 1 May 2026 at 15:02, Leif Lindholm
<leif.lindholm@oss.qualcomm.com> wrote:
>
> On Fri, 1 May 2026 at 04:28, Alistair Francis <alistair23@gmail.com> wrote:
> > The first line of the README says:
> >
> > """
> > This document is capturing discussions at the Server Platform TG.
> > These are not official specifications and everything in this document
> > may change.
> > """
> >
> > So this machine needs to start out with version support (like the ARM
> > virt board)
>
> We ended up not doing that for sbsa-ref, partially based on advice
> from Peter (added to cc),
> which I can't right now bring to mind in any great detail.
>
> I would expect the same argument holds here. Peter?

Roughly, QEMU versioned machine types are a big maintenance pain,
so we should only have them where the use-case is that users
really want to be able to run and migrate their workloads from
old QEMU to new QEMU. The use case for sbsa-ref is "I am developing
the full firmware/system software stack and I want a reference
platform for that" -- nobody wants to be able to run the older
version of the firmware/software stack on the newer QEMU,
and certainly nobody is going to be doing live migration of the
software between QEMU versions. The small population of people
doing this development work will be running the bleeding edge of
all the components involved anyway, and to the extent they care
about running on an older / newer QEMU for convenience they can
handle that in the firmware -- sbsa-ref passes the firmware a
"machine-version-major" and "machine-version-minor" that we
bump when we add something that would be a compat break with the
firmware.

thanks
-- PMM

