Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BFAD6E2CC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIaw-0006Va-Lo; Thu, 18 Dec 2025 13:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWIae-0006Q2-D8
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:19:07 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWIab-00034D-Hj
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:19:03 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso7247995e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766081938; x=1766686738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVD7KeNHSoZXyk7/Vq+5GFFpep3i4V4TnIDs7GSc+Ig=;
 b=PJ1fLip4iN0iWvuoPWWWMS76ALLXbphvsg/5iZeBJMvco/8GFsIYnio2t2Bi1V5w0c
 7HCtowB8DoTUxsYOacbGnBdIcWXOfHvsxUap/UfeqmhPNhxAM6hs8poQ/LvZirhuiLva
 lcyC44ERb3iEpRqOUvJiii8VVN+UmQQXO/Y0kd6fQFzyLHGtE8+1bt5/4M2BpSBfoJzs
 u3KnGApmVjc4Q/vruH23SAIu4MR6yAYRl9vDbSDvuydretMBQ8IVKb0VHjkTN05oW1Re
 lwgdIc60ejwgKtxFh1c1SzJmo62DzOZdCFBbZBGs4H1Gh32NLTLkeeT5X7o1OZkO7GM6
 9muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766081938; x=1766686738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KVD7KeNHSoZXyk7/Vq+5GFFpep3i4V4TnIDs7GSc+Ig=;
 b=U+GotEJayVhPYzEv2Vr9QQRQcuYRokuhVc9/2eae/HXJq0oZrmJvaucWidqCzG3p/C
 +CiKuxPElVzj65KdK6y2AcKcfDjWdeJO7FjIYUu2ndC9d5u1dg+zsXCiMKROZdWUrQUI
 ryWX60Avubd2/PB+yIQ5T8zRU8z//FGPs0fz/DyOYub+lnR678e+YClHDr4s9Glju4Re
 HsAtClY7OFkk8ebxRD8NyqwPQFrwUfcJyfm03v759fexsxz+Cfb0XoI3P7QMvm5Q2Uu4
 M8gMnXO/Ov1CUwQZudLVkSsReLrItQ4x33Aad9rmT+yzQSX3RHhpJWYzb2ycW+2S6dyS
 kFvw==
X-Gm-Message-State: AOJu0YyHEuN37I5Y96W5hJJfqLlMC/ueexem6RKa3sEu4UZAxK1jdRaz
 AHdHC06U3HHuSQX//R9fyCgb5s5VhW0YzelD3X0Wr5SFSDdi+W1vdvLk6nvykFbAbqrnz+8/1u0
 O/VsvEmg=
X-Gm-Gg: AY/fxX5Rj4mb/ExTBb1CSq7sJBJWHL4CyYpXSVivHvYikEF8efWFTdLfwoWrP70+ULD
 /5eMoN++If4AdB93DQRjRg8nO5gkb+CKt1GcHgSF+KGqInnK7dSEYWncY4ZeESNsrNCjGMGjJqS
 XGvIdW7aMGvX7gpWWFgCyIzFPKgzl2HN73fxOfxFr+0awOrjpddiKXpYg77vYBMrDq8R498Dw1P
 lg3fnENm04W4YFW3k5W/igC6+MgyXPUspA6lN5MqsobGG3FF1KCB9Gc9m0xzoUyuLCNT8rcfTsY
 J2AKoXcSZ+TAxUwRfoACm2eVgD95DPliOJBsL6z7pN8dlZQzfcCBfv0mTFYLhgm++j9aPlHyIpC
 z18g+LZ0+5MqYvGVRIXWEDLkBfVn1HEWClWFB++6JciTFo+QYy/Ds90siYubTdvP/12bPMFO1fi
 m/pmlZYu2+Nd8c0/AE/gs0PILIEj8oxiUUpDnpt0WUvQrrVhILxcy8kiyhbK0M
X-Google-Smtp-Source: AGHT+IEQS04J5k9ys7VUrixvOqoIfqYL77w/GAjeUbl8nGYnPKg+ydshN38AfVjuXuWkE2AFDKoNcw==
X-Received: by 2002:a05:600c:3489:b0:479:2a09:9262 with SMTP id
 5b1f17b1804b1-47d1953dabamr1379125e9.9.1766081938576; 
 Thu, 18 Dec 2025 10:18:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723d19sm62333055e9.2.2025.12.18.10.18.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 10:18:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] rust/system: Stop exposing bogus DEVICE_NATIVE_ENDIAN
 symbol
Date: Thu, 18 Dec 2025 19:18:11 +0100
Message-ID: <20251218181812.58363-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218181812.58363-1-philmd@linaro.org>
References: <20251218181812.58363-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

We want to remove the bogus DEVICE_NATIVE_ENDIAN definition
(by only having it explicit, either big or little one). Stop
exposing it to rust devices to avoid it spreading further.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 rust/system/src/memory.rs | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 4b3316bf767..4e06c16a0b5 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -78,12 +78,6 @@ pub const fn little_endian(mut self) -> Self {
         self
     }
 
-    #[must_use]
-    pub const fn native_endian(mut self) -> Self {
-        self.0.endianness = device_endian::DEVICE_NATIVE_ENDIAN;
-        self
-    }
-
     #[must_use]
     pub const fn valid_sizes(mut self, min: u32, max: u32) -> Self {
         self.0.valid.min_access_size = min;
-- 
2.52.0


