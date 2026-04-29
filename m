Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F59FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI66t-00018F-2N; Wed, 29 Apr 2026 10:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI66o-00016e-GZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:41:50 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI66k-00039U-El
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:41:48 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so4880051a34.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777473705; x=1778078505;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hqQRX7NHmcnoVCdQPhuAPV3niYT3oKUD0fxHi+zdto0=;
 b=vk1NJyzYfPNU+Y4m2bk7Nr4KVYzWFW7PLedUsyQhabYUCquEwKv9ro+XmiTBBkLpv0
 D8yBRjJhIKo8gvmsEtd5wpqte7vX6Xruf8rPba94tvFE+QiW/DCZarNudtCle7OYSUMD
 AC1G1XubCla4JpUD7rStNA0f/vZ4RN1pZZH6l+qZibDmWvR7glx5VUFBqXAY7JEAdO/m
 L0BuXDJ7HD0frR/Xi78zlYAHIrLVdTQf6Vaxjh7ntkFYnM0wIAgqXBEJJGj26cKzVfmb
 jq6E8kLvYJ0/Ne47eiNXc3Z4zQHhHgF7l35WU/jX6g4jdJ42k2sWuZfRW34eSF545jLn
 SMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473705; x=1778078505;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hqQRX7NHmcnoVCdQPhuAPV3niYT3oKUD0fxHi+zdto0=;
 b=Wio+YawoFtXqi70RCirAnspVxRIT4y+azMkxwLbvl8WciEZiteCTRG6lREMwmp4Q2w
 8wbTcwjyAMP02lOo0rt+CCYl9VYwUVjTVYWiBl22z5Pao+nZtSTv9gl6bJbTNasFBF6t
 6oLMNVlJNFzQJ2Dt26KPci2DcM1vIqQ+PdzTJObwXa6LaM8gVOtZnU+FTyTg9AFJKwNG
 9mZrzLHD5qjN9GpqSKkYaqiAyaGfa9/9rDuy92mS9jkNfOinfRPZxU56Xt/zTwNQoibB
 ZJKV4uOffFqdKKftSmOijtWUFkAztlJw9IgGwL7kUr6aLn5912CJe8x6Ulr32UBs6zke
 ffhg==
X-Gm-Message-State: AOJu0YzQeeNbTLTz19bYv09pKHrk5fPAbZfGjrHGUv52qZcWRjmwzX0H
 6q4pjsUdc4hgS7D2axwkIEfu2TCeFqaK1VrixkilVdIPFc399RE+UpTmhhZZPnRF4B0=
X-Gm-Gg: AeBDiesUqNmTQdO1ESdUupR/WtNG+lVyLOCUb/KEqFCE8+eraLYcxz6zCTZ7x7Zs3Z7
 +G9V2mM9LF9EMETkshi8g6lEXt1PdhGUv7uhaQwu7vZPfO3+/l9qBYBgiLIuA0Vmo4Zl0xTaGfe
 za8e4s1qkispok+tQrLvapPdLZdvLoAC2G+SMwJ9FzulxJzZGYcRvQwuXmzKZJcBCjQkNqIXoKg
 sGUGz/40CKKANRwut+fwDrN/sQwtoDIplwPFtLh2l/zIieFyu8VxElK1I4ik/NukLlRdwkThLEY
 isDZAr8IH7JdU4zSpfeTyMD/sCVe6tTPDa87aCkIUVVdAWqNBXAKNCqf5vWZgwXP1YaJr3+RFOH
 eXcWZaMokBEYJKoqlamnJ+692TFZLcAX/EWwuPW+RHvktcD9iHN98AqWxGuyeoWha1vpZoJLWiM
 ekmGFXY3EeVRpgwFyiB7yGXhYqMGI21JE=
X-Received: by 2002:a05:6830:2403:b0:7dc:cefa:1c20 with SMTP id
 46e09a7af769-7dea6227849mr2598206a34.0.1777473705012; 
 Wed, 29 Apr 2026 07:41:45 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deab9d6067sm1553377a34.22.2026.04.29.07.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:41:44 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:38:52 -0600
