Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976DAFCB61F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyYBX-0000Yw-0l; Fri, 06 Mar 2026 11:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyYBT-0000Y0-RN
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:37:52 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyYBQ-00035W-OE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:37:50 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64aedd812baso8427323d50.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:37:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772815068; cv=none;
 d=google.com; s=arc-20240605;
 b=DXfA2SuR4+33K5A7JZzRxiMZ7XRex5pzIIxjfrP8nBIiwzsSAuNmdsBEZIfIP0WdOM
 yCGXlnX4MMLAhrUW/rJKawvc8WOj1BR3NM5gFNiKMlZHoWRLXzBZOsp0pft7kIs9Wx+8
 LfKcohLRxCLk36RLPOruU6ff2qmcNY8gl7OSafZqaTwFg9uPN81dFRpV0y2XOgxruEFN
 D2M6C4aZyI58HxMc5QYKOL6Rqs/PM+2ufLU61HH1Jb+rt+XO2TQcTXS2DOHY9MFKZIPY
 zoZulu1dsTTYXPO1NmMGz1ZQqs71q8VqguTJ0DAd3Lj8zoUzUBxIyCgFyvZRRnPTnALa
 ApAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fhj5UqzymciJmdwmXwAsHdo8SvA2ratnUFK4+SJ84us=;
 fh=O4meA+F8l1YRat8TJxBExGYubmYoZszfvFdIP/34Qdw=;
 b=ZgNkDIlcTe5/CBRZXJ9xHF/RYZZlg0A5dCos51R3Zf/70qJaRDG5pA93Dk7HPS5XIB
 8ikPCU7ihqT4E4/u2UeZd+ErQL9qhhVNEg6Wi4hrvF2RRyZgFIMWkrqJzKjyBNp6RRyH
 q+5v/HC+Eqc1Rl7vAUBeNtmw73eVgnjglc216uZF66ClFxZmVdGMrmm+51+KXzI9Zlso
 InuRTBfxlTNxR6WUXUAucLrjBLCBUaB3222osZ7E6VCaGI1jZyd8iJ9/sGj5mOVPbje3
 gg7i9+WsKaw0q2n19q0izx15gG0kLu/H3OfvApKQKFCRixsokGr4eAeB3SULtC7DfTt3
 4HQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772815068; x=1773419868; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fhj5UqzymciJmdwmXwAsHdo8SvA2ratnUFK4+SJ84us=;
 b=GHCL2UxRYNnZvmpaYaIaVs/wv+Ppt13u379iFcEPdLgj1+maPhmwSS7JnKdZoJaw7B
 nbLBsmmuv5vgxz/+bycGT7D5MUOA5Aku8xUXrcp8r6IiaUunH60gX//sqLe3VkyctMhq
 /eUdhgKJ89PTxnHnhI6ZGCsCc396Y0ZcO6jDnrjRSDaBOwuFRXhlmAY66U6Gtd/Ec4Wv
 /fbp9UnEQ9tkDg85T4t+JFgyDhZtyFpjlUCmQKNHCsKWhadjczJ+8CucNDAaz3L+qnFO
 N53cZuXygwakplPGKBxZdC75pxJLaIAAu8dmpXlSPYji25KU352O0fDU6DAjJYhL5iaT
 YMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772815068; x=1773419868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhj5UqzymciJmdwmXwAsHdo8SvA2ratnUFK4+SJ84us=;
 b=hlcbL1Iph5/aW/TbL3Bf5+t1OGKKGvXx0t6GRHO5p2qMa1l/TeEyrwk5j4n9pMc1qQ
 gT0Wzue5YUlxy+61Wv8HL4C4YGX3Pbzwiph1a6n9akjRpCx593YfOAxWxZwrJj79gbdN
 GcAJ43GM00ZWntIQE5v9hPORESim/xZ8Q4qnIkofw2sSDhI9Wto6sJZi6TCkQhhRucWO
 jC/BReK8TTrm1o77fz1z9mpriXlKK0y7wHswC//T7fHFVy0VqNA28eRmsOaYJFENQkNF
 emlJkrHQPpNgthN9GHREnqHwU04gKx9IxVfcoh2K/aon9yDWtMTWV9MBvS+YXlWnBVR5
 flhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTO47OhMYeFHJuhkJaakyiXMH5ln243i91Konro5uJa/aZVL5l6qnTMxLUpH2T4YvInhoLqmLskC26@nongnu.org
