Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BDEE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN29G-0007PU-7q; Sun, 15 Dec 2024 22:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN29D-0007Of-Oh
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:56 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN29B-00061n-Fd
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:55 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-71e17ab806bso2058049a34.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321112; x=1734925912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f+XQR0giWaYJSQ3hwaZ65nOMJP3BUJ/58MIcg1IC9xY=;
 b=jqe6QzDOhmcNXJhoGoYfafooO2QoQ10NJ+mvxxQvqsrC0HmWLYP3hS0NxNjcvD5ecA
 7bBcf6adY2616DG/ye3gBCm5vgydMVqITqR5fAbRKmKqEU/PoeWIScmyV1JyZYmehXVZ
 32k+wjx2yYPUjfpLxq9sSTJkGoUV4/ZYDX++qtm/njWvL+WOW0MZG+dZro/ISv41RIip
 qW8gUYEvk1KI0rrrehuKF/xQxdnuRGO1Ra3aA/wuSRY4nbPmO46jdvS0nH5xe5lCLqYv
 /Zfc8WT9oJ9DQanZf8FfzqXLF1ngF9PMVG6gMnWBk+paVwq3HxAiXdXcbysYA1EBLy0F
 voLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321112; x=1734925912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+XQR0giWaYJSQ3hwaZ65nOMJP3BUJ/58MIcg1IC9xY=;
 b=BevJ6V8olhFE2beDIjLG+1i5AwIRO4JY8k9L4UQ+kpUPD1xn2mXop5JIoIiVLOaXSI
 oyHTUwnuMCQDncuYv3VJxR/JCIcHMNoGzNMI9cAeMIhFG4So/sN6/Zkg1LzPRbZS3SMq
 Hrh6VyXhWML3L84P+tjN8h+NHct+V4uhsAJrIaPfZ+DvLgUa5xY6ZZLfSJUOY98yNoYn
 V4C5/XsqFxdR6iof/0O3rzzmjCSizCqws6763sWiRdzrRrVuEor/CFmNIYdVxSzh1Pie
 PPnebUnP1QKneCtmEWFb+Z5McTG3bBbdY3BWrtIC7OIOlHX0LOJVW8nIaj8t3rdhFn/N
 hBng==
X-Gm-Message-State: AOJu0YzNeHLF8yKTFSxG/k8E3B+Bxt6bwxP2Xlvb1jNKupAs8WNf/ORh
 2wma/t7TZJ9FaFzFD9Pnk0NN8qKMfltnktK65/P/nUp/2Z2plAe4CUmEXuKKh51tUf5FdgtlanW
 hLpTZ7jOH
X-Gm-Gg: ASbGncsAbp0tEEOZeSLZkKimtd9P5cdYT22sICNEgCpsSgPt+VUCBY4Wol1wyaPLDJn
 xbUMs1xN4Ebus5HkI/xLbrwmN4zW18Dhu70jwiJuxEnIc9kyaQeYwQuboIc00QAa9c0oHDMjL3H
 vls4KrX9q87Oz8zYJ1v9pY09jx2m8wScpq0itY4psAskKl3Fkf6myOTRFHbjcC9DcZR0pJlI0W6
 reLzBaFyHjE/rPd1uh/7K+D+ZLYQsCK4JHFQGk4bdSxj7fapgPXz4UKGSHsmUfCjF71MAH0GWCS
 NIG6XBQSTEKUOMrAf+2nHzx5ZtwfCH3czP97nB53cWg=
X-Google-Smtp-Source: AGHT+IFENkyehn9pQ0VDD7crqS8Bv9vF5pS1NPJxKVTaigABl47j7bEwi19NIDH6G9hbe02oiKuSPw==
X-Received: by 2002:a05:6830:dc4:b0:717:fe94:40af with SMTP id
 46e09a7af769-71e3b82178dmr6356540a34.3.1734321111763; 
 Sun, 15 Dec 2024 19:51:51 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/24] include/hw/qdev-properties: Shrink struct Property
Date: Sun, 15 Dec 2024 21:51:06 -0600
Message-ID: <20241216035109.3486070-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

Saves 20k from qemu-system-aarch64 on a 64-bit host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-properties.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index ef3fd7b4ae..3680cd239f 100644
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


