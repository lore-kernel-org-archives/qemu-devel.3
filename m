Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E646CCF9F0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnbH-0006DH-5S; Tue, 28 Oct 2025 13:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbF-0006Bp-Df
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnb8-0004Sc-M4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uNUgC+CpMFn7MC6N/Zib6jbMtfkLhzBQ6ENJcnYPLcY=;
 b=UgeQ3lbihjE4uB/Q12iv9e+6L8p8PeWEgqqRshyAHxJQvviSGGDxqOK7b3Z28ZW2zqTI7g
 zovQoye6d6jM1+kswS7xHzQK4J7btf276ikBOrApzIUKkz1pF0fE/3CLOW/bKY5oQ5Aww7
 r1NZNExI+VysuTGsJ7FS75o5zWEo0w8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-kmWzT40lPXC-t_oV4CoUUw-1; Tue, 28 Oct 2025 13:35:00 -0400
X-MC-Unique: kmWzT40lPXC-t_oV4CoUUw-1
X-Mimecast-MFC-AGG-ID: kmWzT40lPXC-t_oV4CoUUw_1761672899
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4711899ab0aso44619155e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672898; x=1762277698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNUgC+CpMFn7MC6N/Zib6jbMtfkLhzBQ6ENJcnYPLcY=;
 b=iNyDV4h3ijk8zo0Bhx68MdbbQXg50b+j7d9/QK2ih4/WywC84v6pWsQE5fhnA98733
 YZbNcVoscpw87iQVa9sp0IvqWz7srBuSEAYsmO3WIeAFmufv77hYaB/x7iHn0GHCXwxp
 cXcMvIxhnpJbYagfwTDpGUfduPqtg/fQA795JXShX5wVbalBUklRvgA4SLQHuzCvhOJw
 FO3cxXQejZMAu/BlUT2j3oK39oZygi0w2lc8Mz2vdjhKPbjwZ2OIWEXkChBpFq3i9f2u
 nmBhJy0ocSJa3K8d6Kb3b2sxmrNdl3T4CH2eKqMz64hJyilBoBwlTlPf9cogPTQKpH5v
 tyMA==
X-Gm-Message-State: AOJu0YwGPNsoLh/ml0uX6slumT09pGcLn91X7U5pxUnwzk4MeOqnLKHs
 ae2nJapB80ryGJiP+y4iaevQV2o5bE6MH6SfUXtlvBWIxYLmTT7n7EQoX5z/fkVoM51FVB8V/Vj
 JH7B6CF4UkgKjyIP9wf9QGyIlMZcC8DfKGOlRrM+HR9yy2B8oendjW2XiYCUPoo+f5euZwTo6HY
 lBym/RcnYBq2JtyPimrqmM95ylbnOEQxWJHtUoZSDw
X-Gm-Gg: ASbGncvFX8mz5tED8OSu3lpWKIYmsv8TaSnseHsKC4f2tg4OMp3bQTnvo5g47a+PI3k
 +vgdqxxEE4MNYsMH+KnqjGkRCV1WW6RBfcs9wDHCbraMGFY/G+ZmpXquR9z81ou+fB5ji1E3XT8
 bPfD+xE7VdkkOnwz7TOQhj6iNXWQ0tSs4XBmQw8y3fp7wsw5fk/bgUquZwrcnsRGgB0fb9HC+bY
 h06/33vlcZwAVQ0L1TAcCRQLSMXqcKst6P8BzXYm+r1HOrDXWz4aN/jN8LJzf8/mlvve6x+iRiC
 h7z/lTQpt5BX/3UJ9bxXEt80dI+aEUgnaEELopAR+WMfl+D66247WeJcBmJfrKPOcw6MSfz8wmZ
 CrO0v33ajflMLKDNziW0Q8dENTr4HsB3BKpt1bAmm4gNNIe2+o/gSXMlFX4wcpx+/Cqpl22n60H
 YvF/o=
X-Received: by 2002:a05:600c:1992:b0:475:d952:342f with SMTP id
 5b1f17b1804b1-4771e24e0fdmr2056235e9.39.1761672897803; 
 Tue, 28 Oct 2025 10:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3OeZeHSZv4NQ7tuLzYcaOXr9HroN3Ew7tD56JoIb97RfKqnz54BteuTIHb+bwl2DtvtGdJw==
X-Received: by 2002:a05:600c:1992:b0:475:d952:342f with SMTP id
 5b1f17b1804b1-4771e24e0fdmr2055935e9.39.1761672897248; 
 Tue, 28 Oct 2025 10:34:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e202093sm3535315e9.11.2025.10.28.10.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:34:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/18] accel/mshv: use return value of handle_pio_str_read
Date: Tue, 28 Oct 2025 18:34:21 +0100
Message-ID: <20251028173430.2180057-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Coverity complains because we assign to ret here but
then never read it again before we overwrite it with
the call to set_x64_registers().

Analyzed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 1f7b9cb37ec..1c3db02188c 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1489,6 +1489,10 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
         reg_values[0] = info->rsi;
     } else {
         ret = handle_pio_str_read(cpu, info, repeat, port, direction_flag);
+        if (ret < 0) {
+            error_report("Failed to handle pio str read");
+            return -1;
+        }
         reg_names[0] = HV_X64_REGISTER_RDI;
         reg_values[0] = info->rdi;
     }
-- 
2.51.1


