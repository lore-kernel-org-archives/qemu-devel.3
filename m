Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFD8C5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJ9x-0007Bd-OJ; Tue, 18 Aug 2026 08:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwJ9v-0007BG-LG
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:43:15 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwJ9u-0008US-20
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:43:15 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8200b55dc47so62589467b3.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 05:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787056992; cv=none;
 d=google.com; s=arc-20260327;
 b=Wa7eMqmbtLndpyXbQoiaNL7XVjU0S965rfq8l1pSp2K1xhjpMXK/bFMYrN+reUKbBl
 4f9ddf9hLJ7LzW06x7fF4eslDzMzOizWYUZXwKiOGzPPSLMsBFaJTRupS+fEIpr10sqr
 IsblvrLJ8iivb0qqyxaQ34bNrUF1MRsFOwtVdUwJ2tbumT+xJ14QoQ+28QAjhcMScXtp
 yqVCEDscmoWTlgE7nBfiUdQpcWaPzO3lUYmAU6ZuDj02uNkv3a7HdVvm2RWLVeJ/kiaw
 t2apa1VmckS/GzdvUmCqgnuEWMOgpYGQqp4dW6RWxQfQ0D1CKPdZqpsCjFOUpOnkQrxP
 ItGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tYNWycrRUIkpg9fWKOwkWpdfm1CCknAxBkVCA2SOEHs=;
 fh=9vj37u+eHcwu8xrs9kNN2ajOuXCHKTpGHD0wKu/Rzc8=;
 b=rsT4gtyt5epv58unZ1zOallfUTP0Aip44e8JcRosLQTucmxxVt2uuK4kszQsQ0sP8o
 l6oVciTM/b01qCM/26JGWmHk4e7Tbml9wL8Ds8zfAeR2eeYH0I+34EY+cgV6uEqTWOwh
 LkJFksydcX9xhzMtVMJ+jmmMZNou6ocojcWVMk5JsFGyxs1uJhtRsk1xqe6f+A3gWdcW
 bNzB0fPOhsOqDPOErQBtuyOhSV4vRAfLn1O7FZpexFdeZDGnxfJSsYrmMS2ZenA1bZbk
 TjMHvcfqVL1GXZOnp3rC2LqDmS3s9f+mUoAni3XLDgYzBnaGD0kZskI1bNgwW91gfUd1
 X1dw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787056992; x=1787661792; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tYNWycrRUIkpg9fWKOwkWpdfm1CCknAxBkVCA2SOEHs=;
 b=sclclCCXuibU6aOljWXIqoc2VodJcp3kmBi0DBYfkgI99K/EEpHSywawbSUe+wVZNP
 CZPmWbqJW/ITElWPxbwLIosfTRstaZokxO5+SY0HU42CbiRf/aDLc8STQDAq6MWtHRu8
 XD1VRwYTjz4cUVaPScM07J186CPNpfo+OG5RslCqwnxZA4NStqmaY9Ft/xQMkNMNlBnJ
 LDV9tQz8ayypcY+v6frwiA73xdgD8Wke8Og915jVpHuJ7xvbpN/UNcfiSAzK9hcUEEwJ
 U53oZmxPFhA+GpEMwLLx1tw1QXGc2zcTl9t1/KxFKOnQmdvA6Nr8Gq07btTA5/pcSLBS
 Fz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787056992; x=1787661792;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tYNWycrRUIkpg9fWKOwkWpdfm1CCknAxBkVCA2SOEHs=;
 b=QCqatXh2m16WEzBD65j4pk1nKAiX6chJChxwRItIQAixFVEcmZ/eqJcx7oWGms9elI
 BIfnjeZZiNggiMx5Ap0uGlsfbm569Fd4OSea9MrkAW0X1aramEJzpkwTXaNFAYzKvA7O
 fSAiqO+yVY9+9SS6dsZ1GZaOPLW3ylDOrYRu/hOqb9KDXrzVpuxSk9GfWswnk52HEXtC
 0R7Xw/7AXqHzztSslveHZVHUJJuvbd8H2sqdNQGe9he6XzdNsMT4hgH097CICxZqSW2t
 gHDBK56fK0KJIsrea+XFJdJEUu3JSl9qQf9pGhImxAG35BvrromievVbWKQnFXqm1Fu/
 YLcg==
X-Gm-Message-State: AOJu0YxGQh/apbNsXMD5XQH6u/IvwysfSMH6hMjzfBRp3oFlSeGK16/S
 ZMgDKu5xOlUs5CZaazSY0lYlFQaq63610CjsVhIOqFeSBLZCmBoyJAf2K3n+3SfR/fR3rPEtcvz
 3LCrR8VObHKVbA+AxDzQZQ+4wq8wbBc7WZO3w/x9nerdlpN3cdJmn
