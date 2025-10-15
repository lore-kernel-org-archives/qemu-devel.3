Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783CBCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xeX-00027U-7Q; Wed, 15 Oct 2025 05:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xeR-00021m-2Q
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:31 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xdy-0007HH-8e
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:30 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b48d8deafaeso1310497366b.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760519874; x=1761124674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1IEAaSPzmzz5B3AM/apm91VbHSHgHQnwVHyZGTcUVH8=;
 b=JSiUqZ1HxyOiUxhm1C2USBNqRWyBodi0CJd5jNnnukWYTMFYdpr5uYJUUmnTsGflDW
 rAtbFrRuzaWayYFK2Q66cenxCWRMY9qiyyhAszOG1kvD8LKeMWpyAeCDz919PkyN73r1
 NStWwnv3ohQ+2pQlD1LJvpOgO5wEqyErqXOMJBL+A1NPPCoHrrZWo5Gn4UYO8JWycv3t
 Db3rdx1AyrIIpNozUm3T5aTjWeqWya4DMeWrY4ATCItRL1L95Og3nUR5rv2moxRK0Zrx
 02VX92IYhE9m+R9rHSzN70koAf5DjT+2yLM1oryMkDaM5r0ru+p1VB7GS0k4oBz2Eg6x
 0VTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519874; x=1761124674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1IEAaSPzmzz5B3AM/apm91VbHSHgHQnwVHyZGTcUVH8=;
 b=BvLJf5rpJGh7Yfln0UcSkozLHZGvRJ+tquzKg4sJB+nM1AcfWVyXxlD8GnP0S00OiD
 ymeq/Zoc0uwRwNZZl/VXc9Dor9E3gBVn+C3lap749BxB6daJHtupRwkO+RNARO3KbnxQ
 W9ghv8WttJ1c8fzjEO6BJ27/tzWcrOM5EmpG/lnEANY4IYkKk8w4u4rtpq+zPoqOP3Ef
 /GgEG+ymhyhd0RNfz3kw/mkA0VDO1aBlpkLm9vdcFLeiYQtoQlSLyjHSn2cEvB+Fn9gD
 2ytsbae2LD6lTCn5WP8gVFVlUaPkmax71607u/SFI8jPhSlxU6LUdJKcnq2BAQgOKeQs
 IhSA==
X-Gm-Message-State: AOJu0YyYVXaeVnewhTh0Of9FPblXB0D5Z8udXa6dplCpu6X1JWBpjPo5
 APhKtNNQ/BFo414J9HZ4btPfQixGs2E2TYevLBfkicB/u64gUh57MIWLLNlvvmo+eTg=
X-Gm-Gg: ASbGncuMSOrUb9tq/k2eN5/hul7MMb5ZktYgQpDjAahuAnzmG7tVP4feLquJaQeMdDD
 JVuBvYHJGanDAEwsjP9ivrFxSsQx3d7mD5MF5e7oHWSYE6GeOBLyRBCXT6hqZ1LNqj391Xu+gtm
 B8uK357FD86Bo21lr8nBPumCtuw++Hh4F/Kw69dgSn42E2kGDHvp55Y7o63kVrOvdYc1qOUUxzf
 hZHphRca4qPfztNk8lOWW/SseAMNYl7vHUAxccf4ZuNMDs2wcnBAphDEIsD9xtbMLCLYUbJ/c3O
 2znws9GxDGo5tgBb16/6c2e58OzbAF4uZxkuLoTaGgyw3VxjRb0JrHZLHHJgPjtRm+Z3pXL126J
 kMcpY93acYDexbJJWKikebOoMOHH3013bQKinSurDvho9eGR84DxQNRqot/xb7htHz8RRYQwa
X-Google-Smtp-Source: AGHT+IHLAZzJLN1bKOsiOe3mqN1XhP0eiIwCDbtX9fDYf91M3S2gHD5OBU7BbYanHg8raMaeLOUjMQ==
X-Received: by 2002:a17:907:3f1c:b0:b3e:26ae:7288 with SMTP id
 a640c23a62f3a-b50aa48e3b6mr2986592866b.8.1760519873543; 
 Wed, 15 Oct 2025 02:17:53 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cb9e7a23dsm182069966b.23.2025.10.15.02.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 02:17:53 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v3 12/14] hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
Date: Wed, 15 Oct 2025 11:17:27 +0200
Message-ID: <20251015091729.33761-13-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015091729.33761-1-corvin.koehne@gmail.com>
References: <20251015091729.33761-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x629.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

The is25lp016d has 4 Block Write Protect Bits. BP3 specifies
whether the upper or lower range should be protected. Therefore,
we add the HAS_SR_TB flag to the is25lp016d flags.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/block/m25p80.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index a5336d92ff..1df223ee81 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -217,7 +217,8 @@ static const FlashPartInfo known_devices[] = {
     /* ISSI */
     { INFO("is25lq040b",  0x9d4013,      0,  64 << 10,   8, ER_4K) },
     { INFO("is25lp080d",  0x9d6014,      0,  64 << 10,  16, ER_4K) },
-    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32, ER_4K) },
+    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32,
+           ER_4K | HAS_SR_TB) },
     { INFO("is25lp032",   0x9d6016,      0,  64 << 10,  64, ER_4K) },
     { INFO("is25lp064",   0x9d6017,      0,  64 << 10, 128, ER_4K) },
     { INFO("is25lp128",   0x9d6018,      0,  64 << 10, 256, ER_4K) },
-- 
2.47.3


