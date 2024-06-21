Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C220C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 07:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZ84-0007aU-TQ; Fri, 21 Jun 2024 03:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZ83-0007aI-6U
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 03:56:15 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZ81-0006EN-JP
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 03:56:14 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57cbc2a2496so2015016a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 00:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718956571; x=1719561371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IzQLNAGPwNKDPbpDvBTrnLSOC5ryk7VLNi38y6lx6kE=;
 b=dIXdWOyB2FTRQZ+eytOEFh04ceuxyFlsOotedyouz+OiUSluMoBHGrT+3t9HIwtyuN
 EHAcYjQJyH6JQafXlmgt4PQly80rle8tfSiYoBJK8Uv4ZhF+ST6OZzRizE2ghKPVWFTE
 KvoErW1yaC60MnnS/WDzmn1Ln9GF0XYGiMfC6sDjI/jhsagr/0JV0geYN0uEztugqjUL
 mpzjXWiE2PlzOTzLD7/RfFsxsDEEsCab+DHIB5GrDiZSROjLwBCcVAjApg7tN8stYYRv
 Q8dAm4GbsLHhfVQH+iUIWS22V6apWqJd0IPhHztiCr6zgk3kt+l8A1yXcph3vku/l6JO
 9KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718956571; x=1719561371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IzQLNAGPwNKDPbpDvBTrnLSOC5ryk7VLNi38y6lx6kE=;
 b=Cdqy6VKpnP+pV5LJC2QxUIiiwO2raHz342aZzd/cR5+m8AzFpRCSzX+QQ4UaJ8Z74L
 y7LwhKxw3oEZdRY7vtW5hmxmfj+i9VAY7coX4ZaJ2fvDNkalwq4uRPQVfPO11X+m+47a
 2Oko0W1Ne063Ij8K102aBzZeQzgNsBgz/rMlNVei0jGZ7APY01TMXrBvlOUOkYl3Q1em
 I3tNuh2ptV+8PdmT+ibE7fD97rRYjzek1jwM2+cSck2Icv5kqpv/wxTSKPTBmyG8ZxGu
 og4pRj+CBCFjhDY+9ni26dJ3YbOEkV7xe2BtylCca5Ub7BWXuNNm0CCopcD9kgri15AA
 Y0GA==
X-Gm-Message-State: AOJu0YyiJaCC+7F7SppahLfEDLpt9pDMWcGRRd59GXgA1/ezNk5RdJZ6
 mtZwNVMUhK8pr6MS1v95baGv/44jRtm6UdqSwvr5V4eapJTQUeL129eTx7XMflu4is2I+iUx68f
 b
X-Google-Smtp-Source: AGHT+IGRB/MOO1CbmTnVgzkA6wYZctk7eIPiDHG2pzi+OZ3FnRa2rD1+vKK8b8Lh/xPOzedv88j6lQ==
X-Received: by 2002:a17:907:a608:b0:a6f:6389:4aba with SMTP id
 a640c23a62f3a-a6fab609e80mr626933066b.3.1718956570755; 
 Fri, 21 Jun 2024 00:56:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf56ea09sm54361966b.201.2024.06.21.00.56.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 00:56:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>,
 Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] bswap: Add st24_be_p() to store 24 bits in big-endian order
Date: Fri, 21 Jun 2024 09:56:07 +0200
Message-ID: <20240621075607.17902-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit 14180d6221 ("bswap: Add the ability to store to an
unaligned 24 bit field") added st24_le_p() for little
endianness, add st24_be_p() equivalent for bit one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Some SD card registers are 3 bytes wide stored MSB first.
---
 include/qemu/bswap.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index bd67468e5e..ad22910a5d 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -38,12 +38,14 @@ static inline void bswap64s(uint64_t *s)
 #if HOST_BIG_ENDIAN
 #define be_bswap(v, size) (v)
 #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
+#define be_bswap24(v) (v)
 #define le_bswap24(v) bswap24(v)
 #define be_bswaps(v, size)
 #define le_bswaps(p, size) \
             do { *p = glue(__builtin_bswap, size)(*p); } while (0)
 #else
 #define le_bswap(v, size) (v)
+#define be_bswap24(v) bswap24(v)
 #define le_bswap24(v) (v)
 #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
 #define le_bswaps(v, size)
@@ -357,6 +359,11 @@ static inline void stw_be_p(void *ptr, uint16_t v)
     stw_he_p(ptr, be_bswap(v, 16));
 }
 
+static inline void st24_be_p(void *ptr, uint32_t v)
+{
+    st24_he_p(ptr, be_bswap24(v));
+}
+
 static inline void stl_be_p(void *ptr, uint32_t v)
 {
     stl_he_p(ptr, be_bswap(v, 32));
-- 
2.41.0