X-Gm-Gg: AR+sD12iA7UKDXoWPuyrBsXneXS4awclsmvGi80IP6BxSxXO3J1YB6STNI7mDDMjnPz
 clTKY9/9PdKRFi7esAMdDDHRyPx625+rnmK6sSZd8sT23lRDo1Wzi/FIg3EMWoRAxMTlf6elVWJ
 hZC/d1rD9xNx52ACMFGR8dkVCTXF7BdGKnv2AZdmTEea8jY2vG2kPOd03RC0YQqtvsjaNpUrMGe
 xVMjXl3Jk8ymBSDzwHpE3Th7H2yGDSjy/6LOznecvKn+ABSMw/987I4TA5WAh2ekidHfRN1zqDl
 qc0h81OI5LZaiUXjkFyg2MWxsXkCn1gFp/jX4yIuV+sjlyuYDZTGdwfbd5DrbnPKgUT775xwpfq
 u/IaRB5j7a7MvCvVXfuH//aGDx0jO
X-Received: by 2002:a05:690c:60c4:b0:830:7633:a1aa with SMTP id
 00721157ae682-83710a8e008mr119078717b3.21.1787056992076; Tue, 18 Aug 2026
 05:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260818115742.2268257-1-peter.maydell@linaro.org>
In-Reply-To: <20260818115742.2268257-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Aug 2026 13:43:00 +0100
X-Gm-Features: AcwNN1UQZht5mwFfLWc0fGol8ZvS7-nz_Kdu-qMy9P6R8ARSAyHyMiwSSgCzYyk
Message-ID: <CAFEAcA_x7JEr8nmS3043NiwenhzM3K6bEGT7T65P4+1rL118Vg@mail.gmail.com>
Subject: Re: [PATCH] hw/block/pflash_cfi01: Always set romd mode when clearing
 wcycle and cmd
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Bin Guo <guobin@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

Oops, I forgot to cc Bin Guo on this.

-- PMM

On Tue, 18 Aug 2026 at 12:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The pflash_cfi01 code has an invariant that the MemoryRegion is in
> ROMD mode if and only if wcycle == 0 && cmd == 0.  We rely on this
> for setting ROMD mode on an inbound migration.
>
> There is one corner case where the code clears wcycle and cmd without
> also setting ROMD mode on the MR: in the "should never happen" code
> path in pflash_read().  As the comment notes, that code really is
> unreachable (unless an inbound migration feeds us a bogus pfl->cmd
> value), so this isn't a problem in practice.  But it does make the
> code a little trickier to analyse.
>
> Pull out a function which does the "clear wcycle and cmd and set mode
> to ROMD", and use it in the three places that need to do this.  This
> makes it clearer that we are preserving our invariant, and tidies up
> the loose end noted in the commit message of 60d010f66f2ad7
> ("hw/block/pflash_cfi01: Restore ROMD mode after migration").
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/block/pflash_cfi01.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index a13b91967e..486fc6350d 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -243,6 +243,18 @@ static uint32_t pflash_devid_query(PFlashCFI01 *pfl, hwaddr offset)
>      return resp;
>  }
>
> +static void pflash_set_to_read_array_mode(PFlashCFI01 *pfl)
> +{
> +    /*
> +     * Reset the flash device to its "just read the data" mode.
> +     * The command 0x00 is not assigned by the CFI open standard,
> +     * but QEMU historically uses it for the READ_ARRAY command (0xff).
> +     */
> +    pfl->wcycle = 0;
> +    pfl->cmd = 0x00;
> +    memory_region_rom_device_set_romd(&pfl->mem, true);
> +}
> +
>  static uint32_t pflash_data_read(PFlashCFI01 *pfl, hwaddr offset,
>                                   int width, int be)
>  {
> @@ -270,12 +282,7 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr offset,
>      default:
>          /* This should never happen : reset state & treat it as a read */
>          trace_pflash_read_unknown_state(pfl->name, pfl->cmd);
> -        pfl->wcycle = 0;
> -        /*
> -         * The command 0x00 is not assigned by the CFI open standard,
> -         * but QEMU historically uses it for the READ_ARRAY command (0xff).
> -         */
> -        pfl->cmd = 0x00;
> +        pflash_set_to_read_array_mode(pfl);
>          /* fall through to read code */
>      case 0x00: /* This model reset value for READ_ARRAY (not CFI compliant) */
>          /* Flash area read */
> @@ -652,9 +659,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>
>   mode_read_array:
>      trace_pflash_mode_read_array(pfl->name);
> -    memory_region_rom_device_set_romd(&pfl->mem, true);
> -    pfl->wcycle = 0;
> -    pfl->cmd = 0x00; /* This model reset value for READ_ARRAY (not CFI) */
> +    pflash_set_to_read_array_mode(pfl);
>  }
>
>
> @@ -873,13 +878,7 @@ static void pflash_cfi01_system_reset(DeviceState *dev)
>      PFlashCFI01 *pfl = PFLASH_CFI01(dev);
>
>      trace_pflash_reset(pfl->name);
> -    /*
> -     * The command 0x00 is not assigned by the CFI open standard,
> -     * but QEMU historically uses it for the READ_ARRAY command (0xff).
> -     */
> -    pfl->cmd = 0x00;
> -    pfl->wcycle = 0;
> -    memory_region_rom_device_set_romd(&pfl->mem, true);
> +    pflash_set_to_read_array_mode(pfl);
>      /*
>       * The WSM ready timer occurs at most 150ns after system reset.
>       * This model deliberately ignores this delay.

