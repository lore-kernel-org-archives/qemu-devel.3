Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D06C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgc-0001ze-N1; Tue, 18 Aug 2026 19:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgb-0001zT-St
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:41 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTga-0005Dm-H9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:41 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-499f6e0bbabso354428b6e.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097459; x=1787702259;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uUMY9WHuTdgvyHkA28I65k11CWVDaB0ciMNOALHZxlk=;
 b=Z5kGs7K3mXW+SP0GagBqAQXdIV+v1pv1zBgiKCXMXRLwys5jh4ofoOj7ziuRmc1gGl
 0ddfcxKM+qrmwFesC2D9WBJAHk8syyneGewvepssz9/dJHP8+FayvLAMw4zY7X20xL2L
 I89NX9d4Oqgq3NVJRAru7Ivsl19guMbAzgGKL1piNw42+zfw9dEAU1xn3XbSQgxi21i2
 gLYnGRfwZ9b+guX/fMwtYLzbHLbYvMnYQ9kCJV0K7NVn7q3HwjLiTNSeu7CxCdFJmlmF
 9M5BUJvKqaz9bpF96KeDQmRVTe+wDj8YB7/tmIwWbnqGozOM4kFZpTOyDbq/wfRk2xSq
 htNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097459; x=1787702259;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uUMY9WHuTdgvyHkA28I65k11CWVDaB0ciMNOALHZxlk=;
 b=H9lAKNfdV/f28SWfpZgmDeBLlxugMHM2h8vxQkEg1lPCRMMi6aAKi73twB1kPrNJ84
 pcaQim16PY7eVCgm+56XJvN87SSho0iuUG9GHDdBWMNvN2xmmtssOnn24qD8iEB2B6OQ
 RiOjBuwsqfbMy55PH2OcmHlUE5VT0R4m7ZP/40yN8i2TT6S6xMqYIfcl5J8ejF3JbzuR
 eIkRlTC/qvzff8rjuNJiOggAH2O5vPfHvuL3wWolFRA9WKHLkpN6jetyW7RGTM+Nm25Q
 QyXlEeAX0vig/2dk9aRxe/kcgaajm2XhN6d0J3ju/Rb4sBooFfPZNRTQGFEsn0bo4+jd
 jUAA==
X-Gm-Message-State: AOJu0Yya1NbuWoKeGtFSRfNvzIHRMdnT9GB/mkos7iP8tLcKf9XXeQtv
 qIcGcaIiFMnX1xrWH+iYwNPPYYAMolx1aJ1Ar9yWZ/AkES9tfX3AYO3y4f8MOKDr6HpbNCSQ1MM
 jX5oSXNU=
X-Gm-Gg: AR+sD106XC+0WwKG7yxE6bfkk8a2CjdbYc7quqjqasB3Ub9ix6g+Bw+fiyvjULx+SXR
 xuMzqBWSIcLNpWUqOHJvMGiu1YhxvHDBDwlZ5x3bn+f9FbALy8IyOjPjmmdSxvSsyiO/cI3hYj3
 tsSN/UNuxzUnDyP1uTR/9Jej2P3aNHgf9nLwxXkOWOuq/BLV28g2fGwSB3oqh4eQpU0ljt6lb4o
 OJ9zbk2qbcbqlNJp2ntnrSbZzA9GGiNxC0MfwPLjkoa+3qQWqOYlb15bxTpsbO4EYT/cfTIWF3Y
 a1jUcJ3czZ2VT/vVFp3Ub5Wdxevfr+WaB2fDR9hn/YlD6PDg9QnNU7A121mwmw8c3SkcOk89Tu6
 kk2Y1gwNduUUq3IwXqQMKcjW3HF8YM+ZU8QJINLxcGu19coZ2yxkk6SrUAqi+Y4+N9a9Vam/coR
 67rtoXi8h5VK/FLY00TrPoHamopz61kn0PSAGkiKD4+V6j/8JW2bi692OUuw==
X-Received: by 2002:a05:6808:198d:b0:4b2:8e2a:295 with SMTP id
 5614622812f47-4b2bc46de25mr460973b6e.0.1787097459393; 
 Tue, 18 Aug 2026 16:57:39 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:37 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:00 -0600
Subject: [PATCH v4 07/40] bsd-user: Remove mmap defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-7-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=KjLnsMmQjxyrIgZ9EdNkxfh5tG3P37D0w8anGK6QIfQ=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPEp0ylwa4efJbOLDt/NUp/rsppaKCgsufC0V
 b0idTrM1taJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxKRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQDx8BAAhW/Efp+OSRi2WV0CM32Wbnq0MDzHmhg
 ZJ/rKIs9PZQ6U5DFxRP9Glk17bGqmUB9TujLicJRfZXRueolAgv2cBmM4O/II3+IjVNtpAokZBr
 bhGX18cz57AsUT3Ser5GU09HAEO6EuCRnGTc5tPWi6pZ7vSr+90+ZNMImgo2Q4DXyr6/FyXUm9r
 VJisBNXzrkF6CeZHHglqXbZD4QRsquaPXtIxtGcweq0urOIdFP8XMxOb5z3ppdChNwNRf69nzxX
 LirBtNd2l0WfIJ93IcZ7vTYrSChGku71tyOwF99p2NQNHvgLUOzj+DqXsB6xs7iR140c4JLKFrA
 5L5fhbci14ky/Hj0xDS+feOVsv0UDlYsrfFMupgvot3RIFA8Biqw5IKRZstEQgWHBq9XXMU9KTx
 KJSQTah0+bfemAsaUIsCnSJ4vOBvmc6nvwqV5nWwnq23f0uFKgDsnFRyYZlc8PN6L3oGnxu2r39
 GLTKWtR43VRrp8Wji3mZ0/yAUhBVJxSR6ZXl+FlvMOrOmW739w/s0AB3DUKe3j8BcCPZltK7Z/K
 SZ+ShnQ2BoMEaCb4WvclRfxUSzVLJzcchRI1VyRhBP3/oZUufIZOEe4/+NI0SdUkC1QnXPjaHK0
 fFMmkjAudeSkcACLi8tb/bkFzmUMbi+90Ol4SRpNK/eTrViBx0A4=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22d.google.com
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

These defines are not used, remove them. They aren't in blitz anymore.
A future commit will cleanup several mmap issues, not least the obvious
mismatch in the flags here.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 7e70d6ad57..7646a52744 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -121,20 +121,6 @@ struct target_msgbuf {
 /*
  *  sys/mman.h
  */
-#define TARGET_MADV_DONTNEED            4       /* dont need these pages */
-
-#define TARGET_FREEBSD_MAP_RESERVED0080 0x0080  /* previously misimplemented */
-                                                /* MAP_INHERIT */
-#define TARGET_FREEBSD_MAP_RESERVED0100 0x0100  /* previously unimplemented */
-                                                /* MAP_NOEXTEND */
-#define TARGET_FREEBSD_MAP_STACK        0x0400  /* region grows down, like a */
-                                                /* stack */
-#define TARGET_FREEBSD_MAP_NOSYNC       0x0800  /* page to but do not sync */
-                                                /* underlying file */
-
-#define TARGET_FREEBSD_MAP_FLAGMASK     0x1ff7
-
-/* XXX */
 #define TARGET_BSD_MAP_FLAGMASK         0x3ff7
 
 /*

-- 
2.55.0


