Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C94C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQRA-0005bo-0S; Tue, 18 Feb 2025 11:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQR8-0005Yu-IP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:27:06 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQR6-0000oT-Pn
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:27:06 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4398e3dfc66so16163555e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739896023; x=1740500823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8Njo+qOXhV4Sx/ta7KiauuSaoi71X4Ex5TI1JyVyyI=;
 b=JJlkYZjDHy1SyWYNS0ofTXuL3jnbHk9TyGp+zaNdP+RZnPMhUf9uF9vncrgpTt8293
 jrNPP78tE9nFy66qTC6ONF8xRcNDNQuv0azituwdkofRsH1QR0ENwxD0t2ud1eA8/ox5
 P0hYjnKwlxfMPMWT6j/0JEgxcmkfUAQHhoOJ1CftW3FhqwhcpjIFKFB22p8SDRyX0K6o
 MXAdmT2PYpCdwWlyJqFpgwLxaCPetRfUk06OgfxE4ErFC6oj/f+aE4lyZsSmP+6GUlHE
 PHOACDuDDZPSuyALXI9/fKzuQ3y+W/uj36+NTVTk1aM3imZX9rntSY38g4WUezERfzL7
 DeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896023; x=1740500823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8Njo+qOXhV4Sx/ta7KiauuSaoi71X4Ex5TI1JyVyyI=;
 b=uxJlYv7mO46OkVTBVMVA9soUKCP1bHtaP7pjDzfkAJtdvRy08A0lg47TQ0YNdr4x1L
 r25aRSXyscjb4VwSdLZ4FSkIsaDmvmaeX0cqE0bmhzAYW2YwJRArSh0k12+jFohoWxaW
 vudkatD92Aq4KrayDX5jX+xk9upVuEtlh8Tttah91zjiIqqcoMFW5slGfExtbbid/SOJ
 IV6F3RHXqcy7+qaFPMCGlPA1OkwhNRyGVjSkmHy7BAZZQP767fB/CNiZQeVR361GFHRG
 SyD/TIVpsj6PF+3LnRmm35VDzuYx0wdjp/buomvuGbG8YOv/hFHWARExwAb7CTyoYbgL
 tV3g==
X-Gm-Message-State: AOJu0YxxZKFzHbec582wo2NkPNhK1IA/ytI2Opi1ksmPY6u2u+wKvYX7
 gvuPpp4Z7l/ZaQ0WTmGIeKweUsNEE8IPiuXrKXoOmbaQh5TtmDuKOSukTip0QaLDG4pyS2F5etb
 PN3g=
X-Gm-Gg: ASbGnctWUbX9FA9eZ8sRKS1dUYseiVtYVmaz3Tblww1mQxKMds2aKXmBsi7zNcWFUBm
 snPtbqqE4oKwZn9AvkoMNgTfOmDwzgAaj7w4rewcrqgW2bRFNlpC8WFzwQK6kn23gFSWvgIchp6
 eFYsbKLsxQ58jn8AVASHmK/E3XCSrN1vo9BeV1wI07EYRyfbr6eI/5eshPU2t+ItYSvk3JBvhro
 Igbp3Hu1f2nrDS7Am4XDzA5Z2U7aGcI4spexexBmNPJoiaC9d7c5eBL64hQwV8kS4yR9r7aAKSI
 VROnE2GPUSPh7wOnpvyCvWRxrm5GVBh7m8k8HwTvCZ8wwWDf3RWsueHM3LCDof1Jeg==
X-Google-Smtp-Source: AGHT+IHNicWVQy20xmctK+WaMFhMn6/Qp3O5JrlTfAC9l8cTOsGhr1pxbbnLyADgvxXG36sDv5n1uQ==
X-Received: by 2002:a05:600c:4f55:b0:439:95b9:91fc with SMTP id
 5b1f17b1804b1-43999d8b49dmr3064455e9.12.1739896023034; 
 Tue, 18 Feb 2025 08:27:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398a44264csm48848305e9.25.2025.02.18.08.27.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Feb 2025 08:27:02 -0800 (PST)
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
Subject: [PATCH 8/8] meson: Remove support for Xen on 32-bit ARM hosts
Date: Tue, 18 Feb 2025 17:26:18 +0100
Message-ID: <20250218162618.46167-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218162618.46167-1-philmd@linaro.org>
References: <20250218162618.46167-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Per Stefano:

  For ARM 32-bit, I do not think we ever had many deployments,
  as most are 64-bit. Even when there are deployments, they do
  not typically use QEMU, as QEMU is less important for Xen on
  ARM compared to x86.

The QEMU project only test to cross-build Xen on Aarch64 hosts
(see 84eda110792 ("gitlab-ci: Add Xen cross-build jobs").
Since 32-bit host aren't tested, simply remove the support there.

[*] https://lore.kernel.org/qemu-devel/alpine.DEB.2.22.394.2502031438170.11632@ubuntu-linux-20-04-desktop/
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
While apparently running Xen on 32-bit hosts isn't straighforward
anymore (see [x]), we don't need to remove it ASAP, it is already
in the deprecation queue since commit 6d701c9bac1 ("meson:
Deprecate 32-bit host support").

[x] https://lore.kernel.org/qemu-devel/173d18bf-f68c-4bd5-b822-abb1c1f0c51b@suse.com/
---
 docs/about/removed-features.rst | 5 +++++
 meson.build                     | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index c6616ce05e5..f6ea53acc8b 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -969,6 +969,11 @@ MIPS "Trap-and-Emulate" KVM support (removed in 8.0)
 The MIPS "Trap-and-Emulate" KVM host and guest support was removed
 from Linux in 2021, and is not supported anymore by QEMU either.
 
+Xen on 32-bit ARM hosts (removed in 10.0)
+'''''''''''''''''''''''''''''''''''''''''
+
+Untested for more than 4 years.
+
 System emulator machines
 ------------------------
 
diff --git a/meson.build b/meson.build
index 8ed10b6624e..7b80d8dff09 100644
--- a/meson.build
+++ b/meson.build
@@ -308,9 +308,6 @@ if cpu == 'x86'
   xen_targets = ['i386-softmmu']
 elif cpu == 'x86_64'
   xen_targets = ['i386-softmmu', 'x86_64-softmmu']
-elif cpu == 'arm'
-  # i386 emulator provides xenpv machine type for multiple architectures
-  xen_targets = ['i386-softmmu']
 elif cpu == 'aarch64'
   # i386 emulator provides xenpv machine type for multiple architectures
   xen_targets = ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu']
-- 
2.47.1


