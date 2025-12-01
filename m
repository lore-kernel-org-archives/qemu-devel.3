Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13894D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 19:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ9pv-0000mj-8N; Mon, 01 Dec 2025 14:45:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9pu-0000mB-7T
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9ps-0005Ht-B9
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764618323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rin2rU4dC98DtaDQogrP6C7tNI/p40r0Mt6FMofBulA=;
 b=KltfA1ROv9giXExlEkMf6eOUDxhqUKrqy1fB2GjH3IKzemWS5wF5LThXNJ+J3iecbHRSrv
 xBcgTQrmTmIJppKB5l3Av0Ba3lJQ2ZHaJHEkNU3uJdnOMDg/Z6sw7C4+XmFKg+MGXgNAUA
 qE1IoRRlSqX5T8cNstJtCYYoEeDYJgw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-oWWW4btUPiOS-YOsJviVCw-1; Mon, 01 Dec 2025 14:45:19 -0500
X-MC-Unique: oWWW4btUPiOS-YOsJviVCw-1
X-Mimecast-MFC-AGG-ID: oWWW4btUPiOS-YOsJviVCw_1764618318
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-880441e0f93so105734196d6.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 11:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764618318; x=1765223118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rin2rU4dC98DtaDQogrP6C7tNI/p40r0Mt6FMofBulA=;
 b=KuKAf9LmZZYNrfNMmfAZxnzl5gHS2n6Rd4EWFQfIbEiuNNivU63ojyAOQ/IZL8xDZo
 FwhedCshxtzQ8Y39MY+v+Sbi4rr599QPoE9ktBrRrIPrpi1xeEEvuOe+Oozh4BfCBOPQ
 8OjRhZQkG8nqlSQvszSTcsgNu6DIgFDHLYeI56OBo2LWKX9iwrHPozsWgU9ci98Ox1Fi
 KSZAGJaX0Hagu4gxz9kVe7N3LrL8egOIK81JYF6dCfTxxO7sXukhhNuSJCNTjVecTV8Z
 m3Qr89rNXSUvvB3vI+8coQPsKf1HK4bZgEHd1pFNpHdEjO+SBqh8sQz0vGrWwkBIOOUK
 /7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764618318; x=1765223118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rin2rU4dC98DtaDQogrP6C7tNI/p40r0Mt6FMofBulA=;
 b=qVyxjHORt+EDNqs4m/JvXOZXGG6L7HujQgYo5HWBBd3Vp11vYAcFd7RreiY0kXm9L1
 e8MhudgPYqxKVEYNEkpHEZ7rsEdRoPDPiSqIedWmAuGZQvwP6rCrfOZyKKdzo7gl1Rn3
 vTEqbO19qngGhcC3TgvVFK3ClSGR6Ht6zWst3TGeuODgn/bBsaHdZpttuQqmMO19IdyJ
 U0Rh5XnpXBT1V9WdSWvL6h0Rhn1U+ZYOgaAT+jE3S7BE0ajBJiYL8pe2DbLBlBwuMAOn
 rPnBzKW/gKGZXIVUbpnNvheU7OSx4vlLV+yBFBgM6/985OnaFS1+YjWqC4BWrhMcN1Zw
 PeFA==
X-Gm-Message-State: AOJu0Yzk6etssIg1BXyhR85+vu0YrAZJJMkHd5BPewXa1ParlxmViMCL
 i215fgaE6yNomJGLhV5nj5n8REFe0ySqTVE5jbHl3PbQgCWLZ+Z/7MzXj8g+pfOygnoQJHO2i67
 bRTma/FcCFZvgm5px6tlStSBfEyoR/RDa7cgvGiNG3uxdBbTMXzH34DfiyAjqehff+74izkgbAL
 DEg9cO4YLAhLlT4hcpt4rg+iy1hPF20LlM0yK3EQ==
X-Gm-Gg: ASbGncsXW8yU4qpADPDaYBZ5QJB+YUYBppkBcdf/IACLJ7bh9w4+BsLTUnRVcBG/nFW
 sTdFxedUPBkU0PXwcxEBoxEjDd5kFhNJr+96Ge6VhDldfTQg8rF+hDy5ijfnN1ihEqp+glPH/3a
 Q1GSTCkhrJghIsahdjflqPeT2C0FuwWoxuO29WBB1z3BTDM1kRXbcGQtNRHBi4oUJ2kM19I6Ivd
 UI1iLVatq6Al5pjltdSidvFG4fsN1fSz8ZVkR5MCFYomTtjnCMaIXTHKimGJbkoNXnT7mc5MiL8
 NmopDyczxGesCiiEVfgNIiT+4rVpd/ekGMmvLkt7S/rwpz5otbXVXQWo+clcSrJAo7u+2sFkj4S
 y
X-Received: by 2002:ad4:5bac:0:b0:884:70ed:5414 with SMTP id
 6a1803df08f44-8847c4c4cddmr698510876d6.17.1764618317838; 
 Mon, 01 Dec 2025 11:45:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDbAnBuXEt5XeXasvQ/SIHw2VShp5BR8MI3xjXFA79rZiyRHMn2fFil/FDumIl2LjcYfMxRw==
X-Received: by 2002:ad4:5bac:0:b0:884:70ed:5414 with SMTP id
 6a1803df08f44-8847c4c4cddmr698509626d6.17.1764618317190; 
 Mon, 01 Dec 2025 11:45:17 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b91ba3sm88835156d6.53.2025.12.01.11.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 11:45:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH for-11.0 v2 2/7] Revert "error: define g_autoptr() cleanup
 function for the Error type"
Date: Mon,  1 Dec 2025 14:45:05 -0500
Message-ID: <20251201194510.1121221-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201194510.1121221-1-peterx@redhat.com>
References: <20251201194510.1121221-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

This reverts commit 18eb55546a54e443d94a4c49286348176ad4b00a.

Due to the nature of how Error should be used (normally ownership will be
passed over to Error APIs, like error_report_err), auto-free functions may
be error prone on its own.  The auto cleanup function was merged without
proper review as pointed out by Dan and Markus:

https://lore.kernel.org/r/aSWSLMi6ZhTCS_p2@redhat.com

Cc: Cédric Le Goater <clg@redhat.com>
Acked-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qapi/error.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index b16c6303f8..f3ce4a4a2d 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -437,8 +437,6 @@ Error *error_copy(const Error *err);
  */
 void error_free(Error *err);
 
-G_DEFINE_AUTOPTR_CLEANUP_FUNC(Error, error_free)
-
 /*
  * Convenience function to assert that *@errp is set, then silently free it.
  */
-- 
2.50.1


