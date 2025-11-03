Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A13CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 09:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFr5e-0000kp-Fu; Mon, 03 Nov 2025 04:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vFr5V-0000kT-Ne
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 04:42:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vFr5M-0005h4-1n
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 04:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762162957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+QRBMRrNrUFmbBMt1SSPqBZIeipH55Ra1Y/Mnq8brPQ=;
 b=aYgRFlrW/TdfJUkwv19pg4F4zZpb+pZ0Gy6cUhkRnTG+2oXDl9lpZM+qNK+S5OmhEVhndF
 mkVb8Nt6UjkDz48scQQMyiyYgpk6H+c+CPkZv/XlezxXtw7H4p75RWHLvY1XWE6ZMcKeSv
 a274YdtEt5aol6V/LY5T4hAtR9OUejc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-28h2Ga86OCee54_qmEbbNw-1; Mon, 03 Nov 2025 04:42:36 -0500
X-MC-Unique: 28h2Ga86OCee54_qmEbbNw-1
X-Mimecast-MFC-AGG-ID: 28h2Ga86OCee54_qmEbbNw_1762162955
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429c95fdba8so994093f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 01:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762162954; x=1762767754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QRBMRrNrUFmbBMt1SSPqBZIeipH55Ra1Y/Mnq8brPQ=;
 b=rpahMP8ZS3gbpewND3gopjMZsQiPFikWf6B2Vx0EnEvzV7VRRaKHyjQlUdxTNkeMTk
 lEq+hc3KxrJK1Jt7f3Kx+dYX7mBfM19Dj9TYgwv3owYBIkukQY1yP5xWVUDf4O5p7yg7
 GlzfJ1dq4ZH7k22a6gpWIzhTrLIxSkLdxuDHC3M7IOSzeVClxCF441JOxbOgB32kcTdY
 Sgt+/FoS601Qg/QKDjf05uBgPaoeN4qZFrRhImzT18A8mZXcaii2i6h78GKi5KFKpdCa
 S2IGLYZYuvpBSviXiEuVf+ZCQaO78ZhpWlKbK7Gm1qoNOvWrgqvS7rki8NBmuBx6/zn8
 4Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762162954; x=1762767754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+QRBMRrNrUFmbBMt1SSPqBZIeipH55Ra1Y/Mnq8brPQ=;
 b=DAG4cj2xuIZdDZgYWVJNKF1ikh6rCQ2O/64GxUZtWV7l7NCbpni5q91SfRZhv5pWDX
 fztIc94X8NUCd2l7DQdc1NfdKTi3ghW88pjIEhhJ5Ink+vO2NoO7UE0iY/kUdJEK2xC/
 ult7F8Horp/PVK9BZpDty/00vLtn7g8kssQZEG4tpuOFP8W0Ivh5bT40OS1DJduXAajN
 FdjGxqG6bjGeMPs2gE0J9uxybcOrorugeFFXHB05WyReT18wvR6tXlAYo3QdlNO8FvxD
 TCKYXoN2mUYHhHUII0IsouT/cMrcpk/8NhvbuCBo/DWFPm7d3i02bwrMVOHuYmjuIx+6
 A4nA==
X-Gm-Message-State: AOJu0YyQlTfY3V9O6rAWa5ZdP/ldv9v4vIYvgAkjV0tyd5ihJbSR/vVH
 6adiRTiLxw0+NOcYnVzshQBBbOwYd2ivq2cbcNuMQ4aciMHjJ68Mnw0cDCLikKA7iISmCcnhw37
 1nkJiW+wFC0vsDn7j836H1jsPLlR+Hcksiug9E+F171nQVD8+7aFc9WYSnNxWzCIQ
X-Gm-Gg: ASbGncvG64JrB1oaEkLsUmIegXAhkGf3gsKmJHw6ufheHGPwypa6iaxEQ+7lIC5e546
 VXonZsotTCnTiryeDfB8nCY7ia8J997hhikz8QPVIQMZi5Fh+kBkuwL70a/BKfPWXK85SWo1ffr
 ATadAyTuJtnc+68KfLlh/hJLrd30VGKV1pPSZ7Cs+OAwPwhkiEUEnTdq1WktkNftnhLd/NthEiD
 rg/NwN2la9MbMx8pMRAdnj1ipSQRB+V3usfYRJdr6/SZ/ObDNFD1uG8VTFr143JAMvxSc7cSQr7
 2EGpI8CnZ0W5odgqfTiCS1OYtyqXlwV7NWrkthmCtpZHrWQKnikUfweKs7bO4fEzMw==
