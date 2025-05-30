Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CF1C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 11:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKyB3-0007XJ-Nm; Fri, 30 May 2025 07:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKyAt-0007W4-CK
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKyAq-0002c4-IB
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748605519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WVZC1i+rkRea2Bzt+5NfaWSjNrdWgEzrHBG8hGCNAgY=;
 b=ITxiOcEoQcAvHEKYSBv3pUtOkhSB30fL5h0SrOcAwmod2BZHg7HDLHIuPBPpqew5cxpfjf
 6K1/n2XSPKWqOpnUQxgnqnKnGikAx06LhyYkJ/35KBuSL6QWAU/9H9xE0W3thCURX5tO8p
 su8Ovp2Z71WJN3o6Ix6mqcG8eRJJcZs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-YpyCEYWEMEW7wZYmf7dhsQ-1; Fri, 30 May 2025 07:45:18 -0400
X-MC-Unique: YpyCEYWEMEW7wZYmf7dhsQ-1
X-Mimecast-MFC-AGG-ID: YpyCEYWEMEW7wZYmf7dhsQ_1748605517
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4fabcafecso121383f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 04:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748605517; x=1749210317;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WVZC1i+rkRea2Bzt+5NfaWSjNrdWgEzrHBG8hGCNAgY=;
 b=n5mVnBpWbWk+m8P3aA/FsiQWM7lvEAEtdYQ5rUBkmd8kogZe9KlteUfItA8ceL2dly
 q3CHqLdvWgWJYrDqj4ROsfjjgaaTTXz4ElZQGJU1h0Rv9DgCZ9zKM+du6YZ6hJPAwiF9
 1EVJdlnDHFUGyTKAzWYkdslcJ5JMCK+5zLlm5WrpiLIUdzNkq3hq7dY0g6I1t6bDiZXk
 cq4LbemZQeoQO3Ig2qssdzGX7CyOcE0yewEDZRH8Q7LPHtVo1UcywfA+N6rkEcJ3e3bg
 6VL1vqIJgfshK/hSzjbkIGAVjQ9fBPwWVpL1JZW1YoGo5btuZEy3oJbHtfzB+2gw7jU4
 EWOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYGy15426oJ2trBGGBl3Rav064mkCPquULBq/kSlq0BubY4dHQsDm/9D3R6b7e8HXfG0GqXUGfrLY1@nongnu.org
X-Gm-Message-State: AOJu0Yzax91YgGjkVlj9tsuU4ZMufKr+RLV5AxK8o5PuC6PvLSAbi0Ai
 LfoWZoJMITKKxebxBOfjNj4m/hyz+BOLDrCeBRwIBGRb9tIWNzddougMHoP8/WuLtpe70ZMuV9K
 i4Maawo/vtz5z4Cz+U4KTMffkRM7TbABk8zM059r+GvFfeJ/p2wwDjBvG7Xp8AkPC
X-Gm-Gg: ASbGncsDOMkIt7Uk436SefVJCYFyZeyUJ/WxYUiJYOgXnq0twY4Rq1YDmXWKrf8B/m1
 tLH/RdlVTqg9tsB+jfz20IaZ9RiuiZ4GyOJyIW75Ed9sE/xA9+Fh5eXh2/7EYpgkTbpbCJikPvh
 Ew+HZExzNuGpMNvwDxpCeukVaqyrugX2XKHKKQI3KtcGSSw762/RRpWnlTW5ytvmlILsbSNrptv
 eh1hj5jBeF8j7CkAK+mgnT+IzOGAerXlFqUXFpku9gTQwLEym+fsffWBZbDa29A+IO/k5mucyuI
 R4nIrA==
X-Received: by 2002:a05:6000:4007:b0:3a3:6afd:f2dd with SMTP id
 ffacd0b85a97d-3a4f7a7cc0bmr2031101f8f.50.1748605516928; 
 Fri, 30 May 2025 04:45:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEev+uUDmL/CZs+zaUMqVGk0wjrVNmorkp7wMgSqrTmqly20DfDSq3CtCPJMn5P80647lWm0Q==
X-Received: by 2002:a05:6000:4007:b0:3a3:6afd:f2dd with SMTP id
 ffacd0b85a97d-3a4f7a7cc0bmr2031071f8f.50.1748605516506; 
 Fri, 30 May 2025 04:45:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb0997sm15899945e9.23.2025.05.30.04.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 04:45:15 -0700 (PDT)
Date: Fri, 30 May 2025 07:45:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Fam Zheng <fam@euphon.net>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 13/19] hw/block/fdc-isa: Remove 'fallback' property
Message-ID: <20250530074459-mutt-send-email-mst@kernel.org>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-14-philmd@linaro.org>
 <6484086d-22a7-4cb6-9140-bb5251c5cf93@redhat.com>
 <bfc0d4e7-d062-4526-8969-9fc0a7a3d179@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfc0d4e7-d062-4526-8969-9fc0a7a3d179@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 28, 2025 at 10:30:17AM +0200, Thomas Huth wrote:
> On 27/05/2025 19.20, Thomas Huth wrote:
> > On 12/05/2025 10.39, Philippe Mathieu-Daudé wrote:
> > > The "fallback" property was only used by the hw_compat_2_5[] array,
> > > as 'fallback=144'. We removed all machines using that array, lets
> > > remove ISA floppy drive 'fallback' property, manually setting the
> > > default value in isabus_fdc_realize().
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > > ---
> > >   hw/block/fdc-isa.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > FWIW, this needs a fixup for iotest 172:
> > 
> >   https://gitlab.com/thuth/qemu/-/jobs/10166450223#L466
> 
> FYI, since I was testing this series anyway, I'll fix up this patch with:
> 
> diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
> --- a/tests/qemu-iotests/172.out
> +++ b/tests/qemu-iotests/172.out
> @@ -14,7 +14,6 @@ Testing:
>              dma = 2 (0x2)
>              fdtypeA = "auto"
>              fdtypeB = "auto"
> -            fallback = "288"
>              bus: floppy-bus.0
>                type floppy-bus
>                dev: floppy, id ""
> @@ -43,7 +42,6 @@ Testing: -fda TEST_DIR/t.qcow2
>              dma = 2 (0x2)
>              fdtypeA = "auto"
>              fdtypeB = "auto"
> -            fallback = "288"
>              bus: floppy-bus.0
>                type floppy-bus
>                dev: floppy, id ""
> @@ -79,7 +77,6 @@ Testing: -fdb TEST_DIR/t.qcow2
>              dma = 2 (0x2)
>              fdtypeA = "auto"
>              fdtypeB = "auto"
> -            fallback = "288"
>              bus: floppy-bus.0
>                type floppy-bus
>                dev: floppy, id ""
> 
> etc.
> 
> and I will queue this series (without the "Remove X86CPU::check_cpuid field"
> patch as mentioned by Xiaoyao Li), unless Paolo or another x86 maintainer
> wants to do this instead (please let me know!).
> 
>  Thomas

No, pls go ahead.


