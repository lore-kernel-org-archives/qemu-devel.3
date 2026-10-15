Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E776FCC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ9G-0004PO-8U; Thu, 15 Oct 2026 06:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHJ9E-0004P8-UQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:57:20 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHJ9D-0008UC-C2
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:57:20 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c315729ad50so837809366b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792061838; cv=none;
 d=google.com; s=arc-20260327;
 b=U4cyf+bQ6iPq5JIbn0dFRn0E5630qX6Mvgmagjfu3+8qgub2h5VLjk8Leb8ihauIJY
 LXOREiiFcLzojZqwIg287AkleFe443LsB0PRQjWpAI9SuhP3K67Ot7tEFGGmoJg32ihU
 gYTYtWcwOWKUso+X9H3gcSh1pCk74Vtq7SBmFmz74LcHq2vq7jFtQ4vk+s+NoIMXBYH4
 2SKe7MuKtbQ142mFj1e7BAxFGP+pY9rBm+42hSgUwzC/kLKyVyJ6l83QnM77BD510tAw
 Ke0xiReCEbdXu88wWr2hd39acHPP5xkn7BQxYuq3nOgxUJ5ZFXaBKW9rkbXu5Ca3Z+gd
 9PEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=RYSFE9nEnpDfJSTsSGt0FMe6SX2bXMHzywunkDepyuo=;
 fh=XOQSk2i3zTHu205GUyC/R9shjcUH5+kSxVk44hirRBo=;
 b=UZ7/0TU9yThjq7jzf5IjSEFl8FCpx/9HFOqKzKKTDQ6EeWFiajJFiYneLQkcTGgsMp
 6UCOb8d2070UhoWTXofwiFH5gQimpMSgO3ok6dgEpPNMr3bpCtNVOmkn4bTgHihZ4DyL
 420HekGAaNMOPu/oynKnGEM5NDMPumPqAN2OxpaF0L0xfqFkPmv7pq7L0gwUJpDolXoC
 USPYsEd8Tbz3envZ6na6c9jWEi7uG5N2mXIJcJ7lovRJwl6//WSJTT/LXozJ6isJDwIA
 ShdiQpBXOSJlLqrEXMvGMV2VMtK5hFlwdogJCyhNa+VxVqU1vxv3/KMmKu15oxQr2foi
 0LjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061838; x=1792666638; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RYSFE9nEnpDfJSTsSGt0FMe6SX2bXMHzywunkDepyuo=;
 b=Eh6y2qUXwIOoWuBDm8WpIO/akWSkcNBjQ96NLpRVSFkML73s1Cy3NyLB4cSodHzsU6
 uItAweSjgxafkXEBF2y5f7XbqrBAMmaDc4JMPRemd0Bm01p86NlLLbQcmsHVdz4+cTUg
 4RDJfM67JiL1Nnl21AIfWIkkySxz0D83fa5kmyQFwMXu5rFIo/Bn0ydvCZfN9Q/yDkmI
 e6SWRIsqUykXYSDwWIe4XlbcWeKXj5GnJm1qkGtiTlWM2lLg4gHMfx8ZmWIb18WwFkt1
 P+fqvC6jgQzDn/5ISpOc8Q+9c8HZvCwJdomJgynmqFZXprAZDgXN+ZDf+ziwQaU62oYD
 PjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061838; x=1792666638;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RYSFE9nEnpDfJSTsSGt0FMe6SX2bXMHzywunkDepyuo=;
 b=TA8q6KHz1GX8yBePA2bIRB1jCW/VwQm9lqGoV3RkPsJaUSyAuRs4fj1GWI9vWZifwO
 aK2P/thk66yahZiEDWX9m3NLsjCOq42DOGdz+T4QOGm/K4vqxFY1eQbdBRcP6Jurr3pB
 Nr0PvFJjBkPK8rzEuoGRl9DZi9rTTwqjGTQC3+tkEUVd2PeumrEYedILjzZ5DQeywYvQ
 VoXptmKXEacholyvrPXVxF5zblSPFVPzMsMW8OIcu11RqZkamVNrMUqOSerOAg4rwUoC
 uSEzT2x00K0jMpNIi0zkyNt4JanhY0LNdm79GZw3j+PVZH6ek4kyAn5EW/jhnGSslBJK
 /eDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHdrTe1lqIIpfukNjo7qR5+us867UCe8r5/ufhGlXsYTcRCHgY3q2X41iyFRNqN1vb6QR8Gx2AJ2qh@nongnu.org
