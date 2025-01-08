Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16ADFE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUI6-0001ag-I6; Wed, 08 Jan 2025 06:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVUI4-0001a3-18
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:32:00 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVUI2-00043u-6v
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:31:59 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21619108a6bso230303835ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 03:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736335916; x=1736940716;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9UbyiJZ0O3OUj3MNcXOU8MC+tnB5FkSSR8mSCdPMh5k=;
 b=vuw27fz6ewiBuM+tQPMWVIlYkSgvjm6vRtQrGi/l6ZLHbg1VprUtgBCB/0ML/1bsHr
 hMD486oFPOxnI5HaWlTS8P21kr3Jl3hexCeex0+T6qeS5ux1ZZJ/NKnrmO7pR49pqUIJ
 kZ9ZyRGKFJzo6KBVApliTCOlMHtMjFMjSyvWaGd2obzO4xFUAopywNkpxMyTbbjPTkka
 0kBtvSyL5UqOZbAZBcy+BVuVpBnALPZC+OmzlWHEwVvfT5JOjupNNc+sLiTb6nUUrlwD
 K1kMdKu/RsqpAnYywKdRZyyz7qMDlTMExg/hXO4mcxRFs8qUc643hBsw04a/QWTXNcZX
 D4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736335916; x=1736940716;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9UbyiJZ0O3OUj3MNcXOU8MC+tnB5FkSSR8mSCdPMh5k=;
 b=MCMc0NBoFKe5ygHeOSCoTP2xU65D+pqP3DD+o0djnM3059EGQOHBVxXAa8pghsVN7i
 VL55pj4XlgbX3JcDTjTrx8XmKlqvFv7C8ZcYW3WE2uKklIbkmFcLwQ6vAPL+bbtdkH5D
 Y6BYkM+URdSWJIiW+m4VP7gw8HYRIim4f0ID5utaGNCGyCsnalPjZ2xV3jT9lPGOUVk7
 ykfI6ghs1EhzmwMC8yI8S58Hc7TGTLqZyv1tezmQRaBKiJXhpatDcnTBug1tia6UrDhE
 y2+RuI/Ns2tQWOd9nC79M5TGvTSmCjdrAZA2DsHo1ayX9InEpJC3cvZFBVGfJp2XW+kc
 VIUA==
X-Gm-Message-State: AOJu0Yxx3sUI60CTdsK3DLzOXXuZPRSPu1iFUHODkvU+WkCbBw5sjsVR
 hLLZYJG2x9xqY9G17OrVw0jiDMAqc+jgjkSH5epqTrIev6eeTml6886Yv5oR/rENlsBaa2djpjP
 Gdms=
X-Gm-Gg: ASbGncvFDwJ5uuyXnNJSX/gmKc+rxgj2oui38O2YEkpcr42avt7O0D/igS/CQW2FOh4
 4vvwtZEsojVgzEgOaNlGMiwbgfyHyJdGnGCGHahxbFvjfKUm0Pz0H/I++WEJKlAWpDHcsep2TUv
 DLMtAANoNQ+BrLtiYCBkAmp+QT2nSl08YXOWF1yMfUj/w6R11GOZk++GKOvsm/90nwN4X9rV3Xa
 hnYYMPA+91nPqfsNq/hrhc1Ebz+xzeoa+WpVlRakYvQ1qUK0yH3+FW/+Z0=
X-Google-Smtp-Source: AGHT+IFjbLv0yYtDZhYOUbUk+RiAnuiH9B+yaQVkZsHf7c4nTX3dx7Dea2B2DkXLUUsZFDP9CThMbQ==
X-Received: by 2002:a17:903:1248:b0:216:2dc5:2330 with SMTP id
 d9443c01a7336-21a83fd2400mr40975575ad.36.1736335916504; 
 Wed, 08 Jan 2025 03:31:56 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dca01450sm323986875ad.230.2025.01.08.03.31.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 03:31:56 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 08 Jan 2025 20:31:46 +0900
Subject: [PATCH] hw/xen: Check if len is 0 before memcpy()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-xen-v1-1-3f95cd358eed@daynix.com>
X-B4-Tracking: v=1; b=H4sIACFifmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIyNz3YrUPN20JNNEQ9PkZIPkRHMloMqCotS0zAqwKdGxtbUANjr9r1U
 AAAA=
To: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

data->data can be NULL when len is 0. Strictly speaking, the behavior
of memcpy() in such a scenario is undefined so UBSan complaints.

Satisfy UBSan by checking if len is 0 before memcpy().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/i386/kvm/xen_xenstore.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 59691056670e..17802aa33d20 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -532,6 +532,10 @@ static void xs_read(XenXenstoreState *s, unsigned int req_id,
         return;
     }
 
+    if (!len) {
+        return;
+    }
+
     memcpy(&rsp_data[rsp->len], data->data, len);
     rsp->len += len;
 }

---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20241227-xen-fb5a15cc0ca7

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


