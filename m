Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D66E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswV4-0002l5-P9; Thu, 19 Feb 2026 00:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswV2-0002kd-0J
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:52 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUz-0001gk-SY
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:51 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-662fe3ff6f6so321190eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478569; x=1772083369;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pBz8VycCUML/vNPwsdJc+qzGhunZE8y8+GOUDlPj+GE=;
 b=BU03x9C6nsHj5+wZmjWCL/VJR9Rj5OAP6IAaI62JvW9s/yhJGPdPEVHYoo41aBBLj5
 bueVE5q+JLwcKZNqIrcqIDp+zJ+NLgPwFpcJx6oxFsCjGnhNuIJXW8m1B0UKRIPRx3r3
 TEmqD+nHrEk596glYG9S/IF408yfz6a08ZkhZzjaENV+CkZQxfH250nP5nRs4Ix+7diO
 lVMqfQ4e9+GKurvKxyXtvRm2SDxSrR8na4Jo5q12CsVX8iCzJsoPl2uJdANLN/rUpYHO
 WxbHlta1y4NymoeVngafhQaIKjwGVz8z+9ZgK6YEj/69mSg0MG2VOuHh7S1PKnYJdf5m
 vKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478569; x=1772083369;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pBz8VycCUML/vNPwsdJc+qzGhunZE8y8+GOUDlPj+GE=;
 b=r/I6mBZ7YCpgorQQ2EYkPDp0ydM7P6JgFv6fAvqu5e/obcUlA7DNarMyXnvniCxPPX
 XlWfQeYW5d8/NDDch1wmQlrmi/WGn60rMORO+8NJGTFlsaDT9DGQiIVJ1rHLNozT0AHk
 YeKWZYGR6JX/6q+0hWU/WQ9268GrRVnhewR7gdUhZAHdRfqnML0pzm5UMEn4oeHhoDbJ
 CW1ToKDzy4UQTClDjGK8cQBb0+x6dtH5pA07Z9u5IFxVVb4KtQHunJq2KKxRzOiwymFZ
 uC43Ry3EEUQwThfxgvjiogfBlP4CjsjcwsG5RK9lXr/5iVTInalkbseZfkURAZy1D4a7
 iwxg==
X-Gm-Message-State: AOJu0Yw4WKxFi2l/AvNiGYmEKOD37zGDrIqBoR2qHnp8K800Pq5UiSBX
 PJ6jkNZTeHioZhwWNtdlR6OD/WM4u0yFV8GjvsGYcukL4j/22FMsC2T0IIH5By+rodw=
X-Gm-Gg: AZuq6aLMSo9hH6DEGeh7ZPL9TS8sDAXWpNLbBwWbERNRKi375RHxv+aMdcXrAt9OX2x
 9Vlt1h2mf7TABlEY6P/yrTVPW7c3yJxboygcm0Eo1EOnC8wEODItb1pNOe/XbMHFeLKwu3Dnezy
 CJxsB6T6K690NThnhGfpNVIxuQ7g8dPPZ2b/vv/k3iVTrkRX5FR2yqOPQSxXi8wYN0MALADBmGz
 6rOmaMHgdYeHdnBmKArhxAR1y5gd0o1Gi/elm+yAoZK0e/uoQvV7W5xndFvJrhQIndrFbHxTMQO
 DukOYKlbvO69tKgKAivt4t00soBVM38tN6F2CqeUiQdMR1RHC2gDlg0kOhsEdepFxxRehj6Op4Z
 wGaoOhEBX9Xb1vBwAxZyuItzdBq9zt4LG/BVRso5KCvdsKp84OPxNRARfI4yhHIv03MpPwT7nMe
 CKrgNOUYcJCg==
X-Received: by 2002:a05:6820:62a:b0:679:a484:fae0 with SMTP id
 006d021491bc7-679a484fb98mr3187052eaf.28.1771478568666; 
 Wed, 18 Feb 2026 21:22:48 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:47 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:33 -0700
Subject: [PATCH v3 10/24] bsd-user: Add host_to_target_semid_ds for semctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-10-0137b37b221e@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=m4nroGBdmsjJ8MqRlkpI324ArqPLJWX8Os4psbfwQzg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4rLCwArfQEQLf8pI7X+gc2oPYUvFUVx+owY
 vreVewK/r+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeKwAKCRBsHNEofbAR
 ADwOD/0U6aWcwqh7vIGi0e1vr0koAwKaWv0BZ809c38j8zcSC0XjI7HXOqRK62sjNXfOBfoQz0p
 NhwcYEZyGp94qewY+O16if+YKas2lpkVZCjZ0dqUheTgepwNrdn+wdjhgqwgkLSohmamQUY7RSx
 5E+vMoP8Vo3x/8As/zFm0wD3igBfsEgSOlS9jw0/4RQrZ77greexcb421rReDolHw7K08652sOO
 qn2r0tIqiRnxOM6LjE1p+rLsEg7uuP0+QM+nhf5sckhC4mFjAB8DVHnUhsJ6M6EznOh1ngDOfNk
 9rTh8xxcVdg71LTf2CkbUsDXu1+CYFPXOcFJiqwEh3kyk0XSghKFZjattobXLLp1j7WpePB4Na+
 QgFzVFE9sv6+5XhP6Y/laUG33/IC4vGdtLesn9KxdfOP/Y3ux1vvl0CO0cRfRw7gpyHcgdDQHOz
 omePAB4D0AtQVlbyJNxVEZSgaPRDSB7AJqmdT5r+4FNV57PqIDijrk2y1yJqJmpWZwcJuLUUE7E
 TpNQnd20BF8zSCjqDmB4+zAAkuxZohEoPzoCb0aNih14EQxrtpAUxoIWVJ241NR7ep8sFEqZhy7
 m/CUYffXAxdIe5axFqwjs73EAk79cIwbFR6l4eQSFzndO9TULewFf4kuTDhHdyaM50fASng43+q
 KnV9eQfMKwpobUQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c32;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc32.google.com
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

Add host_to_target_semid_ds() to convert host struct semid_ds to target
format for semctl(2) IPC_STAT operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 941f30d547..5b02006313 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -116,3 +116,23 @@ abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
     unlock_user_struct(target_sd, target_addr, 0);
     return 0;
 }
+
+abi_long host_to_target_semid_ds(abi_ulong target_addr,
+        struct semid_ds *host_sd)
+{
+    struct target_semid_ds *target_sd;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    host_to_target_ipc_perm__locked(&target_sd->sem_perm,
+                                    &host_sd->sem_perm);
+    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
+    /* target_sd->sem_base = h2g((void *)host_sd->sem_base); */
+    __put_user(target_sd->sem_nsems, &host_sd->sem_nsems);
+    __put_user(target_sd->sem_otime, &host_sd->sem_otime);
+    __put_user(target_sd->sem_ctime, &host_sd->sem_ctime);
+    unlock_user_struct(target_sd, target_addr, 1);
+
+    return 0;
+}

-- 
2.52.0


