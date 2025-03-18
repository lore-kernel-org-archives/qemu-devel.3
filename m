Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AF9C28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWgY-00053C-Ht; Tue, 18 Mar 2025 09:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuWgA-0004vu-BE
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:08:23 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuWg4-00030e-Ih
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:08:20 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e60ad903382so3890533276.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 06:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742303295; x=1742908095; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yFIdGsQeOTzjrZAsoC6xSnbK/QkKBhSBYcsChn0QdHM=;
 b=LZh8Nl9xxEjghSn6QehHxD1KWiZ1dwhkTWFY4ke2HW3KKPSJo8gTIoTygKSWh4sjT+
 5xMMChmtAizFk3vUTfVMZklTfSkvwg8AB8Dj8Pq1AX2frx0gyW1vw9g7JSTbxUmNJcyU
 4b8BwRGbNvwCMvoRZi0oW0olFqNqNuoYXnk/Tlit4d5og74IYsd/UkQPBEOTC0R9vpCN
 1zBciSoWO4PUaHheaT6Y24wsCdTqbvOY5bebtbQsUQSuQFpyrrl3IGYzrvtvZL3/oEVk
 KGjGZ2Gwmkyc+JaF9jGcJ1IdH0twc5/w+hOeb7eByZCwkct0JWOk8SqmDPBns08lqkcs
 o73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303295; x=1742908095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yFIdGsQeOTzjrZAsoC6xSnbK/QkKBhSBYcsChn0QdHM=;
 b=Rlv8Js05ldjEuEHoBje+LFo2p+SxH0dXtB2ugLxL4URbRPSVS9lQMOL5CA+zHZy7aL
 pfb3qRMvjCAKUFq3aYH4egd8jCtZ7ea4l5KB35Q+FetZJgMrSwr3Wo8O8qO5N2QfFJPf
 Bz2TjhNu/XS5/tKWR4K+3Vlg6g+hdTskRLZfRcwH276dCmZ/mS+6bI13mnNVbupFgtsg
 ZM5pCapdUK0KhAM04jAuztRzNlhpLq2/uO7kenuSKnp8dV5mZ8zD3toTtpBxq5o9OQtz
 s0+hWeh9MXq8Bi6QtCf7uOftgbDdihr8VZ0a5ipMh9QCVCqRAaKpKSVLFf2bfizKA0xq
 bzvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5DciDJp2XfioiRnlfpfrSkQZzYAShaD/9itwr4fn4YkygIp06z5PvxIGniTQilvJdo1LP9P1x+ogI@nongnu.org
X-Gm-Message-State: AOJu0Yzh95q23mRya8Mvnpz3uulEa0ion2ZS+wx52ISkIwNyWIrAiDuE
 FyMy3D9U6wueLCm2iVxBZvK3rxq3pg4kDVECqBeeiDIkChk1lK4k6pmKQ69pHHTE6gJcsDQizav
 AKov3u82DHG1l9HvR1YZNHk/BBegiZ72oauXnzg==
X-Gm-Gg: ASbGncugCCGNwz/rBB3Xcnozvf2z83uYXsR3wi676IqHf7ua6lNKp5/CXxSeehTQnQq
 PFjZMY4lN9VNYEsE2N+jLysyPDyVb+hm+lpatGgTGqs6e4oMy+teciQFti4BLsvMUy+0pgS4cI2
 aeCfLXVjIOsjUfMOgGy7JwMyZeeVQ=
X-Google-Smtp-Source: AGHT+IGc1mcWOVbZyiKUHJyojszX80mV9z+1zlgo+JepXNAFyqlCWh7Kv0HZppXbF5Yd8JmA+QqDZa/ly1KJA3H/dYg=
X-Received: by 2002:a05:6902:1ac3:b0:e61:18f0:8505 with SMTP id
 3f1490d57ef6-e63f64d8f51mr22499311276.7.1742303295220; Tue, 18 Mar 2025
 06:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8RjNTZsuhShFwFUHa+YP5VKBUw2RneUPwAJ9eOVAL5Vw@mail.gmail.com>
 <20250318125952.583908-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250318125952.583908-1-aleksandar.rakic@htecgroup.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 13:08:03 +0000
X-Gm-Features: AQ5f1JrIUx0LynCNJ_n74xVn4eZYXkpAa8T_v_rvdp3CIKo7zuYqvHENKfn_v-c
Message-ID: <CAFEAcA_7TvkzcB=5Dw_oFvwNJW_7Oa5mFD9MmgbO7-pVb-hEYw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] Skip NaN mode check for soft-float
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, 
 "arikalo@gmail.com" <arikalo@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Tue, 18 Mar 2025 at 13:00, Aleksandar Rakic
<aleksandar.rakic@htecgroup.com> wrote:
> The soft(-float) requirement means that the program being loaded has no
> FPU dependency at all (i.e. it has no FPU instructions).
> https://elixir.bootlin.com/linux/v6.13.6/source/arch/mips/kernel/elf.c#L34

Yes, I know. But the kernel loader does not use this as part
of the NaN mode checking, so we should not either. We are
supposed to behave the same way the kernel does.

thanks
-- PMM

