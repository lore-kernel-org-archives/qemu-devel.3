Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3071DC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 13:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKGQn-0008E8-RM; Wed, 28 May 2025 09:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKGQl-0008A7-Dj
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKGQj-0003Lb-8b
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748437367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zTYLE6MSys4OmtzSZ6e/+XfZzBtahBlti+qgIKKXxs=;
 b=biKio2iIwrd6OQja/azrX24ZxCXOmtlqVMEvoVwnY+b47OXyJPChcrBhPnArVj6bFxwi3Y
 AECMlNwzqkjjrKgFx+zf2pi+FH7LRUxegUDdX/j+8BPaBl0JE0y4dThuJY4qZpZdDDec/u
 1n2fet6srU/oAmjsC8E7BEIU4fXnCh0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-zkDBhmrIMsibF99E36z4VQ-1; Wed, 28 May 2025 09:02:45 -0400
X-MC-Unique: zkDBhmrIMsibF99E36z4VQ-1
X-Mimecast-MFC-AGG-ID: zkDBhmrIMsibF99E36z4VQ_1748437365
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4d95f197dso2105848f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 06:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748437364; x=1749042164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zTYLE6MSys4OmtzSZ6e/+XfZzBtahBlti+qgIKKXxs=;
 b=CTRy5ITH8r0M7bHUJZIZmX+0EPczDQvAY4cr6IhArT9GRSk5dVz/AE49a/pbyuH7W8
 ORzQPO2xc7EZFoiGNg+66mhMjDEkknsoavdCA4kdHZZOZMmyOaRvcLTUJ5TV1JO+1JyP
 pJp3bYI46erKwVEJJyYTl8BDVC7085bH3IPtjWDD/G5a+8n64baoLEe1dPf9Fkdpw1K5
 dKqO++AC/7aWWIEhAngzO+h4tD8aPFqX0/xF2byVNeKV/QlfqCDQfhWk7eO9Kw/URAR3
 WzSZK2X6HhTkrwyLlaqrRek2H4ZgdL9FtcrCuPYil2KuYOVxOpB9lI48njYrTFdZrdD4
 Nufg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Je5J5Vm1ebo+6EWXf0RLa4GPb5gAHK9/AE4/rb5kAB7qbdft48J1zpJYTHi9J8b8/yDsWXuAFBWT@nongnu.org
X-Gm-Message-State: AOJu0YwHEguAjpv0/M6zrOMGfy2p/vSqy6dAq4nRqPoUvmpeCXSD3Xdc
 8JF7skGG3yWBvTwM9x5Zhajyw93Z5+T4In/kFq6COueUSn0QtMzd30urKbrNAC6T7hVeNlGmW0j
 /tYjILl82+0uXQL18RL3AbR2Xai4suaAZGbziC/K902BcvXyjsn81sqKo
X-Gm-Gg: ASbGncuMRgQ63TLQPwt0FoTfHwEKgpGNWWgITiPxUeHBSnb05jVKJM5xzRgsXNk/iry
 B8wk7gHoAd+hwPDfZu1A7wlYZltj4z602jLmjB0hHFMb//KJzs3kxdJ4TkJptBqv5no/d/cgeoH
 O0sOrgAKE7pfnXrzDswOaPvf81q+iIj9mfyM+vAf+jNYM2qrwaemdKb6Cj9gQHI19SNbk2wShYc
 GWIwTnofjXn/+P/7MrMJTN7XTEoACxMUh4HTk2bFLMmLbvzrBJJ/zMwI7tw0+dpDK8abYXGsN3p
 /Vq3HYtNM0Qd7P6e+duR9KZc11KI2p+x
X-Received: by 2002:a05:6000:2dc1:b0:3a4:dfc1:ecb8 with SMTP id
 ffacd0b85a97d-3a4dfc1ed20mr7176336f8f.53.1748437363767; 
 Wed, 28 May 2025 06:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHugJgHlM0Vpj60zdOilrkSc0PXc4GX760uO6ixkmaC5ppG/M5YTtZnO4PIKJNH99Zu97/0lQ==
X-Received: by 2002:a05:6000:2dc1:b0:3a4:dfc1:ecb8 with SMTP id
 ffacd0b85a97d-3a4dfc1ed20mr7176063f8f.53.1748437361535; 
 Wed, 28 May 2025 06:02:41 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac6ed58sm1433023f8f.8.2025.05.28.06.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 06:02:41 -0700 (PDT)
Date: Wed, 28 May 2025 15:02:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v2 24/25] tests/qtest/bios-tables-test: Keep ACPI PCI
 hotplug off
Message-ID: <20250528150239.5f6b63d0@imammedo.users.ipa.redhat.com>
In-Reply-To: <375cfbd6-e585-4b6d-bf10-6571aa40370e@linaro.org>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-25-eric.auger@redhat.com>
 <20250528113813.47086516@imammedo.users.ipa.redhat.com>
 <375cfbd6-e585-4b6d-bf10-6571aa40370e@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 28 May 2025 09:41:15 -0300
