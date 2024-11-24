Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62569E668A0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 07:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tF7Do-0003eo-Mk; Sun, 24 Nov 2024 02:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1tF7Dn-0003eb-Pw; Sun, 24 Nov 2024 02:39:55 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1tF7Dm-0007Xe-B3; Sun, 24 Nov 2024 02:39:55 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso30882385e9.0; 
 Sat, 23 Nov 2024 23:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732433992; x=1733038792; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K33PgrDWo711VT0gKLOzkY+T+R4zcRcG05hDCHpWivs=;
 b=HsPLY7h2s7UCmrC6fsmo9THr05E4bp53HpAtc7EHVMiCPwn3Lw5LSrAGd0F0wn4Hu/
 2Aw/w1Pi9diDypS37xd+F4PMT+rXg8jVzoqra6yFO4zeT3XtapUxmZ7KsAyIjGO/gyAn
 rZjTJrC/kXiKdUc0xAlt/yoySP1TelqRxVYMD+045USaL+21t3VbUV93J6OcD73Bc26V
 8p7qDiux6S2vquCTd4m+U7Oz3DTfwbYZ9IDnjElwx+Z8ZWf6NkOK2VFSPqP0h1ehQYZ/
 l6PaR7pPuBuoY0RL6mYI4McLPxmtUoK6gyd4J/WF3wjL1zDfRcz+23lQnNmalR7+PkFc
 1gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732433992; x=1733038792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K33PgrDWo711VT0gKLOzkY+T+R4zcRcG05hDCHpWivs=;
 b=vmIg98o8QEOcGiHR/UreLlZpJDoKRCmY7HxSpzyh2S0zmkspCmKopLfoj1i6mDBbgT
 mss4uFlEn1hQ0jONNy75WCc7LtyOzogNs4EemsaRtDsFIDgxLRtVx17KOexdwAfkErRc
 DP9yLaMYXBTtynV1raEuENVWyexF5u2/3EepkdH4xH0AnR/uGIul691sEGbnIROfhs91
 L//ahi2ulrq6yvL1KsZw82o7mRQXQbT2XKh+cSrnE3NtALyWrp6t0DTvTw0/tpkaqlJ3
 1OaFglGxnUoIGZQizBLkmqCHOFAGFBl5odmVIR6p03f/COxRW9YZOgEhA115fktotlhI
 TiSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx3rq8Uef2UxB8ylzuTsvm16NgI3Ku/E6FzILnpg3zAFZGA7YsMB+ZZ6yhcTSC5ynfanm0BkafJ9UzUA==@nongnu.org
X-Gm-Message-State: AOJu0Yz/hgGMmYxUiqd2i18BvXXNw6XemO/6qQUcQU8PvAxEwSGnZ0fn
 zSEQi2FtU8vOrhf20KRbRJDfJsGG0SQQUzpufmbgf7HbBiKLzioVdqSmzQ==
X-Gm-Gg: ASbGncszVUPOy+E+mDeJ/TahgMNMj6pwWx/iaaLVgcQUnWGyOtACkzqZmK26w3+tuvB
 LZbzANbnvinPqmihRVLVI573bhdnQNURwNkFTYe8iiU2CGcnCVDYPCFvpO+F4Y9Fb2UgqqlinFx
 rhOJnX1/5UaEE7agQVyNOZJtVlcaFnGfbQWzWAV8EqhlPVKrci7MfPgKcNvs9+z6h7EaCxZPcby
 VoOtTSCYKjJyt6et02ux42Ofj2B8TCKoTV7SyOoxcgtYycdAiPc8Rwl4l6DOfpl4VKfKKBMLoZl
 asT94OYwGwSRZg==
X-Google-Smtp-Source: AGHT+IFAk2SRpAlOmnFVP1DH1vScY6an/o4b/bEeMpI1D7Wa/RCIo/9O2YDw5RrxMZVUgkzgaNkAEA==
X-Received: by 2002:a05:6000:1f82:b0:382:4a6c:fdd4 with SMTP id
 ffacd0b85a97d-38260b5016dmr7366979f8f.9.1732433991870; 
 Sat, 23 Nov 2024 23:39:51 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349cc29406sm18218815e9.0.2024.11.23.23.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 23:39:49 -0800 (PST)
Date: Sun, 24 Nov 2024 07:39:48 +0000
From: Stafford Horne <shorne@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Development <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH 0/2] Misc OpenRISC fixes for 9.2.0
Message-ID: <Z0LYRNhkDJPKbQ21@antec>
References: <20241123103828.3157128-1-shorne@gmail.com>
 <618427e1-ef6d-439f-be0a-6d573b28f1c4@tls.msk.ru>
 <Z0IKhkyU8YdI5vyP@antec>
 <a7afbef0-89c5-418d-8d98-8c3e2d0698ec@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7afbef0-89c5-418d-8d98-8c3e2d0698ec@tls.msk.ru>
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x334.google.com
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

On Sun, Nov 24, 2024 at 08:03:53AM +0300, Michael Tokarev wrote:
> 23.11.2024 20:01, Stafford Horne wrote:
> > On Sat, Nov 23, 2024 at 03:12:12PM +0300, Michael Tokarev wrote:
> > > On 23.11.2024 13:38, Stafford Horne wrote:
> > > > This series has 2 fixes for OpenRISC that came in over that past few months.
> > > > 
> > > > Ahmad Fatoum (1):
> > > >     hw/openrisc/openrisc_sim: keep serial@90000000 as default
> > > > 
> > > > Joel Holdsworth (1):
> > > >     hw/openrisc: Fixed undercounting of TTCR in continuous mode
> > > 
> > > Is there anything in there which is worth picking up for stable?
> > > The first one above seems to be a good candidate.
> > 
> > Yes, I think so, would you like me to tag it with anything?  It does have a
> > Fixes.
> 
> Well, there are Fixes and Fixes.  Some are much more important to be
> in stable series, while others are hardly relevant.  Obviously you're
> much better to judge in your area than others.  After all, maybe  you're
> the only one in this world to run or1k, and you don't need stable
> series at all :)

There are a few more people running or1k qemu for itegration testing of various
ports and every once in a while I get someone coming out of the woodwork using
or1k for real world stuff.

But sooner or later it may only be me.

:)

> From the two fixes in this series, I (with my very limited understanding)
> see first one above is maybe good for stable, while for second I don't know.
> So I entirely rely on your call, hence I asked.
> 
> As for tagging, you might add Cc: qemu-stable@ tag for all changes which
> you  want to be back-ported, or just send a note to qemu-stabl@ with the
> changes you'd like to be in stable (note: this email has Cc: there already).
> The key point is to make qemu-stable@ aware of what do you think is relevant.

Thanks for this.  I will add Cc: qemu-stable in the v2 of the series.

-Stafford

