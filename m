Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183CDC54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4c-0006CV-C4; Wed, 21 May 2025 18:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4a-0006BG-R6
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:04 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4V-0005bG-MQ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:02 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2321c38a948so49245875ad.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867077; x=1748471877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGfL+RzDQIDa37K5e41+zNPdkMKsax67ftvf0bDSf/s=;
 b=Oc34g3CFDvCQelWrlYLP1eshp4wrnnKdatghqQCJgqPYEilQqEf8flT5R44ebHf6Vc
 MhZhijcNoDca0z3nvvr1wBDi3qbFA0gtzlAXB41gKQn+z9BZ+MQTHO2T9W5Z3fdjryA3
 CVR7L6z7JTAefVisHT0QOfi+EwghvxhLf03j5863+xrbtnJ9Ui3lYOJTVu2puHUNy6wX
 P4zCfU+xidtDpjFJXIh3LypVKVX3NZqBtwLNdrpxVTiAcC450Vc6tFaA49+BQSbzoV9O
 X0+UE0rZFrmEajlKj1k5KFlbDH12bNgFxF41f8zaO3qda4Mb+d9gz8EtTFzmV5Bm5mOh
 POUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867077; x=1748471877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGfL+RzDQIDa37K5e41+zNPdkMKsax67ftvf0bDSf/s=;
 b=ZTfG7kxVbC9WtjCmx8c9LQ91ivMu9vk2wYGpP7+ce2lMydKpLa1sOREb87QbhDGJ/W
 UaXtSdlAWW64wcFyCBaUdA0b4dzUm8iZ+ypMuZEbxmnxLv7HPRD1WM5ww6Q2yKVb3TVj
 shXIupCAyHIxpq5fAq9kBUA0b84n8leIVsDyu6LyKzrV9GipivSGhO0oJ0fuWDHFotbr
 J//C1wHPOC9wAvu+tL+rNnegzxH8TnSBc6zV+Bt3BrrdYNfDwHVai2HPjW5cko1fao7m
 L3jYsLpxx97MrsT0R05wXs/CcG2xxGpu87IDaj8CmBbmrcYSCy2HBvFxI9QuCYQQcv9U
 cAMQ==
X-Gm-Message-State: AOJu0YzBm8ALV4KNHTyyewZA+3F4NAgYVYQuahD5y1MW7GXmSfnuraqt
 pF2yUmPQ1dNUNvenOckGFB0ypQ2rF/67jQb+HwTERhDve7NHXxjepk0xiTlTtEusA6d2tLzerdZ
 NTPTs
X-Gm-Gg: ASbGncsvWlJWsphxxMd6k+8cuvujqBAPzo1b/0uO8+vWVSmW8YNJjWfZ4EpqNXJ1qCM
 JTLRAPVvAybXRQWXfQixgka89lbAoeXUBn5hhEaFlZTFgoWwOBiXkk4ofvkGgkvWr3Xm36xQU13
 Ur/qem7paVEefGCCDlzLrQHsJFnHAEdhiY0HdtU8L8kZb2+cc7KmNC7SCFELgnrV2iPSOZuy/8K
 vp8/PpPb6Sk6wSkAK3JksTErX6fvYs8SWO/ZdAucVi08ib1xGDJmly3hAsUzlaoRtOW6zYkVpQ5
 NmMZZsHmDBylqyLYaxuEBpdzOAk4PhhdBnw25MMl9sR1L3Hogwo=
X-Google-Smtp-Source: AGHT+IGzkPbslC4Jwk09jLeeH2EXbZaK0lTTPQzMpyRZ+bkXbBBymgmpb3qU8IkOhI13A4iB6r2zCA==
X-Received: by 2002:a17:902:ef4e:b0:231:cec7:465a with SMTP id
 d9443c01a7336-231de36b432mr264912415ad.20.1747867076989; 
 Wed, 21 May 2025 15:37:56 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com
Subject: [PATCH v3 13/14] qapi/misc-i386: s/field will be set/field is set/
Date: Wed, 21 May 2025 15:37:39 -0700
Message-ID: <20250521223740.249720-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As requested by Markus:
> I'd prefer "field is set".

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-i386.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 3fda7a20bdd..6f79817e382 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -129,7 +129,7 @@
 # Return information about SEV/SEV-ES/SEV-SNP.
 #
 # If unavailable due to an incompatible configuration the
-# returned @enabled field will be set to 'false' and the
+# returned @enabled field is set to 'false' and the
 # state of all other fields is undefined.
 #
 # Returns: @SevInfo
-- 
2.47.2


