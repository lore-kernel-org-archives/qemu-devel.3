Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A398ECD995
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo3Lq-0007LV-IH; Thu, 05 Feb 2026 12:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vo3Ln-0007Kr-Ib
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:41:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vo3Ll-0003xz-Kf
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770313261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGypKcpukOs7Bc/BtAYDdkywm8x5uQj6dqQs8EyKp4Y=;
 b=TE2capqERNAOs4dAfAb7iNFCZhyvyk/zmwCHcFTCiqc1CyvCJDSygh3ye+h7mdAmqhUF/d
 syMpW/JGz8CE/cU5sE4uF6L6HXs9iXBYlsB7qj8a1KwGZFFiDZEKtkHpk8gACaoJtLn0tq
 g2EIJBT0tnMy2LZuGxm3EJOqM+2ww9I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-2m8-tm0SMqig5E4nGOmbKA-1; Thu, 05 Feb 2026 12:41:00 -0500
X-MC-Unique: 2m8-tm0SMqig5E4nGOmbKA-1
X-Mimecast-MFC-AGG-ID: 2m8-tm0SMqig5E4nGOmbKA_1770313259
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso995260f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770313259; x=1770918059; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vGypKcpukOs7Bc/BtAYDdkywm8x5uQj6dqQs8EyKp4Y=;
 b=p0I6p/VPJMY1I9e144hvntsSERbK7s+hGH8Y3fwJMcC4trsFX7+leS/O3u4DBnujeB
 TGPfibJpJzP3qcTe86TVduqACs5C0hZ/nLrbBILJf/a1rWbFAKuBFevBrN8MvUHcbBBH
 j3CvmVRaBq9aHk6yekAJks/bimPoo9vnMs2WPCARJFoUMsPiNX8Q3dgqQGm3CPvskBaj
 5R3iU33LVVBelRfvdbJO2ukrxdlMjnWShRxu0VtxYucIunOSDYhM4lGx7t0B0EgvULzY
 Pao4yvbq+k9uZFMcDT91Q3G12Z3dDtgBhz5lIjxEqwDVBoY7ZCEvIr26aqKvQ5zsju4e
 vgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770313259; x=1770918059;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vGypKcpukOs7Bc/BtAYDdkywm8x5uQj6dqQs8EyKp4Y=;
 b=NOX7EFEgH0lbnR8YNDeTjD5MkgLgObi4hse3U2bQSID8q5laXktsagXlqX/KTLPWSF
 NYosDbIMK7oF4RZ74HmOBJu7KuMzDqn4m7or0jEA07AjhJg+MlLhKO6P3HXzK1RYmKdo
 Rl7PFzOaz7ta1PtsQXNu8VjH/MH/NegcnOW2ymRy9xayBfjkSb0tEJK6mLFbt9shitjc
 R3pQnS9gtaFI2ViLE917Z8/AYOIa/WUybwTSYjN9d5IDJkp+f1du6Bylop50SHgn2zBN
 HMQZBHya1LhOC0UIWaMphE4vEjpgrlYYNMbq+N9AF57zkyevd6YW+oDmLnAb4hGb0IfW
 IgLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIHRZRR4RvqlEsZiFzlKH1VNbkEgi6pFknpmAq1VFJnXA4nkUZwmNyP1BR7gbvjh4lPNPThcBoYmj0@nongnu.org
X-Gm-Message-State: AOJu0YztSo0d7jq0Mi3BqGTdw9n/oVFEWInnI5x7/y3OUgCTaxWVhvZr
 8lUk2HbVnq4a87Z48hu70+8Bh5h9whw7GyoUBXw1MQbrCYL2Fa5iPMSJR0uboql8LHEF30EZsWi
 AStQpVkZvXWwVdMqDqjS+9qAv38hfcQW2xAvANzjT5PqATrtsLt8SGP/p
X-Gm-Gg: AZuq6aKg39yiTvfm5uFPTAfVcw2lc/bC2p5NnW7eN+LBtHcz0+bAdCvSHYAlVUqQ9fN
 3pV2vHwVjPn/19iSl/s80YejssR4EwlYPYhwoSkQDFyfjpqEqgjKn0mjJFW55TFpFa2tjVKDFH3
 X8LvVc8iTvkGJgg0+4raYB3jnJYiZLX6fm5qeqo8fcNNt5xDpoZVn+7gYg0pI2fG/4Zx9ZkB47C
 yTM3RQRXq517SYkLlXMwAyBkFVgEyT/zZ7vr1Q5cY4Xo03RtTXUOT6jwcKh3jo9rCyqCKDZwV11
 ZeLHf7Bgozpit7u719s4Bs2sdplFoTiMRITAhXUTrdBILFDUggkpI1fANAgiEb185hkuac+Ii7F
 6WgTXzDvXfN9psg9uFH2tMC/6HEB7ywPsKw==
