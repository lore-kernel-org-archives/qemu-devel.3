Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB07E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswVG-0002pr-Qe; Thu, 19 Feb 2026 00:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVD-0002nx-DO
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:03 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVB-00020F-4f
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:02 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d19bfe1190so570922a34.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478580; x=1772083380;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TRM3Oispr2CVqNb5Tfdu3Fuz7LopAWJ8TkqPl++2V8Y=;
 b=sl0w5/YiH+92LX5+srpUuIX14QE4+SAXt4bRXNQiF2OWs6iXhtyGgJXTUtwP9wRcQo
 k17L0+QABQf67vUtKoXJH4GHWcVoUbRtStv4H4W9PqXMJy+PBGhIM9f/IJ7TsQfT7X4D
 yYSgNcYRVRCzEw8jQGmYcT+DabnshoWvzlPo9/G7ZoQWp89zpRqqpi7XhO1mwQLL7nH9
 yNKLUAYcG6rJK6M+uSvTnCZMfox8cGNIEE4GPK1BmLIXMbuzzwhs8BUEqRpk7RwzPzlv
 waLniD40luqqjeG3bHT07tsnY8sIbfxgpdwZ1uidK6croQzxVjtc08C12l/sp10VJjOj
 XZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478580; x=1772083380;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TRM3Oispr2CVqNb5Tfdu3Fuz7LopAWJ8TkqPl++2V8Y=;
 b=k3CjnUJ/x4mkhc7JV7pK+GpiXRogrX0/XaGexrheBrkh+f65O8qHiTis0FgeOahWWi
 yjbdaQfFQGVFlK/10YhaZJcEx30ng1BFat6usNqNDT+LtqDERR/XFP7AUFoU9z1oSdSS
 1JE0RNFo1vHUdJqMam1DaI/l5HnrNw03fI6UtEAeUtHsMb6fmcBPcllFLUNOE+x+D8Fj
 8ZSYc7DhR+td+xZ6ek0v0emPlrK38VI5dRB6AEYcT1cMA26LxjiJs/deAecWCZ7ZBFE8
 MOq7k0wRIjGimKJidq/YWxKIID3UF0nD9R5Vt1gEy/JTXN38+ltDwuz04gqkwLruuCIB
 +8Xw==
X-Gm-Message-State: AOJu0YzCBToSJMGXK2CCTkyvBDfx7DXaIACLVPa4483QCRFiCGPlcZnE
 qC1g1q8jb09V4frZ3GrrpZO4RK36cz3huD1xcFnr3vX+DQXq8no28S+w90hXVbC4ghI=
X-Gm-Gg: AZuq6aJRFS6gFFFb78dNZTphMFU0YyqpB1Uerrpgd6rQP6+/JgMJFdwUc2PuXsURAw6
 oHBl+GEXK9LX3KVUPR4MlPw+7TTogrrAnUjyvEntDTeaWol4aQowBjd0HtKKjGD8IqAlyu9Kpdg
 /STSMzHinqvGVks7JEaWmL7CMOkKhbxzvmdTp33APBjhotCxfq1lmW/ciTRA87UW8T6PJm3aRLq
 Gy2sHI+RdeFgShzSFKsWym27Mtwp/aPQymJrGPcKZjL2Uv0qJOwf0eA4Li1FVlvRJAeUjxvvXNH
 dy4WCDjZuiaSYPKkdMpSNTC5k5s2iYzNcb4NVaZWJEqUBUCopaV0ZJH0E4g04A62ernd19LVER0
 6L1D9pvF7+OJGHYTDUC4NGfHl8f0K41EU2oL2V86am0Hhoex3+abwHM6jMFpRnltBWTkWXCCEL2
 PCQwhFyGpL0Q==
X-Received: by 2002:a05:6820:6ae3:b0:679:92c7:2c07 with SMTP id
 006d021491bc7-679a71dcbf8mr2533911eaf.29.1771478580039; 
 Wed, 18 Feb 2026 21:23:00 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:59 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:40 -0700
Subject: [PATCH v3 17/24] bsd-user: Add do_bsd_semop implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-17-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=mBs5Y0mZEl6PwncKqPNyZPiCKdK9StT+eagUv/bboAk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4sEcouz6NcTRXDUcuJFFdQ3iydZPbk4co6I
 mBgasmPcaOJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLAAKCRBsHNEofbAR
 AB5tEAC1fEvULmkKd4WgsCrWZie4rzZ8jf3nQIiwvrtXa66Gr+iV/g1XwTWEJskinfyRktNJlCJ
 +tu41p19iBRTmokxzswlQVFwowgjD8eoMiNby3wVuYeB6JDqX8FNUT4t9e2xVHeKmMuVtpa6ofj
 UIyHOifL63khjyFjW+tDOP/dyLDh6cdmK2CmgtcLL3wMz/YVaAJsHzOc1aAf1JU9GIceAuTNrjm
 T7CJXUnchvwaQJAvB+d/SVx8Jn385Ycr4mTsvCj/9rhItp6fU9fco5RNyigqK3o8BEekLYRDunm
 WPMdt4GYxuIdGZoLWsBFmaSA3F5npyJNvc2tH3aH2kxXHSOE5JbvobdLGhBR8hkP5h5JAQ0Q8Nz
 y/k3czYzHIVS+UWrr2xg0LQTDmmU06WRPfvFf22tSPs3hysmNzaFCAZiCT4nkRDfyLj/OoMEiAO
 LdRuacmlR19PrURjiRbhbb6coBC4PovtxzLHqOgXHHbJJQgudevBuWeACbq/16VnSYnXn1n/dra
 Sf4T5J238swTtW2hHXFc635XkoShwzPMjdA3OHueXjYA8RcKv6r+2iuw/6+HbWRJH7K6mwZ2jyA
 S3yeSTFcPcozBEvJNNA+rNOdKrtKiC5VbhsMrbbn3+sDbyzj2JXjbF4cA85+ygEPB+r3oTYUl31
 jwNWx72nggBTwAA==
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

From: Stacey Son <sson@FreeBSD.org>

Add implementation of semop(2) syscall to perform System V semaphore
operations. Converts target sembuf array to host format and executes
operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 3dffb977a5..e1e552b58f 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -77,6 +77,28 @@ static inline abi_long do_bsd_semget(abi_long key, int nsems,
                 target_to_host_bitmask(target_flags, ipc_flags_tbl)));
 }
 
+/* semop(2) */
+static inline abi_long do_bsd_semop(int semid, abi_long ptr, unsigned nsops)
+{
+    g_autofree struct sembuf *sops = g_malloc(nsops * sizeof(struct sembuf));
+    struct target_sembuf *target_sembuf;
+    int i;
+
+    target_sembuf = lock_user(VERIFY_READ, ptr,
+            nsops * sizeof(struct target_sembuf), 1);
+    if (target_sembuf == NULL) {
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsops; i++) {
+        __get_user(sops[i].sem_num, &target_sembuf[i].sem_num);
+        __get_user(sops[i].sem_op, &target_sembuf[i].sem_op);
+        __get_user(sops[i].sem_flg, &target_sembuf[i].sem_flg);
+    }
+    unlock_user(target_sembuf, ptr, 0);
+
+    return semop(semid, sops, nsops);
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


