Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9381EC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbhl-0006zL-Nz; Fri, 20 Jun 2025 09:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbhb-0006wr-OR
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbhW-0007Qp-Q5
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750425757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TrY03pQabW/7U+H8CdQTgK6FVk4MRFPxv/zbddqFY8=;
 b=AE6zH1mDDiQpsVh4nB0YIbH/xrSK5Xbu9RlWcKJwxOg82LXaO1t0TSBpHmWawVvb5gjz+H
 LkL9aN0/0BLWHXKG6CwBT9Tqac2daURYot1vt796neLfoFl0hy5LHLOTrNAc1hw9Cok4DA
 FqxCa+sRp5C70cQmTq+/7tCsliQmKWE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-MhtOVbydOcyLTQrOfrsCnw-1; Fri, 20 Jun 2025 09:22:35 -0400
X-MC-Unique: MhtOVbydOcyLTQrOfrsCnw-1
X-Mimecast-MFC-AGG-ID: MhtOVbydOcyLTQrOfrsCnw_1750425754
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so978963f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750425754; x=1751030554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1TrY03pQabW/7U+H8CdQTgK6FVk4MRFPxv/zbddqFY8=;
 b=bJ0TJUxjDjhyuJOkdBeGllIZCZZHJ7rDKlPSNW4pdoaOOdbP4OCCaUHWfHC5RyJSaY
 mG4Gzkt1sNA0+U8GqXYpogdKCjc+pWpsUYorDbCjNQ2ZuBg/Y9tFalIzdhoBsYlLn//X
 9+RlE3/R4QYaBQEg849XAkms1hvOm+lsXXz29eA6y6NkdexyJgahwPg2kitm1QGwy5ci
 4lfndrlwrIQwhsS+y9taMgmtBdoQz3I/RLjPi6Ss/B4N/DatX32hZvm7HtVOXnLxkoev
 NHhfsxIRAW30w3JK1qDrZXnZWb/1kvQZmTshDIg5bCnpABy7sRVw4JqlJD6BeIgLaGo9
 Pn+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE2Kiku3dthxTPdd0kNkAgUPDXtPovU6kv96Gwm+nzsEGH7kzIUU7Err/MlfU9T5P1SNxW8e6w5a0S@nongnu.org
X-Gm-Message-State: AOJu0YyM2EshGDc5kLhKH5PFNXoUmONJFmNGDLcW7WRk7kQBL1NAQ4dI
 0Rg3u33A6S0tY5cNa/3cStOQpnYNDQnEyf5mSPqKhWQx+lVUa9nxFuuolVB3KkbydrSrTiVqPT3
 hFxkXzt7IcsRqcAVEkfJBdAc19SPDdqwPQEAQeeeEKLuuzxbu19pF7TBs
X-Gm-Gg: ASbGncvNmufkOOJSMZnaPfAzaS+lPQJeue0vgNRJPNePU79gW3dyqRJTDfg1S51wN//
 v5i/3iic91BzHlVAbXABLpHWSrl56sdU7WChG111BzabWWJaVmkGFL3VQVFg2TxvisNnKdLbpRW
 iSvAidlPZUI2HRMD79RH0trVrIHXMiKF55Cr02Sjx722QBAkLSvzQa5F/bZtY8KEWHws0Vwm8sk
 4kAd6eN9SQtbekHNqW5gk4kJKvCwVS96WOFO9P+1T+WKa2Tj8Bp0kQblwqWs5UfS+jYKOaQXWSF
 9Arq8kWWn5zB
X-Received: by 2002:a5d:588e:0:b0:3a5:2b1e:c49b with SMTP id
 ffacd0b85a97d-3a6d2802f51mr1924610f8f.29.1750425754130; 
 Fri, 20 Jun 2025 06:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPFSqZhoNmVQoxMPzgnSJXmQkqHW/lKdpTuZ2lNRUmfS7QmXDTtclgE7fRkpjCnJ5leRB39Q==
X-Received: by 2002:a5d:588e:0:b0:3a5:2b1e:c49b with SMTP id
 ffacd0b85a97d-3a6d2802f51mr1924579f8f.29.1750425753731; 
 Fri, 20 Jun 2025 06:22:33 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e97ac4asm58965995e9.3.2025.06.20.06.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 06:22:33 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:22:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 28/29] tests/qtest/bios-tables-test: Add aarch64 ACPI
 PCI hotplug test
Message-ID: <20250620152232.36683ffc@fedora>
In-Reply-To: <20250620114029.00005a94@huawei.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-29-eric.auger@redhat.com>
 <20250620114029.00005a94@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 20 Jun 2025 11:40:29 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 16 Jun 2025 11:46:57 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
> > From: Gustavo Romero <gustavo.romero@linaro.org>
> > 
> > The test uses -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
> > to force the usage of ACPI PCI hotplug.
> > 
> > Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>  
> 
> Could we add the necessary (I'm not quite sure what) to trigger the _DSM
> creation so EDSM gets used?  I'm not keen on that being dead code
> wrt to tests on ARM.

relevant x86 example:

        " -device pcie-root-port,id=nohprp,port=0x0,chassis=2,hotplug=off,"      
                                 "addr=7.0"                                      
        " -device pci-testdev,bus=nohprp,acpi-index=501"  
> 
> Jonathan
> 
> 
> 
> > ---
> >  tests/qtest/bios-tables-test.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index 0b2bdf9d0d..4b9e391eaf 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -1643,6 +1643,38 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
> >  
> >  }
> >  
> > +static void test_acpi_aarch64_virt_acpi_pci_hotplug(void)
> > +{
> > +    test_data data = {
> > +        .machine = "virt",
> > +        .arch = "aarch64",
> > +        .tcg_only = true,
> > +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> > +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> > +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> > +        .ram_start = 0x40000000ULL,
> > +        .scan_len = 256ULL * MiB,
> > +        .variant = ".acpipcihp",
> > +    };
> > +
> > +   /* Use ACPI PCI Hotplug */
> > +   test_acpi_one(" -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on"
> > +                 " -cpu cortex-a57"
> > +                 /*
> > +                  * We just pick address=0x04 for the root port to avoid
> > +                  * collisions with other PCI devices on the root bus (pcie.0).
> > +                  * It could be any other value that doesn't collide.
> > +                  *
> > +                  * The 'chassis' and 'slot' options equal to 1 have no special
> > +                  * meaning here, could be any integer, but we set them to known
> > +                  * values to keep the test consistent.
> > +                  */
> > +                 " -device pcie-root-port,bus=pcie.0,chassis=1,slot=1,addr=0x04.0x00",
> > +                 &data);
> > +
> > +    free_test_data(&data);
> > +}
> > +
> >  static void test_acpi_microvm_prepare(test_data *data)
> >  {
> >      data->machine = "microvm";
> > @@ -2580,6 +2612,8 @@ int main(int argc, char *argv[])
> >              qtest_add_func("acpi/virt/numamem",
> >                             test_acpi_aarch64_virt_tcg_numamem);
> >              qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
> > +            qtest_add_func("acpi/virt/acpipcihp",
> > +                           test_acpi_aarch64_virt_acpi_pci_hotplug);
> >              qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
> >              qtest_add_func("acpi/virt/oem-fields",
> >                             test_acpi_aarch64_virt_oem_fields);  
> 


