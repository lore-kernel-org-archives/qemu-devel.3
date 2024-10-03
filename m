Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D034CF34A0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 11:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swKJZ-0006Tr-LC; Thu, 03 Oct 2024 07:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1swKJX-0006TI-5b
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1swKJV-0006NM-IG
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727956085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a1acHY6fh6+wqHRLFAYFWoikOwNPLODXkcHHMjYb79k=;
 b=gT/A5q1TgUt6Q6n5TzvxQTRMuaqqkyCtI5w5FYoZeUrtE6eSoHE3QphxwxCdEo/MZ+wEIa
 0v8qJAPxnZS3YIK09ziW8BU3nvebIXSkYjzhQrWC2uT541/iPqWrY2V2FOXNvFg6s+Muek
 LIaoJAB7cnFNi1mfHW9DBpI4Z9reOW4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-f0o2BLqBNcyAXbaSZ7YuEg-1; Thu, 03 Oct 2024 07:48:04 -0400
X-MC-Unique: f0o2BLqBNcyAXbaSZ7YuEg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2fae0ab58ceso6586341fa.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 04:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727956083; x=1728560883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1acHY6fh6+wqHRLFAYFWoikOwNPLODXkcHHMjYb79k=;
 b=j/VuYRCGNLvvbR8xqvdBpYQ8FZ4oLgsMN0R9007lQzdRIWnIAYaT1dSlaA4Q/Wkmbk
 FUnL/dQIJ0FFThNg7KJhdzDu9ql5eLYAwyaGfOpLHRYJr5oRJcFG6fxG5UeDWeZnhcLV
 Io86lgT3qz55qZSZeoEQVRikE8Inl6jBqv7Z9gpNHfFp1AArUV0UqM7E5APnXuL63yEg
 NBYVbLhqvugigFTG4wMR3osJDc3IK1acaFQkvoCJFvaP/+inb5kLNpqnCznH2dpUw1cL
 nDleYvBoRuCywPL8N1bZugKCxbA5vkdmMsGE49BPiAplWw0IbYy5m7O3p9Dk1L5nDSuq
 vqmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhQ0eKmoUYGmMoHbTWr9mfqhMoRlHZxPXvegluplavtwXRln2DZjBObFfKKuHuV5rQ2tm7/erMsVX4@nongnu.org
X-Gm-Message-State: AOJu0YySiLZxUTQiN1ULalA7vAyj89mAhAVYtVkgCt8LrbcIr3hK89iI
 XICNdPjSTkmQt8XRb/SfrB8DtWPorq9CyAbnHuI4Szj1ap+PqA8qgTAj4h5Ue06AiBZxlKXsT9D
 ZktrYTA0qj85xrwnBehxwmfjW2UicDLhJ1UH8+opJ0If7RYPXVlPv
X-Received: by 2002:a05:6512:350f:b0:539:a2e0:4e75 with SMTP id
 2adb3069b0e04-539a2e0508fmr2226741e87.14.1727956082986; 
 Thu, 03 Oct 2024 04:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErMqTvniZWUJgTcWjpTv72/Ut5ohGDdLBrF2AydGMn3+68wsnUhYgSCLZeIGj+IBg0k74CQg==
X-Received: by 2002:a05:6512:350f:b0:539:a2e0:4e75 with SMTP id
 2adb3069b0e04-539a2e0508fmr2226735e87.14.1727956082495; 
 Thu, 03 Oct 2024 04:48:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f8025b414sm13701945e9.15.2024.10.03.04.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 04:48:01 -0700 (PDT)
Date: Thu, 3 Oct 2024 13:48:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 01/12] acpi/ghes: add a firmware file with HEST address
Message-ID: <20241003134800.72aff741@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241001105426.48598baa@sal.lan>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
 <34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
 <20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
 <20240913074435.0eea2552@foz.lan>
 <20240913152518.2f80ab1e@imammedo.users.ipa.redhat.com>
 <20240914073314.46368ff6@foz.lan>
 <20240916130506.293ab543@imammedo.users.ipa.redhat.com>
 <20241001105426.48598baa@sal.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 1 Oct 2024 10:54:26 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Mon, 16 Sep 2024 13:05:06 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > > But no idea how to start a machine using a saved state.    
> > 
> > see https://www.linux-kvm.org/page/Migration
> > 'savevm/loadvm to an external state file (using pseudo-migration)' section
> >   
> 
> It didn't work. Is migration currently working between 9.1 and 9.2?
> 
> I did a compilation of qemu version v9.1.0-rc0 and saved the state.
but it's better to use actually released 9.1 source code.
that should be effectively virt-9.1 machine type
(unless something changed between rc0 and release version)

show us CLI on source side (i.e. qemu instance where you saved state,
it should be the same as below modulo '-incoming' option)

> 
> Then, on vanilla 9.2 (changeset 01dc65a3bc26), I tried to restore the
> state with both "virt" and "virt-9.1". None worked:
> 
> 
> $ qemu-system-aarch64 -m 4g,maxmem=8G,slots=8 -M type=virt-9.1,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 --nographic -monitor telnet:127.0.0.1:1234,server,nowait -incoming "exec: gzip -c -d statefile.gz" -no-reboot -bios /new_devel/edac/emulator/QEMU_EFI-silent.fd -kernel /new_devel/edac/work/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=/new_devel/edac/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'
> qemu-system-aarch64: error while loading state for instance 0x0 of device 'cpu'
> qemu-system-aarch64: load of migration failed: Operation not permitted

and that should've worked

 
> $ qemu-system-aarch64 -m 4g,maxmem=8G,slots=8 -M type=virt,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 --nographic -monitor telnet:127.0.0.1:1234,server,nowait -incoming "exec: gzip -c -d statefile.gz" -no-reboot -bios /new_devel/edac/emulator/QEMU_EFI-silent.fd -kernel /new_devel/edac/work/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=/new_devel/edac/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'
> qemu-system-aarch64: Machine type received is 'virt-9.1' and local is 'virt-9.2'
> qemu-system-aarch64: load of migration failed: Invalid argument

that isn't meant to work.

> 
> Did I made something wrong?

let's see src CLI first, and then ask someone who knows more about migration and how to troubleshoot it

> Regards,
> Mauro
> 


