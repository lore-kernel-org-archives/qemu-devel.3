Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4495DE6F090
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3P2-00013l-69; Tue, 23 Dec 2025 09:30:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Oy-00011g-TF
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Ou-0003hZ-U2
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r3s0hCxig61OePmENRwDLet9KpUs1bicj/o3FmE0RZU=;
 b=WePxB67UUV7O37gCspaA3bsp1rUn0Tv9mBVglreVKPExJUb7oCKS8UDaqdeOr0qeG3Q+mF
 KNfmwDN3AzMk46UHQHmYVkUd1KiOnbf+HIlgIcGBNvE5IRNjZ/Qm5sSbVahEPT4IuwrehI
 VQ7ir8LRfXo5ywindcA7UgFLIEo69hM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-UlXRO9o_NjeDQfCmoOWSMg-1; Tue, 23 Dec 2025 09:30:11 -0500
X-MC-Unique: UlXRO9o_NjeDQfCmoOWSMg-1
X-Mimecast-MFC-AGG-ID: UlXRO9o_NjeDQfCmoOWSMg_1766500210
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b51db8ebd9so1570948385a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500210; x=1767105010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3s0hCxig61OePmENRwDLet9KpUs1bicj/o3FmE0RZU=;
 b=kh/Op9hDc7vzdf53Fit7JoOaPOSMLlWYYLRdv9Q/cMkj2LzYneKMDEAjkiKWSRi0tL
 bSTA/+eDUP0qDPu+Vjy5M4noJp8etT+qoVrtaZyURt69sxfnqwvbhzoPErLEAvHcqgMp
 Hl/dFZgIDP4MEIf2fpKTvi/vm9tDX81RzPqVVi535enNNQllJoGR3Appg8rAAadAuZP5
 Ad5MPHFImOvV/olTYpw5B7yDIdYZ+TUz4grrf05TnUKj1SAHbRjAlOF5D5lI5oh4yuKT
 KcT1g5wOFNpEVa4DdZnCVq487b2bFOM6ty1FC8xhHCjmrsFWHpsNMWiHxTO+xHpd5Ghb
 hoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500210; x=1767105010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r3s0hCxig61OePmENRwDLet9KpUs1bicj/o3FmE0RZU=;
 b=kb3bDTzvTludDDkselOAR4tmLucEcpUhDPmUQRcUpwVcC+YunT59OgnW7eJ+XIsjyv
 S9ImB2bAwQIXRBsUrp4RPVOLdz6hYqnQsFA9qxhh11dC9VdJOs7ljY53KyrKxWHaUD6A
 g48iMrP9eaMt4XHKsAlVzZYVpXLXZ2stLYvnvCwyH5nG5BgMgy4f27n+p/q1P40HCAPx
 cDM6uFIxAS8IK40VOKd64EYS2/8iQVn1mi6EkkrWvC3nxsmyP1sr01MawCZkMHckd1Js
 Ih9huqDM8oAK1PSFWfwxHLV+NsmNV2hS9zh4Dwwg37QJt5rjYupB/Bs9B6TDXTAkJaJC
 DPgw==
X-Gm-Message-State: AOJu0YxA6iG4gRYkGnuTlC1/0fgrezhZkjw6ghG9AG0GA0Je9l4thNqP
 yzfufk19LflVwre0zLU9ox2yo3howruje6/pCDV/vVZWK8NA/+qq2A/GSXYNKs6HQs/0zxudKUG
 RXByT2tl/4/pzNNeP3auTuX0GWXc5XUicDB9CEjpTCUa8gRbMAHz/sE8UEIG7HN9nbnv7KIq/V8
 KPTf6A/H6kdGWLBIF4eAuByhjFkDY6dCr1A82qCg==
X-Gm-Gg: AY/fxX7aUIe/gTRZQv7eQytFuI4/hJWnRXaYda4HDFYHcS9/5Rq+glMIlz663xfFakz
 PvsnWwuL6Q6+lU4iNJ0Emg7tLFgfs7zc5Dn8kXFu1059/3duydlxFql5AyHGIL0fYnSLqNImfRc
 MWXl6ESPZ9DQ6psFHyBIMdvRmU8NgFPYcDghM/aagbvfLGY5DBzSK9/N8jwzfJOu7zxB7lH6TAS
 WRK+jxVp6KOXWRBt6aFB2NWxLDUbnACHvDmot3B0v7IXCnM3SarpY63LCccjRED1Y9fbyUmIUmT
 XekgVO1B6tvkx+CkDzIkZxAeZ62IhjIDS53RTz1TMA+Eppc0xerD7NppAYUl2NSR0RFXdYEFqw4
 aQ44=
X-Received: by 2002:a05:620a:4626:b0:8b2:fa94:e48a with SMTP id
 af79cd13be357-8c08fa9c452mr2294549285a.52.1766500210029; 
 Tue, 23 Dec 2025 06:30:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1jy2Eef/D8eLeGwgklqhf2osnaXpbMQsgbqwKkx1IctJIWEe7h2UzvbjpidNOuzmebAXJ4w==
X-Received: by 2002:a05:620a:4626:b0:8b2:fa94:e48a with SMTP id
 af79cd13be357-8c08fa9c452mr2294539785a.52.1766500209375; 
 Tue, 23 Dec 2025 06:30:09 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:08 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Markus Armbruster <armbru@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PULL 06/31] Revert "error: define g_autoptr() cleanup function for
 the Error type"
Date: Tue, 23 Dec 2025 09:29:34 -0500
Message-ID: <20251223142959.1460293-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/r/20251201194510.1121221-3-peterx@redhat.com
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


