Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8C6C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBACp-0004RL-Id; Mon, 28 Sep 2026 08:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBACj-00040p-HT
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:11:33 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBACh-0006Pn-LR
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:11:33 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 956f58d0204a3-67453dc240fso1584537d50.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 05:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790597490; cv=none;
 d=google.com; s=arc-20260327;
 b=coavOrhKJ674EhjsYcH2sYN3O8uyIsffXWgHhqZZ23WxSr/wk7ipjp08vS3ihbJEHi
 hqh6OGZCwVUyxJSRuZ6Glw1F0L1cv7F+vkgJSQrUfTL2wrdWNF6D8pfCls472XV07qny
 i+UCI9iLiqtRoZ8hikq4NAxQ0TBr1BvcVmzxhUaL8xJGFrcjV+xurpxmaNQ+Ja/pyzL7
 bd+I1RIEJHPlrYKODGw6f9wrJzcc0wehHcMROc2NrR2SJBy3FYHurq3TgOl80Wnzc9kh
 MfZ+379B8d5V/CsJeQXMwVf9jJxdYboNx10wsZY2/BwEbZ3PENsN+RpWegXWy1aqR8Wk
 QyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BVZ285iW8xYSkl8diGIPTkpZwkwzLt8ODv7loB0mGcA=;
 fh=WibSQDncNgWSyywKvPHAKYpHRJ63hQ7/by0Ly3U6FhU=;
 b=AQHTICGoDKQAuwoEDW9hG+yeKLJJctpDKn4D8S4DmnM4pfq3ccfJnkTz38WZPSsf+U
 jRPKrRKlZ49L8KX4foafSIaEWZudOXGs4U3B0EHZYyGzrfdZgBsou3ukwd0DmDnxg9Xj
 CmpNJb0g5FyHUaQi3IkyFpdCHI3AavyZxYn7feNfClLb+yejgdnBdLMku4wA/qYJa9A4
 zJBNYWns0pqbNCU4rTrhUPWsNXljmM62K0Fj3aB8F9P0VDsRPXVlK6RZ0RnHK38vrbcm
 pVGphd/Fg+WXzFxhRbrZD+Q1C6FM5PQJICSg65UB2O6+wsY0ezB0ITF8nAtKWpJq4Dtb
 fsTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790597490; x=1791202290; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BVZ285iW8xYSkl8diGIPTkpZwkwzLt8ODv7loB0mGcA=;
 b=eq/fG26MEH/upzw1sfoDUhUfs8NL4jStqY3MDrlGtc6+8aYfY1UfH4XzdcwFSmir/K
 0TdVuQfiovyf7d4VZ6uFXmrDUZajvNqoSB6qSyZv0X6l8SIglGA07YZo2cTLpWKkJrV3
 RWSeeN8AkjZil9NUSyQRmEk+mYI7ftKddBoMjjeoiFLGIx6G4R5um7CqEJpP9gLeIs5x
 M/eJxfEP2PnvF29HSl8artdnRjECkjzAGSaWNlQK/LKoA8HPNDLNjIB5jjboHXM1hYBo
 2mTUGpxXtWf1Sm6p82MQoNuBj01wtzfJhNCkwqIrlQbxve2qpDSfNZ3zKMrT9ZMmy8iN
 aekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790597490; x=1791202290;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BVZ285iW8xYSkl8diGIPTkpZwkwzLt8ODv7loB0mGcA=;
 b=LcsdOGnahMB2S/qSqeQ9utP4aOpYPuTRKVDwdp2DgNI9zfzJHNCZexLuzUdbPHBslu
 kyjPooc1BWgq+fue6ZU8Bhlk06Ky8n7qMAJjZfOQJ7WD5ZltSMrjeJHcjClPVF2hlJsA
 XrWNfEKQ04Sh1FNMG5VlpkXEjzDdLZ0ZqRRltO/x8EO6F07YHmQm+YNXFijHEmcJrF/h
 I3yG07TUi57iboLnbvB61VA2UDqIDqr0sKRViFKiw1XWD39n4Plkglk6N/8djH1wtjYS
 oIfYMU/zOLmjQALDCgf9xGPTATDHMNd1Cuxnrlg2NhmTw6JPYxLkFYMnrXrG2OIhYAjb
 W+9w==
X-Gm-Message-State: AFq9FYKBEx5zi7nqorO30XTIerJ7Axb/u1P2sGKAesOTHE5zo6fNE1ww
 QaZqSF069N2j3kGevbYm+CJvemaJgipR3z84IGef7JNXwfWzZ4HBaiODiS9NyaVrdJA/E8GXFBA
 P2n1VpFP1viXufYdJHodPoqJJXf48hWk7AXZYp1DfCA==
X-Gm-Gg: AYBFou2ANAcJUQB80nvT7ZK6LuyeGetifwu2ykLI8FX4ZRNYvsUobY/W7pBX5wVTQEZ
 O8uJJ9IYIwKBA2uZJksPdcsOYmVNMNrm0VrZ9DZWRGQHHZNfX/c/P/13NVe+wkH62MCvVIr6C1i
 n8MBTwe8KO2YCQDekCb3Zz+urbrCIrmjTB1E1I9r/4HPBNUyde3yDFrpy6vvvUqaHt6WEIE/lV3
 4aykvUdBpMGfC0rJPBBS12em8h+SreSGLgRaJuiRZInZIuodzILMtTIuMaC8fVNhIBTvKypLjkS
 YDDpvk4wlnf7ci5Fde14H1NE+/iwsOtVeBEIjO+UdRnKBJswunyKwJk/2McH3Ij4aT31opYE0W1
 rdV1RA4jjpQ4zeUTyespBz285rCTv4KgLfNMMhBk=
X-Received: by 2002:a05:690e:1384:b0:674:cc60:9ac2 with SMTP id
 956f58d0204a3-674cc60b315mr2526251d50.46.1790597489993; Mon, 28 Sep 2026
 05:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260916224454.91924-1-mohamed@unpredictable.fr>
In-Reply-To: <20260916224454.91924-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 13:11:18 +0100
X-Gm-Features: AclHuK9bMLoWbOKlt7SjK1LyL68r2xFbbzPleQP_W_Gsx0dMStOi9_A3hEsQfSA
Message-ID: <CAFEAcA81GZMWo5e4zV2MsWvzSXTLGskx=geamdno++3kuUQo+w@mail.gmail.com>
Subject: Re: [PATCH] whpx: arm64: check for physical address width after WHPX
 availability
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0c.google.com
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

On Wed, 16 Sept 2026 at 23:44, Mohamed Mediouni
<mohamed@unpredictable.fr> wrote:
>
> In the case where WHPX isn't supported on the platform, makes the
> intended error appear instead of failing at getting the IPA width.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  target/arm/whpx/whpx-all.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index d106400686..46f0b9524e 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -879,14 +879,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
>          goto error;
>      }
>
> -    if (mc->get_physical_address_range) {
> -        pa_range = mc->get_physical_address_range(ms,
> -            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
> -        if (pa_range < 0) {
> -            return -EINVAL;
> -        }
> -    }
> -
>      whpx->mem_quota = ms->ram_size;
>
>      hr = whp_dispatch.WHvGetCapability(
> @@ -914,6 +906,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
>          goto error;
>      }
>
> +    if (mc->get_physical_address_range) {
> +        pa_range = mc->get_physical_address_range(ms,
> +            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
> +        if (pa_range < 0) {
> +            return -EINVAL;
> +        }
> +    }
> +




Applied to target-arm.next, thanks.

-- PMM