X-Gm-Message-State: AOJu0Yz9wPQl0UEHCfVTTdpd4cH3cveHngBT/uZAY796P91yyV4svdjx
 gFl0ufBThbuXxHYsetoa+DPIukiYoBsSnCkTYmjjiMhQtwjqoLEGA8GSjvmulcPZmRnN8tapgR0
 I6DbjsdAQM8EBgbVN6p2yV6ptO/5Ta0nd4h4l2kFLs9k/xmKPzVjK
X-Gm-Gg: ATEYQzzyHyQlM1We8KSzIHXK7CUhXj4VCfk5O2z+aeK+4AoehK/Y1UIF9cPiKJD1s41
 QU5BAj8Yz43XAEgYTPkswLyr85uhOUeM/nZJ9eSw+T6Jf6guOYia58xp+5tB+Tj2E5SVR04mtFb
 xtw9ETrkObsgUMv6I+LFyfshi6CMpmJK/G9cZDUCd/9/OIoE+1p4ZsVOhTSTcNd1u6uOWff+k6R
 esqzZ6iytalmF+l9rPLqUCFHw2QnTBanpUcQAsXvwFqrpW6AtvU+wG/HX3v5ae1wEIR+FWUW+p8
 sJXbSUtHApsQL3abQiu/al/LYGtSPwKgt0eEFjZR6xgTCMuWkfVpqYLfWcg87jsTRMX6fD4EL/n
 IHQ==
X-Received: by 2002:a05:690e:d4b:b0:64a:f163:1554 with SMTP id
 956f58d0204a3-64d140a365amr2391295d50.14.1772815067644; Fri, 06 Mar 2026
 08:37:47 -0800 (PST)
MIME-Version: 1.0
References: <20260306152140.2191653-1-peter.maydell@linaro.org>
 <aar9otqHQI08k2sN@linaro.org>
In-Reply-To: <aar9otqHQI08k2sN@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 16:37:36 +0000
X-Gm-Features: AaiRm50bKbe_rYJYWTnrZFjFqS8YH6YLuBOBhvFO_Hm9U-kS0YUIIwzcJsapE90
Message-ID: <CAFEAcA-1V1okPnAdoeEse-He-_dxVan=R39yLX3xFW_bTbme-Q@mail.gmail.com>
Subject: Re: [PATCH] hw/dma/pl080: Handle bogus swidth and dwidth in transfers
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-arm@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 6 Mar 2026 at 16:15, Jim MacArthur <jim.macarthur@linaro.org> wrote:
>
> On Fri, Mar 06, 2026 at 03:21:40PM +0000, Peter Maydell wrote:
> > The PL080 TRM states that the DWidth and SWidth fields of the channel
> > control registers can only validly specify widths up to 32 bits (i.e.
> > values from 0 to 2) and all other values are reserved.
> >
> > Currently we don't check this, so if the guest specifies an invalid
> > value we will transfer more data into our local 'buff[]' array than
> > it can hold.
> >
> > Check the widths; since the TRM doesn't clearly specify any behaviour
> > for what to do on invalid values, we choose to log them and then
> > ignore the channel for transfers.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3203
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

>
> Thanks for picking this up, Peter.
>
> Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>

Thanks.

NB that you need to keep qemu-devel on the cc list as the
automated tooling like patchew and patchwork that tracks
signoffs only listens to that list. (The rule of thumb is
"don't send anything to a sub-list without ccing qemu-devel").

-- PMM

