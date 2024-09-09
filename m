Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B124DECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 10:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snbdH-0000OJ-Ur; Mon, 09 Sep 2024 06:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snbdG-0000Nn-Sn
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:28:30 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snbdF-0002Pb-0u
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:28:30 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c3ca32974fso4658416a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725877707; x=1726482507; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QLwrXVBuDuZonxyJ/WzkvELXaM84BtmcnWIYpRh2SW4=;
 b=EPhhvQkcwjWsFWxB8hmX4j6syCFmR2C253r4HPSFFT0kzFxsy16IdlLpM/Es3aOf0B
 76mXzjUB+6gewrl/jf5wm//i79j4Q1bl93N/xZRT1RMbqTtRRs+W8miuj1Syvgj4GYJe
 TNoRskZCiMvjFVI6W8Lv/rqKszMZb8UXOLRiaHM5a2oxGvVfZvDmlNcfxxb2ejZJ1cb9
 zHgXVqQqSPcMyuYWU0YZ9RTxCtvT/YkaQ5BVvBl4LKxgPRN03iO/JRXKS0yx/csUcCip
 EfjmL8WPEQQy8P4Bs6Vgas6sdq/HYxspE87gMasQF2qvJMkNYbXvVmG1cDvgmG2RpkrN
 NZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725877707; x=1726482507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QLwrXVBuDuZonxyJ/WzkvELXaM84BtmcnWIYpRh2SW4=;
 b=rmxAqW+fHQawGZwy74ixYC5ARU2WmK3Grn3eoXVuUHeQGEOd/CpP7Gb5ptFX7WkGjG
 SjXXW+qkrRpzCGjR255k4f30PUDuYBoeKkHmBOVc9r4TEvMfgRrXoyzH0ytKBaoRYMrS
 tvAWSY/o4z03O8InuBuWFjP/Dwi62GOdYoZ+CTCyphkD9e4mox9cV0L0+i76aWdq/JDM
 YlgtBKLUSmdEkJ9xK1xQw+gunX5IOVkD0YrGXOtcn+P6+vcm4lQs7mtS4FUbC1ixaX09
 PBe2K6lSynXjb8rTnjDCLInYXZzoHAvQ7Pk6cEs2rotQTcq+BB0959f7GOTNoKxKwppH
 LOoQ==
X-Gm-Message-State: AOJu0YzQgIc92EtiQY2acoMzkWzdTaWJ2xhY9l87ZA3aqCqb7ZbyceY8
 aE2wL35ukxTssWHH4aS1lOj6kjNk40yzLyJiOwECQSvhSMEBZIzoJiJD78S184xD8l+nekjGIuf
 iSQd/8lcdcC/GiKR3NIII0Q7OVUIfMrSSCqXjVw==
X-Google-Smtp-Source: AGHT+IGsynsg7XtMTpLL8FHYM4Meu43Pl0saRaqmpJFEbCDXlT6xfw8ISiW9a67R9aZoCGT6pzUuVOxyxlRyyhjU11Y=
X-Received: by 2002:a05:6402:5205:b0:5c3:d251:e4a8 with SMTP id
 4fb4d7f45d1cf-5c3dc78c320mr7911804a12.8.1725877706660; Mon, 09 Sep 2024
 03:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240904124417.14565-1-farosas@suse.de>
 <20240904124417.14565-28-farosas@suse.de>
In-Reply-To: <20240904124417.14565-28-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2024 11:28:14 +0100
Message-ID: <CAFEAcA_F2qrSAacY=V5Hez1qFGuNW0-XqL2LQ=Y_UKYuHEJWhw@mail.gmail.com>
Subject: Re: [PULL 27/34] migration/multifd: Move nocomp code into
 multifd-nocomp.c
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Wed, 4 Sept 2024 at 13:48, Fabiano Rosas <farosas@suse.de> wrote:
>
> In preparation for adding new payload types to multifd, move most of
> the no-compression code into multifd-nocomp.c. Let's try to keep a
> semblance of layering by not mixing general multifd control flow with
> the details of transmitting pages of ram.
>
> There are still some pieces leftover, namely the p->normal, p->zero,
> etc variables that we use for zero page tracking and the packet
> allocation which is heavily dependent on the ram code.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

I know Coverity has only flagged this up because the
code has moved, but it seems like a good place to ask
the question:

> +void multifd_ram_fill_packet(MultiFDSendParams *p)
> +{
> +    MultiFDPacket_t *packet = p->packet;
> +    MultiFDPages_t *pages = &p->data->u.ram;
> +    uint32_t zero_num = pages->num - pages->normal_num;
> +
> +    packet->pages_alloc = cpu_to_be32(multifd_ram_page_count());
> +    packet->normal_pages = cpu_to_be32(pages->normal_num);
> +    packet->zero_pages = cpu_to_be32(zero_num);
> +
> +    if (pages->block) {
> +        strncpy(packet->ramblock, pages->block->idstr, 256);

Coverity points out that when we fill in the RAMBlock::idstr
here, if packet->ramblock is not NUL terminated then we won't
NUL-terminate idstr either (CID 1560071).

Is this really what is intended?

Perhaps
         pstrncpy(packet->ramblock, sizeof(packet->ramblock),
                  pages->block->idstr);

would be better?

(pstrncpy will always NUL-terminate, and won't pointlessly
zero-fill the space after the string in the destination.)

> +    }
> +
> +    for (int i = 0; i < pages->num; i++) {
> +        /* there are architectures where ram_addr_t is 32 bit */
> +        uint64_t temp = pages->offset[i];
> +
> +        packet->offset[i] = cpu_to_be64(temp);
> +    }
> +
> +    trace_multifd_send_ram_fill(p->id, pages->normal_num,
> +                                zero_num);
> +}

thanks
-- PMM

