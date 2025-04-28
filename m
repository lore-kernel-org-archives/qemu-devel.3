Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347FFC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9O5i-0000Yo-3N; Mon, 28 Apr 2025 09:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O54-0007uO-Uq
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:31 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O4y-00036y-K5
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:28 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac2c663a3daso935283866b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745845163; x=1746449963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U57KKXtG3p2E4GxRki+kejQJQkJUB7hPOj4McHyafgQ=;
 b=NASWo8/GBCe4GuKte1m6OOvxqxl2e73kO2fqArfE9jZ+LIzUoC7B+erYSOVJgpPUF9
 TzUao1LaWaITWZ4jjFHsF514WabiQ4Iq2KlvCa4m7vvUDcjZLrlwZTvaDWQ9LetIVwMp
 NadHDV6LztwnuPczSQpW1mCUjVPs+Ka+hnKmQkyyCXHgbIqSWFUbU2tvIDSp8qNFG1Ai
 mGwafPg2n6usoY9myUSRZJPPao1qYZ9zeYEiRTGNBO0NzFDgJGVn3+/N1R/tttUwUWtb
 zdllZI3DSBNJz8rcDHcdZORu14DPkTc3Sm/RinsW2vWZxk19Bd747LgI06bL78rMY+Sa
 53bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745845163; x=1746449963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U57KKXtG3p2E4GxRki+kejQJQkJUB7hPOj4McHyafgQ=;
 b=VNLjw2HLWuU7CeoX46E2nQENrQSa2SWOwrKfUTn9HViOTf0rt9oXKbK3+PAevnGyZt
 jDD2RSXDYUDJWKnrFTJrazCgMbdfxydadv33c0J57WKQ59y5t1AqH0KAjc935ThGrnj9
 47rOlL8xknoYOTKO+JZzU1vWJNKCIXKuoNacrxJCDWv9PLZ8qDDDMMOAwwnEncmX7NFj
 /9ymnOfYtpvOK+k+NX26jY6yd1mcHXiVAr4Q5SDlPMnIjK4rzaigvFsJh9uRMZNBOo09
 li1Acm9tnqiBmOyJsoyVFroQQQ3NbI5QzMU2gBZWACQTfSG7V6U76XPlEsIgFTTAfh3G
 OvNw==
X-Gm-Message-State: AOJu0Yw3xPK7rZvXuZvzMnJBdm5F8i8/CXVSFzuP3uN43N9YRcm8vGDG
 6JrIgNHshOE7QNvHEefomIxinZonhikMI7WxBhMoApdB61NyJZrKrQ8kmd/4Xzo=
X-Gm-Gg: ASbGncvp3hLSU9W2+ik2qLkqowal9XVuIZGmoDuXilNjuh0Maiy8GEhMZLNzGLsRvb2
 Flo8BcEnBaC/9olxpbtihWSGLQFrGR7rZsDjPsOrpRUVev2jvOW1Dw3abP/FXshfN9tzPkeFSrL
 T1rWhUVyvfofJziTy569wJ9nf5T2ugYJHlNaH24oS0JlACaizE855Yo8F39TEsKWDBuThCQ7bCQ
 FRKmnZBdf/FayMNfDScP2tppMvwPOGjV9kmF1HmQwI1n+F/TdgAFsMMPcT3QGOgnPPrwKPtY6vg
 Wr+FvvfWl1NDWhd22BJGdpokY5VF/d7hYNYuP2UlDPg=
X-Google-Smtp-Source: AGHT+IFc5jRZJP3HDBk8y2drDkR6BAF6FGwmR+FgwjTl/hYgZeI8xxnZuZqLi3ZtMKd8JlC3W3ovOw==
X-Received: by 2002:a17:907:97c9:b0:acb:b267:436b with SMTP id
 a640c23a62f3a-ace84938eeemr803926066b.25.1745845162835; 
 Mon, 28 Apr 2025 05:59:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f7011055f0sm5809746a12.15.2025.04.28.05.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 05:59:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C6DB65FAEE;
 Mon, 28 Apr 2025 13:59:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 6/9] MAINTAINERS: add myself to virtio-gpu for Odd Fixes
Date: Mon, 28 Apr 2025 13:59:15 +0100
Message-Id: <20250428125918.449346-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428125918.449346-1-alex.bennee@linaro.org>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Seeing as I've taken a few patches to here now I might as well put
myself forward to maintain virtio-gpu. I've marked it as Odd Fixes as
it's not my core focus. If someone with more GPU experience comes
forward we can always update again.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 661a47db5a..f67c8edcf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2636,7 +2636,8 @@ F: hw/display/ramfb*.c
 F: include/hw/display/ramfb.h
 
 virtio-gpu
-S: Orphan
+M: Alex Bennée <alex.bennee@linaro.org>
+M: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
-- 
2.39.5


