Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F061088E5E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 17:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3HGm-0006p2-KG; Thu, 19 Mar 2026 13:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3HGc-0006oa-Mp
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 13:34:42 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3HGb-0002Nc-5x
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 13:34:42 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ea87939b3so406748d50.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 10:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773941680; cv=none;
 d=google.com; s=arc-20240605;
 b=WHZ4mgznotYi8GdHKKBNYzvUcRvo2diEJSat2N4UkHEMyM5YmsfRMiexU40nda4ALO
 4Qp7N1bg5tWZcnv+/Wm2IokJO5m5cTDO5VX5PxTC1xmh0VRIbIEOVE2V6QUilZV5ZUOQ
 QK8BheD9hyuRmI99seZB8ywK7Orw6+L/u5+3fKJ6zzzqg9c0vaZocqtO1JkWkL6qkn/X
 TFofGjKqKoqJmnR/TvVtmQyr+NC3c8rJfxgjpOXnAVeiKBng9kxBdR7+Xp76lNeOpEGm
 PhqnVWHK9ENROor8AtUnZKyW9TISg6HHQrrRpioD8CBDmayMw4ON+L1GS//By/iGP+LJ
 OWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fOL4c2q9gla+Uu04yGal6zOHbTfHMT1xGYmmambwpaw=;
 fh=LKm8SA9mUPlQVekpeFoPIxDgWCQ8iL0Atn5eXCmBJIY=;
 b=A6QpD2QEkW9sBhFNO5/mFuuen57DN7dt//bQCnao5iGmDQ2ekr8L20dcfzFfF8x47Q
 J4ldod/Xbd3ZgJ4q8FPblNW3rf4QDWpjBNjOPNXaW9Sfx6H2Lo/f0SIAcQxU1Vw1jype
 Y/FMedhoSWk/Fpc678XjG/R4hmYb+t3W+MnAsn4nxkbEdgQ5sZW8kBbfL/JerILt9WSb
 oRh8xZ8woEKCktXsGCXFsqouBsGYBTIvL/cdokUnApTSU39VeX4c2yelzr+0q3k4vwwT
 AOFMtJ37Vce1OmFxhQV+Nyo6tTbEsfekRy0CM6O3tHX0wawda3woqsGw/6fNwC/dS+EB
 X3EA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773941680; x=1774546480; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fOL4c2q9gla+Uu04yGal6zOHbTfHMT1xGYmmambwpaw=;
 b=E2TsAtUTfW+euQ4edbgt+FyHbljkwoeJAgcKyc4KsV+va5R/Xjt0Ir9zRZQEtSlq70
 PN1HHIPA5B8AwAMlpnAZFWWwSCHoCa/ItuMoW3Wucu8bwS/lmfGWvWx/4uvFFgag48hl
 KOL+5hWBJlUP2kfBo9JhnrcZPYJB86oZwzjB+I5aY5VHT6uBiIrmty4c4DdzgHaa1Sp5
 m2nRLMgqD1XazekXfMgqrWgyo0U3WcICH0kurIbGRR0Bz7iQSsNYxjHFwu3yhzVeT+RI
 JG+/oleal/9YlN+85ppedOI+YyHnIVwr6Hi3EM27fuGdBqhFuIEiMjUs9TN2xAFUqkLz
 a/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773941680; x=1774546480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOL4c2q9gla+Uu04yGal6zOHbTfHMT1xGYmmambwpaw=;
 b=f9vPeagHYQTjqyBgZIUjLM8nkbC7YRlQKGWLvkvhGI4uLVONn+yW2BL/HWZRRwSG/d
 rqxxcyyHGWwHSafDL2zhAXztBHjhkc4ItAmgCfMDKZweA5HU9Znt4J/sld2VCH8Opwf9
 fy3/IOtF7UPHp5fN2oUa0IW9tG5EAE3IGLY1C5ubiMm6hVlI1pLI0KmW94ciUpCWwFE1
 lpLHA9x7oej7aGgFHVAK8YhsPOmsWiP4qwabVgwEIEeoG6pE5BZAOvDC/jRtgqEWiZqG
 SqnsaLPRDBtAcCbZ4pW9sKtSDp3r7s1ZamYrUrJkbs4oCIeAPMcOBE0jyERxEZlMtCqy
 i0fQ==
