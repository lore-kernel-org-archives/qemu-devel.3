Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DC2D58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwunJ-00016G-Gk; Sun, 01 Mar 2026 23:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunI-00015z-DD
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:08 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunH-0006t4-15
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:08 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-673ee2a98b1so2983272eaf.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425325; x=1773030125;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkSPYe7vGxsH38iRtJNJ1Zw+ligLc5Dh2MoNVN9rfT8=;
 b=KqB+tBEFS5xTgUOFoGYEy9ofaVuSTwUZSmdIEvhDjPvy9otVndEAza2Q8pWAov44Eb
 nnE4wBtZAl1EjoIwW6fZ4sjinouHb5HmvX+V/VWPBZSkztESOj0xPw9nHQWFyOEEBLIl
 vfx+Cwc24N840LuO86wz7djsb8ItuIxTAJAAJuw/WI1vWFBfKjxv3vK7Zdu0VOR0oBzg
 JruezwtURdtKqKl8QUDrVgRwg86Bsb6Wj2jfIGOPtHawxInwpDxnQBfD1hbDQXkxPjoH
 /1JXvSY3zemlEkOSFilkTxYuSNuym5yLOCog1EJYjZ7i2SxBeGWtX23RytIOwWo6Gk9d
 265g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425325; x=1773030125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tkSPYe7vGxsH38iRtJNJ1Zw+ligLc5Dh2MoNVN9rfT8=;
 b=IOFbfUpKzzEAaIpV+kcJo/PQCYSAC9WpwajGqFv/wEA+Ffs5noJaF8HmeaopqY3x9h
 KIcjSZUtdHCOCerQ9+XAIZBIVR5UWdY4JV/0Xf6ZJyr+E1eQ3t1R3K1I6FF5ljT9m1Gs
 jcRllNbVvgcVYsEUlWR1Z5erQdsqJj6hhreVwZQCyQ5F0YPy6zQEVXKpO/MCE1vhVEHA
 nuAXKNEipIPrOCTXEtBgOjLIyrqIlEpVyryDNcD6Ltm7sWHOAmJDQMa4aS3NxF81zkVr
 0YvDA54cx+AA9Fh0wbgw2MXfI2pUKEZc7lRRLCEjhvnXpla+UtIWQPSixe0oXYdDjv3H
 qSCg==
X-Gm-Message-State: AOJu0YwCdgB+OWTbj+JLWZQKMv3k8RTHAj8Q+wk+aBoW57k7qC4tsVPr
 7LgmU+92l2htfNn5RQikAUVmcf/KBWeA2D+PTGYnXpdpADWWiRCCBeVcXCTt51E5gUjFpiKxbrK
 MxqDlHaA=
X-Gm-Gg: ATEYQzxQ72qe/CZVbZ+phMTXuGxAK6rA/jAblj82eDSZdUDfxe9britp+iF4MyAM72D
 GeJBCT7HK6PpT2epLkKT53cd4ON4SWlHyBku+xHr1dfVcuYM4ZXCgF8tdW/7Zsx4G3VdNKRLgXw
 t1/XFnZF5htqjSO95FUBPOMo/lFRGo0JO/Z1jGeEvMqscZQZL5qpi+so1OWviMETIFi1Vmhvcve
 yTu4Al/+eDz41ZX5k7Mhue7hoE/thiuZk/FgeRZp9XnV8swOGTm5DRMU2E8we/DW+xHREsSwbJB
 nM3kpZJ46DrXWag8yjsprz9vyQyNjfkA6SUx/BQ7k5psZTIuHzXzcBoVyfs7BVIjETdcCs8WJXx
 y/MEiG/qMPSS2/bE8SMW5jqX/rwzObHok8VAvQTp9h+skcWt6rikL3BiQa8L76WcIcCBV3ZJorl
 TDtMJgozhIgQ==
X-Received: by 2002:a05:6820:81d0:b0:678:1941:c633 with SMTP id
 006d021491bc7-679fade5628mr7131385eaf.12.1772425325284; 
 Sun, 01 Mar 2026 20:22:05 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:22:04 -0800 (PST)
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
Subject: [PULL 21/27] bsd-user: Add do_bsd_msgctl implementation
Date: Sun,  1 Mar 2026 21:21:09 -0700
Message-ID: <20260302042115.83410-22-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c33;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc33.google.com
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

Add implementation of msgctl(2) syscall for System V message queue control
operations. Handles command translation and structure conversions for
IPC_STAT/IPC_SET/IPC_RMID operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 47 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 2397ca460b..4209ac61d0 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -213,6 +213,53 @@ out:
     return ret;
 }
 
+/* msgctl(2) */
+static inline abi_long do_bsd_msgctl(int msgid, int target_cmd, abi_long ptr)
+{
+    struct msqid_ds dsarg;
+    abi_long ret = -TARGET_EINVAL;
+    int host_cmd;
+
+    switch (target_cmd) {
+    case TARGET_IPC_STAT:
+        host_cmd = IPC_STAT;
+        break;
+
+    case TARGET_IPC_SET:
+        host_cmd = IPC_SET;
+        break;
+
+    case TARGET_IPC_RMID:
+        host_cmd = IPC_RMID;
+        break;
+
+    default:
+        return -TARGET_EINVAL;
+    }
+
+    switch (host_cmd) {
+    case IPC_STAT:
+    case IPC_SET:
+        if (target_to_host_msqid_ds(&dsarg, ptr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(msgctl(msgid, host_cmd, &dsarg));
+        if (host_to_target_msqid_ds(ptr, &dsarg)) {
+            return -TARGET_EFAULT;
+        }
+        break;
+
+    case IPC_RMID:
+        ret = get_errno(msgctl(msgid, host_cmd, NULL));
+        break;
+
+    default:
+        ret = -TARGET_EINVAL;
+        break;
+    }
+    return ret;
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {
-- 
2.52.0


