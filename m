Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF9AC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 15:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc3gL-0006PQ-W9; Wed, 16 Jul 2025 11:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uc3Nf-00023t-CB
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 10:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uc3NZ-0004TZ-MY
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 10:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752677102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u0vfUR7ji/+imKodcKXq8MSTGfgE0DppfpE/Ldc0IzE=;
 b=S5DBGo8+2U5BF9+bkZDS50K8a+9b8QtPCG2riA5+/NlXaMpRCnZVgV4Uin45WIcBTOC5ge
 O8GUZ3VMXcYJXRf4R7lSmaourJFMEsmAtbDetmPDfOnagPV5peOHIzl6QS7rYfd9mo9s77
 WHdFX/OkwUnPxX3dtyDZgt/387c2rqE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-T2S0IkJXNou2JZZo5vfZ_Q-1; Wed, 16 Jul 2025 10:45:01 -0400
X-MC-Unique: T2S0IkJXNou2JZZo5vfZ_Q-1
X-Mimecast-MFC-AGG-ID: T2S0IkJXNou2JZZo5vfZ_Q_1752677100
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-455f79a2a16so44439595e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 07:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752677099; x=1753281899;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u0vfUR7ji/+imKodcKXq8MSTGfgE0DppfpE/Ldc0IzE=;
 b=R33D59Lmg9YG22rGppdMgrQEjNyrKXhtYalTWZTkaqVkcQd16HL+fX7X3n01up3s24
 d3R7o4AsHwlmRA2pJCCpMBPc1l4kjt+u7oggRyd7VjZ1i/vMlqlAI67GvLwsAexXqwMl
 sVp1xbmMzXJh3ht+gjLnZ1jB/41WR97qPj5MEy//oCxGJD4QaHXj5RKdhhOJMCeiYlO9
 xdRfDXFD5kreFNLRyYHj1QGMTwFVWLLXMR/MMA3fRSEsrwuCVBEMooyO7DSvqlzezo/J
 LKxAJuc69tucb1GdJKcHioMjUu0fTr9MwLkQcRcc1ZwTRJrq3n0gqm1fUdL5MJKN2g6q
 RvWA==
X-Gm-Message-State: AOJu0Yz3UPWBRVoeAbcF0/FxyEBPY8UGSbwNFWcUMmF3tKGtfp3FaZvF
 G+jyboQXnoOOUVLoZR27VmTHiFCtvo0IfTL1wOInUjkS1933H+Fi4RoxFDAJyXJz1+E12ySM/3f
 6g8bUISKoEPZ4XdjOtDOpGE5BhHpgdeZPi07aFw/eDvVEL49cbT95QyXqHrH1/+Nr
X-Gm-Gg: ASbGncu8in6H9l93FzG2Hx/qxkDb3A4vn4/K6+TKT7b8b+EV5yPzF7vMn7aSDqFJLM0
 y3rhRXkMrnjWt4AlCgCrL1gXjxxlMcJDaVnH++80c0a9f5ZnR1iVgT8V2peyjKWetSgCGlUbyHX
 irxrJVIsDDDcfKrUOQRr/eZPv5kmvSjdMNMrF2HBHV+mxdtRdF3nxrLTvA1j9E65EGkAMTsRUyE
 393/leITnzRaqdxwyflzvo+xvAR3ZiQrbmnS4/YthlsAy6CQ8qj2/XsSUZzQQe/MzZPWdsS4ng0
 c+x60hA1SM1xvbVPUCyYZyfgElL+NR+LiwggT+VJY3FZ6I124uliiDRXrznalQ4CYFUpTnCHSiH
 1FTQXNcIW/8I=
X-Received: by 2002:a05:6000:24c5:b0:3a5:2ef8:34f9 with SMTP id
 ffacd0b85a97d-3b60dd73204mr2859536f8f.27.1752677099487; 
 Wed, 16 Jul 2025 07:44:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP6B86YXjHBXDieW7sQjUfB8Wui3g4kMioLlBk1Ge/R8bWy4+u1RtDhJrEqsTZOmr1FH3cYg==
X-Received: by 2002:a05:6000:24c5:b0:3a5:2ef8:34f9 with SMTP id
 ffacd0b85a97d-3b60dd73204mr2859511f8f.27.1752677099043; 
 Wed, 16 Jul 2025 07:44:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e832dfbsm23173105e9.29.2025.07.16.07.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 07:44:58 -0700 (PDT)
Message-ID: <6c04f89b-0313-481a-9d26-1fe9e60e0616@redhat.com>
Date: Wed, 16 Jul 2025 16:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
Subject: boot failure on top of current git
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

I'm observing boot failure for a rhel-9.7 VM. I'm using qemu git tree at
commit c079d3a31e.

My local conf is:

/configure  --enable-kvm --enable-lto --target-list=x86_64-softmmu
enable-numa --enable-curses --enable-vhost-net

and the qemu command line:

/build/qemu-system-x86_64  -smp 4 -enable-kvm -m 4G \
 -hda "rhel9.7-20250506.3-image.qcow2" \
 -netdev
tap,id=nd0,vhostforce=on,vhost=on,ifname=tun0,script=no,downscript=no \
 -device virtio-net-pci,netdev=nd0 \
 -chardev stdio,id=char0,mux=on,logfile=serial.log,signal=off \
 -serial chardev:char0 -mon chardev=char0 \
 -cpu host \
 -D qemu.log \
 -name "raw qemu"

it core dumps with the following error:

qemu-system-x86_64: ../target/i386/kvm/kvm-cpu.c:149:
kvm_cpu_xsave_init: Assertion `esa->size == eax' failed.

Dumbly and blindly reverting 29f1ba338baf60a9e455b6fdc37489ca1efe25aa
and 5f158abef44c7e0945fc5f76715ef135a9bf9bd2 solves the problem for me.

Is that a known problem?

Paolo


