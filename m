Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FB8CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 11:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGxqE-0000CS-Jb; Thu, 06 Nov 2025 06:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGxqD-0000CI-4o
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:07:45 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGxqB-0004ox-QT
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:07:44 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7866e9e62e1so8104387b3.2
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 03:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762427262; x=1763032062; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xXqYbbuLdWBDn5cZrYjOU4grQxbikWDAOsP6gK4qtwI=;
 b=fYZae3AvMMLajNojzT9aQrTwzLf2ojeEq9T+eZy/a2jJZ2u3hjjGoEiWZmbUz2YkpD
 5bKU+ZWrjY/a9uqZKOkGkTIXDxOXIWDI/Z8V76RdaSoPwxxxAsVC+pUVqWjsjp58MGjZ
 //um4ud2tkf1sSJZYNA9rvz+SHuBPpR6bfKjbu+Q3nMQzr3YcJHkloYLrt2O5vu4qBbH
 6htFHp/Qjzm5ulpYkaVFNn9pIoCGu34HSrhb4SbWaGRmuzjfmaNba9ubKaTpS7BH3G2t
 8JlrvxAJEIuvSOKZOgkRhpLH+HN/UaXKgJBtRoFzR2uQd17EzDLpLC0ebXlY0uN1sUvX
 rkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762427262; x=1763032062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xXqYbbuLdWBDn5cZrYjOU4grQxbikWDAOsP6gK4qtwI=;
 b=Tbl+ppebq96VDXzOLfXco48viFzKpiEehh344wLfjp0gusTCd5QQIKfx+tUuU/DM7e
 VD304Dyfg05FSsomVIulCbjlrZPsQhUy5KATNo5MXhuaWs2Nd6f5xsfOBEW+sktsuIZY
 JWXINB7MHKspd4fGl3kiIr4UWwiPF7tvyLsR5LTvjXy2+jvoxnvz7nQivMPvD+AtofFw
 jlzEFw5OYKHDmZIVG1pXt1s5E7dVXsz9fukM4oYU3BslEfbisJ8JF4Yxu/ZCDdaHQMci
 KMyX4RvzWVz4sBQSVlWVeLN1jjj5+g3j8+M3cTWJ35geCvwyiL7XTa84e/liviH6d1bR
 HqyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8ZIb4H5F9Ag0CeqcUcskotq8sbbnoHW3ccWBzLxDgdvLB2wpe9yHzub3SlJkDf7dYccBaYUI03brF@nongnu.org
X-Gm-Message-State: AOJu0YywgzV3FOLUvM6NzSBcGhCKnkBI4ofA/za0EYGS8kBXwSGq2kU/
 Spnu8SPhmKbWGy+1aLkL9GElHkK6+GlcV8FxtmcOCEluUfUV/hmraFPxo8SCy0LmB8ux4fgIpTU
 rYUcoRxHQYa+Rw9tl5NZowAG/loW+O3YKVQWa27zjbA==
X-Gm-Gg: ASbGnctjQOrQvOFx6O++bnw9slIFQtP1E6LQtadUGE32Ejz25iBbMO/6FztJPoBkwKn
 c+JYe2NbPt+/hnyRuvJy6st3JJYy0gIeZUKfJh78fFaxPZ+M4JbgHymWSjKa69U60VsiWzO81xT
 6XoXcitVFf37356YjAOIH50EKIg3Oy10HDH/Cw0Qt7kr1fizZ7ay3212J/VYXbRdDojDLc3NZBG
 0uzvuxPQ70s8vHrFl0b9sfnrjR96+WvA6rN/ghzqPDr5G4LLj2ZHsndOTxulg==
X-Google-Smtp-Source: AGHT+IGRX7ko5QrqKHMZJB6C2KHerfN8PkMHit4qL2B7yKpfT1AFQGOGzDEvwJrDvjsua72TnuAYAWTVORuEk6PgQSY=
X-Received: by 2002:a05:690e:428f:20b0:63f:b983:5a51 with SMTP id
 956f58d0204a3-63fd34a87fcmr4773471d50.11.1762427262292; Thu, 06 Nov 2025
 03:07:42 -0800 (PST)
MIME-Version: 1.0
References: <aQtAotYvzFY0Vpft@tcarey.uk>
 <5c356c12-55b8-4d01-bc0f-025d3a3b9293@suse.cz>
 <CAFEAcA9c0Y=ndvd-yV5tTr_+nbBO7W-TDcF4+=qCoknzyGPxAg@mail.gmail.com>
 <508e699e-ba3e-4977-9507-8da7da14fa28@suse.cz>
 <CAFEAcA8z-voiUiBx2bTjUq-GuYJgL96ai81aPAyhYTJvg-uieg@mail.gmail.com>
 <1e8e6966-cc2d-4970-9529-510ad91622c9@suse.cz>
In-Reply-To: <1e8e6966-cc2d-4970-9529-510ad91622c9@suse.cz>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Nov 2025 11:07:30 +0000
X-Gm-Features: AWmQ_bnSlVX16Ef-cpKiz4YqksRKKllNlUju_cyrgMfp8ylhoRF_RWyMHzyWczE
Message-ID: <CAFEAcA83na3XZJA7Fagjyuu6riJmu0APqEX=PReNWi9-0L3zbw@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/edu: restrict dma access to dma buffer
To: Jiri Slaby <jslaby@suse.cz>
Cc: Torin Carey <torin@tcarey.uk>, qemu-devel@nongnu.org, 
 Chris Friedt <chrisfriedt@gmail.com>
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

On Thu, 6 Nov 2025 at 11:01, Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 06. 11. 25, 11:53, Peter Maydell wrote:
> > People debugging drivers can turn on the GUEST_ERROR logging
> > which should be a big clue.
>
> Hm, so errors are not logged by default? Neither the man page, nor
> google yields anything useful on how to enable this. This does not look
> very promising.

"-d guest_errors". There are other error categories which
you can find via '-d help'.

thanks
-- PMM

