Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF8BC0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 07:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tarUR-0007ZD-AC; Thu, 23 Jan 2025 02:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tarUO-0007YD-Mq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 02:18:57 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tarUM-0006DX-VR
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 02:18:56 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2163b0c09afso9612355ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 23:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737616733; x=1738221533;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dnbmNif4o9FGZl1LjI7Slk5zmQWIsYzZyTRTPo22AKw=;
 b=1Ml4+yUwynxmleGGG6G263127R3mRHMJTGEgIQ8FmnLqK266RlX3pbHYmc8Wy8a4SH
 QwfMAhENgbdD67vGHo33smto14GeF9Lr9zgXkIrKLJcF+GIZ0fSGXd7KJwnBVeNHCEeR
 FjBHg8O4ewpnKwgRsKd6vOUWQJQfEAv7iLfvpKFtiP344EatYJyNtbGAnpL4nGtLiaO/
 cKteE+eakNv/TOk+13nMhB/eCVhsNStJ2ED/ISy5fsAS1/KIKnlYETTyKE/6uGUTSULR
 ED1vwtsQ6eRCN79ux4CwcHMMgRY56rROE+KIq5a0CczGQmdfC1ihRQf4YcBkkflqGsKx
 Gnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737616733; x=1738221533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnbmNif4o9FGZl1LjI7Slk5zmQWIsYzZyTRTPo22AKw=;
 b=GNyMbdl56inCaXGxTDXgkUYEXJqj0guqu5GuA8Qgfi7HuCN9DX4vEM3J1Sn8YWu7Rk
 lkcVzQU8TDHjYAGUP8gZ++lt6eoN+xkbxU/G8gwrcdaC1B4Ri1H1XWfPagTt58BnGydp
 1wfeErUee2LtpIswvkMy+18RLaG37JGgEiiMguNkD2lHiOUyGoQ3Uy2yiBhfRMlHe9eA
 c452gmrzPJstkmO9un3lr/wFCDo5PXeuv/o3wTit1+yPUSWpqpTtXNomnPhA4PzUHOub
 jeZrr5izBauE/SDyHY33FLEPVtn4P/8jRKE4C2GISSHDk3wj5meX5eodMvfWQqgeRnAR
 uXIA==
X-Gm-Message-State: AOJu0YxWh3R8tVOu26RyiOAnLRUs7dJRdohoDmt7q0yuZLCdwy0iu/01
 qOL9S8koI/tAc5JZD2rrOnJYVS0km1ngpwllMjZqQ5QgLKFA53lnRCW1bav8FPU=
X-Gm-Gg: ASbGncti6Qzo3VWJMtyIHbzRQnSQjfruGYHmLopw0zsD8UCbKGNeKT4QUlGku8S/qzt
 3D3jb14iCfgTQrqK+JirG/aaLxVpBsjL3xH6RTl+G1GmD+G0zjFVdb2MUU3PEoMMYtUsseAJlG8
 47kV/IiS/8T5uuCSOQHYk+IFx/b8j12GJkTMjenkSGReliO6YkRzLs8NfTo/cl7Ted6Ou2rLDHy
 ZLDUxf5FkF9eT2z0THWM3zJ3hdxEGgAVnj33VjHPwpFY1J79uW4t3swOdrDVjlZJPbDaw1Hl0Mx
 0fzh8InF
X-Google-Smtp-Source: AGHT+IFuf0ALdxA2AAO9i0FcV5uXd+RctVpJCLDnzAWVPnd/JBJrJFOPK1SIIbhwBh4c+eDiNSTyug==
X-Received: by 2002:a05:6a20:2591:b0:1e1:e2d9:3f31 with SMTP id
 adf61e73a8af0-1eb2148df72mr35037552637.16.1737616733530; 
 Wed, 22 Jan 2025 23:18:53 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72daba46239sm12329319b3a.123.2025.01.22.23.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 23:18:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 23 Jan 2025 16:18:32 +0900
Subject: [PATCH v5 4/4] coreaudio: Initialize the buffer for device change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-coreaudio-v5-4-6873df4215a0@daynix.com>
References: <20250123-coreaudio-v5-0-6873df4215a0@daynix.com>
In-Reply-To: <20250123-coreaudio-v5-0-6873df4215a0@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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
index a8d71c6cf816f7658037e26608a4c1101ebd071e..9edae3d7443a57076781a69dde522cdfcfb77662 100644
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


