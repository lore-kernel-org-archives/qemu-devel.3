Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71D6C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywaM-0004iS-1O; Tue, 25 Aug 2026 15:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywaJ-0004SU-2X
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywaG-0004bQ-QQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAFwmbIv/8Iz1PvzfVdH8TCC2X8FuwRSRiP92lMbPeE=;
 b=gs4NzuIjvtqbIgzsbXeTxI3h+Rh3MvG5LwPe84fcQ6PSdMalE7UI5xD48gbjir+bvesMxI
 TUHYCL1O2ck/2nq3ab60O20ITO6x4Wj/ok81drJf83XFfU2bC3HZjFimPqjsbO8jkOxB0j
 ib2ro3xwBj8eDx2u00ksH1ZRdxSSIP0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-SbUMpSz3Mtuc_-v47zVIhA-1; Tue,
 25 Aug 2026 15:13:18 -0400
X-MC-Unique: SbUMpSz3Mtuc_-v47zVIhA-1
X-Mimecast-MFC-AGG-ID: SbUMpSz3Mtuc_-v47zVIhA_1787685197
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBA9D18C1067; Tue, 25 Aug 2026 19:13:16 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23FDF18005B4; Tue, 25 Aug 2026 19:13:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:56 +0400
Subject: [PATCH v4 49/49] gitlab: --disable-hmp in build-without-defaults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-49-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=664;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2PfBfGSrrAVwhOfSkL4rieqVo4dBCVB2xaPbnEs7CSI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiID6zGtV1rO2ksPWC737V9d9qlxEtQC7DJb
 iGlTibu/AuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3oiAAKCRDa6OEJdZac
 5W+cEACY1gB5UA4WuuEAXON28T+ZnEC2kHwUBDiYB0hINUKq12auycmMI0Fwv/1rxCh3kQAev+q
 TFlNYeYyzAaxGJZEXzh/1L3x7pYK9nZH55Bh7vDtu63kvzNBlVA6AD1rvxFd/gXb1Xu7DeX0ihX
 isPapYZnrdEO/DFaGkyYtelzfJbuB74CxXlq6/u7gFt5+WftBRXwifhFFpDKlzPgHwjWjg35tI/
 YvEyBBlszkIZEOOSEBgFzgRl/EsSUP/QHOWmLE94PVLpHwWZaXp+aT2ul33VPtX8Uhxub6DSRJ4
 jEVK02s2B+cGiClqdjJ5g7JkAyMOMHOy7M8LcXx9WpRYtEXvnx7ucIEcr68FuV4MLFAeF/xe1p2
 Qc61GkZCkK91d8QffiyoC0eOzzNTBVrPew2xo40Ul/HlhBS/k6v7gusREitxKXDc3oqV59DAbuR
 g108N/RQjcdJDOYD3QCRM34Hhu/khh+2meWGROpaUr3IwjZrG3MWt4H7bwz5TQmTARh/dbAy0gw
 0Q9e6uZFVM7w0/0nlDuOQDDIDB6ERWQie1ZduS4FVB6HHurrV07x8oZDn1eH2ioswGkYWRhvV/U
 EIKJ7XvnSVu0aObEsupBlTLllgpRj8qZqR0skTiERM+LUQv9qglU0kGSy5ClNQQtWG8lHG+cX9l
 uxtMf2p24kPP8Ww==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 831d9a267425..5f21703645b3 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -673,6 +673,7 @@ build-without-defaults:
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
+      --disable-hmp
       --target-list-exclude=aarch64-softmmu,mips64-softmmu,mipsel-softmmu,ppc64-softmmu,sh4el-softmmu,xtensa-softmmu,x86_64-softmmu
     MAKE_CHECK_ARGS: check
 

-- 
2.55.0.543.g5ebe2ebe4ea8


