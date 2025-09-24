Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F02CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LqC-0006Nx-LT; Wed, 24 Sep 2025 05:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpF-0005ZS-UU
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpA-00052q-FD
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLACulWrroEz1Bbdqp6RPLMUguLtq4kl6Dbini6ddkA=;
 b=LznutvwVD8tyYHamiHBJx9EpntMz2HkStYWJzSwVOcJs3Vd7YPkqqOqMNWB3p6noZqTSsR
 1xivDzBDxK1TZIkSPcbAXfTMaPcuncIzWqNlv0PF9DQCAXxub2Y0V0zGPxMow6ZjDr6g/E
 zTzck2Rvf+CihvuqoQR5Ao62wrlzTes=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-dcs-b-mvP_uoHJegIq6PuA-1; Wed, 24 Sep 2025 05:30:04 -0400
X-MC-Unique: dcs-b-mvP_uoHJegIq6PuA-1
X-Mimecast-MFC-AGG-ID: dcs-b-mvP_uoHJegIq6PuA_1758706203
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6341958f08fso2797916a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706202; x=1759311002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLACulWrroEz1Bbdqp6RPLMUguLtq4kl6Dbini6ddkA=;
 b=Oe6vwNQ3nDvMz5XBpDqGT8ykdg6dNCFdvBhnBzUgt0T/CVhp/aeY+PC6nrxGFa11tt
 heKXRKAw95lJ7Q5HqyK1IX7qNiHFZ4CI/URCAkVl/DHpnlc0mEdncX+EEdoTy/r0zd6v
 2tmDoDx0xj8tAYV/LozbWEtrp84H5QGr2LnXrARY5htQfYH+WPpLDihVDO/aXmZqInuY
 UawfcH/tuZY6zUTCjuRUMIAs3UT1ImLURDNrlw62pTD0HQH2MiLbc5evdEzEaQY22UCh
 MuDaAsiOifml6ScEao/XT2q2MtSGpl6/MZpQ2Sv2jzJUBIabOfRKk2BV7nvtbAPUiAoJ
 id+A==
X-Gm-Message-State: AOJu0Yxqrsv5PSbQxmHBrxj5dCBluLFK3XYNbXIveytJYaJihIRD+QWt
 aRA1H0oaCxvZ+e8+y9tm+Z84patb9GaZdcHu5HVigpsaGk7UUqzlaegw1WCwbD4lktYey0dEvbW
 JC1JmEIJtLRn/Enx3qBYL4C6s6+gxvENaFJQne0lymyVsYF8AABSoJjSX5d0/cGKNfkhJXypfeq
 bVsrJCxGsFZrWQMSP8Gq58uhNl6qHf8BEW22+qk+yX
X-Gm-Gg: ASbGnct1p6ft6kDbJXFvKqI+aV8CuV5LKnpBZ3M56HROw4JC5N2KZdLOS/MKRBlGp/Y
 Z5Z+P2WHCWdSSwKoKBc1Yu0xZ/u+69F1aB0NA0bfuEoO3lHOx9NRpa+NNtdjxz+RF0nNQuCZFIU
 qRy9+2+7Glrx0yuMVO0SoqY/wtr94sOKvKZlB3J/5I7TUdGLZ3XhDFsWYa+LeO3rH7P9ydDN8Mx
 RhI/c1BCIHr5YAVu/FiRGulYJ8ACvic/W1piQj5v8qjp3gvdz079leRw5Ch1KXaciXWcmbbJtMO
 9nUsWR0zwOxkq0YsuKQyPincdbsJ/h9zXhVusy8eWcpreV+J225WUnM73rn3IOx5sxXjk5U7ge0
 kHoe284b2h7gQNDgnPTDSAfmsNZeADQ6IN1i6p2fqM//QRQ==
X-Received: by 2002:a17:907:72d5:b0:b0c:1701:bf77 with SMTP id
 a640c23a62f3a-b3026d7dd1cmr559222766b.18.1758706202341; 
 Wed, 24 Sep 2025 02:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAAMN4AaOH70eogHBanRceM2xgIddenJo6xIRhEGt4zCuk3kTL1oZd7KH3VOgis/UXn6CgTA==
X-Received: by 2002:a17:907:72d5:b0:b0c:1701:bf77 with SMTP id
 a640c23a62f3a-b3026d7dd1cmr559218866b.18.1758706201824; 
 Wed, 24 Sep 2025 02:30:01 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2eca89e388sm448896866b.106.2025.09.24.02.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:30:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 24/29] hw/sd/sdhci: Do not unparent in instance_finalize()
Date: Wed, 24 Sep 2025 11:28:44 +0200
Message-ID: <20250924092850.42047-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Children are automatically unparented so manually unparenting is
unnecessary.

Worse, automatic unparenting happens before the instance_finalize()
callback of the parent gets called, so object_unparent() calls in
the callback will refer to objects that are already unparented, which
is semantically incorrect.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250924-use-v4-5-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/sd/sdhci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 3c897e54b72..89b595ce4a5 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1578,10 +1578,6 @@ static void sdhci_sysbus_finalize(Object *obj)
 {
     SDHCIState *s = SYSBUS_SDHCI(obj);
 
-    if (s->dma_mr) {
-        object_unparent(OBJECT(s->dma_mr));
-    }
-
     sdhci_uninitfn(s);
 }
 
-- 
2.51.0


