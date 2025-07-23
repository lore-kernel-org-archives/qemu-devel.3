Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4E4C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 09:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueVzf-0004MM-Cr; Wed, 23 Jul 2025 05:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ueVzd-0004K3-2w
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:42:33 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ueVzX-0005lK-SC
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:42:32 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso80746625ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 02:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1753263745; x=1753868545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0MrgxsI1odmrb/YPjNLodWdZqYACxXeEs3w3/m5PvV0=;
 b=cMyWCM8LfL0y4O0V9zmoC6SsQ+pwzUHNIr4XqwXwj03KqHuPHNgo+E5yQL7b5jhGT0
 jgT+rUmSlu7Z/AVAbn+stjcm4hvu2jFFOarulvwlzIAj+sTb+0srxDHHXjgyRRwGjHWo
 TlMBMV4wvw8nAme1r5tvO0kV3Fy5n/BZJxEaMccSQQrkCjiQFx2aX7/SsvXDMgtVsMMX
 HsXu6YRUEwonJF59KGJID7dNGHixrnV8OK3mZmOegOfhwkysi7BYCg+ZKflNmpVLbqjX
 czzpd/zUU6/GCW5klQgDhi9DzLRJflo+PGo3aKCq0xTqJXyLnOE9ZONGxsL1CGptbICf
 Ozwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753263745; x=1753868545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0MrgxsI1odmrb/YPjNLodWdZqYACxXeEs3w3/m5PvV0=;
 b=JrcgpYIw3R3Xhv4W3cSKN9GG4ECS4spzamZi87YOo1FJY0TVb5+NsLTCOJLa+E+Cdv
 oemBbFUx9yKzZkr2Y1yTZS0LhwUcr3SqoOfeqt8JPBFOPchIh/QCYdnVyBr++hztSQ9L
 1eeMDLyGNhMwgbR8gQgir9H6WbC0j8bR+iaulHxATaChcnUIsTT4HTad4L+90tRwR8pK
 4fqMpOUSGWIsam/N8ayzSStz+0K1wANSgfpeQlXg8qTFNG7tCbscM3L/OOYnjvqeNj28
 PeAaR8fbvcU7TYkrdmXM8UW+ieIfb1lJVvZa9HakcD49pQ0cr34Rsas/1fru8T+STUzL
 MoYg==
X-Gm-Message-State: AOJu0Yzm0hYUVmlPxU4WAv1/CQ3vEDUGcPTN3oMF/kWUphKBmcbaDAQ6
 A99xrpTvpshopADsKqNodL/ai9thv0ZswItv7/pcmeMwALknvqdJqHv6z/Yodp3n8ulp6HTfe8m
 mc4QN
X-Gm-Gg: ASbGncuyzJrrb/y0I5MmCs04OJzcOzTiqzmoqL/H9pfbipuik9IQwIyq1oQdCKaSkzp
 cIRTWxXxrpZqMgzUMrdOLuziVl14KTDloyvp/qjUph9IKVkm+TRWzuImR36x3bZ0DjGQEwhdfd5
 R1iblBhPUNsUoySzkyyKskE66qUSLm6/sePT67jnu1Jiya1nM19T/Yuykak4K7DuKP4W3plT9DE
 emQM55P0HFF6DKnJ0uRw+Pe3e/5vkIeDoGJ8RG9sVwGGmTTYXjmTuqihT1vEfns/gs7sFYQ5g8b
 g7TMq4Afhtc8Wk1gKTJUUGfHQEeyPzzzcejhyHdr79zpDr9c0zhCp/abk7ExicCNf99In+24iTd
 ou6TdLLoluTwO8WrhNOe1uNA=
X-Google-Smtp-Source: AGHT+IHgXjAXY1RLDtEouEOULJcEX7AoF5l4lNQQ3cW0tMnoM52kMza6wfAlc3pr5/0HcnqzgN5izg==
X-Received: by 2002:a17:902:d4cc:b0:236:7079:fafd with SMTP id
 d9443c01a7336-23f981b346emr32790795ad.36.1753263744838; 
 Wed, 23 Jul 2025 02:42:24 -0700 (PDT)
Received: from grind ([177.170.118.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6b4a88sm92732205ad.131.2025.07.23.02.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 02:42:24 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.1 0/1] roms/opensbi: Update to v1.7
Date: Wed, 23 Jul 2025 06:42:12 -0300
Message-ID: <20250723094213.2975268-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

It has been awhile since we last updated OpenSBI - we're still running
v1.5.1, updated almost a year ago. We're missing out a lot of fixes and
goodies (including SBI 3.0) from v1.6 and v1.7.

This update didn't trigger any regressions in our opensbi tests so I
would like to update the roms for 10.1 to avoid yet another release with
OpenSBI v1.5.1.

Please download the roms from:

https://gitlab.com/danielhb/qemu/-/tree/opensbi_update


Daniel Henrique Barboza (1):
  roms/opensbi: Update to v1.7

 .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268312 -> 268752 bytes
 .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 272504 -> 273048 bytes
 roms/opensbi                                  |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.50.1