Subject: [PATCH v2 2/5] bsd-user: Delete sbrk and sstk system calls.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-syscall-nr-v2-2-67a8d09dc13e@bsdimp.com>
References: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
In-Reply-To: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3036; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=VY6OYhFAhZDkOU4DGGiY5jBP+cq1LdQq+JnMt+rf9iE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hhK078qSmBVhNNjI8kLdDmL0AzwHTsFcHvx5
 UUx32osqOSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIYSgAKCRBsHNEofbAR
 AENvD/0eg9twLvHqXO1sxegQYERi5eoo28ED4ZVT5JByGk+QAFZwyFdZa4xy2InuSlEkPJEt8RK
 U8ec09yLZPTKya4zUscU/JWLQakil8ZmG7Fv9U+m8/Ah1yUbGcUKELd8ime1x0FHzCNbNvSvfUV
 E8XYR2yzAyF02xQvVNTj1GU084YsselVv/oQCBJebw0R1zGvUTJjbU2RQhi7bBF5BJxMzGQ5aMd
 JoCRWW1SmL/+EY/yETHVWipBdVA2WhSvvEG61GRPc5z2C951laMLOpBBqjioJJXSZKOf1xvxXGm
 g/ucIWhrBQwAMU/tDZfWKYt+wZ9P+L2YV4XO1p5nJgj5kKHrsw1byzL5KhlhmdbOyDuLz5QRlq/
 ccayuj3Ng8p4L+M5CIyTnE35fxsMpT4Ww0zIqjJLNoUXlcDZkYUna3kp1etQOedE/SprkLg1zEO
 OZrPFgsAV9Wo++R9iKzYPiHwoi3tgK479L6ff4z8/HFb1hZiRzjvnUym17di4bp6LcLhUPk6aAm
 IcUIuRgqx1a3uR9dEeasze3/AbCByp7XFZ8HtCg8mXjibgrpG4N85CDkNOlTibg22Tiy4GDrkHF
 vcmZRhMrp9+mjTgGt4EUsvL50OniVWusOSm8lhH11e/4unL5xAdf1tO0QL8CwtQ/meZtGuWrIzV
 VZFWLs7EZvzJpHw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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

sbrk and sstk were an experimental system call introduced in 4.2BSD, but
with an blank implementation. They remained in subsequent 4BSD releases
doing nothing (with 4.3-Reno and later returning not supported). FreeBSD
1.x imported this. They were removed in 2023. Remove them from here
because no real, non-contrived program on FreeBSD ever had them.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-mem.h            | 2 ++
 bsd-user/freebsd/os-syscall.c | 8 --------
 bsd-user/freebsd/strace.list  | 4 ++++
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index a118e57260..a20b703053 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -440,6 +440,7 @@ static inline abi_long do_bsd_vadvise(void)
     return -TARGET_EINVAL;
 }
 
+#ifdef TARGET_FREEBSD_NR_sbrk
 static inline abi_long do_bsd_sbrk(void)
 {
     /* see sys_sbrk() in vm_mmap.c */
@@ -451,5 +452,6 @@ static inline abi_long do_bsd_sstk(void)
     /* see sys_sstk() in vm_mmap.c */
     return -TARGET_EOPNOTSUPP;
 }
+#endif
 
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 85e5db19a3..ca819fc530 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -918,14 +918,6 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_vadvise();
         break;
 
-    case TARGET_FREEBSD_NR_sbrk:
-        ret = do_bsd_sbrk();
-        break;
-
-    case TARGET_FREEBSD_NR_sstk:
-        ret = do_bsd_sstk();
-        break;
-
         /*
          * Misc
          */
diff --git a/bsd-user/freebsd/strace.list b/bsd-user/freebsd/strace.list
index 275d2dbe27..d7f61f480e 100644
--- a/bsd-user/freebsd/strace.list
+++ b/bsd-user/freebsd/strace.list
@@ -194,7 +194,9 @@
 { TARGET_FREEBSD_NR_rfork, "rfork", NULL, NULL, NULL },
 { TARGET_FREEBSD_NR_rmdir, "rmdir", NULL, NULL, NULL },
 { TARGET_FREEBSD_NR_rtprio_thread, "rtprio_thread", "%s(%d, %d, %p)", NULL, NULL },
+#ifdef TARGET_FREEBSD_NR_sbrk
 { TARGET_FREEBSD_NR_sbrk, "sbrk", NULL, NULL, NULL },
+#endif
 { TARGET_FREEBSD_NR_sched_get_priority_max, "sched_get_priority_max", NULL, NULL, NULL },
 { TARGET_FREEBSD_NR_sched_get_priority_min, "sched_get_priority_min", NULL, NULL, NULL },
 { TARGET_FREEBSD_NR_sched_yield, "sched_yield", NULL, NULL, NULL },
@@ -234,7 +236,9 @@
 { TARGET_FREEBSD_NR_sigsuspend, "sigsuspend", NULL, NULL, NULL },
 { TARGET_FREEBSD_NR_socket, "socket", "%s(%d,%d,%d)", NULL, NULL },
 { TARGET_FREEBSD_NR_socketpair, "socketpair", NULL, NULL, NULL },
+#ifdef TARGET_FREEBSD_NR_sstk
 { TARGET_FREEBSD_NR_sstk, "sstk", NULL, NULL, NULL },
+#endif
 { TARGET_FREEBSD_NR_freebsd11_stat, "freebsd11_stat", "%s(\"%s\",%p)", NULL, NULL },
 { TARGET_FREEBSD_NR_freebsd11_statfs, "freebsd11_statfs", "%s(\"%s\",%p)", NULL, NULL },
 { TARGET_FREEBSD_NR_symlink, "symlink", "%s(\"%s\",\"%s\")", NULL, NULL },

-- 
2.52.0


