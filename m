Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CE0C44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkhl3-0000ae-Ab; Fri, 17 Jul 2026 08:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wkhl1-0000TZ-2J
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:33:35 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wkhkz-0000RR-2i
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:33:34 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c1740c36c5cso66534466b.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 05:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784291611; cv=none;
 d=google.com; s=arc-20260327;
 b=XgXthyQHwsYakogEVHkaHR6xIfe1X8cF0jjkFtruIoKy1rU1KwN9URzvW/iqIJSEsq
 hUJaFYxamFMRBJoEAkl2AeV8XSNBBQuZGDL70CCm7GnLrmeHomChq0yRn8sselvaUh+H
 /3J9I8cAkqlLVY3ZnC36UnU/64Fbz1rtD/e1V3cORJ38oa4KhhSZrY3UZ8OtJURGjdmR
 LYWs6QZ5HXFuJ0QE/iIkt22Wl7si5Rlg+2j+vQBZqDVwLb7vCMuJwgOGM5AmvjW+/DbI
 /91QzpuaJbCttLOPltec6Jm3VjFljnY4kC5NkhhOOBW4ng3eIoCfGzUr5p1L03xJaDw3
 /05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z73NkepKB+5jaatHXwyhzGHCY7KENMRNCS7V3bm/E5U=;
 fh=Y1bwhosuPm98M2ldNQhOCif96EY9zeOHnO0HzgDv5aQ=;
 b=IJZy24969IzzDTwT27iOktCj+6YixfGWDFWZPW6EcOhG2ao0rhWdDlpqIWqH02ncDu
 sAk4xOWhP/ub+2mffUSYOQnS1BGPwXSZ5YEH3ZZI6ji6sfBlMqHcdrHeL1VNILOFkgDh
 hZ9bJTxnkJ3+n9z/Anxz76nqJ0Qeu0WYKXAibQfmfAdAhPrymFCj6wF7vsh1UjIjwbxq
 sI8btfa/YtVHhBJDBOTTEEj8Ol+gVK7YKg0vCQJFTqpU6sb/7bKJ2WbPcvkPmTZ2rem+
 EwhyASc2rVnHgGMZHK+pFO1FzOIDWzaNDUZubLu2b0XUOPzJAhOvXyx7lHBtcrhXne0x
 ZS0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1784291611; x=1784896411; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z73NkepKB+5jaatHXwyhzGHCY7KENMRNCS7V3bm/E5U=;
 b=P/IcvA6VsRQeBcNei8LSV12M9Ui6YhUN3nfu04HIj0QREKGEj6KcdLKu6GLZPrIVU4
 6SMcd7XSrJp7SO6NAZKd7FmG4xu4FF3W15XmvgugPbtMw3aelw0WaqIa42/bZuDHGLP6
 bixlbmjAoeUrTnYkjW/13O+ImaEajN/eyqFeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784291611; x=1784896411;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z73NkepKB+5jaatHXwyhzGHCY7KENMRNCS7V3bm/E5U=;
 b=szJpRdxh3fDgi0ngWKfsK410GJXpfLuhYiIFOrml0ui9+TzJ0s1gxr7abD2gdbOra2
 tuYrE4Xt3iGONBkcBWxbU12l/XpKY4u1gfnN9msbAOZzbY9D4zvL0362sOSX949SDMQ5
 rQEjSkuvLQnsUUJNPjzXLQTakUV1cBIz9OwmPwDwtUNep/iuPGwMLslkR91k14vFkwvA
 zYgPP5bUxhYweyV3ago9U3broVzCcYIon8V3Cga19X/SRKCSlD8+g+4IJH8zKCsfsrAX
 NmrQBWOiExIoBfV8nsTFPbp4YtrYm2Dx2EvuIalF7fLPFXgftxdszTv7K7djjYReFmsE
 CL7Q==
X-Gm-Message-State: AOJu0YyNBvwlpanFu7wmxgoFBzzc66vDdw4n9UpPNONP1JCd0zy4FNTj
 M4Y3lLw07/deHbcGn7GzuBtd2L0HCSbCqYk7M+QZgzI1hADb51QGnDzXrhiZQropRpExqBkBC3h
 pCL52EGIphk9d6iSRZDItoNVlARD8v9xHx4hcRjaFmDeONp3LC20cWjE=
X-Gm-Gg: AfdE7cmJFc8wgBUB5SfRZO7GQWYwvRsb1uN1b2JTM0+vyReWYEoAuEOtt9NLSAmt675
 voWfuzsBvLRSKf0Rau7HNJ4nOvvcoCOHQRB7exVEzqJPEkYQELFIKZHeYrW9o7Uh/qLxO2SGsRU
 qLSgLma3JX21TNFpmYrCHbob/UEnLi2F4RhhThX/w5K1iSSG/6OdKtoz/jybtI5vJs/GM4G9oww
 pMo1GVJGANqB2K0EcIzxeT0cMRz7NZnTWl+7TKkW800OVvVOvwUehLaJnhj4rsIsmKlKWQp7xw9
 Ez1Hh77cSan3H/Obzw==
X-Received: by 2002:a17:906:ef08:b0:c16:7414:4c29 with SMTP id
 a640c23a62f3a-c16b473acc7mr128898766b.25.1784291610917; Fri, 17 Jul 2026
 05:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260615141216.162388-1-alexander@mihalicyn.com>
In-Reply-To: <20260615141216.162388-1-alexander@mihalicyn.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 17 Jul 2026 14:33:19 +0200
X-Gm-Features: AUfX_myD0UDNMJy5u1H4eP6iW9d2cZvqs0K76-kzY0iSonL0QJp_yfvvb1zON-U
Message-ID: <CAJqdLrrPAW0R2ndYyYa=k00WEnqSyLejsppYnxaFT2R7N1Mf2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hw/nvme: support online resize
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Jesper Devantier <foss@defmacro.it>, Keith Busch <kbusch@kernel.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x636.google.com
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

Gentle ping

Kind regards,
Alex

Am Mo., 15. Juni 2026 um 16:12 Uhr schrieb Alexander Mikhalitsyn
<alexander@mihalicyn.com>:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
> Dear friends,
>
> This patchset is aimed to support online resize for NVMe emulated
> device. My approach is simple - I just implement (BlockDevOps *)->resize_cb()
> callback and ensure that AER notification is fired to all controllers using
> a namespace that is being resized.
>
> Testing.
>
> I manually validated this with Debian 13 VM (a resized disk was a root disk) and
> Windows Server 2022 (a resized disk was a secondary one).
>
> Git tree:
> https://gitlab.com/mihalicyn/qemu/-/commits/nvme-resize
>
> Changelog for version 2:
> - checkpatch fixes
> - rebased
> - CI is green (https://gitlab.com/mihalicyn/qemu/-/pipelines/2602102750)
>
> Kind regards,
> Alex
>
> Alexander Mikhalitsyn (2):
>   hw/nvme: initialize ns->subsys for n->namespace
>   hw/nvme: support online resize
>
>  hw/nvme/ctrl.c | 10 ++++++++
>  hw/nvme/ns.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h |  2 ++
>  3 files changed, 79 insertions(+), 1 deletion(-)
>
> --
> 2.47.3
>

