Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB05C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOH7f-0008EI-Lm; Mon, 01 Jul 2024 09:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOH7a-0008Cg-IN
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:31:06 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOH7O-00059S-Pw
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:31:03 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c8e7553c9eso2155182a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719840649; x=1720445449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ACjYCACcN+OWc47eXAmrxeH7/7W3zi9H8TmCFf0Y8Ck=;
 b=l6ZKYwgbE1jxnFQhKL7MfszGxthqdLLAf8M1nOmU/5wFWuIoPf3AwAjyROfmhkAJ8B
 EOM0oAVJVmSYt+eXQgEToyoS4bMVOLXiftttkba0YpNeZRUf8jMspSepDFEgxvv+4GiW
 VjBFzFK0lp9Um+HU0FJg0SFXXdzeFDWMfiPUptVX+pfFDwonQbEVns8CKRsJ5AOksm7o
 rdV55+gDrV7nNPqAlO15WTOGRk6WcICOtF2S18jjj16kzAguV2Nqyql6wPozj2u69vCQ
 7vc5hFbaA/C08kWmBaPIZnC+CHq981MckJA0hb/b6od7Csve9uYNaIrUIPUuTMm6qSO6
 0sBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719840649; x=1720445449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ACjYCACcN+OWc47eXAmrxeH7/7W3zi9H8TmCFf0Y8Ck=;
 b=Y1uv4kCaEEGeXrvzH/OK7AtTWemc8yWCIfGNWS2Kz1ADcu8UjLRtSwcenga1F/4NUV
 fS+GtPPorJAFcF6BqRk+PcznVnlyFGvKmf17NWoDkXEp+ojOj2uD/4MI4XqbzUyUSeg/
 3OOvPNrM2QhywaWAou3HwjynhY64rnbuwPwXVXOgS8+XUPi6rfg5IW54dvzrmNmcMuz9
 KWeXw6rcVh23fRzPjRimpkiCSBG0dgxVPKsowNiY0hTLths9q16QQV5X9GzI8rLEC5Pw
 UYo3lD1ICWYIOVUxzMSRH/MlYCg9Km9o4nR8h8CfP+Y+0HdOHDRprpOU/6lhTLZXMkF2
 U9jw==
X-Gm-Message-State: AOJu0Ywkgw8R5lRErCNx7/zpFYXHUcDJ2i7Lr9RvD18V4bwJiZ0epD1Y
 4oWW6rBmGE+i+BmV7ev3ZLa88YDXOFOJsQcI4BoxtRNq8Exj6vu46pVECACOznHok1FbypTKuMQ
 L
X-Google-Smtp-Source: AGHT+IEsEH0syE5I5eIq0bNcuc/4kdWvvN/EjpqarenQEf1WTCeU95Cg+G2deP6nky2vYBpYZVAY1A==
X-Received: by 2002:a17:90b:4d8d:b0:2c8:ac1:d8c3 with SMTP id
 98e67ed59e1d1-2c93d732b8fmr4730670a91.29.1719840649163; 
 Mon, 01 Jul 2024 06:30:49 -0700 (PDT)
Received: from grind.. ([179.193.8.43]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3eb34bsm6736935a91.56.2024.07.01.06.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 06:30:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/2] system/vl.c: parse all '-accel' opts 
Date: Mon,  1 Jul 2024 10:30:36 -0300
Message-ID: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102c.google.com
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

Hi,

In the current handling of  '-accel' only the first instance is parsed.
All other instances (aside from a 'helper' command that triggers the
help text and exits) is ignored.

This also means that we can mix different accelerators in the same
command line. In fact we can do whatever we want as long as the first
instance of '-accel' is valid. E.g. this command line will boot a x86_64
KVM guest without problems:

qemu-system-x86_64 -accel kvm -accel tcg -accel not_an_accel (...)

And this will boot a KVM guest with kernel-irqchip=off because it will
ignore the second '-accel' that sets its back to 'on':

qemu-system-x86_64 -accel kvm,kernel-irqchip=off \
    -accel kvm,kernel-irqchip=on (...)

My initial intention was to fix a problem we're having with libvirt and
RISC-V where we can't set 'riscv-aia' by appending '-accel kvm,riscv-aia=val'
via <qemu:cmdline> in the domain XML. libvirt will add a leading
'-accel kvm' in the regular command line and ignore the second. But to
fix that (patch 2) we must first guarantee that we're not mixing different
accelerators.

Both patches can be squashed in a single patch if preferrable. I'm
sending in separate because I'm not fully confident in patch 1.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>

Daniel Henrique Barboza (2):
  system/vl.c: do not allow mixed -accel opts
  system/vl.c: parse all -accel options

 system/vl.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

-- 
2.45.2


