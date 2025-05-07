Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E52C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoPg-0008EA-5F; Wed, 07 May 2025 19:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPZ-00082K-Ak
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:49 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPW-0002QD-T5
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227d6b530d8so4592645ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661365; x=1747266165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFP3MpqDIAT/Xkpc6JOppR3V5lexoIXt45Qw9vGPUlk=;
 b=n5vp2y766DcPd10ckPrckZqCnL01Gy4V5bPxA75TgWa7243/sS+IcDp2k+0g1W5xEj
 rUX9SxD0Vbsn8gwxZ5Yz64TnBiyvXTmcjiBZkU9qX4DQYYFafOjIcQ1psCjXcV8hkwav
 8h5r7sFXttbmHhd8lDG7yNJWYsblexkNhMWxxGIImT5COLZPMO0EmT6tEeasXULR4bfV
 WMIuzeKltHuo+bE2B0wOrxAydDGie2kOyarJRhS6jBvtwfoml8/m6ENYJtxfCpNHMZ9n
 rjkB/lbyGdYQRDShihQnOq25bV8u9k4bj5gfoQzNBm/Pga/NIiR4mWITFld5rkRk7T/0
 U8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661365; x=1747266165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFP3MpqDIAT/Xkpc6JOppR3V5lexoIXt45Qw9vGPUlk=;
 b=i1LlrRXMJcvwIbQ7lVrDOlDyrenAakEUJHmJ7BX2GdfwxuoMXZidPqzcHgFOLXXWNI
 dBohLEhJhfUEwIpXDLw7VPRUmn4LYVSiSZ3rxsZTwf2JAXC7UxkU4eQYLK8j4x8ePd61
 MJaESAHCynIvPN2/oKUGQsloCTVpq0y6rVSLgEdf8XQWxF5/97eWcqD9uGG+1FqP/90O
 8rBmJBRmYLr1h7fG1ZAtf7KH/n5HidbEG7UJKjRW7MvmtFlHibNfnnUwcipNpBoFOnpS
 dKMIWnwaJR0zdUQSU7SrXmcOoNr+XfT7FDZusygICnF55C4qxGFQVCTlrRhnXA7DcHNL
 wIPA==
X-Gm-Message-State: AOJu0YwyBCxUZxvukrIHC3rpmCHDpvqgwvWh8dCl+ZEj/zePMkcuT771
 49tMohHLf+CJTDIV7siP2vkph1SRHwzwSejHWHGWEn/wR3pA9Maa7NuNSup0vUTatNLR/gAF/BZ
 9ANBv1Q==
X-Gm-Gg: ASbGncsF0PbRW7XKeeKflPIhXkiFFrDpXgQH5n/Y57+2rHppNSBeQ3IOQSbEbuJ7nI5
 t1qC0dqpKQb8pthHmmsckvSf0YLj0G7vBC7IwMYaTxqdqnjEUX+iWaYYmBz4LssZloyQP8B0L7p
 SjAoT1K0RX3JymoFpaLQlrj4MKziLbiPsPqjNBAr0KnAn/oyc4hpYVt7eQ7JAxe7NgI9AMc9IzZ
 iTOLRYk8Q4asNXWhSePfg50kwfX7LkGQF1C2nXaSFaY+BxCq8LHvhP9GjX3ygS0E3lllb+hWD9X
 5/FL310tfG834Rmvjf98cL4NsO1vKYATVH7qbFlv
X-Google-Smtp-Source: AGHT+IFRElYU/KSdQj6gvksHfb5N/L/kOA91LoLgQhb0WTU6VTAxYcNOCkcgNdJ7NYvydi9yp0l9og==
X-Received: by 2002:a17:903:19c7:b0:220:eade:d77e with SMTP id
 d9443c01a7336-22e5eddc7c8mr85104195ad.40.1746661365302; 
 Wed, 07 May 2025 16:42:45 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 02/49] include/system/hvf: missing vaddr include
Date: Wed,  7 May 2025 16:41:53 -0700
Message-ID: <20250507234241.957746-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On MacOS x86_64:
In file included from ../target/i386/hvf/x86_task.c:13:
/Users/runner/work/qemu/qemu/include/system/hvf.h:42:5: error: unknown type name 'vaddr'
    vaddr pc;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:43:5: error: unknown type name 'vaddr'
    vaddr saved_insn;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:5: error: type name requires a specifier or qualifier
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:18: error: a parameter list without types is only allowed in a function definition
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
                 ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:36: error: expected ';' at end of declaration list
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hvf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 730f927f034..356fced63e3 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -15,6 +15,7 @@
 
 #include "qemu/accel.h"
 #include "qom/object.h"
+#include "exec/vaddr.h"
 
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
-- 
2.47.2


