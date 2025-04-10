Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AA1C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 22:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2zw3-00017V-Cb; Thu, 10 Apr 2025 17:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u2zw2-00017M-CV
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:59:46 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u2zw0-0003Z9-CS
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:59:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1744322361; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Vo8J7RX6eYPAhsL+QdKWa8PhFgv05qZ+KozP0V8Na3oigjY7Sv/hgQOwdLOmahhDF4Q8mcx901i6/OS0u7uiNXXhoqpvcz3Z2134VL9cSmhm4VM18qxeponPdaC7C1oKsYR7YzgGS9RlCKgEfvAY7r1kCbUCoiUjOsTdiyCsA68=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1744322361;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7nONUep5bnSOMiWWHwTvNyTSKC3sukLroyF3KuAylkw=; 
 b=N4bLEv5N1r3+jYq5zjNnvDXhZz6rFjTvMI/TcSaUn7sJkR4K6TWx1HwO3KMwuuWjnGhnQZVrlg20BRjKcM3l9VG6UrOdIlFDEaLr08nFaqzRDlILMwxnMSV0UCsYTj6AEVtkKBYby+7FYr5KgMKKJT/7Gyo+gftEnV3OxlpAeno=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744322361; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=7nONUep5bnSOMiWWHwTvNyTSKC3sukLroyF3KuAylkw=;
 b=h7kKShi2uPuQp1WSTZBTYZzdoPzIU9YEuAuuh6KajGHSS7gpNRpf5GsPkApslu9z
 ptPuIzIxx7KLMoVxfBlsDJqsPNMlEHdtu7p7qzUC+9/4dU6qHK/eyEwrGjJSOdv11mD
 IIOVYOoG1T2HKTUIRRI1CtMhOL1oZg0eK3xeaMTE=
Received: by mx.zohomail.com with SMTPS id 1744322359077865.9523564041237;
 Thu, 10 Apr 2025 14:59:19 -0700 (PDT)
Message-ID: <d0e9e72a-02bf-4f1e-abe0-6e8d0d089b29@collabora.com>
Date: Fri, 11 Apr 2025 00:59:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/10] virtio-gpu: Support asynchronous fencing
To: Cong Liu <liucong2565@phytium.com.cn>
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
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250410095454.188105-1-liucong2565@phytium.com.cn>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

10.04.2025 12:54, Cong Liu пишет:
> I discovered that on an ARM64 environment, the 'virtio-gpu: Support asynchronous fencing' patch causes the virtual machine GUI to fail to display. Rolling back this patch and using virgl allows the virtual machine to start normally. When the VM screen is black, I can see some errors in QEMU. I used QEMU's -serial stdio to enter the virtual machine's command line console but didn't see any errors inside the VM - the graphical interface seems to be stuck. I would greatly appreciate any suggestions regarding effective troubleshooting methods or specific areas I should investigate to resolve this issue.
> 
> Here's my software and hardware environment:
> - host and guest are ubuntu 24.04
> - QEMU: https://gitlab.freedesktop.org/digetx/qemu.git native-context-v11 branch
> - virglrender: latest main branch 08eb12d00711370002e8f8fa6d620df9b79f9e27
> - Mesa: Mesa 25.0~git2504031308.ff386e~oibaf~n (git-ff386eb 2025-04-03 noble-oibaf-ppa)
> - Kernel: Linux d3000 6.14.1-061401-generic #202504071048
> - GPU: Radeon RX 6600/6600 XT/6600M
> - CPU: phytium D3000 aarch64
> 
> Here's the command I'm using to run the virtual machine, which displays a black frame with "Display output is not active" and fails to start the graphical interface normally:
> 
>     phytium@d3000:~/working/qemu$ /usr/local/bin/qemu-system-aarch64 --machine virt,accel=kvm -cpu host -smp 4 -m 4G -drive file=/home/phytium/working/ubuntu24.04-aarch64-native-context,format=raw,if=virtio -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=net0 -device virtio-net-pci,netdev=net0 -device virtio-gpu-gl -display gtk,gl=on,show-cursor=on -device usb-ehci,id=usb -device usb-mouse,bus=usb.0 -device usb-kbd,bus=usb.0
> 
>     (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent failed
>     (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent failed
>     (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent failed
>     (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent failed
>     (qemu:46029): Gdk-WARNING **: 16:43:53.716: eglMakeCurrent failed
> 
> When using SDL, the error messages are slightly different:
> 
>     phytium@d3000:~/working/qemu$ /usr/local/bin/qemu-system-aarch64 --machine virt,accel=kvm -cpu host -smp 4 -m 4G -drive file=/home/phytium/working/ubuntu24.04-aarch64-native-context,format=raw,if=virtio -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=net0 -device virtio-net-pci,netdev=net0 -device virtio-gpu-gl -display sdl,gl=on,show-cursor=on -device usb-ehci,id=usb -device usb-mouse,bus=usb.0 -device usb-kbd,bus=usb.0
> 
>     vrend_renderer_fill_caps: Entering with stale GL error: 1286
> 

Hi,

1. Please make sure that you're not only building QEMU against your
virglrenderer version, but also setting LD_LIBRARY_PATH properly at
runtime. Best to remove system version of virglrenderer if unsure,

2. Can you reproduce this problem using tcg instead of kvm?

-- 
Best regards,
Dmitry

