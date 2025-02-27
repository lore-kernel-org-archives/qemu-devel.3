Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA862C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 15:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngBj-00055e-Ax; Thu, 27 Feb 2025 10:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tngBe-0004yM-54
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 10:52:34 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tngBZ-0005b1-1B
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 10:52:31 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e6087a8588bso1095330276.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 07:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740671546; x=1741276346; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MTO/pg8l5Vr26AuUe58rroRQkc9rGDddVuErXlIKOXA=;
 b=regz246kpBKPu2KAtI9e5inSCt9MLC112RYFU11h8Sx2fN2QXOUNTNwaGExA3opkhE
 IpwxEugMkCpBPEw88Jl4iRyMB6MhqSYqDyPmchq6U2oLClvcwRMaWYBM04C0uQMU2JwT
 bVd4LiFuG7jFLKjkJwrH3d4klm3h4zUpIhmmdZOkHm26TQdn8SQmEA8rMR0KKr+alt0O
 AjjQU7smky5FLpYdEt+2h1T/GLmDHE823WOC+4hE7NW44784teDavw8amCmjJXkBimlM
 xsbipLuj+OK8b+pmeSzmYGuF2Mrae8Uc9iugalCsqxEsh5QfBza7xrs7Q5nsrIyVjhKY
 Wxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740671546; x=1741276346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MTO/pg8l5Vr26AuUe58rroRQkc9rGDddVuErXlIKOXA=;
 b=bH5Iin7Hu342b8HzuXDegZ/IJRAomsISPG/+HoOVTGZ6t98tWTBh8fahcejULcuvFM
 X1mnCfP+SFoisMn8aASiOFXTcxv7ezJl2mdi0NWWWfOaXTrouQNM++5v0Vi37ljJNBFp
 88wdH2wCwyTaitVD+CHOSeLDrdsrXhXEY66UkluRLMhaGTZWAE/Mo+aM9/3kTDycVNe/
 g80tTh5ngpK7EJsYRjisb3CrygYyWfFAk16e3AI04ciIm+VyKBnH+72cPdyonEceUeSA
 y5Nxngg5A2BZ0JdVgtNqxIyxw98/fW7hm99KrSTD93qeAt//tlWJORpwJCNhP6D4v+Jj
 zdIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWNitMOEWYw1xkH5G2B8/q1u40Whn4D5uTEsqG3GduLF5LJh8qcyTdUBdNH98Mee84wXw8Eh4cH96x@nongnu.org
X-Gm-Message-State: AOJu0YxXV0I0ahyKsJZRAB/ch0DgxcTdXegkhTFkmXnWLe1ZV0M5pQqX
 x1JzHjG4NWdEj92vtlw7WxoKPnDUxKKirwmb8maKcs419UXTNWETRZ3Th4rZK2F3LtisZAvcrp+
 9e0yHN6+3NNwC5UyC2EHkgBCoCXbRSuXKBGVybHBp2qJ/BvnZ
X-Gm-Gg: ASbGncsb2/lgHPhTqXfwiWVg0Y91+AxXkCrVbomDuKChZJllsZzVg0H47X39cLnuL2R
 vEw/nt1m5zAh1stop9I5CzfkFsulK8wSpurJGkUF2nngTLZI31zfWFO7eXpj/cKuCM8UMKTuvTr
 BIg11506/G
X-Google-Smtp-Source: AGHT+IG2YIA9gIVdhAEEI9BiMgalbMxQa/TD7kY67fsUkcph5CFWIY2cIqCKoRmiXDgQeZVjYWEyddVWLDst9wfT2gg=
X-Received: by 2002:a05:6902:72b:b0:e5b:33c2:5a03 with SMTP id
 3f1490d57ef6-e609eebe81amr3922277276.9.1740671545860; Thu, 27 Feb 2025
 07:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20250227154003.1646017-1-venture@google.com>
In-Reply-To: <20250227154003.1646017-1-venture@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2025 15:52:12 +0000
X-Gm-Features: AQ5f1JrV_XZ-0UJSzn5b46MxdfzVyP4qP8KhXHWf71Xh1HxyeyCxw9u_KDbDEIQ
Message-ID: <CAFEAcA_wR-M3+BhZY0MFjv3OfoyL2gvukduvKZ6ksKwUKmdB6Q@mail.gmail.com>
Subject: Re: [PATCH] hw/net: npcm7xx_emc: fix alignment to eth_hdr
To: Patrick Venture <venture@google.com>
Cc: kfting@nuvoton.com, wuhaotsh@google.com, jasowang@redhat.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Thu, 27 Feb 2025 at 15:40, Patrick Venture <venture@google.com> wrote:
>
> 'const struct eth_header', which requires 2 byte alignment
>
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
>  hw/net/npcm7xx_emc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
> index e06f652629..11ed4a9e6a 100644
> --- a/hw/net/npcm7xx_emc.c
> +++ b/hw/net/npcm7xx_emc.c
> @@ -424,7 +424,12 @@ static bool emc_can_receive(NetClientState *nc)
>  static bool emc_receive_filter1(NPCM7xxEMCState *emc, const uint8_t *buf,
>                                  size_t len, const char **fail_reason)
>  {
> -    eth_pkt_types_e pkt_type = get_eth_packet_type(PKT_GET_ETH_HDR(buf));
> +    struct eth_header eth_hdr = {};
> +    eth_pkt_types_e pkt_type;
> +
> +    memcpy(&eth_hdr, PKT_GET_ETH_HDR(buf),
> +           (sizeof(eth_hdr) > len) ? len : sizeof(eth_hdr));
> +    pkt_type = get_eth_packet_type(&eth_hdr);

Maybe better to mark struct eth_header as QEMU_PACKED?
Compare commit f8b94b4c5201 ("net: mark struct ip_header as
QEMU_PACKED"). The handling of these header structs in eth.h
is in general pretty suspect IMHO. We do the same
"get_eth_packet_type(PKT_GET_ETH_HDR(buf))" in other devices,
so this isn't just this device's bug.

thanks
-- PMM

