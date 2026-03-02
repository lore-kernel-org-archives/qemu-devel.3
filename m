Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3656D58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwun8-00012w-OB; Sun, 01 Mar 2026 23:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwun7-00012H-2F
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:57 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwun5-0006rH-K5
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:56 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d18a9d2b1aso3425948a34.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425314; x=1773030114;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kaJ7/WMIHYxKTm6O9Jk5r3Fvy48JrSl/V92soW/xRBY=;
 b=QAFmmH4PXQh8jstXZp9P+sxtYKj5KKH/+oehO5CX51S+KSrTD5b3igyHzo5ouu8frp
 M4r63Se8sn3n0chYaMRbi3/9s2JG5HvOKLiP0TLQ/SeI2vWUU5roSr/eO8XnRx9RAait
 OMwMbbSzx1THzXZD6dpKN/GhZwYDnv1Jtdj8JDPHfon723OeHCPLjuPMCxvSLvLtkEDB
 PmndJ9REgubaOZln7d98mOFb7K16euGwQDnXycaMB7MlbX1jBwDBdmilNrB+rai2pZby
 z4sfLswCeELzZdmndsr7wG2jMQmpuO6d5RLdNpcRPeWRo6IppMbEdmPV1karBQnd3enX
 hTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425314; x=1773030114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kaJ7/WMIHYxKTm6O9Jk5r3Fvy48JrSl/V92soW/xRBY=;
 b=VJtLJYTwbPKkXMq75CkCYmXHcCZD0E615afpOTSBXxLaXrbfWpuRf9zezCqc29p/Pt
 lqPhz/ozSum8o7gtmU1be8SiHD9QZvy7WaKGJZx5OFnDjIf5D1Eks9iHhx94N6oEd+xO
 oSbUXRJ+0J8C+Z/I+ypy2qYAajIULze03iQBT5q11jgadnBdcq0YXJpUcuwyk4tmHQE8
 HgzhjYjF3i5qNEwrNYnGcItUVhmNaQb2E/n/hMph8fzRXog4J7JikbpXUvGoes96zUCA
 8u6PqeAphvMJ8+CFfESfxhGOeTW1RgbSAFjUGXbs/0M8bNqQxYqKE7oSe5prByW0Oi/V
 iGVA==
X-Gm-Message-State: AOJu0Yz+8Zh6mKY/wSkqLLrul9Jkx3JipVCiZyZqxE6g9wkw9UN1fpHp
 /MGP53JPdKKDlQk/yx9m+wv3b6I27lgQ9jb7igN7TfVSzX9SsIgmVvdremvGS/vxRHU287ikIgJ
 sCWfybp4=
X-Gm-Gg: ATEYQzzitIxFPkvwmC/KyIFRYW679wEfgbAjXwFHD5dMrETtfvVn80ZFVjuI1/uJbJR
 hmAirHTyQ5UTYPSeJj6rZH4UKEyuqdjeroVKM4U0qq2QE0da8UeW4Oza906mfjT/V8koiojMRj8
 aqzhRPaqMJu9sCD1P5hiWEfghTMvRpbwas2VCnyF5ftohAASHMFIJSrkIg98GAu0gJCQ4LyDuCg
 h87VDzeN7FmODpnW3MuvppfrvbDuU5FQc2UlRxMZr/SvYVuj6MDfpuoPoNx8tY4daZqRdE4+GDo
 v+7pzRir6G3+cCHmasIry+QfyCTGRzht61pqireM5PVU11kkaJEFYQnGaazsV5GBsxtULexX2vT
 9PfaQ1bLJlM1OyLmMoC/Ml+4maAJBr4pFBbPI/vggJfwdE7C9Xc1H6kFghr+3BmaGqAHK76jukX
 YpYwhorxOP0w==
X-Received: by 2002:a05:6870:dc49:b0:349:de3c:bfc5 with SMTP id
 586e51a60fabf-41626e4fd29mr5604405fac.7.1772425314334; 
 Sun, 01 Mar 2026 20:21:54 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:54 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Brooks Davis <brooks@one-eyed-alien.net>, Sean Bruno <sbruno@FreeBSD.org>,
 Mikael Urankar <mikael.urankar@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/27] bsd-user: Add host_to_target_msqid_ds for msgctl(2)
Date: Sun,  1 Mar 2026 21:21:02 -0700
Message-ID: <20260302042115.83410-15-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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

Add host_to_target_msqid_ds() to convert host struct msqid_ds to target
format for msgctl(2) IPC_STAT operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Brooks Davis <brooks@one-eyed-alien.net>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 5e5a590227..3e1968718f 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -163,3 +163,30 @@ abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
 
     return 0;
 }
+
+abi_long host_to_target_msqid_ds(abi_ulong target_addr,
+        struct msqid_ds *host_md)
+{
+    struct target_msqid_ds *target_md;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_md, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    memset(target_md, 0, sizeof(struct target_msqid_ds));
+    host_to_target_ipc_perm__locked(&target_md->msg_perm,
+                                    &host_md->msg_perm);
+
+    /* msg_first and msg_last are not used by IPC_SET/IPC_STAT in kernel. */
+    __put_user(target_md->msg_cbytes, &host_md->msg_cbytes);
+    __put_user(target_md->msg_qnum, &host_md->msg_qnum);
+    __put_user(target_md->msg_qbytes, &host_md->msg_qbytes);
+    __put_user(target_md->msg_lspid, &host_md->msg_lspid);
+    __put_user(target_md->msg_lrpid, &host_md->msg_lrpid);
+    __put_user(target_md->msg_stime, &host_md->msg_stime);
+    __put_user(target_md->msg_rtime, &host_md->msg_rtime);
+    __put_user(target_md->msg_ctime, &host_md->msg_ctime);
+    unlock_user_struct(target_md, target_addr, 1);
+
+    return 0;
+}
-- 
2.52.0


