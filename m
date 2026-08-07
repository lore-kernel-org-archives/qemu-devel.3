Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7599CC2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 05:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsD6q-0002I7-HJ; Fri, 07 Aug 2026 01:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD6j-0002Ea-CI
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD6g-0000mR-4L
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786080416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViTTh4v1KQjxlG8syeql8cXKrA2bPWoS6ARXsEm9SxM=;
 b=AmD1f43hF4kbk0lDLtUFqucTUNwth/AXCCw4zarJEN3vefuSA2xoRCQX0haQSb87USKv9R
 cyqYvx70/3uLDj+LaIhYtlNo+t8SexBqiud6B3C+MHbZJoJ2v0CCHL4dMf/3KmijwO04nd
 RBseilUjMlbbORNDsZbrwbQk7WKDE1I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-_REgIzw2NoC_oIISDLOEkg-1; Fri, 07 Aug 2026 01:26:48 -0400
X-MC-Unique: _REgIzw2NoC_oIISDLOEkg-1
X-Mimecast-MFC-AGG-ID: _REgIzw2NoC_oIISDLOEkg_1786080404
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e1118e4abso4438930a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 22:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786080404; x=1786685204; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ViTTh4v1KQjxlG8syeql8cXKrA2bPWoS6ARXsEm9SxM=;
 b=q9eTr9vBm7vCuTKWjLbB1thOEhx7CHg8FIrhoDLn8vLWLozaMh9lErzdNxeZK6cgT2
 fgnzbwGat74LQuEwJ8KolKZLWidN3eKpQbeWb4kMmsG3U9IMndTyQ4/+rGa7D9HjIj8D
 ZkEgTVF8Q11kXhLEr+kpwxw3q4kDSfhBAdil4G5gzA8vVrz7oMqSZclDbRPrzebHfv2A
 2h3Ymg/wcA+dnJXUNqZ4ZlcqSGJQrRE4N1OBN4FAaUbOgF+0HcWqRFXkH+yCEKj4bgMa
 TCvr+nppSkNce7lsNzfasadsbxElhYH0BQmiM1LuD0TqoFCePFHkQHp+Qgz0GXBwB1tn
 R6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786080404; x=1786685204;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ViTTh4v1KQjxlG8syeql8cXKrA2bPWoS6ARXsEm9SxM=;
 b=dqV0MV+DBUNejcrcyV//4EEkeGCB4aZpPwHwk1fgTfMwOJTOFB6EaI1PeXT5YN9Fq8
 izNQTT/wTP7FPPiR1le5oLtaM7lM/YN1oQZx6YTvSusQLy5TDs7c32NflkwwhwDQp2yG
 Vdsj3bheQ0ktyW8J/bfokqdWR5/i6q/Z5wJqE/qI47pbqUeQa3wpEEf3TFBLmNOWMGcq
 hYUauY/s8MTyXe3ZMBV8RoSgKtq8i8+wN0TVuzcXFC+rqeSovNDcQrF+k6Ky7nivZDUh
 Zeyxk0U/rfhpYii3RyJ++OS5sYSiJjtmZ1qkMoL320dSdUVJHU9i0YV2WdmbCuhQynm7
 OrSA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCLjL4VnCKf1TNE4ZadNIom1k+ncQxJJpWo8p2foawwjw3CzoWodEphJMYVTUBfVWMMEtOvSIDAUt9@nongnu.org
X-Gm-Message-State: AOJu0YxPBf2HshfTpm+jLmhuWK548jV6nKggKzIoH/PF0zjP3aSZIrSL
 wyzd7br+vL2RRONC4pworUpweLD3vqYwv/zZzRjhUth4UFKi1zyfKHKgIGyyOe+ytvDzGWPH3rc
 9In3OdwXw1oGaLFe/Vu3hS/YMsYjUqE+GW5ltgDzbWX0e7E8SwabvgHSi
X-Gm-Gg: AR+sD10R8fupgbgu2HFGDJMWhnIQDUYjkunKEz9plJh/gwmPBcREfCiK/x70chJd/1M
 WM8st5nunfpmLvq0qdoqHQI1r1IIMGdqJ4N8rdEfi1eEyFjepxmOWsY8Spi/wdpj0SOFpWMPT5o
 lRyUm5JOSLdKBQ4SMe5z3hHsgsMrvyQx4Ro9XZdZWtIl3nvfJ95Xt3x45B/Vg8mejD/guWSem8s
 ZUdxNpMGd4IH0vWVgTk09j/7pS6hvjhXfwQUP+MVv3ykg6S0um2c6YGUUNA5S2+OySsIQIQs30B
 CYxfeJdrzlZOzIntOxaIWqctNTiKzkgaJUuo+3Om50BeJH+r+bfomnearaBiM2HiXfPV+Pb6jws
 dAas3exRZwv195xXD9n8FIXr8BxRwzz1NbQ==
X-Received: by 2002:a17:90b:3c06:b0:381:a766:efcc with SMTP id
 98e67ed59e1d1-3903c5bcd66mr20946376a91.14.1786080403803; 
 Thu, 06 Aug 2026 22:26:43 -0700 (PDT)
X-Received: by 2002:a17:90b:3c06:b0:381:a766:efcc with SMTP id
 98e67ed59e1d1-3903c5bcd66mr20946344a91.14.1786080403356; 
 Thu, 06 Aug 2026 22:26:43 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3908616d21esm3316334a91.17.2026.08.06.22.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 22:26:42 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, agraf@csgraf.de, graf@amazon.com,
 qemu-devel@nongnu.org, kraxel@redhat.com
Subject: [PATCH v4 11/11] Update MAINTAINERS
Date: Fri,  7 Aug 2026 10:55:53 +0530
Message-ID: <20260807052559.50643-12-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260807052559.50643-1-anisinha@redhat.com>
References: <20260807052559.50643-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add maintainers for vm-launch-update device and associated documentation and
test code.

Reviewed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 902db77218..b8523d4cc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2833,6 +2833,19 @@ F: include/hw/acpi/vmgenid.h
 F: docs/specs/vmgenid.rst
 F: tests/qtest/vmgenid-test.c
 
+VM Launch Update
+M: Ani Sinha <anisinha@redhat.com>
+M: Gerd Hoffman <kraxel@redhat.com>
+S: Maintained
+F: hw/misc/vmlaunchupdate.c
+F: include/hw/misc/vmlaunchupdate.h
+F: include/standard-headers/misc/vmlaunchupdate.h
+F: docs/specs/vmlaunchupdate.rst
+F: tests/functional/aarch64/test_vm_launch_update_aarch.py
+F: tests/functional/x86_64/test_vm_launch_update.py
+F: tests/qtest/launchupdate-test.c
+F: tests/data/igvm/*
+
 LED
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
-- 
2.42.0


