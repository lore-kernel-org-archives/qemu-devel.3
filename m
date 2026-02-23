Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E9BEC113C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucyu-0006aX-5Z; Mon, 23 Feb 2026 15:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucys-0006Zz-AW
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:38 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyq-00080x-Mr
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:38 -0500
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7d4c307db9aso2476566a34.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 12:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771880194; x=1772484994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VYiV3uUyJHz2/FR+sN3LP/IVCZ3NT54ZlyBYnhfbCto=;
 b=OhGMph9C414WqpE7WuDdtOyApClHaNzr2Kx+6ulZphIEsKPohCGh0ag6jvdtjo/EhP
 3eEtLo/kfVN9N8S3t0XJvdUGQtZ1MF53F9sg6RUE0BwwY4mC51sZMmBWI8prhBZjzYvK
 lZTNSnL1ECbhe2x3RNLRcF7Hq7R1DGIbfNFJqnCWgOjO2D4ywvlmCxnwLv1+JHQY4E6R
 5uF1hmEsAo0ULDsiZEhvInBbwNmTpQN7bJNcsAnmpCFqZhhUkd8E66MOrRuzUqAHYkFJ
 22kOAiyeC5VgsKLTnOa9w+rJSKBgvTywfx+BZ/FM6pau6sDGf0pukfvzW2AxHCW/KV9k
 LRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771880194; x=1772484994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYiV3uUyJHz2/FR+sN3LP/IVCZ3NT54ZlyBYnhfbCto=;
 b=BPadzopKjMhjyyZkrAzbQwf7HZIHq58+n8jaL1b0ttEF3+1l3AQfbCUjRCovdoBsl/
 usKOCvQHtWGU0SpBslr2kCsJFZN42f83vOM/MXSqA6wgeIlOfxzQTfzNT021ebiNShfu
 vpa9FtHP2hS431XcTgy7DXkvQhXPcM1lT+djDUisCN8CoASXfoiLV/a7w1C45o0ApB0k
 Bsy9PALr4G0qU4eBvJ6lZVzyuXbbQ503CKlZ4feflGQovFZ2y2Al/35wg98c8CiNTRSj
 5TdlwVoeekeRn/Vkh8C8LMcOizrMBkUpX3GXmnqOhluz7BSKTtBy2+FhhvXCqNJJ6SiE
 u0NQ==
X-Gm-Message-State: AOJu0YxM+8iogqK5jaVM3NlA7IFiJ6sixGFFA2yiWyPxAEvqhN/lAb8T
 ohxCGrB/KOB2q3m/7uw4jeaXmQ67pcLdMFLQV0EJlvVWdhIPgQFjookzOJlZ1QS3
X-Gm-Gg: AZuq6aKqBsNqykjZi8TyUZ0eh11NkARRg6cO+ZrOKelTVg7igwLUKqTWZPjAFSh+hqy
 tTm/mGd4oyL1K3kJQ6uhN5L7+eCZQ1zMBOhNX/PFHxp4Q8wqjj3kwJcw1nUeTgv+H9UpOoF95o6
 QK59JLfEvfhn4e7o7GBJxshpyQ3YEMuz1TgAdWt5NesVadQ881SRVxONfows4CQQWQBZKOz9DO+
 qUmNftgtyErMnLT19Of03EuUqbb5ORv3AuNEofIifbLg0QMsgjTHNVFeykibuPGFhmY0ydEBSk/
 u09At3+zkvfoLGRyCBVbPNPThXBrkKtqODU6sG/DAREHAOGZyoNXKHvVYBl0/C8O4Smb3eFihuL
 zNKELipJYxhlgWlTrMMWp0PAW2VUD7lgP3pIWT/qAFi/PBwsmakt+E7T+xt8TVcY8lFP0Hx3HBy
 +yAhrBH89FcxCC9a/JL3Rg1Pc1KJ0LE7kAUfghXeUO66PyUAwUgFHwv+FWmV8Slyp4NMWVYuHiz
 5P81+QsLMm3oP6d72i4qPwh6ayfExuJjv+hXQ==
X-Received: by 2002:a05:6830:210e:b0:7c7:32d:975d with SMTP id
 46e09a7af769-7d52bfb0265mr5306113a34.31.1771880193984; 
 Mon, 23 Feb 2026 12:56:33 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-75-70-169-246.hsd1.co.comcast.net. [75.70.169.246])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04dbf1sm8011996a34.22.2026.02.23.12.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:56:33 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 0/8] Hexagon (target/hexagon) Check for multiwrites in
 analyze_packet
Date: Mon, 23 Feb 2026 13:56:24 -0700
Message-ID: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, we check for register multiwrites during packet decode. The
downside of this approach is that it only checks a single destination
register for each instruction.  During analyze_packet, we can check
for more than one instruction.  Further, we can check for different
types of registers.  This series adds checks for HVX v-registers and
q-registers.

Note that multiple writes to a predicate register are allowed on Hexagon.

Taylor Simpson (8):
  Hexagon (target/hexagon) Move code out of gen_start_packet
  Hexagon (target/hexagon) Check for GPR multiwrite in analyze_packet
  Hexagon (tests/tcg/hexagon) Add tests for multi-destination
    instructions
  Hexagon (target/hexagon) Check for vreg multiwrite in analyze_packet
  Hexagon (tests/tcg/hexagon) Add tests for vreg multiple writes
  Hexagon (target/hexagon) Check for qreg multiwrite in analyze_packet
  Hexagon (tests/tcg/hexagon) Add tests for qreg multiple writes
  Hexagon (target/hexagon) Remove old way of detecting register
    multiwrites

 target/hexagon/insn.h               |   4 -
 target/hexagon/translate.h          |  25 +++++-
 target/hexagon/decode.c             |  54 ------------
 target/hexagon/translate.c          |  77 ++++++++++++-----
 tests/tcg/hexagon/multiple-writes.c | 129 ++++++++++++++++++++++++++++
 target/hexagon/gen_trans_funcs.py   |  10 ---
 tests/tcg/hexagon/Makefile.target   |   1 +
 7 files changed, 210 insertions(+), 90 deletions(-)

-- 
2.43.0