X-Received: by 2002:a05:6000:2910:b0:405:ed47:b22b with SMTP id
 ffacd0b85a97d-429bd672210mr9171325f8f.10.1762162954618; 
 Mon, 03 Nov 2025 01:42:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpuKT4RfrHCBWWjdxzpuWWon9jmzWA8QrreuyyQ1hJZygqpqUNiwivqlx/6WIvErtBUZ2drw==
X-Received: by 2002:a05:6000:2910:b0:405:ed47:b22b with SMTP id
 ffacd0b85a97d-429bd672210mr9171301f8f.10.1762162954155; 
 Mon, 03 Nov 2025 01:42:34 -0800 (PST)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13f2b5asm19288156f8f.40.2025.11.03.01.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 01:42:33 -0800 (PST)
Date: Mon, 3 Nov 2025 10:42:31 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v5] hw/i386/pc: Remove
 PCMachineClass::legacy_cpu_hotplug field
Message-ID: <20251103104231.05121741@fedora>
In-Reply-To: <4b92d159-1bcd-5672-977f-6741a9d26c8f@eik.bme.hu>
References: <20250508133550.81391-3-philmd@linaro.org>
 <20251031142825.179239-1-imammedo@redhat.com>
 <4b92d159-1bcd-5672-977f-6741a9d26c8f@eik.bme.hu>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 1 Nov 2025 00:27:36 +0100 (CET)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

[...]
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index dfb8523c8b..7191854857 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1 +1,43 @@  
> 
> Does this belong here?
thanks for spotting it, it should be a separate preceding patch,

and then expected blobs update patch after this patch,
that would cleanup bios-tables-test-allowed-diff.h along with new blobs.
/i.e. as per process described in bios-tables-test.c /

> 
> > /* List of comma-separated changed AML files to ignore */
> > +"tests/data/acpi/x86/pc/DSDT",
> > +"tests/data/acpi/x86/q35/DSDT",
> > +"tests/data/acpi/x86/pc/DSDT.bridge",
> > +"tests/data/acpi/x86/pc/DSDT.ipmikcs",
> > +"tests/data/acpi/x86/pc/DSDT.cphp",
> > +"tests/data/acpi/x86/pc/DSDT.numamem",
> > +"tests/data/acpi/x86/pc/DSDT.nohpet",
> > +"tests/data/acpi/x86/pc/DSDT.memhp",
> > +"tests/data/acpi/x86/pc/DSDT.dimmpxm",
> > +"tests/data/acpi/x86/pc/DSDT.acpihmat",
> > +"tests/data/acpi/x86/pc/DSDT.acpierst",
> > +"tests/data/acpi/x86/pc/DSDT.roothp",
> > +"tests/data/acpi/x86/pc/DSDT.hpbridge",
> > +"tests/data/acpi/x86/pc/DSDT.hpbrroot",
> > +"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
> > +"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
> > +"tests/data/acpi/x86/q35/DSDT.bridge",
> > +"tests/data/acpi/x86/q35/DSDT.noacpihp",
> > +"tests/data/acpi/x86/q35/DSDT.multi-bridge",
> > +"tests/data/acpi/x86/q35/DSDT.ipmibt",
> > +"tests/data/acpi/x86/q35/DSDT.cphp",
> > +"tests/data/acpi/x86/q35/DSDT.numamem",
> > +"tests/data/acpi/x86/q35/DSDT.nohpet",
> > +"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
> > +"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
> > +"tests/data/acpi/x86/q35/DSDT.memhp",
> > +"tests/data/acpi/x86/q35/DSDT.dimmpxm",
> > +"tests/data/acpi/x86/q35/DSDT.acpihmat",
> > +"tests/data/acpi/x86/q35/DSDT.mmio64",
> > +"tests/data/acpi/x86/q35/DSDT.acpierst",
> > +"tests/data/acpi/x86/q35/DSDT.applesmc",
> > +"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
> > +"tests/data/acpi/x86/q35/DSDT.ivrs",
> > +"tests/data/acpi/x86/q35/DSDT.type4-count",
> > +"tests/data/acpi/x86/q35/DSDT.core-count",
> > +"tests/data/acpi/x86/q35/DSDT.core-count2",
> > +"tests/data/acpi/x86/q35/DSDT.thread-count",
> > +"tests/data/acpi/x86/q35/DSDT.thread-count2",
> > +"tests/data/acpi/x86/q35/DSDT.viot",
> > +"tests/data/acpi/x86/q35/DSDT.cxl",
> > +"tests/data/acpi/x86/q35/DSDT.ipmismbus",
> > +"tests/data/acpi/x86/q35/DSDT.xapic",  
> 
> Regards,
> BALATON Zoltan


