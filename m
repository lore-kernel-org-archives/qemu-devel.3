Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA4ECCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6W2-0002F6-Ul; Sun, 09 Nov 2025 09:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6W1-0002El-7M
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vz-0001ol-Pj
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e0/66sXsmsUJ5C1OsJfboRZvVx9JzW9VTegIObTcbHI=;
 b=VxMjqQbh3K47pMYKYIbeJfKdyVww5QUs/YQh/8eSp9DCQl2TvNdsEJKRzSyNga59Wwam9d
 iRmoEvLAEw08WIhC+rqjh6daq9HcyfH2EVwVMUlZAserDcSCIdCSf6gveZscJKiyWarcoO
 nuV+skLxp+2Cq7zhu5pZ3jjdKHyer3k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-J97FPfSQNd-_od0YcfEg7A-1; Sun, 09 Nov 2025 09:35:33 -0500
X-MC-Unique: J97FPfSQNd-_od0YcfEg7A-1
X-Mimecast-MFC-AGG-ID: J97FPfSQNd-_od0YcfEg7A_1762698933
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b2ad29140so855658f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698932; x=1763303732; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e0/66sXsmsUJ5C1OsJfboRZvVx9JzW9VTegIObTcbHI=;
 b=q+OQtwGo2osDq0mWYNUtlxVmh7JKWTpriKcGG7A/LILPHcLhKl8DvAHKpL/dmu8b52
 BK86JHfr2mZA+b9t7vtLkZprywxlftqUkAsyUUEqkVs4KaKR3tWa+4XfT/aqZgPfxz90
 mxRgJZLNzTBNIMUE0jef/cTZk2kV3o/x3KXMhj4yK8WFothcyTSfkd2IXSbtukS4mAVg
 UozUIB4X2b7fdYIsvSMGA2UdDEDZjDUCXdKBSZfb+w7g4XVwCf6UoSIsdZsj/v3cnuF5
 cKWr/WNdX5Tf3x7mpvFIj8YG/KlJZxNzcSMEzqLVnMmqbdB8Jx8apnLSHHNKbP+J/p5O
 2kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698932; x=1763303732;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e0/66sXsmsUJ5C1OsJfboRZvVx9JzW9VTegIObTcbHI=;
 b=IetdLUOQTELNY3IR77IvD/vp4cLd5Q6HAhuU1aLHKH30dGFcuJMS5DzrbLZTl4eNbp
 onqPSYEHEVD9ZPhHIxYlsOh8E7WvGoaMcAtTysx7awV2dPJ17fs0OdIHtdTXb2Ouuy39
 unfMlofsgim06R/VAfjyz7SPPQdxlNV8ue/+k0QHgvaSn6lhRqN9tIWLL5HMY129VFit
 cTYIqQRUo+DKaHpG7Qyu4mJMy/cUw3Cdy9xbiz9D+0bPyPHgYFIOiJ7D4sjmL6LGAkSI
 NBAYfYjtiaBO5IigSRSB/WMLEAhNwbIhB38mtj61tcY4OZ2z5vUPx0h9Z89Zu7tUKoDE
 CVlQ==
X-Gm-Message-State: AOJu0YzwZYUIoDZjJeKg8XWuVk6w2E0O1S/Y7fn0zdd02g4fZixy7sPB
 4J15AW9kHHHM8T1aCXON0IVQmVHCZDJzYHKiHk60tFtoKFRokI3X/35gFer0jSOOzOxYo0L/oyR
 OpEgHGreubqZRjBvSCP7JScfQ2J0IAgARX4v/epZRQ1XjLEMp2pErK4yl+1wjDgbz7Bjorr+gS9
 YzDvGJfe8p7P+1gW2fO560jEauGGYSz+aSbQ==
X-Gm-Gg: ASbGnctNNzN3lDp9kGvgY1QTDmESbhlYYyIfyxuyLhYDYml0+mqRGf45PkjREQvluzE
 FibZVcA+S4fRzq/IGG+u/pFKMYcUlEcGyD5Acncjn1TmYcVIfM/eg9/N7AHKcL6fLNAcwuKmXLa
 ivSdtanu5Ytqphr0Aofhoz8qdSGbHAtcxA0sQifXfVmRsAdIYZDBBnEm8BicWO8i8NlF2Ubsf2n
 WfhmYrcNEpGQ7V5npRXhBB8LCE8EIwJDgjw0gDA9SpTBWV25lKWs91lsLAT5wayZvgAyh4DBzq5
 y/mfGgNrT103H1YaT/PjD99uGHUtoyjA0NnFkaoWPpFumA8gOp0hxL16wCJ60JZUnjw=
X-Received: by 2002:a05:6000:2903:b0:3e7:6418:247b with SMTP id
 ffacd0b85a97d-42b2dbe4583mr4067484f8f.10.1762698932188; 
 Sun, 09 Nov 2025 06:35:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG16L4udtSGhwZaR52tIdTfsgtDPm8uZJlGLoLGLR1RK7hvxW1R+02gxdiSVC3RBJGyTdl2eQ==
X-Received: by 2002:a05:6000:2903:b0:3e7:6418:247b with SMTP id
 ffacd0b85a97d-42b2dbe4583mr4067458f8f.10.1762698931659; 
 Sun, 09 Nov 2025 06:35:31 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b32c1ad2bsm5461214f8f.6.2025.11.09.06.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:31 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 10/14] hw/pci-host/gpex-acpi: Fix _DSM function 0 support
 return value
Message-ID: <325aa2d86a20786c308b0874d15a60d1b924bd0e.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Currently, only function 0 is supported. According to the ACPI
Specification, Revision 6.6, Section 9.1.1 “_DSM (Device Specific
Method)”, bit 0 should be 0 to indicate that no other functions
are supported beyond function 0.

The resulting AML change looks like this:

Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
{
    If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d")
    {
        If ((Arg2 == Zero))
        {
            Return (Buffer (One)
            {
-               0x01                                             // .
+               0x00                                             // .
            })
        }
    }
}

Fixes: 5b85eabe68f9 ("acpi: add acpi_dsdt_add_gpex")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251022080639.243965-3-skolothumtho@nvidia.com>
---
 hw/pci-host/gpex-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 952a0ace19..4587baeb78 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -64,7 +64,7 @@ static Aml *build_pci_host_bridge_dsm_method(void)
     UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
     ifctx = aml_if(aml_equal(aml_arg(0), UUID));
     ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
-    uint8_t byte_list[1] = {1};
+    uint8_t byte_list[1] = {0};
     buf = aml_buffer(1, byte_list);
     aml_append(ifctx1, aml_return(buf));
     aml_append(ifctx, ifctx1);
-- 
MST


