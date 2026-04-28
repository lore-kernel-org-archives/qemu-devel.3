Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEFBFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHjWQ-0004CJ-PN; Tue, 28 Apr 2026 10:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wHjVo-000459-Kn
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wHjVl-0007DC-DA
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777386843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TQUfvFQ3tyKu+n9lbDeaooMtPB8vWvoDj2D8zdsHoU=;
 b=O9dQSJ7T5palNx4F2LLkprFC8HAIrW6KMQXYB9Tvy8xOnCFb++AnsLqdZsYeazBRNvWHV3
 bGZgzg9pzqKhGdxB651d4yBUHJtz0AcX5kwjrp/+yuloG/PRExtTHwn7kkJWr8d8nXnPVw
 LRRtNWGNouf8iYtp91lkv7G7Jw4AHXw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-2lo0QVW6PvaPyKHA3gBSnQ-1; Tue, 28 Apr 2026 10:34:02 -0400
X-MC-Unique: 2lo0QVW6PvaPyKHA3gBSnQ-1
X-Mimecast-MFC-AGG-ID: 2lo0QVW6PvaPyKHA3gBSnQ_1777386841
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8f87d6ce659so75987385a.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777386841; x=1777991641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5TQUfvFQ3tyKu+n9lbDeaooMtPB8vWvoDj2D8zdsHoU=;
 b=Svug6oxx/KkZ0Bj+ZtwB6iSF26xVjSpl5XULooN9s85triTj0Xhb1zsKNtq4DcJnz/
 sDaG41jimHOI/cqhfGApyBXxV6UdS5jV5f3Tk6suS4e0lCgsrnk5B3uIceBwbS4xALqj
 ARmV6ow0VexX1xv5pJ1qR/dZPspKwdOidopZ0JC2Fo5M6hmhIYJAD8FSLAKD05x1oJH7
 zgjL3dWLxdc4NSU8pO+iqwJEAKz/O87+aXcr7w2YvsaC2xeEF8TLTvwhE06jglqk+Kvy
 cBhLf/cahc34CBv2kkXHMQWULZmdBZA0P8lfEvUNsPBgsIgsiHHV4iKr0J0vG7jyjBP+
 713g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777386841; x=1777991641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5TQUfvFQ3tyKu+n9lbDeaooMtPB8vWvoDj2D8zdsHoU=;
 b=WiHcmz6GHuolKZxuzdZPPXdWu9rFRGez7j0ztGnJ6/Rhhw9+f+h8BoqLlFYbMRYVk/
 /ETZo/gpvadOiW7i5VlFxkd/4AxPpE2GPrR0EfUOLxtWGSdVUg3SehMCXDfgnGWPY4cb
 gui/3Zev5rXiext6Mwtz8EDPaRgcINM7blFOEWWpMvDW8LmdaczPxNd52IuxQyHWV8l0
 KDMYXjkVXljsl73LdzDnNNLrnxM+2GK4BcHHuiA6jJRDAW/ZVlwZC0BAozn52YWw3Fcp
 D7dk6T8JWy0JZEWzEEvhe85f27HQEW712N1tQVV1sJHSZZm2PecJ5lh4Bidw96KkgXwV
 fR5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YJAJIIVweAAazzHFG2JkB4hQ9SVU/4TM+KrHj56Ss1jm/whIC5VrzqgnJK2C3oEh/pAhhV+2P4kV1@nongnu.org
X-Gm-Message-State: AOJu0Yy1FCh+zlMoxBsJ/yDZfIi0AiujwnCQafnuYcaiUvvsb+wlSxks
 hKNQJqdeqKTNsz72ntXyr4n/ebxBtUolg0m6MJ2rU5nINHR7wDXVEQnDHol4jX4OEpc+e6si7tu
 94JQ8a7Ldx4MLW9CS8q1r4brp0yQlo+Vsf6BMbs15wNC3ckO44inhzUmj
X-Gm-Gg: AeBDieuZsxQPNcjE6vdulRkB8TC3oQ8qFKPLihQJrB/v6EAjdTyPIljzU/Ge9mHpxIo
 52xdeM/SKn0SqXI3n+uD4mV3jOqmgVqYL5bHoDw5ipk3Y3YNxeCQiplUBwbc4azhEWAxwenimgS
 QvF3pI7Q2cXNt0+GASHxY4+ZoyrcTCjus6xXjcAjY3OTYMM6+JBZ50K++uj2aMwLX+j/bkTp0l9
 h5HiJ69FS1hmqTtR6M5NP4GHQmhSxLlr+KJvI9QuqgTWWbunn0+ecNZaITRsBGJ0ENxAG9cN7SW
 2/IJMzpJbOcbgTp3HHhOak1kVmUW3wVoXhGDMz1YCEUhwhNrUVaS7VhkWDe1Hav3jmkhJt9Qcm3
 vRcPpdwdWZwAApOjy
