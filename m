Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6CED3B7F3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT40C-0005gr-CS; Tue, 09 Dec 2025 15:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT40B-0005co-S0
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:08:03 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT40A-0001TP-6l
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:08:03 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779d47be12so54610255e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310881; x=1765915681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Dj/2XRkoHzovnFZPSCjdJXobTdNzLwo8MRe/JTlBu0=;
 b=wyVyo3yWzV352cbI2n96xv3qLGRbbCIrZfxVZr9ZBpoBvu2nzgS2xoviSaLRipr3MU
 gXtq1iZ/NBYoLHDExu7dNJ8a8OqpbAVb0ZrzOkRyW9tesIjLaKwujVKsPWT6tvDVMvJX
 +Vg85R8ixELP9TXJisZGgL2IJsIcravQlAE05SycSSMHK5vl1v/nft+tsnygeGnz2Agm
 d5eLC6bDjklmcbOJbqo3cEzuhvAFixAV8P4dJ2uZ/ycY3JhIE3KiuJ7UeRe/TqH24Gtu
 UqYXysU64/3iCW2YF5GR/AqPHINAJM9yRQArRHaGdMaF37oE6L+znj/V+IdwuTaVUmPN
 m4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310881; x=1765915681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Dj/2XRkoHzovnFZPSCjdJXobTdNzLwo8MRe/JTlBu0=;
 b=nT/xhIXXbO8Xo1OMrLCPKd2X5KeIo5iZMbzxu6B82x/Gd2rRW/PRqmy684XFoCEaFZ
 2i88AY64wIVgKxEw15XPK6PIGpvaV++KNDvIlfONXf0eSsguxSxzNlGxuRmF7wcUV0mB
 NzBPHpGRxeT/NGxhIkAApiyegkZme8gu0rcfwdhrOuBojesWrmOEUXqZmenNU08CggXp
 dvsVA5zZpaw6JjIiqbHIPbqWTn9B6Ad706UQCYMaPOLhdDEqGO76XmJAPBNaNEs3xneD
 hIrPqjgJNCio1Le94Ev8zBuLHDZMC2GU0laaqXHAKOMXCuW/Hd7dy7xVJ2xFny4otk9y
 nKxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7PJdxagqmnNK5lGga0CYAoMCzVCP6JLcr9qP3oOurKrQVhdFSwttUurz0fXuEuk3A7FBS2fsj1Ela@nongnu.org
X-Gm-Message-State: AOJu0YyooaV5nbtd9t+zA6Is8WnLeQSZmhUFZ/45PUftgs60Wa3kklrZ
 WfmDKv7O5rxOhYG+5gJzl77Og28kptF9+jgGUxn1cTBho9BQs6gUvI//MrjtN1RhvirSgtDJnmQ
 NeUXficc=
X-Gm-Gg: ASbGncu1p1aGhEA6yxuHU5N6xyggCS+mKmnboChewjAzGCYgj6C3lISArfZryN4mdrJ
 hAFevA4ThAb79F7A656/e+Uh/qdWXyad8dtzUzM80aGENNQ3j2sNewQ8aWp9TSjhJedUhMANPUL
 hEQw2B7zXbISl/yyjxi//mfDmQkLlIYSAWLHfZHKWs3wXtIZ7+l+MfBndoEnkbcJuBBoyJV9D2O
 extWCKiqaByruknG242hkeHa8HrfqkLC8VdXg4vkKeg1dBrHj+c85kbFzzC36sa7/txZvoLACns
 TsW61RpKphDba2LG9sCsykO1Rqe1VTve67CWuqG64tZAww64nE+OHyl6VwLIDvEzqXqKxNZ60QC
 Dnf/T+dt3lMj/vztjzu+JIMVAiC9CVXxOfgDp7+JL6q5UiqoiqTcEk/33+HvVbBweSuL9UO+mkn
 ai2CQFhXBse1N2NSk88oetrmlPwJbfIcg3Jq0Irr8sOPx9v1A7zI829Q==
