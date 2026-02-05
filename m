Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6112CEC1E86
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 10:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnwMR-0000sw-J9; Thu, 05 Feb 2026 05:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnwMJ-0000rc-PD
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnwMH-0006cJ-TN
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770286388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMX3XJ8cyHbJ7lmfnDUiplGZd/RUEGZQjFEvJ21+2h4=;
 b=B33AgefAsDq/vHW7pfsxiwiplHMZgPRkrhpd2UPYE65TxGcFYHuZU08hKfJ7SJF5Gj+AMj
 SbCgF2Lh2zv9PjLjPHNFJBkIVC5z2BxRU7RyBpOv0H7AkP05iG/CKJ3TfDB2F7C/ehrwxn
 u8NOAl9tMd4qDs2Z5Z54kIfZtF+FnkQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-YmDiVkE0MZKxUzt37UH4xw-1; Thu, 05 Feb 2026 05:13:07 -0500
X-MC-Unique: YmDiVkE0MZKxUzt37UH4xw-1
X-Mimecast-MFC-AGG-ID: YmDiVkE0MZKxUzt37UH4xw_1770286386
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47edf8ba319so10117885e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 02:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770286386; x=1770891186; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WMX3XJ8cyHbJ7lmfnDUiplGZd/RUEGZQjFEvJ21+2h4=;
 b=T8m3PB9W1dfUbvMULGgfFlsr7lgdrLNEmBK2uYdlTf9QkoDDOdmPz3dWBlOvFnjSk5
 rIOcJPWa+jJRHztSAEHbZ77SsQ474PtOZ92PzYXMZ5ehP22Ss0OHNzNJwCNSKEbG6TU3
 QNWk+R9MNOa9n8CfL36+gyWGhHB/KCV8vVwC8StR7fx0lI5fsv7ueIztW/Hhw4YdkmoT
 kkzGG0QJoGxkA2tAGhklMdf2fbDgIIOmg+lqadiKnwgGegI3dPwxoWt7+1cjQx/X9XGE
 pRZ+e4/MGOvx0m9m5nEQj0i1S3vfEcUZHswYuNIiELtG0hdbs+ba5PeVIrUnpBj2B8/f
 xUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770286386; x=1770891186;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WMX3XJ8cyHbJ7lmfnDUiplGZd/RUEGZQjFEvJ21+2h4=;
 b=sL7V8p46uIsFvnrWRtCdBErpyELW0+Jwcgr3E2VQAdGFcWB0fTXpoesyk8ylU4Dny3
 gnqyNcbbntbW5IrqbIYAi+jPnIQY7MPptzQROGXO63lZ+n6xdOVXUP89lAOblQPnUeH/
 z/wzQELalfJKQ2hSrXNOx9wOGX1cAQ30ajV3rrzIgJ3VEHZFAHaSNdsdSUV9UQPa+E3b
 D/AXjsbr6XnB4zENhl/8cfomKenteS4oLvw1GrBGaIiVRzvUv3Yu0TDZ0w7ApBD9tWai
 eqmWXOy/DVHiNIi5pNAJihmDDLo0K/KBt2RDX6K0SUnPkg87N7eDD6N3fTG95Bp2hV0e
 8nfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJt2Es25VWckt4zWk+mKIHvb+H98pZzk1mohKcmlYzFRJ+DWvfH9xUwya09Dc07OQQH12FekYxLrpN@nongnu.org
X-Gm-Message-State: AOJu0YyD66kfjw1FlsZkMq7MiFDVcYolij3jotfmA5Fl8ioCmgF4wDIl
 70CuzeYyaKGIZeIG5hT4UB3Lgx5/bDch7mh60iRKalywEszCQ1VvXo5i45fa60ugLpQJHPPIGJf
 82ECLmlCTaHW5TQfAOUWV9dWRhuOzll5g5AlH3tJVlMaGIN9YJV33OtUX
X-Gm-Gg: AZuq6aJd6ehVzZzfR3NKud51iMrIEPDv+Hs8sNqxEPQLZ3zECLC5EN4MuAIjM5Hv7cK
 AuMCenPXC2PdaUXtbfG7XQY9ZfYPH8L5hg9U5eiazWYfnRJxsZ3ZKI1gbwV95PJkdesGiKXhRin
 zchAFrRVvFKIleM3YjInIXmj6vaUysQCJlu5qfnr72u9TkbMiQ+bIz985l6ZzDTxSzKVZSf4CPp
 Zlq6YOiT4rxtPD2wSy4zbUmlRLUYKhgLbbft9l608hw6eJuD30vddK9fvY3IDvpP/yUrPJKkhmC
 3AisjRh5qZfHJWrP/u6BoyI1O6NuEyzVYwM05XA+3qhnv+iQvWMh5F+VbDSP544k5ueb3Sq8uyz
 QbRLblgs9d0DFLFIvekUknOFv8a9J02STug==
X-Received: by 2002:a05:600c:3145:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-4830e97af61mr71822265e9.36.1770286385607; 
 Thu, 05 Feb 2026 02:13:05 -0800 (PST)
X-Received: by 2002:a05:600c:3145:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-4830e97af61mr71821845e9.36.1770286385088; 
 Thu, 05 Feb 2026 02:13:05 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830fe53c23sm62352395e9.3.2026.02.05.02.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 02:13:03 -0800 (PST)
Date: Thu, 5 Feb 2026 05:13:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Li Chen <me@linux.beauty>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v6] acpi/virt: suppress UART device & SPCR when guest has
 no serial hardware
Message-ID: <20260205051236-mutt-send-email-mst@kernel.org>
References: <20251211102025.873506-1-me@linux.beauty>
 <CAFEAcA8FcW22-TnyBKHmFUUsR=xk2u-74uPz6KisJTeG=YWxmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8FcW22-TnyBKHmFUUsR=xk2u-74uPz6KisJTeG=YWxmQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 05, 2026 at 10:08:32AM +0000, Peter Maydell wrote:
> On Thu, 11 Dec 2025 at 10:21, Li Chen <me@linux.beauty> wrote:
> >
> > From: Li Chen <chenl311@chinatelecom.cn>
> >
> > virt machines always instantiate a PL011/16550 UART at slot 0 and describe
> > it in ACPI (DSDT and optional SPCR table). When the command line disables
> > the serial backend (e.g. "-serial none"), the guest still sees the UART as
> > a preferred console even though it is not usable.
> >
> > Teach the virt ACPI code to omit the UART device and SPCR when there is no
> > serial backend attached. This matches the hardware that the guest can
> > actually use and avoids confusing firmware or OS code that relies on SPCR.
> >
> > The bios-tables-test qtests rely on an ACPI UART node and SPCR entry for
> > UEFI-based virt machines. To keep those tests working we create a UART
> > with a "null" chardev backend instead. This preserves the ACPI tables
> > while discarding the firmware's serial output so it does not corrupt the
> > TAP stdout stream.
> >
> > Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> 
> Sorry, I must have missed this patch previously. I'm not sure that
> this is a good idea, because it means:
>  * the dtb version of virt and the ACPI handling diverge
>  * we tangle up "what chardev do you want to connect serial output to"
>    and "what UARTs does the guest see"
> 
> If the user explicitly sends the first serial port output
> to nowhere with "-serial none -serial stdio" they presumably
> had a reason for that and won't be happy to find that we've
> adjusted the ACPI tables to redirect that output to the
> second serial port they were planning to use for something else.
> 
> thanks
> -- PMM

presumably, things would be different with -nodefaults?


