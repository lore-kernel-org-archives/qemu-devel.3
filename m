Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E3AC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEonC-0005Xq-KJ; Wed, 05 Jun 2024 07:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEonA-0005W1-WA
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:26:57 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEon9-0003Mf-Ex
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:26:56 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57a7dc13aabso2699232a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717586814; x=1718191614;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AaRzhLsox3oysptViKMojdf5oerb0z9Xurwugiu/cvk=;
 b=jKktJWPMws6XISdOdfLuEh7/xO0j8udE1qMjz2/3jBcPVQVD9JQ0ZE9zNQzCEU3QkW
 a5Uom6XB7R3ogIFo4KsyyEckwN5bMTQxqszWfkB4LWU3FzGm/PPl1rzXiDbhgWaOG5vR
 TETHEuE42uSdvq3OOdfFN1xo6xv3lrokw9i+nobnCb4Hi9FNhda/1zVX41HniwYAtG/P
 MTjTwc24HNq61R5/Lj7EQ5q40B61MqMkiChrLD9B00nWbxvwkG2EUGZTKENay9JHwv1u
 mjio01AxlarEy6zxkWAC6xj/OxVvdEcncnRirpnYlCOCW2GqIGhyg+UbCrssPBrO7qU5
 Bxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717586814; x=1718191614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AaRzhLsox3oysptViKMojdf5oerb0z9Xurwugiu/cvk=;
 b=r0HEFyZl6WFdNnrY+alHC3xQJf0AtshjvS3Muw6diH/cqpQxgO7ekjuIO4ELv1msFz
 mkpOju5dXldFE7APurDi2HKZmt3T/2Wgsi6uGOV5tfLZXnbsI519JvxMCPxKSzu2lktB
 qa7AWIRo2UvwZ8w1wUpIHn29hTd4WYwfMLaF+szljnQ3TjVAdpZTVmOKk616rKYU4UcZ
 gk8bQocrUe8RW024pKCkJ9Not6/5ETDjNAlC7i69V0eNtwRjg56Yzo1qCuQXO45T5f4Z
 wSX1S1dQf2pmtX7GcJKG62dHZSRUZalX4dW+fjI+wwxkz02K3S8vjCZG8FwoqbJWSmYe
 +6lA==
X-Gm-Message-State: AOJu0YwpI7VcRN10E2TjPSAdp3+rxOW7OF4QF2XjBYyVi9u4c8+Rf8uI
 6q/uYQQA5srRmUYqC6caCVWn1bQFtmpPlbrVY4/ZQMZFNztJSTA5GEEaG8nLgkkJ7t9KZJeMd1s
 =
X-Google-Smtp-Source: AGHT+IGuR059yOZ0yF5ATbIlW1JtQ3ghYcA21+h58g4T3dNL3WxWSxZRRdEvKI9rlP3xWovzRZH/6Q==
X-Received: by 2002:a50:a696:0:b0:579:fb79:309 with SMTP id
 4fb4d7f45d1cf-57a8b6a4669mr1404754a12.10.1717586813895; 
 Wed, 05 Jun 2024 04:26:53 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a51023af4sm7111335a12.29.2024.06.05.04.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 04:26:53 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v3 5/7] i386/hvf: In kick_vcpu use hv_vcpu_interrupt to force
 exit
Date: Wed,  5 Jun 2024 13:25:54 +0200
Message-Id: <20240605112556.43193-6-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240605112556.43193-1-phil@philjordan.eu>
References: <20240605112556.43193-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52f;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

When interrupting a vCPU thread, this patch actually tells the hypervisor to
stop running guest code on that vCPU.

Calling hv_vcpu_interrupt actually forces a vCPU exit, analogously to
hv_vcpus_exit on aarch64. Alternatively, if the vCPU thread
is not
running the VM, it will immediately cause an exit when it attempts
to do so.

Previously, hvf_kick_vcpu_thread relied upon hv_vcpu_run returning very
frequently, including many spurious exits, which made it less of a problem that
nothing was actively done to stop the vCPU thread running guest code.
The newer, more efficient hv_vcpu_run_until exits much more rarely, so a true
"kick" is needed before switching to that.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 268c5734d5..106ac5cbf6 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -215,6 +215,7 @@ static inline bool apic_bus_freq_is_known(CPUX86State *env)
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
     cpus_kick_thread(cpu);
+    hv_vcpu_interrupt(&cpu->accel->fd, 1);
 }
 
 int hvf_arch_init(void)
-- 
2.36.1


