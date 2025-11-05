Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A08DCCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 21:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGl11-0002Os-6e; Wed, 05 Nov 2025 16:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vGl0y-0002Ld-F8
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 16:26:00 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vGl0x-0002CZ-0a
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 16:26:00 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-43326c74e19so1169025ab.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 13:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762377957; x=1762982757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qq0CeFccoUaw797SCNd5kg/OmbuJurCFknlqPb34xEE=;
 b=kc0sT1+pQCnNYo4bSfQa+oR6ekbVCjKKE6ryjuKfpXSSeMAqZL7ikZE8NdNuFPB3P0
 H/m0FrfhHf9jdhEtb287kk9993MRjS+u0pcepBPM4cfEEae/RaSJtVu/5tXALyHUPT7V
 aIhOV5s8dbjcpxfzsMqP7nsDEga+tYKKwDMusAmZSI5bEDYcerIsHtDcQxh1NqeENRPb
 H1rL0x4aX/SDf7fl11twDxIAxQiDy+lsujo2uoxbnXBcN0Ga5rq2LmwDdCGQ3lCGDU3o
 VbwI9x92HbQBRCUgXdCQaNJ+Yc9ALEEhv42eAYAQqIGridB53s48OaMrTbPTZqM4tpRK
 v72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762377957; x=1762982757;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qq0CeFccoUaw797SCNd5kg/OmbuJurCFknlqPb34xEE=;
 b=gqfGTr7Cr6ZL7Vg5xjAnGC8e2lZHsZB1cKr5hvVy/hdcIRu0yJ/OXLpc5jrHdi0JRL
 IFc9S0uXfaBz6pI//YWHI8sReiqj/DNFGd3rp2eynCbFpa4gBNyQYmSQ/4usjJsfdPK3
 4az76Y9VzUNQfgmZd3mQheQ2H0HK9bxZKYXr+5FauXQD5iSVW++rrEtkJGSYNoRgXX7t
 1XKfgHOOHrHN6B2KDBoC+q7JJMgLCcJmaGLtNE/elN/NuCW/bZKO5eyrMJBEAa2NATid
 oI65Wk4YWHnwGEKrKEkDEaLGJPJgIfjx9bplVBGWie4Mkept2hqNg4cq61UKsSc9iACm
 /+dg==
X-Gm-Message-State: AOJu0YzzSHl9FSzkEJrFqMWbdCDT4lWl18JrLBVTi/eBNQS08vsZ6Yzo
 KbBAHSiBwP2TcS6vu1Hgf6qHFKC6DP6KFXqr3tA28NNwTG6GrRj4ux8jjKnj926iisk=
X-Gm-Gg: ASbGncv0oy6/i8Ozm209/v/vgOJXhgZn6zrG8R5FUMc1Dh1WpuE5ytwp1MtGyBiy7ex
 AFxnjsaSTA3ZzJ7VkyyOgU0Rd3o7q8NBwUe8xEOF0J0HNzlayFg5NT/8RHEWfZda7MXd5fEcp65
 Cz+okLF4oZ2v5mh936BxRk3EE6VxaemVk/iZwJ8OQ0m0XtwhE7MsNIn8UVnKh722WN8bOeOEOgE
 64mOmLsrSGyT+bAS9lUiW9lVRlCAAhZLy7OmRgIrprFhTz1bNy6h2lTR8EjI9ACd1wVV0/sCT66
 Becy0giQyLff57y9VjfJhcLx0jPI50P1LGplwJ1gqmuQk18kOAMgisMDKjuY204k2Z5gmxO8nUi
 gaksEEzVgTp61qtU3U888/1aPITm3EiAif8bxqOyK32bc6lxPC6LeIaX8xQTG2uCpKgHBsz919D
 wZkESUZQj0KQpCCEXdDastvTmgFQOd95Ywo7FAMT7GOiFpW0XRYrcOvsH9WgPTv31tGTfRyFO+W
 aw3
X-Google-Smtp-Source: AGHT+IEzPVEb4F6FIX6HIa6N198J9zgt0+ZeoTHNqVtyrfuJZ7UeyZuJeApZ5u4eLquAenK9l//WcQ==
X-Received: by 2002:a05:6e02:b25:b0:433:315e:29bd with SMTP id
 e9e14a558f8ab-433407a2f1cmr71303445ab.3.1762377957158; 
 Wed, 05 Nov 2025 13:25:57 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b7467d5a0asm127785173.2.2025.11.05.13.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 13:25:56 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v3 0/3] Hexagon (target/hexagon) Improve USR handling
Date: Wed,  5 Nov 2025 14:25:51 -0700
Message-ID: <20251105212554.127017-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12c.google.com
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

Currently, any instruction that writes USR disables short-circuiting a
packet.  When the write is implicit, we can allow the short-circuit.

Changes in v2:
- Properly handle implicit USR writes when packet commit is necessary
- Added test case

Changes in v3:
- Address feedback from Brian Cain <brian.cain@oss.qualcomm.com>
    Use symbolic/named operands in inline asm
- Added more packet test cases


Taylor Simpson (3):
  Hexagon (target/hexagon) Add pkt_need_commit argument to arch_fpop_end
  Hexagon (target/hexagon) Implicit writes to USR don't force packet
    commit
  Hexagon (tests/tcg/hexagon) Add test for USR changes in packet

 target/hexagon/arch.h              |   2 +-
 target/hexagon/gen_tcg.h           | 114 ++++++------
 target/hexagon/helper.h            | 114 ++++++------
 target/hexagon/translate.h         |   1 +
 target/hexagon/arch.c              |   3 +-
 target/hexagon/op_helper.c         | 287 +++++++++++++++++------------
 target/hexagon/translate.c         |  35 ++--
 tests/tcg/hexagon/usr.c            |  54 ++++++
 target/hexagon/gen_helper_funcs.py |   8 +-
 target/hexagon/gen_tcg_funcs.py    |   4 +
 10 files changed, 371 insertions(+), 251 deletions(-)

-- 
2.43.0


