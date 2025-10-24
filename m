Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E355CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 16:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCKCr-0000Hm-5G; Fri, 24 Oct 2025 11:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vCKCo-0000HS-Vs
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:59:55 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vCKCm-0005yD-W9
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:59:54 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-63e17c0fefbso2384328d50.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761321591; x=1761926391; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W4SgcHATEJ0qNHnDj29cwRV7eUB29RYYRSBudT+9Tn8=;
 b=CPwxMqvkR7bLqQKWQwhE348JhVHZIK5enkaymm6cw9SdD2EOCpRb7LU2a6qfD+1LRR
 jj1sAPGrSfLt3xNUy1D8oIAAWB/h6plaobcdEByox+WUPaV6vAZ+6R41DEfaR1Lo6EFm
 P8djqS5EHe4fDb3Qg5+tZoKAiFZqyifuejFJy/qGrL00kABXPeMpcpGCh1JeBuc+cflo
 0PbAFsDgttwybyXiA0vpz9ezvwILLPbmO7zpVWvWKL8qMb1lkclR/D0WxnurFwadJ12B
 s5ZPruhgCdKW4JPUH9IQw8exHPJkl2fW0yY0I6wb1rS8EM1bNBhCmgZthy/M2B+y1Tq5
 SQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761321591; x=1761926391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W4SgcHATEJ0qNHnDj29cwRV7eUB29RYYRSBudT+9Tn8=;
 b=Z2F+e/KWtXwOJii4/XKuPisxQ+Z4qxCffNM4QplO+UH9D6T5bKAi8qR/UML8TZgZvv
 zeATdsslIjO8qixlB/5IDicKtvnG/eTIlsHQAnGTvUmYc9lCNWLqn2jpsbWKMWBQQKA0
 9+P1af02SQvhKKkPvrOtFsRANe8/8SD7lMYHe6QiFWGWzn9hYHlRfWj9eYmyeoa+0SyH
 kfFPxpGCMXYwTybTqyoyRUNK6bmSfDfeIOkvxwxI/7ptrE7vy6gtD2T2mrSetXv0OY1c
 DR4TLOJa/xRPdc+gw8zuP/dO6MajJ/ichq9pEg+inOYpgAUqUw1+d8Ry13LY8H9UMV4K
 yoJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu7ICHbrJKOH6gwzTy4dXh4yDQGYMFU/TM26V8rZDCtRHyr0DLfPjnnezhRMxdKYBXYCEZvIJdEhV3@nongnu.org
X-Gm-Message-State: AOJu0Yy3Q5363c4sdDoyapqats2cfKEBJkTClTwdjUZEK9pccjmWz5my
 U8W4HmjreFUL5kIgj/kkMaSl/DXUwXKRzCZizpC35aiUvM03yWAgYtCXrcBySzaFjVFs5KmPV9r
 j/pq0ZEKV7KiFcXWhvQVliAAw54rRXE0Z3MmurQKtZQ==
X-Gm-Gg: ASbGncua0KxKf2Y2J1zEBcQKhUqoPJLKZeOqWHvO9ifdGi4bixZ9JNTbJtlGM37WYAX
 QgnIUi3XVvvNZr7+QLgM5bkZyP9btfaCGTESEZ3DJ+D/+qbI0e3Cb0OUyc5HQL5Wrlp0ZeS+/AG
 XBbM7S358S/T9jN3+CIQkOXKa6QK952FFzsXbrD5lmQ7BlVK3E4MoBI8wgooX7i6rdi1YiuMfCI
 b5FMzvlG8v7KfF9+VbSf0e8nVWuq24MFjCqP6o+cimIaXoB77YszjhB8DOrFQ==
X-Google-Smtp-Source: AGHT+IHM5GIdVAqJ2xXmHYlLJiCZrGifJ3h7sp/SBk/IHbaVXhEzRwv2/utllJZhu+T5heONeODTNidBBvb0cA3fbEg=
X-Received: by 2002:a05:690e:14cd:b0:63c:f0a0:d2b3 with SMTP id
 956f58d0204a3-63f435602a1mr2094126d50.32.1761321591194; Fri, 24 Oct 2025
 08:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
 <35087274-df34-4528-88a2-d855768fb5af@linaro.org>
 <e3314d25-dd8a-46a9-bbfc-44fba387099a@linaro.org>
 <CAFEAcA_OLA=Ct7wFHwnfixrYofjyMDuw_5ViNb7Yxu43B12szQ@mail.gmail.com>
 <ca74ac20-f510-4c78-8f3b-85a551841041@linaro.org>
 <CAFEAcA9MjN3q06COn=_==v+zFt06Qtp9WEy7+yx2JO_L17StCQ@mail.gmail.com>
 <e280b52d-7fab-4e9f-84f4-a5862ce7284e@linaro.org>
In-Reply-To: <e280b52d-7fab-4e9f-84f4-a5862ce7284e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Oct 2025 16:59:39 +0100
X-Gm-Features: AS18NWAE21pLVXI5NZVM9eCxWz0P_IvT5BqSgFIsyGpW1dG-7JlWkCi4_aHt9fw
Message-ID: <CAFEAcA8Hx=QgL5irt2TaS-jw=Hw1FXGtRf8Xvq1GKvTPDih7Ww@mail.gmail.com>
Subject: Re: [PULL 00/76] target-arm queue
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 14 Oct 2025 at 17:15, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Hi Peter,
>
> On 10/14/25 12:28, Peter Maydell wrote:
> > On Tue, 14 Oct 2025 at 16:24, Gustavo Romero <gustavo.romero@linaro.org> wrote:
> >>
> >> Hi Peter,
> >>
> >> On 10/12/25 16:58, Peter Maydell wrote:
> >> It's missing FEAT_MEC in the list.
> >
> > ...and also FEAT_GCS : looks like I didn't update the changelog
> > at all for this pullreq. Either I was confusing it with
> > some other pullreq, or else I failed to actually save my
> > changes or something.
> >
> >> But let me add it so I can test my access to the Wiki pages.
> >
> > Sure -- please add both FEAT_MEC and FEAT_GCS.
>
> Ok! ;)

I was just updating the changelog again for the pullreq
that just landed, and I noticed it was still missing FEAT_MEC
and FEAT_GCS, so I went ahead and added them since I was editing
that page anyway.

thanks
-- PMM

