Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C12C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 04:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbBbr-0002F5-Ah; Thu, 23 Jan 2025 23:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBbo-0002Eo-GL
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:47:56 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBbn-0004cH-1A
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:47:56 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-219f8263ae0so31615675ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 20:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737694073; x=1738298873;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6ez9apN9lZeka8SxY6TZjMinLRnJzvs/6Urk4IfIR58=;
 b=J+VvZQEyZgrSmJ3/k2srTLzC9WjxrbW5utHp+M3Yu+c2ELBtfyGRQW+6poVn79ABnE
 YZh4Ey9aAa0Ys4ij6kzRfytbL7U1lGIr14jSdpa4xiFkt1SBQqcZHwHJVLlos7SyowkV
 hRMbOiNopM+XcX0KmU1zMiLh4jcwdebMaBGqAAqWo8AHUOmZsg5tC+HvZPUb4jjeK5Yi
 hmfdzPynEMNovZtsIg31Mz8iwgcajZ9eQJm8yrctFuaFUc5XsrXja4yM8Ndtn+Y7lInX
 QEY2MKfZdETrWOqfylLtnS3L40YxTq5eGPdrllcE8FwboREiuP5oNDYt4vS5v6C5peU8
 qmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737694073; x=1738298873;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ez9apN9lZeka8SxY6TZjMinLRnJzvs/6Urk4IfIR58=;
 b=asBq2l52UAAWLmk7rZSiGJZjWMwZN6cAh8FKYzmH3MQ3UeXoz3/0zG1BEX/3br2YXn
 STgNiAyPRh4+EOI/GZl456FpunOofLAgJrSfIJo8bSPGClLVbXVUeH0qAVlf88yF8836
 4SkcQWU4kJ2VRheD9ZWf4nfZwYG8knzO3bjnRstCnWp1GsgkRCA6iAAh5adYEPGCvP9k
 rCdkTTlEumj39zDJ9/JSQ5JgjN77Bh0szso22Zzsk1C/zHtPRGr8/4eFINXHLTmXYWYe
 pj133B9i9FqkJXz+nFkOezyx0JmR2IrORt265zI6fEZCQeWge5nFr1kyOvYk5E1SSovP
 U0xg==
X-Gm-Message-State: AOJu0YwmBoLP+FOX8lth+5ncfyOMQBa/6J01O0vyWq3h4a3MvGv9bR51
 orHZIsEVY+8LLvSgeo4RKvublHprpJbEYxDh/6GShaBjZAyREDlpAU2vsSAc6Fo=
X-Gm-Gg: ASbGncsSpFiv/U7jvqS2j7mmWcnJrComydKy3/WgNhMajTvbHNP1IGXJZwhhF0cccxn
 WhtaA6SoUFcxFDX1NyoNaaup+u7tvUy8k59p3EYlTc/Hpa44UVCAYsJ1ixpV/b7000w7yY0xadF
 ZndVcXOeRs+fbrtX0gTHkcrDHC2TOJacno6MtpTZNtA/Qx1DpESJfFNL+/IOwlmFMsGFcqahF8C
 ShUD99a7Ujdo0gjR0+/IzM7OU3Ub4fbSafceE6igDfX/EyN3eLMni0mR4Qn8hR+VVL/AgaGbpX+
 yiMdIoE6
X-Google-Smtp-Source: AGHT+IF0oiJ0lCG3YNEFI0fRiEBrardZzxC42QtzY+4VnY5cFYt/mGw9/gbPJ+ZwDNfpXKiSbxvdXw==
X-Received: by 2002:a05:6a00:244d:b0:71e:6c3f:2fb6 with SMTP id
 d2e1a72fcca58-72daf950b94mr48574479b3a.8.1737694073622; 
 Thu, 23 Jan 2025 20:47:53 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72f8a760e2asm850203b3a.88.2025.01.23.20.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 20:47:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 Jan 2025 13:47:15 +0900
Subject: [PATCH v6 5/5] coreaudio: Initialize the buffer for device change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-coreaudio-v6-5-11fbcb6c47cf@daynix.com>
References: <20250124-coreaudio-v6-0-11fbcb6c47cf@daynix.com>
In-Reply-To: <20250124-coreaudio-v6-0-11fbcb6c47cf@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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
index aff2b37b12aca723849645297c04f30ed365b8f8..2ad47dcbbab338f2791251297202af328b0baf49 100644
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


