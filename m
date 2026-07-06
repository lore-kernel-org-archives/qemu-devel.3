Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947DFC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgiqE-0005uN-IN; Mon, 06 Jul 2026 08:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wgipz-0005qq-Dn
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 08:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wgipy-0007zF-2F
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 08:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783342453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnMduQI4JzxWh7DFwl+Ge03blT1Jvh4bKa8/9Kbe0yI=;
 b=TkDujxIZSTGhvI3Usrfv/T4z1Va8Lmtc4fxFdI6PWi6o6bn/WIOaQSgA/PR+CF+KQ+URm/
 zgzg8cAe45GIe3vkx12BvbTQzAUKGn6Hs+KHfFpLYO5EA7rCpadePxhAYgkGAl8P+qihiL
 vX0XeO5fDcMGZGUrhE2BhynKnaCQMLo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-jJdAaHZJPySxLGTV_LBjCQ-1; Mon,
 06 Jul 2026 08:54:12 -0400
X-MC-Unique: jJdAaHZJPySxLGTV_LBjCQ-1
X-Mimecast-MFC-AGG-ID: jJdAaHZJPySxLGTV_LBjCQ_1783342451
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3072118052F9; Mon,  6 Jul 2026 12:54:11 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1169836512; Mon,  6 Jul 2026 12:54:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 06 Jul 2026 16:53:48 +0400
Subject: [PATCH 1/5] i386/tdx: fix uninitialized variable warning in
 tdx_check_features
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix-v1-1-4b83a70e9f3b@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
In-Reply-To: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=902;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Kjaz1rel2sNl+d5VT2IglyjxLokjkl6yFaJ2/HKSzoY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqS6VnYhFFHkp+YuIdTnf12RCW5HTzJn2F8kIu0
 UerFQ6AQPeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakulZwAKCRDa6OEJdZac
 5XD3EACUpaHxCQl9UJsJGOh2BXvqFVl6jDj38+2BJRXkR90lAoyWnP1ovKmRtnOQM3/7mDXAaod
 lsJS4vGb1Y7Y8xF2l7IyfOmaVedA35VA2nggnoDwJVbJzALyvcDBtHuBvIpcs6Hd1vJl+6fANUi
 IDU1ovdjpHn39BlS4M5VjucnumTy5pfC2UZz1mi+sAy9Oijr31OX7bIB/7N28/AEdMBpjacFid/
 YmLaA5Sch7P2AZzy3muspPSf4919k2nPABU4xvM3Fr5nKnYX7wa3GSf4SrpnOyGxTzHELAmqf0O
 ltlqDrdo/XevIXh1TkIAZzfhNVMiQDBVkWqo7e0ZqQnbs4a3G2gnch3hNrnfZtYi19KGOI6/tpG
 BLNxvvIqWtGlMlOXoPx+3lNrb/Bjy9wsuHg/GGnlvXzp/LUzcKw7HffIuBKT/8N/x71Bdw96Zzb
 LwzSZgvZj5B39lsb+TYPdoptEJJ02B2+rg/BCa0MAGPLags8qN5DVK/QexYoRw88ybl2o98MT78
 Wc/kK8GdmX0DNnE9CqnXdDNZcSApCz6Fo8aHV7FNb6yf29dHecnd+dp2fMjKu6ZM+iLkH6dqPr/
 kLko9KTWZnCGFN0RDMNeYRuxE3NoivcSlE5vKRAkkvu+hbYvnz7Npb19dwPdGFgWT6FyY9+kdjA
 Yi9b0qmwuvYoyww==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

tdx_fetch_cpuid() only sets the output ret parameter on the error
path. GCC cannot prove that r is always initialized before use in
the caller, triggering -Werror=maybe-uninitialized.

Initialize r to -1 to silence the warning.

Fixes: 228e40f33048 ("i386/tdx: Fetch and validate CPUID of TD guest")
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 target/i386/kvm/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index c9c3b05d5fe..8294dbde3aa 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -887,7 +887,7 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
     FeatureWordInfo *wi;
     FeatureWord w;
     bool mismatch = false;
-    int r;
+    int r = -1;
 
     fetch_cpuid = tdx_fetch_cpuid(cs, &r);
     if (!fetch_cpuid) {

-- 
2.55.0


