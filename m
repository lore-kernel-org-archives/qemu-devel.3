Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D15CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXifU-0001wv-Vc; Thu, 11 Jun 2026 12:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXifS-0001vW-1A
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:54:10 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXifQ-0006m2-7B
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:54:09 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7e2fc11088dso527387b3.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 09:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781196847; cv=none;
 d=google.com; s=arc-20240605;
 b=Pq/yyQJZM4qSEdj2laVrvafRKWlhFDfm0YCD7Rtgykv0LLSABLgY3M5MZtIXAKPcji
 87hoiHZ6kSx5zMFQpTeQqCH2EAaEdkOOSbpfkMNDbb5FJavGHLIhPmGkXiOpjxIlqJX8
 4qM3tyd6wE6N1FpBfBR0XwTZ/XUhe+REcrT87OEXWccSfb3gs2AWN9XY5UhMJxLRqYtT
 S0/fGU2L1FmnhQY0cULu77nTb7gIT+UnCnxGb8+q/DRKL8lxuxCtcJ6flPwQ7gyuZx/5
 HmItbqYNkf42Y+Ip35i2uqz2V7Edu6KnM9OvtArF4LD4bkkRoDxGtAyhTrUoFUkYQLGg
 3rQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QaqbYXHxzpGu3QvISyD4fmu8tEvOHjOFgehRi8Xo7QA=;
 fh=XN9Oh5CJ51bIkKbKLfsBg6zM8uQiBy0ZVlSSriHUUNA=;
 b=GYD1yK60nUbHaKeDMzjTaYmo6IxmhnHQnzC+4Hko6HbbMOIyFxtcPOUj3Wm0mzPqHF
 nn5oey80ovowbAl5944bl9VzkrMNKxBYY9tA6vLdFEaUePFv074jVpZmUuE5t9+Zktxr
 0kkcQ3JNwQbf06xuxHvr0iqf5zXBhkvKeF3DtoIMzj6+z+A1rTwrdkzbL/oYRmTMg59Q
 DYfeeTQCTmdgF7XvmE4NodiByxNBUqpjZLSHfMb1eOXoitgnzh3Ioi0l0mX0TSy+ncfj
 q8pCRVoppt9p3n2yx7e+erJDp5poeUslebUgV520n2jhBWiCsddbPNMYdzRoN3Z3Ip0S
 kyUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781196847; x=1781801647; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QaqbYXHxzpGu3QvISyD4fmu8tEvOHjOFgehRi8Xo7QA=;
 b=s2DFtvcgDQfglQKeic9d+tdwEZntrICk0NXcFjfYNWOgWraZGZhn+jPeVKsR0d4rSc
 MoSvxa7aeltfuRLS5QDyXNbTbqt9lrvHss4KONoADGAHWZFjtPmG53FaVRMmwGnNC+g5
 3QUglZewXj7eJMosICrn97FQeUCEGRnEdy0WumAWLQtJcNze1nkJ2S1JCN1I0T3mMSAS
 jcGy9qDbGWgw4J7oRy6qnUayZT6Rj+ldZHBkJCh/ESibuoaZl8X5alywYk0TguCP2vxL
 8huRd4uMkeOeU4P2N1sL/MuOXItYxb19daS51h6ctPrZgTr++6mcZjs9Tnk9yIoW5QF+
 iFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781196847; x=1781801647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaqbYXHxzpGu3QvISyD4fmu8tEvOHjOFgehRi8Xo7QA=;
 b=H57JgpI0hyZik2+DhZfh0mTILyH/jOAhzab/8qlIubDbKdlZnGUrxoHh/LMlYHJm65
 ojMm7mhl9v5O8EJ/IQy7g5BfUOO387GH02LhFxYbI9h4Gff9ozRSgLxkhNTMscNIWfS+
 Xs4rkCGmrBFA9gEw5FLukZe1rSFkf9ziOKVCjiy0qOwaGxLjAN3V9rb2hacjy6+wQGS/
 uTxbDGPh6RkAnbr7wTNZjjcYFjRc9S26+kAinwMHCmDL/4qYNqlVS3SxJ6iqqhN5Kegg
 vRWsvlnIzmEbIe/6bssF/vBVnGk3et8BD1K3q7kcslvauB+d4VTklUbVVKys/MIXLAWo
 P/8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TzOcUt3GODLaNHYngqT/RLrka86dXz2WxslCtvUDSw7gNwePVq9AlPT+HlHP9MF0Fdapq5DpPplP8@nongnu.org
