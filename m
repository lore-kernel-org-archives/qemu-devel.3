Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AC1CD6E56
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 02:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUEl4-0008TH-1z; Mon, 01 Jun 2026 22:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1wUEkq-0008Sk-TC
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 22:21:21 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1wUEko-0006bS-9a
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 22:21:19 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-6c50579dc4aso1023728137.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 19:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=allelesecurity.com; s=google; t=1780366876; x=1780971676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oqSK6KHimFMn/wufhN+V/HaPMlQTvUnD2P67uwmnzDE=;
 b=h/AUDKw+cMpvgXkh7s/NJTw8NOV/qhhysf/cjXdy+8DvIOoY97e41AbS7wYPXF4IAL
 bZqyqTr3uD2I/2ZosJQD9L5iS2A2D6V3inWX7YKJDVItzUf3liV08OPJ/7L0UjwM5evj
 TyhS+ifYILwOG+s4i1K3wz+dwHZAmJe/tVeKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780366876; x=1780971676;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqSK6KHimFMn/wufhN+V/HaPMlQTvUnD2P67uwmnzDE=;
 b=N8HZWM6QsACzm4dgUbyE7jBcoL/i+HUm+OqtptWSisuD5Qxa7klFT0X8A8r75Iyo/c
 Z44/iSByMUFZQKY8L5mUissWoEEfs6s3XMY2kNu8UCG05RvpS99I9ejopvr6kqnrSWB1
 xW7PrA//CwAsGKWw/ycjiSnqsX9sarosXFzIWXZFPazYvtJb9ysYmBYqgIpU9MJmDeXm
 n6GWMaGLX6VuFe8coCwZn3WQmwH6fjjgUgojbxmz3x4ZVH0N0q3t4ZUHQswrFPRySM7F
 eXIvy0Yw5cFysLLEcBvwrYqxaAvrfNbDYrVAYNrfkZXYdgZPhJcCGGOmbPHKdEWLn5VS
 VTQA==
X-Gm-Message-State: AOJu0Yx6KVztWcMRoNZiwDmtK4Mvk+oAOreJ7sjct01qsqL9Tg3s8wxF
 mqfn102BdSNEEInVbLQIfO3DByXRZj7yjjknv2DWAcPRPr6TRBO4ZNVrPZj/xmo8/BRcx8NCyqW
 R1hLlZ9s=
X-Gm-Gg: Acq92OGYabNl2xh2/S+8tUaGxnhl0EO1aOmXjUWc7Ioa+1riUEJHsxr/glnw43u+Bqs
 e3ND6/GVi3QRbG4Magrvq+kMmV5Wn4oS/ykjgHc2NM5hr9rnuPQi5go5b7gqRNXlj75fOS7DtcU
 qRpkjpev44vyIgI5BoaxtKNNSJ8lEro1ruVmugfppwlWMi/BZoQGmrlPOpQR9OcgsTRIitssNEl
 IdOlCxwOHRreMsrToALQ2Cyuqj5VnRKNIVzfRLw8DHGxBBYAfS15nL5iL5oYh4J6Cll76N+mT/6
 p6u069vhtpj8IbIk27EzfDaxMAg1qyiSso2mhWvTA1verg5tCOf7NkiTbWVgLqv4XWuPZV/NBO9
 SfSEFvyvxFQ/syn+786216XmDkJcsoTEL9ykgjQOyzJASvVWEN+xXJ07azHyiAueTjpuvJgws8Q
 UbW8nkoCCcFAkGy2vMs53ykl8d30ylNWpusbtwQg==
X-Received: by 2002:a05:6102:4a93:b0:643:80f1:33d8 with SMTP id
 ada2fe7eead31-6c694f50a1dmr5989468137.4.1780366876493; 
 Mon, 01 Jun 2026 19:21:16 -0700 (PDT)
Received: from tarski ([179.105.152.38]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a1c3c784a2sm3648243e0c.15.2026.06.01.19.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 19:21:16 -0700 (PDT)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 zhao1.liu@intel.com, mtosatti@redhat.com
Cc: Anderson Nascimento <anderson@allelesecurity.com>
Subject: [RFC PATCH 0/1] target/i386: Add support for KVM APERF/MPERF
 passthrough
Date: Mon,  1 Jun 2026 23:20:47 -0300
Message-ID: <20260602022048.752453-1-anderson@allelesecurity.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=anderson@allelesecurity.com; helo=mail-vs1-xe33.google.com
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

Hello,

I have implemented support for exposing and enabling APERF/MPERF 
MSR passthrough for x86 QEMU guests when running on KVM.

As of last year, the Linux kernel supports providing a capability 
to disable APERF/MPERF read intercepts [1]. However, there is 
currently no native way in QEMU to instruct KVM to activate this 
capability or expose the feature bit cleanly via CPUID.

My patch introduces the `aperfmperf` feature flag via `FEAT_6_ECX` 
(CPUID.06H:ECX[bit 0]). It ties into the existing power management 
framework, so when a user enables power management via 
`-overcommit cpu-pm=on` and passes `+aperfmperf` to the CPU, QEMU 
requests KVM to drop the MSR intercepts.

For testing, I passed the feature via Libvirt XML like so:

    <qemu:arg value="-overcommit"/>
    <qemu:arg value="cpu-pm=on"/>
    <qemu:arg value="-cpu"/>
    <qemu:arg value="+aperfmperf,+invtsc"/>

A FreeBSD 16 guest is successfully able to read the changing 
values of the MSRs directly without exiting to the hypervisor:

root@freebsd16development:/home/user # cpucontrol -i 6 /dev/cpuctl0
cpuid level 0x6: 0x00000004 0x00000000 0x00000001 0x00000000
root@freebsd16development:/home/user # cpucontrol -m 0xe7 /dev/cpuctl0
MSR 0xe7: 0x00007fdf 0x22480f90
root@freebsd16development:/home/user # cpucontrol -m 0xe7 /dev/cpuctl0
MSR 0xe7: 0x00007fdf 0x2b8b48b0
root@freebsd16development:/home/user # cpucontrol -m 0xe8 /dev/cpuctl0
MSR 0xe8: 0x000050de 0x49270831
root@freebsd16development:/home/user # cpucontrol -m 0xe8 /dev/cpuctl0
MSR 0xe8: 0x000050de 0x4ad66ae6
root@freebsd16development:/home/user # 

I am looking for feedback on the approach, specifically if tying 
this directly into `cpu-pm` makes the most sense to the 
maintainers.

Based-on: QEMU v11.0.50 (commit 5611a9268d)

Anderson Nascimento (1):
  target/i386: Add support for KVM APERF/MPERF passthrough

 target/i386/cpu.c     | 17 ++++++++++++++++-
 target/i386/cpu.h     |  2 ++
 target/i386/kvm/kvm.c |  5 ++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.54.0


