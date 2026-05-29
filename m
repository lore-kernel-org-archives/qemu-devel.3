Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA072CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 13:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwsa-0006T6-Go; Fri, 29 May 2026 09:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wSwsX-0006Or-QQ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wSwsW-0001Mp-B0
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780059835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k0h/e48HKzK8qaSEuhnE2gETMlM29GhONx96gOKhjY0=;
 b=GvNJRM4/fgSeOEJCxkK0Cb0/3XpGqi4QwC84rNIDyeCdR6Ot4kUMJj3oYgji99d5F+L5TQ
 pvcDmaZN1Wcv20fJ7Yh5NFt11S2EiQ9YNRPqpwFqxje2L9fzo+cPlsIYMGMGWYy4lrF5cd
 25CGYldkro3kQLkCi4WCYXAJaRiX5RY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-8u5kKg7VNqSmHzZSYQQ6IQ-1; Fri, 29 May 2026 09:03:50 -0400
X-MC-Unique: 8u5kKg7VNqSmHzZSYQQ6IQ-1
X-Mimecast-MFC-AGG-ID: 8u5kKg7VNqSmHzZSYQQ6IQ_1780059829
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49050c44bcdso80200185e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780059829; x=1780664629; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=k0h/e48HKzK8qaSEuhnE2gETMlM29GhONx96gOKhjY0=;
 b=RAXp8IpgXcLJBw0QDL6Wz5kXOFBNUqm5PF21IS+kwnn2skcwI9GYKdgz9W25TGkAKv
 ZcvL4y9L+7mgq9KmKdss4h2w1Y0GZDCgJzLz2PsB4pU9Qh+zwv4u/LYzDqudwGyKZOyI
 FA8HtyErHTlQis9yeIL+//HQvyhW2ctcGFiOkXHZAJzeF+B9GBCuWyBCvL2xDvnCRSsT
 0OHOCgv3/+haNNx+rHN7pHwHOp7GTPG/7o6EpGF8S7Dd9uz01wcgKSuNYpwbvHbchqk9
 QWCYiMMFEYqiUR/e1SYARGIOuUVrB6ZiYNyhaNjD+Li7G2NrsR2uTgT4wexK3tiphw+i
 fneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780059829; x=1780664629;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k0h/e48HKzK8qaSEuhnE2gETMlM29GhONx96gOKhjY0=;
 b=eIiiCLfAbC6NvoqvjgRSmtavFDJjf9kO6bb60MVfLp2QwjlS1lBtdoAMEPCtp5K6O9
 rZmXJtOY0LDeeZRrRHAnK4NkRn36IrMHA+0qhXL6mzCGLzmtNrRs2sxqcM3yf6F6h0or
 TW1rc/uYwkq4RgMUdVfVMvLSW59Xt2tlxHA7Y7w3mumSyca0JXvuG5JBtk5azIwRzoRJ
 Atj+ceYuBdBg2J++AzXSN0+eCOXWpBEgxlWQsusiSxovM91027a1IS9n+RNWyQXALF35
 b733NkiyoQSYjT0OKqpgAG1JnVD2wtHi0xK5Umg2LX8FswJ4KHa+8OndQwwSKmFtNQVS
 ADkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wM638IKQ9ZtRz1LaGU6z5wze62ANUnYzHX7kl++omNPyYmNKkCd7SN254DJjLUsKpbsUPi4LjpyrM@nongnu.org
X-Gm-Message-State: AOJu0Ywxa3RT96yMhHhzXQ/VzkokarOcsuaimwzCEZLFAN4+xN+TOyn2
 0VovnuNQMBZ1x2E3hol7Tk8YPtvrUoZ5wTWZ/DlNk7wZOjkvbpItW1aM4BtgAPV09XnuZUuSfnv
 yq2qGLD2N2kL1I+TakQHKVglqGAgcdw04AlylZUlitEcbZs8pIi+ih+d9
