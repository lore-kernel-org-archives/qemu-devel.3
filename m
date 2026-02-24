Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F90AF3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbK-0000uu-DW; Tue, 24 Feb 2026 09:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutbA-0000kv-DO
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:18 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutb6-0001L8-CC
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:15 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d556c1a79eso1991913a34.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944070; x=1772548870;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nZXQv4gZD+ncGRmcanP3bAVNuvnim3Z+KZJ0IpojcCw=;
 b=aN0Pbw/VZvNEExCsEyPz0IraDxC9NXKpvWXemsRPfDWmJd76OrI2oIVbmYnm4KMN83
 15u/MOJfnCvN1OeWZYiIsA2XF/1gYSMH9ebTls8HVLvknFTqRKMJfXrJWQ8XFQuFXT+a
 4XXfsAklwIInGKW6S/EgnvYgxGJJNc80QA2udWp80vi8JibWEMFyzARFnKxyId/CiluE
 6NNoC06ZjGIt0zn63DjdQDsZ18oRJZQDQgSFOkJQH9EmuoiLgtbT9TGUN6LKLuTbS7EK
 WbgqiRNNs+4T11+/1CKI6Ptd9IgEURv1zaHmvmu6ftRNf1Dc49w97n+4cC2vQ9u7vY4h
 cFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944070; x=1772548870;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nZXQv4gZD+ncGRmcanP3bAVNuvnim3Z+KZJ0IpojcCw=;
 b=a16nYRNprOZY4fgUnJU5E6vmuIliurZdCsssh9PW5tI9sXGw38tNwS/t2LOR1WaEWU
 qZsTYkVtjW75L7MZ63WQrG5YVV5vwLoPNSSTsXsPXiEkwE2BOWkeW2lrIFwz4Hcc4UJC
 n6kjSkIR4Tw0Q3Iv56w3X4lZbMrAjy69Yak2G16vK8337uuZ9T1mudo3YO+pCcFWjU3T
 xMhNTJTMZ8MVKILRWuWsx6HA58oxN2qXF1BN1UTJDdwnBFZi5HK64NGyFXwENneenTD6
 xaVRJteZpySZ2uZZGQ+qQ1SRctKTZHZIG3hpzZ7NRXSks0iBtSaWgjvfqEgovokgSCAP
 flhw==
X-Gm-Message-State: AOJu0YxwC+b69XT1/wgQnsGjzrU5fPEuphTz+QeczbvsBKEB94nLqFDW
 oq1N49gsL6eIhv/FYVM62/K+kXCRNPQZYQzl52EnndBAIJwoIZ4GJ+hqWF34MV31oMcSdlX8u3s
 87zXxWUg=
X-Gm-Gg: AZuq6aIqTs8n820vhuCkdZ39ZtDOfjs09HdzPxukX5aqbP7QVTCfparS1O7p1H99UzG
 tVEYddOgVba6f01CGAXzZoD+WlCPzw489jAdMVVgoKLJCS1oPlPqN4ClZ3Dl/N7lo/zCVfu4a7l
 Go36RmujtGogSF+wgKSyDz1izd99Jev1hwWRTudwztp14LIeBYZXONZh5EFEa0+0AfC5kMtBfM0
 iLwTnVqbT7XI/KJ8XZFUdckD/DDO2N3GcseYe+FguMSSL1DmIp9J5PFIgiBEZ7AoZyxvUzNNSX+
 T9q239rRPQHYQGTGPl85pyf6Rhzm8ffmEEo9jdj+NaxAlQ+TbeyE20pkGOAgIZz20DZ1Tr1WQ9t
 HF2QmbSzMrpCmTPZvx/japr9ZfpaoD3rLNQCEYhbUQBeTPTvCiVVLplBP3jttiQfZZujLID9BsT
 NCgYy2h2Vu2g==
X-Received: by 2002:a05:6830:438d:b0:7c7:471:55ff with SMTP id
 46e09a7af769-7d52be3dc61mr7553001a34.10.1771944070320; 
 Tue, 24 Feb 2026 06:41:10 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:41:09 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:48 -0700
Subject: [PATCH v4 24/24] bsd-user: Add miscellaneous BSD syscall
 implementations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-24-8ee5ae17056f@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=5JNtxaB6Hh3wMCs2T5wWom3HT0DjtMFbl/EcUs72mDM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhoS+SrTwrCjo9tzTX5Kw/9LZ/+XHpHNpz24
 4Q15xedz+CJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24aAAKCRBsHNEofbAR
 ADJYEADk3lpqhNDNZmzIaSVj10zAwtvXHM1Z7rH0E1g7JRYuxCeuZTHC1W/vO0M4qTZXlzpDH5O
 /l56yR5/XmLuK5RneQQIj4+bvIvqW2Psg18Na+yyV7Jz+jsoeyv5A9GyV8HK5dxIKNO+vcy1aP3
 jMjSUHTjr4vSbXatg2Z574TEYEjwz+K0FLvV22A0OB1Z1uA8+hGjqom1TRM8VGmIlXt70DMandb
 ItqusXi2oXBoTg6QuOH8+dr7H5j+tqK5rYcw57ydC6BnANnQQoghGzLcE3eqYyYsVPU9D+8kWYC
 50HbahfhM0G8R+RVkcEEHUnCL2rlNnyd5ibgRY1kXe/2wqfuP7AUl6eKTcu0yJW3jDOz5Rr6Jxf
 LJJLskp5yLKduk1eMKzP28Xm6qwGsTHxsJnyP03JM1+7uWRNfGgSuMNyDJ5GxV4bfbHGshs2FzK
 HqJK9TdeoJV2ls1QJSZEoNjyobq19Em9pu9LQIwZNbnfjxvG6fcOFqoGsi5Uqk40vU4cwnoMM7s
 fovFxxv0cOyChEgLVHDgeJlB3s2aWyi5L+YP69ib0wUAXYyLug5X7s/igIGEEAD0jQ//JtmuGpQ
 XjE2GUDY/MlvQmYjiVdF3aCQOwHIwNQsJIBURsOMik14+lF1Mm4bsMAXT8JIpSJKcdtqF2uvbHA
 TMNrhxBkQ7dFOIA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
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

Wire up the remaining miscellaneous BSD syscalls:
- quotactl(2): Quota control (stub returning ENOSYS)
- reboot(2): Reboot system (stub returning ENOSYS)
- uuidgen(2): Generate UUIDs
- getdtablesize(2): Get descriptor table size

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f39e521e42..85e5db19a3 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -933,6 +933,22 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_obreak(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_quotactl: /* quotactl(2) */
+        ret = do_bsd_quotactl(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_reboot: /* reboot(2) */
+        ret = do_bsd_reboot(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_uuidgen: /* uuidgen(2) */
+        ret = do_bsd_uuidgen(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_getdtablesize: /* getdtablesize(2) */
+        ret = do_bsd_getdtablesize();
+        break;
+
         /*
          * sys{ctl, arch, call}
          */

-- 
2.52.0


