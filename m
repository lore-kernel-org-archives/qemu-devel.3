Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE24D58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwumw-0000yj-UY; Sun, 01 Mar 2026 23:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwumv-0000yH-Lp
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:45 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwumu-0006oS-5v
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:45 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4c7d04890so3771580a34.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425301; x=1773030101;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0CRkjyhdguI6dPnABFXZ/GSFvPOZ/1FfXcgqI/Pdgu4=;
 b=oNGRFXmpeKnMjfWwagdb+My1+weB6SStFVtMjD+TyqE9qj1DVfGRTREmSxYe+gW1Md
 oPrlZOhLHeLfG51ybubhd/E5GxQH8ivtkhKJSvyMibgdsGAWKdufK66IwKGbvTHqlLUF
 7PwwYagvhkN8cYh6z5fOfbr5IPaN1i8w2i4gMfq9V7UKCn91GPFAaSnZ7nlYtwc9mUk4
 Q8x2G3iDYYd4PuJc95An3VihjsorxVOmDmv61yuW9X8qmP+iIDHl7+QBjZxQ342fwqbP
 0RKHCy4FjOw8EHO6cX2hRYqfDLYY1wmlBc3THnKugYY4fMKje8L/wLYmvDKeGHzFhk0h
 9oKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425301; x=1773030101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0CRkjyhdguI6dPnABFXZ/GSFvPOZ/1FfXcgqI/Pdgu4=;
 b=jrSMX28LEMxkPEpV2egW/b/nqjy0z9uZReXSTohqMPy9yLec9kZLqgoudHf6I25Gio
 CB7ldEq944d1VUcHY4dekl1JDGApQQSKD4YHy26VdDw3EcHkvgR8L5f0zE5H26dDMTWl
 cCLT1oCr2OfW5FdqUBNlu+5jVhW0Ylj1w9UVNnj2aiAFWocL/+JCuhinH7mGYGD1zB27
 nD/NtJVwPqiLG9l1QOBaQrd71/QgIVK9Ejtp5MEyWW1KS51nhlJ5LM2pqk7Bwos5jCbW
 1Cn4zaxwxXiQgvMPu1OxkFsE5AOi5KhwfXZtV13Ldtot5uAgOiD75ew2mlJfiimnhQcg
 zslw==
X-Gm-Message-State: AOJu0Yw9Ot9lGzOsvvPaCiGGLi00+JabQUIYQw+5AcZBmPb3kdqxvGvF
 8PUb6a5I0qHmQ2D9xEECU+lIch9yAhCVwrjOqnveI/DIcskZBKNcjzHuJmKAaMwzMX8xjwmMcy1
 ca7/M
X-Gm-Gg: ATEYQzwxLQheetzAyIDdypRvM+jj7tA5XOgz//P0TONxJwqTvWYVFu6pKxmeaJ55B7M
 n2Fw1iHikhrzncysP+h5YKVhKUQiZ2uF7u0GZOGLiKgCxHZJC1uMHYKYs0t+DpQlKWS7oP/SUHx
 UsbrLwLwXWEXQnDjF6zw7H9NiD+vYgz4EzTnZudP8MA6aoZxkWj9yALAGBniRu/i1kuGSZi/p02
 ucEhLwUuuXLeKjUXIHYySTzoAfmgNCzEFNGRDF4wVFk4hc1N6elNKDzD/UED8LhxLUr6yzQTQR4
 NOmGdFa9G6nTuQ7M486SDtjA3phND4WrXo315KPl96VfQdbbyCe8GyDI3+chAyicN+kzBhdgd+v
 lJ0qDlSGkM2m9bAPPFCNyB3Ouc5INIX8IqY5NeXHyqZ5seYbz17z68UJbg84Q74UOcmrO0Kb+6z
 uC1LF3Ca+mmQ==
X-Received: by 2002:a05:6871:3312:b0:40e:e8eb:b74b with SMTP id
 586e51a60fabf-41626fb9e93mr6446208fac.35.1772425301580; 
 Sun, 01 Mar 2026 20:21:41 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:40 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/27] bsd-user: Add target_uuid structure for uuidgen syscall
Date: Sun,  1 Mar 2026 21:20:54 -0700
Message-ID: <20260302042115.83410-7-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add the target ABI definition for struct uuid, needed for uuidgen(2)
syscall emulation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index a4967b444b..84a3837b6e 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -483,6 +483,20 @@ struct target_procctl_reaper_kill {
     uint32_t rk_pad0[15];
 };
 
+/*
+ * sys/uuid.h
+ */
+#define TARGET_UUID_NODE_LEN    6
+
+struct target_uuid {
+    uint32_t    time_low;
+    uint16_t    time_mid;
+    uint16_t    time_hi_and_version;
+    uint8_t     clock_seq_hi_and_reserved;
+    uint8_t     clock_seq_low;
+    uint8_t     node[TARGET_UUID_NODE_LEN];
+};
+
 
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
-- 
2.52.0


