Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0691CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 10:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGEfy-0004Q6-QW; Tue, 04 Nov 2025 05:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGEfx-0004Pl-0g
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:54:09 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGEfv-00063I-GT
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:54:08 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7866aca9e25so21949717b3.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 02:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762253646; x=1762858446; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IzZ7SuZ7t7bfsmmCugQ23TNFJAFSK4U00LSWWPJjhjc=;
 b=nNsnIqWeMrnqcLaDayZH97oeI298excwzmU/UWBH65HAtsYgdO8w4ZNfyNI3a7vSje
 ltw4yQO4ZRp9Ru4xOx7Q/949jNHkg9zPxVXQC+GJRWkh5Xe3alhPhyeu8IT/DfrstBKz
 YHpxwZOTX381AqXp9hCeQtD3leyIV3vil97OIZGUk0udi1/nukI3ualjOFv0M4xARVyn
 K/FjcOWsjatY2esIOOd9PytmEUEb0/7OW8dFe4DpkFR8c+W1yXhNsuM+9f8DtrNUMvxi
 G7O9eSSduC5Qzw/8CKaWJp/NHIgWD8Pbib4CClzUpblNJo+gw/HY8DEAZ2L2liwtYWAJ
 uCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762253646; x=1762858446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IzZ7SuZ7t7bfsmmCugQ23TNFJAFSK4U00LSWWPJjhjc=;
 b=L03+1+YB9CynI9SpDJ7S7/HQVFHCVV+ymATR5CDmlKWi+ohg+wJUVJd/TFMB28TNKk
 XHLTWFuNjJPRVnC8qWgyydEam3wx9KSks9gXWfkNRlHwaEygILKP482OiBtcjWjETaQr
 5PD5daBlPLer+PArMwdYILeBQGFoG9mErvbpNMx5JwX2uo/dc+wOCUCku8+4YFOU7Nch
 kdnIeDw8okAh39QnQnYsLvrmOmAXf5DFRMHTHNtZHHx9EQahOTM0cBfGnyBNnPfVexs2
 pYxpGOH43BEGcs20Ji8qFi/HafFp7T7kW8YQNFKGS4N+43m0NIeDraRQRdNYdMu5PkTA
 /RnA==
X-Gm-Message-State: AOJu0YwrUGoFAP8NeS2P/JUdxZBIXNPRODheP5IXkd56vYoUJ9lAjTCW
 o+HqzUmM/TVQnE9p2J0AXn7tRmGBmTCAOKymuKRBC7LE03n+LDNq47blm/QECk3691LE5xjKSF2
 fl5GmbX52nitJ+/KgVmS5IodZ3jFqQiQ/xZ9di3lhGw==
X-Gm-Gg: ASbGncv6je+SDGGdKwkxGgL1beAm9Hy6wQGKeZ2kpZwQPmYbsm52cugVXKouKjxTzR6
 Trx5p25OFSWVx23wZnXcxZavo9LGuYU+iUBevBtq7/BbBwGou523FnA/d7xBrtGEJMAIG0Mp1mm
 hrh6P3Bj7zIwwskMHbuo46J/OXekde/8S9P1uJGBpe2j/xiqCQ8YqiXfuTTI445371dUDdyzyli
 tBydLlZSZNG5oQ0ZVbO/v65aSOjW2kskFimKK+OoR+KrOlyMdgRgOEPqrawMw==
X-Google-Smtp-Source: AGHT+IFoKbTjaPhyVKrWQFRm76sqAsS1X6Y4FZ6s6KnCnDZDLKa92ECOOOtD5Lhdy1D9qR38Q28HI6e40DDz8XMDG30=
X-Received: by 2002:a53:d058:0:20b0:63f:ba88:e8f7 with SMTP id
 956f58d0204a3-63fba88efb9mr3999881d50.27.1762253646006; Tue, 04 Nov 2025
 02:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20250129160059.6987-1-farosas@suse.de>
 <20250129160059.6987-8-farosas@suse.de>
In-Reply-To: <20250129160059.6987-8-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Nov 2025 10:53:54 +0000
X-Gm-Features: AWmQ_bkRtRoiabEpvVBWJtsdoKbL2mfDZ9PT7_hnIJ4mbGovYab5w9CPuL2kLhU
Message-ID: <CAFEAcA8_zO0MmyN2nQDZsmiWssoiSUvKRMVYfRLrz6TsNejQFA@mail.gmail.com>
Subject: Re: [PULL 07/42] machine: aux-ram-share option
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 29 Jan 2025 at 16:03, Fabiano Rosas <farosas@suse.de> wrote:
>
> From: Steve Sistare <steven.sistare@oracle.com>
>
> Allocate auxilliary guest RAM as an anonymous file that is shareable
> with an external process.  This option applies to memory allocated as
> a side effect of creating various devices. It does not apply to
> memory-backend-objects, whether explicitly specified on the command
> line, or implicitly created by the -m command line option.
>
> This option is intended to support new migration modes, in which the
> memory region can be transferred in place to a new QEMU process, by sending
> the memfd file descriptor to the process.  Memory contents are preserved,
> and if the mode also transfers device descriptors, then pages that are
> locked in memory for DMA remain locked.  This behavior is a pre-requisite
> for supporting vfio, vdpa, and iommufd devices with the new modes.

Hi; I've just noticed that in this patch:


> @@ -1162,6 +1178,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
>      object_class_property_set_description(oc, "mem-merge",
>          "Enable/disable memory merge support");
>
> +#ifdef CONFIG_POSIX
> +    object_class_property_add_bool(oc, "aux-ram-share",
> +                                   machine_get_aux_ram_share,
> +                                   machine_set_aux_ram_share);
> +#endif

we added a new class property to the machine, but we don't
call object_class_property_set_description() to give it any
help text (compare how we handle the other properties in this
function).

> +
>      object_class_property_add_bool(oc, "usb",
>          machine_get_usb, machine_set_usb);
>      object_class_property_set_description(oc, "usb",

This means that if you run "qemu-system-x86_64 -M q35,help"
you'll see that this option is missing help text:

pc-q35-10.2-machine options:
  acpi=<OnOffAuto>       - Enable ACPI
  append=<string>        - Linux kernel command line
  aux-ram-share=<bool>
  boot=<BootConfiguration> - Boot configuration
  bus-lock-ratelimit=<uint64_t> - Set the ratelimit for the bus locks
acquired in VMs
  confidential-guest-support=<link<confidential-guest-support>> - Set
confidential guest scheme to support
  default-bus-bypass-iommu=<bool>
[etc]

Would somebody like to write a patch to add the missing
description ?

thanks
-- PMM

