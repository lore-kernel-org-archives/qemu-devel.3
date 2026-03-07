Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B85FC9EF9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 11:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyqHu-0008UX-DW; Sat, 07 Mar 2026 06:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyqHs-0008SE-GF
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:57:40 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyqHp-0001vc-JD
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:57:40 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ae222d87dso9273190d50.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 03:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772884654; cv=none;
 d=google.com; s=arc-20240605;
 b=Su6eFbgdVj3MoQz3TH2oE1nQUwiWRIo+N+LAAfJY+2KT7xMcj/RJ8c9sYL5R90Pc9e
 tLR4ns1AIyqp8uo32dwtyCKTqALpnvRAjJfl6MAs0dj2ZV9e9MOSMha2Lcx8WvFSp1/v
 Mnn9TmFX4EQCOVG7gL6Wm6an1TK4zw+s7GuhrYTXCqlssEzeoKRYjCNsQIhiCFV3SGwi
 nBOG2uqcTk0IHzwsQMbYpVoPZIowjDJeeRC8XIbISZbSACBYQVbBdRvTKe0QgYgfK7Jm
 4sgZG8L1HdvLAbHEMoMOUqkdfYwB/ZSLnrRLTi2KKtDtlAnuI79uNwDCevi7A3f5s2Ql
 CRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bqjfmx6l65XDlRbYgcElRyKso9BXBZuLNioK67IT7/o=;
 fh=BWQLt1rHW1xLgWd4huE0rSwJ9gDLpGmKBg+4vEq3v/8=;
 b=Zz4FFNftNWRoZ7zUHqcntVT5LFk6+ibZbnNOAon0w/sLPqA+fL87l7dqo1FAqbwQRC
 kXYWQ9/FDqRGzJMdTEsB01goMGKJwbvbUS5oiPgGjqYlmMJCJiwFbog5oLQL5vUE+zb0
 V112SdYTqaQAcUCQROvuDajybfy70PXfEgyXG59O6/ARpBv1yCIfHHUKMJqctp6OvxHc
 I6YV0mU/gvW7HD8w623LJreGFjBBVr2X9Xwai4qw6EPM7/e01Ny9rCRXUfMAAJdRJSRZ
 wzxJy2mpBhDPGBLNYqb3c5bpuVHiIi2dwBkATUBehjvQtS37zE8bpkyzhjtB4X2lhz3V
 b72Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772884654; x=1773489454; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bqjfmx6l65XDlRbYgcElRyKso9BXBZuLNioK67IT7/o=;
 b=YWMCiKPbo9nouYmnWpEJnjUyJuVmBaHsEzfUvqihd/dnP3xWY2Gss5FLgZ/W/7XySY
 s5WFF3QPry5alPirb3T4s8LUnAYULRdKLBMFaemizxNwrY6wIxLbaJrgQf7kMcXJDrn1
 cxJ0MaDFJZKoN1DvCSnyJLckrYkwNkooMoGuTAzok4jwhoP+a2ahDFFbuFHZzE2hTpxG
 bxlJ0ZWGKWA1ysSZEgcvDMfTl9tSLt9dZpgQTAbCsgq4E8feK/kN34SNKBNRuM/A0cC+
 mSx7BTWoi6UGPw8VpzCRbFTJ0h1iI5HESHUqb5JPQqbocVeVnBS1bJhjMOg98oFE1AnC
 5uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772884654; x=1773489454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqjfmx6l65XDlRbYgcElRyKso9BXBZuLNioK67IT7/o=;
 b=Jt74et/MkAj1QapijQDtqRmPo9C5EEfA7pMfkLVau9j7bFz/BiNcnULZ/MPcXcCeom
 CrEaqMAUjfeduxC289A5PoMBKb3H80lxH3OTW3LaCnbbYX4dweZ95mWShse6Uyo+xGZK
 KuGHgm/fGykSC5ikYPdIf41d8mHis+UEM2MsxYrraaVb1Gwlj3n4tUcsHDwpEUoyeyM9
 bNSNQlLdpRCaURjZJINakVdFV/7vkWaHNP4oY/1Tlcupl+seUSr1Fbvb/3hRwu72R3sL
 kSjJ5iL1SnQfvNcs/jt0lA8WEJhNcpEFLiylnEoT9dseYsKSXaF5D1M7tjZvUIO0Sav4
 KGCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnPCFfvTGzObxA6d5KWsk4oAN7fEzfO4IZ+zhLlOhDCAku+Yb2nqLanuIdmG4rtyFbjysqJneinyzF@nongnu.org