X-Gm-Message-State: AOJu0YxECdUHgP3jiIN818LF00MN/q6ujDlEKn6fIKJsHomP9mruUb9q
 TOCYfu3zy/Zqda2i1vjPUqhs2yy3BMuC6J3ytrT3GpL+KlvcQe/8IQ11OW74E2hs6cX7Vfk0wuE
 Ap5t3rlw8dDUVGf9u8rIPbMq9hWw63uQGQVDGjDb9pw==
X-Gm-Gg: ATEYQzwhb1lGWIrO87DngtFRivQAM2aFSDQ/KHDxY4lQvnH/Mwcu0o7xkqW/CCpcvgo
 9PvoAmiVQBdopCSBBb+7AQA1WOjQedM/B5HCm0x+gu2KilJX6MZAViUkohUgkdrWJb37Z5Rez+D
 dWTHg4pwESlJszELR3BvdajtwVpxzBweFiXVc+ZB2T97UkppbEvKrAaxpL9ivtBlBzI7RTb6hGG
 l4V/t2i3B9s9U0hG9fh9zU23h6JHZVt8Dwagimlbjz8gCt2Pwv5H0dAQk1h4X4eX3fSwsJY9NLA
 VNE9lDSgkgYUkAM8dw7KibG9pj8w0NSK++WWAKSVOBO44g7GwSC3iXCjznzqCOBc2+D0gUOQVfw
 4EA==
X-Received: by 2002:a53:ac84:0:b0:64a:db17:3ce6 with SMTP id
 956f58d0204a3-64eaa698034mr450433d50.2.1773941679535; Thu, 19 Mar 2026
 10:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260318193610.2043847-1-qguanni@gmail.com>
In-Reply-To: <20260318193610.2043847-1-qguanni@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2026 17:34:28 +0000
X-Gm-Features: AaiRm52tiMAgpnS89Cv18WnTy86i_3R5QdSyFUsnAvEhA1hfStAnMDPdg3BabPs
Message-ID: <CAFEAcA_tiZT=vhEvtS3VAgjJLrYEZDBTQxm5xbbWmTBm8DLnng@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: check for MPS=0 to avoid infinite loop
To: Jenny Guanni Qu <qguanni@gmail.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, mcascell@redhat.com, 
 qemu-security@nongnu.org
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

On Wed, 18 Mar 2026 at 19:36, Jenny Guanni Qu <qguanni@gmail.com> wrote:
>
> When a guest sets MaxPacketSize to 0 in an OHCI Endpoint Descriptor,
> ohci_service_td() transfers 0 bytes per iteration. The Transfer
> Descriptor never completes because CBP never advances toward BE,
> causing ohci_service_ed_list() to loop indefinitely and hang QEMU.
>
> Add a check for MPS==0 after extracting the field from ED flags.
> If MPS is zero, call ohci_die() to reset the controller and return
> an error, preventing the infinite loop.
>
> Fixes: CVE-2026-3890
> Reported-by: Jenny Guanni Qu <qguanni@gmail.com>
> Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> ---
>  hw/usb/hcd-ohci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 1aeed9286f..b93a99593e 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -956,6 +956,10 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
>          if (len && dir != OHCI_TD_DIR_IN) {
>              /* The endpoint may not allow us to transfer it all now */
>              pktlen = (ed->flags & OHCI_ED_MPS_MASK) >> OHCI_ED_MPS_SHIFT;
> +            if (pktlen == 0) {
> +                ohci_die(ohci);
> +                return 1;
> +            }

The OHCI spec doesn't (as far as I can tell) say what the
hardware should do for this situation, so I guess "flag it
as an error" is a reasonable choice. I think it would be
useful to note in a comment that this is our best-guess, though:

/*
 * The OHCI spec doesn't say what to do if the guest hands us
 * an endpoint descriptor which specifies a MaximumPacketSize
 * of zero, which would mean we can never actually make forward
 * progress transferring data to it. We choose to treat it as
 * an error.
 */

With something like that,

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(Or if I've missed something in the spec, let me know...)

thanks
-- PMM

