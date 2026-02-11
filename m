Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9EBEB5954
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 10:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq73L-0000o2-UL; Wed, 11 Feb 2026 05:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq73K-0000nh-Pl
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:02:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq73J-0002yz-Eg
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770804152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bCE+VZTz5It258nq9w0WusiflQQw95GaaujpmY/YYas=;
 b=PlnphqcNHa7gVmV7zVnPDk6mWKGIUP5DucJnEqC8w4p3PwD8iCqkCuWtOeR+YVeUCI9IDz
 HsOtKWP+0JldsilrQOL/QqnQfcp2mSHb6Vap8nawq2TLHKvc4NS4d+L72e0vVzMohkl8lH
 1Bj3RCVcwGfBjYJO3sUZBro+3T2IBWU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-he83vMY1O_KVF82gXH6lcg-1; Wed,
 11 Feb 2026 05:02:28 -0500
X-MC-Unique: he83vMY1O_KVF82gXH6lcg-1
X-Mimecast-MFC-AGG-ID: he83vMY1O_KVF82gXH6lcg_1770804147
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3D28180061C; Wed, 11 Feb 2026 10:02:27 +0000 (UTC)
Received: from localhost (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CD441800464; Wed, 11 Feb 2026 10:02:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Feb 2026 14:01:43 +0400
Subject: [PATCH 3/7] scripts/vendor.py: add pycotap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260211-cleanups-v1-3-e63c96572389@redhat.com>
References: <20260211-cleanups-v1-0-e63c96572389@redhat.com>
In-Reply-To: <20260211-cleanups-v1-0-e63c96572389@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=785;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mSIJ56gztgL4aLvsGgDJgkDadMkPayvNWGtYB8wJsPA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpjFOUROQL1yl27Xroe+yTsYwQNc5QiMx3n2SN/
 AyggMEK6Q+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaYxTlAAKCRDa6OEJdZac
 5cooD/4kojBhNjms6iRlKnC15X97zaEZvkw3zGd4M2r4bXgExemb3isQii3qCI3H7OBCdThzO6U
 d793VzxsUezJsJCEbq/oEtT8Ackthm7McT9HG4WeJ0b7aQGii+bM0ERxHRamROgjjFqYSBS5tBc
 tfTHhdqAg7uPhqTSgTYH9TPgKglTWHuLLjK3CRs4EecZQa21m0z4ZN6qxkAIKWBbw/xFPtq59y4
 rDqkf/IKMXxL/btSWqCYQO4lxHHv7+8Igs5kTuM/CvriS45+1SNCwTMeEnzX3z+jq7WlC8P3mbC
 76RAdZPDEUS2V8y+nZ7VdFTurnkRVDdssGenxXjhXRPqyA01PEFi2jpm/RRSia0NikwfrDrkNEZ
 MdZORMXWbPgNnvNGeGvMu3Fv0rYPHL6K+j+XhTNEjVdfy1QiJm9o92d7VAHRyzuD+Et1ATfMVHa
 5VDh3jRLbrL9lOD2g6C9HMzpJ+xSx9BUrASL0X1lb41DZcWhHd3VnQ+BBpPcC8QlLnRm2Kc93OL
 PXjS1dq2JaDa/XFDshhQN4To0pzpXEe1rbOh3qkbR/d/QUWtD7v9nSIy65urBdIvDp2WTvgrWRV
 JN4Ra/OsfpAKSDw5Tq3LQQ8pN+6J53HvmXTrWKXXgIt7M+Kjo52iJKwBioRIe3r/gPVKGPfXMji
 DLoZW4r7EvfbiDw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Related to commit 5ec1eec11000ef118b2a87c330245ffaa475f5ee ("python:
Install pycotap in our venv if necessary")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 python/scripts/vendor.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
index 33b9b0b92b7..9a7175d3cc4 100755
--- a/python/scripts/vendor.py
+++ b/python/scripts/vendor.py
@@ -43,6 +43,8 @@ def main() -> int:
     packages = {
         "meson==1.10.0":
         "4b27aafce281e652dcb437b28007457411245d975c48b5db3a797d3e93ae1585",
+        "pycotap==1.3.1":
+        "1c3a25b3ff89e48f4e00f1f71dbbc1642b4f65c65d416524d07e73492fff25ea",
     }
 
     vendor_dir = Path(__file__, "..", "..", "wheels").resolve()

-- 
2.52.0


