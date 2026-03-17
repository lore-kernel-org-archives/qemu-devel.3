Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0EAFD8777
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Ulw-00014W-20; Tue, 17 Mar 2026 09:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2Ult-00010q-Df
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 09:47:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2Ulp-0002KT-88
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 09:47:44 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-829865a8471so5511535b3a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773755259; x=1774360059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8fk75+2+dehpCUWtG1Tw3F2LtHObu0LZAs9CryAiLw=;
 b=LzuoRb+RdmGec1rgSgGuDzsuuBfIDSBrgr2mjcCxdaOlp2iDdtdlLV5+4KVBQqOA1A
 kwiTZMtfMHcXoLLXUCq7WsIwJq5s4/A4T8cKQ9cTPLeZPj/RX5QvoqHZ6wVDNoxbvL1B
 UQbVHn/oSPAMLWQlL4vwpQQgwVAE4IP0kpn4dYiFfTZXLoGPKgk5LRWQaO26Ffj+Q/Fs
 xfvmK+6v8G74eVF49L/MYi+sK0EkRLUw7EtuA0duzZ+0ziA3muhlvu8NZN/8hb2jR2sc
 0h/4nr7PlcnVQedKsEeRTjIg+mwrLlUIi8X/cyXtNjS9pcHPwefKYzT7WXqSxMIP6Q8j
 qn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773755259; x=1774360059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d8fk75+2+dehpCUWtG1Tw3F2LtHObu0LZAs9CryAiLw=;
 b=VOGlpzD3ES2l1s4ceQE7KfAGk1BAlTLCTiYWECgu4oPsiDhKWSWXx+/Tu8WFt0j12p
 xEyr2qkWZcfslgfvqXNnF0GPu7lDOkNJAhTz5yYER6/Zgy2relRLp5/aybafoEmGzkdk
 +P69Tn8tqrlM9o99fIDXwZ2OkXAtiWQU3Hu/L6+57RHQAsmffdsL46uLWUQUD0oWTO5Y
 hY9ZMHe92+JIDV17RSFqaV4N3HZXMRuzAsCYJECZn2w7JVejsdxoJola3QQaXu4ebD2A
 vZ+lTwDgK34uN9UNxNaunraoHjL1d4oWu6tkO9h9kWtCaBxuX8BQiszYRHKytwGjeGoK
 IAvQ==
X-Gm-Message-State: AOJu0YyQPC86o9F6FBC0GLuw5J/LMYhgI5SCIuFvDmcFVWaT/8rR+Gqi
 431nSw+AqsrKfYAKWkplScSttyVktSCoBV5CQyOYmxNWfi95v63jZ+PU86CMu0seeA0=
X-Gm-Gg: ATEYQzykvIcf3ntcc8BxClOtGN1mP4ZdySboJH1vegl605vB1T+kITVzjeBd/jtQh0J
 xrqJF3yepmcf4pn7/tTSSnr8ovkQMwudC09zd1NsxgUXZt8IH4LsihGSuUHJDYZDM2mfMU4/F/W
 XL4ck0tF/fXdaRzeNcfoA1W3sHkkpy/VCnZBmONKOhQtddAsDto6pHaS0p3pTLgBXEOeiUFlvoq
 fkdxl3V7WGzjvogmdQJyhPahzdNYHLq1hbCi8JHZoYBOB5wNA8/848pJqlzKsnvtdQoLdEXSvpP
 JSDOwBjiD5VS1w3tjoPdcZRLWpgcOXItmMzOPtyiUOBY6ouQaY2JfZC1v5FiUGQI+Hg5l1YKWjb
 fpquk5Y0ryIxolJJ0P/zzRCEsSLztnwN5JNYpajSlPPnccIpEnpbgWcGg4OvoNzfhFjIAQyxPso
 SeBNfm/0NVckZNKu+YQZqahTBaMN6gRkPcRVILRQy443lm4ezzt4SiqbZou0iJ2uJjv+ENjLWbw
 IhiQ6Qjiw==
X-Received: by 2002:a05:6a21:6e46:b0:398:e2b9:cce4 with SMTP id
 adf61e73a8af0-398ecccb8camr16473482637.40.1773755259335; 
 Tue, 17 Mar 2026 06:47:39 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7404576d9esm5546956a12.6.2026.03.17.06.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:47:38 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pierrick.bouvier@linaro.org,
 alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com,
 Trieu Huynh <vikingtc4@gmail.com>
Subject: [PATCH v2 v2] plugins/api-system: Handle migrate_add_blocker() failure
Date: Tue, 17 Mar 2026 22:47:33 +0900
Message-ID: <20260317134733.126584-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312121617.228654-1-vikingtc4@gmail.com>
References: <20260312121617.228654-1-vikingtc4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

migrate_add_blocker() can fail (e.g. if migration is already in
progress), in which case it returns a negative value and populates
its errp argument with the reason.

The previous code ignored the return value. Pass &error_fatal so
that on failure QEMU exits cleanly with an informative error message
rather than continuing in an inconsistent state.

Resolves: CID 1645470
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
v2:
- Pass &error_fatal instead of returning NULL: the plugin has no
  recovery path, QEMU should exit cleanly with an error message.
  (Peter Maydell, Pierrick Bouvier)
- Remove manual error_free(migration_blocker) + migration_blocker = NULL:
  migrate_add_blocker() already does this on failure. (Peter Maydell)
---
 plugins/api-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/api-system.c b/plugins/api-system.c
index 9a70b9caa6..fbf905cd63 100644
--- a/plugins/api-system.c
+++ b/plugins/api-system.c
@@ -108,7 +108,7 @@ const void *qemu_plugin_request_time_control(void)
         has_control = true;
         error_setg(&migration_blocker,
                    "TCG plugin time control does not support migration");
-        migrate_add_blocker(&migration_blocker, NULL);
+        migrate_add_blocker(&migration_blocker, &error_fatal);
         return &has_control;
     }
     return NULL;
-- 
2.43.0


