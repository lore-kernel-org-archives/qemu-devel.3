Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55369CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzyG-0004hR-LT; Fri, 15 May 2026 17:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxl-0002vj-W0
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:55 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxj-00039M-UR
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:53 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-479d593a0c3so236875b6e.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880050; x=1779484850;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2EsJKY6wRKyUAHQyJydxItZiWMuRqA47IYT8gmTrP+8=;
 b=Y372ZVEmV3/pledt6K2QlfmSEA+OqCvMINFHEyPTB+OWMyegvabxBU2CZkrlRkfO5l
 TrY2MBz5mKJd9PlNmeamFARwTWncib4WpWQ75wmwlnjzteHoEbVV3C7YcJfp7/zxfmR5
 hwZSVlW/uycKa6ncILmSSwYWdDWoj+S7W+GH3T3qk02lNJZe8pnRY/cKB4YHmg32hqF5
 gh/tkQq8QAc9WME7bXd2NLznzbwfgciRwvsm3JZl4v2i5HAv8xUT2xF7YAjKsUZMSMIV
 v7ABjjNcHE9gucUcw+HTMBymIumRvjGJqwsUgDxIqQGG29K5dnvk9pbMvnK9jfsd01Sc
 xJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880050; x=1779484850;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2EsJKY6wRKyUAHQyJydxItZiWMuRqA47IYT8gmTrP+8=;
 b=GM3+shzI5vo9VG44aXISVCu2w45xXikvstMXfBow5RPP+FaY5ftLnojDIY/G+/bxJv
 Dg43YdzfCK3jOCAfvsyuqttf8vGzDSj5ohypJR/5I+wmYS2OLSFiSwF5SykYM8CMZNuJ
 8+Id1qD9OW0a1LdedY35THpzMohlV5OdEwLYU2in5pIKKoj4ebGZVSMipLk0gYaWPToj
 uM9ac+DH9NvZ6wQ1JH/ev+mulnwIoy5OdcjQwd4a6hEaDXuB1NsrMeyDzY8osLrpxpxI
 HmcjdIBU4xN0OXulBY+H/BiZMj+mmsKsql3ogYv/ooRpYaM9llWRRHYLbYdpQeZth2rP
 Q4Mg==
X-Gm-Message-State: AOJu0YyitI1Q2j27KuOE9xbRdJ/fUqV4E8kCcZkiSppLdOi8UiDXMlaU
 C76jAHvfbKlekh3HNwYR6O+EMxHJNLALyrsMAU5Tt8MAkHQDlL8EoGe2apLrC2y9NY3wBMTBccC
 WHwZkY0U=
X-Gm-Gg: Acq92OGeUPALQLZBytTMSRI+N3BwxYkcCfYAcvdYxw4qih2jEOjgOJa/pdnq6T0zAsn
 wVI0kmexHmMRgIkIgFGuMiRyGiQbN/98RaXp5XzGjdzjme6BGMKYHrWi1CytNL8MTjVcfd0aNeb
 u46DHzWnsYkMPUjQDvIuWYBAshhLNAeLzEYZWcVoycJZ9VylIdTU9sNQqfEqr9zakPT+FMxoLkx
 /Yps+TxLs3F2RPsqxmjg24RMTvmakFToWlpjwS3gS4KX4AcBvzfSUeA32nGzoYxX8auRS4I+BEt
 HS/jPgBPKFBMt8FlXl3cLD+XTphZQIaF6P1Vwxa6AK2YAXyY9O/OV6gReQJcGREKQ/CY6CWB9Ya
 PL7IUjGHl7DrG3HKmM7X+ZOak0Nw68bmpJAFJYpNDVUSt2923maiH9hakWOBl95Eg1KrdSTTXdc
 wCOFTPE1b7FA==
X-Received: by 2002:a05:6808:181e:b0:450:b249:71bb with SMTP id
 5614622812f47-482cb927ed6mr4928338b6e.19.1778880050243; 
 Fri, 15 May 2026 14:20:50 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:49 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:45 -0600
Subject: [PATCH 46/66] bsd-user: freebsd_umtx_mutex_wake2 fix unlock_user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-46-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=+tJeoK0ng+exvyjMVCcN8K1cXKYqQMT9ULR0VIbAmwA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43mYYem8x2ZCvbA7/xqzzsyf0DnSxrK+lCIT
 jNXnbVzTdCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5gAKCRBsHNEofbAR
 AHb2D/9qO8P0CZDs//g+O0arEzB1EKhgwO56dSOh1drObpTx53aHM5HURCosF03k70fcX7ZQy/J
 craBzJ9m8mdg0yoNtDiqR35I2A7m7Pvh8cLpf3hwIMpz8Xp1vwcw9RsvHmrtYrDwpQFKeUt27E6
 iU1JKCh9CHkT/WH+GBeoxziZ8MsgznmZ5sR+YgNP1xNL8k8tLsVkijAXU3tBxWWX4xhF1nGyPzb
 9iIymDZ0+zmvImNSma/4zvMLKahNSjq4brl3DV3/HlO5IaE61U9lb7ty1rDfPdEyqYJ8pOuIuXT
 IQmw/twzMRnRDYUxyqGYGjZTAiX8BezCz/g8+XPeqKFMf9halztS2vJMniIDxHe0F+XFUR/IS/C
 kiOmIQZPC/sVb3f0ClUGxsl2FK1HG/LodRPQTcSbLzV0C91JN2NfAzVmnX9V/P7boXh/rrTOKXd
 C6rqcWFUPu5Af5F7Qc072GbHc+aLgXCV4d8JlGnnqUOrmVn4RgBBhVfQCYBO4orrZgJV9zxiQu4
 Hq9imJDndh1HoJOUrclF2FldCY8V17r3nfT9Kp5uudua6Y2vect9IB16krGraweKDSlPhql6LjY
 o7vHdmfDqsh6dmnhf2xtUjh7I9IZx7wePwvB56jBjFjfVKcHrguWzZ8inB0uuWnxQxvp11szptA
 e6u3qoZK8cGdJoA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22b;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22b.google.com
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

This should be an unlock_user_struct to match the
lock_user_struct. Didn't change the writeback to '1' since the
tcmpset_32 writes to target memory and we don't need to write again.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index b91e0d32b0..7c3256a87e 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -474,7 +474,7 @@ abi_long freebsd_umtx_mutex_wake2(abi_ulong target_addr, uint32_t flags)
     }
     pthread_mutex_unlock(&umtx_wait_lck);
     addr = g2h_untagged((uintptr_t)&target_umutex->m_owner);
-    unlock_user(target_umutex, target_addr, 0);
+    unlock_user_struct(target_umutex, target_addr, 0);
 
     return get_errno(safe__umtx_op(addr, UMTX_OP_WAKE_PRIVATE, 1, NULL,
         NULL));

-- 
2.52.0


