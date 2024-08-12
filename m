Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC5AC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 07:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdPUm-0003Ge-Sk; Mon, 12 Aug 2024 03:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sdPUl-000397-7J
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 03:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sdPUj-0004IX-PA
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 03:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723447772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4J+Piw5GQHUXV0O5DFF8QqhV4GUHNLBkAmnLyMH59E=;
 b=TlqSQ0i4y7V2Fq64A0zYLnM1O57V1E0OyKRu58o+1CqC27bNOHV1UiYINVGS4w66FZtGf2
 fGciVy02FmvouecIYStZMTlK/k+Or7CHIONt6Ef/HU8aplx60gYDWBoWuWs1d43FYOQqyb
 r2F/pw8mnuH0mdXLfe78WNDx6Kqin9E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-90UE2ZiiM-urN_wgEFPv-g-1; Mon, 12 Aug 2024 03:29:30 -0400
X-MC-Unique: 90UE2ZiiM-urN_wgEFPv-g-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2cb4bcdd996so3725196a91.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 00:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723447769; x=1724052569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4J+Piw5GQHUXV0O5DFF8QqhV4GUHNLBkAmnLyMH59E=;
 b=vzpVGIay5Tpgh3oESW/Q4/VLwSVyhnq3kYNZldUijl3i6ky41601mbVXB8ahNbJMfy
 X8rV4JilSVWW+RUlxItbAEv+J7Wofk/my6lRs0iIizVXob6+RZv+GsRyugE3J5Yws38K
 0h7/3v4q+PWRH+du1i3IC8g53F4DoXWC1ciSuPzREa5KBsM5iW8boo2zMXZTlb+IiHET
 JCOjkvgBA/Ud6xJy1wsDX1KR5vOA94VtQw0zBFDfc4jiLRviIcfUlYioLSPaVPPDXoTL
 0me4MituWO2oHUKKWhDK5aOVardfyTDTfVVxrFkMjk9C2j83aED66COltc9C20r6e1ec
 eIfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHwYTRK30m0Uu6GFkxDkpDwRXkJSlKe0T5MF9ydUXgj6iB7+aX23mch9zKEYKcPT6VV7PnBOih1fBI@nongnu.org
X-Gm-Message-State: AOJu0YznQp0ZvraZes+AivvsIE0OUR550yKqXDX+gEj2VDU1dPe49bIR
 rNG5TtSqy8NxcyxkKTIcYipUP2Fd+N1mh9pBkpBLdM03LNN8EHZSHOC9FWl7e0wfzfTbK/NcLrv
 S9n/oDa9JL86KZQQqLQzyhkrbbhwqiXmDkA0fCEPSMQ3PFfjnCfeASBKHKp/zHLjBcXz+poZhGs
 cFwtnho6qQf967XD3uaq3eMyOosLo=
X-Received: by 2002:a17:90b:1197:b0:2c9:a831:3b7d with SMTP id
 98e67ed59e1d1-2d1c4c2db64mr18659439a91.18.1723447769605; 
 Mon, 12 Aug 2024 00:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJqupq/dUZBLfIy0GFN0W2ZtkAo/Myh7XWWdxdiYUUfCTNLY7d00LBeVLb2WuUsfzaqiYJJOW/PBQq5uxukJ4=
X-Received: by 2002:a17:90b:1197:b0:2c9:a831:3b7d with SMTP id
 98e67ed59e1d1-2d1c4c2db64mr18659418a91.18.1723447769106; Mon, 12 Aug 2024
 00:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <c5f7438e2e0c40b0f89030de1096335f5704d3a5.camel@infradead.org>
 <5d9e1e69-159e-4570-b7d9-6db21e960d2e@tls.msk.ru>
In-Reply-To: <5d9e1e69-159e-4570-b7d9-6db21e960d2e@tls.msk.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Aug 2024 15:29:18 +0800
Message-ID: <CACGkMEv0KrPevx9EG911myabDO6S1o86Qan1bqLLdrJfH8brug@mail.gmail.com>
Subject: Re: [PATCH] net: Fix '-net nic,model=' for non-help arguments
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org, 
 qemu-stable <qemu-stable@nongnu.org>, Hans <sungdgdhtryrt@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Aug 11, 2024 at 3:40=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 06.08.2024 20:21, David Woodhouse wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> >
> > Oops, don't *delete* the model option when checking for 'help'.
> >
> > Fixes: 64f75f57f9d2 ("net: Reinstate '-net nic, model=3Dhelp' output as=
 documented in man page")
> > Reported-by: Hans <sungdgdhtryrt@gmail.com>
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > Cc: qemu-stable@nongnu.org
>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
>
> Please pick this one up to master as a bugfix (Cc'ing rth), or send a pul=
lreq soon :)
>
> Thanks,
>
> /mjt

I've just sent a pullreq.

Thanks