X-Received: by 2002:a05:620a:4694:b0:8ee:a1d:bad3 with SMTP id
 af79cd13be357-8f7d9a0f623mr456158385a.48.1777386841389; 
 Tue, 28 Apr 2026 07:34:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4694:b0:8ee:a1d:bad3 with SMTP id
 af79cd13be357-8f7d9a0f623mr456151885a.48.1777386840824; 
 Tue, 28 Apr 2026 07:34:00 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f7c85a8eb1sm199986785a.41.2026.04.28.07.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:34:00 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:33:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/4] isa-serial: acpi: declare shared IRQs for COM1/3
 and COM2/4
Message-ID: <20260428163356.3a2feb90@imammedo>
In-Reply-To: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
References: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 11 Mar 2026 16:24:25 +0000
Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
> 5.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ

nitpicking but pc/q35 ship rev 3.0 facp, it is worth mentioning CLI used to reproduce/test
 
> Descriptor is used then the interrupt is considered to be high true, edge
> sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
> an IRQ then if more than 2 serial ports are added, Windows indicates a
> conflict in Device Manager and these combinations cannot be used together.
> 
> Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
> ISA serial IRQ is low true, edge sensitive and shareable. This enables all 4
> legacy serial ports to be used in Windows without conflict.
> 
> Tested on Windows 8.1 and Windows 11 with 4 instances of -serial on the command
> line and copying data simultaneously across serial ports COM1/3 and COM2/4.
> Note that with this series applied, if extra ISA serial ports are added to an
> existing VM then it is necessary to go to Device Manager, select "Add legacy
> hardware" from the "Action" menu, and then reboot the VM for the serial ports
> to be detected correctly without Device Manager indicating a conflict.




> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> v2
> - Remove _PRS changes (including AML build changes that are no longer required)
>   and compatibility property as suggested by Igor
> 
> 
> Mark Cave-Ayland (4):
>   hw/acpi/aml-build.c: add aml_irq() representing the 3-byte IRQ
>     descriptor
>   tests/acpi: allow DSDT acpi table changes
>   hw/char/serial-isa.c: declare IRQ as shared in ACPI IRQ descriptor
>   tests: data: update x86 ACPI tables
> 
>  include/hw/acpi/aml-build.h                   |   2 ++
>  hw/acpi/aml-build-stub.c                      |   6 +++++
>  hw/acpi/aml-build.c                           |  25 ++++++++++++++++++
>  hw/char/serial-isa.c                          |   3 ++-
>  tests/data/acpi/x86/microvm/DSDT              | Bin 365 -> 366 bytes
>  tests/data/acpi/x86/microvm/DSDT.ioapic2      | Bin 365 -> 366 bytes
>  tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2986 bytes
>  tests/data/acpi/x86/microvm/DSDT.rtc          | Bin 404 -> 405 bytes
>  tests/data/acpi/x86/microvm/DSDT.usb          | Bin 414 -> 415 bytes
>  tests/data/acpi/x86/pc/DSDT                   | Bin 8598 -> 8599 bytes
>  tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8509 -> 8510 bytes
>  tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9923 -> 9924 bytes
>  tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15469 -> 15470 bytes
>  tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9062 -> 9063 bytes
>  tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10252 -> 10253 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8549 -> 8550 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5087 -> 5088 bytes
>  tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8670 -> 8671 bytes
>  tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9957 -> 9958 bytes
>  tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8456 -> 8457 bytes
>  tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8604 -> 8605 bytes
>  tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12391 -> 12392 bytes
>  tests/data/acpi/x86/q35/DSDT                  | Bin 8427 -> 8428 bytes
>  tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8444 -> 8445 bytes
>  tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9752 -> 9753 bytes
>  .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12637 -> 12638 bytes
>  .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8706 -> 8707 bytes
>  tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8473 -> 8474 bytes
>  tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12040 -> 12041 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12985 -> 12986 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33842 -> 33843 bytes
>  tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8891 -> 8892 bytes
>  tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13218 -> 13219 bytes
>  tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10081 -> 10082 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8502 -> 8503 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8515 -> 8516 bytes
>  tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8444 -> 8445 bytes
>  tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9786 -> 9787 bytes
>  tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9557 -> 9558 bytes
>  tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13280 -> 13281 bytes
>  tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8289 -> 8290 bytes
>  tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8285 -> 8286 bytes
>  tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8433 -> 8434 bytes
>  tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8528 -> 8529 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12985 -> 12986 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33842 -> 33843 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9033 -> 9034 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9059 -> 9060 bytes
>  tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18661 -> 18662 bytes
>  tests/data/acpi/x86/q35/DSDT.viot             | Bin 14684 -> 14685 bytes
>  tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35790 -> 35791 bytes
>  51 files changed, 35 insertions(+), 1 deletion(-)
> 


