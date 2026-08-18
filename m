Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF34C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThf-0005HH-1R; Tue, 18 Aug 2026 19:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThc-0004v6-Ht
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:44 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTha-0005KM-Qo
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:44 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-45171f2f608so360960fac.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097521; x=1787702321;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jczbfvic4hw974INPn7FyuHXatH9RwonYfq0gUWlZ5c=;
 b=TCVx9Z+4jJbvHEiu55/q0Qtd7CotWLyi33mnxVqFE4zBkUxsYcTw9LD/x1sNXNsk7o
 g2gKvYdQZgrtVZWn1ftQREhk7Oha5din9RPmuRB70FMOn1k7us8IxYADD8lkq8NKFaTk
 N/iSx4kS2ZpTCZID/xeLK34gWO2zEgKxhtsmNMphOvUpDkObNYZ0XrIliDm9lXsIwsrN
 0LoBvxHsnSeUqHG3TNY1zPV95Wkn8bSI11TMu4O5YZ41x4Q7DYlYmPrxc8qDuLuW1g25
 H5rJ1c0/t2wqYejwn+Yrq5Fwcys8JKAYb7Od8Cf+z8xPN94VV9+EgWNoOse+KF+3r9HM
 z4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097521; x=1787702321;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jczbfvic4hw974INPn7FyuHXatH9RwonYfq0gUWlZ5c=;
 b=EXxq/QD6le1XdWThOwXIStGBlcQv0yni+vsIgM9B5KVx222hmBgfwpGLohUa1qp8v2
 JwgaclYvC0c0uFF1qQ/dvIzcRzXr7E2djM5yyj7OUG99Tj21LE5gVyY1bNfcxq0xwFAC
 euKYxD1Z0P6UGIe+OaBtYcK+v8gtxmyvFrvgWWi9PZ13DQw7OAJ5mYb3pmh6AG/snlG/
 zjOcHVu6dL1eOeClCB5qlcqfVftcnwGugfiqFerwuu2gSu+HiioQctAjaIXo3JG1jJIC
 WkxUaSsOt6lUl/6l9Cwi9kKaYlgcxsH94dO79LTW/QKE0TvMzJGkFZIHL5HqjIN8zMtI
 vVQA==
X-Gm-Message-State: AOJu0YzbD8hOQHD16YGzlBrKKRYZrLQdjrF+T9vrbY6m6XYZd3zHdHLp
 hWE96NwwATrM1v6kmhHXBbTJsBxs3C2VKIWMb+46r6AR2c23gU/g0Dc2TOllt1FiM9I=
X-Gm-Gg: AR+sD109hYVtyHXVp8dAe65qME87349wJy0jeKJGO6jaswqSgs/fFACt6w1mDBYCc2Z
 OKT1C2Un5CrESYL9rS0AgUm5Amz56BetXCoS/ou0zoH1T4O8keG6A2UOTTrp2nCq9X6HWDA9uVX
 u7c0DGAkYqn9/tiT6+7czn+IIDoefLbT/jerzn0VMi3ZGQd5L1bnTHD0D6anQMMP8PwzUujMfCu
 ZSvC0t8Re+1g9B2INg3nuLQyCgiObrPxlPCei5YoGT5KLoXawC9YWGN1Jun3/9Zn393cAvIc7e6
 +3dwM4Mhfv7qWwMb/ReZy95NeNAVSY/HVrrhvIsf9Ju3LDVtSVaoamDXV0FIu9yubGmyXMNVYVX
 KukBxz19cP1mVhicUyDu92T0JQqIXoOHCDzTOHXfI7Qx48h4yWgCQNet1RuJi1+UAFYHsA/P8DC
 4tk9J+yDniw2VQnyMXWB2Rslc3F0WtMu4xBCdAv/7eCT+5FC8=
X-Received: by 2002:a05:6808:4fe5:b0:495:e997:528d with SMTP id
 5614622812f47-4b2bc88425fmr458301b6e.3.1787097521347; 
 Tue, 18 Aug 2026 16:58:41 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:40 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:29 -0600