X-Gm-Gg: Acq92OHkdMiGqiYsBi6GyPvOA4jkrf0DGN1DLjc/a5qefIABHimOezU+jCO9NYBFsMz
 YZ05icLu0qrlwfzSp4vvEnaFQXRvUt4c49Y/MkArUj7JNke3tzeH7+UQ51IngpkcjxOVofGEMPP
 TBXTSt5R/h+ylBwp1RgyYCDXF29t7ME85qAqi7msgj439SOVj5gWMhj2AzThr7JY9vijp0FJ0CO
 GaeBuOJUNo9Oy1thvqyrpvYPNt7vW6oYx+cqMqJhFlDoemX/SXk4N1mBQmWHkaJlKzps+iel5po
 fd81c5KgpBktQD6g0tzDLgtuzx42pRuTPwtMx/PrAcZIQKaTbQ6yq6BNw/aJX4LhKALc0QrQ0X0
 RYY/n954/1xGGxo3WVhM63t1bG6juXdZ7zj08fIsiLu7byFVC8aoalc+mABlJfdJ5m2bmDjdugd
 th7nKWPg==
X-Received: by 2002:a05:600c:1c0d:b0:490:45bb:8dd8 with SMTP id
 5b1f17b1804b1-4909c0e02c1mr57151415e9.25.1780059829233; 
 Fri, 29 May 2026 06:03:49 -0700 (PDT)
X-Received: by 2002:a05:600c:1c0d:b0:490:45bb:8dd8 with SMTP id
 5b1f17b1804b1-4909c0e02c1mr57150705e9.25.1780059828738; 
 Fri, 29 May 2026 06:03:48 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cabfd6esm45521605e9.15.2026.05.29.06.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 06:03:48 -0700 (PDT)
Date: Fri, 29 May 2026 15:03:46 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
cc: mst@redhat.com, Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/virt: preserve config for ACPI PCI hotplug
In-Reply-To: <CAFEAcA-PkO3aeGoaAzpbJGrrE-_-RjJy9Q4D4MnQ=9W61--3hA@mail.gmail.com>
Message-ID: <48595a74-78b5-6136-8752-0a73501b9531@redhat.com>
References: <0de640a2-8807-69cf-4429-672263e3e759@redhat.com>
 <CAFEAcA-PkO3aeGoaAzpbJGrrE-_-RjJy9Q4D4MnQ=9W61--3hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 28 May 2026, Peter Maydell wrote:
> On Thu, 28 May 2026 at 10:23, Sebastian Ott <sebott@redhat.com> wrote:
>>
>> ACPI PCI hotplug of a PCI device using a bar > 2M fails on ARM
>> with a resource allocation failure in the guest kernel (Linux):
>>
>> qemu-system-aarch64 [..] -device pcie-root-port,id=rp1,bus=pcie.0 \
>>                     -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on \
>>                     -pflash /usr/share/edk2/aarch64/QEMU_EFI-silent-pflash.qcow2
>>
>> (qemu) device_add pci-testdev,bus=rp1,membar=4M
>>
>> [   55.106283] pci 0000:01:00.0: [1b36:0005] type 00 class 0x00ff00 conventional PCI endpoint
>> [   55.107627] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00000fff]
>> [   55.107864] pci 0000:01:00.0: BAR 1 [io  0x0000-0x00ff]
>> [   55.108015] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x003fffff 64bit pref]
>> [   55.118609] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: can't assign; no space
>> [   55.118653] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: failed to assign
>> [   55.118671] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: assigned
>> [   55.122828] pci 0000:01:00.0: BAR 1 [io  0x1000-0x10ff]: assigned
>> [   55.127090] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: releasing
>> [   55.127098] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: can't assign; no space
>> [   55.127102] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: failed to assign
>> [   55.127106] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: assigned
>>
>> This behavior is exactly the same on x86 - except the busses are created
>> with a default window size of 256M there. If the PCI devices being
>> hotplugged use a bar > 256M you get the same failure like on ARM.
>>
>> The workaround on x86 is to specify "pref64-reserve=" for the PCIe
>> root-port. On ARM this is currently ignored.
>
> From the perspective of somebody who doesn't know much about
> ACPI or PCI, this commit message doesn't really tell me why
> QEMU needs to change. The above reads like "this is a kernel
> problem" to me. Why is the kernel unable to allocate this BAR?

Lack of resources on the parent bus/bridge device - the bridge windows are
2M per default on ARM. The native PCIe hotplug controller would add the
additional resources to the parent bridge and retry allocation. The
ACPI PCI hotplug controller does not do that. I'm curently playing with
a hack that adds this to acpiphp.

Sebastian


