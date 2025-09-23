Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9E6CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0z0A-0004KR-2p; Tue, 23 Sep 2025 05:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1v0z02-0004JQ-MO
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:07:52 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1v0yzz-000055-08
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:07:49 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-25669596921so57213835ad.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1758618460; x=1759223260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TwDWGCnzVp2md9jXpRmyhyahuiECd2RbbH3vyHCO39c=;
 b=VSegOUCISJxf0MPjEJItY8T/GsP/mFR0mPjN3ReETZaAXkgRV+ani+sB15x48CPpfa
 Yr/es7SqCFNE+msk5d4YrXrlNlXRMZGDHmRFDDsMiBSOj+8bLwSnZU6FKoVO2ezFpgzC
 Iy/ZPRwkekoIClgFI/QOyWQE0RjJ9264N3VoP4wkouwch8Li1CgkN2EjpNOb9JwBRYUh
 enb9+7UArA2dp9Xde2j3hu0ZCRZvkv9PdqyRVYlPiSHAtYX9Nj6jqN7Jn7hc4Zs6I3jJ
 ekt8xiGRhRAKBy9RU4AteZbYRyOwXaRemG912wSaUvgaSlZjt+suW2OK+kg3ayCV12ei
 Msfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758618460; x=1759223260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TwDWGCnzVp2md9jXpRmyhyahuiECd2RbbH3vyHCO39c=;
 b=YKMPywMYlr5gjAAJ3TmfZ0fZi9FSXjj9ienvblLAuG92imrAtyw+ICLRr8kphWL6uo
 x2mY0gQvyfyTwcQro/HwQ5vqFmQZJnYVR2mHvPvSU6okGEAxf1HguegzU2PyYYLe3Dli
 ZPj64aQvHOHtfUK4GwYGQQSM2ROhE9wixDAIpLjZ9pk7hNgoQS4OQVrm7tdcWM85bdWu
 iiCg6wvh/c6dMUlWewm3jGaP83IyEF7EK5/Zo3JJ53Vmr2E9HgOw+zIT6ZP6Yw8WvQ0i
 ZeMjo0k8I5G82TtbmsiIYUMUrEgioCs2CBvpnSlE/hy2qd8SiU6CUQfcINaIp4ofV3aL
 RE3Q==
X-Gm-Message-State: AOJu0Yz4XhosSZHqvrXUJgD5GpdyiQVS8X6Qmnv5fOewl9lEEzw70J3m
 oWsq1PYbPHQ0m0Rt09V4O9tacE4I0WQv8plGmNpymUayz47lsrmX9bgD5qOgHsJZ9Cxz92sGU2D
 0nZ90IMQzRiK1Bt1+K1SWjTu7n8AYT8nck68ZA5GY0zEfZfCPzpu5jq/LWxEEb/iZoGhWY+x/C+
 Pmp6MYuqVW+xpSIrjS0draxjbmfcJ9YrJfueeXpaL0hw==
X-Gm-Gg: ASbGncs0X8wdHfZIcQrs6GxIG3pZUjMjgQ6egjN7JaudXDVfrfXYYf/Xs+QkHxjKnjR
 3vW7rZPPcBiyWWG5kcyK4fDDLBQbD22eyQFo7JLwYhFceNZLDBqMFNm0Y0yjrcODOUqXjJhtMV7
 MwSxiC7u2H0SeVphas6Wx9eBZRSDr0oNpF6RxmagTuH3AzJhubbPW3oDM+q/XJWlnCn0VOCaWyv
 b044sbGhQDRD3wwytnHGpz+QvoogmUCCBEk8huzs7hVcwgEdJ8b9aKYAVPQl1K1T76yM9p/Q6On
 D3+2dy9rbLH0RSaS631otfO//uGGNcabeurcZ3dDRN3062t5Hi1evEaPtmTqV5fji5hPGb+eNPU
 96EmcL2T3l6B9hg8cGYilP/Wrlq7/NIMSq/fZNCBPPwZ4/QWVDaIYfOGcCvf98gujP1Q=
X-Google-Smtp-Source: AGHT+IE0YziYtVaKy+f37OepKYp/a2J1JQbC7hktUlSENlG6gniAMbzgLAxoaPdn5ApY5M5NkbnctQ==
X-Received: by 2002:a17:902:ec84:b0:249:3efa:3c99 with SMTP id
 d9443c01a7336-27cc7f92191mr19399125ad.61.1758618460280; 
 Tue, 23 Sep 2025 02:07:40 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269800530b7sm157486245ad.18.2025.09.23.02.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 02:07:39 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 0/2] riscv: Modify minimum VLEN rule
Date: Tue, 23 Sep 2025 17:07:27 +0800
Message-ID: <20250923090729.1887406-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62e.google.com
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

According to the RISC-V unprivileged specification, the VLEN should be greater
or equal to the ELEN. This patchset provides following modifications:

* Replace the checkings of standard V with the checkings of Zve32x
* Introduces a check rule for VLEN and ELEN
* Modifies the minimum VLEN based on the vector extensions

Extension     Minimum VLEN
V                      128
Zve64[d|f|x]            64
Zve32[f|x]              32

v1: 20250627132156.440214-1-max.chou@sifive.com
- Rebase to riscv-to-apply.next branch
- Add patch 1 to replace checking RVV by checking Zve32x

Max Chou (2):
  target/riscv: rvv: Replace checking V by checking Zve32x
  target/riscv: rvv: Modify minimum VLEN according to enabled vector
    extensions

 target/riscv/cpu.c            |  2 +-
 target/riscv/csr.c            |  3 ++-
 target/riscv/machine.c        |  3 ++-
 target/riscv/riscv-qmp-cmds.c |  2 +-
 target/riscv/tcg/tcg-cpu.c    | 21 ++++++++++++++++++---
 5 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.43.0


