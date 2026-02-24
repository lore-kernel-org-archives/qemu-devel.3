Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1430FF3C985
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutb8-0000cY-CR; Tue, 24 Feb 2026 09:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutap-0000K9-Jr
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:56 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutao-0001I5-1k
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:55 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d1959ba05cso2654630a34.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944052; x=1772548852;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VwG9IGFOxqmSGM/oPn87UQ+8mXvbE6Kw5MD0BJdObFs=;
 b=1ZpJwHzdSQtXT705PGHRXZyNTkakkVYbg4yvvfNLAdq7KP5qW7TcAL6Z1dRtzJ9Ib8
 aT+d0G/Rs9K+2RV063s11KB6yeXz5Z9yClj1bPaZ6doc6WCsoUmlOZtyqVRYLw+BqEpj
 z2z+tWtxRkt+Ex7pqA/0kKXZ/HSvLVguoi9lJxCBji9k6I7iz8azulLuOmSEbpZg/DZI
 LEQGwFzvFJiQZTXw4wxsyUFNozjprCkAkMLjFRqbOi8Q1tsychVcRK9c2hyS7h+qyLM5
 Av8+wucWzctSihfXYxtRfiPjlaovyT2lNk09vT11B8RYdMLqfDKEMx5J4AXnqBCI/n3q
 WLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944052; x=1772548852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VwG9IGFOxqmSGM/oPn87UQ+8mXvbE6Kw5MD0BJdObFs=;
 b=u//eujSom7JYzpiDDNYqHLrBDELZ4xggRDJ7lPhM5palkF42VK7s3hfmKnG0jVBRex
 owulxBdUYPtXzOHzKKONeEtYeK8yO17A5gXauDLzxKUIIqCb800u2YJR4t6CKA6WJtoR
 LuChaBH7xU4lv2mRa6+Wi3KLeQilEl1yW3n2KNyr9haT/f+pNg83w46WgkbHx6eV5/4j
 qJryc03X0IQBk4Hs7qxXgOzuf+/rtMI/7shVgTbtU31cu0lOlnSbRXwTMGnNSFH5/3cP
 13RGCR8S+goq+S28anQcgB4S8Rasre3pI4TvNsBMB57QgKcD1S535yL42NY2IzyJ5D5O
 rL8Q==
X-Gm-Message-State: AOJu0YzfWyT0cuq9K1vmBXDPDzxUStD5Mfu11Kmm+DqdMICUJh4fB3Qz
 5p7wHomgZZx4OiOJwRTPrfimQO/60EO4ip1vBqvAofxB1JpbAGV1bQCGlNJoz/jLRq1louVM0Ty
 xq+bCKCE=
X-Gm-Gg: AZuq6aLktcrsgYYIpR65I8rOAHirVdaUaxw2HW+aFjU5ZSpqUgAo8CACXxPFDL/d+Ux
 vMX5LU8LUnDoGn7TanTrNcf2R76CXmhNpc98XtMj6GWrzwv3Xh9EfxrkP8NnLguZD8i5yWp6BPo
 GND+NXNXRcjXeZPGmj24Pl0SGUwxl09gx9JpWDI7ERESSHPLoVaOXdPR8dSIFOxRRfMPJBwno68
 WlLD0ZsfQd8eAzY3/BxrMNVf1VcCtcapW8Z21obwpv/4JzvUhxgJM+GTvGBQPXnBHi8Ty+hWAFh
 1zJ4UoIARdkKXNv68dRtm3ieL7cY07oMLEkk0wRBCYIwbCVnv8tYE8clLsxIqMXnLjekpV6Cfsv
 FUBHjy/5z2AVhTHTJNGe3q+oLpxpCMLDwQ6Err2aBV87YNp0nG1YaCu+AdD7lTHPmfX104a5b3W
 nJNepgt0IZxQ==
X-Received: by 2002:a05:6830:67c9:b0:7cf:da36:4cbb with SMTP id
 46e09a7af769-7d52c1d65c6mr8557659a34.2.1771944052585; 
 Tue, 24 Feb 2026 06:40:52 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:52 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:33 -0700
Subject: [PATCH v4 09/24] bsd-user: Add target_to_host_semid_ds for semctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-9-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=fgH3524EO/JRuA2EMdN9nWxqm50+gVm4UNlg5mR95Uk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhn5Tmfzifs8dkaS6Q1ISKpYCIvV5XCIt2YF
 UcqGB5WydeJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZwAKCRBsHNEofbAR
 AKqDEACYt0pXlNGnEdNto3fELRNhmublADm9wGJm/Owk0xpubuvSS8n/a+D0Nfclait3l1hfzdc
 VN7ka89XoZWn5/Tw+cd2uLnvf3xsXbMgzWmGIpEWY4yam/HUrxmIHskRP+v6kIKQbbvEd9JWgvp
 D2yCrBSwsR2O/CnaBTNpDjYiCX3MK58vvcv+AnXzkbo4Z9EmklnivtiY6khwGa5m5wUQGm5hgkx
 PNSuWgbAVwK4gSWzzldH5j0xa9DrOv7/dpRnixi6l7M9lcqu2LWSKYhpZowwE5Sx70sjS4I0DY5
 0fYo6rnoRPKpFxDds8FyxIIKZEuvIFPmgoNJeulqT9HoT7IQejvhwRg6Of9XQVa0U6JC8Tg3fkW
 HmQtKCSntAtJaBRszYo1PBTdjAZz5/Fh0p/+aAjHzw47z7tfbVK3cvwjo0Yl2BjZ8sEgPt6GPgQ
 dRhNiANtv8Hznr8YDSVcxdbjhISgQiSKNAZSH7D0Xi2cOnIDo8L49VF4gIH9Bqj9NXAEW+zBsUj
 CJXxLegsQpn2S7WKQRWsKpy66F67Hec1VwxZZ2Bk7JT/F/01JybBQ+qw3xIVjyXf2DJICg0xDOR
 TjH+2owHjMr1WBApO839Z8JVAq+wixOuEwC2sClBVDRKH/TDZhJ9KcGK+wY2zLzlbIsyERix/3C
 ri78Mxn+AIMosTA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32f.google.com
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

Add target_to_host_semid_ds() to convert target struct semid_ds to host
format for semctl(2) IPC_SET operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 65fd7b72e5..941f30d547 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -98,3 +98,21 @@ abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
     unlock_user(array, target_addr, 1);
     return 0;
 }
+
+abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
+        abi_ulong target_addr)
+{
+    struct target_semid_ds *target_sd;
+
+    if (!lock_user_struct(VERIFY_READ, target_sd, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_ipc_perm__locked(&host_sd->sem_perm, &target_sd->sem_perm);
+    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
+    /* host_sd->sem_base  = g2h_untagged(target_sd->sem_base); */
+    __get_user(host_sd->sem_nsems, &target_sd->sem_nsems);
+    __get_user(host_sd->sem_otime, &target_sd->sem_otime);
+    __get_user(host_sd->sem_ctime, &target_sd->sem_ctime);
+    unlock_user_struct(target_sd, target_addr, 0);
+    return 0;
+}

-- 
2.52.0


