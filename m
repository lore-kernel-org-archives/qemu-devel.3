Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970D9D0E3F8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 19:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t43jr-0006M8-6i; Thu, 24 Oct 2024 15:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t43jn-0006Ln-VC
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:43:15 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t43jl-0007za-8Q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:43:15 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so1067076f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1729798991; x=1730403791;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PFMhArkOKIBuKv4PTRu+D2zkI2eDhHGS4f1WZUn3U5A=;
 b=DwRRdvjDtZ9sMNj+9Bx4hjoLRNI7MKHdWdk99ZvC6c9ap51KuBhJSvWA1d0tu80Wqb
 izr4zVYE4EHTd6PR9F6qW/FyIc80eMiC4uVRZBdjPIOtZVGjJYojI8LLOMvwTifPCP2l
 kIHLlLfyNJq6nCCrh1yraXZVr3KUUAsD+Ya6iWbkT9RBo0Kd91t97FKjZId3cOiZvgSC
 /jRHy+e9PgrT9XPi9i9jMOblBUiejBG4FHTF6eBYPABt3ycg6690ct2AEBFITw/sjyRm
 ceMQYwqbRgRzc0m8GQeRkZdOtCSvTOMz+MvVGVRLyuoh0JgEA0zIfIKFGqvRe5lTPkGc
 VXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729798991; x=1730403791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PFMhArkOKIBuKv4PTRu+D2zkI2eDhHGS4f1WZUn3U5A=;
 b=RlRky1vPfZnHanBtlpprvR36yoipraNdDapsk1uTwyGbAzFntbDTVmTidDYv8Y49HB
 y9xcAdqeALkKL1iAGjvzSUmpVtAqRDIxyijhoJ/zEtjvhw+e9gaOF+DP1DzI1Q9QhDL9
 djWBo3/3jXBoro+/VKX16h9mbuq3PIjJ4Kb0F6KZgg5Wrr/zX+94VCHUOgfw99FVrR1W
 CHg281rDFlA6BqqTmg2YYV/KkQhzm0IgpTpcBfU1r55F7Yq1ynmZ1/Ga4KRGWLIemJqj
 pB38Tt2fIFomsehDNtXD11M14Q4IdxasbB/Fa+zRoYiPrlOBV2OuXWSJ0hHsWEcip+w9
 HzIQ==
X-Gm-Message-State: AOJu0YwwqKDanEpdFKMSGpQQf/DIpqPR6Ch5GaLSgdn7NCU4dsQpegBZ
 341kixv1mgW4/ss3wdn62mDCcznTFPptvBd9x//pEb4lZLffeK50ULLFh1wThV590JhTN0xF4rl
 osw==
X-Google-Smtp-Source: AGHT+IE1fiECvprywQnEUtK1oSYC7ojC8NxTXgGvULWuq3FC/Lttt0aq1T5rzRT9XLuPQeDWWGo3rw==
X-Received: by 2002:a5d:58e9:0:b0:37d:4619:f975 with SMTP id
 ffacd0b85a97d-37efcf05df6mr6187940f8f.19.1729798991304; 
 Thu, 24 Oct 2024 12:43:11 -0700 (PDT)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d6545sm652536866b.31.2024.10.24.12.43.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Oct 2024 12:43:10 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 0/4] i386/hvf: x2apic support and some small fixes
Date: Thu, 24 Oct 2024 21:42:59 +0200
Message-Id: <20241024194303.32100-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::42c;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

This is a loose collection of patches against the x86 hvf accel. They
can be applied/pulled independently from one another.

Patch 1 is a repost of a patch I've submitted a bunch of times already.
It wires up and enables x2APIC mode in conjunction with HVF - the
software APIC implementation in QEMU gained the feature earlier this
year but hvf wasn't included.
The change typically improves performance with modern SMP guest OSes by
a 2-digit percentage. (Exact values depend on workload.)

Patch 2 fixes a minor one-off memory leak during hvf startup.

Patch 3 ever so slightly improves APIC correctness under hvf: when
setting the APICBASE MSR, if the APIC deems the new value invalid,
we raise an exception (as per spec) rather than silently doing
nothing. This fixes a failing kvm-unit-tests test case.

Patch 4 removes some unnecessary duplication and type-rechecking in
HVF's inner loop. (No need to cast the cpu state pointer to X86CPU
within, the hvf_vcp_exec function already does that once at the top.)

This work has been sponsored by Sauce Labs Inc.

Phil Dennis-Jordan (4):
  i386/hvf: Integrates x2APIC support with hvf accel
  i386/hvf: Fixes startup memory leak (vmcs caps)
  i386/hvf: Raise exception on error setting APICBASE
  i386/hvf: Removes duplicate/shadowed variables in hvf_vcpu_exec

 target/i386/hvf/hvf.c       |  7 +++----
 target/i386/hvf/x86_cpuid.c |  4 ++--
 target/i386/hvf/x86_emu.c   | 42 +++++++++++++++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.39.3 (Apple Git-145)