X-Gm-Message-State: AOJu0YzZ5B2bHKHlxX2ewlsjGddza1Lg+fVRrEVQpU583Rm5Ssyrvgyv
 To+BQtrGlvgpUgE9jQdgO9AbeXWFLzyuuHWJFRcKJBnXbUIerZkcPRrywucfE16A+h38WMG+NKO
 v/6vnae3D8BSy2hvcFg9EcUVs4f15w2Y0lkKwe/tQ0A==
X-Gm-Gg: ATEYQzwTLMhd6l3PdQi8nhA4Zarrv31PS8kZ86+8BuiHLC308Ij1xrdZLT8mkwkIUjQ
 yE43aCUrf8Pv7imQChGxvaBjSEbjiuSoTZrijIChIY6tL+/2XkxKCUCclkDGhdh+nbxv85h/rHQ
 0aTM96Q94E1npS2la61YtsRGsE8W9/COwGUNkvJiWodF0JuF7fVpzQKQcVMsY7C/jWfCdvDiOIl
 y03qATyb0iGU+IrdFYebOD0WDxN39yXzLq155GrO8xzt/HpMipRyQycAKonvpqiPsp7at1PJTdG
 8tNaANqlLoDAa8/hBSqfKWsAnU5KCb91PqN6BWqCWvaUIpPad/dA1zRaMeabFLfQQdlWu9sDia8
 /OQ==
X-Received: by 2002:a05:690e:1a8d:b0:64c:ed45:c612 with SMTP id
 956f58d0204a3-64d1433f697mr3518866d50.75.1772884653997; Sat, 07 Mar 2026
 03:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20250207210540.24594-1-deller@kernel.org>
 <20250207210540.24594-3-deller@kernel.org>
 <CAFEAcA_VWSYYE+GdDRwxpWzOX6qVYptjYOe--azOzo4_pre_+A@mail.gmail.com>
 <aasZKZ1FQY5ytrb2@p100>
 <CAFEAcA8MLNYfDe_0chBmo+wwwNJoUHWj4Sg1nhCNSjodCzTOtw@mail.gmail.com>
 <aaseBa-3GVyjKGXh@p100>
 <CAFEAcA_g4tT2dTyWHoTn0hVZ_Soy7W_exh2JEE-C9U+PN4LGPg@mail.gmail.com>
 <aas7xpjiDx5Bhrs4@p100>
 <CAFEAcA_Tcarx1+EbLfrZxVpHFaKQkfOy_pTLc_T0FdNFRDfPTw@mail.gmail.com>
 <9ad53895-e340-433c-b60f-bb4901aad668@gmx.de>
In-Reply-To: <9ad53895-e340-433c-b60f-bb4901aad668@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 7 Mar 2026 11:57:22 +0000
X-Gm-Features: AaiRm539My7L3kWETUGUL7ct0F-B8d5ECEEoJJYOb4G0e05auE5h2nsL23tqMZs
Message-ID: <CAFEAcA-pRycQRdQLfvMq+jEOQv=gk_5SM5Hyb34Pe6dwPVE0MQ@mail.gmail.com>
Subject: Re: [PULL 2/6] hw/hppa: Wire up Diva GSP card
To: Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 7 Mar 2026 at 11:41, Helge Deller <deller@gmx.de> wrote:
>
> On 3/7/26 11:46, Peter Maydell wrote:
> > On Fri, 6 Mar 2026 at 20:40, Helge Deller <deller@kernel.org> wrote:
> >>
> >> * Peter Maydell <peter.maydell@linaro.org>:
> >>> You need to increment the version_id and minimum_version_id
> >>> to change the vmstate. Or you could instead replace the line with
> >>>             VMSTATE_UNUSED(1), /* was "disable" */
> >>> (which keeps the migration data structure the same, so no
> >>> version bump needed).
> >>>
> >>> I have no strong preference; I would probably just bump
> >>> the version numbers personally.
> >>
> >> New patch below.
> >> Ok?
> >>
> >> Helge
> >>
> >>
> >> From: Helge Deller <deller@gmx.de>
> >> Subject: [PATCH] hw/char: Drop disable property of Diva GSP card
> >>
> >> The "disable" property is not used, so drop it.
> >>
> >> Noticed-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Helge Deller <deller@gmx.de>
> >
> > That looks fine, you can have
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> Thanks!
>
> > (You should send these to the list as proper patchmails.)
>
> Yes, I'll include them in my next pull request and then
> they will show up as normal stand-alone patches.

No, I mean you should send them as patch mails first.
Nothing is supposed to turn up in a pull request
email series if it hasn't first been on the list as
a patch email for potential review.

thanks
-- PMM

