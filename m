Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72487F3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbZ-0001O5-0j; Tue, 24 Feb 2026 09:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutb2-0000TG-P5
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:10 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutaw-0001JO-K4
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:05 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4ba9abbecso5702527a34.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944061; x=1772548861;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iu6XADh6tBVGnb9s7zpQE7ccWgUjuPoiVdjFMev6W3c=;
 b=X84I6O4UrAmJ2LUj6+sRkGWkbo+PAYHMf87lhQZei5QmbvOKsPD1Qh1jRixPzQMZ2K
 q658dH2TTLsWabfufWwD4FFjMJ4RHDUSkfu+w0VuuCPP7peXWNINObc/TeBEoZ5eROiS
 F9XUSiX1+kId5qyCoyIjgBTAXk0QFXACmf43pTbyYnmkc23HiKe12kpJAtuNzAw+4V7Q
 kzA5YN2LbfT2twMSzE97S97MA/cpJGxVg+hJUdgit2kO7RABh3bEWvkguRJ0D+ASH6Jk
 g9j8z9CbfOznzGG1nfPwiZ3DTSRq95cAV6VmK4xCdMPc3TI1v31WlJFgLQJjOt7YVP4W
 zOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944061; x=1772548861;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iu6XADh6tBVGnb9s7zpQE7ccWgUjuPoiVdjFMev6W3c=;
 b=OJHZydV3NNQg6Sf7xkKMEyvaBcdVjtrBG/a3q0QfhI1ebtm6d+T3BhbXIYdkyx3zEf
 /ZfRS1cy8Zx8xTurHvfID2jgClFcPsdD4Z7RoOTsQmvY4Ent4OoNYLq2ljV2R6ZBDxSZ
 f5EM8PiCQ6zG15ZbvKiHanX2WbwKcBsm05z/IplhjUvfD4OaDWvLEuioBDjGxIXbleQb
 EYkjlMBarL33nMhQPBdf/GFK3zlexA6GomFkYETkFjfXiILOigzH5w2imvncs63ElOm4
 QDtWjcsozUFU7lcYvK8JM6uZrhI/OgdByFcwiiGej9oK1h76F2SPuW0+rqc/XES/xrAN
 fowQ==
X-Gm-Message-State: AOJu0YyBfJholuexHSpyRpJeFJvnyIrmfLq3LmAgLfohVDfB7EWd89Z2
 ebSvCVPeByzHrmOkHjeq/OvVFKlGFOgO+cfB5cruMvqcfU0KgOy0NQVv7b+O9gWCMWO4t5FYEqM
 THoJ/ovg=
X-Gm-Gg: AZuq6aKT+LwjX/hbCxY46xVszp6hlI2G2ZlhObEHmjAMEv1UKMjN4LJao3lGav3YTBq
 s9WH2/JL/Uh6qexFUKA/YThWI/bKosGfAs+KJpTLbhy6187YvjCURfF8/WMBj+eEeGGfR2OP0FX
 UcSo7WyT6ixiPA5d49tIQxT9GZJmIqXxR7ggi1kxdkZ1NCwBJeRjGJI/PKHk0FqOwuYCVkfAQXp
 H7ncjYYTRYCMdeyfm5wrEt91t68oXpOaTvmTx0MxCm45h/4rPvPqoo26Cul3a8fmdpEQOSv3MZg
 5lPpSa+XYWoziTEnuXYI6nBK2p9HIl/w73mWLBTxbF/DcgKXpxkpfTLHlUwlngRM/ZV37anrsBI
 HAooA+4Ds8YzebuFEfE5SYXLbOvr9rIWHYVCdBHshHFvHvFNkpo0l4JMbUQ0D7Qt5APmICb0nn6
 kKa0z5Im0wqQ==
X-Received: by 2002:a05:6830:378d:b0:7d1:586a:32a2 with SMTP id
 46e09a7af769-7d52bc72790mr6838683a34.0.1771944060794; 
 Tue, 24 Feb 2026 06:41:00 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:41:00 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:40 -0700
Subject: [PATCH v4 16/24] bsd-user: Add do_bsd_semget implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-16-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
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
 h=from:subject:message-id; bh=SV0eNLU7fS1XVSTHoXjgS6GD2dK60TDF+cTpamGVRRE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhoz+s5CF8ztZ78+6D0st+DJfzXrGtddWC89
 9K7EB12LeCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24aAAKCRBsHNEofbAR
 AFyZD/0Y1+oi4fEkns/SiceyI2U9RxTdQozwaLux+8e+KqJHM6zPW8l2CFwhjQY+r0QXehhqStE
 XELvavHiwYPz4ZYP3L6WZB4TxZDPmdbLj0x0D0rA3zrBfYQQCusn7oCyjY50+YGM/uA1c6+4U4H
 bdHyxqw3hKqv35IHfRu+IC92rW2Hl/bBGyir2+KyXDAHN3GBOAyuc3a/4ItJf8jhezz9JGZh+w7
 HZtbVpAdVd7J4Y1ZNjaldN4TxocV4WtLaTVZCJaeD4ARBQjmDGqDMDMST8TVoUEu+qV8Iwnc6WP
 +7iDqFZNvlgLT8VKZ9niHGaCJmhofUqBL7JoJQFq7sYUeZwkx3vZt2HJXlqKhwDz9XnRAMQo/of
 e+Neniyiaqnacsr+xU44tdXtRVQmxMKrAooJyKoRubVIfrT8c0Mzk9QNEbW9qXbiNkhpH6qpwt8
 3qwK9s3Tn+riKxeNRADZPtnR7QcN2i0usJx7D9TQASLQaWD9K+WTGSWmhUiQgTiI4qgHrRal55o
 xBSXLEuGcoJX1mqsK6xeaiVMTbEHiOxuHhxS6LVSposFlFI5gbw0ig0BtrUtV/96uPu6T0To+rr
 fv2YxYRUZAyKYwKq59ZP9YPPNEfmSaTXhJqW5z1lqQSUVup4cMgwgFGqtOSR6NKKwRDPeNrKru3
 f01Zlxk2USAroNQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x336.google.com
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
index 9f1cc8a0cd..3dffb977a5 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -65,6 +65,18 @@ out:
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


