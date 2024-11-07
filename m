Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922AAD4337C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t95Qi-0007yO-Td; Thu, 07 Nov 2024 11:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t95Qf-0007xf-U9
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:32:17 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t95Qc-00049u-Lr
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:32:17 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so1022625f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730997133; x=1731601933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cl4ZO8ew2BAiajP9BAvW5+7ZXDojU8B2khh55fONv8=;
 b=GMvTBYoTiQsHNdUppdQAN9QAjzU6z9jGRYXckHjUFaTPHfT6qmgLI2xXc31w9f9JOF
 xcwQtlxhSpruEv02Ptv7/hY098OjneYCvQlSyIu1fTehlz7Zq97+bI3KkbRXm57/QfTQ
 zi+Rw0JUhinIFh1kiXlY3FLlk7oMMnv91CZMCDnf+RoB6u5iIPphJAL+9qog0u1WemcG
 GD9JI27Z2W8fFCyZnaGqcLN4lFSxx3GhmGlPhkSzAOuytUksrUg/40qKfXB2s9LZLpA2
 pWh6osGskyiNq6lDnqpt2wvT0y96dzJ5W326B+9Bio1CI2AZdfqCgGH9egOWJt8zuQyZ
 Az9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730997133; x=1731601933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cl4ZO8ew2BAiajP9BAvW5+7ZXDojU8B2khh55fONv8=;
 b=Na6xWXMjrL4tPKsLcJhCaDlOOmPrnTRima+E6cZd6Y+1K4KC/9+vN8/1oDn8QGT6k/
 T8ztfVGq3m8jn1Jb4LVOrE4WyAMUs0Zo7alpJTSE6lFg8o1llKimCjGBaGsMfkd8Y9on
 1Uwl8Sc3t/VBBVMercEMDVtxizFT8Eld88mlY1BNSjml+uZKnYGp9vSorBi0OdB3pqUP
 WaX0BsAc4e1ut2QMarPFqdhi4BAexkhrekoVxLr4Qw4VNfBFbr0heMHp6llfISdVIhLR
 KY/c6oYnkCCaMBCEj0t6igKNZlcy/MdtjAaN2DqG1OuZK4+HYfvhdchAPcMIsrm4bRqy
 72zg==
X-Gm-Message-State: AOJu0Yy6pF0X6FJQbtxNgtqiGhTyfN4LuNsGz9SvkG7YWSsMpqJygLUY
 SzYeTf6X10tXKOIDVrhl3f4UjHvSIZOL81TzzGuEa3nfV1f88gRnz9rGcWMm3qnQ8VS9aa4/kj1
 3
X-Google-Smtp-Source: AGHT+IFHQb4h2VI2jURzQ9uJmqNRbDVdHLyLxU8jg32m/b7eZU8mA6Gr+f03Obdvq1b/hzcyDKE2DA==
X-Received: by 2002:a5d:59a7:0:b0:37d:4376:6e1d with SMTP id
 ffacd0b85a97d-381c7ac45b8mr24204658f8f.41.1730997133200; 
 Thu, 07 Nov 2024 08:32:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea587sm2185161f8f.78.2024.11.07.08.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 08:32:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 2/2] net: mark struct ip_header as QEMU_PACKED
Date: Thu,  7 Nov 2024 16:32:10 +0000
Message-Id: <20241107163210.3620697-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107163210.3620697-1-peter.maydell@linaro.org>
References: <20241107163210.3620697-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

The ip_header is not actually guaranteed to be aligned. We attempt to
deal with this in some places such as net_checksum_calculate() by
using stw_be_p and so on to access the fields, but this is not
sufficient to be correct, because even accessing a byte member
within an unaligned struct is undefined behaviour. The clang
sanitizer will emit warnings like these if net_checksum_calculate()
is called:

     Stopping network: ../../net/checksum.c:106:9: runtime error: member access within misaligned address 0x556aad9b502e for type 'struct ip_header', which requires 4 byte alignment
    0x556aad9b502e: note: pointer points here
     34 56 08 00 45 00  01 48 a5 09 40 00 40 11  7c 8b 0a 00 02 0f 0a 00  02 02 00 44 00 43 01 34  19 56
                 ^
    SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../net/checksum.c:106:9 in
    ../../net/checksum.c:106:9: runtime error: load of misaligned address 0x556aad9b502e for type 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
    0x556aad9b502e: note: pointer points here
     34 56 08 00 45 00  01 48 a5 09 40 00 40 11  7c 8b 0a 00 02 0f 0a 00  02 02 00 44 00 43 01 34  19 56
                 ^

Fix this by marking the ip_header struct as QEMU_PACKED, so that
the compiler knows that it might be unaligned and will generate
the right code for accessing fields.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/net/eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 3b80b6e07f3..14c34f530fe 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -56,7 +56,7 @@ struct ip_header {
     uint8_t  ip_p;           /* protocol */
     uint16_t ip_sum;         /* checksum */
     uint32_t ip_src, ip_dst; /* source and destination address */
-};
+} QEMU_PACKED;
 
 typedef struct tcp_header {
     uint16_t th_sport;          /* source port */
-- 
2.34.1


