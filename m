Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA38C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0BU-0000Qa-Fx; Wed, 05 Jun 2024 19:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0BS-0000B4-GM
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0BQ-0005ui-KY
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PiQRSKV88pDHIzL/embxb6ck9gnapJtoEwzBqZXK5wg=;
 b=duYjxbxG54nwpDwG5uETchjcmK0HTWyAKbsB/aaZEBj9hWARKz1B35WSAQIqG/F8OAY/m0
 ZGQZS1KZ95ufvO3M76JMUmYd6zXZUxxqHDB42U/Z314DXjnHVBReSf4jMkY9Ev5ov6wcgK
 ufu69UdH6iSwt6Fks9HuqdEIoBsH8WQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-rLbs8pqIPQ--Yg3SfsG0VQ-1; Wed, 05 Jun 2024 19:36:42 -0400
X-MC-Unique: rLbs8pqIPQ--Yg3SfsG0VQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2eaa806df17so1849121fa.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630601; x=1718235401;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PiQRSKV88pDHIzL/embxb6ck9gnapJtoEwzBqZXK5wg=;
 b=Q/Gr7lg9lBdsXLgTdbcyI5SO33d8jR5sX9WnQCIsyOI1R2c/9NfD7oAAGt4901Jd2d
 M9OzUjjo2PWU+Y6XNEkUS4J2Ajkqi3OAYIZaXSOIQaYoRl/+GfhHEHF3DjY1RF1x7ep1
 hTKnWMqLpWlwCBQjdMjxbrGdJeCHajN9/dusxpF+Fs4SQmB49GjaIIpmz924oasvtr7T
 /OP1/g5lrahExHeWu0BUphkEk+p5WDGN74kcAAAHbm/KaPv219XexaspNWe0Rqa4+o/J
 q+8ya/MHMEYcWmNS5SRRwe4rEuxGztfC26VLyTulfYxUNUExCRHDN34C6HewDVrMJfkq
 wYNg==
X-Gm-Message-State: AOJu0YxNNUEEQUtplZq0FUTbcy1MwcJGrIOhLxQq6Tb9vEW2xgTniEqB
 ScKDixOPGqbM0P2/t+s/CshYqZpe0u4sNsPg7gIpPfJkxDRaok29ZICCwN+vAATAg4Dso/NAsMh
 L9Olmr+EcycpL0PGi4EHpIlNcx6AtvKcd12fM2uKHZrWUWgPyxrM82wOvu+apwIOui+8OqACdFF
 tp56kwMTIQEeUCDKRGJl10ZtxYHvDpEQ==
X-Received: by 2002:a2e:2c06:0:b0:2ea:bc8d:3a43 with SMTP id
 38308e7fff4ca-2eac7aace3bmr20897761fa.43.1717630600926; 
 Wed, 05 Jun 2024 16:36:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF002q5CRfYJKtGq/CJm/lyEtHjtvPmWOWPb4tSY4hYBp77ZRbkRgyBfE8hfne09EMPbs+wOA==
X-Received: by 2002:a2e:2c06:0:b0:2ea:bc8d:3a43 with SMTP id
 38308e7fff4ca-2eac7aace3bmr20897631fa.43.1717630600454; 
 Wed, 05 Jun 2024 16:36:40 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae201a6esm94218a12.71.2024.06.05.16.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:36:39 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:36:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v3 32/41] scripts/update-linux-headers: Copy setup_data.h to
 correct directory
Message-ID: <22df9cd2eac6404888df74e9a44f151681f31051.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Thomas Weißschuh <thomas@t-8ch.de>

Add the missing "include/" path component, so the files ends up in the
correct place like the other headers.

Fixes: 66210a1a30f2 ("scripts/update-linux-headers: Add setup_data.h to import list")
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240527-pvpanic-shutdown-v8-1-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 8963c39189..a148793bd5 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -158,7 +158,7 @@ for arch in $ARCHLIST; do
         cp_portable "$hdrdir/bootparam.h" \
                     "$output/include/standard-headers/asm-$arch"
         cp_portable "$hdrdir/include/asm/setup_data.h" \
-                    "$output/standard-headers/asm-x86"
+                    "$output/include/standard-headers/asm-x86"
     fi
     if [ $arch = riscv ]; then
         cp "$hdrdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
-- 
MST


