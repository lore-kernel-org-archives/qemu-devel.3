Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE295C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmq4i-0005C0-Qh; Wed, 20 Mar 2024 03:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rmq4d-0005Az-VA
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:09:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rmq4c-000737-Ga
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710918557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RN378LBciNz3SPfxHyk8OuNHw06Gmus29kjmKACDUxk=;
 b=IAIjY8EjPvx3dEMzskQMdDsrrg3ckq2fLadvZnFxKSwTzZ9UbB4bVO5NA/AHyU3q2YSHfr
 wHgbOejW7kabvw5rSw8ENFFHwsW8Z35A4Pwt6JjedoVLLePgAmCUM6s+xZuJtdslGUNtKO
 gK8NewYWRTkEkdUVd3OKpqSjrHXd4kA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-OPYziv4PPtKL-uE4IQGZHA-1; Wed, 20 Mar 2024 03:09:13 -0400
X-MC-Unique: OPYziv4PPtKL-uE4IQGZHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0441789F9E4;
 Wed, 20 Mar 2024 07:09:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AE023C20;
 Wed, 20 Mar 2024 07:09:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 96A801800DD6; Wed, 20 Mar 2024 08:08:51 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 1/5] roms/efi: clean up edk2 build config
Date: Wed, 20 Mar 2024 08:08:44 +0100
Message-ID: <20240320070851.18933-2-kraxel@redhat.com>
In-Reply-To: <20240320070851.18933-1-kraxel@redhat.com>
References: <20240320070851.18933-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Needed to avoid stale toolchain configurations breaking firmware builds.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20240314115307.628118-2-kraxel@redhat.com>
---
 roms/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/roms/Makefile b/roms/Makefile
index 8e5d8d26a9a0..edc234a0e886 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -187,6 +187,7 @@ clean:
 	rm -rf seabios/.config seabios/out seabios/builds
 	$(MAKE) -C ipxe/src veryclean
 	$(MAKE) -C edk2/BaseTools clean
+	rm -rf edk2/Conf/{.cache,BuildEnv.sh,build_rule.txt,target.txt,tools_def.txt}
 	$(MAKE) -C SLOF clean
 	rm -rf u-boot/build-e500
 	$(MAKE) -C u-boot-sam460ex distclean
-- 
2.44.0


