Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D59C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKEM6-0002Nx-UN; Wed, 28 May 2025 06:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKEM3-0002Kx-3e
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKEM0-0006gT-Vl
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748429388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eo7JgcWIfIt948do3LlLVcHxwolSgQoURAGIxncUInI=;
 b=GDCmINvVMMa8mWkzok3nAzulfyoWAtkk3Bj5mTpAbK08KTrp4n8l1QeOZFlIE6bkUsXN+X
 tPPBeP/xHkHK0285fdp1nOqXuz0Z/MG6BCU0gzGgR6adNYdob3q8+PKlZZ0InFB5A6g5Z8
 j5Nc5wCQRSI1ymjU4mQVXxUhuLAs7dk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-KhWthrI0PwyUNTlLYOSohg-1; Wed, 28 May 2025 06:49:46 -0400
X-MC-Unique: KhWthrI0PwyUNTlLYOSohg-1
X-Mimecast-MFC-AGG-ID: KhWthrI0PwyUNTlLYOSohg_1748429385
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-441c96c1977so26849975e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 03:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748429385; x=1749034185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eo7JgcWIfIt948do3LlLVcHxwolSgQoURAGIxncUInI=;
 b=j/9AE0qss8+GZ+ToQFiX/57OKr1vND24AhTyCOVIdxU+NR1SogTzJjpqo56WCByhKa
 1dEZEKN5bcZS2rvVMxVL8VDzVje+eUKPxNBK2K7Ug3BCDH0U1utsmFu6Gt90NidXyhYH
 nm/t7SQnRFA8ZC0DaeSl9TsqtUCHklyg1sTdjyE3weF1MaRlpXx0urLy7lm+gK7itVEV
 All4bU8EUrFQkbhvu4qNfjGpTtMupPPi9kbp4Qxa8Q87fNSAj4kyYYkjsFIu7u52kjcU
 0PRKhQggoiG5qcLrezTJt409sxCyUOZcdHU7qx/5jCCkskkCNen9n/2EFGK3yUTJvt0b
 tKEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD4Bd7pXzpIHAW50FeyFlcoY3rYt0rvhOcNuZXWRNvCFvQv7OxhprHksrpbeyKoMuBe5kQAnYIVrGv@nongnu.org
X-Gm-Message-State: AOJu0Yy6hTCo3Pj4JTdz8G6r4G4KrfdbuYor4fkv4GPaIrz9WpMrtEWo
 12mTOkzq9TXvFiGKoHc0nMwcCgNsM6zOR7sJ3LTYSlvK3CmlE+uQZj3wVGzNyH1Uvcbx/r5EI3g
 SyYcn+eIoEhRzk/pyYOqIXBVjHUt1Tkbf27OYWU/6MUq+pqdOWBne6NX5
X-Gm-Gg: ASbGncuEMO7RsLQ891VwjVkZgkyxin2UoxnOooRoJwK4KrJqSr+px2cnBeKeXIl7WPp
 9J6a1PzWuf5dYqeg8JRO9cPKf5z/XLfAq5WBLLnGxHUDnH6aUS7Fg+PJbTGk+8yPRWSe0QkJhAl
 866waUIavSno0MWbQV715UnmkMkYsFeC9g4kdkbj42CGZCtlAr+hAcV/DAgK/pEMeCO5Dv3DvbT
 LTr65UHtz4PP+9nI7MTg6KzHFDhx5JrImDPgmwjhKWgxAkddPswLzDzQsuOkZKC+HsrhY3B/lbg
 oPxe0W0+3HeNNEio6ZahQwScbdhEevOd
X-Received: by 2002:a05:6000:18ad:b0:3a4:d994:be4b with SMTP id
 ffacd0b85a97d-3a4d994bfa2mr10275449f8f.1.1748429385174; 
 Wed, 28 May 2025 03:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8sKOF7yPrvUxEoRddkV6M+gSz4jdvQ9zIPf0wudDQkmUFgjb3FBPGXsfCtlFLA2DnnQiA2g==
X-Received: by 2002:a05:6000:18ad:b0:3a4:d994:be4b with SMTP id
 ffacd0b85a97d-3a4d994bfa2mr10275431f8f.1.1748429384773; 
 Wed, 28 May 2025 03:49:44 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450064a133csm17695005e9.11.2025.05.28.03.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 03:49:44 -0700 (PDT)
Date: Wed, 28 May 2025 12:49:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 24/25] tests/qtest/bios-tables-test: Keep ACPI PCI
 hotplug off
