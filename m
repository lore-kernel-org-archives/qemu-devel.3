Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC36DCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKbZ-0003Hh-7m; Tue, 04 Nov 2025 12:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKbS-0003EP-92
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:13:54 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKbM-0005ni-Cg
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:13:52 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-640c1fda178so3669568a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762276426; x=1762881226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ft0gBvtyOQH6FyOUJfwzOoqV18xrHBjh5Rs307pXpnA=;
 b=Zz/rav2hMOiK8PgcWTK13gPk3Hkl2JxB/2IoTbxXMAsZUm6YHdy+QCGYhj4WObEPNX
 TktNGnnUn1SYFOIzogD5yh7fUSQnJtaxmyZKJOJazJj87DtoKrxkt1FLw7Ji8TKHQm0B
 bC1YiUv0nx2JolB+XdbhLzu7fVtIwZZZ3ERvwXzIA3N+YyGkpBWj+2DPooYPzPs7YISe
 7dSQ4JNnCQnjvQFWRP8cTkWZQcacOPR9GDnkb+foloQDYofXYXrME7/tYetFreygqTDe
 5K36es2XSitnWhb7coPY5XMHAcDZFW8fdgJPqk54q1Wn4ki52Mb43YVtWsR5v/7cN9i9
 /PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762276426; x=1762881226;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ft0gBvtyOQH6FyOUJfwzOoqV18xrHBjh5Rs307pXpnA=;
 b=aTSWCFv67662SoLebvN+EX8wv/uoBJrGEOE+d7S8HMifQwkOVVUGHApaC1ks5pkeBS
 BKmrwKOgcvcpaZwS743qlsyqBFFNniQ3ujCC+bh92tx4pesGg6y7GWWveBuHENgdVTlu
 vVttZ2K3B9KJF5/jrCkA859AFQQGKEiPOYxaxrhux2bOFkB5kcfU2JYEJseW8P6cP0S6
 kaH8G1/6D9z/+U5mEUue68Pr6Oas2H/T8kpUlU4dg8bD2WLFgWPK287wS+iKHAzM+3jt
 MBG8Llcqn0/mkU0Yltwxi7/6Y4f2lAKCc++MaF6NqNNtD5sS9Efe62QyLGG9mIn3Y6JP
 9BeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdaVsgJT573Owy/K6NEKorO9q++TxCysgb9UbNPVtd8OH9xtg7lAgGhvs+FA9SuE+YZoq9a999YmCs@nongnu.org
X-Gm-Message-State: AOJu0YwqaOeMReKGxV8qzhhEovniXuWQHGPrFLRV2DajYmdvw4uoKvU9
 c1dr2b38U1l76o3gS1qqTlaDImozxTmzutOHeMaHi9dWtJ7OML9wZlBkYRbvPL8bkKo=
X-Gm-Gg: ASbGncuK6WqAAL1cItJNNRhR70Coe3Q8Z8SQmSy7dqdGo4H2nTLLIdTe6xr97t1iXT0
 0biauhiM7maXKYiEaAeDekkKzvolEV4hPgS+FeoMkU1yUbtQ5zhrMIFYvrTKAuhSsC/RxXA5nUk
 2imw/V0nHEglnEmMVeGXQXEG6w1IrQyKEilcb3X1VOzSCAnAE4WeHs/hAYrkijTOZB0H1eZMmYJ
 EAMJKBIBbiIBQOoHkswz8MR4de4R5Hg/lIywfvLbMKBA0yjf4uxeq8PYNJv4g0w+ILw4fKtmbwi
 aM6kVO0XUQGn+ihqpp6+UVH9eY7/ZtX6QGe1l1Fig9td/VEx6/Oxc8Svbo2yDXhmGt9bNM1PgtU
 DDymRPZLC0ek5omHq3AP1ATj84Z3Q36zfJU0aLrYxaA8inuEqMzXh8IWTJ0OLfQDKdwgynk+i9q
 Jj9EotJAo/S3Sp556ASMP7GsSslbq8mQ==
