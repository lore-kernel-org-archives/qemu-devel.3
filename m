Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B6ECD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 08:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNnfx-0007Eo-48; Fri, 15 May 2026 04:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnfs-000739-VF
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:13:36 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnfr-0004M6-1g
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:13:36 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-65c7492a2ceso10034693d50.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 01:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778832814; cv=none;
 d=google.com; s=arc-20240605;
 b=gmH0csR1JIQhsLJmTK/FpkaHzZb9zG+bpLZpUzRXhbJsUtcx4WO0RyOA+bVuS3xzNk
 UnqQPifm2LUCfR7gf/2FPNn3dXyf/+/bEBILhnGqQbw1y7EInsSxiC8Ia1ZCZM7uEcRZ
 4m/iBkTFzc7OQGj9w3Z7ynhKZzdhTXxZllke+WRt//oiRWYO6zcdRCmWt6H4JGp8XwGI
 /W6bThQhTv8xKCofA+nKUvRJYeWrex+kum1dGer8NycvJ+dvfbV07ix9NTnRBUxouwRI
 TetB06lM3izARDG4tWL94BJ7ATeXJiT04YDbVT8JmYwqBTqXeBE3OYGX1taFJLYy1B0y
 YvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XyrErN7cbbGBASANmj3+ZttdGIYnI1ScJ2BwJK3w0nc=;
 fh=kvOOaizNZldvZrGcUk8ta2JEDnV4vPRBdkt8TLZf/QY=;
 b=eB97HM4hffcH7x2P1YLXjpixCI/HEgFOK8F3EUsfCdV3v5USTabsRNvG50f3yi74K8
 9i3HwKxX7xauJMrJZR3NV8E0xj7LdzOR1frWd8LAqw/OwL8ytz2JCXCGGfLrGac98eMB
 tRgBiv0KRyNvUuc37vcUH9kR2ZRnzsgxeLiD/uSiITvN8B0v1fanoEONXjj32q8Qg4k2
 H9ltAIhzorQlMKUrx4O7E1x0F71zz4+x11I20/JvVaFpaJxD8tQoaip6CvPf9h75x1wz
 J3nKw5zDInc7CmTkMkQx1KvUPaz/N+M8vRWelQU6S+YP/HKlPjhvZgvoiiF0dNSsUE/1
 LA1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778832814; x=1779437614; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyrErN7cbbGBASANmj3+ZttdGIYnI1ScJ2BwJK3w0nc=;
 b=RamBhCH1tzmVbUwSEkL1fKGaF7U/MjttqI8gZ7ftuzX/rZNZr/bzh796V4ZE+Yo0Xm
 dqVzFvJEiJ1sHYrIr3jQ5C2/H40ZLh3sYS1MuWGKmduP/5H/Aa/3+ZYClRSuu2RF1A1T
 P9LEGuk/V02dR0Ir3VHzVcVFl1sXOrJG+Y9JzXzEq65/Uu75TDQmGSpplfSv3AA2ToA0
 xFM7XCBBzhuAFoSR9FioqVTHRLqF+O884enmheW7Q8y9fvSZg7BJOxxd2JgmwPP2DIhx
 i5IP/HSU80ir8YWGGEQozJY7mZtNNPi9TEaFM8ipZeJXRd11yny0F/fAjbvAgTNmnl9H
 OnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778832814; x=1779437614;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XyrErN7cbbGBASANmj3+ZttdGIYnI1ScJ2BwJK3w0nc=;
 b=FZfY4EDNQ0ss/9AbbGDYCS/tuSNX0ter2ZpcJvALKO4jVBmPxwtcwq98fDrWUuF/wT
 HRtklGxPRK+BVHHLgv9933cWhUlfmFU8Ftd0SS9vWIJH6niZt2uNlC3y9RpejjoXXT1y
 d/JRkOeejRuvmfgjykioahqiiJnHhE+X9zbagZqgIAsm/g+SwCUz17YjomJMYzmUzxyO
 ZFhQWISmyLRoUSU9X6BN00o98XL5hKwax89b3nuyg0oyLDMsEE6TyNYVbPqY8GHidr/o
 2D5YmMUQ5iL08HL01hKE1f4ZEQkmwo3GSFaemUg9vfEYxlOO0OdqyfbDHWtRR3IhjaV+
 F1Eg==
X-Gm-Message-State: AOJu0YwbCPcc+ymv51hl26awIO/+r9k4sULuNIm7wf2189x7Bf2zpQ4F
 BrvgR2Gsi0EKnvkR0BSC5xM20N1ATaJFQOkuG/esmrMim29Ccyiy7zDlw3VmgAJVWPd9/r1REYc
 uhUdikzqNYGD1HYRZYJx2rFs3IUZo97UCFO007AVgrQ==
X-Gm-Gg: Acq92OHfTZNMNaY98GZmZ2/Ldg2QeEYnEX2cer6X7yTwsKbCQOLqDl59PF7WQO8huOp
 Z+Fm7Fe0xleeW9jmmlsQ6PGn+DNqVBkypGxGDo3QsIrmkvn3+wCSPxwDyoLF9qoURo+QMw07R+t
 u1JVR1SMrpit5MwxlRJkPlRMKp9yiHog1ehB/BRrs4I3CfuXnf0jGOOWtldBritDDd6R4ycFFP4
 +3jJDad1iZuDcKlY+snzXtsNHuxOFv1KaysuK/voLI9aPGDPOJb07vhjrc4tr95R0hoWJS6kosg
 X7kxveZswuVVQ6jDPp9SYqb2dAlKgcV5FD/ed8MUYH6AVIt9a5rSKq1w6qBGyTQzJGU6EjqO0mw
 gNw==
X-Received: by 2002:a53:d005:0:b0:650:895a:19a6 with SMTP id
 956f58d0204a3-65e22849a88mr2602687d50.56.1778832813786; Fri, 15 May 2026
 01:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
 <20260513105517.146706-13-corvin.koehne@gmail.com>
In-Reply-To: <20260513105517.146706-13-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 09:13:21 +0100
X-Gm-Features: AVHnY4LQ3dBhG_1d8HuEBIeuE3mVHoqQzC_EK7P5O08xXUreFyfHDisCexMMRMQ
Message-ID: <CAFEAcA-7so97etPHqGa8RBCKTo1OjQKi0bQDXVm6MAK6XbV3aA@mail.gmail.com>
Subject: Re: [PATCH v6 12/15] hw/arm/xilinx_zynq: Split xilinx_zynq into
 header and implementation files
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 13 May 2026 at 11:55, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Create xilinx_zynq.h header file to expose ZynqMachineState and
> related definitions for machine inheritance. This enables creation
> of derived machines based on the Zynq platform.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

New file should have an SPDX tag, but otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(as noted on v5)

thanks
-- PMM

