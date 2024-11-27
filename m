Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE960D6ACD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 14:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIYO-0003j2-I7; Wed, 27 Nov 2024 08:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYN-0003iZ-G7
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:58:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYL-0007kL-7z
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xc83yCJTjWUOlwbPIaTOBSqDgZomNzG9qaGscIC6VEA=;
 b=MxN4Kq6Yzltv0VlhgAZEvdMY+w0oLJ6bTCDAxYuDQu5sFoOh5ce2SlUQiG6wIG61jPlAvi
 ENvkBlpH4gD7oGMnvOiLMkngeI7MfdBV1ZnU8HpYqSWoo06mQ+8fNFg19QhtmLpePdSD/A
 yhp6/TdyaxhB7H6lzvVqWM7xKefVsp8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-MRM3YBsRP2qndmx7lr4qCw-1; Wed, 27 Nov 2024 08:57:56 -0500
X-MC-Unique: MRM3YBsRP2qndmx7lr4qCw-1
X-Mimecast-MFC-AGG-ID: MRM3YBsRP2qndmx7lr4qCw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38256bf4828so481746f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715874; x=1733320674;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xc83yCJTjWUOlwbPIaTOBSqDgZomNzG9qaGscIC6VEA=;
 b=VSIM0NYyCOtWgPJNYWma8+tIsJ5+Fa24YISWnrAbRlHmsgOijoX28crTksrxOM9h5Y
 RHFj8CEmmPGzP7WB+QBjfgc3AF17ApAlbY6prIGQGCiuBSeZSLI9w8khFCHncKwkWQMR
 dvP5RpT2lvPjKoIYc5g5OwD6/YdLX0pec0OF+1sMk69p7BjMYpoBgHboYd5Hkn3TMQv/
 aIrzLiWDRLkJTWTQ91m79Bq/DewrAAuuyb32TUOGki3JlPi8T3nKYdgEzWFOax9B8Oma
 3ed2TycBG9dluaV/OIhuC6fYXq8vMGvOlnRAT3S9sc7rrC3iVtqPfE/qap8+RxW0A1Dl
 jwjg==
X-Gm-Message-State: AOJu0Yw/03BiqEtIN/C11G397pRK4cOw/s/Lnbr0IEV5Osx8yW29W823
 R8eOuU6I+TydXkAuuatl47ZvUis+Au8RMjJI2n97f9cJDYurSpd0K1MPqdm2pqhiCJ81dwZFHLC
 bA1o/LO5qkslsRLkbYjKAp9/Pe8kfrph723H/Lx/nSz1B+TvmxR8gKYIC3x6c0ZHSxsEGjjYfrV
 Jq9cKF24V6jwkOiFeYfR5uJSSP6SOupwdZ
X-Gm-Gg: ASbGncuI0DqVXXMKdqFLb4LJ6EWebgQPShwGOOrndGhEhagqG2nJo0ETv6StJv9opET
 g/Jb5qeCSu2+0WbiSuk/B+rNknCsRDWs5LptIPKHRTxLS9gPjExc8lcZ2IJvSOCD8QBfwwcbAWj
 dBfS5MHxwIemRr9WChO8fMeCgAVvuGlT04/1dC3orczs80Evxxi4Ah4O36p21v2RUkcZlUFiycz
 kosZ1cAz14fMYhCdXF1LYXe9v9TmylsYcnCnLIEqT+1
X-Received: by 2002:a05:6000:1ac8:b0:37d:3b31:7a9d with SMTP id
 ffacd0b85a97d-385bfb14bbemr7145654f8f.23.1732715874746; 
 Wed, 27 Nov 2024 05:57:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHP2/hT+XDbnBycDKK19hbZRDr0/bQzKTJLnwPEO3Nm/VEPZW6jj1sUYvvtpxeTTQrmWUh37g==
X-Received: by 2002:a05:6000:1ac8:b0:37d:3b31:7a9d with SMTP id
 ffacd0b85a97d-385bfb14bbemr7145618f8f.23.1732715874407; 
 Wed, 27 Nov 2024 05:57:54 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc40a1sm16382593f8f.69.2024.11.27.05.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:57:53 -0800 (PST)
Date: Wed, 27 Nov 2024 08:57:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 09/13] qapi/qom: Change Since entry for
 AcpiGenericPortProperties to 9.2
Message-ID: <37a14f24b4ee696def42d7629598ab6da7399f65.1732715823.git.mst@redhat.com>
References: <cover.1732715823.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1732715823.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This feature was only applied during the 9.2 cycle, so reflect
that rather than 9.1.

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Closes: https://lore.kernel.org/qemu-devel/ZyngEiwmYeZ-DvCy@redhat.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241107123446.902801-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/qom.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index a8beeabf1f..28ce24cd8d 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -877,7 +877,7 @@
 #     complex as there may be interleaving across multiple devices
 #     and shared links in the path.
 #
-# Since: 9.1
+# Since: 9.2
 ##
 { 'struct': 'AcpiGenericPortProperties',
   'data': { 'pci-bus': 'str',
-- 
MST