Gustavo Romero <gustavo.romero@linaro.org> wrote:

> Hi Igor,
> 
> On 5/28/25 06:38, Igor Mammedov wrote:
> > On Tue, 27 May 2025 09:40:26 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> >   
> >> From: Gustavo Romero <gustavo.romero@linaro.org>
> >>
> >> ACPI PCI hotplug is now turned on by default so we need to change the
> >> existing tests to keep it off. However, even setting the ACPI PCI
> >> hotplug off in the existing tests, there will be changes in the ACPI
> >> tables because the _OSC method was modified, hence in the next patch of
> >> this series the blobs are updated accordingly.
> >>
> >> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>  
> > 
> > it would be better to test whatever default we end up with.
> > (like x86)  
> 
> hmm maybe there is a confusion here, Igor. We are actually planning what you

perhaps, see my reply to Eric about my expectations wrt tests.
(i.e. default tests shouldn't have any explicit CLI options,
instead it should follow whitelist blobs/set new default patch/update blobs pattern)

> said. This patch and the other two in this series related to the bios-tables-test
> (i.e., patches 8/25 and 10/25) are for actually making the current (legacy) test pass,
> since the new default as per this series will be acpi-pcihp=on. That's why here we're
> adapting the current test here to have acpi-pcihp=off.
> 
> The new test that will test for acpi-pcihp=on (the new default) is not in this series
> and we decided to merge it separate. It's in the patch 4/5 and 5/5 of the follow series:
> 
> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05828.html 4/5
> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05827.html 5/5
> 
> 
> Cheers,
> Gustavo
> 
> >>
> >> ---
> >>
> >> [Eric] also added acpi-pcihp=off to test_acpi_aarch64_virt_tcg_numamem
> >> ---
> >>   tests/qtest/bios-tables-test.c | 13 +++++++++----
> >>   1 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> >> index 0a333ec435..6379dba714 100644
> >> --- a/tests/qtest/bios-tables-test.c
> >> +++ b/tests/qtest/bios-tables-test.c
> >> @@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
> >>       };
> >>   
> >>       data.variant = ".memhp";
> >> -    test_acpi_one(" -machine nvdimm=on"
> >> +    test_acpi_one(" -machine nvdimm=on,acpi-pcihp=off"
> >>                     " -cpu cortex-a57"
> >>                     " -m 256M,slots=3,maxmem=1G"
> >>                     " -object memory-backend-ram,id=ram0,size=128M"
> >> @@ -1747,7 +1747,8 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
> >>       };
> >>   
> >>       data.variant = ".numamem";
> >> -    test_acpi_one(" -cpu cortex-a57"
> >> +    test_acpi_one(" -machine acpi-pcihp=off"
> >> +                  " -cpu cortex-a57"
> >>                     " -object memory-backend-ram,id=ram0,size=128M"
> >>                     " -numa node,memdev=ram0",
> >>                     &data);
> >> @@ -1775,7 +1776,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
> >>        * to solve the conflicts.
> >>        */
> >>       data.variant = ".pxb";
> >> -    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
> >> +    test_acpi_one(" -machine acpi-pcihp=off"
> >> +                  " -device pcie-root-port,chassis=1,id=pci.1"
> >>                     " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
> >>                     " -drive file="
> >>                     "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
> >> @@ -1846,7 +1848,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
> >>   
> >>       data.variant = ".acpihmatvirt";
> >>   
> >> -    test_acpi_one(" -machine hmat=on"
> >> +    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
> >>                     " -cpu cortex-a57"
> >>                     " -smp 4,sockets=2"
> >>                     " -m 384M"
> >> @@ -2123,6 +2125,7 @@ static void test_acpi_aarch64_virt_tcg(void)
> >>       data.smbios_cpu_max_speed = 2900;
> >>       data.smbios_cpu_curr_speed = 2700;
> >>       test_acpi_one("-cpu cortex-a57 "
> >> +                  "-machine acpi-pcihp=off "
> >>                     "-smbios type=4,max-speed=2900,current-speed=2700", &data);
> >>       free_test_data(&data);
> >>   }
> >> @@ -2142,6 +2145,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
> >>       };
> >>   
> >>       test_acpi_one("-cpu cortex-a57 "
> >> +                  "-machine acpi-pcihp=off "
> >>                     "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
> >>       free_test_data(&data);
> >>   }
> >> @@ -2227,6 +2231,7 @@ static void test_acpi_aarch64_virt_viot(void)
> >>       };
> >>   
> >>       test_acpi_one("-cpu cortex-a57 "
> >> +                  "-machine acpi-pcihp=off "
> >>                     "-device virtio-iommu-pci", &data);
> >>       free_test_data(&data);
> >>   }  
> >   
> 


