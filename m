Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7280BC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvOf-0008VD-Q7; Fri, 28 Aug 2026 08:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvON-0007d8-T5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvOJ-00044F-DY
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hBTzYeyo4SgGU/xJrI5LwyJUwLaUHE/ytbMaC0uFcT8=;
 b=R+fLlEpe39Qjl7zhBY9bwEFHwGWtdxFugdATnZttvl/c0FO6tN3jDa9kcH3mvyR5WqmtQc
 e+vod4jVdHqCwzIvYsPs8KdOmxo0F7NP/2O19ujI6l+WbwPPfDLsU0mFtAIwPIpHoLvgHD
 e10yzHaHWQ4seFoqN9Qp5MBhtXe0PMY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-HUl4rc6FPYGSc5XwrZLDUQ-1; Fri,
 28 Aug 2026 08:08:56 -0400
X-MC-Unique: HUl4rc6FPYGSc5XwrZLDUQ-1
X-Mimecast-MFC-AGG-ID: HUl4rc6FPYGSc5XwrZLDUQ_1787918935
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FB12195C278; Fri, 28 Aug 2026 12:08:55 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 620EA1803A51; Fri, 28 Aug 2026 12:08:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:47 +0400
Subject: [PATCH v5 50/50] gitlab: --disable-hmp in build-without-defaults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-50-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=728;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2hJRNuFpL3UjcDbWGaCvvWU8zkMvKeDbdR/uhwrLjHk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk6eH6Mw3OmfHcl4HcGhAYNXBReHlziuqLAP
 VTeqhNze+SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OgAKCRDa6OEJdZac
 5bOUD/4gGjoxCFBI1A1E1AN7JJdYOa9mJ7de9rMC0NdM78XDoaBQmgAydJuMBkbxFeI869QYpT6
 kkUSj6WyDz+befuJ70XbXyIN97wHFU2bw+ToqQO2rOPV7FhbhHGLMqz5XJxTj2Pkd2gGMiaMxeG
 kCoBjMRKYybApsSrceN3GXgaT8D40SQ15D0PvdBXQl4QL7qDNj7mCOwflsmTUBr2ctshtlR0nJ/
 w+eTGDXxDW64Dv2kT7VFrxLuyu7Py2eistagc2Dqq4GjYagYMXQoeM0L+syU47IxXk/WA1cmRvt
 0T0nwQPloGBZ6O/Ui5ENkOgrt5r8cKP+QyD/Mg7WH8nd6tuemi0VBlDj5vC4B6CrcS8HLSa/1qL
 0uOxXhWiHREIVtVSqtIQIBJEHr30SikjKXUdaok+XdkgS5BMxmLsKKYkMO6piDpZ6AxS3BQVBwx
 TqBVsqV1l8gL7K8QUCQZf7wL4o69wkkMrdkWXLJmrOEmk/iOn62FIJEx3c6oGTMkn+8NsHnJAz+
 rCRM2ND7cgld3agvtYGLmEzzpi1z455gDM8hlcr8ul/4jU4WLVmP+FeSLWe57YOACvwR/KfJ94q
 7x31EJXikKr9tpioOGv2ZyXScyYv1RcqDumkS2R/QBy7vJcsuzTbX6GPj0D3QdVw7G86UvCbe1m
 fe6r9SaIOoNM4Ew==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


