Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964CFCD128D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKkz-0002XH-UT; Fri, 29 Mar 2024 18:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkt-0002Vz-TF
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:25 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkp-0003Uq-Us
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e00d1e13acso17038075ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751478; x=1712356278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUaBJKSO6H1bbGryp1PQTqH1TE2lEnHyVoVrY4Z6LJ4=;
 b=YMbDbEwa44L2LhoZinm+P7gyCr76Y1QyIPMHQ3yw2mHqmERJsfQOLG4NDOMt92ixhl
 ZhcylLUlPH8zmyvISWYquIsB/4mZuBFDqU3N6h5ylxJQFLfZ7kwaC/QL6Ucl2ie/cyj9
 8l1ky79rqj20dlb0wMUW5zjum16YSrus1uGcke7cE16aq6LquAyBny72QVQQvcmLt2AJ
 dUWH0XW3aFxu+hhqeML6E5moYi4vwOzmEk3xZNnDJB6BgacWNDGHg76K7wEsnnVhVWNE
 OH7Wl0A3l4doPB5dE4fGFemVXBh+02xXmNcLgM8wlKbdqn/iNWQPcaY9ZMFJcFkiSfFp
 nngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751478; x=1712356278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUaBJKSO6H1bbGryp1PQTqH1TE2lEnHyVoVrY4Z6LJ4=;
 b=uy7L3kdZ7njYibtL7iuZMlJUFMkZSizCwMqOQneYS0Gwog+Lke48WqPv3M/Au4OeZ3
 4vhwwv/NeZ7VhY3zJ767FxPXjgusfIS3P4zG5QMTnfouvpgrHmCf/yMPWUPeyPFWYhcI
 TaF313aDbu3h1koeKnUVGUaOI7kBaQuaobzQlg/ua9trkPTk6zbWzyJVYKH5Wz781Z3t
 FIR5LKW+RKMFkbklZYzRUnWe2KBMhDKkohcDgEf7sidxHYD5nOdTNrq6i7HwCXqhgfKE
 y/htjJzX/fyHgE0sv0QA+ZwzCp9i93l6tdLBTt46m4GyAl/WVE4G74irHbMS+HDEiEmb
 ELNw==
X-Gm-Message-State: AOJu0Yywz+NOJZ7US0DO8Za/fzFOIl0nJQwduUnVyFSPExvwDZdOiUV8
 EpNTwGmfUHbCxZA36ywq4SKvpHnYgIq/BE5XXji6qLSe3qWZ2hK27RDF9By+PjcsbfYDTorh78c
 2
X-Google-Smtp-Source: AGHT+IH6uQQKd06nVO8zs1OKfCZxzzXj/fc3gGvrXNcGBRV5LsGwBooSKsXY0n8EBn4uIPf0w5Pz1A==
X-Received: by 2002:a17:902:6546:b0:1e0:a326:e89e with SMTP id
 d6-20020a170902654600b001e0a326e89emr3307183pln.37.1711751477989; 
 Fri, 29 Mar 2024 15:31:17 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/18] target/hppa: Fix B,GATE for wide mode
Date: Fri, 29 Mar 2024 12:30:55 -1000
Message-Id: <20240329223111.1735826-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Do not clobber the high bits of the address by using a 32-bit deposit.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 1766a63001..f875d76a23 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3880,7 +3880,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
         }
         /* No change for non-gateway pages or for priv decrease.  */
         if (type >= 4 && type - 4 < ctx->privilege) {
-            dest = deposit32(dest, 0, 2, type - 4);
+            dest = deposit64(dest, 0, 2, type - 4);
         }
     } else {
         dest &= -4;  /* priv = 0 */
-- 
2.34.1


