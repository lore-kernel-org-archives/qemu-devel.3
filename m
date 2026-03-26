Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E9810A1E68
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5iqh-0004fj-4w; Thu, 26 Mar 2026 07:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5iqf-0004et-Bq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:26:01 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5iqc-00030q-OG
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:26:01 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so947438d50.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 04:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774524357; cv=none;
 d=google.com; s=arc-20240605;
 b=NfKQsRML0kbXysKi1Nmi/GQmlXmcmgnZ1noKTmv0eai0TZIX1jqCxLNEOxS+qyrerZ
 4jlg+bQZ/35YQT4FHHx/R8zW8nyVKn0V1td/pqbiLbYvwRZoIJ8onIMk4I2igoDMuWve
 Xuovx6yq6XRVeGHx6vYlULlNJPSOUPAFo+DtfLq9MfW7YN+p9X3cs/QfWhHqWQd56ecS
 RHVhvd+kSA/5NuJzw5ZtkQfPMZRoppL/UHRGaZKI5mB4iZvL1JRPVRQlZry+9Ng0LyLq
 cQ2RP/JzjaQAsUdnVxBlvMqCec9fZshgnI6qCmxdqNcJeVniuL2dkMP/es0g0Bxb/8kG
 en2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K8H1CL0upw+6AEBN8OABjOhr2OIodMFHFRvrQgjLZPo=;
 fh=w4/Pf5nSLMv8sd9OsiAIH2Qcy6NnrDybe8Vo6nCIxOk=;
 b=TTwproIJq3WL01dHUjxFCvdNk4O0V8Ps8bTGwnahGMFKlHq6Uhtqk61p9ZlI9pqiw5
 +awr/5+QKoffRzDa+7ubqH6EHtfX204eTlTLb9mUUhLLUQhygd/rhlRodu/5B6ZHKBDI
 3xgfV+iEpSPlhplmnw077F5eTAJmKAUfpfAlnsk5x3BkhLZ2mw/f9fMVKUOjibPttcqg
 v6vEyyES0/Io4eNS4WlMJ6GstxQ3lslC2bWhvGXGCfETFFAcRUBWFKWc0Mh4dZ5fS6FT
 IMlpKW8JiO+JrkuF/hqQheVry5U1VajNn3z22vYcrfZ0z8gTQ3PXILMxNR6YGBE9nAll
 JWDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774524357; x=1775129157; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K8H1CL0upw+6AEBN8OABjOhr2OIodMFHFRvrQgjLZPo=;
 b=HvI1toCdWtzaM6LAFS7BbDaAr3fevYE/jxZuW+ve0zrEJo0aE/1FD9F+E+OpkMBDnT
 mFvVAfRZYgz7X4fNhNXY0lUdydmPoTxZ+GUdKOX4Jwhan7fIJjqGjg0RnSb6vTYK4ySH
 kxl6LqJ265cNtU+DSOF+Q8Ngo7sPReF+HIgfD6arXUYcxwfj78VkWawTi4YkJcDM8BMn
 SaIenHvpDt8ciZeGZQuS/+V78FeaN4Y2NJ3XMUBLhtqK8DZQMdg0dek7aiN45pKQh4ag
 QVzY8P2/cDznk/u75wWd2Nc1ECFFgCOTGrflYeTwJ8x7ohy4rjBs3mctxzUHYc+TLv1S
 dWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524357; x=1775129157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8H1CL0upw+6AEBN8OABjOhr2OIodMFHFRvrQgjLZPo=;
 b=o61lTi7kXeqNiT9kBtI6ZOtUNA9rS/HVpfbJWdfgDvZAVo9AWIXKGwKlHmr408sjac
 DFsNMfdP204pMU5KS1CN5wCRxSkt0y5J74681tf+Bihf/7X/tWwDk85soZL7KqELVOij
 VHMLJ+eGM03eMG17ZtZegrM3e6lW1RwrzAdmQ0kV3tgSeILtSzkJaj4xXU8LKIjMo1iP
 PSCHwDHOTQQIlhLlSbI1ZucXwURbPrdBcaUMlDRroBWNeXTbbVE1J3hbRESHTEG7FAPS
 iWXdxIVoHGRfvrJQbMF16rgqNTlRZIdg0F4vwid9UUOE1gxQql5efDvo4Od/9Blm0XvB
 scyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPK/CLI1iEJNiGnFJt9mU46bgW9c25HnmsNYnnD6wypo0YBkFG/M1CecDAlQBdnwK8C2dxw4EC+iP8@nongnu.org