Subject: [PATCH v4 36/40] bsd-user: Add extended attribute and ACL system
 call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-36-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5060; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=YzVmLaj2ivnvHTtm9AJ2z0J8N0IZJU1MbhxD5FYtKh4=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFYICqJNCHhPN+3CpnoMmmcCubRdv6Slr9uR
 RuA1bkh2b6JAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxWBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBZpQ/9HLl6Tr/5fmjF1ttbJ/5QtrgmKERhlT0
 7axEcEfeVS9HPDf7yx7pdvA4kfEeZ7LtY4CdMc6hMLLYYtWGToE9F43noKANy9c134EJBNmay+V
 Q/AMhPAZ2LYbuiXZIYsLMv4QINC+N1m6BoH8XKVoH7ckJeccbJt50jjtTPwjqdlaVKm84OzGtl3
 LlTEBu55nP4utjvwYX1fZrtcbkMe38Ctw5fb58I4k3gb6b/T0gg38S0FNqeHzZpK0nl+RMcAg61
 rtTXDeCLhnsAS3kyx5r6Oz/AQIum2BwhBkiOuyM3F5Z/4R0mH38kekrcFo8jeKfjdIVNplwxFGf
 66eDJWeFIsPCm14BsrZTkLl0585B1La3HRYlTO/YxQ/5GpN/Kt9U4igP1cTeFEaTEteV9ATeIS8
 Q2y8MF7PCzVylfmF9zD6s1KjkQ1Jm/qS46MUSh3QfQTjbnWoG7LOMZoGtwCJbxvmUmwpYRr4XO6
 xzddyEeNWIHG3g6DqXZX9XrBRoYEbvHYLgAdZCBpOhyjFu3hlUicyXRofZ6l13lnuoVrD04Az6e
 OEVQugWDnonFPbgiS7JAEzDNV/3GZH5mReoAfXdG0roFvKlrkhYNzJaT9R+3lbi9Xms0RBTKZt1
 5gmbquwSSbYU9U+qPQOg/S6XywOrqYI11M6HMTDNWnWf45mrhHL4=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::29;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x29.google.com
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

Wire up extended attribute and ACL system calls: extattrctl,
extattr_set/get/delete for file, fd, and link variants,
extattr_list for fd, file, and link, and all __acl_* operations
(aclcheck, delete, get, set for fd, file, and link).

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 103 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f385034a53..a14efd3fd4 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1365,6 +1365,109 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_sysarch(env, arg1, arg2);
         break;
 
+        /*
+         * extended attributes and ACL system calls
+         */
+    case TARGET_FREEBSD_NR_extattrctl: /* extattrctl() */
+        ret = do_freebsd_extattrctl(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_set_file: /* extattr_set_file(2) */
+        ret = do_freebsd_extattr_set_file(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_get_file: /* extattr_get_file(2) */
+        ret = do_freebsd_extattr_get_file(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_delete_file: /* extattr_delete_file(2) */
+        ret = do_freebsd_extattr_delete_file(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_set_fd: /* extattr_set_fd(2) */
+        ret = do_freebsd_extattr_set_fd(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_get_fd: /* extattr_get_fd(2) */
+        ret = do_freebsd_extattr_get_fd(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_delete_fd: /* extattr_delete_fd(2) */
+        ret = do_freebsd_extattr_delete_fd(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_get_link: /* extattr_get_link(2) */
+        ret = do_freebsd_extattr_get_link(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_set_link: /* extattr_set_link(2) */
+        ret = do_freebsd_extattr_set_link(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_delete_link: /* extattr_delete_link(2) */
+        ret = do_freebsd_extattr_delete_link(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_list_fd: /* extattr_list_fd(2) */
+        ret = do_freebsd_extattr_list_fd(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_list_file: /* extattr_list_file(2) */
+        ret = do_freebsd_extattr_list_file(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_list_link: /* extattr_list_link(2) */
+        ret = do_freebsd_extattr_list_link(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_aclcheck_fd: /* __acl_aclcheck_fd() */
+        ret = do_freebsd__acl_aclcheck_fd(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_aclcheck_file: /* __acl_aclcheck_file() */
+        ret = do_freebsd__acl_aclcheck_file(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_aclcheck_link: /* __acl_aclcheck_link() */
+        ret = do_freebsd__acl_aclcheck_link(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_delete_fd: /* __acl_delete_fd() */
+        ret = do_freebsd__acl_delete_fd(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_delete_file: /* __acl_delete_file() */
+        ret = do_freebsd__acl_delete_file(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_delete_link: /* __acl_delete_link() */
+        ret = do_freebsd__acl_delete_link(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_get_fd: /* __acl_get_fd() */
+        ret = do_freebsd__acl_get_fd(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_get_file: /* __acl_get_file() */
+        ret = do_freebsd__acl_get_file(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_get_link: /* __acl_get_link() */
+        ret = do_freebsd__acl_get_link(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_set_fd: /* __acl_set_fd() */
+        ret = do_freebsd__acl_set_fd(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_set_file: /* __acl_set_file() */
+        ret = do_freebsd__acl_set_file(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_set_link: /* __acl_set_link() */
+        ret = do_freebsd__acl_set_link(arg1, arg2, arg3);
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         ret = -TARGET_ENOSYS;

-- 
2.55.0


