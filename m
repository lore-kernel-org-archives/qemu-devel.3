Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579C3E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkVA-0006Fp-MY; Mon, 09 Dec 2024 15:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkV7-0006DT-FJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:05 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkV4-0003D1-Ce
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:05 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso229204566b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733776621; x=1734381421;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYKrY4D89CQtOtQV4UE1A1McnS4pHYxVCom2HH+qHOk=;
 b=bawufz62s0+B4u9giuELv0ftic9R5QPCb2vQLlmQbYw7xLIo3VVyVSYOKkjLGmZlS8
 fl7RtGD+uyTBRnFBfcbqnOhysXl8rSAob6I/vFRMn+XwI4Ts9xt/TM0GLeZ6eREpceu0
 LufjcdwYGp79Kk1AcwVeTWKY705uodypdQVYL7m69IIJaBaBErgqj8Bhmlz6i+Kka87P
 hnovsxj7AM2kw3RxX6V/a0IJGmOrxlwPgwg9TWT5LLgQYmLQbr6lx4AZPtEQhG3tIB+D
 CHAcAMyIUnSpBW5tVbA183tDKK74AZM0Flhh+elqSbMXGPsuROg4VwoNai1tyz6GTOPw
 8JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733776621; x=1734381421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYKrY4D89CQtOtQV4UE1A1McnS4pHYxVCom2HH+qHOk=;
 b=uCgQ3SkXFItaLOSg88BZi5ORInxIIDU9SPM8au+PaCwg1VMbrYzwISFU1egclajtm2
 i/Wqvtu/nar1yJr1qDNQkjG2Yc8UWG8b8vpu0MIKZRiRe3kSjhKvabcW8mHtSCCMfzOJ
 6a1fhAlWxQm/NnFUloh+ScZBU0Y6X2uKfPTmY6Ala2t0uS/KIPpXV96NMF1blCKP3FuE
 zO4GVVNGHCtcPLhIUtLdzk1zaDRLxdk1TXtIxO0gCzwKvH6tG2tD/TpjZDHeEdpnLRGR
 hVvUtUbpec6pUZG0seNPTTq4VAaXSMQ4uTyQDlt/7+Fno+DjLn/tUptTe8r8eWPSYp2W
 qQwQ==
X-Gm-Message-State: AOJu0YwgTu9RsT9Rne9M2f4Zjs09RubENTOq8aUPS81+OvSFaLwTM8JX
 z3CsRqFBQUdGhceYTMOx3xm0UIHLSSw0Awzr5u2WQk72yI55aipKuMTebJmSV/9nfE5EpAoJI6b
 JQg==
X-Gm-Gg: ASbGncuzPkA8s7Bw9A4I0an/feaE45/35kocbMKINpxkW4rRos+vzztRUAdu8Hpr0kd
 gaOGA+kfpqVA252zQWFf6PLu2cRhV3UUVJPD+KO64B7O36YglQG5jyLKyfbEchcjKec3LjAg1D2
 jBJ785JFQ5Yl2Yu+GpASNEb8dDFDgWLXzpfflTmGn/mz01SdtxmPueVFOtF4GbsbYZwH40kNTRV
 nwO8aaa/yukuYAg+eT79TVEqAkp7M67xfDlTduzoKva3u8EqR88COGBjUjznyqiDYk4U4JOYevN
 slE8YxPRBfQTnQF2C1ZKx5CjPy1+FA==
X-Google-Smtp-Source: AGHT+IGpQVRF/pbWeU4ghCdI1WiusaGqYHZNlg9MVL7VNjeigJCwKaKS24noJW27M/XzGw7NgFye7g==
X-Received: by 2002:a17:906:8455:b0:aa6:96c4:ad58 with SMTP id
 a640c23a62f3a-aa696c4ae47mr307131966b.61.1733776620739; 
 Mon, 09 Dec 2024 12:37:00 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa692e4e9d5sm141783566b.129.2024.12.09.12.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 12:37:00 -0800 (PST)
From: phil@philjordan.eu
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 03/11] i386/hvf: Don't send signal to thread when kicking
Date: Mon,  9 Dec 2024 21:36:21 +0100
Message-Id: <20241209203629.74436-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241209203629.74436-1-phil@philjordan.eu>
References: <20241209203629.74436-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::636;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x636.google.com
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

This seems to be entirely superfluous and is costly enough to show up in
profiling. hv_vcpu_interrupt() has been demonstrated to very reliably
cause VM exits - even if the target vCPU isn't even running, it will
immediately exit on entry.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/hvf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 3b6ee79fb2..936c31dbdd 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -214,7 +214,7 @@ static inline bool apic_bus_freq_is_known(CPUX86State *env)
 
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
-    cpus_kick_thread(cpu);
+    cpu->thread_kicked = true;
     hv_vcpu_interrupt(&cpu->accel->fd, 1);
 }
 
-- 
2.39.3 (Apple Git-146)


