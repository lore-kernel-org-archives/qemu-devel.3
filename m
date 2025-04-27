Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D746FC369D3
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 14:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u92p5-0002VT-77; Sun, 27 Apr 2025 10:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u92p3-0002VH-Tk
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 10:17:34 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u92p1-0005sn-OL
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 10:17:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1745763427; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YgrTw22p2Nbl2f0BemAqPXIu3XPUqLz1SSfZRpuj8nNtr+KAaoxmzJCcXjuAjYN6mX13HITomBlqKGPvtTVEAr4jJPEDOj8LHz+XlM2tNN+4ZLzoCnuO080fhqFeRSPVB4tj9zOVUaKkkue/wSPrcMXVe9aePRE6YpR3PbFQIHY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1745763427;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ktzXeDDldCrHsg+oyZMDHKVStkDAPY4HOV3pxFsIuFg=; 
 b=TIU942ybHa8PzpWFmBQ1oEuGB3hUwxZuI14o+jvIAeo+yMOyYovu1BPFQkh29rs6pW3b2twGh04qwqUkqGJQAK8woWXyAMFJ0FivQt1BT3MiX/P7zsDdq6dtt2qaLzazPDNwrmf+3tT6qITimRhgCB8XoP5jFw0pnHaPKESnrzY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745763427; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=ktzXeDDldCrHsg+oyZMDHKVStkDAPY4HOV3pxFsIuFg=;
 b=I4YWaVfPhjnD4rPxHrPVH4lax+5lCF5A9ngwud1bqwAZVH17y9c1a0blj/Im3/bO
 dR6LmbSuoWnjgY/BYXNmdzcmNiOfboKMhdvyWxdxZc9KPzH+yzIAyVOtyOHsK2KCDCN
 pGsFYLihS0Vc2VR//xLNBAEfVLkQxWPsVROF2bmI=
Received: by mx.zohomail.com with SMTPS id 1745763420491569.2022588417423;
 Sun, 27 Apr 2025 07:17:00 -0700 (PDT)
Message-ID: <03414f52-def8-4b50-8da4-69b722dfc758@collabora.com>
Date: Sun, 27 Apr 2025 17:16:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/10] virtio-gpu: Support asynchronous fencing
To: =?UTF-8?B?5YiY6IGq?= <liucong2565@phytium.com.cn>,
 Sean Christopherson <seanjc@google.com>
Cc: Jiqian.Chen@amd.com, akihiko.odaki@daynix.com, alex.bennee@linaro.org,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 gert.wollny@collabora.com, gurchetansingh@chromium.org, hi@alyssa.is,
 honglei1.huang@amd.com, julia.zhang@amd.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 philmd@linaro.org, pierre-eric.pelloux-prayer@amd.com,
 qemu-devel@nongnu.org, ray.huang@amd.com, robdclark@gmail.com,
 roger.pau@citrix.com, slp@redhat.com, stefano.stabellini@amd.com,
 xenia.ragiadakou@amd.com, zzyiwei@chromium.org
References: <20250310120555.150077-5-dmitry.osipenko@collabora.com>
 <20250410095454.188105-1-liucong2565@phytium.com.cn>
 <d0e9e72a-02bf-4f1e-abe0-6e8d0d089b29@collabora.com>
 <5514d916.6d34.19622831b11.Coremail.liucong2565@phytium.com.cn>
 <425ebb80-4348-46f3-878b-054800a8fe85@collabora.com>
 <f662c725-e40e-43eb-b155-2440cff34324@collabora.com>
 <2d6e3b03.bb9.1967717fa84.Coremail.liucong2565@phytium.com.cn>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <2d6e3b03.bb9.1967717fa84.Coremail.liucong2565@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 4/27/25 14:53, 刘聪 wrote:
> Hi Dmitry,
> 
> The virglrender patch can fix the virgl issue, but the native context still fails to run on my machine.
> I'm not sure if anyone has successfully run it on an ARM64 machine before.

Thanks for the testing!

> When running with Venus, the virtual machine can successfully run vkcube. However, when using the native context, a KVM error is triggered. Both my guest and host kernels are already updated to version 6.14.
> 
> Here are the commands and error messages I encountered:
> 
> ```
> phytium@ubuntu:~/working/virglrenderer$ /opt/native-context-v11/bin/qemu-system-aarch64 --machine virt,accel=kvm,memory-backend=mem1 -cpu host -smp 4 -m 4G -drive file=/home/phytium/working/ubuntu24.04-aarch64-native-context,format=raw,if=virtio -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=net0 -device virtio-net-pci,netdev=net0 -device virtio-gpu-gl,hostmem=4G,blob=on,venus=on -object memory-backend-memfd,id=mem1,size=4G  -display sdl,gl=on,show-cursor=on -device usb-ehci,id=usb -device usb-mouse,bus=usb.0 -device usb-kbd,bus=usb.0
> phytium@ubuntu:~/working/virglrenderer$ 
> phytium@ubuntu:~/working/virglrenderer$ /opt/native-context-v11/bin/qemu-system-aarch64 --machine virt,accel=kvm,memory-backend=mem1 -cpu host -smp 4 -m 4G -drive file=/home/phytium/working/ubuntu24.04-aarch64-native-context,format=raw,if=virtio -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=net0 -device virtio-net-pci,netdev=net0 -device virtio-gpu-gl,hostmem=4G,blob=on,drm_native_context=on -object memory-backend-memfd,id=mem1,size=4G  -display sdl,gl=on,show-cursor=on -device usb-ehci,id=usb -device usb-mouse,bus=usb.0 -device usb-kbd,bus=usb.0
> error: kvm run failed Bad address
>  PC=0000e2bcbbf31ab0 X00=0000e2bc9c3ae060 X01=0000e2bc7c02af00
> X02=0000000000000014 X03=0000e2bc9c3ae000 X04=0000e2bc7c02af14
> X05=0000e2bc9c3ae074 X06=0000000000000200 X07=0000e2bc7c02a8f8
> X08=00000000000000de X09=0000000000000200 X10=0000000000001000
> X11=0000000000000004 X12=0000e2bc7c0000b0 X13=0000000000000001
> X14=0000000000000020 X15=0000e2bc9e465f93 X16=0000e2bcad6a01f0
> X17=0000e2bcbbf31a80 X18=0000000000000093 X19=0000000000000060
> X20=0000000000000074 X21=0000e2bc9e46c5f0 X22=0000e2bc9c3ae000
> X23=0000000000000074 X24=0000c02241da83b0 X25=0000c02241da85a0
> X26=0000c02241da85a0 X27=0000000000000014 X28=0000e2bc9e46c5f0
> X29=0000e2bc9e46c610 X30=0000e2bcac809c38  SP=0000e2bc9e46c510
> PSTATE=20001000 --C- EL0t
> phytium@ubuntu:~/working/virglrenderer$ uname -a
> Linux ubuntu 6.14.1-061401-generic #202504071048 SMP PREEMPT_DYNAMIC Mon Apr  7 11:34:37 UTC 2025 aarch64 aarch64 aarch64 GNU/Linux
> ```

Alex Bennée reported the very same problem with KVM on ARM + native ctx
AMD dGPU in the past. You may try to add error messages to
virt/kvm/kvm_main.c of host Linux kernel to find from where KVM error
originates. Sounds like page refcounting may be not working properly on ARM.

+CC: Sean Christopherson

-- 
Best regards,
Dmitry

