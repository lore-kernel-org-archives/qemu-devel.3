Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B456CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LqA-0006Mh-Aj; Wed, 24 Sep 2025 05:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpX-0005wF-TS
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpO-000562-VM
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TF+uRkbdU4sqmkTEUKCHp2+nyTo8mJw1hvaCWSytbjg=;
 b=PbPrcXTxjKmXx/Sq3kF1yVfRWUlz2+ZlOwlNBDb2Ol0faoRuIt2FAhOySCnSQjXW/7oBBq
 ideowLHc6tdv03usr2ZvCgo5IeEskDm0u/E7Lv1jlfuxbCmUha+sqYIm4vpYlLBnmfw+rO
 IB2VoQ8vy9sNX1WljXKudM+mNhmszBY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-u21SsSdRM_u8nr29JppqZw-1; Wed, 24 Sep 2025 05:30:18 -0400
X-MC-Unique: u21SsSdRM_u8nr29JppqZw-1
X-Mimecast-MFC-AGG-ID: u21SsSdRM_u8nr29JppqZw_1758706217
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b311b7aa78fso136822366b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706217; x=1759311017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TF+uRkbdU4sqmkTEUKCHp2+nyTo8mJw1hvaCWSytbjg=;
 b=FKJf+sR/c47bPCCT6SWEa6+Pkso3ZnZXogECzpBjK1HaqWCPV37t0VGxwzltPDxqGA
 dFnLPzlSUhz2r9j0MEhIuefwpoyBMRbbzeAOiwkDQnvO4hjL0Vafup+Q9o43nRt+7Yse
 wwk+S/bFPKc7FdVhrt/z+xjLgLD5Roy8t2IlYV6GQX8IiduXyvOHbI1nZRcoDTM01DHd
 b5GN2MoHliCM4Cx5yhminh6BDx4lPoEUm+x8TpDuRYiTVO+XH9eGAA68F1GCGmwiWtOo
 jso3TDs/yd915cR7xyYPiHbQTxK9utI1Rk/zNulOu54ZBeCOCXKhy0wh8bNyOr31HwjC
 9tYg==
X-Gm-Message-State: AOJu0YxDZn6OeaQblOhum1cbWuJgZ5ijpReGcgFyeWz49NaHYUj9Y7BN
 p1hHYY1HnJXft/LIlBDOeRf4yksEkJ6XP+91Nq6OC4TDaiHL2BAa3HVy/GdmOtpR5wO0Oe8yG4U
 ScPCf8C167AJBbCzSXucLJxbDqgsesmw1IpbH3XJ8Jg+Xtm07BsPXNqF28xTl0yrj7MIAkJNrww
 TTJye4s1/KpqZbmYEeFRWzS7RyyHnAy6tN0FrYbN5p
X-Gm-Gg: ASbGncvTvBvZGtn3GstXDM1t9Ki59jxGqc+j2Pokqwu2AoaG+hIKqQVJHhesrE8QVLb
 zf7S+3WJmLothiVnKrJ9uNry3IdnIplLZey9YRa2xAdepwIxqTIPDko9RKOwmIXFyMFc71EAVha
 d7cEueZf7lPIJtuszZXU1gbVA1Xnmwb6ZWdPbV89wQns/OBHConacCCCOFl5bU2HcjSic2I/uu5
 7C0eetxJsgtYlkc7+DlHtIGImhqWdadjKC52l49kfmMCyX1gHTQ5y/d4qqxLpOcWAvY+UffEWL2
 xXz/LDJCT2yqxUpax087q19c+jpxxI2vvYWv6yNrMg7dhIO+eyJ2isRISYiH1f9P7+5Y3sI/KMW
 yYVfGVlwSaqeyY09aC781swwBUnMnMbVzLcCDe6Z+FnIT+Q==
X-Received: by 2002:a17:907:3f2a:b0:b32:b055:949a with SMTP id
 a640c23a62f3a-b32b0559c0emr209611166b.33.1758706216622; 
 Wed, 24 Sep 2025 02:30:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnhaSUFNJb9H7tB3abHwb6xuv5TRziTs6lTGe9LpUqrw86umi8ccwvv138ZeOgw9sLGCVT8g==
X-Received: by 2002:a17:907:3f2a:b0:b32:b055:949a with SMTP id
 a640c23a62f3a-b32b0559c0emr209608066b.33.1758706216152; 
 Wed, 24 Sep 2025 02:30:16 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b26847ba016sm1136962266b.21.2025.09.24.02.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:30:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 29/29] docs/code-provenance: AI exceptions are in addition to
 DCO
Date: Wed, 24 Sep 2025 11:28:49 +0200
Message-ID: <20250924092850.42047-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Using phrasing from https://openinfra.org/legal/ai-policy (with just
"commit" replaced by "submission", because we do not submit changes
as commits but rather emails), clarify that the contributor remains
responsible for its copyright or license status.

[This is not my preferred phrasing.  I would prefer something lighter
like "the "Signed-off-by" label in the contribution gives the author
responsibility".  But for the sake of not reinventing the wheel I am
keeping the exact words from the OpenInfra policy.]

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/code-provenance.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index 6968d54be8a..8cdc56f6649 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -341,3 +341,9 @@ or more general revisions. This can be done by contacting the qemu-devel
 mailing list with details of a proposed tool, model, usage scenario, etc.
 that is beneficial to QEMU, while still mitigating issues around compliance
 with the DCO.  After discussion, any exception will be listed below.
+
+Exceptions do not remove the need for authors to comply with all other
+requirements for contribution.  In particular, the "Signed-off-by"
+label in a patch submission is a statement that the author takes
+responsibility for the entire contents of the patch, including any parts
+that were generated or assisted by AI tools or other tools.
-- 
2.51.0


