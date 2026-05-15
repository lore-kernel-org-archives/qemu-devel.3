Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40822CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzy4-0003cl-Vw; Fri, 15 May 2026 17:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxs-00034r-TY
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:01 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxr-0003BM-2b
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:00 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-48270f099d5so376622b6e.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880058; x=1779484858;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=juQfj3VTOQN20k/nloCMS30VhzLzx4/oq0LQ6H/kJJs=;
 b=Uesg+miGXWDm+kY7Hy+1iLzQaXRVXIxsnEg7DVv2oE4SdALG/SkNDy6BrcvVQodby4
 ZKv1CaMqLGXPiQ2/59jQ1xkXIJDof09x75j6cWKt9DV1sBz4nLCJr+WGn4mP9W3acCok
 WBVEVzqN11PWH9VVB5n2SE+44somhj8JzWakYCOhZAjtdrB1huRSlhmSRhyD/4ASWlBI
 ClcyweQJuuBtskVBPI48tAF78CtaHqN9Ce3HPML2MqGKG7YzMsP6ccudhUsSJ9Opd7Vo
 KMkzRivvOAlgw+ix6kp60EBnZhRKYrgnBdacomAciQpyZ+DGgtvdPgvA17fXyXqvsMnJ
 0lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880058; x=1779484858;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=juQfj3VTOQN20k/nloCMS30VhzLzx4/oq0LQ6H/kJJs=;
 b=RAOdMMkFiewnyAgtre0Ei64qdD5vD7E8I/KhFtP7CzwIftYo1ORXjPVmv4zsRusX1N
 3Lncz1nQSkaipiO8pYgZakdSFuo+uoP6N0GZU3q7xNYSavByphiQS3PTm5tjLcj0GNnV
 wQl53zAcfLgg+Aow/HvpeG+ez1h8TiSZ3fI5C+x9/T2S8ref9yjsHjhaUzQb+1I8z8Jw
 LE2AsWqCFypA1kjSZOXPZR983OVWas65MiJzUvejc5sizOIM6gF4OIDSJ7tB3rrVD0wU
 TjyDZ9xOkLTYqubEbh3eVu3Q5iY2lxjyzfbtxX2MGtm4g5zLxOo3FPlji7NxA9+Bt4I3
 C/3w==
X-Gm-Message-State: AOJu0YzkfCPj2DYB553/Qu29TQxM7jo24R0NlTX1kQfjMgQPZylKAvEM
 SsIaxWnIaUNkscxiS8KEOrP8vLpJxx6F5mZqDmRAFXJtNRQaF94iD+JMZXU7FGNu607M96ECO5O
 gde8N9D0=
X-Gm-Gg: Acq92OFAy8Hg8VUuJngX4MI/JZ0rD0k4/bLuRvvl041sQqz9e/uEx/WWpE4KkXsgoRz
 hAbGCD3QDYmCzHHz9Y+Eury+bB8O0LGyLl/F5MVdXS94WrbO+JtHTBSBqiYs41uBDyxKSZf/n9S
 /p+Kg0iwln/Zwo6pmDXf1Ia+2BhnNHxEy5yp2ljhfLAg8giqgH1Umj6ftOODIE/9ENpqd9wm2r7
 N8rG8aooQINQGfQBMWaHuXCB0XysE/W8dIDv0IY7aTc3m0If3vUGixbW3CImyjK3vL6i/ffWeK5
 laTFFmgoj8w0Mjq790DPclmyVSfDO/pGnbZNK/qPvjwrBDT2vehlnfVPEWEpAkEikUcQQ0uAg9Y
 z+z0UfKjW+/c5TJWYtvAV3X9qn6AKj51hHlkU/W4TnkFdYi6S/1x174DXkaj/VbqN2bAgH+q4g5
 TzPoI45nwV1w==
