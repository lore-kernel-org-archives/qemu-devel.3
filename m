Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6B5CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stEOB-0000IO-JZ; Tue, 24 Sep 2024 18:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1stEOA-0000FA-Or
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1stEO8-0005PB-Nl
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727218327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7TxogcYoM1yG0npSOzAM1BVRqLz/9NioED9yVLrbqiQ=;
 b=PejEiVu6+wn/bvYB+oj+8XKrm9tDJrt2wRHsW1yyO7kGLmuY5posm0C0kpyVZ7B9I+rWrY
 rGF44sifG8AzY8noBMzuN0kuwAye2P8mPaiq+Ta5O9/YMDAkIuAJROoIyR14CSFh7dCaWT
 ZxVOCSGlNB3F/ZaQ5+FQddUHbhPvrh0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-gZdwBCL-NtaxCjShLFnghg-1; Tue, 24 Sep 2024 18:52:05 -0400
X-MC-Unique: gZdwBCL-NtaxCjShLFnghg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb857fc7dso46768715e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727218324; x=1727823124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TxogcYoM1yG0npSOzAM1BVRqLz/9NioED9yVLrbqiQ=;
 b=XwxEGvmMD4/v0EPmgr+J4rGWaJhv4Wgvl49WpJF75h3CVxcRU0GK1Xy6LK8gO8Tsxw
 oOvsnd98VDzYhmUgENBirkIt58j9hAJF5E507ovy1PXsl5/8HS2bovmzD1vSWANdnXsU
 revzT00CLt8N1jNAMRmw4aJi6ap0ilu8nddLPqbSYwqWjrpxoYHJRE4iG7hWdqcbtqr/
 dgwT9ErtgO9jlcxrCx1TTV2+yT/ltB2NHiBAiO5UvXOiJ3Md/OTvfrta6GZCM5jxcsY3
 LVRQwBNlfcfJd8kUhQ5YhbQRUhXt9h1VN6LiB+663wMTYPg+XH7ibxXeAps/pEVDkHFI
 /5uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr3Ip/A8iT28qf0J/s/hvp2crBHQndZkgNxa1QCYIGCkxcb20dQT3w4HGh8Xc/uBrrhM3xF3KjgXuj@nongnu.org
X-Gm-Message-State: AOJu0Yzgz6OoZsMqfX3Mv68VqbKhBgwPXilQmn6wWCxhuvhtN2vWgP0L
 MlKaRNU+hptthmuLecgl4zq2QIzoVf6BNZFEGEP3OazlVJdmcDANUBLlgdKGjkDg/PlDiELEfKl
 /hrCasdkjx+78W1vL7GGFZ/4XRWrbcj4O1QZ3tP9INtQNO1Fw6q3Q
X-Received: by 2002:a05:600c:45cf:b0:42c:c4c8:7090 with SMTP id
 5b1f17b1804b1-42e9610b567mr3684325e9.9.1727218324292; 
 Tue, 24 Sep 2024 15:52:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6caV6wDZ2CQ1LXAcBooYvH0iOS8G7bwJUX14W6eBID9LopwnAGL4QCR6DHT3ptdn0vm9now==
X-Received: by 2002:a05:600c:45cf:b0:42c:c4c8:7090 with SMTP id
 5b1f17b1804b1-42e9610b567mr3684205e9.9.1727218323906; 
 Tue, 24 Sep 2024 15:52:03 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969e194bsm1337115e9.1.2024.09.24.15.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:52:02 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:51:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 0/3] Fix WinXP ISO boot using the dc390/am53C974 SCSI
 device
Message-ID: <20240924185147-mutt-send-email-mst@kernel.org>
References: <20240922143216.662873-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922143216.662873-1-ribalda@chromium.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Sep 22, 2024 at 02:31:08PM +0000, Ricardo Ribalda wrote:
> Mark Cave-Ayland reported that after landing the pre-computed _PRT, the
> above mentioned testcase failed to pass.
> 
> It seems that it is due to WinXP not handling properly a variable
> package. Let's replace it.


Thanks, will merge

> 
> Unfortunately, the ASL diff is not the best (or I cannot produce
> something better):
> 
> 12c12
> <  *     Length           0x00003917 (14615)
> ---
> >  *     Length           0x00003914 (14612)
> 14c14
> <  *     Checksum         0xD9
> ---
> >  *     Checksum         0x09
> 
> Ricardo Ribalda (3):
>   tests/acpi: pc: allow DSDT acpi table changes
>   hw/i386/acpi-build: return a non-var package from _PRT()
>   tests/acpi: pc: update golden masters for DSDT
> 
>  hw/i386/acpi-build.c                 |   2 +-
>  tests/data/acpi/x86/pc/DSDT          | Bin 8527 -> 8526 bytes
>  tests/data/acpi/x86/pc/DSDT.acpierst | Bin 8438 -> 8437 bytes
>  tests/data/acpi/x86/pc/DSDT.acpihmat | Bin 9852 -> 9851 bytes
>  tests/data/acpi/x86/pc/DSDT.bridge   | Bin 15398 -> 15397 bytes
>  tests/data/acpi/x86/pc/DSDT.cphp     | Bin 8991 -> 8990 bytes
>  tests/data/acpi/x86/pc/DSDT.dimmpxm  | Bin 10181 -> 10180 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbridge | Bin 8478 -> 8477 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbrroot | Bin 5034 -> 5033 bytes
>  tests/data/acpi/x86/pc/DSDT.ipmikcs  | Bin 8599 -> 8598 bytes
>  tests/data/acpi/x86/pc/DSDT.memhp    | Bin 9886 -> 9885 bytes
>  tests/data/acpi/x86/pc/DSDT.nohpet   | Bin 8385 -> 8384 bytes
>  tests/data/acpi/x86/pc/DSDT.numamem  | Bin 8533 -> 8532 bytes
>  tests/data/acpi/x86/pc/DSDT.roothp   | Bin 12320 -> 12319 bytes
>  tests/data/acpi/x86/q35/DSDT.cxl     | Bin 13148 -> 13146 bytes
>  tests/data/acpi/x86/q35/DSDT.viot    | Bin 14615 -> 14612 bytes
>  16 files changed, 1 insertion(+), 1 deletion(-)
> 
> -- 
> 2.46.0.792.g87dc391469-goog


