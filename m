Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81855CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waClj-00035k-9Q; Thu, 18 Jun 2026 09:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1waClf-00030H-Jm
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:26:53 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1waClb-0004c0-5z
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:26:48 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8F2B13FA70
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781789204;
 bh=XhHqIce4YmfjfDl7IyTM/2KqBTFzJ4CYn9v00QTAhMQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=GlwaZJ3HWoQv2Oh5oTj+ITStE0qi4+QQ5murzYSVZFA3nofTcLWSaxpQ1DRpXUJrR
 ckcpr6aSMEUSGezVCU7YPLqSejHz9u6cB43ti/Ha+zGTo9pYNDHbWyRKW/VSiGCQzh
 6lo6zPhAKhlgCAvPU6sPPR9y+nhriFa6yorAAohmAkzVTiB3eO9sPNwm6du4YaeI4Z
 +9vVSL8WuUvMVagQG92KhrEPnCsG/VEE+Ls6LW/VAiTS5zcJuPa75itOTY8Gcv7WFX
 lBrjqB1GMVjIBcQ48zZDaXI9lAGdMosUDq1cx1BXUIoDpaGiDXiYf2wl2XJwr0ZKcK
 2B+3396b2f4C5UqbH5hbdsZQHnVp0/cw6gfAxTiklRreLUyfssIIzEnPkVspBTn0sG
 Ud+KYOPIoNPgHhaRTN42N0fo/rl+K0beDtrtA6xQLacPPbcOMs8xY3HLCUTmOOPA6/
 3oh2HUopDmfoZ7sqayynPFv8AFZRAUnN83rYAbhcfka2erF1hgk9sify9nG4ugc6o0
 7P3vOi+goJdybgLGFhVIdaXFFX9X2QvOStYDBRP6WSxUWeh6D/sjKj7XE+m+LJ3dk1
 yKGpRbmJkT86dcdoZUdbFHIbUYGkwD8FsZT1+42ELfTYIy/ciKVtR8QKxjsqLtHs2R
 QDysKiaDWm+t7wG83OQy+QPw=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4625e71d3ccso1339258f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 06:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781789204; x=1782394004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XhHqIce4YmfjfDl7IyTM/2KqBTFzJ4CYn9v00QTAhMQ=;
 b=ryLtCVwhglqokJanBkRcukyzr+FYc65fNwwqlq76rxsIZZCpAGBuUwHT4aa3vKM3Pd
 /4xN/kCYssPv/m28e/fk+VTe2Bn120VSau1gv9hH+EDnIDa9H/LKDHYY6lktLvwrrmCT
 3BN8dMynvneF0p76FgDzNcooOGZ0blr5xPGHtfG9SBhGH2eD/vQrvcN3im/q7K/Ef2x/
 fhji4Rh2GcIUp4i6wME26UQcY7Jg7dv2lNn5sGeusIRFtPih22xYkKOzpwoc97ziNABy
 kKz3HiZSUsNbGgNgNIpFLdbGaJ6ZxHkHFcKLQx02KtaviY2OCm/TjN3zTXyM6/W1M1ed
 YYxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wtmYfDqw2+W3KRRD3asNSMNlHcCe3hQMZBLxmwLFU1tyFbhGfWPZBEwMeVoaNQM+fVaS9SWFrIH/Q@nongnu.org
X-Gm-Message-State: AOJu0YweVg1TEMt7EYvacdTsrA0R59Ldss188VLYHh/3rRBrWNgscsSW
 N5bfjmcViuFZSVSqm4C1T+ONLuC3cWY0ta0SpIkItZBtnoRjbfJN+FUEUWjc5TgEBJ01/+hlU4M
 tHn5c6Iit7/oXq17+mC8w7yIz7noyKkY7zTLuQqts40/zSsVDYD/1M1GCXSwQlVjqx32Ca538
X-Gm-Gg: AfdE7cn+4c1BQPuHf5KZRs9LvawFcKIMhLCv64aff+Kv9HT9nxTkEQy8uQHz3zDbXUZ
 yH43Rx9xQSFfErsm314oM4hSULpMcXAjjtsZN0Y/ywFpp5qbrXHAuZl1Z98QG6yk5VajLFbdRIh
 fiSQrWgB/iTSoDcijGNx06S8WOKTrDEaO2TSx7TrRiejiVRJq+9mDEv6D1c+RKVmYG3S9XSNCuf
 T7nm++QdXcdBFKdbfvostquYEz6shVaXbTlwiCbKZ/vC1za/kyhGKtos/OjbbnxeHW+C71VsX1l
 zK/P6Br3BUlelkp/YYFiiOKcegpTl0FWXyChDuhNOHcoMdpwTxN6C+rPiNa+Tad1BRQvWePpDK1
 wy0eNLDfFLQIVjSY/2U2XAMHuskntPTIZJJNVAN0Z0NDhw5umjDIo72xxxJEPILGRy/Bav0cFdf
 mWNvS6iq1xhdJgEPuk4zw2RcVhhe6nlwx7zw==
