Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1B1C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krM-0003bm-Li; Wed, 23 Apr 2025 20:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqU-00012J-W5
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:43 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kq4-0004ha-V6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:18 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso501829b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455995; x=1746060795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhN0H72crR7ocnAMdx8d6CUFaK0puwv/7eMWfuXv8/4=;
 b=x2uMZTaQxBoeJT61Z+HtZeci5nfU2KAv5qU4uGZXsmtZfib8zy2b4EZvpZGP1UYdv7
 BRUBdugw8HE4Ie9z7zlUCsbuSM0Z2KwjGgGOIfAOs6jYs8+0gYxyl2UxayEsYZDBwRd7
 WzzfJFEhTVNzZ3Yr0ncizhLrVftW/lztKCfI3unEPS2+Mkpnaj2Dm1+Rqjz4/XgcPJL9
 KYIsp+yv7nszc7vw+K5g1INLbYAGUNeUAcUDdbgwRTyPGXIlWuJ3FtkfpcD9/fOM8zzB
 pAmovEXOZ7XJr8vnYDOLeu0VgLiFuN7UHYSFV2WpZJkWFssYhQ03dtA8BisehyGyG3hr
 VQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455995; x=1746060795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhN0H72crR7ocnAMdx8d6CUFaK0puwv/7eMWfuXv8/4=;
 b=n/eM1GxRYdBTOdI6SJoXJ59eGeVWXu9xMDLDR9DtcA7+rRKPzZAGhxs4zSHXZa9uRc
 GBhnCHtNFC9iTScqFs2BSX3fTqqeZQitG4+tLYVlDfo9+uUTJfQ0K81BISJBIzKveR6o
 swbaMhXm4mOlxNrcIRwcmNTD+MS53RZpiFySXmiPgk0VhlFc1wq3WHLDFyutIT8TXF1v
 xtgbXXmuyQEkJR76Muf7TTWPQzRoQMRymkOx1ipltbfm4qUewt+OveuvxHExCsM/ueiL
 t8uRc5zuyA8KAgIl03d05Q8Lg7A6ufmCvQKYbOBQLCylQQmQfV3+MDnk0xsHHnRJxs4I
 e00A==
X-Gm-Message-State: AOJu0YyyPZg3LPv5HbUntwpdftCMzbeo5kVeTZoi+ZlDG1twf7ZaO9HM
 rOfw31BnopmjI9U/cOiRs3sty/ytJtdqF8oqVXoWRt029CuQ3CLOfu6pEWFW9dNsVbVlTOghvnx
 J
X-Gm-Gg: ASbGncvyGEkMUuPCV5y8NqZldmH9mq9f4OwwSlZSEtHIULqFVEizCh0lvR1MKzfwgw5
 iRBEzgvd6FNpNrAZGDbs9C0UTqmZWFleou8rCfUafiBsDClU97DfJ3lHDLT1Nl2wSNnoZuJL34v
 ZkOrUZW+OzxHF/+LnfFw5ynyZuj8KExqu6chWKgSrG4JEabpyBNzPT0yyohfet/cQoQXrUO/8cv
 2xu19/vhE04lY3xnJEPm0vZE0oD1WdnzfGvA1jZ2pXKWe+TyHNm1uw0M1GxaF7lMugb7KU+Gc7b
 GTiux+co2jV0NcoLP9/L9YMU/bTPI0ufebGYzWnJ4+yOgKBp3o6D831qwtqlN3xKdeim+qVBWBI
 =
X-Google-Smtp-Source: AGHT+IHq8uNwrmHtJ21X0KbThzF6CQDrvxQpIGCXMVsDYWU0rnbTyuJKEE1shBYX+rgdpW8xFu5FRg==
X-Received: by 2002:a05:6a00:3018:b0:736:4e02:c543 with SMTP id
 d2e1a72fcca58-73e245e3bc0mr1045774b3a.9.1745455995646; 
 Wed, 23 Apr 2025 17:53:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 051/148] plugins: Move api.c, core.c to libuser_ss, libsystem_ss
Date: Wed, 23 Apr 2025 17:47:56 -0700
Message-ID: <20250424004934.598783-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Headers used by these files require CONFIG_USER_ONLY.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/meson.build b/plugins/meson.build
index 3be8245a69..5383c7b88b 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -61,5 +61,8 @@ endif
 user_ss.add(files('user.c', 'api-user.c'))
 system_ss.add(files('system.c', 'api-system.c'))
 
-common_ss.add(files('loader.c', 'api.c', 'core.c'))
+libuser_ss.add(files('api.c', 'core.c'))
+libsystem_ss.add(files('api.c', 'core.c'))
+
+common_ss.add(files('loader.c'))
 
-- 
2.43.0