X-Google-Smtp-Source: AGHT+IESzfQ9/3E5ilt3TvT3efhzNaIoODdFRSAWPyzPJi9QygZ3pv5BjHjdQQSVJdec+aWRd4UI8g==
X-Received: by 2002:a05:6402:35d6:b0:640:b736:6c2f with SMTP id
 4fb4d7f45d1cf-640b7366e62mr7958271a12.18.1762276426180; 
 Tue, 04 Nov 2025 09:13:46 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e67eb64dsm2511086a12.5.2025.11.04.09.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 09:13:45 -0800 (PST)
Message-ID: <218924b2-215e-4762-8d52-2b75dcfac8f1@linaro.org>
Date: Tue, 4 Nov 2025 18:13:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] sd: Add RPMB emulation to eMMC model
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, Alistair Francis
 <alistair@alistair23.me>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Warner Losh <imp@bsdimp.com>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1762261430.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Hi Jan,

On 4/11/25 14:03, Jan Kiszka wrote:

> Jan Kiszka (6):
>    hw/sd/sdcard: Fix size check for backing block image
>    hw/sd/sdcard: Allow user-instantiated eMMC
>    hw/sd/sdcard: Add basic support for RPMB partition
>    hw/sd/sdcard: Handle RPMB MAC field
>    scripts: Add helper script to generate eMMC block device images
>    docs: Add eMMC device model description

Series queued with the following squashed to please checkpatch:

-- >8 --
diff --git a/docs/system/devices/emmc.rst b/docs/system/devices/emmc.rst
index 7e15b622706..8fcb47e25b2 100644
--- a/docs/system/devices/emmc.rst
+++ b/docs/system/devices/emmc.rst
@@ -0,0 +1,2 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 61754bf1083..9c86c016cc9 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1166,2 +1166 @@ static bool rpmb_calc_hmac(SDState *sd, const 
RPMBDataFrame *frame,
-        offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN +
-            sd_part_offset(sd);
+        offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN + 
sd_part_offset(sd);
@@ -1207,2 +1206,2 @@ static void emmc_rpmb_blk_read(SDState *sd, 
uint64_t addr, uint32_t len)
-            curr_block += lduw_be_p(&sd->rpmb.result.block_count) -
-                sd->multi_blk_cnt;
+            curr_block += lduw_be_p(&sd->rpmb.result.block_count);
+            curr_block -= sd->multi_blk_cnt;
@@ -1211 +1210,2 @@ static void emmc_rpmb_blk_read(SDState *sd, uint64_t 
addr, uint32_t len)
-        if (blk_pread(sd->blk, addr, RPMB_DATA_LEN, 
sd->rpmb.result.data, 0) < 0) {
+        if (blk_pread(sd->blk, addr, RPMB_DATA_LEN,
+                      sd->rpmb.result.data, 0) < 0) {
@@ -1215,2 +1215,2 @@ static void emmc_rpmb_blk_read(SDState *sd, 
uint64_t addr, uint32_t len)
-                     RPMB_RESULT_READ_FAILURE |
-                     (result & RPMB_RESULT_COUTER_EXPIRED));
+                     RPMB_RESULT_READ_FAILURE
+                     | (result & RPMB_RESULT_COUTER_EXPIRED));
@@ -1308,2 +1308 @@ exit:
-                 lduw_be_p(&sd->rpmb.result.result) |
-                 RPMB_RESULT_COUTER_EXPIRED);
+                 lduw_be_p(&sd->rpmb.result.result) | 
RPMB_RESULT_COUTER_EXPIRED);
diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
index 45dc3f08fa5..429388213c6 100755
--- a/scripts/mkemmc.sh
+++ b/scripts/mkemmc.sh
@@ -11,3 +10,0 @@
-# This work is licensed under the terms of the GNU GPL version 2.
-# See the COPYING file in the top-level directory.
-#
---

I apologize it took me so long to review, I needed to study the spec.

Thanks for this high quality contribution!

Phil.

