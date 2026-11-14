Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26C060A2608
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=r8oJ9WHC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSBFG-0005mE-Ug; Sat, 14 Nov 2026 05:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSBFF-0005jl-3E
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 05:44:29 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSBFD-0007X5-Cl
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 05:44:28 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-67bef25eb92so2279794d50.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 02:44:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794653066; cv=none;
 d=google.com; s=arc-20260327;
 b=HlogdcwDL3Q1h5TG3GLA3cDOsS9UmR9X85/DbOv07CltLeDuA+66pH2LpHVEAWCgTk
 jA8UzWhTH6c7JPp3HKlOnk4ar1F8DWC7z2HBBwrmW4MLR507cWwGQwHYX9syAQMKUuzP
 z9ch1TY+VgIAqP3JSUanhkaOpctfbYPMa78Hy28An8hnevtUR/aR+YnGs7Cq1tz0tVx7
 B5G8xx6yPs0nz1ZQTTTbDrpXbGRaESCWixnTExx+vjz2RoUlvhWNi6Edd4zEAXSD+PZR
 hRDlFGWfPD0yG+c7S/H/AmPBUTlyTbGLqW2vHL2DqKMZc57/tfJ1AqDXClehXy7GmBBG
 BtnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pWtncOK1KebY8SxXe9LHYqDbAfcFSB7aebK0lqOeypk=;
 fh=sIZKLB8CYpwWLL/O9GNiUphqLSI1Xdv3q+OjOgPEruY=;
 b=oOXpq0EGrZCnm7cmPvFFNw4k+apfBGOUWOs5hprVnKClujqSTxgCc1Xxpwzy3n34G4
 0xbcRGc6NIGdTF2EjH/nuhDBdTiRfMdjhBifKviqRJlt8sLnuK9V3FoUf/iU2oBTW/pp
 Gd3TbsdkjLi55dIXESV7BdHDkdxSCRQVRevd36h2o3XJhUo9Ucl9VYIKd4Mu7ME3nKh2
 3nublwBUZNYM6CLY4CVV98mbn/vsVlkjmP8COZlGs8yF1R0tr6Yg0rIHtZc6gJ4Mv8lJ
 cdNcRUStSWYQNayTkGutzAvkAy+DGaAntJtA3rsQw2Z3dko4Nht/BedZAMjDzwmvFqXk
 DO9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794653066; x=1795257866; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pWtncOK1KebY8SxXe9LHYqDbAfcFSB7aebK0lqOeypk=;
 b=r8oJ9WHCf4FzmZTjakoPVYC5v8uNfNw1ToQFvWiFjPvy5WmKO42s1GlJiUORZyAwhB
 G9g2wxlalhC1UQttee2Q7xLB57UCHdYYTpXUizdsCoHzsg/ctNGPnNXPHWgQM0ZKovAT
 DH+3/KV8Qh4CwFOzIsmUTtGyUBGAAoqK5al6ISDiKkgpOrZAV47Te7A5ZRffqNeNtYvg
 0nItWBFJcoNVxZznkJ3/3MGTb8kG/5StiV6SFwoo5pm/KJs3mS2leZpGcQHBUoVbGRJp
 Q4S9SFMkYOavlm/66x6Nl/QXLAwM8u7ahXmCwUvMDj0ri/YBL+diy/qEAHVk95dDQ5St
 hgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794653066; x=1795257866;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pWtncOK1KebY8SxXe9LHYqDbAfcFSB7aebK0lqOeypk=;
 b=ESLQAf55XaNaPCC7y6wxz3BkyP8QMnZwbtcFcsufiNW8jUba5ap279MJLLn3s9DKD6
 aPoLwMJ3GJrCJxxVgsP9OCNs8GpZlNResHZ/UBVTwyyWp0h690oOyt6VJu5eYAmTMSkc
 5ZkC1gu70Xl89twm4n94CrqZ+XjAJSHaXDWN75l7CHRVZS4p5vBwhCQlxfjrUyzmFjKk
 gZ8wJaA2jZ7UU+lPpRz6r8/Tjp6M2hWjxgLSARKqnmzeWKguEkArm9RaKPg7xLlnlpX3
 2Mh7aPTgoQHm9S9/bq+uSxDbrdpF/3np6iT11t2gysYSoXnKoptDwZVK4WtuamLUQHWo
 TXEw==
X-Gm-Message-State: APuU4Z9QVS9KvdKkG4wvv2NupLbsPvoBj2G8TSRHQDgQ5ibcvI9JUTjf
 O9nFiRL5cN/A4xSJLrYr3iiwh7i0q/eFSENT8KwTV9Yngg3aF96LtuAmDlPOzhS3iiNu6/i4xcr
 ayxQV/VK02+5c/7RxqpB/r9N1YpUcbHKwIbXF/2lQpA==
