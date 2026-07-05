Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BF1C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNvn-0005AA-LA; Sun, 05 Jul 2026 10:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNvm-00059Y-Gc
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNvk-000135-UG
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RyXo8IcwoquYoDigzOCgrundImULxF1Wii2Ii3gongY=;
 b=Gh6IzMOZE5tjsopiRdY3CVkirNibMf+4YmbPVgRuDwlsRk+cc9PqZnPTu/KMDkboeEOk+6
 4MKPfG5um2PrsBEZH5ndVyBVDfFwVI/v2nkAjnPbXaTf9nwKGAetpXtcSb+1H8jf+QG6Ny
 eVUSfMIDY3Ve6Ea2eV91N7q1Ga+Cx5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-rA04qQ0KOeuhgkdFPozYrA-1; Sun, 05 Jul 2026 10:34:45 -0400
X-MC-Unique: rA04qQ0KOeuhgkdFPozYrA-1
X-Mimecast-MFC-AGG-ID: rA04qQ0KOeuhgkdFPozYrA_1783262084
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493caa3c54eso18811115e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262084; x=1783866884; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RyXo8IcwoquYoDigzOCgrundImULxF1Wii2Ii3gongY=;
 b=fLHaELXDH8Q5iKUqypfHzyaL9pCSfTuWHvix5WWSjGgSq4nv9/mxU5hhgy9gjP1x6F
 mfh8IHCke1VtC087f0Y6yc7BMyd4DJejzwYo1xrt2R1gHBn5M9lxdhuFtfuHXVUdxqlM
 DjRCaxAXoCByG8gx6OLQq1brq0/KZqvl7k5YNB968dkkMFWyBeFUFfb6K6DuZp+SOF/c
 j2K34g2LbRPpEc2TD0UwO55eurca46m0m7qHC8ZzhzdBsFjHCAo7xRo9ZlmWH20WGYG1
 BLWZhPi+X+nvhjexBQhkJ9YPjYHf+jbhtSnV5hKgkJ4kbb9bjAHl2gfqL6hPHOkHlzN7
 pcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262084; x=1783866884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RyXo8IcwoquYoDigzOCgrundImULxF1Wii2Ii3gongY=;
 b=CEHYu8N8W5F4u503PnSvs2P++uLoajCS8Ee5JoYO7wtiGMdiaUgK6rQpZXHfNyVh/s
 0HkT6vRJKn2DRm9nw79uh/LCkeigtODK9BXz+tsr8hsRGryCJpGryGQFYicnesdeXD0N
 2ieHguY1slMXjb5/FnGyu7Z4i8GxrsqkehRMqgY6PIIjRz3HiRhA8n0Tse9j9FE8dXXr
 IPQm+11DrQC9Mr1fiD0f4uShORspBjddd4rp8jM4baYPytk7MsXd9Rknqy1VDRkhNtRI
 Uv2XyeEAfTxz06TD1yuKp0GoplTo2k4oEhxulfYC0d6tEd/ZMRB/lEn1myOqkEbBKBHm
 gGUw==
X-Gm-Message-State: AOJu0YwQjuvX47X17IuLFv7FS+c+rUMOw32tbcL+tS8WKwV13IsZDt9H
 zarHdQEJdepvVPFxGC9jvM1fIYyuZMiIKYLD82VIasY63L3u8CLml+gBd0oQUKThRlVKCKJqiHt
 6TglajOpVHAek96/sfaD1VdkkGiMncK6oRSIf12nmZlXHXscLo0oLe+FarjyEyyBzHv22xUz8k2
 O+TTEavNf0MaJWLp0elC5p6GNJStolrVKemg==
X-Gm-Gg: AfdE7cmEhWtzHr9hwAal30Ej3pbjCpKgftpNF2eGfyUJeIvwNjOvu0HoouokPa6FuON
 N0ZjMcF35L76DK/hMA+N+AdrF6Oy8kBcPRyWqpTMZjYo0hGAwxbzh5wy/uHZC4Hn0ZIDrQbfTiz
 gmsRka88izwRjqZ/XltBzgx3AENrfBhRkMkyFU2nbQTvMmh3rPOH42W8Cvb1N0QZbXvjDCQKIGP
 iiVboQnDrrZt8sPRVuw+kK5hP35eu9MkUbApEeV0LoUyfflvqJ6vKGDldfzchB+K/PwwSqvvNcV
 Zm7HXuKqC13ECUUOvkW+dCIe1Hc1GiRxYztlQn3EAahmkxqE86lx6fkXajmHjw0HveLQ4UPsU6c
 6Hf4quFUD0czIAn2T+ioMFeuPHyUuad2t
X-Received: by 2002:a05:600c:8711:b0:493:aa24:792b with SMTP id
 5b1f17b1804b1-493d11f15c6mr73895675e9.22.1783262083929; 
 Sun, 05 Jul 2026 07:34:43 -0700 (PDT)
X-Received: by 2002:a05:600c:8711:b0:493:aa24:792b with SMTP id
 5b1f17b1804b1-493d11f15c6mr73895215e9.22.1783262083407; 
 Sun, 05 Jul 2026 07:34:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8cdsm18401486f8f.1.2026.07.05.07.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:34:42 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:34:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hoppenbrouwers <qemu@demindiro.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/44] amd_iommu: Fix opcode reported in invalid command
 handling
Message-ID: <0611d393031f9941fcfaf3f17c3ac2b7a0ea00d1.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: David Hoppenbrouwers <qemu@demindiro.com>

According to the AMD I/O Virtualization Technology (IOMMU) Specification
(Rev 3.10), Section 2.4 Commands, the Generic Command Buffer Entry Format
encodes the opcode in bits [63:60] of the command buffer.

When handling illegal opcodes, the traces for unhandled commands and event
log info extract the opcode from an incorrect offset in the command buffer.
Fix this issue to avoid potential confusion with mismatched opcodes in
traces and unlikely errors in guest event processing.

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: David Hoppenbrouwers <qemu@demindiro.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630220806.1758748-2-alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 79216fb305..05b7c638f4 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1509,9 +1509,9 @@ static void amdvi_cmdbuf_exec(AMDVIState *s)
         amdvi_inval_all(s, cmd);
         break;
     default:
-        trace_amdvi_unhandled_command(extract64(cmd[1], 60, 4));
+        trace_amdvi_unhandled_command(extract64(cmd[0], 60, 4));
         /* log illegal command */
-        amdvi_log_illegalcom_error(s, extract64(cmd[1], 60, 4),
+        amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
 }
-- 
MST


