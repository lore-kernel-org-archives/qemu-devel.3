Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7363ECD992
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo380-0004OM-NS; Thu, 05 Feb 2026 12:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37v-0004NT-8O
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:47 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37s-0001Nq-Co
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:45 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4094d7d71a9so450107fac.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312403; x=1770917203;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=04pRH5rJZSMEls8ye7woMf0Vms3XmfyAn0Lr04fjp9U=;
 b=QcGWy6KSmI2eN0PYhWzyC1qvr3NZ4R1LgJJrDVT+T7lUfOHNvmr1l9Rt4eQh+pSK4f
 BitPpDeAj4KOxOOBXJnyR8LxQYl5erOHRv3SNlYE1JBNAmGx+pUMDVgFScDc33XNYtvE
 VmM2IPf1LST3YhLGjScJpMQVeGK+H/Enq1gJ/7+6VG/TdxdIA0VUr31OeVTnpxLBHYfZ
 vBgGISHSmuoqMGHAa+8p0s7aGGZ+NxfC2v/vuRyhzYQ3z6RYggcR/KAh7pVqJdLOUU0l
 OMEbuDhF8xNvULlej1UvNMyG8UEiuUFNJ+NWIb2wBJ8bW40TA0dMXgrC7BIyFL8rhize
 iVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312403; x=1770917203;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=04pRH5rJZSMEls8ye7woMf0Vms3XmfyAn0Lr04fjp9U=;
 b=GS0u735ay4ZkshGBXQfjL2JcJABZ43+KnYoXm8UZ6VDF18SC7QnGPG1ii13A43JPA6
 bdweZZ82SFYkQJgUDB28vHGkIegzhQBjhoKG7X/YpCQIF/5ai14RGknjr0BnnDsc61qD
 Nd4ct8KCAB/cVSOZhixyDFZVsu3aCW9C1c4j2yG9Znu497yTFI5WGE/jyC3/deAQSEye
 tfzoL91SAgSTgXhVzloXj7Li1wFZ9mQiTXauK11blpuoYkPPZc8zy6o6/83MpqdMYfMy
 ElJ4og+8xUYL3m8U26ppzgCFfk9Xj9bwSvcUzVp9xAmg0edJy3PLxEWZVzapFXsEQ+Tq
 FKNA==
X-Gm-Message-State: AOJu0YxYPugIOQCaUkx5DX+YnYMacDdUB1SDRAHrwRtnE9Z9bf2Aal01
 GFGZBOPeXHXFFXeTWFAGXjtz5ZotEUKF/CjHLgOlqe7BzSNpTGQMsPPqul4KlxVhJqc=
X-Gm-Gg: AZuq6aI98uUxl+B/j6SrYRgSYFELxcI3Wkftm5GWgBAHuLd9n6LDfAT5ayg41FmzObP
 1aE1tQiHJxGP8+NnCTbqZxV2SKJByosfEJpQJpwI7oK0kguwKGBTzjtlOROC4TBoZpUSNZforHf
 lgqHgdMwxuwHe4tiOyIcSsZJHhEqM2fBrJEVeMF3AfuSq7OYUr00UpWH0T+/MbXxsxquN8DZQFp
 XN2oGtsWC044H3dQNK9enIGfFdv5ganmU78dImBwKGPySwcsIFypzNUauAWnFyBt2T2Fz5uEqOt
 8OWrP/M0+g/wD36P0U3BTTxvXo0YQZ4FILesVgf1nerekG7cABURW++127auh+w0cFvQZt7IMCL
 EnapFTqdgRObl+AAP1lhCPe8Pr/joeBd3Amb+gRlNq2qfN7Af7QlyXOrrbZNV+7Xz1oUaxm/TAw
 ==
X-Received: by 2002:a05:6870:c20d:b0:404:4301:8ce8 with SMTP id
 586e51a60fabf-40a96f5487cmr731fac.49.1770312403078; 
 Thu, 05 Feb 2026 09:26:43 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:42 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:36 -0700
