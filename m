Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A171CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LoY-0004jf-3b; Wed, 24 Sep 2025 05:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoW-0004iO-Ej
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoP-0004mh-D6
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQtQgz5paDlJPQB2PzlMqA4uvKzTZV/KR4MEWJ2j6p8=;
 b=IV4pwMCB0SKcIeQ/avuGIIQ+sbZ/r6Q+y6WQ1oHNyESbabA0lCydDw/6qZE8TpXBjRxqMb
 xNDM7Vb/bvCgyGPg/cmQ4vPscHWtCYLr7xN7tofiZ0y6bvNPIJbpviuRz9rf4Elc7yd0pj
 YU8SYS6PSfB6e1o5JUlT6UakJ/t9pMg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-fYuwfd_8PACXOPLLYLBflA-1; Wed, 24 Sep 2025 05:29:18 -0400
X-MC-Unique: fYuwfd_8PACXOPLLYLBflA-1
X-Mimecast-MFC-AGG-ID: fYuwfd_8PACXOPLLYLBflA_1758706157
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b07c2924d53so317575866b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706156; x=1759310956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQtQgz5paDlJPQB2PzlMqA4uvKzTZV/KR4MEWJ2j6p8=;
 b=wb1fiXtQ+szRGQW04XItvP2poM3KAMEeAm6FSJOi+Ra98OHm18V9tWgRVpJIuGHVFm
 Yy3Ex/g3zva/EYEDfmwZVnNYZpn9b407joGSSxt287kN3SMkiVVpG/vx+bFdkVawWyNX
 f6tM/6kOfjZeJanwSYD+St4EdZYCP4skqm4lTQRF+hTCZ9w7TvzuLqc18URRmQeTVomV
 gTDhjA9qLRsjDwCkI9WNdam8S6vA3p0GARScr8lIQIQ68zEIV5NEoPQfDv6eZsNr2vlM
 OXTpAc7WLq5H5b0Jp0WUXiOqtsKkn6KIEgKNSAtvX/TwNxJuMua5Zd4HegG/z3CHvq6G
 UDXQ==
X-Gm-Message-State: AOJu0YxR8nA1kPCPtwfiwEyq+yXTe7dA2H7ilUbkQ+8Dk1pr675hTiEE
 yCUMwV7Z+1yEtMpB5JU/3z8IBAgXktV7EyLcR7ohnQrwl6NM9q5EU1rcbQIHzuC1aA919GKjsy8
 5/kdJxAyqISv/EqkeCC5BIxM6gFGnnbit7yy+6wGGSzp3ii0lB3XfC9a4u16Lq0jBHDdYXK5PGG
 UoGzpXkSSOWfWNFqeVJnF5K8DhMEWlpxIr30p0t07V
X-Gm-Gg: ASbGncuC/2f+ua4yT1r6c88iEIXK2CZcSXl3RjLPI0bWQkvfrAIM8q1GNrs6qvonDbh
 Rf6gn65f3aX1KuqSwLm9jCeN/Gb3yiLLn6uy/r6r5WKKlcXPoiMJxTEDKFdgbvNPB94rx+vyVIi
 5NNJitX1yKqpFRpcerOxvm9TP6RyUn0sXXdHmGse7ZO6S5MLVMxpDjTnSbd4i4mhlG1+hnNd8od
 xEkI6Nsy9+H6a+0QaViFw34UbfuE8JcSpX9L0LFPc3IIFndzVHKmAp+yxWazdU1IOA2oeUxxxdU
 BCDo7zhgTiR3YMNRsIqnt2Jl3BC3dS1u9pIgnevqVbiGF2gm3HaR9iMvxja2gu1peWOr8J1eY+T
 A0vc/LLJVdV4/WJHREEfZzdgdA5jBekzFHSVP/2XYr1/26Q==
X-Received: by 2002:a17:907:3dab:b0:b2c:bf1e:2788 with SMTP id
 a640c23a62f3a-b302ac325acmr545950066b.39.1758706156144; 
 Wed, 24 Sep 2025 02:29:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUPph/8p4yfLKz9JGOSXuhkU3JFaptmlKllL6HwAJB2mvMlYDczB5flsfU+2ErEWuwnLjtJQ==
X-Received: by 2002:a17:907:3dab:b0:b2c:bf1e:2788 with SMTP id
 a640c23a62f3a-b302ac325acmr545948166b.39.1758706155728; 
 Wed, 24 Sep 2025 02:29:15 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b27d7eeafc7sm1054233966b.86.2025.09.24.02.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 07/29] subprojects: Update .gitignore for proc-macro2 and syn
Date: Wed, 24 Sep 2025 11:28:27 +0200
Message-ID: <20250924092850.42047-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20250920160520.3699591-2-zhao1.liu@intel.com
---
 subprojects/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 983c4c1549e..38e949640f6 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -17,7 +17,7 @@
 /libc-0.2.162
 /proc-macro-error-1.0.4
 /proc-macro-error-attr-1.0.4
-/proc-macro2-1.0.84
+/proc-macro2-1.0.95
 /quote-1.0.36
 /syn-2.0.66
 /unicode-ident-1.0.12
-- 
2.51.0


