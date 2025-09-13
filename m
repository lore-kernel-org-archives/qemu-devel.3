Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB4BCAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLLJ-0005u4-HF; Sat, 13 Sep 2025 04:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLH-0005tI-7r
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLF-0004zY-LT
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0nuKa0pQnnRbuWROMsoY7tGerozDA9x5CjuoP23Xwkg=;
 b=FCIbil5je+oaLlWQtL36GHvnT1zM1x73upSS0ocMuCW0IsOQYRhpsX9HkHQQDJTDvLq8V1
 x1fftMoE48qgKNDBRWvXPI6m3boWpZaI9eR3HCTeP8/g5PfYAe/pKWHykZEAmIjo+wAO0X
 xWvkn1Gyr13MU3XzPvrzA9YItAMTLwg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-N8y_G6IQNdGCaWy-6ksYDA-1; Sat, 13 Sep 2025 04:10:39 -0400
X-MC-Unique: N8y_G6IQNdGCaWy-6ksYDA-1
X-Mimecast-MFC-AGG-ID: N8y_G6IQNdGCaWy-6ksYDA_1757751038
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45dd66e1971so23559865e9.2
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751038; x=1758355838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0nuKa0pQnnRbuWROMsoY7tGerozDA9x5CjuoP23Xwkg=;
 b=h02VjcnJY38YVCTA5b00j+wCYPO6FvBaf24PBBdoVvWJCWq2UuylGPNQs/f9xoCuf8
 Z7Kd5gcb0RLQuZ4aDovuaJ9MoAfZZqXNJojexlF3abrHV894wtgSQ1s6TfocgbGbsB2u
 jfHgXA5uHw4AJzR/2tF7MO3MSk6r6HMzJaN4CbZmw7xGdopUWxbvKCEkrBG1N4mFnFZT
 rTMwDF2KkTIlg78RnLRUFKVItsVExIctB5rIZmNlgdF6UzSmR/1xkov1Y+uGN4gYI1pB
 fiA+ZaYKMiJ0SaBKgqhnHuuiBDEBsAaq4LfVJ3KJbSF7jhdVHmovuFbPt2zuklornYNe
 nu9w==
X-Gm-Message-State: AOJu0Yw9RDjERz6vlYqoPr0JuXZJU1yoJEg/PPo8PH5BV81O8JHQf4cU
 NdYw/UvEUZUvM0A6/qLfcvVr+8516qREzvvRFRnZHHAgL+XCtMMPCZG/L3af/9w8hoZEyPo/lzB
 XiEo+VNRkrrxfnTaSzJxCuq0Vs40rFjg9gDxqNVwQ88WUHUEyoa1n1u0lDTBhtvne+KRVohBcoB
 Fqd7Oc3GNhn0Rxb2jpIMpET4+CDHb8gOVCElnnmDqm
X-Gm-Gg: ASbGncs3jQvDWqyLcB2IkoYg/Z950+3EnotIWvuN4LA0zU9wPYa1763kaQQN47iSsd6
 zTXF0K+Mh14ttbs4TOBFPOfU3cbx+J+G3oH/S5tfVbubZEqMEVVv+Bb5EhqpqUQsnsoL7x7RwU6
 EGb0WxbxuvcHAFQaLbfudhqD21Q2oQ7fPMfIJIWg/0VLaIEbl26BDVYJlOC/uw5/G3iwm+Pwq2H
 re7nZD8Ss6YWCr0zANW/Khpus72KgYUsgnR6MxD7fJ1f9yfzr8QzR+IU0DWeLqlaKef4mtJa9Sl
 ibhxJrk/29CaAMpAU23UsJDkmujCUI/ufe+lK27x5Aa+0bn4rs+OoKyzU6kGAXsnt/MLruJ9Vji
 PYxX0XFWCtojbhWgDmoFjNzb7Ji//VgwNJmhWinvJoaA=
X-Received: by 2002:a05:600c:1993:b0:45b:5f99:191c with SMTP id
 5b1f17b1804b1-45f211d5aa8mr59383825e9.12.1757751037841; 
 Sat, 13 Sep 2025 01:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVi6cigfC05eJnL/TuYSY2m+RCCQvCRSORtOBUn338bTr4wO4EmYkHRIdPt7hPjipiuF9vAg==
X-Received: by 2002:a05:600c:1993:b0:45b:5f99:191c with SMTP id
 5b1f17b1804b1-45f211d5aa8mr59383585e9.12.1757751037379; 
 Sat, 13 Sep 2025 01:10:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e015775f1sm93399455e9.8.2025.09.13.01.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 19/61] tcg/user: do not set exit_request gratuitously
Date: Sat, 13 Sep 2025 10:09:00 +0200
Message-ID: <20250913080943.11710-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Whenever user-mode emulation needs to go all the way out of the cpu
exec loop, it uses cpu_exit(), which already sets cpu->exit_request.

Therefore, there is no need for tcg_kick_vcpu_thread() to set
cpu->exit_request again outside system emulation.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ad94f96b252..7c20d9db122 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -751,6 +751,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 
 void tcg_kick_vcpu_thread(CPUState *cpu)
 {
+#ifndef CONFIG_USER_ONLY
     /*
      * Ensure cpu_exec will see the reason why the exit request was set.
      * FIXME: this is not always needed.  Other accelerators instead
@@ -758,6 +759,7 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
      * CPU thread; see kvm_arch_pre_run() for example.
      */
     qatomic_store_release(&cpu->exit_request, true);
+#endif
 
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
-- 
2.51.0