X-Received: by 2002:a05:6808:1705:b0:47b:c2a2:1c79 with SMTP id
 5614622812f47-482e55c66b0mr3426607b6e.1.1778880058013; 
 Fri, 15 May 2026 14:20:58 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:57 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:53 -0600
Subject: [PATCH 54/66] bsd-user: Validate acl_maxcnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-54-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=ya5y+Jk/LAQ+I8jHspERUJwk2JeKRe9Gy4dMj6ZOljU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43nN/pYKvTfwuFp7WVYgj3SBh3FQ7CoSSyQo
 v5C2ogrSv2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5wAKCRBsHNEofbAR
 AIB+D/96HG4/R7jBKpcmm+FfcE6c9ryvVpfrd8DePqMEBfgx/zIcqy0dpGEJMYyRxFZsgs9racz
 ZZRbhqnOSMhk+XV+jTQh02yIQNJS9Rbkl0mXlEyk2hhBmUMlPh1ckV6J15pr4ZoeJrZEmKt6uhQ
 K/MXjjs/PpQ3ef8hRtVS2Q5pyxq2LDKcq1TH25S2qSmFuc/OeJQxrGLju5Kl3ZoRGCER4GF1Tzc
 efWOSSzmxzVkDqpS1VpQK7MAtX7qPXCUVgJ2g1EoCt9FKd7okXeXR8j+DlUQCuM18ItKOR1OsRy
 uwL1DWGJd7kN7q6Ok0iLvKtcagBR1zlZUX2/Ae7EPwCddCFRdSMueKyh6Ef+ulyyyS2FFLfTbVP
 ql4HSAxx8XIzZBuQz2AJzGYtfOyJvDJpjMe3KoOGITO8eDA+cqRWQN06WjGebJz6CyMcef7s9dQ
 2ZgS99X51H8LduUgTlwrg5Q7Nqnuy1XZp2qhZj0mIfseBH+Z2gJOxsytgUMmgb/7D+zJj571fUB
 A1qGx8fFj5N8q31w6TGJ+ZzaVbVwMcJx8XORGKh5WRK6S5WxYi933b22P6drqTPbpearNZ2+Luy
 onQZGjV55MhM/b+IVBKGBi0kODCTU7JkDzCuAHGdOCZjCiP4GwyGr/EoDv+sWXytMEuUE4tRMYc
 2e3n4DkjRJ2ohhQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::229;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x229.google.com
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

Make sure that acl_maxcnt is <= ACL_MAX_ENTRIES.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-extattr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bsd-user/freebsd/os-extattr.c b/bsd-user/freebsd/os-extattr.c
index a30d513655..0f0c7123dd 100644
--- a/bsd-user/freebsd/os-extattr.c
+++ b/bsd-user/freebsd/os-extattr.c
@@ -29,6 +29,11 @@ abi_long t2h_freebsd_acl(struct acl *host_acl, abi_ulong target_addr)
     __get_user(host_acl->acl_maxcnt, &target_acl->acl_maxcnt);
     __get_user(host_acl->acl_cnt, &target_acl->acl_cnt);
 
+    if (host_acl->acl_maxcnt > ACL_MAX_ENTRIES) {
+        unlock_user_struct(target_acl, target_addr, 0);
+        return -TARGET_EINVAL;
+    }
+
     for (i = 0; i < host_acl->acl_maxcnt; i++) {
         __get_user(host_acl->acl_entry[i].ae_tag,
             &target_acl->acl_entry[i].ae_tag);
@@ -51,6 +56,10 @@ abi_long h2t_freebsd_acl(abi_ulong target_addr, struct acl *host_acl)
     uint32_t i;
     struct target_freebsd_acl *target_acl;
 
+    if (host_acl->acl_maxcnt > ACL_MAX_ENTRIES) {
+        return -TARGET_EINVAL;
+    }
+
     if (!lock_user_struct(VERIFY_WRITE, target_acl, target_addr, 0)) {
         return -TARGET_EFAULT;
     }

-- 
2.52.0


