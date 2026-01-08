Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711ABD232C7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 23:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdz3h-0007WL-29; Thu, 08 Jan 2026 18:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vdz3d-0007Sx-RY
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 18:04:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vdz3c-0003Yx-8Q
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 18:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767913483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/wOYTEAvtiSe9YSYoR3MVQ33obg2WZXnCauUYIHGp4U=;
 b=gY+1E11oSv3h8dJvnj6Jd64P1aEpcjNjMfJQuok1b0Ig9/rNLMzuS7tI6cre953HBydYBi
 uF3ZacSojDkFtnPvhXUmnPwQNUCqHb6LXbj1Z8A2YPQqjYzeViuq0tqPRrcNpYFG9dSSQI
 2pdyDKVvSAIm82gDfrwNGr92nJNsx5c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-1KTWGnOvPbaKNrS7DrnMDA-1; Thu, 08 Jan 2026 18:04:36 -0500
X-MC-Unique: 1KTWGnOvPbaKNrS7DrnMDA-1
X-Mimecast-MFC-AGG-ID: 1KTWGnOvPbaKNrS7DrnMDA_1767913468
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b2e2342803so930039285a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 15:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767913468; x=1768518268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wOYTEAvtiSe9YSYoR3MVQ33obg2WZXnCauUYIHGp4U=;
 b=hjubA3Biu2FlH2/vl2FltFKsgrNZr40d95r0lZsPk0MrS35B3Gvb9DkBpH6ig6uXcn
 /JM0eVoXgOP8KLtdZO7YgEwWE3hKu3DHqQSm1Pm1I+Y9TCcCsyJunG2I+ReYxbX0IIfJ
 Dr1OAe6SmSTieSqUnNZgt3ID5yGb1RSlK8xT6sDIzdC/0260Ypeedh6wnO4P/aLs1XOM
 xrkjpKnCPAVsztEk5Ond32yNQRcIgB7jgDWhy4SG5V6O9p+4X+kHlLmaGP80S2aggb0C
 t+1nP/JokZcdDoIH7wELLpdDCo+ABLqUi2jJ6TTUJb9rPpUWKbon5bGh2IPmR+ehBcw4
 9Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767913468; x=1768518268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/wOYTEAvtiSe9YSYoR3MVQ33obg2WZXnCauUYIHGp4U=;
 b=M2RDIDqzYrC8lNd78jzRG0iUn4VyY00U5K+JP9/zxWuPQrTONbTO78KYRV85AtEQ+x
 wXmsEgDPOXN+qtp7KOCatV+mGf8j7Gui3y84hwlh2jFBkOWsiBR9h26fH8qGgK9l/y++
 UsdBChd/wloA46kGLeg0/gIF+5cusO8HsXY2rTPsfopaYeW2vpdbQOpDM/bSxzHwuMDI
 0Jf3SyPITv6WmpW7+2yX+pGt5dy4T9w4b9a1mFn7xGpUpwi64U8LOjYpwrZK9vr40KK7
 1e/ajoC466+iNOUW5hVfjFqCDmgYucgSVfOfGJqVW/Wfl/o4R/2GFAOOPfPJcsj+SIR5
 wNIQ==
X-Gm-Message-State: AOJu0Yz8YBOzWryMPVR1Wz0O4IO9P0HVYOYH4RH8TURcfE7TRLE2BcOO
 KNxLbZ3q9oB2d4qeIzwOwyJxF1EC9BfYEd0/AFnyFEsAZP9VhFadGrOsr14nFM0Y8Gf4Qadgzvi
 6ObBK1pqzCr0JvCvzS57SFwHluExao/2pSl3qpAE4kfiF9XZWEXTamYQr5T9sbYxGybUDmb+ZW3
 sn1mBmEp+OXwKypUnnOiD6tAEoZDU2qgfc7jybfuY=
X-Gm-Gg: AY/fxX5NoohE+KmVZN/Pi0Mmu8a1bllJfQ4kB+cS/q28s9K14X4EUP7fZIgQW5oBSdv
 Avo/xrs486lf21AD6y/2DUjP2yJlhihYtGvHTKnLjwKhyu/j0Ji6N6mua4IJ/oRjfOU3LbtGsq8
 WKjwwuDM0+g39afU/YLh42r8bDbqe++Y9TLlC5TDu4YSa8hYd91k8XULME7rggOgiiPWONm5/AE
 UUFI/MQmnCTm2AgNTdZZAKfa32+udhzt81HjYqUW59E3o/II7o5+OwPG3ZkgVJb6LCYxMF4x2ea
 PULXinpdYexd+hR6UNfZCKW2F+GOLTmeVi0M1R/ps9Qv80fEUi3qJhKOmSv2N/VvE0sWRNtXgoN
 5DvjrAIJpJt0Q/0kqs9l0++7f/95ty9r6YBriWgw=
X-Received: by 2002:a05:620a:f0f:b0:863:42ea:d687 with SMTP id
 af79cd13be357-8c38940c2c5mr1046482185a.78.1767913468055; 
 Thu, 08 Jan 2026 15:04:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqRc9bLVLIFbSWb6p7UQfcE+awwIUOeB9+iC0MWv1rMECa22+q5Bz2rlOOLczN5k4v1uS69g==
X-Received: by 2002:a05:620a:f0f:b0:863:42ea:d687 with SMTP id
 af79cd13be357-8c38940c2c5mr1046477585a.78.1767913467561; 
 Thu, 08 Jan 2026 15:04:27 -0800 (PST)
Received: from csomani-thinkpadp1gen7.rmtusca.csb ([47.153.136.179])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f51b787sm680000685a.29.2026.01.08.15.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 15:04:27 -0800 (PST)
From: Chandan Somani <csomani@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 4/5] qdev: make release_tpm() idempotent
Date: Thu,  8 Jan 2026 15:03:10 -0800
Message-ID: <20260108230311.584141-5-csomani@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260108230311.584141-1-csomani@redhat.com>
References: <20260108230311.584141-1-csomani@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=csomani@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

So it can eventually be called multiple times safely.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-Id: <20250429140306.190384-4-marcandre.lureau@redhat.com>
---
 backends/tpm/tpm_util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index a64e156f45..264bff22a9 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -72,6 +72,7 @@ static void release_tpm(Object *obj, const char *name, void *opaque)
 
     if (*be) {
         tpm_backend_reset(*be);
+        *be = NULL;
     }
 }
 
-- 
2.51.1


