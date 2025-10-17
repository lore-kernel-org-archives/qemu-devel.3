Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBF8CCD1A7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 14:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9lCr-0004rI-Rh; Fri, 17 Oct 2025 10:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lCo-0004nq-Sf
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:13:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lCQ-0005hl-LA
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:13:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4710022571cso16790895e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760710370; x=1761315170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqDslS9NKjHnUWYR3Oq3CSi9/FfiBOz9NHEnZxcZS80=;
 b=GnkqAxWl1yv5KVAZIaDW+SjmxQd+0rEjWu2xOrJIel5hpX/lMXKyjNzd6aq6ELLgza
 4K2mMbfSpU4ng1Nil0rjcNVvrcYFG6Pg/p09GAilpcsXDbcSqfGDdM8C7O42Vh5G1exM
 XC4EHgswbFdziIzFoLN2f5vSTBeZIELMGUpdq6y2Pr5MbdGwJX3IZSb1YFNsw5e+S7LG
 nkF27u7Ju3Ih++XlRaKPn4EcnCEinWtVrDM48dnCgLHCpM21gY48XJdEXrR879XxAdQW
 GeIP4lV3+VB48Qi4N/NMuvjkJQy5H1Z6Jf5xe6E3/JvG/RuAPJ3AqJ3ji/xo+yuCNBEw
 6nBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760710370; x=1761315170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqDslS9NKjHnUWYR3Oq3CSi9/FfiBOz9NHEnZxcZS80=;
 b=ZqZ6RvKewCmL/Hd0qLC2GQI+tMR1n52T0yehJbrRud6vdw+PJIwJil/V4esJjwwDAQ
 ukkuDBbeQ9B64KEDXCRvg9UTUPgRQ2mkhokjlewYReuP2ogkI4GKlAhvK3NtsTZosIwy
 cPLmLCaE+twb1Q7wFrqiDoj9FnddcPaOW2sJj7QKFLvd3j1mRgtg8/t2aMfJNu5/RT48
 DL0OeysQNn5ifU6lej0Ad0TOqN4uXm7JNGH830TenIjIaoAUi2P+xW5TvELPieySPsse
 kES3oX8PQpBufhErY+MSHqPGtMYoXb0kv8RCTpTB14fKSdSb8TweNM4XbW/RoAGh6fl3
 q4Ow==
X-Gm-Message-State: AOJu0YzGdVm35IVFzErnNncaA2lyNhdAkdmoB/bfDE75dE5PsF+zImcV
 cuLQvNYZ3W7wP9JbUqLGiOU32T5YYmbN8nl3osRrBZjvhzIQmE4Ehh2nIFtjGw==
X-Gm-Gg: ASbGncth68wE1gs/b10dxrEtWBR5V1nZPeb60+dWKuDD61CtmQwcdC9/JMrcHlXPQiS
 goj3MJfRHFLdinBsao1NHljMj2rbrZzKWiMRSxmHbs4PVFr2RXGrswZwzPSNTS1qsOeiI6bsrh8
 lPhOsz4tbzcqx/+6jcRc12TdzBaBLSC510ZESEiYFvSGtb/fzGb6HHELHYLWtS/5+/IkRML6L2f
 4ekEbqPqT+NqvLazci33X0h0+q5T2S7pbkBqU34k0pfbPBaN3BSWXkmhxZJsEwfFNNXISmdbfXQ
 N7Zl7x1/tcb35i7+0+xt6tcquvclrYt+wQJBGfIKWdqNXT5ChP5V5u3ofgQEwoirahFCRDNGR1+
 XqqyH4qElWFOItnzvweso39ExBJqzyJq/7b8YMw+Op1I1v6Ap1vn8GnxQ7nQp5F9RQxzcGP7eLZ
 UD2ypM36AeVc5lj2RcZgcoiElF6gn7ZxdF
X-Google-Smtp-Source: AGHT+IGYs584RAcS+bQviT9zSdPD1C3R1/CztDsteU1MEMn/nBmYwej5QPyS60IjXtCNMrEecg2MBA==
X-Received: by 2002:a05:600c:64cf:b0:46e:3b81:c3f9 with SMTP id
 5b1f17b1804b1-471178a80f7mr25809605e9.17.1760710370235; 
 Fri, 17 Oct 2025 07:12:50 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cb36e7csm51359675e9.2.2025.10.17.07.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 07:12:49 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 05/11] hw/rtc/mc146818rtc: Assert correct usage of
 mc146818rtc_set_cmos_data()
Date: Fri, 17 Oct 2025 16:11:11 +0200
Message-ID: <20251017141117.105944-6-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017141117.105944-1-shentey@gmail.com>
References: <20251017141117.105944-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The offset is never controlled by the guest, so any misuse constitutes a
programming error and shouldn't be silently ignored. Fix this by using assert().

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/rtc/mc146818rtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 5a89062b4c..8631386b9f 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -726,9 +726,8 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
 
 void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val)
 {
-    if (addr >= 0 && addr < ARRAY_SIZE(s->cmos_data)) {
-        s->cmos_data[addr] = val;
-    }
+    assert(addr >= 0 && addr < ARRAY_SIZE(s->cmos_data));
+    s->cmos_data[addr] = val;
 }
 
 int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr)
-- 
2.51.1.dirty


