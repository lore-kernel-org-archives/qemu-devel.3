Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608D4C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh87-0003fB-33; Fri, 17 Jul 2026 07:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh85-0003ev-FB
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh7y-0003OK-TM
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQ0kpNbqQmh7Rqy8oHbfrgrmT4Ki1WOkGKlW/sPYSzQ=;
 b=b9Ce6NNX98cpp3LTieudE9PzzneMY10RYHmV8kl5L8aeZ3yMtl6hr9IuhNO9+7qSz+Ahc+
 DuZxg+IlChFsl/KXNqKhchAzdcXRikBRhZtgRGDj3ypoS1HNv7QdaSsb/cb5vUYf0Ol5ng
 PFAzU1+3WsZg+lnN5oNblFqNnyqLzkg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-xGXoTz6MM7igQ4H5Vn7IRA-1; Fri,
 17 Jul 2026 07:53:10 -0400
X-MC-Unique: xGXoTz6MM7igQ4H5Vn7IRA-1
X-Mimecast-MFC-AGG-ID: xGXoTz6MM7igQ4H5Vn7IRA_1784289189
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34D91180074E
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:09 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 030FA1955D86
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:40 +0400
Subject: [GIT PULL 01/15] i386/tdx: fix uninitialized variable warning in
 tdx_check_features
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-1-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=966;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=R6iO6NRN+7wwybY73JE3CJcD1P+wCpJvUpV059G3hA0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheZpW9xU8L78nAtghp79F2IABJZFO1GRFzpM
 G1UyvxB2YGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmQAKCRDa6OEJdZac
 5auKD/0eyQ3FeHOxEVOXXc2IxeSu3BfcD/Pa0dAZ3GDbUqUeAxfy/rC/JkTCd1myPNmcSv6UlZt
 E+/qEHG9Dyblb6hgafgFrqBKh25jHm/z/xQ0bP0/uI3hBJIIi2/kB+QnWqbUkQOpAGprsPQp7oD
 DrClKG52YlAKyplZFe+qQbJY423fGG5zDG0BwWgShAPOITcwDKFqFT7HaDc1OJJSy7+k0eJxnrz
 O8DkplhkOBds0x9A8mgP5mdnGkftTv1TJCd0gfLVmdHA0kScEyiXvi55QgE7FpMLV/xFQwR6UNo
 Aholi5GTyjZM74SU33KkGNdmw/BBaCLPq8tPWEo7LW9BpnrqQoHjPBFJ/BrQbdxxbN+G/7t+v9V
 xETNSkC0RkaubRTd/kMlZQ1UbC+Ow3SxAetrYILhqi0grJBr3w8DbqFeqI2kJczjdKeqth8cokY
 YopYxvbUZnX1TMvkSMIexyhvVWoNanW33LUhGkqOIYnSXibYam8hcvwCMKna8X5Ek6J/ZOfQVK6
 xHh6Cmz/zpDJLSV2pMq50bFDj2y8UvFYc/jF3Iz6TAdHGcuCswnKmyf63cCXn2N8HgncuYfygUi
 lDjDC+yB5aKLnGsKWhzq+XydY7BW/Gwlh+K6aYAkRkEkdF+p5mK8MITOMKclj7UXTcrulCT+tLO
 OC9dxXGnzz1wPcg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


