Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F152DCCF2C1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 15:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI6fC-0006mS-6l; Sat, 17 Oct 2026 11:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI6f7-0006lo-5F
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 11:49:33 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI6f5-0002rh-GW
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 11:49:32 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6767d92cde6so985852d50.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 08:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792252170; cv=none;
 d=google.com; s=arc-20260327;
 b=QpjyeahZJ5CIfgy50/OMRTOiFuOfbTOgUIYuq7lWJ/YMiB9wJ2rjvjYLfhDZj1cNiK
 Q6L/hV5DHqsFwiOGzfMAmmuKwgWyn5LvOB7yckfDqJWfiweinGpj2oSPY4IqYYED0+0G
 B2nFATsynQSKnkdgQ6TMjuqaD4IecKEeeLRbzgjj9+T3F4n0YH5EtIIvhMFODO7MKa8R
 oS/mP9V+IEptSaZIKIVZ9e02G3FCeyW1V065TDjPtLUg0kWJrDa44pMV2IcTp3AK3qHD
 jMvx+1xtebA6+x/aerEhprVhxiBoh8rOBEcGvsj3gOGqba8tl0U0IR+tbPM8A7+hvVij
 hSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rg9OOZZySLtTRXSSOvUyHxS98vNLg990guRbHpNwkDk=;
 fh=TUfzxw1B/DFEA1jNT0iQFdzEda/YXFE68WBEXYJToV4=;
 b=knoEsRC6bPsbIUZcInQxVMI2iw1czxkVnazPe14i9v9JB4yJhheqZcw0rhcgJJmpDn
 FkELZbxdO1nYuHxlB05G825N6Tg1omqglbxMLJOmul5tK5gsmE8xkS9JDGXcjAN+9MR7
 y3dw4sY4HwO37Hq7UdIkiVFFi6DpNYULjJc9tC1ICsdy3uPvNZ1u3QOllQ9nMVFpSZ/L
 YLqQJMBfSqY5UAkP6UOuQB9GGkQu8S4olLzZEZvkkzoMoph2dFp3L/pGiZK+NEkdHJIA
 RFA7BH93nZnNt3497B27XACXVK7Q25tASUzGSrg0dEdeDlLqPFSQSeAPnR857FEbvmjH
 rGZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792252170; x=1792856970; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rg9OOZZySLtTRXSSOvUyHxS98vNLg990guRbHpNwkDk=;
 b=P11WAyyOtqGUFr/SlQKxtVT5RcyZ1IQWr7gJT5FY7xywZ8D0+fJOTzhQXJ/VpAInEg
 CjO45zPcVCScCuItA5bgZ8lmw6aNq2UjOMFazxMYwN4hr8WB7OaB2adpjbM4EIcNcBnA
 x7PPV/zJ/8eHIE8aEKtC0X6n0uXt1aSbmTLegi4UhUwiivPkbh5OXuqsEVJuaXXDSqK8
 e8y9sLofNu+3ruTsOEDwX6d3wddMujfeu7pSd2zygX0VBc30uhB/TKNDovbUd1Gng3RV
 3b+CcX7vbAzM0Y11GJzSTOURFsmzn3io6rK6MVJr0qJqUQsLBNFSEODwRHSaqrmp0Wun
 RUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792252170; x=1792856970;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rg9OOZZySLtTRXSSOvUyHxS98vNLg990guRbHpNwkDk=;
 b=c+5jiUKRaGIKOomNZUXTD4hHMhy2Vve7dwECJdFHzKrYbk/sAuDZTwREogJ0P9InQN
 D4M6CUjWo5E08oVzjI6PLGRFtG929rtq4DcxEpfPNaxojXhPc0wRJCnNCWovT69eV2U+
 UCEq6BlWRRCq4C6pAJDs1PnyNatwNPc2DBPfFZLOUwOhZzHfNe4V+TaZUqXNsLAzb9RI
 L6i6hjEpljOC2h/hB1QZds6Fb3zIVxdUU+WZiTOgyikpkYVdOML0qLe2GidL3xqK9BPw
 zwgbgZ1voL3hxB8xbsp6JR1iJc+8sWqP5PbIBPHVlTA1MtQZURBbcd/75EYSnl+AxV4/
 81gw==