X-Gm-Gg: AYBFou0WqvAUxw62J68YkA8KStotL5edaIFNfCPFSiGdTbFVuUHRHpTHzhkQpPsh9Ln
 dt//z1eDk3cO243bGvTS7s3kMz60vpBGvB55U7dGedmCDs70CFbqjurgvMG3h9Gewu3mQvpfJuX
 2wpivovaLsXe4TsT5e3LplnGIQ33OCSFao4mkgekkSNpJyy28OfEu36nyY6CXHq9pEFdiyW1sFa
 mvMqE7Uf4SVyklbIMNLNgwS1veCVUnKr8N40ip4j3rBP8MozAicprs3+BAChJ+NMSXV/cmXxSVP
 HAWr9f8tGZNntw2Gtw+fUrl2qzI4epvQGM7SHHkTijwr39Y0DdtyVHGrHU1CpJyrx+idPTwyMC0
 SXMwDrWIin2TQfdBOM7ai5+NnaewS9JsVZYCuBJ96IBAE8Dl7cLB+eXuc+hmk81LkAxHuq3WvAK
 91sXZ3QJGn4gXawuJKGFmo
X-Received: by 2002:a05:690e:479f:10b0:67c:1e37:2a8a with SMTP id
 956f58d0204a3-67d896cf4bdmr2287618d50.41.1794653065651; Sat, 14 Nov 2026
 02:44:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112180239.489819-1-peter.maydell@linaro.org>
 <20261112180239.489819-3-peter.maydell@linaro.org>
 <199fbbeb-f9d9-4220-97a9-da8c4d18ded7@linaro.org>
In-Reply-To: <199fbbeb-f9d9-4220-97a9-da8c4d18ded7@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 14 Nov 2026 10:44:14 +0000
X-Gm-Features: AclHuK9JkUd_lmZs5Sh0t0eNHXRkRlUNhL8Mz4mDfneV5p2JfleCqR7oW0TJ23A
Message-ID: <CAFEAcA9w3nVdZn5GY=As8fNxwt9d-GcwnoMQj656q1V8jaR=Ag@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/checksum: Correct handling of checksums when IP
 options present
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 14 Nov 2026 at 05:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/12/26 11:02, Peter Maydell wrote:
> > In net_checksum_calculate() we calculate the position of the TCP or
> > UDP header in the buffer with:
> >    tcp_header *tcp = (tcp_header *)(ip + 1);
> > where ip is a 'struct ip_header' (and similarly for udp).
> >
> > This only gives the correct location if the IP packet has no options
> > and its header is the minimum length.  Otherwise we will corrupt some
> > part of the packet in writing the checksum word.
> >
> > Fortunately packets with IP options are rare (and often get blocked
> > by routers or firewalls), so this probably didn't often cause
> > problems, and the incorrect offset we write to is always inside the
> > packet, not out-of-bounds.
> >
> > Use the IP header length value from the packet to locate the TCP or
> > UDP header, instead of the fixed minimum size.  While we're adjusting
> > this code, make sure that we don't assign to the tcp_header or
> > udp_header pointer until after we've made the length check that the
> > buffer is big enough (the previous ordering of operations was
> > harmless as we never used the resulting pointer, but not ideal).
> >
> > This was mentioned in passing in issue #4791 (which is otherwise
> > a duplicate of #4720).
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 50dbce6538d1 ("net: improve UDP/TCP checksum computation.")
> > Reported-by: Alex Meiburg <https://gitlab.com/timeroot.alex>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   net/checksum.c | 14 ++++++++++----
> >   1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/checksum.c b/net/checksum.c
> > index 997a0dd2350..277b2e652d9 100644
> > --- a/net/checksum.c
> > +++ b/net/checksum.c
> > @@ -62,6 +62,7 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
> >       int mac_hdr_len, ip_len, ip_hdr_len;
> >       struct ip_header *ip;
> >       uint16_t csum;
> > +    uint8_t *ip_payload;
>
> Why uint8_t*z and not void*?

Mostly because it is a byte buffer that we're dealing with.
But yes, a void* would avoid the cast.

> This could also plausibly be reordered to
>
>          case IP_PROTO_TCP:
>              if ((csum & CSUM_TCP) && ip_len >= sizeof(tcg_header)) {
>                  tcp_header *tcp = ip_payload;
>                  ...
>              }

I think I prefer the "early return" style here personally.

thanks
-- PMM

