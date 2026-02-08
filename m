Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D84CEF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpARf-0000jD-CP; Sun, 08 Feb 2026 14:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARK-0000f3-Cu
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:28 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARC-00006S-CZ
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:25 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d1916d1e24so2929049a34.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578806; x=1771183606;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Za64mH2olhqqX9NrtIAafwT+hIGjFO5DSzG1uatzsF4=;
 b=b3VyafYYGs/8y99s7mRvz4CT54X2LLqR+Vvc4fIhA4RPI5PrK/DLqVu0YIqOmqTQLE
 WsSM8+JgzPKfghw30u9KB9ZR8HdDGCJuzItEYjBSOG9jrzWqxU0QrU+Wutup5ZKwANCr
 plu93QpeAY0JH3nWm+K69jB2Vj/EKLDmVEh6HwsYmcm/d4ZHqUMI4WkzFTQ3ytmTSEbw
 bsTs490hvZEQ+NhKb1b3cXWY27zjeiSIkhNUu5d9m43S991bCFKFNNGxyg6wfMA5oiWy
 myLNkK358QeHU9t9IHA6fU319gNCm9/Bx2w1HN8rQb989iiFLTlSAfNGNAITa2XqRqU5
 ITtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578806; x=1771183606;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Za64mH2olhqqX9NrtIAafwT+hIGjFO5DSzG1uatzsF4=;
 b=OMED71YYjx/C6vqVZe+fv4gO1pdnv9vJ/Q2bq7f9//bKVAg3BXDHpNWAwCvCX4MHLT
 Hu0DDGcRDwUqFfo9p9qtfWxCzCNl6AZo54A/D79HFCY0CWkM+i/52HLF/G57Uzshm7+U
 om7xUljyzG5W0gwsbc2glwPosj+dsokBafUQJJvqZnXNHeIftIPtLff3p4Uir+FBlBR2
 nCZFKaiVEtvFHz4LYelqlsmjNkwsgxoY2ZfX/jkNF3XAu57LZDnEUBdpC9eyV9BDfXIp
 GrYiV2FgJ8aSfPlnU3zVxDCCbXFN/8QD5U++7OVdlx4XQv4P9rhZWFDpDDGXl1SXeJ9C
 6qlA==
X-Gm-Message-State: AOJu0YyljxMZYeKFWtma1efDfIb9tF7ZKRFIJz9Zz8R7SO/azxhZvU+S
 SL5tOEhqMCSfjBW8k6xeeR8ByppP6+D1+1ET1kV6kwcvJ55buDZcIG39aPKTaVOgN/w=
X-Gm-Gg: AZuq6aKujcXG3U3N1ZPgY4ESBQwJmTxt4G1llBr/lZbdKx7zTJ9426k9tYBXrd8nAoG
 mqV8e1h66A1Hqt1XEbAfCKQXKCHxNY8G8U2pNPSfM9iGNJKOu+dEyK3EJYZIfmvc/NrCkU7u4eK
 dO08Rj0Wo6CJld6kSzIrrGOzCAaKQ0NYMWRjimseOVHShHd63b4uEOqyxff4QyKA+GpFL9zzr1n
 PASbsY6nd1e3ERmjIytOA6wPfnkJU92H7Rs0Rjc53+mIiKf7FCZmJXNy+2ZGKrssmWfiWfLgAkh
 L+hd9gqpNL7GCSgaJHelqV3c6YGtZyQynccAomPNwGTszuR2SiIQhfDsgeGbWV1OLj32fJz8GLw
 CbGpL0iNy5umHoL1ivg4eIzJnvM6FuaFESb/1AOn/QBl9uhrqJZERcntZVOl6Wdl8UQjAKDtGzg
 ==
X-Received: by 2002:a05:6820:228b:b0:66f:5c21:b4c2 with SMTP id
 006d021491bc7-66f5c21bb65mr1938627eaf.51.1770578806655; 
 Sun, 08 Feb 2026 11:26:46 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:45 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:25 -0700
Subject: [PATCH v2 16/24] bsd-user: Add do_bsd_semget implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-16-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=RByKMcPZD1MnRAeq/kr7dvGGOMa4LX07mKrELgzbIG0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONhcb3TKrSr8rT8DnJK0TohPzU+XsxAP6S7e
 ldAw8g5ZdGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYQAKCRBsHNEofbAR
 AJXeD/9+dMU9Q1U/UMwynzxKvtBZ10vyXQwA4lboBRhfIv8btKEgP+wM8waopERw8ZHZrpx3ovu
 fXDGpbJw16j/N8mSYGsfHoOMEpvYTXG7GkTH+h5/bDHJjUVqi4W6LKoXzAPihLh2tTG4qMS+/cw
 7r2nic05DbOb2W9gc82PWZu5ao+43XOIFiMgf/Z7ptcJYnzMtYrkl1xiUOZooxmYlvZseNPsLfE
 fd7fZdolRgmilc6LWWl7LTbhLr7SJINIG83mMXJkmsnmYClO/bB5tkBEOPsRMwnA9zXLnHB/qmb
 U470Kuhskz8joT8D4Jc4Tcs0ecW6eTPu6VOG9KTswsW8YWrcEtwizJU3ZokSn6ewPuEndaWMeGh
 ARrNAjRKO5VUNmB0+qoz3bU9oEe9zZQzwVwDuRjOjTNrTNUWu6PbfW1AUzlPRjewqMa6a+RYp2Z
 rV7+yJK6TGuPaxAuezxxny6+g8zne7VQP48/f0bJoMZlDKrozXJ1sgX6Ds7M7mqu/Xc5jTw+7Eo
 lzSrwxUd0Qfz07JENaQ+oDv1rboccDXrBnHrBrs5B2eMVWoYLZhdntH0X5/JciBD8kcbYS6L8sn
 r4XQ0ZA1tKFhh+RF0/pncEWS1IDw2ow5fcbXhZHqH4euZcVu09u22UKq4L8vxBAqY5O7+TQbALL
 PfrCNWPF86zCptQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x333.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add implementation of semget(2) syscall to get System V semaphore set
identifier. Converts target IPC flags to host format.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index ad248c3b79..cc489ab13c 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -72,6 +72,18 @@ out:
     return ret;
 }
 
+/*
+ * System V Semaphores
+ */
+
+/* semget(2) */
+static inline abi_long do_bsd_semget(abi_long key, int nsems,
+        int target_flags)
+{
+    return get_errno(semget(key, nsems,
+                target_to_host_bitmask(target_flags, ipc_flags_tbl)));
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