X-Gm-Message-State: AFq9FYJt3Le8BZ0egHRTSttKKUKZAAE/WiHPqbc9CiWN7q/FXpEc7th6
 QzVf7/8wLVfhOgqZdogqSEKf/YMtGdF7QiURaequYwOR1y/zNc6BDwOPJXCUnZxKuMoke8K7fJc
 RL686aG6/9mXSRMMJ61fh3Dmxlg+0l7Iq3oBFaifxoQ==
X-Gm-Gg: AYBFou3/5Z1toF17UOLLGQInh1qfYC+35wbcmEHxQmmQFx3cQAhVAV8s6ScoJC95jJS
 uB1CM9I033IctWLqSDiSFLLxHvPkN77IkvEpO50ZAvCzF7Qsii8k4XdXsp4FO7OJo921iDyYboS
 dm72yA7+z3/01WsliCG0VcO/WyumugMHtx4NHmrb6/fJ30cprk9rcEO41ojy/gC6LNquov6xerv
 sZ30c/RZ6CUGDPaFuYm1f4k7Ch+RT55NtnRFK7bTfC6UfSK1NGicfeGII1P96Z2y30EhMkZAMuV
 Dw39ixucGo206iHZ7kWg8WAHCYbK0d4mHxIYazIG8k5wvPenzBBT6LyDPfGtEG/fDWuNojAoM4n
 2qYMZpwI7+A2XgfClUWTqqb79QHUtMPBdCgi/2Fs=
X-Received: by 2002:a05:690c:f02:b0:8b0:e6ed:ae4d with SMTP id
 00721157ae682-8b0f21e919dmr11702667b3.65.1792252170119; Sat, 17 Oct 2026
 08:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-14-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-14-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 16:49:18 +0100
X-Gm-Features: AclHuK-KZe-rRHCcoeaOD42eRxWzP8mhkpDfpsBblbt_f9wq3UkhS1np1C0eKJI
Message-ID: <CAFEAcA9t5xLvgfF_Q5Vt-KnvXrU-FxRuk94j3c4iEPAxD_37WA@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] hw/net/bcm2838_genet: implement GENET RX path
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Implement the receive DMA ring handling: qemu_can_receive()/
> receive() callbacks for the NIC's netdev peer, copying incoming
> frame data into descriptor buffers on the active RX ring,
> classifying broadcast/multicast, and raising the RXDMA_MBDONE
> interrupt as descriptors complete.
>
> Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
> networking series (patchwork series 829638, posted to qemu-devel in
> 2024, never merged). Carried forward and completed by Marcelo Manzo.
>

Some of my comments on the TX path will apply here too.

> +
> +        /*
> +         * Report no hardware-computed checksum. The IP header's own
> +         * checksum was previously (incorrectly) stored here, but the
> +         * guest's CHECKSUM_COMPLETE path expects a running checksum over
> +         * the L4 payload, not the L3 header checksum -- and it was stored
> +         * in host byte order besides. That mismatch was causing the guest
> +         * to reject otherwise-valid inbound packets ("hw csum failure" in
> +         * dmesg, tied to bcmgenet_rx_poll), breaking DHCP/connectivity
> +         * intermittently. Leaving this at 0 makes the guest fall back to
> +         * verifying checksums itself in software, which succeeds since the
> +         * packet data itself is intact.
> +         */

We don't need comments to document bugs we've fixed (especially bugs
that were only present in previous versions of the patchset, not
upstream). It is useful to note that we don't implement hardware
checksums and rely on the guest to do it in software (i.e. documenting
where we deviate from the actual hardware behaviour).

thanks
-- PMM

