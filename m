Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A38D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 09:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ0G8-0006jI-BR; Mon, 01 Dec 2025 04:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ0Fo-0006bt-Ds
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:31:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ0Fm-0006ie-53
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764581488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2LKeAYfETFbC7/6TgYjVAonRRiDR9BymVeVFN92O/pA=;
 b=DYoRymdpGX1/sREH3gT/XgbpS+BSQlRP90Th4GNuvbnoEkFdcK8SpQ0JNFCCQ0skY7J8Nw
 ijl7KA93peUtuhwgmZIvkqp7ltGEhDfi2m62wLSEUZlUBGI9CXs7yHRc1WH/hjK4h/YBjT
 BAcl1n3j6LJ1t911EHYhEi65hknIIDM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-kxCCmi1LMSOONMglY6DNKQ-1; Mon, 01 Dec 2025 04:31:27 -0500
X-MC-Unique: kxCCmi1LMSOONMglY6DNKQ-1
X-Mimecast-MFC-AGG-ID: kxCCmi1LMSOONMglY6DNKQ_1764581486
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so33918835e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 01:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764581486; x=1765186286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LKeAYfETFbC7/6TgYjVAonRRiDR9BymVeVFN92O/pA=;
 b=gtWxHceALALPzwn9Z2qPRlsEGBYpC5/KA/sFtja5NROEK7Ktddp2Jpb5yHFikpukcI
 gs6EsYpHh0VLBQ5rtLSPmqeUMYkvkmaWaodoPH4mq19JLumHF2upf5nGjLyn8jzPvBaQ
 Rh78RkZDeAuQBoevFVaPggBBYCQcpDde2BPWqNERbBG5CmwM2r5jvltvhwF4UxSKPsGU
 iZlGYM9PlvKjZs4vvE2pWJ4GqmI39oCbijJQQ88dT/RwBWhx3YE8nYPp7FkA+6IzhyJa
 tvJDFoW65/16EfbgknH/ekFa6zLosjzJ3Xmni3+zr7SdgzFDOuDwbfSJr2RXqUMmhi68
 ttjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764581486; x=1765186286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2LKeAYfETFbC7/6TgYjVAonRRiDR9BymVeVFN92O/pA=;
 b=oaVCvrwjE3Ucnu4ld8lawA2oq9YvZqi6yMxhDRFPrXIJ8IGMh1+EN5/NVrdyBjVrcd
 Mjjqr8RXBC3mLUK+ra1IQJ0yWedhhgNlWkoJdzyJYm0RzwInAY6vRMmimYR68vEhiO2R
 /tMtJ3s2WCv8BGkRiqyjyCpgfLW7rd2VKchhagtTRnk7BGRh/VtN6lUW6Kq3t7FRs5Rk
 +lWNVTQGTLt3nEOqLuoGW5IeHMSoDGJFG4Z5/NTuQH9ZE4gXd8NmxKgxrkjaZMocCdi7
 Z4tUDGAii+RjGXHNA7PLxigusIBSSNolCax/HMnQRELHizTKbZQDgqAV3ymYQBmfj/kL
 wNDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJs8CgFkDo8qG2OlMcT2pra5Gt7R7yKqo9iB4+o3HAViQLRI39XFqRAgQmPFV0yEFw0cJXAa6eS5+3@nongnu.org
X-Gm-Message-State: AOJu0Yz+UvsgvaLYtQA/4o1lStwS9DsqG/L7VTZl9DlRJG2ZodHNTYfJ
 SP67VSZgiB5311m+LMO588znt4sVakuV/eX8vibg7SSVV7OQMJhCyWU63JkrSqs5kLK0LhDxTG0
 kCmQqLXkV26zLZCnajisr4girqtn3FIONebjWE/Yt8J527y8NEWnnhz3+
