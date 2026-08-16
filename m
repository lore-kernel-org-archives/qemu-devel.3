Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994FEC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgLH-00018T-2V; Sun, 16 Aug 2026 15:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgL6-0000io-8p
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgL3-00006g-Lk
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAFwmbIv/8Iz1PvzfVdH8TCC2X8FuwRSRiP92lMbPeE=;
 b=h6unS1499TH9XzAtJmTFDnzfsxm5ZLu1nYDJ3hly7eyNCbaRJdmvu8PtsV18a8ciPPbvJK
 inx7u+Xoc8lxnjgUt01onJguyBmILjhckj3kLGyP3sRsU2ibsXPmZPTG+crf5apah+iRsw
 +m6ML7PxPJCGDArGdaiVln9Re9+itd4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-UqelhnB7MxOdD1yXVfcE_g-1; Sun,
 16 Aug 2026 15:16:05 -0400
X-MC-Unique: UqelhnB7MxOdD1yXVfcE_g-1
X-Mimecast-MFC-AGG-ID: UqelhnB7MxOdD1yXVfcE_g_1786907764
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 968761956089; Sun, 16 Aug 2026 19:16:04 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C94C218005BB; Sun, 16 Aug 2026 19:16:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:13:16 +0400
Subject: [PATCH v3 49/49] gitlab: --disable-hmp in build-without-defaults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-49-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=664;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2PfBfGSrrAVwhOfSkL4rieqVo4dBCVB2xaPbnEs7CSI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqggu1xDxrrCWP3i4FCWHEmtG6XbfTMC/AfE40f
 Qw45OP9xQGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILtQAKCRDa6OEJdZac
 5bylD/0dfJVLen+x8Bv/ccYc3Oc3oH557hixw7fsuEM0C6lLcPjz11/tF571ajYvnamTJB/aanO
 aJTtfsMaZbRTSOgzTDgwD+N4TeIDvxI1X4Z4kucHmzrd+F2TQ2HJOYetfaLyJlab8M2lv849YH2
 kfpVKwD/aPcIJsUB0bTSsPLAGq+3ad0kNL6WnFF+IcVhx4QBthtC/MAbQJs4dBaaFL1dQvOHEEK
 rRR6Sh4nS5g+wJEchu9QNDkf1mnc2bo2UmoHrPcP++6ZEg2AC4/O5SsXY3fDPfSj5BdjCC4iYCO
 k6bVYhlNflUQwa50/EsGwIhGXmdm77lwPSTUHrZyrFI+3wrJ38CvI56GP6boeNj7i8tNJu+FhnK
 iohbwGAOB0HGo2rxnkRRKm8wRcocrrqh6oI00laWLrINDO7HufaafR2DcjGOZ3hdGKVWDnnWdow
 QJZxRWRXuO4jfXqoycjIfwB+uYR2ZwyR8pRXcxVgtRsRtzII0irnVBsqEJCfOcfDKPE3fskywd/
 oMeWtknv3RGjlzEWkn31FMUgN8XUzxRkVQ9PJufvwYSemjEx1A4CaDJVyIceaDadTekDDEXbqpn
 DltpoXKTh0zgyaUml4kpTjmx1kzwk0/f+nVhODvlj1GxspVLT5Hh/AOuHOrAksqJAGqnEZeRyW/
 UY2vKLExTb+NOPg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