X-Received: by 2002:a05:6000:4301:b0:435:b7b9:afe5 with SMTP id
 ffacd0b85a97d-4362934a08emr63224f8f.1.1770313259015; 
 Thu, 05 Feb 2026 09:40:59 -0800 (PST)
X-Received: by 2002:a05:6000:4301:b0:435:b7b9:afe5 with SMTP id
 ffacd0b85a97d-4362934a08emr63178f8f.1.1770313258422; 
 Thu, 05 Feb 2026 09:40:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e25683sm14885376f8f.6.2026.02.05.09.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:40:57 -0800 (PST)
Date: Thu, 5 Feb 2026 12:40:54 -0500
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
Message-ID: <20260205124004-mutt-send-email-mst@kernel.org>
References: <20251211102025.873506-1-me@linux.beauty>
 <CAFEAcA8FcW22-TnyBKHmFUUsR=xk2u-74uPz6KisJTeG=YWxmQ@mail.gmail.com>
 <20260205051236-mutt-send-email-mst@kernel.org>
 <CAFEAcA-2QKtniTsLFA2ayjQ28dmQ=35r_zhkL6UBpiEOr=xGVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-2QKtniTsLFA2ayjQ28dmQ=35r_zhkL6UBpiEOr=xGVg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 05, 2026 at 05:15:17PM +0000, Peter Maydell wrote:
> On Thu, 5 Feb 2026 at 10:13, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Feb 05, 2026 at 10:08:32AM +0000, Peter Maydell wrote:
> > > On Thu, 11 Dec 2025 at 10:21, Li Chen <me@linux.beauty> wrote:
> > > >
> > > > From: Li Chen <chenl311@chinatelecom.cn>
> > > >
> > > > virt machines always instantiate a PL011/16550 UART at slot 0 and describe
> > > > it in ACPI (DSDT and optional SPCR table). When the command line disables
> > > > the serial backend (e.g. "-serial none"), the guest still sees the UART as
> > > > a preferred console even though it is not usable.
> > > >
> > > > Teach the virt ACPI code to omit the UART device and SPCR when there is no
> > > > serial backend attached. This matches the hardware that the guest can
> > > > actually use and avoids confusing firmware or OS code that relies on SPCR.
> > > >
> > > > The bios-tables-test qtests rely on an ACPI UART node and SPCR entry for
> > > > UEFI-based virt machines. To keep those tests working we create a UART
> > > > with a "null" chardev backend instead. This preserves the ACPI tables
> > > > while discarding the firmware's serial output so it does not corrupt the
> > > > TAP stdout stream.
> > > >
> > > > Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> > > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > >
> > > Sorry, I must have missed this patch previously. I'm not sure that
> > > this is a good idea, because it means:
> > >  * the dtb version of virt and the ACPI handling diverge
> > >  * we tangle up "what chardev do you want to connect serial output to"
> > >    and "what UARTs does the guest see"
> > >
> > > If the user explicitly sends the first serial port output
> > > to nowhere with "-serial none -serial stdio" they presumably
> > > had a reason for that and won't be happy to find that we've
> > > adjusted the ACPI tables to redirect that output to the
> > > second serial port they were planning to use for something else.
> 
> > presumably, things would be different with -nodefaults?
> 
> -nodefaults doesn't generally do much on Arm boards, because
> we don't have a lot of "pluggable thing that's plugged in by
> default" that we would turn off -- that's more of an x86 thing.
> 
> On the virt board the UART situation is a bit complicated,
> for command-line backwards compatibility reasons:
> 
>  * the first UART always exists
>  * if you're emulating the security extensions, the second
>    UART always exists (and is the secure-world UART)
>  * otherwise, the second UART exists only if the user
>    configured a second serial backend (i.e. provided
>    "-serial foo -serial bar" or similar)
> 
> If I were designing it again from scratch without the
> back-compat baggage, it would probably have three always-exists
> UARTs, one for secure-world and two for normal-world.
> 
> thanks
> -- PMM

that is why we have machine versioning?
I would say -nodefaults really should not have a serial port
unless defined, no?

-- 
MST


