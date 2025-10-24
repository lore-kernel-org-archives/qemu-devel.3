Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDCACCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBiE-00077v-O8; Fri, 24 Oct 2025 02:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vCBi8-00077T-Th
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vCBi5-0006cQ-GH
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761288934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qk/1K0avWi1fwiLFQ6xtzNkb1QuApfY9mW8p4gvIfN4=;
 b=CT4IXtGS8dFIUKMFcbIp1HwGJQcVkSj2o4vA7p+tRdYAJsfB87LxjmsjMU3Fia6wzHFo4B
 E8VINmbvGoXr8oybRyMuoFJ0J3uPQQNFj1dSi0ZE3n2BfCLElr9HN1kkUy7b8LYU8Cbgpp
 22hq+lrltF3d49RaLMmEQW4VtpASo8k=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-XkSScXFUPf2vt2EfjxCfVA-1; Fri, 24 Oct 2025 02:55:32 -0400
X-MC-Unique: XkSScXFUPf2vt2EfjxCfVA-1
X-Mimecast-MFC-AGG-ID: XkSScXFUPf2vt2EfjxCfVA_1761288931
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-33bb3b235ebso3861891a91.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 23:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761288931; x=1761893731;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qk/1K0avWi1fwiLFQ6xtzNkb1QuApfY9mW8p4gvIfN4=;
 b=Q/x/UcOt6lkWLORdNOOeBo8DyF99a0Joz06wm/9BY3Uza4uwsGVq+11n7GmTdSz/nE
 LwIFaVpEdgl722Cwt7sRkPChffer3NQs6aqSIHttyOJXixNNihnThrw3r0oVovLlCYYQ
 uva/m4RzGiZNCyRaGGO2m+TLMiNasVCBT026X0mWh3UZl9PcLqOhKE9nhDEBuY7p2asE
 6owg88vLfeTYrvHH5IE+3VxrEgtLOCSuLw2RuSHDW8RJ06e7n4IZe5dMD3CbomMuuas3
 N1EejpU65DXOtmNPcExqHj9LNwD+tRKxdqnuE5iG0nrBqY+IwKVu2gutnkzDHcNhpcxr
 eOSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5Kf755bfRgUTdZx/1Q+XcA+Qke2UqAe/y6Jm2r7P1Au/970+iIV+O1+bjqYwpxMiyzBRbEczWyDcZ@nongnu.org
X-Gm-Message-State: AOJu0Ywvg8E4FsDE6DlrcV1zLVQx+dS1paPADlxiNtth/IKrdqv4hbPG
 d7MSSAMNmbL2BcfYqqiynoIXsnTT/eUFs+ywVV5v2iQ8PcmQ7bVMpuhwaaBfB0GTj/+PO1lfeYI
 dVpbOK50lAeh0sxpXQTRgcUBpfbzMIxrURYrtUif5yOtSqsaEUs8Q33Jf
X-Gm-Gg: ASbGncsWo8W2LBDbQ6DPGEZsW6hhcs9SO9+vwoPrQ64Z0hnFqvTjE5bXBdG1e2FlQHB
 zCV3kUwZry3U1iqCoLSizNrac8tNTnw4iPBZRagbrAQYibZXxEVrC5iKm/ZiWp2hRj1BvVl8eCg
 Ax85ADI0ZX38C7oYXhL0tHYJh26x4sP5o2M3qVR2hobaENv6XZ4bJj+YxBl3pmsI4u9P195dmam
 19XvLJ4d3ZrgS1RyX/HkzO1FD93Ep2fNzexOQW+AZpZPYzRB/eEPFGvboZ0o07hS+u/1cv2C/uQ
 wUblU0/MPTxYPwIF5nh36MCbqlnPsoRy6n8ZGeEZbIUb7QHHjFNO2rB/dFy995NZVeO7+RuzcCH
 ELqmX00u+gG6EP7J/SAvKDZOHkCo6fVRaSEUI4Ew=
X-Received: by 2002:a17:902:cec6:b0:27e:f201:ec94 with SMTP id
 d9443c01a7336-2948b98294amr18185395ad.18.1761288931189; 
 Thu, 23 Oct 2025 23:55:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgef95mK+Ki2hx1NleNTDyL0rmdqa3EraCCc9f9J5a/5oLh2Z4mfb5VfE8OmNXFAdv4TGihQ==
X-Received: by 2002:a17:902:cec6:b0:27e:f201:ec94 with SMTP id
 d9443c01a7336-2948b98294amr18184875ad.18.1761288930747; 
 Thu, 23 Oct 2025 23:55:30 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946ddee569sm44681375ad.31.2025.10.23.23.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 23:55:30 -0700 (PDT)
