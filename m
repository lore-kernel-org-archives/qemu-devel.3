Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E82CD3423
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsM-0007rr-Tr; Sat, 02 May 2026 13:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsJ-0007qP-Ju
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:31 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsI-0007Bw-5B
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:31 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbe437b072so1829373a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741889; x=1778346689;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FIy4SnqLUGIEyitTzv2znL28AAqKREY6FCzUomgrBVM=;
 b=M6mPKIGS+7XBlE6GsaZeAjL63hloQWEfVpj4sPmkKLeK4zD+m6uyDCcocWZqzt7B27
 08ihGFuMJD1lHGskJjOjVe2L64qhHNHN3Ni+mq0uktB1/jbglfvvH77wudKkgw56vf0e
 /h4QluiWbwWYGbBBkwQHaye2eGIIRr6eRuEFMfzexfScOsAqcFEFUOJixU4Gxdgqo2jE
 ubxOQa4NEfjBebQIj0JV9jkjzS9XGj7PqcPOuZnqg9MkombK+oe7Ekg79XFuNuLOZjqY
 VIOh1zi1gCDFRWFCpYfArT7M3INYA/UKZ9ntbqLjEcmQZKgPOY/c/zLb8gMzaU7kQkYt
 78HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741889; x=1778346689;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FIy4SnqLUGIEyitTzv2znL28AAqKREY6FCzUomgrBVM=;
 b=guJ0wuEHDtIvjCvV9PKy+As/L6dCmIOW1tXkokOMNFnnB1qyLqF08GI023Pu/KYZYW
 +wV07N5gS8pykam+gsQsiVU7KhnKjVfNvzIK+347tsRlGJroI7pkYSVGmClMvscFfdM0
 LYyRBmhrsXfiixDhHEmHFObjwRj8ejYo7mFbmCXn9AexyfhglrKAVJ7DuyBnZiHC6WzK
 pCiU2woCJ2OHajAyzftAuuS3pNC5g6N6i6LJQq830sw5wAtIfNECcGMmuj0hAgAVcTEo
 k8cA80h1UBv9nyweWvtNCAjoWTHE+rGI2kCZi6w2nNdIvRgRCTOanL5q4Tp71XIIiePR
 ZDlw==
X-Gm-Message-State: AOJu0Yy2pBXmGiXgOcO4PnI4qJytHmkHwRISWo7EUcbGeOCxJnFWKLAR
 vl3wKnGWm6Qa/Np74aFI/HZ4CHavBadWcJUjbTqaK4yOXnwtmxEJN4b9mlp+I5sVtRLkfyBzG/E
 liz0bvns=
X-Gm-Gg: AeBDiesGM/BYdiNSzntns/w06XaFXk+oPh7txZ7lLVTQvXNciDPvFxhSJmcdYWeRV5M
 mJmFwqDCIOLKvDSdhxLs9N5XQwcsEqk5YT4/SnSKS/Q+R+VI1V/LGc7eJC+ga+m++cljN235Snd
 QRnoRnmfkMOnRTKLO5/IsO35393F134Ktfb5xDISVcl5wsR6+hLgrsdRoQqT0O0I6U7VihPaIjI
 byK9XkafOJ4HGOV8i3TCvR9EfhmAm+Y+sjY/ZgncX35O4EEaJlbGT9JvA0BGc26TOb5/J2qvein
 WZKb0F1BymEFBPiZgdjnm24tYtFJFy9N2uwxJfrafni7BbLxbuwT8hMiBKROtiHs+zBK+qBiGSm
 DkWWIY31zGOK3pS6MSn1MSPQljQQYEyTWZB4fujHoPwuhlpxLQvPUG4xQeCNpI77d3c7Kw7DkkI
 jmLlXKXZJydpp4bMc+oM8t
X-Received: by 2002:a05:6830:4c04:b0:7d7:f623:680a with SMTP id
 46e09a7af769-7dee122059fmr2225779a34.2.1777741888839; 
 Sat, 02 May 2026 10:11:28 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:28 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:32 -0600
Subject: [PATCH v3 11/19] bsd-user: Add target_sockaddr and safe_ioctl to
 syscall_defs.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-11-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=xg/177J6QSN8YcD+cjog3d3ndgjHQvk6fuzDhXxQAcI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/Qp7OAee6qOUIGj6txSV20ontD+qBeWHBbZ
 xk8ryHJB2yJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYv0AAKCRBsHNEofbAR
 AEP3D/9NkGmLSwADME7uyjXzBvYCBJUWEWQgpKdCTxtKH39ixihgMJ56rUFALN2jCfZNug05XGy
 vGVlOjWgyLwfC3ElVLxjNEiz0p3kTv4rZmDn0ii99FxBha22kP+H5wsQwLUVi57psg+cCpClfyb
 8dXhmHSmNIfgkWm/qKWtC2+OSPpmwy/5OHJ4K0nqKH6iorfxjKNEfFJdbVCbqbcqOhvVB6fZmyf
 c31viqP5QM98EceNjpp2iobtsiMNywhjw7cXbXx0C0Z97Tj/aGyaj5N6lXj2b6RMBVP4+t3W07F
 T2tk5cyPaUsoBLxBwWOOPv0I6i68gDRTaZlkn5Ht0yiuE9UmIO44zE5LKLNq1TbqUTaP29hWb9J
 K7JUERniZaSe3dbtUJ7kMvkp3Ar0dEYyATtVHnDo0MgNiP9TC8PFG+Kzb9SaEx7l/Rn45JRHS4I
 Xz6exfiH+DZP52RSHDSir7QWeCyxZ2jIuYt3os8/xw+OYxiBq8l43NyUc9wAf70cv9V2IQq4NPy
 VLueX+68wZfarAtw9t0X0FAhXUW8RAbbtafd9MwBt7h3HGkaRw7a3NB2OOPtJaI8WT/3Qju3BQf
 rRq7uXdThqIetoMKVJi2+x1LR9X5o3nVPfsbPSUzujFudv0j9zLi9zvEFdqEBtmjQUf0XnHKDy7
 uub01KtrvmK1/Sg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x331.google.com
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

From: "Stacey D. Son" <sson@freebsd.org>

Add struct target_sockaddr and target_in_addr definitions for socket
address handling and safe_ioctl macro for safe ioctl system calls.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 4dbd90c2f1..34ea750bb2 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -565,6 +565,20 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
     return safe_syscall(SYS_##name, arg1, arg2, arg3, arg4, arg5, arg6); \
 }
 
+/*
+ * sys/socket.h
+ */
+struct target_sockaddr {
+    uint8_t sa_len;
+    uint8_t sa_family;
+    uint8_t sa_data[14];
+} QEMU_PACKED;
+
+struct target_in_addr {
+    uint32_t s_addr; /* big endian */
+};
+
+#define safe_ioctl(...) safe_syscall(SYS_ioctl, __VA_ARGS__)
 #define safe_fcntl(...) safe_syscall(SYS_fcntl, __VA_ARGS__)
 
 /* So far all target and host bitmasks are the same */

-- 
2.52.0