X-Gm-Gg: ASbGncuzXx3PKi/y9ZYLZzoEevFYqbljN9WMQQndCZJKXo4SWEASJrwQso2h5Bu6a3Y
 cf2JJXlip55S7wPVgHBE+saz5g5exb+I2Mfm4CbjSt20VfYX0CGzdJ0ALgvts5tQN8Z7gEMx+6B
 w7/jmXiN4dGtuqqv6/BwSr/3117NV1KaLNS9Pz+0YiKMbIXfmZ3PUUO4HOCI3l5gKWHhdGKysds
 oGoOea0/KnrjgXE3j9SIkSDSvkbIhjzBpv4Yd7eIFRcRWvG+XzZMi8Mi7bT7Vr4R88b1Yrai2Xe
 HfhAwWgXdW0LpoaDjpdZZyI/VdjnPInbbYU9AGsk9ktlA7+stke2G/Wob1D29Wk4NIrrOg==
X-Received: by 2002:a05:600c:68c7:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-4792095f3b5mr25845585e9.10.1764581485900; 
 Mon, 01 Dec 2025 01:31:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjzndHATg1+1FFpXTHP2mf1XB+umhMBDLRW85OSAkS9EzrFkW85Ln41dPdm5B09o3aDfeTiw==
X-Received: by 2002:a05:600c:68c7:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-4792095f3b5mr25845275e9.10.1764581485496; 
 Mon, 01 Dec 2025 01:31:25 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790add608bsm295686465e9.5.2025.12.01.01.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 01:31:25 -0800 (PST)
Date: Mon, 1 Dec 2025 10:31:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 0/5] acpi/ghes: Error object handling improvement
Message-ID: <20251201103123.6b934668@imammedo>
In-Reply-To: <53c3c2c4-b8e3-4ca1-a0dd-88148520ad82@redhat.com>
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251128150926.78bebacb@imammedo>
 <53c3c2c4-b8e3-4ca1-a0dd-88148520ad82@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 29 Nov 2025 11:21:55 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Igor,
> 
> On 11/29/25 12:09 AM, Igor Mammedov wrote:
> > On Thu, 27 Nov 2025 10:44:30 +1000
> > Gavin Shan <gshan@redhat.com> wrote:
> >   
> >> This series is curved from that for memory error handling improvement  
> >                   ^^^ confusing
> > based on above I'm not sure if it depends on [1] and shoul be applied on top
> > or it can be merged on its own
> >   
> 
> The current series is a standalone series and expected to be merged by its own.
> 
> For (v4) series of memory error improvement [1], Jonathan wants to extend
> the handlers in the guest kernel so that the granularity in CPER record
> will be used to isolate the corresponding memory address range. With this,
> the patches in the (v4) series to send 16x continuous errors become useless.
> However, those patches in (v4) series to improve the Error (object) hanlding
> are still useful. So I pulled those patches for the Error (object) hanlding
> improvement from (v4) series to form this series.

ok, then I'll review this series and skip v4 for now

> 
> >> [1] based on the received comments, to improve the error object handling
> >> in various aspects.
> >>
> >> [1] https://lists.nongnu.org/archive/html/qemu-arm/2025-11/msg00534.html
> >>  
> 
> Thanks,
> Gavin
> 
> >> Gavin Shan (5):
> >>    acpi/ghes: Automate data block cleanup in acpi_ghes_memory_errors()
> >>    acpi/ghes: Abort in acpi_ghes_memory_errors() if necessary
> >>    target/arm/kvm: Exit on error from acpi_ghes_memory_errors()
> >>    acpi/ghes: Bail early on error from get_ghes_source_offsets()
> >>    acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()
> >>
> >>   hw/acpi/ghes-stub.c    |  6 +++---
> >>   hw/acpi/ghes.c         | 45 ++++++++++++++++++------------------------
> >>   include/hw/acpi/ghes.h |  6 +++---
> >>   target/arm/kvm.c       | 10 +++-------
> >>   4 files changed, 28 insertions(+), 39 deletions(-)
> >>  
> >   
> 


