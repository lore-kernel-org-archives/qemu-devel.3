Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1087510F286F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Ehj-0003Sl-IS; Fri, 27 Mar 2026 17:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Ehh-0003Ro-VF
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Ehg-0003hx-H4
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=87D9hfkXTy21U107ad64fZEaWnZ7Kh+l8r3zoihxcCE=;
 b=Arm2faUwO8NNJo6LZW9wryF23Ri0+M6bLkM9GfCRLhJOHtIdII/S9QPRzLbzgH7eWSkKug
 xlA6FdCoq1Z5PPq2KHp8iGnoEKau35WSAncLav09TPVUdoDdUg1lztTG6B9MucXfrToGZl
 mDYWN05R7fkLvGKwHZEbk32pJ5t6/4o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-NmCMyRGAN02RHgvTfHylDg-1; Fri, 27 Mar 2026 17:26:50 -0400
X-MC-Unique: NmCMyRGAN02RHgvTfHylDg-1
X-Mimecast-MFC-AGG-ID: NmCMyRGAN02RHgvTfHylDg_1774646809
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4852cf0318dso26741375e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646807; x=1775251607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87D9hfkXTy21U107ad64fZEaWnZ7Kh+l8r3zoihxcCE=;
 b=iqSO6vqMLKiPVPCUwb9tYGLTKYWGC60SxmLj4CL6ouVsqO8lrkHKYc5Fjc4a4gjcWY
 GS84JArG9Hwy4eOudBqV00jbxlpGLtkIPhooDRyrd3kDebviy9U7hSoQXVVF2kS4OEsd
 Wn9mTDWgqik09PD0hz8Ek1q8HlLJyAcM7BF+p0lp0rnsIVvqkql16cxGMNih/4GSwQ/b
 IWq+VVALPayEnQUFAvaSSjPPYoxfZZ/GRGCICH/pGe8Yy7iVYtdKzzOerj7YiN7DlX04
 fTz35PNThzvyJ1C+PXQKvwu0bfV2O8hhh54yUpc1Ql5LXpnaGZcZd6EkmKFnBXauOHsz
 APDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646807; x=1775251607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=87D9hfkXTy21U107ad64fZEaWnZ7Kh+l8r3zoihxcCE=;
 b=bSMLYEPKR2GGelLS1XONC+IKIh4J81g+Z6D3Y5FV3hFG0lMN/BCe9LVIzuTmiMfFN0
 rx/W6Pszk7AXng3WxK2ew1cKEholr1AMl4NLw/N/lrYZR4kKzWkohWX8cQveVfrQpdyn
 SVNOZpSHUqPKwwp72R80QpzWVEW7p2B60v/1OqcI/ZqOfa+pxf4xBCSs2/U0tMepEHCf
 v9aQepAfIEaPFLrwW0hV8PLl5vWgalu6/pxtCPmtk92HM6smtV8/0Z/X6q/6SSElilyx
 ZYkASbPMHSn+3GNAJ/GqLWEKikziUL9S3bTDoBhCuJ55LeRQXudsw3QVQc3uccxcu+Y3
 PT5Q==
X-Gm-Message-State: AOJu0Yx1nJ9JSvjERZbbFBXe2rbsWjG0iuzUVNLM4ET2Wr6pn6x+vwKk
 i+2xv/VTqz3CDrTmw82pzF0Ck7PHikhGBJJNE/H/p7Im2TQvSOcfZzUHKrh2PQ41xXOFBI5JutI
 Nx9fciQL+CGQ4Bqu4FudYunEtaELhmX2kDE+mpcWcSq3Jlj/fffeSgeRsIyJRqno45Fs/mJVfCE
 Clb1Qc7bV4/+oQKAaeAF6n6tN9HUFDIbyQj6vAbN3d
X-Gm-Gg: ATEYQzwrrYE29ORf2TVYqKH+61djeRw2HYuL0wXWpBt4CgTA1FgosVY4XKlpNLTfZD/
 aZRKO3WwJe/91/75KsreB6L6QEyk/ozJKyRLxSGrcOlGLiEnvtAYTZ+9a6uqJRH4B+zsGNobMTH
 7klgRHfH+G8qXFYCaKnuDf4HYyKzabZqX2puRsDc4G1LyyWaXVk6tLI8iRIgRukDCQGZbFMzsxO
 rYteJUGXcjUKBoztr4MzIOOWi5UzIaEFs28jD1TGBt4lFGD00HSj6vHW2UtyyFQ5oA8bZK9Df5d
 VplxCHa01r4kgdNg6d8KaSX69VeiMMKDkvExaQ6GLOxdROzazxYA3LJxv7D2tNJLJ0Hdfrx6FPg
 I5meYTeUKYSDOM9PSZk1LONEDUzr8LYSmSVQJytJzGSdBdDa66AUMzRLQ8557TYx/dXNcPZ826s
 zpIUDT/YQeLEIblCFgYHL/VpSS
X-Received: by 2002:a05:600c:c87:b0:486:f308:94ec with SMTP id
 5b1f17b1804b1-48727edf6eemr68427105e9.24.1774646807108; 
 Fri, 27 Mar 2026 14:26:47 -0700 (PDT)
X-Received: by 2002:a05:600c:c87:b0:486:f308:94ec with SMTP id
 5b1f17b1804b1-48727edf6eemr68426855e9.24.1774646806609; 
 Fri, 27 Mar 2026 14:26:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4873061f44csm8893305e9.1.2026.03.27.14.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:26:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 09/16] ncr710: reuse ncr710_clear_pending_irq in
 ncr10_do_command
Date: Fri, 27 Mar 2026 22:25:40 +0100
Message-ID: <20260327212547.460420-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327212547.460420-1-pbonzini@redhat.com>
References: <20260327212547.460420-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 9832d833b37..7503d791205 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -928,10 +928,7 @@ static void ncr710_do_command(NCR710State *s)
         return;
     }
 
-    if (s->current) {
-        ncr710_request_free(s, s->current);
-        s->current = NULL;
-    }
+    ncr710_clear_pending_irq(s);
 
     s->current = g_new0(NCR710Request, 1);
     s->current->tag = s->select_tag;
-- 
2.53.0


