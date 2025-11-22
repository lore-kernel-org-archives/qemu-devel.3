Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA51CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMckT-0001AG-87; Fri, 21 Nov 2025 20:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTQ-0006bv-SX
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTF-0003eZ-FX
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zP1UWP2hrKh6gHFJKbP+xwMm3Oogaln/YNFdJGManXk=;
 b=Lp4iUbDG/+FwDeFC897sfsbpgvV5h7704A8IkYfhMxzB6/LwsE28nlpJCvKrbNXiqQlTQA
 kQl0D9xOCUclRfzT7GOZXi4CDKxSDChp3ZOOl/vCntmAI8Lz+qS6lD4q2Tk//W0l2XxSCX
 7FpXCr2ePKSxOID3+aa7tRNbwjmIO/8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-gPn_B8rCNPSftKvQ_gAVXw-1; Fri, 21 Nov 2025 19:27:05 -0500
X-MC-Unique: gPn_B8rCNPSftKvQ_gAVXw-1
X-Mimecast-MFC-AGG-ID: gPn_B8rCNPSftKvQ_gAVXw_1763771225
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2e2342803so761248885a.3
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763771224; x=1764376024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zP1UWP2hrKh6gHFJKbP+xwMm3Oogaln/YNFdJGManXk=;
 b=IKnDhYvJJIA+//9ajgTO+5ctFntrtieJnGyl04UbhZWP98b9ShtuooExVq6pDtQEd3
 3ag8g7A8kzpUfU+1wCiidKtwEQCjSu1ShXWHRCPXdARNWcfqwdtOJGZcE3yjrebsOkeB
 6dR+OaZoWqpDr6meUUu5Px4nAWjrDyTUUbsQvFT6nbH0aBGJZIIjTR3k5jow5INbpgYP
 KCH162dFAgd0IEeOPVZ1XYnazi2edWcv/9T+kZS4ApVxldv667PatyoU+e3h2tCTf+bc
 0XSP60Huu4CLAqOJcg/v1uvfgjINtB7OFhA4mkGovHGpFFUhRpWKw3MgFhK5MlNqnuDl
 SIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771224; x=1764376024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zP1UWP2hrKh6gHFJKbP+xwMm3Oogaln/YNFdJGManXk=;
 b=oyKAGFVEy8udyh+guQ1wBXt247qCqN7D6t4FfW6WEYxmtVJw0a0upJrL+6R2pdtAMM
 tMhOlTaJ6PMHMBtTY8mFcA2ue0sgousna8VND2sr6XWGH1ehdWRZAGRT30AGc9MTjupS
 Lx04MZHilV++0MB5Pom/Ulo0v0hGQ2rCZ72rSsKA4NWMkz422GhGwPqUJ6MgPIknQcpL
 CH/QPnJ5DQtL0r2srA2e/FXzmdX0WZACNCETi56VD4PQPjqY/wl1XILS/k6Pd0Xt4Sh1
 AsV5+PJY5/vPWQ2ZA92Vz034LA2UfPa1okNznPAnCg0M5vEbq/blPgDTFV7uvoxY20Bl
 E9hQ==
X-Gm-Message-State: AOJu0YwcXopeEBYAnfBRHryqyOtl+mDQ+7vr8MZDINct5wO5aRY6vg2Q
 rEBcqtAsN2YyIAFiM6n0X0/RgmhyXR1dsh8Nz4orG/cIHnClwr4UoaEB59x1NiwrwrjdMGsbo3/
 pEkcAI4WEUHdYHNxV78IOplxkBtlveu3Qp/RssiSk9fh8fiTp8s2AmPHQg0/aEVqA3HTWnkaV+g
 8fNaDm1f+yku95b84cN+DbaisAZet6LbT62mWQhA==
X-Gm-Gg: ASbGncu3T6dWZ2B+1nreAXp+V4RJqUOkC7yrvvogcICNuEq/rIkpt619k0xJCXtCkkS
 dQ+6MFi8ZDv1d/u3irkmvfR50N8eI79K+S2YNcGB0liUXR7e+ZrpahM5T/ZQRV20AXSuajs1v/e
 vKCYWeSGuLZEta4Jo4yn72U9xLtplYFr7C3R31g6BIjOzTUIJKHbhYKCf8ntA5xQb2m6ytev6kA
 wRk9ZLBZ+phbXomkmuKi/p0G2Sjm0InsW1RNflhwaIt+LUQKop+2Q61zUZB7ImSwTqqXuGRd3kQ
 kNm/kS1k7hp552Fgcu6DWsC3ymLvFibxCVXTUUHrHXq+VG3cjS3Fsi3QELCWGPfvbaVqG7A80Wc
 Y
X-Received: by 2002:a05:622a:89:b0:4ee:1f5b:73c3 with SMTP id
 d75a77b69052e-4ee588b5258mr63518061cf.60.1763771224335; 
 Fri, 21 Nov 2025 16:27:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsAHt94GT25KyIjV8tHCZ6e43lQ2/U0ANCQz+46OsfX/WiHUHGdENgtxvVqUtE+bY/FUKXjg==
X-Received: by 2002:a05:622a:89:b0:4ee:1f5b:73c3 with SMTP id
 d75a77b69052e-4ee588b5258mr63517621cf.60.1763771223722; 
 Fri, 21 Nov 2025 16:27:03 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e8df63sm43870291cf.30.2025.11.21.16.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 16:27:03 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 4/9] migration: Use warn_reportf_err() where appropriate
Date: Fri, 21 Nov 2025 19:26:50 -0500
Message-ID: <20251122002656.687350-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251122002656.687350-1-peterx@redhat.com>
References: <20251122002656.687350-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

From: Markus Armbruster <armbru@redhat.com>

Replace

    warn_report("...: %s", ..., error_get_pretty(err));

by

    warn_reportf_err(err, "...: ", ...);

Prior art: commit 5217f1887a8 (error: Use error_reportf_err() where
appropriate).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251115083500.2753895-3-armbru@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index a529c399e4..6210454838 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -464,8 +464,8 @@ static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)
          */
         migration_tls_channel_end(ioc, &local_err);
         if (local_err) {
-            warn_report("Failed to gracefully terminate TLS connection: %s",
-                        error_get_pretty(local_err));
+            warn_reportf_err(local_err,
+                        "Failed to gracefully terminate TLS connection: ");
         }
     }
 
-- 
2.50.1


