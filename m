Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853CBC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSMi-0004zx-Km; Thu, 16 Jan 2025 11:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSLG-0003d5-2a
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:34 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL4-0001Kf-P1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:31 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso7515455e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043400; x=1737648200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AlXy29NBIjMy0Rkry+U475eKhew1JRy9bb9HkntANSQ=;
 b=CZ7pBd/0UBbU+cZ+mQpm8uGv4guvLuI/Zw2ZQD43IEJ6Sb2BKPR2bYTJuIr/Kh8STH
 Kj9rFrkY1tFvjZ5dAwF5Iu9hM7Sb5NsWL4222+CiLsqAcntIWWh5YKPz4Wg9A6LNTAPO
 qCNFsvr+aQfCRlLb5aheBrdkdjCeIeTYJoOR1GzQ6BRS79ajT7QXW7kJ+OHT/3GbtKXW
 2pI8eRZUn9YD3iZt2bFNfaF3I5+OhNvlFqIaE8lTU8XeJFcKfgLSfrGjdio2r29qYGmS
 L8gkPWHOeJdrxY7vVkS3fKJkehIfVPCfdfNuSmqHRaleOlNll9hqEqLKH4+K6FSHOdwC
 jG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043400; x=1737648200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlXy29NBIjMy0Rkry+U475eKhew1JRy9bb9HkntANSQ=;
 b=SYyoioVek03+JOqgAsRCUeChB8gl+oI+EKa0pNOIYs6Q/xtov5h4v5dmJV5G8sLmk4
 Msh2MzLICslHDNCoP/yX/FaEvByKz+K8W5fZgSJemOEOuNbnjMvExIY8yI42hk4QFPqB
 xlYosyhGCYwmEcFFbj9YDfa/UM0T3O3G4YeMosxhEDCIGcVPMPQqRDWvkvWm4Oo4PXdp
 qy/MZ1A+2vQ9fpyUERW/3ImtTnsjkA09ckN1lwAa3RwaTUA42wOT2iwkzaNFzlTgUNRD
 QjqUFJ9w6CXBc2lZ76+xc7hlMiRlV5CPCbsyUqYKiCfVbh2j9Fg1A5OWIyi1X+Rso+5y
 sfpw==
X-Gm-Message-State: AOJu0YyHTrNXKRXYeMYrw9n6I58EcLt+EDOh7L2D2jjTA/cVMh5HEjFl
 ZBVirG7D27nMueJSE6000pWKY96bxHF8BXMCoYyLlW/7+3s0Xw6s1tcpeVvzSD8=
X-Gm-Gg: ASbGncsGNje1lntFyy6wqvA9qm//iV3RDuWVjfaidoBcsAKewJZkfCAhv+wJUoWxeWn
 qZ91kvYStonUdLc034z/TpIr7L+SA10qOFH7ZcRcqi0a19WG9p0Ks8dnoX4hQSVLhb6Y8diCCVc
 Aeu+yIPJqr+wqP96FyCj+4WJukXAJkQ63ayXA+5AT4jAuThI+Q9PzIDNJZYu9ZkG8NllAF/cAyT
 SxEspv87hZ/U1fFHRvrDIZsDtv63R2VPlW42BJ9kL6UQJQr2eLU7BU=
X-Google-Smtp-Source: AGHT+IH/1IKTyCh5O/9SMnJJXCO4Ki5YE8E89cFjAvs1PgDasIBTaQiQMQlFTzuOsDLEwv/pKHrNPg==
X-Received: by 2002:a5d:6d05:0:b0:38b:d9a3:6cff with SMTP id
 ffacd0b85a97d-38bd9a36e6cmr20309143f8f.16.1737043399699; 
 Thu, 16 Jan 2025 08:03:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322b337sm220980f8f.59.2025.01.16.08.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:17 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6B833608E1;
 Thu, 16 Jan 2025 16:03:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 30/37] include/exec: remove warning_printed from
 MemoryRegion
Date: Thu, 16 Jan 2025 16:02:59 +0000
Message-Id: <20250116160306.1709518-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Since d197063fcf9 (memory: move unassigned_mem_ops to memory.c) this
field is unused.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 605687befa..3ee1901b52 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -784,7 +784,6 @@ struct MemoryRegion {
     bool terminates;
     bool ram_device;
     bool enabled;
-    bool warning_printed; /* For reservations */
     uint8_t vga_logging_count;
     MemoryRegion *alias;
     hwaddr alias_offset;
-- 
2.39.5