X-Google-Smtp-Source: AGHT+IExJrzXiz8GyXMvMP7E0Qxhnl4WAEwpBnI0SI8dLavQEE40k1pu8gbgtA+2RMpjrTQ0rxc9mw==
X-Received: by 2002:a05:600c:4e8b:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-47a838586bbmr388875e9.27.1765310880703; 
 Tue, 09 Dec 2025 12:08:00 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d99dabesm24847235e9.5.2025.12.09.12.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 12:08:00 -0800 (PST)
Message-ID: <7db0dde6-e839-4ffc-b39a-17c9dc115f6c@linaro.org>
Date: Tue, 9 Dec 2025 21:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 03/23] hw/net/virtio-net: make VirtIONet.vlans an array
 instead of a pointer
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Lei Yang <leiyang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20251028074901.22062-1-philmd@linaro.org>
 <20251028074901.22062-4-philmd@linaro.org>
 <7798584d-e861-47b7-af52-2c2efb67a4de@proxmox.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7798584d-e861-47b7-af52-2c2efb67a4de@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Fiona,

On 9/12/25 13:15, Fiona Ebner wrote:
> Hi,
> 
> Am 28.10.25 um 11:19 AM schrieb Philippe Mathieu-Daudé:
>> From: Michael Tokarev <mjt@tls.msk.ru>
>>
>> This field is a fixed-size buffer (number of elements is MAX_VLAN,
>> known at build time).  There's no need to allocate it dynamically,
>> it can be made an integral part of VirtIONet structure.
>>
>> This field is the only user of VMSTATE_BUFFER_POINTER_UNSAFE() macro.
>>
>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Tested-by: Lei Yang <leiyang@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> Message-ID: <20251023135316.31128-2-mjt@tls.msk.ru>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> unfortunately, after this commit, loading a VM state taken with v10.1.2
> or older doesn't work anymore:
> 
>> qemu-system-x86_64: Missing section footer for 0000:00:13.0/virtio-net
>> qemu-system-x86_64: Section footer error, section_id: 41
> 
> Reproducer below [0].
> 
> 
> Reverting
> 
>> 58341158d0 migration/vmstate: remove VMSTATE_BUFFER_POINTER_UNSAFE macro
>> 3a9cd2a4a1 hw/net/virtio-net: make VirtIONet.vlans an array instead of a pointer
> 
> in current master makes it work again.

Thanks for the report. Commits reverted.

> 
> 
> I'm also seeing the following when a guest is actually running:
> 
>> kvm: VQ 1 size 0x100 < last_avail_idx 0x9 - used_idx 0x3e30
>> kvm: load of migration failed: Operation not permitted: error while loading state for instance 0x0 of device '0000:00:13.0/virtio-net': Failed to load element of type virtio for virtio: -1
> 
> and here too a revert of the two commits seems to help :)
> 
> 
> Best Regards,
> Fiona
> 
> 
> [0]:
> 
>> [I] root@pve9a1 ~# cat snapshot-virtio-net.sh
>> #!/bin/bash
>> rm /tmp/disk.qcow2
>> args="
>>    -netdev type=tap,id=net1,ifname=tap104i1,script=/usr/libexec/qemu-server/pve-bridge,downscript=/usr/libexec/qemu-server/pve-bridgedown,vhost=on
>>    -device virtio-net-pci,mac=BC:24:11:32:3C:69,netdev=net1,bus=pci.0,addr=0x13,id=net1
>>    -machine type=pc-i440fx-10.1
>> "
>> $1/qemu-img create -f qcow2 /tmp/disk.qcow2 1G
>> $1/qemu-system-x86_64 --qmp stdio --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 $args <<EOF
>> {"execute": "qmp_capabilities"}
>> {"execute": "snapshot-save", "arguments": { "job-id": "save0", "tag": "snap", "vmstate": "node0", "devices": ["node0"] } }
>> {"execute": "quit"}
>> EOF
>> $2/qemu-system-x86_64 --qmp stdio --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 $args -loadvm snap
> 
> 


