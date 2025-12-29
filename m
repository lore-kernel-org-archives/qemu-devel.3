Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62D7E94106
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 23:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaMSv-0006wn-ID; Mon, 29 Dec 2025 18:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMSu-0006wY-B2
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:15:52 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMSs-0004S9-AC
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:15:52 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477770019e4so79961465e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 15:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767050148; x=1767654948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BnG0uxBwEJlz0ufbq2mGZrFo1uNlD9z19kBoHUnL5N8=;
 b=WXqgsWDAkCQ5JxzXHDh6W+h768RxbclTtPNguUBQUfBoEw+oNluL8Jp0MgrnL9kgPz
 BFRxcI7ezI9H9kCNDWK5pvEu4kaAPxMYcqJgrNoJ0d7gA0uXP81QZpSQkirsiOlSlF/i
 uB4t0idnonkPY2g21wLXof4FuXJkDTMOYNfOhjPuW3nr8oT3qePUKytO4TEu0zmGtDNC
 tzdsH599FGtlbC5NdC6H2S/8OF0wQw6/V19kMstIqFOywzIbi1h//2UOncy5imuDBS5k
 qTAB0zS1Ea8abFmOq3WCn2J3hkhO0cRKyTHKaRqPPte93OsHmCoue+u3iQ3apmFsJ6HZ
 Csrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767050148; x=1767654948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BnG0uxBwEJlz0ufbq2mGZrFo1uNlD9z19kBoHUnL5N8=;
 b=tNnAAk7MA0HxwBO5cJX4ooqmMehyxYTvyHhlMrpf9gq8zbopeNIMaLJn7YVhRZtvsD
 COUYPN7UBvfN7R1i7+vAu1GoFxYPwqr9WXrTzjjWLNbv0ummcWN6ebPMvNe0/JflSCH7
 Pp8BII2N47SvuunzPylhxZ9FNWZ0zTkORIHC24g4jCBoNMg7vEysmRuT/sxMqic8/qWW
 bgbbeUitE+VdwlMIffF98uIOV2DHKeOTlsBkwCGyg+DYk9SOlkciJEsXuLBR9W611Hw7
 Cui804pcfH5SretnVE0q/huu7OkqyqCvrg9CxHLJgFlEj2Fkp9KvhITLQiDBWg4ry8ZT
 Pasg==
X-Gm-Message-State: AOJu0YycgQynuAaCK5mXs6RVSAzpQ6FxkXwW3EDYoXCaptsBL8Tjfd/y
 QB4SHhZP8imdrPgQV3aVcG+TLjExjo+i8+9sfUpjawKXmfsotTNJh87KAq7keLVj/8N8V33vQrj
 vbaCEdus=
X-Gm-Gg: AY/fxX6Zoj7tDAZWYkdlNwru6biCS8AijivsGfT8gNZe6K8CKSQ25MCcweDJQQAd0Ii
 PitBGshKGIiiDgs+x4mEu/wrBfnNEzZepbiemR9nMs/WBEPhGZDzQP53NvQ2oYQ42S8jr6mYJEi
 Dnrgs6Obo8BgsfSl0slV9U7vM4Au+6WfbdiJaXlZURFYsrIMaZXi8p1yqlk66qlEMCOCwZxD1N1
 Wie51/VJhuF2Yw6OVnQPcbibnyUg3PC2OZV5+UWpmlD0NJYXBL/u2zxxFIWmYBiMhSE8Y7cVQKi
 W+b4IwLNjmK6cROilkjA9X5XSsIfFvYUWKUAO7BdyXtR51JCvMuU72x7c/OSN4x4xbhiDRJI2Nf
 VgkQZb34X8zOtHcoBAghyMMuUTgELE2aMPu870ZVyCMgInBmW67fchemKbXy10orkZ3ABQF3DdS
 E098e8j7gPpbOlSos9ZHosaBmYMKbV2TCE8Z1FMctGjyb515kEsNrghGtlpHKo
X-Google-Smtp-Source: AGHT+IGoHI7n1K+QfB4x1MTOrOvvi2EMI7RO1Rmwxhelobvg+snbvjNCKxcFqOuHdvmUcLdW7kk8HQ==
X-Received: by 2002:a05:600c:1d1d:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-47d1953b8acmr329885705e9.8.1767050148016; 
 Mon, 29 Dec 2025 15:15:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193522cdsm538785545e9.4.2025.12.29.15.15.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 15:15:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/7] monitor: Merge hmp-cmds-target.c within hmp-cmds.c
Date: Tue, 30 Dec 2025 00:15:38 +0100
Message-ID: <20251229231546.50604-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Missing review: #2 (new)

Since v1:
- Make @is_physical a boolean (Dave)
- Use correct meson.build style (Manos)

Requiered for single-binary work, remove target-specific
parts of hmp-cmds-target.c, eventually allowing to merge
within hmp-cmds.c.

tag: https://gitlab.com/philmd/qemu/-/tags/endian_hmp-v2
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (7):
  monitor/hmp: Replace target_ulong -> vaddr in hmp_gva2gpa()
  monitor/hmp: Make memory_dump() @is_physical argument a boolean
  monitor/hmp: Use plain uint64_t @addr argument in memory_dump()
  monitor/hmp: Remove target_long uses in memory_dump()
  monitor/hmp: Inline ld[uw,l,q]_p() calls in memory_dump()
  monitor/hmp: Fix coding style in hmp-cmds-target.c
  monitor/hmp: Merge hmp-cmds-target.c within hmp-cmds.c

 monitor/hmp-cmds-target.c | 381 --------------------------------------
 monitor/hmp-cmds.c        | 354 +++++++++++++++++++++++++++++++++++
 monitor/meson.build       |   2 +-
 3 files changed, 355 insertions(+), 382 deletions(-)
 delete mode 100644 monitor/hmp-cmds-target.c

-- 
2.52.0