X-Gm-Message-State: AOJu0YyEnFsp3ymdwNbZQB2o90dSNhqbZQXEG77j39YyhiPwWPIuT5+f
 E31QI8SuZ/eBTo5OCoApyv/A7fF085vnuNIwab1f5IZsnOrvh6WLmdZraD0VsKj54LtQtiXLzEW
 wJO8a/Mlo1Zl3E2sXH8rJ+iCr8EiP2gQTBMcNXEZTFA==
X-Gm-Gg: ATEYQzwDgVfH9AqBWfs0Xqxfn2fMXg7m0+9i7khAAJKcd7BoAWlfp6Hr2XJCBBI4uAu
 C6TKQJx6cO6V6QmNhoGekMKdTOQbTrXIIawaYZOd7k1AyU3rrBtceapMweK8f5Hci6sHmvXdski
 c8h5DjY1roHltbxffFDafD8GhhOzO/pOJJj5xpOjar7TlmbcdM6v6TW9N57fZmd3J5kYwlwpXkf
 NqNQHqUFdpiWu2fmoOe14wHCPCFGRrALGAJ4B2XE3BtZj9WLODaeZPqbBgtJgOHahH8DlYfq0Mf
 yV4tdRz/fwLnzySHFaDEQ/IHJM0G6C5vl8tiCEvHP9HFNa44K+EMwqQTY7aeeuJY00Y=
X-Received: by 2002:a05:690e:d0c:b0:649:6139:b80c with SMTP id
 956f58d0204a3-64ee611fcefmr6643060d50.45.1774524356906; Thu, 26 Mar 2026
 04:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260324135026.247418-1-shivangu@linux.ibm.com>
 <acUTurZoQJf8jRhJ@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
In-Reply-To: <acUTurZoQJf8jRhJ@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 11:25:45 +0000
X-Gm-Features: AQROBzD9n4P5zKS_61mIwlXUC8qXp1u_EaoCSiiWqgKoiCyjiNM7T__w1_qSOSk
Message-ID: <CAFEAcA-f+XQPgQ+udz9ts-V51E+jqBHwKpPsh=oArfs1d19wfg@mail.gmail.com>
Subject: Re: [PATCH] ppc/pnv: generate dtb after machine initialization is
 complete
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, npiggin@gmail.com, milesg@linux.ibm.com, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-stable@nongnu.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 26 Mar 2026 at 11:16, Aditya Gupta <adityag@linux.ibm.com> wrote:
> But still the dts we have is different from what we should have at
> pnv_reset. Adding a pnv_dt_create at the end of pnv_reset, as it used to
> be before, gives me a 'bmc' node also in device tree.
>
>         $ diff /tmp/dts.machinedone /tmp/dts.pnvreset
>         16a17,33
>         >       bmc {
>         >
>         >               sensors {
>         >                       #size-cells = <0x00>;
>         >                       #address-cells = <0x01>;
>         >
>         >                       sensor@0 {
>         >                               ipmi-sensor-type = <0x23>;
>         >                               ipmi-entity-instance = <0x01>;
>         >                               ipmi-entity-id = <0x23>;
>         >                               ipmi-sensor-reading-type = <0x6f>;
>         >                               compatible = "ibm,ipmi-sensor";
>         >                               reg = <0x00>;
>         >                       };
>         >               };
>         >       };
>         >
>
> This isn't handled at machine_init_done as 'pnv->bmc' is not set at this
> time
>
> Two ways to fix it:
> 1. Have pnv_dt_create in pnv_reset as well, like previously
> 2. Move the pnv_bmc_find code in pnv_reset to pnv_init
>
> What do you say ?

My feeling would be that the pnv_bmc_find() handling
should move to the machine-init-done notifier. (pnv_init()
would be too early -- the pnv_bmc_find() code is looking
for a device that has been added via the -device command
line option, so it won't be there yet in pnv_init().)

-- PMM

