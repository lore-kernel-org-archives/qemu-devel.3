Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8EDE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 21:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMCs4-00070W-MZ; Fri, 13 Dec 2024 16:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMCry-00070F-7t
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 16:06:42 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMCrw-0004vJ-CQ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 16:06:42 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d89a727a19so31798896d6.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 13:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734123998; x=1734728798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A2kbupBtdaf8sZ/EHMZkFvb/iOEYsdgwFCiDb5bgoRo=;
 b=aymCnmrH+KqxRRyfjrnF3snlVigb6qqkeLnKxXFll6eiinauhOwhd4L1yDIoL9Sk+q
 50Z9bBzNE9JON4F+eNRYBgBbKVvDc0itMOSeSfyExZlyl4nyVPwDoLsA+7+NmiTKqfqW
 KvN/768CaGMDBD82zvQphlpDFgjHT8ZcaHdwm64KUH4/hi6/c8OzLaLSOjG/x7YqIiaH
 oEIcH918S15DOBS5JR4p2smzZilNVV5GsMDC7r7Cg1RBjKkwIey1Zo/RCSw69+rgIDFx
 VoAq53vi64cqeqeucYh9Z1mOBzFDDM9xZOh8ZZZfePWXGEWhlKE2Ccvol4faq2IWtdu1
 wVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734123998; x=1734728798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A2kbupBtdaf8sZ/EHMZkFvb/iOEYsdgwFCiDb5bgoRo=;
 b=gfIsmEbMk/mCpedtSLhfZVMN0+UW6H06+wGdorUILXy4+fVYx1FchPTeRlhpVDDwjF
 BnRSS/z3XqVTUC0I0LkQ573S3lwFW3cmXEuPKq2FYxAeLeUh8YHHiEDmgD/ENpkXZBSg
 PxAjlfh6oHY76SgITkiQQ/67sGs2QqyD3pMW9UnaFXERbMXSC3ncDeCRoGF1ql5pUMZ1
 c+5RyMbSxWD4UII23nmenFBCzBSAkUqdncT697ue2Cwwgyv0LuHArK78uUs8RQanPClV
 EaWlJkRHjMkXNCdXE9OlR8KRfl9JoSBBLaMdiuuoe1kuMZexm3mvnY2wWxkaxz6+jYvR
 VkWg==
X-Gm-Message-State: AOJu0Ywh2ucmK7ssTjIUjoDZxb13KrpBxF+qK1CpNENOL2DY/B+qpT26
 9/SA4XWInUcXOQCQarGrdLcPR/pvajI0T2dQ+8zLQrQjQxGlfzi970sakUpbtSv1J8DVU9hYBfW
 hKWZdS/tI
X-Gm-Gg: ASbGnctLYsuRpAxVTGrrUCaJ/wuBAgNhwOFfGbYZENPn1opUSLpHZpkvBQAUV3WGPk9
 yIIeQfoBYhXmWVztBY4vAz6nYBfyP6fbQADpZrUQmYOgXAduGJrVTbuKw1rpW7wTW5GY+aQOFtO
 EqQkh74KoFJ5cJBbJd5hnbkD8+B1Kr/dZZ/RKBJ2cHu9FizctEjtUJmDA7YlVF52Yc7C/P/2GCL
 x9NaZABnoulnuZg6A8BjZyJzcUpL5t+wCU3NVwWqFugur2UAGsOIQ/7l4ac/PYl
X-Google-Smtp-Source: AGHT+IFEmg9VSAJmQnAGF9ti0k8pj2zecxePwNhD48UR4QVzHZ4D4rPOl0yr3u5aMrgWmRZFlEfu1Q==
X-Received: by 2002:a05:6214:f03:b0:6d8:f50e:8036 with SMTP id
 6a1803df08f44-6db0f4e049cmr99111536d6.20.1734123997908; 
 Fri, 13 Dec 2024 13:06:37 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd257d49sm1256026d6.38.2024.12.13.13.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 13:06:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] include/hw/qdev-properties: Shrink struct Property by 8 bytes
Date: Fri, 13 Dec 2024 15:06:29 -0600
Message-ID: <20241213210629.2525655-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf29.google.com
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

Before, via pahole:

arm32, a 32-bit host which aligns uint64_t:

struct Property {
        const char  *              name;                 /*     0     4 */
        const PropertyInfo  *      info;                 /*     4     4 */
        ptrdiff_t                  offset;               /*     8     4 */
        uint8_t                    bitnr;                /*    12     1 */
        /* XXX 3 bytes hole, try to pack */
        uint64_t                   bitmask;              /*    16     8 */
        _Bool                      set_default;          /*    24     1 */
        /* XXX 7 bytes hole, try to pack */
        union {
                int64_t            i;                    /*    32     8 */
                uint64_t           u;                    /*    32     8 */
        } defval;                                        /*    32     8 */
        int                        arrayoffset;          /*    40     4 */
        const PropertyInfo  *      arrayinfo;            /*    44     4 */
        int                        arrayfieldsize;       /*    48     4 */
        const char  *              link_type;            /*    52     4 */
        /* size: 56, cachelines: 1, members: 11 */
        /* sum members: 46, holes: 2, sum holes: 10 */
};

arm64, an arbitrary 64-bit host:

struct Property {
        const char  *              name;                 /*     0     8 */
        const PropertyInfo  *      info;                 /*     8     8 */
        ptrdiff_t                  offset;               /*    16     8 */
        uint8_t                    bitnr;                /*    24     1 */
        /* XXX 7 bytes hole, try to pack */
        uint64_t                   bitmask;              /*    32     8 */
        _Bool                      set_default;          /*    40     1 */
        /* XXX 7 bytes hole, try to pack */
        union {
                int64_t            i;                    /*    48     8 */
                uint64_t           u;                    /*    48     8 */
        } defval;                                        /*    48     8 */
        int                        arrayoffset;          /*    56     4 */
        /* XXX 4 bytes hole, try to pack */
        const PropertyInfo  *      arrayinfo;            /*    64     8 */
        int                        arrayfieldsize;       /*    72     4 */
        /* XXX 4 bytes hole, try to pack */
        const char  *              link_type;            /*    80     8 */
        /* size: 88, cachelines: 2, members: 11 */
        /* sum members: 66, holes: 4, sum holes: 22 */
};

Afterward there are no holes in either structure.
For arm32, size 48, padding 2, saved 8 bytes.
For arm64, size 72, padding 6, saved 16 bytes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-properties.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 26ebd23068..1d154c1f23 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -16,17 +16,17 @@ struct Property {
     const char   *name;
     const PropertyInfo *info;
     ptrdiff_t    offset;
-    uint8_t      bitnr;
+    const char   *link_type;
     uint64_t     bitmask;
-    bool         set_default;
     union {
         int64_t i;
         uint64_t u;
     } defval;
-    int          arrayoffset;
     const PropertyInfo *arrayinfo;
+    int          arrayoffset;
     int          arrayfieldsize;
-    const char   *link_type;
+    uint8_t      bitnr;
+    bool         set_default;
 };
 
 struct PropertyInfo {
-- 
2.43.0


