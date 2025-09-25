Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD1BCAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 03:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1d5w-0006tM-Ru; Wed, 24 Sep 2025 23:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1d5u-0006sP-3R
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 23:56:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1d5i-0004pd-Au
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 23:56:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46cb53c5900so4862875e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 20:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758772572; x=1759377372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4nUIMGczaS94H5pJHQ5mW+pLCjI7jGTuLrD/WrubOn0=;
 b=jWGx+C5QtTPMtWngP7Is0REK6Df9VFo//mtn3ru6mb7VB+sDlbBN/jaRVfwDUlq1cO
 3Mi7L0RvXdoQOOV5g4SQeqm5pIOYyYKEJxlDYNea24Rhw9L0YJ3tykQWMnfoHx0CbPIx
 FlY7BagT6YFEoz8pANe+rkx4XxlrdgUyJo0f0tudBJyNMMhPMFA3Tx24MMPMrl7UJfhY
 bx57sTCtQ4kw8UQL2qNcg+4fYdl18zYp8Bl2yL6VLgHYCx164b4bHRValMIX9LzL9gr6
 F1+nGU10I0rO7pofPDIrHBJfFcR5xXhK/9ae8bWTOvshS37uieFl6KswBmNTRG5R3gd/
 Z2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758772572; x=1759377372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4nUIMGczaS94H5pJHQ5mW+pLCjI7jGTuLrD/WrubOn0=;
 b=Jq9gXv6sk6IF5YmBO/MMJMMprQCp6lknQEO/siCZpgWG+fBmjDqeMMQF3Rl9iUZhUa
 IExaE1ZVVy0bAiYRTdB41sTohrkGZFDXE9148JthjNzM7HOcbxOdqvbKeDfHpWBa+D1a
 hUvdCDtdzPXieFdYH1UxyZ143XX89Wo9OnKS4qa3TDcMz6zaPy1uB8NBG5nmp94+nL96
 SMBX9vhXo85GYdMvGmbKTm16VYSsLC4bz31sFuRvBPmUf99Ky4xAisS6BLRmoYpYX+D9
 gWIJ60GwzFRX7XDgIxVDtSxiKZxw4CKj2SyZBwt3cGU54mBc8jM0qxscdZVYadgMOK/h
 sH0A==
X-Gm-Message-State: AOJu0YzlBpzWZfVKhx1yzMpsariAo/0HuTheHiq6SgGgDSCjfKi7nZ9k
 tBhDcUsyIxydIvusEkRZ9auIDWjTfzaU2uZXc7+JZdveSGhUCXE/l5sopRqYuX/Fwm4r+gjXLBS
 yqB5fooDRIA==
X-Gm-Gg: ASbGncv9ULlv1+Xh6XZk0ObMZa/Hanq3Rpn2EJHyO0WEO9uLQtoGJMeDaLsdaU1FI97
 F08uhvXRPFtYmV1UPKLdQ86nIvfxAwj6N93py0wiBmcV3XQdbMKC747BmFi1Jx4UOkyQ9br3K9s
 iPUdN/j7TdusPVWgzYi1LfMpHKtBRW7djCvqFDI6/Kive0Z1zQwf0/QNNWZmyiT4OYcvlOM1Q2P
 1YOTvPELJv2NSOPJBiSoHKwtO/O9SO/uRXs5pAEqpxMQJ3RXhJy8vmtQWb20i424kWMfmjzbrM+
 euKY+GyWfVk2YKapsReN05QsfJdnPOdD3rrNixLQyRSBFpi4exEMKLbMUHxAZwsixpw4SVHmKZH
 TgC3QwOlk6Wt5yqI+yHMJTpotVol5YyF/EKjQj5gCRAa4sW8jDn800LmiIipBPB+ytbKZXQHA
X-Google-Smtp-Source: AGHT+IGxCmNL4Z61p8hnOJa6kWqR1vD3jdgiOBxBpKlH5/7K/dC0yojkgxfdA71kDhDpk3r1RoqKCw==
X-Received: by 2002:a05:600c:3b8b:b0:46d:996b:8270 with SMTP id
 5b1f17b1804b1-46e329fb92cmr17363785e9.21.1758772572542; 
 Wed, 24 Sep 2025 20:56:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab7d4e3sm57024085e9.23.2025.09.24.20.56.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 20:56:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] accel/tcg: Trace tb_flush() and tb_gen_code() buffer
 overflow
Date: Thu, 25 Sep 2025 05:56:08 +0200
Message-ID: <20250925035610.80605-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add trace events to better understand the changes introduced
by the "accel/tcg: Improve tb_flush usage" series recently
merged.

Philippe Mathieu-Daudé (2):
  accel/tcg: Trace tb_flush() calls
  accel/tcg: Trace tb_gen_code() buffer overflow

 accel/tcg/tb-maint.c      | 3 ++-
 accel/tcg/translate-all.c | 3 +++
 accel/tcg/trace-events    | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.51.0