Message-ID: <20250528124943.45ee502e@imammedo.users.ipa.redhat.com>
In-Reply-To: <fd44ef37-ef02-4e60-817d-1362c76433b0@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-25-eric.auger@redhat.com>
 <20250528113813.47086516@imammedo.users.ipa.redhat.com>
 <fd44ef37-ef02-4e60-817d-1362c76433b0@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 28 May 2025 11:48:20 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Igor,
> 
> On 5/28/25 11:38 AM, Igor Mammedov wrote:
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
> > it would be better to test whatever default we end up with.
> > (like x86)  
> 
> See my question on patch 2's comment. We intended to have tests for both
> modes (legacy and acpi pcihp). Gustavo added some new tests for the new
> default, namely acpi pcihp. Now I did not really understand your point
> about keeping legacy mode as a default.

default legacy wrt tests are orthogonal things.
Just decide what default should be in #2 and then make sure existing tests
work with that.
Default (majority) tests shouldn't include CLI option a for a feature 'acpi-pcihp',
only legacy tests should have it.

Given bios-tables-test is heavy load on CI for x86 we have only few
test cases to check no pcihp (legacy), the same should be done for ARM.


Then on top add a few acpi hotplug tests to snapshot DSDT with
hotplug hierarchy built in.

ex: test_acpi_piix4_tcg_bridge or test_acpi_piix4_no_acpi_pci_hotplug.
 
> 
> Thanks
> 
> Eric
> >  
> >> ---
> >>
> >> [Eric] also added acpi-pcihp=off to test_acpi_aarch64_virt_tcg_numamem
> >> ---
> >>  tests/qtest/bios-tables-test.c | 13 +++++++++----
> >>  1 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> >> index 0a333ec435..6379dba714 100644
> >> --- a/tests/qtest/bios-tables-test.c
> >> +++ b/tests/qtest/bios-tables-test.c
> >> @@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
> >>      };
> >>  
> >>      data.variant = ".memhp";
> >> -    test_acpi_one(" -machine nvdimm=on"
> >> +    test_acpi_one(" -machine nvdimm=on,acpi-pcihp=off"
> >>                    " -cpu cortex-a57"
> >>                    " -m 256M,slots=3,maxmem=1G"
> >>                    " -object memory-backend-ram,id=ram0,size=128M"
> >> @@ -1747,7 +1747,8 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
> >>      };
> >>  
> >>      data.variant = ".numamem";
> >> -    test_acpi_one(" -cpu cortex-a57"
> >> +    test_acpi_one(" -machine acpi-pcihp=off"
> >> +                  " -cpu cortex-a57"
> >>                    " -object memory-backend-ram,id=ram0,size=128M"
> >>                    " -numa node,memdev=ram0",
> >>                    &data);
> >> @@ -1775,7 +1776,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
> >>       * to solve the conflicts.
> >>       */
> >>      data.variant = ".pxb";
> >> -    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
> >> +    test_acpi_one(" -machine acpi-pcihp=off"
> >> +                  " -device pcie-root-port,chassis=1,id=pci.1"
> >>                    " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
> >>                    " -drive file="
> >>                    "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
> >> @@ -1846,7 +1848,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
> >>  
> >>      data.variant = ".acpihmatvirt";
> >>  
> >> -    test_acpi_one(" -machine hmat=on"
> >> +    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
> >>                    " -cpu cortex-a57"
> >>                    " -smp 4,sockets=2"
> >>                    " -m 384M"
> >> @@ -2123,6 +2125,7 @@ static void test_acpi_aarch64_virt_tcg(void)
> >>      data.smbios_cpu_max_speed = 2900;
> >>      data.smbios_cpu_curr_speed = 2700;
> >>      test_acpi_one("-cpu cortex-a57 "
> >> +                  "-machine acpi-pcihp=off "
> >>                    "-smbios type=4,max-speed=2900,current-speed=2700", &data);
> >>      free_test_data(&data);
> >>  }
> >> @@ -2142,6 +2145,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
> >>      };
> >>  
> >>      test_acpi_one("-cpu cortex-a57 "
> >> +                  "-machine acpi-pcihp=off "
> >>                    "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
> >>      free_test_data(&data);
> >>  }
> >> @@ -2227,6 +2231,7 @@ static void test_acpi_aarch64_virt_viot(void)
> >>      };
> >>  
> >>      test_acpi_one("-cpu cortex-a57 "
> >> +                  "-machine acpi-pcihp=off "
> >>                    "-device virtio-iommu-pci", &data);
> >>      free_test_data(&data);
> >>  }  
> 


