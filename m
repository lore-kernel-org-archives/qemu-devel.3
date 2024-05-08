Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11ABC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gRr-0005XG-Nj; Wed, 08 May 2024 08:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gRS-0005Pf-Qu; Wed, 08 May 2024 08:30:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gRP-00035q-6x; Wed, 08 May 2024 08:30:38 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1edf506b216so23313455ad.2; 
 Wed, 08 May 2024 05:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715171432; x=1715776232; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4qmmFmgHRQlppj/tK/ouq/AbDhqnlddI8qawmh2p8U=;
 b=Q+pNCMGfFIbdtVn7tgTevawOdW27D9axXQOiBVOyEB3b+vuDShzW5Q2zCv/S+cT3Q4
 BaSGtzihw48tqBVIbh2oa2EWgi6OYMoZzfGaTQozhpi0SxwWq70NvJvo7RkmWx70QEty
 5ol9CZjgJgVsoawSLgWIXMMtU+SgcTPcQGH+l4FvSgiEabXqOF+CrT+e7iiLbLewUWNQ
 6CMJZMPitey9AD3b91LGXgPGId4iMhiMIm41EaW8C+4gNEcxz4udFAn3xFBuC9jKrums
 PyJakdBRse1eXRpM3o83TUZzHLanjTbi6nh3QvJcdw+J9zDcYCS/YwM3Dievt7zUthcV
 A2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715171432; x=1715776232;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o4qmmFmgHRQlppj/tK/ouq/AbDhqnlddI8qawmh2p8U=;
 b=IgBZpxVlOb+mySyAAba/H8UYPJyYEYDrSuWcJjRcU79Wg2xvPIRWrIG3efvQOEbDSj
 /DHmhXOFeMXkelxJHGx2EkZhI+5LJfEbCefjUyAyGcMgZ9mYIltCZx8yq+W3AHuZlNYz
 oJ/MBSWC7n7afOhpxZgQvmeV6GL92/DdtSDa3lw70qCfDgbkQpXatKdjKkfc3DSeaWzT
 mSuWIC4uI4QWsdipeBS6zZLyp2IKe7uvpwgrtifGorvorXmZHlF1FlhHsG3A3rlUdz4D
 oVGRfKlTZQOV35Y5itXxKvBb82TiAZJ/jaoLmV3P0PXJFIJKYv7Y+B886u0meRoPiZIU
 dH2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfM3pr5nYsZbM7vrbp7fDi+RxaTYDKs4k11ZRI7e5Qxk/bKe+zm/oLzwRN11FpKV7DmiupPTyC3ve66vOa/dtVhmXI
X-Gm-Message-State: AOJu0YyY0Vr+ziDuoMlx+qkFzyPBPVrlZgA+I6RMHK217W1krCKsxlAe
 gwjzIcJbwPbobHzMYpX6eHoU/t63Uk6wxW3KgGRJhF9wWylOcbRt
X-Google-Smtp-Source: AGHT+IFPj6GskyIz0bMqfsOyjCBWxTby3wRBbdgnLXzp2g9lS9LTvg/haTgjTw3klnGfqoLMtuZ4rA==
X-Received: by 2002:a17:903:2301:b0:1eb:63d9:8d85 with SMTP id
 d9443c01a7336-1eeb03a5643mr29658135ad.14.1715171429774; 
 Wed, 08 May 2024 05:30:29 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 cp1-20020a170902e78100b001e403970ec0sm2418979plb.277.2024.05.08.05.30.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:30:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 22:30:24 +1000
Message-Id: <D149IYMCXH4Z.ZPIXWOVQVOZO@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 26/28] target/ppc/mmu_common.c: Move BookE MMU
 functions together
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <d5d70791bdf598cd28ee70fd058f51c257a2b969.1714606359.git.balaton@eik.bme.hu>
 <D13EMTIRPDQJ.2LCAHIOTN0W5N@gmail.com>
 <090308e7-e3c0-8129-bdae-c2e3a41a2aa5@eik.bme.hu>
In-Reply-To: <090308e7-e3c0-8129-bdae-c2e3a41a2aa5@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

On Tue May 7, 2024 at 10:31 PM AEST, BALATON Zoltan wrote:
> On Tue, 7 May 2024, Nicholas Piggin wrote:
> > What do you think about adding mmu-book3e.c instead?
>
> I have considered that but found that some functions have to be in the=20
> same file and declared static for the compiler to inline them otherwise I=
=20
> get worse performance. Maybe after these rearrangments it's now possible=
=20
> to move these out but as this series got a bit long already I dod not go=
=20
> through with that and left it for a follow up but I can give it a try.

It would be nice.

What host machines are you using? I'm surprised inlining is causing
so much performance unless it is something older or in-order.

Should be able to move small common things inline to headers if it's
important though, we should try to split since you've done most of
the work now.

Thanks,
Nick

>
> Thanks for the review so far, I'll try to make the changes that I=20
> understood and submit and updated version. I'm not sure I got some of you=
r=20
> requests so that may need another round.
>
> Regards,
> BALATON Zoltan


