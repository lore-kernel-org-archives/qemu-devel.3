Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B466CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL28R-0007Fl-57; Mon, 17 Nov 2025 11:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vL28O-0007AD-O1
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:31:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vL28M-0007gt-V3
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763397077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=soTguZMNWGUli6h9FPm5MZ7HtS24tlGq4wCa+drJnqo=;
 b=NCUdMvnjauAFOQEpV2y/gDiQRop5jKmXePp4nR2KeVtvZTqMJZa3YNVKoYoevNdzVK2iyk
 QyaYGQ6iSYCDpfRp95NO0VrST8Gd7VGRkHs/ISX2xg+JY1FPwu6LqJEqDQccmyKppRcFnp
 rL3aadXHSFgGYeL0krGHm2DCBLllO6M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-ulBDOdhLOCegQOkU4zAgOw-1; Mon, 17 Nov 2025 11:31:16 -0500
X-MC-Unique: ulBDOdhLOCegQOkU4zAgOw-1
X-Mimecast-MFC-AGG-ID: ulBDOdhLOCegQOkU4zAgOw_1763397075
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477a0ddd1d4so11549605e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 08:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763397073; x=1764001873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=soTguZMNWGUli6h9FPm5MZ7HtS24tlGq4wCa+drJnqo=;
 b=RfH12d5MAFU2gecFmPCGX+Ff7/5XCjw4bPNZej1T04N9t+iFgnzDxsZ6bM4KRHBKmD
 sNyrn/8/zh5+zQSdjlRO4o2FStVrjyPDNbvMS4m3Pb6i7cU1HwePwut6dEMhXFoMuOqz
 f0eUCe1OhrXw84LQxZIE8/sXCIWjwfAtFeWMZjkuNdyqNWWoIAHi6MDVkhW3ekfyjaHx
 xft0eQedBiiEhOpw0X5Wj9uEfgyLGzJ/xEQRA2JxzOy51v0/p6olHpxBtew0kOjlXwmH
 FdP54VrjpB+/PCCjGtimZOv66kDDOIYAMwxaTow7rnIcAj9pHSv3LoSWAFTbzzMaPQvP
 h7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763397073; x=1764001873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=soTguZMNWGUli6h9FPm5MZ7HtS24tlGq4wCa+drJnqo=;
 b=mc/uxXa7BiH5s7F1v+AU0eIwtwLPXqPqHjv1m0B2n/rLC1TisLpheqVgkQl5fhzDNx
 lAL73qohuRllBXaTZZIJa7rDz1Pz1hAt/C1TfSFGVwFqxoZN7hliNn0cjuEUSCQgkB5+
 A0b5ktXuvsxUYPjWn+QMexL4KSI/DOaS4+RqPEX/ZiC9ASnYVwAV57vdZGihwCwS1qWl
 0U22HaTMgMDYOMWnH2tWwCXMihHgwkgIaoH7GzoP4tUw/a2h9IY1VDRgyK7n9AAbCoEW
 8U1Ou0B8/EB0H4l9EmTfCw+D1Cvzvq3P1nG1ATs939kidaKSPF18OSWqMsnoZ276JSxo
 9qgQ==
X-Gm-Message-State: AOJu0Yy0aE9qyNe9joj8kgJNkQA48zZfGZfPjCfh9I1uMKhGvn2sCORX
 seV4R7aYVECU4dk4OH1yV6sREl1gyLnqM7J1mSiK/9E8+Cx+PSUxTpo39c6iA/0vp4mgW/itANr
 q9jBmZ9+BpZa6ggathhtt//07tCvMYQk8MW0tXP3dg0lsDl6Ev3aULJ82lFGxr681+bbh30qN4I
 tSWo6dORJZPrP360wY0vnFrY9sYirQs/S4gzU6AiZG
X-Gm-Gg: ASbGncuZjQGk9PPvMt21B0wBbt0nOdiZZKL5D41qbuKNTBzE0LxOrKkI4836r+slT9N
 hHT+axf5H4UA/6S86H9zyIHX+RSjT9lwIQoSc3QLUFIX1pkoUhNRL6ZlkQtE3IQXA29mUS4s/fg
 hMUk9mZqBkTFNu6ThbJk3cximzjDTJLlmaLG10V+endzI1E9C1D7Af+WNxeVqiQZcvp75ts9INK
 +q+x+m/vqw2w1sEak62zQH+qfPGLqVGMT8y+wBMFx0QsPDwyZLWQ5igAYVyoesWMKml9EYgcTAB
 3aRntGUja7Q/83xT7uKTc3oya2V+HFPKGeMd+/N+Zh0VK4ELoXVK/+v4yXPSg3P7uF4c4BvYTUc
 1gRn1RcS8tI0cK3jA0xp4CaCdn5ngEPSX4J3VXTpEIquc6a8b0lghbuveHZ//5MQXwe+1fgyaMZ
 7rt53c
X-Received: by 2002:a05:600c:6c8b:b0:477:95a0:fe95 with SMTP id
 5b1f17b1804b1-47795a0ffbcmr67953415e9.24.1763397073504; 
 Mon, 17 Nov 2025 08:31:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAIf0osXXNHyuXMUHSDbm5xuBhlU5qcRFCegI2YpCTNTukCQmhy4vVjRFMmtKcidJC+ZSpyw==
X-Received: by 2002:a05:600c:6c8b:b0:477:95a0:fe95 with SMTP id
 5b1f17b1804b1-47795a0ffbcmr67953145e9.24.1763397073044; 
 Mon, 17 Nov 2025 08:31:13 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a7cb24dfsm26479915e9.14.2025.11.17.08.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 08:31:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 2/3] mtest2make: add dependencies to the "speed-qualified"
 suite
Date: Mon, 17 Nov 2025 17:31:06 +0100
Message-ID: <20251117163107.372393-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117163107.372393-1-pbonzini@redhat.com>
References: <20251117163107.372393-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Thorough tests may have more dependencies than faster ones.
Dependencies are now looked up based on the suites being
executed, not on the suites passed as goals to the makefile.
Therefore, it is possible to limit dependencies to the
speeds that need them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/mtest2make.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index af4ee56de54..d32eef2f7f4 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -59,13 +59,13 @@ def process_tests(test, targets, suites):
             s = s.split(':')[1]
             if s == 'slow' or s == 'thorough':
                 continue
+        suites[s].deps.update(deps)
         if s.endswith('-slow'):
             s = s[:-5]
             suites[s].speeds.append('slow')
         if s.endswith('-thorough'):
             s = s[:-9]
             suites[s].speeds.append('thorough')
-        suites[s].deps.update(deps)
 
 def emit_prolog(suites, prefix):
     all_targets = ' '.join((f'{prefix}-{k}' for k in suites.keys()))
-- 
2.51.1


