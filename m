Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CDBC3601A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWh0-0006dD-1F; Tue, 01 Apr 2025 04:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWgw-0006cw-MD
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:09:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWgt-0005hq-Fq
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:09:48 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so4321021f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743494985; x=1744099785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNtQ0wjdidlnHf+EtMOg0l4ypH3brGi+lZBt3b6ydkU=;
 b=fQSyTa5/bTHrXv0uYW/4gUcxqMpB3IY8XELMU7RoIL4C2WoZZeORAnUcEC+l/Crl5A
 vo2/h6C83LGyJA78aJTmTRth/QOruHad7PEfJyn9iM9aHpd+j2PHcvkuMOB6ITZMFJtv
 U6g7KtSAd6dYnG0SzNdTHTjzTRavkP/i6e37+10sPbyfvWghIOXyRVav37y1B0je+HBG
 P5Gy3WqwjMcAtJw0VrHE9QDLpilDzE7P4dD2gpnrT0jOSiQWXtXbux4mwzhblUZkxZO/
 JKa0/n9wSj4qwGAdGxHy6KEwivNTaALV0NvDGN5xe26wMQCK7r6/myathYdgxI4Orb0O
 wf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743494985; x=1744099785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNtQ0wjdidlnHf+EtMOg0l4ypH3brGi+lZBt3b6ydkU=;
 b=NJHAiuVN1oY7Ft6kIZVVAqMp2oOcLG4gkRRl43K28HyAvAbzo8gF3rV6uvLMpZbLRl
 p1uzdwRBF7nDz8M9xPdSuYLjhwWT4vEoC4GFgOG4mQ0xoba0Xo0lr7Pdy+j45QjtUI1s
 EWBTjXQcP8Hma+roSm0u1NMBUUlRlQRiBiAhqUf/NkZdg5fcy2ik+aa9ZAqg+hxfLNxf
 gXtW1TOxLISHQ9GNpdaHbx3K2bPaspt6MeOxYxwisfHfgQIwij1hrVnJz4leJTKy8l6w
 Z1mQlbxnHcnJgwqNPcgKzfO9LhJKMSAbz3a6tmAK3/431ufjPVqN11hJ20Oso6YDq4DN
 OGEg==
X-Gm-Message-State: AOJu0Yx7aWWv8Y+DTBR1Cqdq5Y23XnfMTBDutfX5RIGaM0x2Ga2w0C2r
 oSfwpDg/lO5DoAlrJXin7Oq7EBvJMWagbtrKqQhbdK77+7hdRGeuFW/QiZQHZwglB5MJFWZzSFD
 D
X-Gm-Gg: ASbGncv5JLW5ckDgCx5pEx7e0JiTc05dokuom8H1+hK9vRg6MWc5fFRxossPm3aSpnR
 0Z3YpmZ0Qjcdtzq8fcWFdGQz6Oo6pX5R7ZkP1L/giXKxSXryl4PeIGhtBeqhvdINWYmb8W7FePR
 vLaaz/Mdj97e10Xv0/rrt4+n3uvfdyY/CVIGjqgYmGGszclJP65W+Q7VQgtX+HV1Qp2KX+X/9ZG
 D3ORK/Fw55i1h0KJVo8Fx0k/JAB+Zqz2S1tR9Z9ZDCJLjsmnj9UGPmBJv0WILodIh33t3M50ARw
 6XjlI+jZT0RxythYD7OoZhF+Xbg4w7jKcc0+p/+MOeo12w9airSt7dkBzWvJ2Sqjs/A3gLkx2/F
 LAq85qWUiOy0t9jJfWvUD57TqqPo/tQ==
X-Google-Smtp-Source: AGHT+IGUy/m+s/etawRsKabVccvS2BIilGr+T5pt0O60knmpFzGYs6+35rzTTNxVlgMoj/zBqyPjrw==
X-Received: by 2002:a05:6000:42c4:b0:39a:d20b:5c14 with SMTP id
 ffacd0b85a97d-39c12117aeemr6826736f8f.36.1743494985460; 
 Tue, 01 Apr 2025 01:09:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658b52sm13272047f8f.4.2025.04.01.01.09.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:09:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 01/24] hw/core/cpu: Update CPUClass::mmu_index
 docstring
Date: Tue,  1 Apr 2025 10:09:14 +0200
Message-ID: <20250401080938.32278-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Since commits 32a8ea12fab..90b7022e698 (target: "Split out
TARGET_env_mmu_index"), target's memory_rw_debug() callbacks
use the target's TARGET_env_mmu_index(), not the generic
CPUClass::mmu_index() callback. Update the documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 84a71d8cf17..60b7abaf49b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -104,8 +104,7 @@ struct SysemuCPUOps;
  *                 instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @mmu_index: Callback for choosing softmmu mmu index;
- *       may be used internally by memory_rw_debug without TCG.
+ * @mmu_index: Callback for choosing softmmu mmu index.
  * @memory_rw_debug: Callback for GDB memory access.
  * @dump_state: Callback for dumping state.
  * @query_cpu_fast:
-- 
2.47.1


