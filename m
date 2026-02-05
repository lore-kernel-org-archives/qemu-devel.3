Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC70DECD994
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38A-0004R4-74; Thu, 05 Feb 2026 12:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37x-0004OL-P6
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:51 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37v-0001OI-1k
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:49 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-40866608701so638657fac.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312405; x=1770917205;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4W3vEcV2gGf1RYn8FMyWdaS9C8j7Azjo7JTDY8euHo8=;
 b=nWRPEacrHxDof0xN5IZWPYv7j00B4ZwpzgF97y58b1ESt7d25VU4SGDdQookblD0dg
 Okyg8wNlgcmNNXhjWgem8KQdrtz1kfxWHfoxYU+QDirvQR3Yb1Zm7VBGp6Ueqng6TSh5
 iQbw9DUsNjqnO9UkTQQU0d0aoPA7UF8OXML0pdW590dwX2KRTWdnKuLvND5XV9RveZsY
 RMny3Ln5EiOXgxNpUfvn7ElE69+HpQe2wxehjr5VkhFXIzilIv5Et0AVvJPtXBH1d4+j
 cnl+5qxqXq5kA5DCpU49WP/LuShwDHhZixkMvVyEvxJG8bKIL8mG+deTJFAXs/JFxDwP
 +szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312405; x=1770917205;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4W3vEcV2gGf1RYn8FMyWdaS9C8j7Azjo7JTDY8euHo8=;
 b=Vkh87NeWEvwP2WGLmYXlgtJQ6ua5rajNFbG+SZMMjun35yyJL54xo2U5gvJCEq0HwR
 /e5Sg1tBUhfVsPvkr72Z5adUETCKfXE7ygnkcTLXGXZQCHG3P5rTdmA83raPslxgzmLA
 o/g4Dc2C5k3CG/f/z7x7hChB6cwxNPJMRThoKhaVPTmOfoiWq8dnSd4tXH7XnzHA/qKx
 TcI2si3HewVWoKUpxqupcAxCp+OPDmAdkh6JNR5HCYx28r7iJAjjEVJq5X7YTMmlNyAr
 unh+rxeOnYd9L7/SUW/L62UZMEpBiMkzleCNh51+ZY4AIxtooROUKF75l/mbdBFMIEzF
 rBNA==
X-Gm-Message-State: AOJu0Yxx8zwn1O2j3FEtfRZseI85isuos4AC0dboENnzLtHW0ZJJhfR/
 Mzdinl8aVCQFvuUYp8fZbfZPuFmouVbSvMaEkAx0KemmpuwAojMXDZkdUDnTdOCMwCM=
X-Gm-Gg: AZuq6aKTbSJwyzblbT4F9sUNNd6xZYO+QkmZv5O3pyrRsMTgFrOH4CVAB0+7eqr7ctx
 qa6Fli11Dci2GDKxRZ451Brzxf3HqCjo9fLQzTqvvlwbUFgCEDtwDvNmLMDdgUVjsdwuz8xWfHq
 onWaOLZTFbwLqWxbweuVDqmY6kjCgtmWp4BlKhsYgerFLt+7HsVBTOoPKMmNUcFQvKhcP1GWjkZ
 VLhjo7qitSKyzB+rHvCgD6zECMOyoqd/HfzRStb2ms3WLkIDxTaOm9Vx8moqt7lxlWBkSELTWR5
 wSTzNJu5tPzKtzRrGiZSal5rFFzqeso5ELk7zRzziXFFXQOYoN3TP3iB0bGRBA0HFxX8lBpmeBT
 0eygwt6zw1JzsSPpiY9/DqpBc9m08mA+8RZhxhCvEIH577oqS3JmcxoSXDQ+ixBdKp61Y28DC0Q
 ==
X-Received: by 2002:a05:6870:b629:b0:40a:62f3:54a4 with SMTP id
 586e51a60fabf-40a96d8cc9emr12448fac.17.1770312405175; 
 Thu, 05 Feb 2026 09:26:45 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:44 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:38 -0700
Subject: [PATCH 05/24] bsd-user: Add function declarations for bsd-misc.c
 conversions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-5-8d8ff0035372@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=t2kgZ2QiLl6S/YQ1n2plgCuueWaLeW+jDUnRnr/rR2o=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLaaOiTolzouq3wG+MZLkEp3DVWi0uptKgL1
 2LvtrpCvs2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2gAKCRBsHNEofbAR
 AEfsEACdb2jpqH6UxtCz3MPZEc7eAnRcy5AvqpA/wom5k3gs7eAIcFoohR9t8x4qXUdSot3D6Y8
 xsXl+BDXV/BYIBIFeR1QENvARDHTsfjlEZX2XHa0dSDPrd97c9sFOM5/OfSZefNsAO4orW8SV6s
 Wlqg1S8b6GGXvYVg5kTSzyXAoidg7ZEm5iv6lry/W/aXtiF6xTTjJjne/UYTjPJ0U6Md8SLPyBS
 kpRJPqtwcmXny07/Yo97Ff6U313uFGjy+IrBvAJt4ZGsmq23tSCioJysYphhDDwMIbwR/C+LI/S
 h1FHf1NzLSZuS18psigCWLh3A9B43Sr+lqIxsZfFd4kYN/eHfDxbMX8aUUaTIornqF+uq04dwso
 bFYZ1DHz6BgKgCdI2f5dE58s/5cKDsFeHuQRaRv1MS/MqB7F2AXyHlGnTLI9lkErwnnniXfJMlE
 HmJgN/zyOyHkJGONK4s4z3CDJdVGSMlWrq4fNJdrIiPJDbaRzoczTJQzGRPSIxbOOwaBW0Q210l
 63713MjNq1YuStdev8R6S9dK5V68arjit0PNIUI9UGO8mrMV4oIauxWgB9brNMsDDvw6o0ah5ao
 1zGKroHtXZ3vJxKOIzc9OJQga7YxipB3nQADsUO8LtZ5FHP4ZFYoW7Z6FNQ4mhizCKa54ZXSxHQ
 IXO3nEzT9lgAbUQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2a;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2a.google.com
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

Add function declarations for BSD System V IPC and UUID conversion
routines that will be implemented in bsd-misc.c.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu-bsd.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index 56affcd31d..b98d1d76b2 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -54,4 +54,19 @@ abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
 abi_long host_to_target_shmid_ds(abi_ulong target_addr,
         struct shmid_ds *host_sd);
 
+/* bsd-misc.c */
+abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid);
+abi_long target_to_host_semarray(int semid, unsigned short **host_array,
+        abi_ulong target_addr);
+abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
+        unsigned short **host_array);
+abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
+        abi_ulong target_addr);
+abi_long host_to_target_semid_ds(abi_ulong target_addr,
+        struct semid_ds *host_sd);
+abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
+        abi_ulong target_addr);
+abi_long host_to_target_msqid_ds(abi_ulong target_addr,
+        struct msqid_ds *host_md);
+
 #endif /* QEMU_BSD_H */

-- 
2.52.0