Subject: [PATCH 03/24] bsd-user: Add target_semid_ds and target_msqid_ds
 structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-3-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1953; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=DhxC6cgRJEZNcZCiN2JAEhPfD4PpHaHJszmZ+T6/gw4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLZpWXIkeurZWbUGz+R6FewdPLK+6J5L4AJ5
 DbpeFDZEtaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2QAKCRBsHNEofbAR
 AH79D/4rF+GXgjTdxVql+16hovQSZycciFy2tSavJZEDuOU3E52yB3y159OVi+fkg2cFVgXr80q
 ipYptx2vEG6XRzNzYef19xpxb550CinOObfPkWfvm9tWmx8Xw0XJ1fowYwd5jJO110svmiLtb6H
 psutKX5e8AUQRJxJFCJDB4N0w4dwIcgbaf1Fh8r0FGyDdyVy17KWUxXBi6Q3sUqeSxRG2+5zXJ+
 4pyyufzvyUumDgg/63g0MRktDUqftb/iNyETBw3RVkseRY2Ti8Ed7R1neZ/WmK6KOedv9k9uhiY
 NYwQbzFPTGhLtMbqVN6GXIEP0dfvecGpl8NJGnw7e65PavJHiwnxc//UN4rnmIbV43h3akzy6Vv
 PgoKJ3qPJ3W5v44Y4UrqLjB0YXsajKpvDmAYmJMTHhWm8NuuNIG7mLYJ9KDvHsL3G9PipV5MG60
 wJ5zZiCY7YGuFec/GyUljaTBPp+2uPc5JecwgWR1xDxipEPDRMmga+pcaSN3xW/PYHTk3FveJqq
 z3P5rHZf7zyBlKTY8q+DyJg/+V7a/Fr6+njfm96EhHN38hzIXCUFzWZpdJGQXKOawVeYi2+TkFt
 BzTCX93KBzIvC8sq+yvWW/meVqpVeQ/vozAkWGDR8b55rY0L/IWfXAlZSzkiGchLAhPiLBMsJim
 1ERx9p0J6MvWHVw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::36;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x36.google.com
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

Add the target ABI definitions for System V semaphore and message queue
data structures, needed for semctl() and msgctl() syscall emulation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index cc4b484f3a..98bdf8cc1a 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -92,6 +92,39 @@ struct bsd_shm_regions {
     abi_long size;
 };
 
+/*
+ * sys/sem.h
+ */
+struct target_semid_ds {
+    struct target_ipc_perm sem_perm; /* operation permission struct */
+    abi_ulong   sem_base;   /* pointer to first semaphore in set */
+    uint16_t    sem_nsems;  /* number of sems in set */
+    target_time_t   sem_otime;  /* last operation time */
+    target_time_t   sem_ctime;  /* times measured in secs */
+};
+
+/*
+ * sys/msg.h
+ */
+struct target_msqid_ds {
+    struct  target_ipc_perm msg_perm; /* msg queue permission bits */
+    abi_ulong   msg_first;  /* first message in the queue */
+    abi_ulong   msg_last;   /* last message in the queue */
+    abi_ulong   msg_cbytes; /* # of bytes in use on the queue */
+    abi_ulong   msg_qnum;   /* number of msgs in the queue */
+    abi_ulong   msg_qbytes; /* max # of bytes on the queue */
+    int32_t     msg_lspid;  /* pid of last msgsnd() */
+    int32_t     msg_lrpid;  /* pid of last msgrcv() */
+    target_time_t   msg_stime;  /* time of last msgsnd() */
+    target_time_t   msg_rtime;  /* time of last msgrcv() */
+    target_time_t   msg_ctime;  /* time of last msgctl() */
+};
+
+struct target_msgbuf {
+    abi_long    mtype;      /* message type */
+    char        mtext[1];   /* body of message */
+};
+
 /*
  *  sys/mman.h
  */

-- 
2.52.0


