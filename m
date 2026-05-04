Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6DBCD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJreO-0001mn-00; Mon, 04 May 2026 07:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJreF-0001Vc-OY
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJreE-0001Vx-G3
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OfyzipyaFyY1CMp4s0Vws0Sy7SQL4ehZCVUgrOMSFM=;
 b=QXK/VMs3zfNoQqCKTFZHm/YIatSeSekRscxchlXNzre0EjYfrjwwRqUrCzxCFdsBIDGUJK
 qYsZGw2fmYJ8C6nkHygM27KfcU6fID/ttGQWmZPtwgI23qZfJtUAOGdDKTh45MLCEGfyjx
 Q9mtWmDz/vNyv3P9WcGTI9ngFA2lyhk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-r1_Ggph-NZChr9b0jYWtXw-1; Mon,
 04 May 2026 07:39:36 -0400
X-MC-Unique: r1_Ggph-NZChr9b0jYWtXw-1
X-Mimecast-MFC-AGG-ID: r1_Ggph-NZChr9b0jYWtXw_1777894775
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B810B19560A2
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:39:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D3CB1800446; Mon,  4 May 2026 11:39:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:33 +0400
Subject: [PATCH v2 45/46] hw/i2c/pmbus: fix undefined behavior in
 pmbus_direct_mode2data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-45-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tLDFCKiyZ3IHoxFsadnpmt3a+eVCWPPwxdz50j2s6oQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRuzEwHy/3uM3LhfvD1h1GLoHgnQh+T9RSov
 wVKj8uq/8uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbgAKCRDa6OEJdZac
 5fbKD/4o51Pq9FXe5oLI4wtU1/Ymo3XZd/+0e1d8KTK2M055ke++G5391NeFtV/Xy648iKRZjNV
 o0mL0c3F3TRlZOM7EON4dzylMpnwe3e4MW15Ft0QmluYpApHDFSSfFc6A4RSKN0IrkwnM2c4Oc1
 L/4GAIxQYu4EZpbrw5GVheLQppS3Dtwk8ne0DdAEQSC21WuDOZWzwjeN5Jjy0WG8WNhToV3Jpu1
 B78P8jualYUQRf3FlD3Gsjdn2AxxTR46x155ExQjhVwEcS6KqQQbzHmHmcu55e5lGvt3C1t0pLG
 3xUzAUYaZUn+NF+C8x/TKXXKol4XaCWtj6jJobwAvYu5KFYhEB7U8oXMSKOxsW5COob3BkpCANt
 sAOcanAyy4RNcpunC998zo8F6mFbm3Jlo/oLYJW00eCXaSjqFsOcEZ2MV3yWBG8wR0EOurdGA3B
 aYNR3O3szQXJX4IJjkTCC8jIQDgDBSasGluwz7Q3w4y1z7rhdFBSPThEn1wF38mqRzmcKKOrI1s
 pSSL1dMTdCuoFzrPo1CipyuPnAlJzJRVugxKLfpT/4Jj1+gb2vl7eMLUcsvVa8jJoEdoDUh8P6C
 TACksSE3N/CPmSK9+gaqDa1gn7xt+SKYb8qf+7N6Fh2L9oaM9ki70nmY8hNXS49UsVMXKMtmlC+
 GMb/wkxQXXM0/Vg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The intermediate result of (Y * 10^-R - b) / m can be negative when
the bias (b) is large and the raw register value is small (e.g. zero
on an uninitialized device). Assigning that negative double to uint32_t
is undefined behavior, caught by UBSan/clang.

Use a double intermediate and clamp negative results to zero.

Fixes: 3746d5c15e70 ("hw/i2c: add support for PMBus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i2c/pmbus_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index 853dc4b4342..861f5b4fb63 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -23,8 +23,8 @@ uint16_t pmbus_data2direct_mode(PMBusCoefficients c, uint32_t value)
 uint32_t pmbus_direct_mode2data(PMBusCoefficients c, uint16_t value)
 {
     /* X = (Y * 10^-R - b) / m */
-    uint32_t x = (value / pow(10, c.R) - c.b) / c.m;
-    return x;
+    double x = (value / pow(10, c.R) - c.b) / c.m;
+    return (x > 0) ? (uint32_t)x : 0;
 }
 
 uint16_t pmbus_data2linear_mode(uint16_t value, int exp)

-- 
2.54.0


