Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB9C021AF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQQj-0004sU-Sj; Tue, 18 Feb 2025 11:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQh-0004rl-Ox
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:39 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQg-0000jk-B0
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:39 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4398ec2abc2so15158635e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739895996; x=1740500796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BmvUlbgMu5QXQdotks4SMqmfKLjL3YMxTV+8+DmV1vQ=;
 b=l041j9rZnukLLA8bx5sI9wAd9uyoCDYFskGl2igA1SGn5qZ8iDDz831AtHQ313je1Q
 TURNWigDFWhLZQbTf97QiNig/vYxA+rqGzrQ72h27zssGVE3eOpYYKD+BNBvJy7szQfA
 86RTVRap7pg6FaEI3zh8l8V7oKcoqKiLNqDamkba8u39BGMAs6Wvb9pZ1vE7J71VrVJc
 uT/i9GsM74DTViu26hP9rHZXMHkBNNx6Y+Z0x3Ura67QEX52i9SOuoQzF7kAA2pd0Ekd
 Nb6niXnTFowMw36BgE4fwkfsnl2OfgBqteOdSlOwPvk5AlqTO3atoSLoLvaNFmvWi0pa
 a5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895996; x=1740500796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BmvUlbgMu5QXQdotks4SMqmfKLjL3YMxTV+8+DmV1vQ=;
 b=bOFHgX/xMlxh2RVXdmYxz7J3VJWwGXxgYHqS5+KY0UGxwzICOr74C7u8fhVXzTSgug
 mWTo0KDOVDh+yEP948tBZqecLdvHXNnMgDSjzlTbCely4KQ3uTubPmXdzpEVKjyZo9cW
 waExUO+MJXFf+efQmbgUAd8MZo0OC+773rcqcgl01dCDXeOcVOjW2Xhrrr08vzgtMnZW
 PIYNh4piYJ4fRoy7uiKYNBsZ0wAZm7Bdi0BIIkMfi3HAbvEgSMEiMzWezu0r2OeBXrW3
 9p3Tyc0f5HMSkDFZNcIO1337SPi03fTPEmHDuco8JXqaHEwUSa1LblN3Xof6cO/uHKRM
 96EQ==
X-Gm-Message-State: AOJu0Yz1nFyM1t7teyl8HBTcuQInhc3j9SsIi6fbifGMXT4rrBKVcUnW
 84bZm9VEKbzQ+D5ueC2S7hymFTg7SOWg8zqbxbLCieMBH98Yjhg7JUQRffgo80+dCiM30Qz413e
 KiLU=
X-Gm-Gg: ASbGnctZC4yF609MbHyavsUm1EERL+hWVYVhul94LVuGTRHUvakSyOzkPLZPSPeewNv
 OWEF9aB+PeguT9+wAfkDJckMUwO1a0f5FqPCiqKsesbp5YQH/d5z1c3h8MhaLZSGcXhl3C7+Dhs
 3Vw23KkMs8cgHGuRp0MOZL22JQ6kGwC6zl/8p6aMMccnFhIAZrc69+Hhb0rxczHVT+PLljjc8S+
 lzKLOknhpf6jfAmpTiCOg+bY3aza3ZZD6uENsA6jKJte0VCaYjMmnNgtfsfuSgNMko9SCvQ/goN
 G2mh1Q1sxxqE71yajXlLPgDMt1L+3fPGUcXIysKcaDYX7Alj0Iz0Vs+97lnATofSTw==
X-Google-Smtp-Source: AGHT+IGDpjA1jMRndJ8zzyh/WqT4n0dcOTmIjm+pFjuPp+1wE2F6F3aH9+wQEgZeB7C8Blu7KKErWQ==
X-Received: by 2002:a05:600c:35c2:b0:439:5a37:814b with SMTP id
 5b1f17b1804b1-43999dd216fmr2597845e9.20.1739895996546; 
 Tue, 18 Feb 2025 08:26:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398a44264csm48836645e9.25.2025.02.18.08.26.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Feb 2025 08:26:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Thomas Huth <thuth@redhat.com>, Jan Beulich <jbeulich@suse.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 3/8] hw/arm/xen-pvh: Do not allow specifying any CPU type
Date: Tue, 18 Feb 2025 17:26:13 +0100
Message-ID: <20250218162618.46167-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218162618.46167-1-philmd@linaro.org>
References: <20250218162618.46167-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

No CPU can be selected by the PHV machine.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xen-pvh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index d1509bd235d..2557d520307 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -53,6 +53,7 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
 {
     XenPVHMachineClass *xpc = XEN_PVH_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
+    static const char * const valid_cpu_types[] = { NULL };
 
     mc->desc = "Xen PVH ARM machine";
 
@@ -75,6 +76,7 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
      * mc->max_cpus, QEMU will bail out with an error message.
      */
     mc->max_cpus = GUEST_MAX_VCPUS;
+    mc->valid_cpu_types = valid_cpu_types;
 
     /* Xen/ARM does not use buffered IOREQs.  */
     xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_OFF;
-- 
2.47.1