X-Gm-Message-State: AFq9FYI9TidraOhOfKR5Tppo1emL8ejJQUK9SyTE9gsBMQe6b6ehDF1q
 vWg3cpk6BUSfQve2hDyNYg6BttFO8g6J+bY57o6UsEyNmUFViB4+VA1HKoDSH6c17qP4gaSTJAw
 1leO8IosYEjQ+oxMi5KM+0SVES7VGPfiKmpFsEjmZ0uA/tFF/gtQuNKM=
X-Gm-Gg: AYBFou0bWb3k9mBV26yDsyqkttc1yzyaOnLxw7lScyluPTigdxPZEFkL48ZmB6frhBn
 g4M4WpZAU/CgBPA6gP0Xiv4A3OPizikSMQG9gySYnE69BiaKy58AJggMY30oXveuv3eSHavK75T
 /lplHu5OxnDE9Se6yiF74e8lrg4p+jKNkM4JTZHa8/wo+u+TVObgjXbMGSBaMqRg2DqjuX7Gkf3
 eIO8+Fu+T3xHqwQ5DlheDm39JpUebHBYpC0Hnq4s3dYdhLggr645uz4iwmuNfICdOCfv73NOuS1
 8CSkMLDh5yZhOKUvOw2wekw/HmPXPY/hd2IsI32KgZKLTbxG+IurTJ8i3kc22Mnv7+sz59TaR0o
 lbA84cqqy75Z25UWGjkam7vEluQHDGi+g5B48Cbg=
X-Received: by 2002:a17:906:c116:b0:c31:8441:35ff with SMTP id
 a640c23a62f3a-c31aa0e9367mr1714858666b.48.1792061837892; Thu, 15 Oct 2026
 03:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-84-peter.maydell@linaro.org>
In-Reply-To: <20261013083933.1024405-84-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 11:57:05 +0100
X-Gm-Features: AclHuK98ZKM2fa1I9u4js3-FmvwJ9Pe9eMl1-LEI_vR9b7DiuTc0hva5BCfsVQc
Message-ID: <CAFEAcA-4UtU+b5GHNvZsUf-dP7FPmc3VfREOJd0__EeA=yqwfw@mail.gmail.com>
Subject: Re: [PATCH 83/86] hw/intc/arm_gicv5: Implement saving virtual
 interrupt state to guest memory
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Tue, 13 Oct 2026 at 09:41, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The IRS_SAVE_VMR register allows software to force the IRS to write
> out any cached virtual interrupt state and configuration to the guest
> memory data structures.  (A hypervisor will use this as part of
> saving the configuration of a VM for migration.)

> diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
> index 50365c4dfe6..667f4501ef1 100644
> --- a/hw/intc/arm_gicv5_common.c
> +++ b/hw/intc/arm_gicv5_common.c
> @@ -116,6 +116,7 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
>          memset(cs->irs_vmap_vper, 0, sizeof(cs->irs_vmap_vper));
>          memset(cs->irs_vpe_selr, 0, sizeof(cs->irs_vpe_selr));
>          memset(cs->irs_vpe_dbr, 0, sizeof(cs->irs_vpe_dbr));
> +        memset(cs->irs_save_vmr, 0, sizeof(cs->irs_vpe_dbr));

Cut and paste error again -- should be sizeof(cs->irs_save_vmr)).
(Currently a harmless error since they're the same size.)

-- PMM