X-Gm-Message-State: AOJu0YzfWnrFIkdknSM7IWGWKnoVo1lb5tLkxuJN3ZsYovrHdaeaCnU6
 CaSRpmbdxj52tw+uxueHSJqfxavcFNoetugO17U87VolgsjhPtgcooj+eWdA6pMMypP6ZjJJeKr
 1I8sDB8MMP0F+HfEd/27kBLa96M5mdOLZbCL82u9oiA==
X-Gm-Gg: Acq92OGRnTSwLYnpJTO1M/6d0YRpme7QnAnuy9ijbBXPIbCFXLGA2tcR2DNannyXuxX
 W0ynXnj0TZZO765+3bOIDmXoJ+fYjxRb4j3G2xFiObUAPHk3oHqCjcw6kDN5tEYnpWwsR8OwWBn
 Qmpjl+Dpt011E8IOQJ0AvH3TQ5IVBEFlZSqmgpbAAzO4rtpWn94da8C1s/hv1tnX19Jlj/Xq4SP
 2qIYM0GrsvidbeIpGZTjJpcbfDq0Eu2U9ANs+zy2hECHhifw+yGYaurkSaGo2WovVOmq4gLQoWm
 LmV4xgURlEwiTPlwO6M4dZQq4R2bKqp3IWZYkUHD/LSRnYekY3rWa3H3fspjZ/obz0U=
X-Received: by 2002:a53:ac91:0:b0:662:5e4d:2bd1 with SMTP id
 956f58d0204a3-66269651897mr3148022d50.23.1781196846777; Thu, 11 Jun 2026
 09:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
 <20260611023428-mutt-send-email-mst@kernel.org>
 <0c3f1dba-3b2c-43c5-b181-1426f6da0951@redhat.com>
 <CAFEAcA8Q9qEaZS8wCpZQ-4jpAnQ9JXvnb7iSeRTdhJ9Y3BcCRg@mail.gmail.com>
 <20260611093049-mutt-send-email-mst@kernel.org>
 <CAFEAcA-8Hv0o3PibjH=8jixsHyunH2HkOAMQVqHkGr34b1Ascg@mail.gmail.com>
 <20260611110156-mutt-send-email-mst@kernel.org>
 <CAFEAcA_2oZepwCoPS+cMgdnrSTj=mCGzdFZf5gGRHJK13yqaKQ@mail.gmail.com>
 <20260611114811-mutt-send-email-mst@kernel.org>
 <CAFEAcA9HUGfDgHjvCemPPNkp6FfvQp+4y7qCnw+ROFpG3+ybMw@mail.gmail.com>
 <20260611123952-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260611123952-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jun 2026 17:53:54 +0100
X-Gm-Features: AVVi8CcsPdd0mVQrbwuS3FL1IDbLwGAE2HTdEThBo87ET2mLg8p8Yo-q4T0Ywt4
Message-ID: <CAFEAcA8vOMd64cCkfCyc1wNbjEY+bnhFPce-V_WbAuXrUnP8cw@mail.gmail.com>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Pavel Hrdina <phrdina@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com, 
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>, 
 David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 11 Jun 2026 at 17:42, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jun 11, 2026 at 05:16:09PM +0100, Peter Maydell wrote:
> > On Thu, 11 Jun 2026 at 16:57, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > Then I'd like to see an example where we have an actual good reason
> > > to do execute arbitrary width accesses on device RAM when the
> > > driver does not execute them, please.
> >
> > That's the case we started with, with this GPU where the
> > virtio data structures are in this PCI BAR. We want the
> > virtio backend to have the freedom to say "I'm just going
> > to assume the ring buffer etc is in RAM, and I don't need to
> > care about carefully ensuring that I only do word accesses".
>
> virtio backend does not need to assume anything. any spec
> compliant guest guarantees it. any address given to
> a virtio device is ram.

OK, but how do we tell if the mmap() PCI BAR we have is RAM
or not ? Some of them are, some of them aren't...

-- PMM

