Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD76DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojeb-0008Pj-VE; Mon, 25 Mar 2024 08:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rojeT-0008PX-Bw
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:42:09 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rojeR-0006dN-QI
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:42:09 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-513da1c1f26so5404872e87.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370525; x=1711975325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aeyypbawzIagv5f4ghFVbV2Z9IgJDfo+3qujNdmCU4c=;
 b=hxDxWbk7GV+d0jZnyIKiIptFZiJX7iHj/p+u1o+dgX3DSAJmz8R8yYHYW3ebjg6i2H
 g0WJqWjTUqmqt37k7FqJVA3B94w+qf0s0ezJsgpRX3D0JuWoTIx+v4IqcqwfvvBEtg98
 zUPrFQog/ABpGFDmaVVKawySC2rjkLBGscP+NYMfVm7aSe70luzNc9w67g2r7qJI0kLG
 ZD2+ca6y+c1PQZ0jPmEbfDH3HFPiQkUuscCFsnCrQUrEhbDVI5IvwXIwzNqZxXkJZHSO
 7JOGXkprlbfKeC6p+w6JxJxhQkj/sveFsraNM8l7VjCEOHH3Y2sB+5NuyZSBAG/SBEua
 TDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370525; x=1711975325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aeyypbawzIagv5f4ghFVbV2Z9IgJDfo+3qujNdmCU4c=;
 b=jmyXUZ7nZ77NOdEozQfLcoH02afcLzXwQMK6fvC7qdgKguBaIPqWwl/Krzo2mieyUj
 n5rSXoqlri6fQgJ26FJFVBOZoZl+Btfd7N4Kp/6IrHcp1f2fHSlwuTon4G0P/39O+BXc
 mU6jotFwcJoyaAs7HB0mC0WmIW8jBW2I6Z4MA6Q7VBDuOopdhifTmaktCzlCstFcJdqZ
 8swm4njH9OW9YYYpuyyAHHtWxCNq9US05/L/yKdfRhBEYe4q8nK4RA43XgkB6K/tVP3G
 beoU4c7FwWCSNu06pxdSQikdGpvRCJVas82B+KWV6PMkdARYnUVLRzq318fzDl2X+zxy
 Yi2A==
X-Gm-Message-State: AOJu0YwQH3QvqemoJgTbx63rj1ICN9H03+PAV7LKO1b21ekoThkQfz7N
 EDooZB7XvjuesGCV77coNo7ph326zaSFlSI/UiSy18XcMawcQDfQ6yTZ7MaYE33zeIAXPMr80El
 7
X-Google-Smtp-Source: AGHT+IGaiBZhpmWkP0jvck7TDmVQ6/9wa5zhfZz/BbQGo+shby//v6A7NNBhUEqhTUI+rHPV4of0pw==
X-Received: by 2002:ac2:59c4:0:b0:513:39a0:1fec with SMTP id
 x4-20020ac259c4000000b0051339a01fecmr3872633lfn.66.1711370525095; 
 Mon, 25 Mar 2024 05:42:05 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 t20-20020ac243b4000000b00515b1b3a2bdsm35231lfl.194.2024.03.25.05.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:42:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 0/8] TCG plugins new inline operations
Date: Mon, 25 Mar 2024 16:41:43 +0400
Message-Id: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x12f.google.com
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

This series implement two new operations for plugins:
- Store inline allows to write a specific value to a scoreboard.
- Conditional callback executes a callback only when a given condition is true.
  The condition is evaluated inline.

It's possible to mix various inline operations (add, store) with conditional
callbacks, allowing efficient "trap" based counters.

It builds on top of new scoreboard API, introduced in the previous series.

v2
--

- fixed issue with udata not being passed to conditional callback
- added specific test for this in tests/plugin/inline.c (udata was NULL before).

v3
--

- rebased on top of "plugins: Rewrite plugin code generation":
  20240316015720.3661236-1-richard.henderson@linaro.org
- single pass code generation
- small cleanups for code generation

Pierrick Bouvier (8):
  plugins: prepare introduction of new inline ops
  plugins: extract generate ptr for qemu_plugin_u64
  plugins: add new inline op STORE_U64
  tests/plugin/inline: add test for STORE_U64 inline op
  plugins: conditional callbacks
  tests/plugin/inline: add test for conditional callback
  plugins: distinct types for callbacks
  plugins: extract cpu_index generate

 include/qemu/plugin.h        |  43 +++++++----
 include/qemu/qemu-plugin.h   |  80 +++++++++++++++++++-
 plugins/plugin.h             |  10 ++-
 accel/tcg/plugin-gen.c       | 138 +++++++++++++++++++++++++++--------
 plugins/api.c                |  39 ++++++++++
 plugins/core.c               | 106 ++++++++++++++++++++-------
 tests/plugin/inline.c        | 130 +++++++++++++++++++++++++++++++--
 plugins/qemu-plugins.symbols |   2 +
 8 files changed, 465 insertions(+), 83 deletions(-)

-- 
2.39.2


