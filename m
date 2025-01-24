Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AB6C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 05:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbBzr-0003Ng-7g; Fri, 24 Jan 2025 00:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBzo-0003NY-0E
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 00:12:44 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBzm-0000Ja-D6
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 00:12:43 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so2466038a91.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 21:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737695561; x=1738300361;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g+lXBbs5YuiYag7M+LKLMwPIA9V9eQc3hh5ELptHd08=;
 b=lSYpWwlq9jYof58bB6qIX2aiwRcZ9plw2Z4hkZvMh27sZNYOxJ1S9B30GPDG9irocG
 qaVvH11kmmB4Q3TyQshA2YNUyHE0h8ypyOqrOyHUvwRVbZnO0TOIc069m5jEXl53CxWD
 DejJucf51H4+D8egbeD7GJJk6dCVRSCCupqkNE1FUmZ+1zvCG6v/6M2Hv4BlVHinukki
 nJv465E4GJaBxDjUoTbE+FJzYdYHiJ2/5V0YgrEylnxIYNZMSkgxdEe2coBV/Vy7Sav6
 AOhAhhNoPVNzyjzuGdgF2wE8d+d5WS6EeZQIf8DiDpAjtRR8FsmWhCX+J9t63AeGsEx2
 qq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737695561; x=1738300361;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+lXBbs5YuiYag7M+LKLMwPIA9V9eQc3hh5ELptHd08=;
 b=onGLhhftK1aoipJeDTxxxy2cOXvgWIeZfvAk7Pik/MGGQcUbJo8KqVtTVoKWquvkS8
 VvPbtNDaNwtACqndvgBR1U13a/nATjlOtyxnSY6ki6kchx37s+yqnT59vVftMI/Y3lhU
 dbLTnHhf+yzDrgu2IItQChDdRer4P9Ve4V7dZEgRDZzeUuERmXtjcmbL8E0w1EIBcOsN
 15yf8EbYfFTRet/wXyjSpqGmmQOFyTxYTam0XD1xLdLVpw3EoLdFHh6eEB80vLufb2lj
 dvALMCm1aqtHd9K36fzt9RJdyZzU6YLL7e8iQDG8Hr40P4TQfhYHxI3at1CBKVe5zw31
 o0cg==
X-Gm-Message-State: AOJu0Yz5r3gphBx8svBe9WmEB/EzosG/63KaBNoG5JHXBpjmLHXP5t+K
 GSeQQA3rJZSIaWE4CEyJ8rD+RjqfRmPNUBZakjPS2FTJUJBTNy8M3t/bGwmIgysomSJaGMqQCh4
 x5Qo=
X-Gm-Gg: ASbGncsK8xsWOL3bN4u9GbD6ca6UFvwmn+cE6erYC0szrkzlH8Nn1DYK5bZxD1F+9xa
 5J0Rj+W+qgNBfPLMquVzC39EAmry4P1SORsTO/uHR1PnoAxWzMeJXbhRuVEWXiaPppZ8A+Y9wUG
 pQPPTkw+YxYt7Sx03hSWemt6yp/fJYaz5Nqk+Y5MzGOQE43y3vwwAvgHMWDEJI8qEatBRV9tcUB
 ich2KEgplvl5bX5OaIl5DSqPZlbnBrDwu3rKCuv5H8H4T01snbua08PgHkUtGhRJ7l8NZIMF+tO
 uffqVdTz
X-Google-Smtp-Source: AGHT+IG5GA3c262fmfqBYrYphoG3LFLWJZvCyQi7pnvD/+6bHwYIQ3K7scFfPfvQMNVUbT91Ffd7wA==
X-Received: by 2002:a17:90b:568b:b0:2ee:90a1:5d42 with SMTP id
 98e67ed59e1d1-2f782b179efmr50107278a91.0.1737695560854; 
 Thu, 23 Jan 2025 21:12:40 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f7ffa6b315sm667914a91.26.2025.01.23.21.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 21:12:40 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 Jan 2025 14:12:09 +0900
Subject: [PATCH v7 6/6] coreaudio: Initialize the buffer for device change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-coreaudio-v7-6-9d9a4d91db37@daynix.com>
References: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
In-Reply-To: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
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

Reallocate buffers when the active device change as the required buffer
size may differ.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 audio/coreaudio.m | 1 +
 1 file changed, 1 insertion(+)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 43a5f837ba4cfe4464eaab8f1693696638e14113..6ca5c038c9fc176238a9d845e8705177c0d2341c 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -467,6 +467,7 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
     core->device_id = device_id;
     core->device_frame_size = device_frame_size;
     core->hw.samples = core->buffer_count * core->device_frame_size;
+    audio_generic_initialize_buffer_out(&core->hw);
     core->ioprocid = ioprocid;
 
     return 0;

-- 
2.48.1


