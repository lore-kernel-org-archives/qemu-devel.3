Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49B8E7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 23:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTqvj-0007hS-BU; Fri, 03 Jan 2025 18:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvb-0007ga-Fy
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:18:04 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvZ-0004JB-SO
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:18:03 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385e06af753so6430526f8f.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 15:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735946279; x=1736551079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dvr9i4kjv30irFUGSKh7uwfrgCkzcWtJhKmLo4Kj02k=;
 b=Cfjna+cKtWmohoBijknJyZ6H+a6gIz6cBVrnPAC12qB4eyNAGRNBoLrVQQ57iZto7V
 sOXMmUT448QkHEJiqdHVYOK2V47wp8WMjlI3KXP7Ma/smr5zzInAqsldjFiPIobY8lSB
 FulgHHGkQ8qpCW1oPGo/V4WyTdaqKuIDtA9b4R/hJUympNX92uL1nNm72OH12zesnYbY
 SlVYUpbWF3/c07StqayD89T5di5Bc+UFae3Si4xJOvkM4HV0N9kq2ahXDWoYuE+nLtkL
 DSwvSn5kSIDAp/GMzSSkUutyx2bqJRukJCvJ/CJ+bJCc59XVnyR8IQC19cv5pJuzCdw1
 Xc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735946279; x=1736551079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dvr9i4kjv30irFUGSKh7uwfrgCkzcWtJhKmLo4Kj02k=;
 b=SELgaIqxbtWCxkvUIenDlGYMuMgGM8Nllb9VgdyOm0HepAWe2fGt8Z954LhvlKjl+x
 NpWBkrCpCIfGVGhwX7mt+JoxixbwbErOdt7x8OSmReb9uQ6AzaxIusQ47ziCp0VZv/9c
 t+GKEDf/M/bkWjnpFwGwUb7i38sK8YefmKL9nI+oz8WaERK/Qh65ZQ7owlAJFlGFF7Rt
 gASebXnYFz19t6u5If1FYPA8X4lDLBgfPnb2iO6PQUpPLfmiVEZwCR+ZjBbz9c+AO9j1
 lHGtGcWmVrgpM4Pc6fkRVoTuMi3aNcgy9GqBU0NMY5vvqa/uZdJSme0U/nu8ZV590tnL
 91GA==
X-Gm-Message-State: AOJu0Yzzficg1roz2LoiZm9L0ouG0gq93THcSQbSopPrAxJ6ubeUFfLa
 t5v4vpN9J/qeR3AaM+Qb8jYZYf9vffNqdqSHmKjzAso4js2ufEWqoHAdxlaLIZyu5Oi4qXgHOZS
 bkpk=
X-Gm-Gg: ASbGnct4BW0jREY8Rj0YYdCBPok3CNiIADX15HT9H00ZPUNd9S4oV8PuhgrkRtOyMJS
 BEpvB+DDMrsevmAE33xu/gmKZRCak8s/EhFDx34gyegJd6qfXc34J63W/rpE3D1Yd1cQ7fzAR0w
 ccJVfRshGKABNnH5xDzWw44ua9frnjYlJUf6/v2ZV8ub8QELaqUqXJIt9gOn2szhDPLtbqVGMw/
 DEwB/BMLLJU62LaoQlrfrj9JmWrAqOKc/P1Ux4ZfXi6F6AHrBupxj99Nwv5WH5ieCbuQkp477CR
 bQcHc8DcRc7XJtmv/YzofI7xJbxR4N8=
X-Google-Smtp-Source: AGHT+IG63TKFeKPRwPdbBnA+jps1IadvzS3gSAY3rWN86k4OTlp76zNkJaq7HQPq61t57gzTs6L7mw==
X-Received: by 2002:a05:6000:704:b0:385:fc00:f5d4 with SMTP id
 ffacd0b85a97d-38a221f9f79mr43046709f8f.29.1735946279572; 
 Fri, 03 Jan 2025 15:17:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661200abesm493862365e9.18.2025.01.03.15.17.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 15:17:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 3/6] target/xtensa: Move xtensa-isa.c to common_ss[]
Date: Sat,  4 Jan 2025 00:17:35 +0100
Message-ID: <20250103231738.65413-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103231738.65413-1-philmd@linaro.org>
References: <20250103231738.65413-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The Xtensa disassembler (selected with CONFIG_XTENSA_DIS=y)
uses methods defined in xtensa-isa.c, so this file has to be
compiled when the disassembler is linked.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/meson.build b/target/xtensa/meson.build
index f8d60101e3d..68ebfe2582d 100644
--- a/target/xtensa/meson.build
+++ b/target/xtensa/meson.build
@@ -12,9 +12,10 @@ xtensa_ss.add(files(
   'op_helper.c',
   'translate.c',
   'win_helper.c',
-  'xtensa-isa.c',
 ))
 
+common_ss.add(when: 'CONFIG_XTENSA_DIS', if_true: files('xtensa-isa.c'))
+
 xtensa_system_ss = ss.source_set()
 xtensa_system_ss.add(files(
   'dbg_helper.c',
-- 
2.47.1


