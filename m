Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2C1CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRvoo-0007jn-OI; Tue, 26 May 2026 13:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRvom-0007jO-8l
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:43:52 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRvok-0004X8-KX
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:43:51 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65890a6ca20so11807711d50.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779817429; cv=none;
 d=google.com; s=arc-20240605;
 b=KCyMfDVJBb+W/dyBkmKYKwdKdWmRQgChXCtfgMWAUClc407yWByARwqwJphuAeSet/
 n7iE9hIXx7R7hC645Ugd4P46/nvGKrT809lUyBebuV6Ey5U0/qoOZUOBViaDTbAoZ2Yg
 TIT9mUOVLcp//BiklOjjdA5UTcytSJUEn/AFNeqSqopZmxUCZrxeY2uSFyayRTEf4aY/
 4/Ctgt3JaBtNTOSfI2lbn/fK3vMbyB3/Hn6NIbAZmpPCdCPz9xyFyJjz3ACJ+0+1N9Mp
 6YxbVrj3/0Hm6zcSkInaD+NmvPX+081QOMPzjEbMLzlt/EvhfI7ChlwJy2UgvIFlamnH
 LTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4yam7g54VFV6lsYYtH6QBmklGyM1qni/UW82Fi1yWJQ=;
 fh=Fva4iuB95AGoP8d2SxY+W/hDk3Sx+eIx2nAhH049jjA=;
 b=LtcDwLgM0XEO4UMrGTRmmHplEZ2HacuF1nkOvzlL55OA4RLyi3QI86/iE5OWsCPS8i
 sNjpjokhiqYb0ZUkgU1HtsOaYast1LOribii4mF5gwx/JGG73eZqg4JOVJ1RO+okDZjz
 I9Gu5ALom+3wYYvjhLIQHVuOpiUuVKQOBWNEZgs9PbAvAzeta/MeCvMPgubrsfRkYsoz
 inJjXGNB065A1LzzmAAJ4dZLPjefBk/TSu+HDw8CQTL2aW0qSWImNUQ8DCvS+AU/RD+R
 HxTgfklKY3YzS5wK8pV3u2O2VRIaBekcIl+azFqsMVmWnjgQX4Y1sM1v3EmG/cAP6Zou
 sIzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779817429; x=1780422229; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4yam7g54VFV6lsYYtH6QBmklGyM1qni/UW82Fi1yWJQ=;
 b=gXg1ny9voVU5NJ8CdBrVN5pAu0Ag/N+wA73Bz2u4PtVyyzWy1Jd8d1OgQTYWFsYmml
 OlIXcJnHFkU1nzlQ14Vyh1TsXZU22HIbw8xG1A6HYh1hx0zuTLR4ejFeZIyTT/UZCh+b
 oTJmtxjLbM9sSj540xIYQC9SezHoHW20yA9nu1JddZqtuz7mB/v9Y3S+yWA6JpdNb5VQ
 0IfT7Q8Gd89kwle3Ituqc0BjoNEGzq7tzpdxVqD/6srLjDiDbiL7IE2+oLZbPF4QIxOQ
 4XmFTXFNf1OHKAUd4bMLCOfjU5XjvrEXBIlkj08dRJVobwajf6Q6nXkOfWFepSuIZKMR
 pFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779817429; x=1780422229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yam7g54VFV6lsYYtH6QBmklGyM1qni/UW82Fi1yWJQ=;
 b=Ip/sxxa6AleFQK53Z0rbO6ZETB16aHrS9NF5xrRGfa1SxCpWbiEm494j7OUfKzuibz
 hrnWznfIViEXuxD6xEdXft0vqPZUAvFi2TPW3WWY0icxbeZkmycIemb6zaH3v2rL8Gsz
 Q6e6r/54hOmI+54xfE0jpn/sbT8XsV3WQE/apwIIaJHaupNRtwwKuN/WDSz2/orYcdxp
 AOIZQqoT+DFQo8th/WkNck21VkyAdWXgWk3QBQpKUSc5O0gAdvT2fW0CrBmc5Vforini
 nQp4Z9uEEukrxnsSVhWcqibL3dP9zwU+QDLWDnnoqUGrRIsoZoGeU+CZioHhMX1hBTPM
 OLDQ==