Message-ID: <f6c6abf0-e57c-4f67-9289-371196d062a5@redhat.com>
Date: Fri, 24 Oct 2025 16:55:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V6 00/24] Support of Virtual CPU Hotplug-like Feature
 for ARMv8+ Arch
From: Gavin Shan <gshan@redhat.com>
To: salil.mehta@opnsrc.net, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, imammedo@redhat.com,
 armbru@redhat.com, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <b1c0a0a8-3b94-47ee-ab8b-e42099f3f1a8@redhat.com>
Content-Language: en-US
In-Reply-To: <b1c0a0a8-3b94-47ee-ab8b-e42099f3f1a8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Salil,

On 10/22/25 8:07 PM, Gavin Shan wrote:
> On 10/1/25 11:01 AM, salil.mehta@opnsrc.net wrote:
>>
>> ===================
>> (VII) Commands Used
>> ===================
>>
>> A. Qemu launch commands to init the machine (with 6 possible vCPUs):
>>
>> $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3 \
>> -cpu host -smp cpus=4,disabled=2 \
>> -m 300M \
>> -kernel Image \
>> -initrd rootfs.cpio.gz \
>> -append "console=ttyAMA0 root=/dev/ram rdinit=/init maxcpus=2 acpi=force" \
>> -nographic \
>> -bios QEMU_EFI.fd \
>>
> 
> The parameter 'disabled=2' isn't correct here and it needs to be 'disabledcpus=2'.
> Otherwise, the VM won't be started due to the unrecognized parameter.
> 
> $ /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64       \
>    --enable-kvm -machine virt,gic-version=3 -cpu host,sve=off    \
>    -smp cpus=4,disabled=2 -m 1024M                               \
>    -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image \
>    -initrd /home/gavin/sandbox/images/rootfs.cpio.xz -nographic
> qemu-system-aarch64: Parameter 'smp.disabled' is unexpected
> 

Apart from the issues that were reported previously, there are more issues.
some of them may be invalid. I'm sharing the extra issues below.

The VM is always started using the following command lines.

host$ /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64               \
-accel kvm -machine virt,gic-version=host,nvdimm=on                         \
-cpu host,sve=off                                                           \
-smp maxcpus=4,cpus=2,disabledcpus=2,sockets=2,clusters=2,cores=1,threads=1 \
-m 4096M,slots=16,maxmem=128G -object memory-backend-ram,id=mem0,size=2048M \
-object memory-backend-ram,id=mem1,size=2048M                               \
-numa node,nodeid=0,memdev=mem0,cpus=0-1                                    \
-numa node,nodeid=1,memdev=mem1,cpus=2-3                                    \
-L /home/gavin/sandbox/qemu.main/build/pc-bios                              \
-monitor none -serial mon:stdio                                             \
-nographic -gdb tcp::6666 -qmp tcp:localhost:5555,server,wait=off           \
-bios /home/gavin/sandbox/qemu.main/build/pc-bios/edk2-aarch64-code.fd      \
-kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image               \
-initrd /home/gavin/sandbox/images/rootfs.cpio.xz                           \
-append memhp_default_state=online_movable

[Issue-1]: Inconsistent output from 'qom-list /machine/unattached'. The disabled
CPU device doesn't show up at the beginning, but it appears after it's hot added.
However, the CPU device is still seen after it's hot removed.

(qemu) qom-list /machine/unattached
device[0] (child<host-arm-cpu>)
device[1] (child<host-arm-cpu>)
   :
(qemu) device_set host-arm-cpu,socket-id=1,admin-state=enable
(qemu) qom-list /machine/unattached
device[0] (child<host-arm-cpu>)
device[1] (child<host-arm-cpu>)
device[42] (child<host-arm-cpu>)
   :
(qemu) device_set host-arm-cpu,socket-id=1,admin-state=disable
(qemu) qom-list /machine/unattached
device[0] (child<host-arm-cpu>)
device[1] (child<host-arm-cpu>)
device[42] (child<host-arm-cpu>)

[Issue-2]: The hot added CPU disappears after a system reset

guest$ cat /sys/devices/system/cpu/online
0-1
(qemu) device_set host-arm-cpu,socket-id=1,admin-state=enable
guest$ echo 1 > /sys/devices/system/cpu/cpu2/online
guest$ cat /sys/devices/system/cpu/online
0-2

(qemu) system_reset
guest$ cat /sys/devices/system/cpu/online
0-1

[Issue-3] PCDIMM is unable to be hot added.

(qemu) object_add memory-backend-ram,id=hp-mem0,size=512M
(qemu) device_add pc-dimm,id=hp-dimm0,memdev=hp-mem0,node=0
Error: Parameter 'driver' expects a pluggable device type or which supports changing power-state administratively

Thanks,
Gavin


