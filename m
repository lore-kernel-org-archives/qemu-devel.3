Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4762ECD992
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38I-0004Ye-6h; Thu, 05 Feb 2026 12:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38B-0004SU-Eg
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:03 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo387-0001Qq-O7
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:03 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4042905015cso845591fac.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312417; x=1770917217;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eiLFo94DHhiGqnCCYLQLyni0ZoSPiQWxVfQRYkKfSjE=;
 b=IfF8FVMkuVhokoqbHEG/KGXajDyDsYOjjDUPDjhrez6p97O9+ayYUfY64V+LyaAHEE
 a8j4WcSqumCWomURfCvwNVe2ts6Vnww2xWbKAx97Pk8gZw8Dz/CqGvppI6SxlAbwnbD7
 2jqmpiTJOF1kAGmVDhzlA0BxHcAms4ON6pGz+8APSWtgF7vJ6ZnYs2UX7xQW98mvDuB9
 V1e5fOsg5jUfvO4fA2kDHN2sE5LvslL8xnGhlvzPP827KMTlw08aXxESCYHT3kNNXanp
 MMRQai2BRPdF72Diu5xwqSNbnxbwtai9ERUv04k+zwRvQ8SQCb5Ty8M2DtWbIfswpzjn
 zcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312417; x=1770917217;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eiLFo94DHhiGqnCCYLQLyni0ZoSPiQWxVfQRYkKfSjE=;
 b=EJJf8yg8lurhd1PmPUf4uHiUoni/dFntBuw553YiwSdY63cmCZiP9R2YE5lp9eIjVT
 4b9Jw3PznuM2rmyQbffRZFQjyiFc2+bDqhUTn1ovGHoq+A7yPpUPijmuxIR5B3j/kSUK
 CfaCujdU6u1OwMEFkbFQOKp93HSMjAdtSmA3dhRHKm56PWU0dGsmbcDE8HsEq4c7x5KL
 dh9qsdrlZsxFVbgBohk2c9uyfylBOHCiTZe3T0i3pUnVAno5dQYsEUJMBiFavy9J6sRq
 m3hMVrOl1Ldk3+WJY5+Yn1Lwx9/ktmpQGXgS09uUNB5D9qGzdIE3BcuODLjd62V660ea
 UX8A==
X-Gm-Message-State: AOJu0Yye3/J66fuQIrZQWZvEsZ1PF3aKK3p/wPFZZnRBgHwu67BGbC5m
 1p9mwlqL1x34uAPoADodW4Z8FuayPenTTBPN4z/HEexxjfVMIKxKyIiCEttN3dSnlKRu7WBdkMz
 Vfy0ZlqY=
X-Gm-Gg: AZuq6aLogFF3yFnmAgyKpfb3uqWpKr3/j6Q10Y/5IAtECh167wVm4rgIegHQU9Mubko
 Y1uLC8P+cB8s7wJsH+hz+bM5gUZW+KTVyhrfzmgZVAeuc8BA24Qh9Yq6iga73VfWVgprIuJyV6P
 +0q/u2tJIb5D7ksLgIjO3ampnP3uCUljwMz4XrHJPz3zrkadhz5p6wsdKfcp5Qt9NPtW/ZcyKPh
 n4z+SdnvrYOGrQTMdPahrBi83RqU41HGL85c7zcMa/LIb2cVWJp5wJk4kPOmiyllmM74o9crs+4
 925VO3ewtQ1Euu0Z6cpaPcVf6ziXZoiZ9Qh4LD0d4evsTxQ3PxX8MgO3cKcGl5tdZc6nnLuC9u4
 CBVV0n5muT3yuGSfjnRPnRlODA6HPg9GaE+7IGX5Ua3dqZrN/xSNIREYi0H0jKhfnICnCZrha0g
 ==
X-Received: by 2002:a05:6820:2208:b0:66a:b73:5e38 with SMTP id
 006d021491bc7-66d0ae30ffdmr59475eaf.37.1770312417449; 
 Thu, 05 Feb 2026 09:26:57 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:56 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:48 -0700
Subject: [PATCH 15/24] bsd-user: Add do_bsd_uuidgen implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-15-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=JkfwpXoKXr8HAyR1b563dnbCt5z99SC9HgzSGrWNKgk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLbuB4TfAVljjpijQR95LZDptNN+IrE385PV
 jD8JXT4+pmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2wAKCRBsHNEofbAR
 AGLxD/93Ycbmd1XsmVezZJz4NmTQICT98CoxFGa3Jrwm4ZroSJnANXt5zZlG9Dk4w90RfAFB+cj
 2yBdUbuVC1IKSLPVeEZyTCg/XAovyQ34xxFb6RUJhxwSCM1nUFuBxJVW5t84ab3BHHgypRcWO57
 v98u+OialBtAcBhghSakimFygkfdjYRqSq/cMiNJOTbIctMxIsFcrcEcOUjAbL/N6bdcFLJsESn
 n/yAAyKDnbAbpaC9WlHbI2YeKjDCDMomCL2SmzMvvE/k6AssGYhScMJejEaJkMbng/ryynVFw3E
 pxhjsJZAN+QzfHdWcAVyASVQ+ugRUDNbB/ScswYM0p3pIKhrIrKRH817UiR50LZdRjnQVjhhawf
 1IM9VfDC8EAysxh5LwSvXNEZTIWUF0129Cvc8ukRmmYme1DxBDydsfEF3Lbfu2oIchrx1t6E4ei
 wvqaS7xG/0TcjfY70nsi93Qy5d0KvUbrUEbGf3d0JDvY9ukKmDHsupwGRtdY8J5dFZWyLmSQQ/9
 bRPT5/d3DQyZWTKnjl6QUuFbKTE1PvLFzvgTxf8/uEivhhhBCdwJjACEfHimyKvpttLk57poYJR
 mnflJePiyZ6c+Vp6D3GPtDzgaD8Z/dWuvcff4H3i418Ny/AaCRqdO6OwQlWDEyPuIRZVfMBY71+
 dGjbgDb76lcr3Ag==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::34;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x34.google.com
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

Add implementation of uuidgen(2) syscall that generates UUIDs and
converts them to target ABI format.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index d81b4fbaef..b722c63437 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -43,6 +43,40 @@ static inline abi_long do_bsd_reboot(abi_long how)
     return -TARGET_ENOSYS;
 }
 
+/* uuidgen(2) */
+static inline abi_long do_bsd_uuidgen(abi_ulong target_addr, int count)
+{
+    int i;
+    abi_long ret;
+    struct uuid *host_uuid;
+
+    if (count < 1 || count > 2048) {
+        return -TARGET_EINVAL;
+    }
+
+    host_uuid = g_malloc(count * sizeof(struct uuid));
+
+    if (host_uuid == NULL) {
+        return -TARGET_ENOMEM;
+    }
+
+    ret = get_errno(uuidgen(host_uuid, count));
+    if (is_error(ret)) {
+        goto out;
+    }
+    for (i = 0; i < count; i++) {
+        ret = host_to_target_uuid(target_addr +
+            (abi_ulong)(sizeof(struct target_uuid) * i), &host_uuid[i]);
+        if (is_error(ret)) {
+            goto out;
+        }
+    }
+
+out:
+    g_free(host_uuid);
+    return ret;
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


