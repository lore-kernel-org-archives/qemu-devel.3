Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508D9C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riID3-0002SJ-Ke; Thu, 07 Mar 2024 13:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riID1-0002RV-Uk
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:11:11 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riICy-0004Rt-Q4
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:11:11 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51344bebe2fso21418e87.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 10:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709835067; x=1710439867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JeVw/zqoXIefq1k86hMLBghVqeIdQrvH247p0frdwQw=;
 b=xUZ3rC9KI/jRlXyuhj3uRmFfSnmJ9XjvWZN7xp38mXH7M3dKWzgQvdpWgpqBnB1gWZ
 nOMhzHDd+XmJbwYiszlmzP1b3kIfx3vhknqGSSpRagjEtbIBC8Cl1wJD6lN2RUs/7J6T
 JFdSB2RUE2pGHQUZAbSOQExLqXVQPdWaj4PiRzVHmSUF/ppYts8kLSMZzBiqG1/xyysH
 u352s9OWD0PpLDCl4AJLUAijHrh9q/g9JPBM9XupR9KN6Jn4pQJha7muJPPyFAuxQJld
 1msBTCi8Xp2tVXRwGU0Xor+Q4/IACEo3Ldvc+FHEm5YurSNw5Vd5RFQ1IzRrxA2ldwPT
 oJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709835067; x=1710439867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JeVw/zqoXIefq1k86hMLBghVqeIdQrvH247p0frdwQw=;
 b=qZv9w18R4r2Z3F1xClxS6ZdX4rK6wIHn3R7bsvJJJ3KQGVPOMm47/cDUE5GZCp4lg0
 I/4Z0EgVLQV4XzTzm60z21ziKJlASqqyht4d6owgKyUF/aQAq03UnJu+rrCAuG3f1tIj
 YZrbHPFVEZeKKreWjzO30/U9jES/qc93HESsuSHlikwoSoWPkmBB+RoRvm3TgHTNObKK
 Tspmi4diluUg6SQvqzBi2qIf13jP1fOQRyRdbs+CmwKssyq8cp/SlffHXCkJRvNr1Zvm
 ShO0UI2QSzjDZysawHomKVcC/h27ZRV9q1/+CvYbDKTowFKc75NmYXXgwVpos5XUBse4
 JbFA==
X-Gm-Message-State: AOJu0Yza6a4CxyeapYdixxfhVr21HghS6AUKUlGQW1cn2lgtA7FppFLz
 f1etWPbZJVKsRc+F/2lfp3vKClY6NVNpVhTsCPqPsOCUpUYVRY6LibgGGxVx87M=
X-Google-Smtp-Source: AGHT+IFO4SXNbKkk+s6cFENZdIxVeb3NIyqVKcHSRfL2EUa3EDydr0w1w6P5RCJwC1Ddx7zugPOxzA==
X-Received: by 2002:a19:9104:0:b0:513:1aa4:a374 with SMTP id
 t4-20020a199104000000b005131aa4a374mr1913064lfd.2.1709835066857; 
 Thu, 07 Mar 2024 10:11:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l37-20020a05600c1d2500b0041315f221c7sm713272wms.16.2024.03.07.10.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 10:11:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B35F45F950;
 Thu,  7 Mar 2024 18:11:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 3/5] include/exec: remove warning_printed from MemoryRegion
Date: Thu,  7 Mar 2024 18:11:03 +0000
Message-Id: <20240307181105.4081793-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307181105.4081793-1-alex.bennee@linaro.org>
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since d197063fcf9 (memory: move unassigned_mem_ops to memory.c) this
field is unused.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/memory.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8626a355b31..17b741bc4f5 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -814,7 +814,6 @@ struct MemoryRegion {
     bool terminates;
     bool ram_device;
     bool enabled;
-    bool warning_printed; /* For reservations */
     uint8_t vga_logging_count;
     MemoryRegion *alias;
     hwaddr alias_offset;
-- 
2.39.2