X-Received: by 2002:a05:600d:11a:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-49238166e54mr39368395e9.6.1781789204055; 
 Thu, 18 Jun 2026 06:26:44 -0700 (PDT)
X-Received: by 2002:a05:600d:11a:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-49238166e54mr39367865e9.6.1781789203461; 
 Thu, 18 Jun 2026 06:26:43 -0700 (PDT)
Received: from ?IPV6:2a02:3035:61d:4f84:7003:6a6a:d834:66f5?
 ([2a02:3035:61d:4f84:7003:6a6a:d834:66f5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4ff67sm257375275e9.6.2026.06.18.06.26.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 06:26:42 -0700 (PDT)
Message-ID: <5032057d-278c-4afa-987a-a25335dff50a@canonical.com>
Date: Thu, 18 Jun 2026 15:26:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] hw/acpi: correct field sequence in SPCR table
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260618124020.640794-1-heinrich.schuchardt@canonical.com>
 <20260618084645-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260618084645-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/18/26 14:48, Michael S. Tsirkin wrote:
> On Thu, Jun 18, 2026 at 02:40:20PM +0200, Heinrich Schuchardt wrote:
>> On LoongArch and RISC-V invalid SPCR tables are created:
>>
>> Terminal Type : 00
>> Language : 03
>>
>> The correct values are:
>>
>> Terminal Type : 03
>> Language : 00
>>
>> This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
>> SPCR creation to common location") that swapped the fields.
>>
>> See the specification of the table in
>> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table
>>
>> This page shows version 1.10. But the sequence of the fields was not changed
>> since version 1.0.
>>
>> Our LoongArch and ARM code uses version 1.07 of the specification.
>> Our RISC-V code uses version 1.10 of the specification.
>>
>> Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location")
>> Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
>> Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> Thanks for the patch!
> Yet something to improve:
> 
> That's not the way to submit expected table changes -
> it would prevent backporting and rebasing.
> 
> Pls follow instructions in ./tests/qtest/bios-tables-test.c
> 
> Thanks!

I tried it. But it does not work:

After running all tests successfully with make check the script
/tests/data/acpi/rebuild-expected-aml.sh
told me that I should run make check.

That did not make sense to me.

I there a specific configuration needed to let make check write what 
rebuild-expected-aml.sh is looking for?

I was using

   ./configure --prefix=/usr/local --static 
--target-list="riscv64-linux-user"

and

   ./configure --prefix=/usr/local --static 
--target-list="loongarch64-linux-user"

Best regards

Heinrich

> 
>> ---
>> v3:
>> 	update test data
>> v2:
>> 	Mention the different specification versions used by our code
>> 	https://lore.kernel.org/qemu-devel/20260326144835.67911-1-heinrich.schuchardt@canonical.com/
>> v1:
>> 	https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
>> ---
>>   hw/acpi/aml-build.c                   |   4 ++--
>>   tests/data/acpi/loongarch64/virt/SPCR | Bin 80 -> 80 bytes
>>   tests/data/acpi/riscv64/virt/SPCR     | Bin 90 -> 90 bytes
>>   3 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 9b3cdd3781..990abc64cd 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -2144,10 +2144,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
>>       build_append_int_noprefix(table_data, f->stop_bits, 1);
>>       /* Flow Control */
>>       build_append_int_noprefix(table_data, f->flow_control, 1);
>> -    /* Language */
>> -    build_append_int_noprefix(table_data, f->language, 1);
>>       /* Terminal Type */
>>       build_append_int_noprefix(table_data, f->terminal_type, 1);
>> +    /* Language */
>> +    build_append_int_noprefix(table_data, f->language, 1);
>>       /* PCI Device ID  */
>>       build_append_int_noprefix(table_data, f->pci_device_id, 2);
>>       /* PCI Vendor ID */
>> diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
>> index 3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d..7bb819cd0d2ad20269e40e4a738709a45260cbb2 100644
>> GIT binary patch
>> delta 23
>> TcmWFtm|!Qw%<vxw7?1z}S|J61
>>
>> delta 23
>> TcmWFtm|!Qw!2BNw7?1z}S{?;}
>>
>> diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
>> index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd0294c18bc6301e208a 100644
>> GIT binary patch
>> delta 10
>> Rcma!wnqbGo%rMbG3IGpM0&@TW
>>
>> delta 10
>> Rcma!wnqbGoz&z1G3IGpJ0&@TW
>>
>> -- 
>> 2.53.0
> 