X-Gm-Message-State: AOJu0Yx8VtYCX5Rtn3AiLUOHc6XAZ5qJIGBytQtewSzoe2VdyFaqANsP
 qBXnnHeAXU8gsNQJ6yIwbRzU2UacYIFHIvBZfF+gPK5wA3yq4lzR+qKl2Auz0UhoO1Ms1TvinVn
 f7bhmcYTOvRvf7q1mHcXQEsRNUNEraZtVoUhcs2kTBA==
X-Gm-Gg: Acq92OGIiaj57LMITiuED74nRBbikFVmHRP+EH9aceAl08217NQphA2MtFUq+vZnxvj
 Yf6dLvn3aqugLbInEee6OGGhwp+N8ogV2tjIE3wsILBlguN9eLeN0JoOZyFtfK0WP7DEhtyL8Jo
 xL3+aq++CsPVvL4IIHhuvrB7waI0yMM75qF0I/92VrsD5dYwSmWMV8RPhLh8SKhOXesOag0Hv6O
 O0MnwHU4uw+b80ZqXQKXSHo28gzMIwLPmJaUaQyhyXu9haOUotRHS7w+d6PVetsRnF0z7Tc1S/e
 3Ne32mWn0vAUiVMmNPdaTongcF8KBU6zdokvlg4NA6AXF3SNTUHpCN39SK0zFjXo+rY=
X-Received: by 2002:a05:690e:169e:b0:65d:d299:2aa9 with SMTP id
 956f58d0204a3-65ec98a3f91mr18704893d50.30.1779817429278; Tue, 26 May 2026
 10:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260526164716.689664-1-mbawa@redhat.com>
In-Reply-To: <20260526164716.689664-1-mbawa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 18:43:37 +0100
X-Gm-Features: AVHnY4IVr63Jc-TFtbdoNSzciI6bRaNE8aYNk17LX7A7guPOSn497O9VQlNQB0I
Message-ID: <CAFEAcA-+VDZ+6Z2ZfRmcsYFa9jg-66q7T60Pcf9ZKBeMUfFG+Q@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis_sysbus: move PPI memory region setup to realizefn
To: Mohammadfaiz Bawa <mbawa@redhat.com>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Tue, 26 May 2026 at 17:49, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
>
> memory_region_init_ram_device_ptr() requires the target page
> size to be finalized, which has not happened during
> instance_init. Calling it from tpm_tis_sysbus_initfn() causes
> an assertion failure when the device is introspected without
> being realized, for example:
>
>   $ qemu-system-aarch64 -device tpm-tis-device,help
>   qemu-system-aarch64: ../system/physmem.c:2524:
>   qemu_ram_alloc_internal:
>   Assertion 'target_page.decided' failed.
>   Aborted (core dumped)
>
> Property introspection only calls instance_init, never
> realizefn, so moving the memory region setup to realizefn
> avoids the crash while keeping the device fully functional
> when actually used in a VM.
>
> Move the PPI buffer allocation, memory_region_init_ram_device_ptr()
> and the corresponding sysbus_init_mmio() from
> tpm_tis_sysbus_initfn() to tpm_tis_sysbus_realizefn(), placing
> them just before the existing vmstate_register_ram() call.
>
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
>  hw/tpm/tpm_tis_sysbus.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 6bec30c36f..33fe9e332c 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -100,7 +100,6 @@ static void tpm_tis_sysbus_initfn(Object *obj)
>  {
>      TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
>      TPMState *s = &sbdev->state;
> -    size_t host_page_size = qemu_real_host_page_size();

This is asking about the host page size, so why does it wind up
asserting about the target page size not being fixed ?

thanks
-- PMM

