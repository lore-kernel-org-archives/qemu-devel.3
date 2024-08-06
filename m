Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC1BC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJVc-00044R-HL; Tue, 06 Aug 2024 08:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJVa-00043w-Jv
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:41:46 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJVY-0006vp-Jj
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:41:46 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5af326eddb2so10674542a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948102; x=1723552902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tQs7092ZSxdRDUP+AqGLcg98ipEOV78qfOl0IcLywt4=;
 b=MroP/3rfeFoCqxPuRIM7LVMxsI5VDX5GF6rtlza9ZxiUBwMPsF/FhJEqCvO7oV3tnb
 CtehJMR+1ps5eH3cHfi5f4wftMAZlwVL8uUONUhGlVibHi1wkRCT9ngcLYwD2iv65PNo
 oMR9PxSNAWiPtBPYBwfsgaIR/OXr2Aotp2wLGrngvxykmSFDliyEojIDvspNnWm+aXtx
 8DC/fHFylwBcCT6ROt+ke9NLdkqsvaM7ShHE8MYDERaUfDNO7kO+a1w6h5g438JDsrXR
 naqjhpSuVZUYGp13ghaN+bG4mP1tiThi/6BGPMyB5cSRt/Ov0V60+5ewyu/wpmDFTfWq
 uliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948102; x=1723552902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tQs7092ZSxdRDUP+AqGLcg98ipEOV78qfOl0IcLywt4=;
 b=XdqQIATGnuDPuK37NcBq5uDWVhGS2IwuTSBG1Rp8fJ0SdNcSCuxGFsTn/J1KyBj3uX
 nuRphf8PCtmv6qGLrCIA1NS+rxWROgbWia7px4W21z7gSmUdiOFw2yWF30ZhE6JQ8f2N
 Muo3OWSLDhVdrjFTJgejva14ajx+huTCKa6qqVKMAi+s4IL89WbmbVosyS7eTgG0enW/
 5BTTthPffickCeIPJrpz55KdffHkVIxmTD29W3oVpuenEZm9LsieTzUbicVr5llpP69p
 1h/scq2NUBLvhCmRmS8vQRck/HLP/z34f72XcsIizEarWmApM/rT5KbHAvcqihgLd2mw
 zfUA==
X-Gm-Message-State: AOJu0Yy9FDYdRFKUCYWaeIyyS11hlEUwTZ5vsasiTNmeJ/FzquGDs9jN
 0Esi5jmhhagyU6iu28cODOSNFX4DWPF7Rafmrd6iugPablo9EqxVnRqi5rr2EX6WAPl8c9sG5OF
 l
X-Google-Smtp-Source: AGHT+IE3PLzY8/uAlD7gioNMjWDeh4MTKJEas60nnnQ+cgUE77wLEs9G49hm7ZPMtPT+kayvzQvW+Q==
X-Received: by 2002:a17:907:3184:b0:a7a:bae8:f2b5 with SMTP id
 a640c23a62f3a-a7dc62d867cmr1269057866b.36.1722948101860; 
 Tue, 06 Aug 2024 05:41:41 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bc3c7asm557554066b.14.2024.08.06.05.41.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:41:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1?] qapi/util: Include missing 'qapi/error.h' header
Date: Tue,  6 Aug 2024 14:41:38 +0200
Message-ID: <20240806124138.90636-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

qapi_enum_parse() uses the Error type which is
declared in "qapi/error.h". Include "qapi/error.h"
in order to avoid:

  include/qapi/util.h:27:30: error: unknown type name 'Error'
                    int def, Error **errp);
                             ^

Note we include it after the QEnumLookup declaration
to avoid:

  In file included from include/qapi/error.h:275:
  qapi/qapi-types-error.h:30:14: error: unknown type name 'QEnumLookup'
  extern const QEnumLookup QapiErrorClass_lookup;
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qapi/util.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qapi/util.h b/include/qapi/util.h
index b8254247b8..568f31ac9e 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -22,6 +22,8 @@ typedef struct QEnumLookup {
     const int size;
 } QEnumLookup;
 
+#include "qapi/error.h"
+
 const char *qapi_enum_lookup(const QEnumLookup *lookup, int val);
 int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
                     int def, Error **errp);
-- 
2.45.2


