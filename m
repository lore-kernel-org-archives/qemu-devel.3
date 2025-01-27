Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93980C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQZd-0001RE-UB; Mon, 27 Jan 2025 09:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcQZb-0001Pn-1D
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:58:47 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcQZZ-0008GV-B6
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:58:46 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so6059472276.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737989924; x=1738594724; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=otG791Cv9Uc5oiyVFVfRkqYTV4AwnWUeCxL+h7sBzg8=;
 b=LYo+m9E7t6CgC5CNHKPr3NcRbptAwmabRyxVWxTqrSb1fnOTWwtyOfSOsOH/O82S+5
 v6WmhjazZBBsXxTDPIL0E8Uxu3aqtES+HQGQbz/rsD+NQSOTAffrrNnmVv2OznxYNaYu
 b4+axFYuz63lJh+/TzW65woJO3nLQF7REWtgkiT9nb3hg8H3OLTZklf01Hj1H8LZgLn/
 IRYglUql3hW4kqqbiXVa6NVPIWeZ1aBx3EL5I3PrW9mIG0m6//Acx2LuqHQyfb/fsMqo
 jPSTWNtGDvwPT0UajhoJkMFGPemToT124qlWdseQWo0gFgr72nL/QbFmBtwi85Q1ryCj
 i9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737989924; x=1738594724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=otG791Cv9Uc5oiyVFVfRkqYTV4AwnWUeCxL+h7sBzg8=;
 b=MtAylGVmopYTRqVx+iyHa+jE32nGCTjzh4GlKVKqtUcoAApnGPX14cLrDhwONGuGNt
 ZdfY2jtQd0kAhTNj+q4d6QF+IKcaOzMS1YH/RdvsVVZ7KK2KZIEWRuZNyXfVPZck3wnv
 7Ipgn/Qztq9otpL3Tgu/HkzEKkHNeqRd6rhTpajNyQBJ61tVYdeIR/ckYIUDjZCndFYM
 csL2GelafyXkTRZ4lXOKRzYQ700JRHqbF4onxWW0T6JbSPrZOl3O7onh+0iPYmFdbUFg
 zrvcNs5U/uKXCQxrw9axZYMqFJq3VxZMvBU2FDFrNItCvP/rGdE3rEHtfjh3QGdkKZsK
 bzDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVenAuRAJE9YK//q02cQZkdUsO+Pj0gphm0RcE3AslVVUHtzLIvIraq72uj5otNmFlo3Eek9yVntwvV@nongnu.org
X-Gm-Message-State: AOJu0YxaT0kAwFO0DgM4lTMhF5WQWeru9qfjA9J+BC/VLfnydSztg4jz
 1uYjAViquXY4A7YRWhP9IOXzHS5Acq5dkAAjgOofvts4sSHPhSqhWQw6+z57ktMn2H46mnpkaRU
 n1iooK8BPxGj5VPFLgHJQZDNf+SBTcNxiTPeg+1ViaG6UXcuY
X-Gm-Gg: ASbGncudOHtML+1XGOMQEEFvtr1MrvQ2uhF3fVAhaYJMqkLrdmpSr7v5lxPW13m038s
 U3I0krSee7dFbZbV8Shq+Z0iIbpns9Kz4zGMBUOkNICHB5GMiUTWlhkrm/5L4DAw=
X-Google-Smtp-Source: AGHT+IG7KKs6LFp6bE0/bF6m6BqMxtY+WIoF0lGGuB09QXVt13w/5ynnFNGd7qmRDJjw2qG7jxKLoj8dwZijyQS8MKU=
X-Received: by 2002:a25:7412:0:b0:e57:cb7c:29b2 with SMTP id
 3f1490d57ef6-e57cb7c2ceamr22406663276.7.1737989924000; Mon, 27 Jan 2025
 06:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20250117191106.322363-1-kchamart@redhat.com>
 <20250117191106.322363-3-kchamart@redhat.com>
 <87sepgtp3e.wl-maz@kernel.org> <Z44R-cUz9CWMp5Gi@gezellig>
 <CAFEAcA9arxn3FLRYS4ObD=iRkX-idgCosZkoqknqTkQwYn0uTA@mail.gmail.com>
 <Z5eLpzisRtAstcxw@gezellig>
In-Reply-To: <Z5eLpzisRtAstcxw@gezellig>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 14:58:32 +0000
X-Gm-Features: AWEUYZlVRODFL3N8bMXxF6Rq6E1zOtlt-ZjurdPo5K8h0a5JKzlcyU2awgFbY14
Message-ID: <CAFEAcA8M5F5vELuEmcjRyU_=xEpAWFWw0oHwRe4iLX9+zLwJ1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs/cpu-features: Update "PAuth" (Pointer
 Authentication) details
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 sebott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 27 Jan 2025 at 13:35, Kashyap Chamarthy <kchamart@redhat.com> wrote:
>
> On Mon, Jan 27, 2025 at 01:06:44PM +0000, Peter Maydell wrote:
> > We should probably do another fix-capitalization pass on docs/,
> > because a bunch more "ARM" uses have crept in since 6fe6d6c9a95.
>
> I can tack it to v2 of this.  I see about 22 occurrences in docs/:
>
>     $> git grep "ARM " | wc -l
>     22
>
> > (6fe6d6c9a95's commit message says that architecture names like
> > "ARMv8" retain all-caps, but I think that was my personal taste
> > creeping in -- at any rate the current Arm ARM uses "Armv8",
> > "Armv9", etc. It was right that "ARM926" etc should stay all-caps,
> > though.)
>
> Okay, so, architecture names should stick to "Armv8", etc.  (I too
> would have preferred "ARMv8", but whatever the branding says.)
>
> For all-caps: I assume you mean these should remain as-is: ARM926EJ-S,
> ARM1176JZS, ARM1176, etc.

Yes.

(We also have two instances of "ARM64" which isn't an Arm
official term at all and should maybe be "AArch64". If we
leave it as-is, I have no idea what capitalization to use
for it.)

thanks
-- PMM

