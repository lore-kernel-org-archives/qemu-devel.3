Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32A9E69E98
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 21:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIDzh-0001G0-RG; Mon, 02 Dec 2024 16:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIDze-0001DT-Jz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:30:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIDzc-0003Gl-Ja
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733175005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yg5hfoea7bahihKzgqKeUBe9X+4pt+gVla+E09mIQeQ=;
 b=iIllhCKbnfZa6cvcUPR50iNNrwlU3Ee/oRsJ1LMhS/4fM3e871FjZzbTLFBf48Pe1mSI1N
 MjF/YTPXLMkG2YmDjlaCE9Dna6LAFd28gZuCOHAlIGkrwzFx8ZAK+Q2Yxim/HHA3YK1IRV
 O5ai4P0BvEJjBFQCQ/fWE/1hybFYJAw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-CWzcdifNO3umcEWQMOrprA-1; Mon, 02 Dec 2024 16:30:03 -0500
X-MC-Unique: CWzcdifNO3umcEWQMOrprA-1
X-Mimecast-MFC-AGG-ID: CWzcdifNO3umcEWQMOrprA
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b66a5121efso588158985a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 13:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733175002; x=1733779802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yg5hfoea7bahihKzgqKeUBe9X+4pt+gVla+E09mIQeQ=;
 b=iLoIMoSSdLOzJTz8L+jABcLUJ6y7gFaxPCok0cfQcPS674oaxpBtujzIqROHEAmNGp
 0e5ec5U5EMp020P59aYDouxnTBKgACZIs+ZRix2ftw+QHDT7m4RDm8IkPcUYhnHNxmza
 F3YRx0Gy4+M7jcT6/r6F6u/E0AzV8PX/M/QZtGcCGrK9XH0b8GqDVxkxjGZuko/7NwpB
 f7cdT4PeL/ckm1MZMu1o4SyKeLFrcxf9pOXk1jCirr8WYzA106G+B8Q1dPZDhKUgZntK
 PW+1gm7zPj9hN3QEMxtPenr14lHGZ6bOlZmiPP/zW0lmfIopIO4lJzQLn9PT09ZA3iJF
 ccHw==
X-Gm-Message-State: AOJu0YzcSnvROnt6YY7SBgxdXL3EWghrNghXB8BXinXEvzXBx0jXmdnS
 zsWgVnspezQULhad5FCuXbVXNVM0oolia29oeF3b+gpcv/GMJDIk2WZIhfg2velTDzFEMWwzS9x
 /fuYEDhilM67hY9Rc/VzjRwLQJCpPMmo1FEpkbUQuI9c2Ax4beHHTS09FwQJSC+EOD2Ra2rHSuw
 2HcTX1O/XQYitM9AS2hJ+f1LskJ3Lmtw0nig==
X-Gm-Gg: ASbGnctCYFGMa4X6iVvscEBQLzPyzMzu4LUdHcNTe9kDKVsc4VhDQgH1OiFCZdnKl1i
 avzaoNS/nJ5UtMP09F7tFY9EFYTEY6spzbU9L4ZiRtYnA+vn1oK2Lt4Fn53xcRWRZ5l6D8u0R2A
 uL/31+10IR1ddgr+MJSMPDUX01Q/UuE1tDrtYCvfcMqSHCT9LC2e69uFRTUdlfoUcDW71agNYWT
 WAUHhi7ct9lKYD/rORMusqcTSnIMPNbDMyzukrnKIj1imI/TLxhjbLIpqdDWZvaEHfPn5HjOCf+
 ORddMf8vt8vJ6EE6OTnzbwcwfQ==
X-Received: by 2002:a05:620a:880f:b0:7b1:506f:7796 with SMTP id
 af79cd13be357-7b67c4c02femr3673285785a.47.1733175001720; 
 Mon, 02 Dec 2024 13:30:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgkwuadg6YxEQtvmy7AczRmFlQmFf6wbaAQ69Y5Laswz9Z4orvqMGlZ6IBx4eKzn4PvCBuSg==
X-Received: by 2002:a05:620a:880f:b0:7b1:506f:7796 with SMTP id
 af79cd13be357-7b67c4c02femr3673281685a.47.1733175001363; 
 Mon, 02 Dec 2024 13:30:01 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492c9b4sm445642785a.29.2024.12.02.13.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 13:30:00 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 peterx@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 1/1] migration: correct multifd receive thread name
Date: Mon,  2 Dec 2024 16:29:57 -0500
Message-ID: <20241202212957.570277-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202212957.570277-1-peterx@redhat.com>
References: <20241202212957.570277-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Prasad Pandit <pjp@fedoraproject.org>

Multifd receive threads run on the destination side.
Correct the thread name marco to indicate the same.

Fixes: e620b1e4770b ("migration: Put thread names together with macros")
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241127111528.167330-1-ppandit@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.h b/migration/migration.h
index 0956e9274b..3857905c0e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -37,7 +37,7 @@
 #define  MIGRATION_THREAD_SRC_TLS           "mig/src/tls"
 
 #define  MIGRATION_THREAD_DST_COLO          "mig/dst/colo"
-#define  MIGRATION_THREAD_DST_MULTIFD       "mig/src/recv_%d"
+#define  MIGRATION_THREAD_DST_MULTIFD       "mig/dst/recv_%d"
 #define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
 #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
 #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
-- 
2.47.0


