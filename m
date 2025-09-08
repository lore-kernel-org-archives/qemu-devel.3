Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0678CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYsA-0001dr-Eb; Mon, 08 Sep 2025 06:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYs7-0001cZ-Gu
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYrm-0000tY-BJ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7F7JtBib3HtIMCET12RYVWnFXL3A+/WcjU3+rd9Ob6M=;
 b=KduLtCeHyJ0yhLscWLDXAgyOF7yyWo8w4yr8UI/oDu2tizmcwK+cb4TA3Fb+RBEntEJpLL
 Vh1EZxQCunb63+U8lCR+ya2lyQBgGv2Zg1tz42FO7Jb+qCEO9Ykml/L6Vhw6GstD3dHlPQ
 LMSMnk62hDhTwW+N6rIgxX3eYoxi67w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-OgHveoIjMFKiEs0uBhBDHw-1; Mon, 08 Sep 2025 06:12:50 -0400
X-MC-Unique: OgHveoIjMFKiEs0uBhBDHw-1
X-Mimecast-MFC-AGG-ID: OgHveoIjMFKiEs0uBhBDHw_1757326369
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45de14da365so13296885e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326368; x=1757931168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7F7JtBib3HtIMCET12RYVWnFXL3A+/WcjU3+rd9Ob6M=;
 b=m8igFD3DBzSMelTMHg0FfTE5UmS2moQYvmDSFLkBvP1YiZzPG71QVsB3UFg7w4bJH/
 GWTSsPQKScd7RMOfSrQR6BeqKC4uIOnRXlSmhS7PEGXmu/lhzIsUKZcdIUhYumy3CZ4z
 SgTtgc8Yx47qQ/E9laQOg7bxdhF5h4/ao3FFqeqM0S6xDr4DC9m2qUs0XOR3TXSzseIq
 lHweRD9kPcQHN9JYq12n8zezUhV3nirWGq6HGQViQy99jZffnuoaG8IPSVlpwC+5d8bg
 R3WBNxmvuOj+OX1FbZOK2qBvnCXL0MFrFqc6l+MDwCvxga3Z6PgpAImHnAHTWZfY3K7r
 id7Q==
X-Gm-Message-State: AOJu0YwB6v1Cxs80bUUOiGkF+vn0pMkWFsRnQcFC7FUKqYKBAAr4D5Xd
 4NWIBlRilzPytWSVcovV2pbJhjVWRB91n5LuIPveXDi3ST9q4VK5SA0QO3dcxRbS/lZNiJrsLN8
 xhNEpyVn6pjia/lrIhLJQwBZNMvCAezJDUW8xCn0/johyTcMN/OLQcOXmcEj5RFZvFi2BAEdw75
 CJ11i03yjf/lgxpk9c+KBQJ1Xq8vr3irdTM93Hj8DV
X-Gm-Gg: ASbGncvEv6LqtkFedsfCQWnTo0pJdKfZfvKb4Zc7v415taVGEVPqqf+2cODi5UV+3QZ
 eqPXwn638PI2eHqOkQLQuxw0vZlNJoH+TFkTqrk1AwK5l/pSMFTAjzuTLSFpv6i92+tPbtI3N03
 4TNMtepDmfZS7doWt9ZWhaolN2zKEACdswnEVtuI09NeW0Jhutm4tqAU2VAhRIpFrP49obxB2bx
 suiDIHxePmEdW/Kx2jOhAnuMBDLMTtiB9w/nyU5ZagpSUbTVU3s1UG3BFTs9Wf2Trlctvhdx2mR
 HjYjKQeX0ezQThoQxzSvwcnkr/DMOLhZWnXaOVdhE0c4BA8+ontkCQG4aTgF0fCKu4zUNQtGeaq
 Bph8CiDo0atMT6p5gaGC642jIYQsmpkCSKvDMQTwHrsg=
X-Received: by 2002:a5d:5f82:0:b0:3e7:42ae:d3dd with SMTP id
 ffacd0b85a97d-3e742aed713mr3940211f8f.53.1757326368554; 
 Mon, 08 Sep 2025 03:12:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcKD6udcCUcULOY2R+Z2Tzs5rjwZBGDVQuz1UhG6afXgRb+ISjKUtCVbJ+NSCk2FEua+zyPw==
X-Received: by 2002:a5d:5f82:0:b0:3e7:42ae:d3dd with SMTP id
 ffacd0b85a97d-3e742aed713mr3940187f8f.53.1757326368131; 
 Mon, 08 Sep 2025 03:12:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45cb61377a7sm231030425e9.13.2025.09.08.03.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:12:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 02/19] target/sparc: limit cpu_check_irqs to system emulation
Date: Mon,  8 Sep 2025 12:12:24 +0200
Message-ID: <20250908101241.2110068-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

It is not used by user-mode emulation and is the only caller of
cpu_interrupt() in qemu-sparc* binaries.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/sparc/int32_helper.c | 2 ++
 target/sparc/int64_helper.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 39db4ffa70a..fdcaa0a578b 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -65,6 +65,7 @@ static const char *excp_name_str(int32_t exception_index)
     return excp_names[exception_index];
 }
 
+#if !defined(CONFIG_USER_ONLY)
 void cpu_check_irqs(CPUSPARCState *env)
 {
     CPUState *cs;
@@ -96,6 +97,7 @@ void cpu_check_irqs(CPUSPARCState *env)
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
 }
+#endif
 
 void sparc_cpu_do_interrupt(CPUState *cs)
 {
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 49e4e51c6dc..23adda4cad7 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -62,6 +62,7 @@ static const char * const excp_names[0x80] = {
 };
 #endif
 
+#if !defined(CONFIG_USER_ONLY)
 void cpu_check_irqs(CPUSPARCState *env)
 {
     CPUState *cs;
@@ -127,6 +128,7 @@ void cpu_check_irqs(CPUSPARCState *env)
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
 }
+#endif
 
 void sparc_cpu_do_interrupt(CPUState *cs)
 {
-- 
2.51.0


