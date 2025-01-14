Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A533C02184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 10:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXe2j-0002wA-Mx; Tue, 14 Jan 2025 05:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tXe2i-0002vd-5V
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:21:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tXe2g-0002bI-Ic
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736850060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6Km4Vl2oNlcqrf1o8ykF8EaMLn60LBZ5H9pe/iXZXs=;
 b=OIqorTAIZM2jEsbaEavwll8TyPfsjJjxixUlUOS97gesxY6/uIsW7MR5tVvA6Vsg1IIQiG
 qvdWIOUwaTCncSL4RcOlBIl19ex+A/8/f8l3U6iv9BEi+v2BQY3RsWc9YdPWbEOeIryIeq
 RYKCJfxfpAknV2Ruy4HZVyaL5TM7lAU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-ZJxG2jQQPqy9zOVYlOcMJw-1; Tue, 14 Jan 2025 05:20:59 -0500
X-MC-Unique: ZJxG2jQQPqy9zOVYlOcMJw-1
X-Mimecast-MFC-AGG-ID: ZJxG2jQQPqy9zOVYlOcMJw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385d735965bso3683214f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 02:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736850056; x=1737454856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6Km4Vl2oNlcqrf1o8ykF8EaMLn60LBZ5H9pe/iXZXs=;
 b=EYnMSy3G2CUafTBtVPs/oxhUxRZWLCjqsgeuQpA8fxTYQOWrfXdU/YWH7nBf+bgN7y
 A6wuSEnNjsD3wdZm1gXdAxMzljB0XIzKsnWfXeBqBAqH5hZkkwwvwKAEz3yZ8JoBKt3n
 Oot5y5KRP/BuFY28GXxnXkwvBmD/7QMa9UBdMbx7FIRu3FrAFpp2+hxYgyzLPHUJv0cj
 53RmYvXCjijc7Ul/mCDkH8pHmam0dFhPmSRdJz+fby/8L4RrgG2ywjFj5muRYe/6d8Z8
 pEXhuJjPY6HonLnSlVJf9qBVwMF6J7BzAcUasQN1eFA4/p0/5HR0QifUOfJgARZbrwJZ
 UfhA==
X-Gm-Message-State: AOJu0Yzx4Pk/DJ2bdtfjNUeywoOH1yVHTJc78eR0Pe3qRk6ycRembLUW
 qw1OA1KzvIUBt8PqDbaH3OirwKL2RP30XShEjlEoRwLAcTFod9vN95cLUVasnGWnBOLLiacevrb
 LKY5jq32tmueSOPZSxAHJUeFAP3fNb8GMd2vlssS3cSu8ALJ8bDQG5VhQQcPi7Hc7ghfhDrDA6d
 ZbKo/n3CvjX2QuZyt8UlEDeFRJ9AKWah85SKQS
X-Gm-Gg: ASbGncsyKU30J8uEKN5M9M9hJqRH1ByF62G5MnYef6/FDkcNygDHJmySVW37vshqKR0
 5oisZ/EuBR9VrWpHUn89k3DuuLMODsXU5LxnTmVtW/b75Gl8r8R+Tx4p4vmPTyzcpAbBIt599N5
 F4Znb7Ot8KIGSMB5/i6UEv8DGh0Jp9p0iVOuCvfFF7ZPnaLbQ8YNpciqpoT09ZAw3txBDi9JLC6
 X2HzhpcusJ8IqTvJPk02vmBpn1aNz4ItcIC6uKZYu+PhURFCTZvS9jG3/LxAAUNnpIgnGZdJsyK
 AXyzPd7gLDMUqmwHcKvkVIcAYkrO
X-Received: by 2002:a05:6000:186b:b0:388:da2a:12fa with SMTP id
 ffacd0b85a97d-38a8733badamr19150892f8f.52.1736850056273; 
 Tue, 14 Jan 2025 02:20:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1XX4GyWwRGRAyhs2Gd1f9cXLmwh111sSO64Ixm3gcVYKIGFsVe9lc/wf5OLjBhEYprj3Y8Q==
X-Received: by 2002:a05:6000:186b:b0:388:da2a:12fa with SMTP id
 ffacd0b85a97d-38a8733badamr19150860f8f.52.1736850055792; 
 Tue, 14 Jan 2025 02:20:55 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38be422191fsm431377f8f.56.2025.01.14.02.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 02:20:55 -0800 (PST)
Date: Tue, 14 Jan 2025 11:20:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, eric.mackay@oracle.com, anisinha@redhat.com
Subject: Re: [PATCH 0/3] cpuhp: ensure that cpu hotremove works the 1st time
Message-ID: <20250114112054.6dcaa756@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241210163945.3422623-1-imammedo@redhat.com>
References: <20241210163945.3422623-1-imammedo@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 10 Dec 2024 17:39:42 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> CPU hotremove event is not delivered to OSPM if the CPU
> has been hotplugged before OS has booted.
> For details see [2/3].

Michael,
can you pick it up please?

> 
> Igor Mammedov (3):
>   tests: acpi: whitelist expected blobs
>   cpuhp: make sure that remove events are handled within the same SCI
>   tests: acpi: update expected blobs
> 
>  hw/acpi/cpu.c                                 |  43 ++++++++++++++----
>  tests/data/acpi/x86/pc/DSDT                   | Bin 8526 -> 8593 bytes
>  tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8437 -> 8504 bytes
>  tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9851 -> 9918 bytes
>  tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15397 -> 15464 bytes
>  tests/data/acpi/x86/pc/DSDT.cphp              | Bin 8990 -> 9057 bytes
>  tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10180 -> 10247 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8477 -> 8544 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5033 -> 5100 bytes
>  tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8598 -> 8665 bytes
>  tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9885 -> 9952 bytes
>  tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8384 -> 8451 bytes
>  tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8532 -> 8599 bytes
>  tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12319 -> 12386 bytes
>  tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8422 bytes
>  tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8439 bytes
>  tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9747 bytes
>  .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12565 -> 12632 bytes
>  .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8701 bytes
>  tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8468 bytes
>  tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 12035 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 12980 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33837 bytes
>  tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 8886 bytes
>  tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13146 -> 13213 bytes
>  tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10076 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8497 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8510 bytes
>  tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8439 bytes
>  tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9781 bytes
>  tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9552 bytes
>  tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13275 bytes
>  tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8235 -> 8302 bytes
>  tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8280 bytes
>  tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8428 bytes
>  tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8523 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 12980 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33837 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 9028 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 9054 bytes
>  tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18656 bytes
>  tests/data/acpi/x86/q35/DSDT.viot             | Bin 14612 -> 14679 bytes
>  tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35785 bytes
>  43 files changed, 34 insertions(+), 9 deletions(-)
> 


