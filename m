Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80244C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8z6-0008Gk-VS; Thu, 20 Aug 2026 16:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8z6-0008GE-9B
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8z4-00052L-So
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787256210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dymtOTbbA2Q2LA0z+aMrYW4c1NOuhuLZRNS72cNN/0g=;
 b=QyPCaOYTIGJdGAO0No3xi+m0wzvwqZuGs2wSymI7FB4gzyd15SKMBiEzAILXGrNnM9mu2S
 IJg6kKsyVJLFwLan+7+4p09n7+ja8z0dMFbkYb5YJjcJ5DQ14519AFCZb9ZVVVmByaC3vo
 bFMIO2mqDhU/W7wP8ThjiTsAPpJbM8A=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-6Pr21yr9NXOx5JyWWiVOsA-1; Thu, 20 Aug 2026 16:03:28 -0400
X-MC-Unique: 6Pr21yr9NXOx5JyWWiVOsA-1
X-Mimecast-MFC-AGG-ID: 6Pr21yr9NXOx5JyWWiVOsA_1787256208
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6b12e3edc28so183232eaf.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787256208; x=1787861008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dymtOTbbA2Q2LA0z+aMrYW4c1NOuhuLZRNS72cNN/0g=;
 b=L//H9AuWfNdPPY/C4piPMwi4C3OiCY0W007rNlaQhs32xBsHMpCSdM43enGJcUMLI9
 2Fe7x8O6oXpCUpXm0VUZqMuRaV03M3R8P4jNe08ppglo4rSMesBbXJtetnHcTPT9xdH2
 IZDHlOmgMpH/IrfZNKQQshgokAJQreU0N3gI1AsEKEuNB5suVXYXy7pr4yARic54+nS6
 I2d5Xe+v5e49iRr8+xXJoXHkeXS87/2Jtk8Bq8gnoUNnWhDbXP0thxnm1Y99o8i+uBjg
 rEcN/eHU2Nwe8tSYGx34o+LAg6jj58BIYYbnNYqFo7S5AYC/jy+pnBAqe8KiC+iukx4c
 MXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256208; x=1787861008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dymtOTbbA2Q2LA0z+aMrYW4c1NOuhuLZRNS72cNN/0g=;
 b=j469Xqf5QuZwAjXqSiOw7ikDUJFIqZBBTTyPodbYXTACLrjCxAx2geE/s1yDfx4BSk
 1FAxszwew9K8L0lPmT4bKNlSHXBchM00qgJTsOotxF1Lz0UfDq1HPzjsTAEPP/y3IGRm
 /jXILfVbkr1WYCASfQWnmqi1Mkqlxaiu3oLO0JaGYZgFWnCaKNDCqgYoo0HJG6wlB3w+
 2KB/FH22sgQMwGR8/2/98uIC/mKCuthQ+dwexZCaHGSTi87+xRlbGQ/TTYEShl+wRzn7
 vCxVnW5OD5OhzYkEKcGdadrFTfPdwVtrE+ZJOkbfidAsvxmpwMKZOCXubD7u8D01yk4x
 vjIw==
X-Gm-Message-State: AOJu0Yy+Hsfh7HjDkyZXvOeKoxhe5e3UBss8ZtIHuDMFGlup4RQuy085
 SB8U73+DGI9e7WW0r+Ra8FkMxX4qupqztQm8j/umtrGecva00daUlVz3iZNg+CwYDKr0y4J2pYy
 i7QhAPYX+98Smsc6RbgoflnkvPV84CxlHJlFlmpzO/58AhWYUPEubk/bnzzMC0Cz0Br66JQyH5n
 l9TlmIA73LF9Swa9MMYG1UbST4eU+dGm/XPEWWnA==
X-Gm-Gg: AR+sD10LNzwGQ76x2iHREltWHx5pc9x0l1zYzpxI+n6M6PwCfWrf55qO4DRGkB1dWWz
 BVC3ybxoiLeyHNjAvsfpZ1FhchB4VyMiMngDs0x22t4t0k231rTN9uLGTRIXRh9OU+Ez5tdPB5r
 fTqQ3D8Akbc5pc0R6N0gwBip5UAtGT+PerLMZJe/3iAY90ASt9Ji+tbFnd42nyA4Y+stFoMUeS1
 XQ8o7f62TGbO6U6Dd1C6/W7Xf3xC7mliH4I4QeSii0ZWWJCfwCKoX98WF92ho+rEwkUHCmElmzw
 B87RDuY79Byj7ccR2uTTZMYOp9q8Z4FBW6ebrvx49urdZqCaL6UcNm+rss7g9Jlg437EK0gpAO7
 tqmiY/E+P70v1m1oLGQIfXOCuwdZaftUIx0objxZRFgASkqNor2RI4PNBRqI=
X-Received: by 2002:a4a:edc3:0:b0:6ae:4131:98c6 with SMTP id
 006d021491bc7-6b15926eac3mr1327823eaf.2.1787256207752; 
 Thu, 20 Aug 2026 13:03:27 -0700 (PDT)
X-Received: by 2002:a4a:edc3:0:b0:6ae:4131:98c6 with SMTP id
 006d021491bc7-6b15926eac3mr1327714eaf.2.1787256207110; 
 Thu, 20 Aug 2026 13:03:27 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cebeb2esm6181314eaf.10.2026.08.20.13.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:03:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Samuel Zhang <guoqing.zhang@amd.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v2 01/10] migration/rdma: Introduce RDMA_CONTROL_NUM
Date: Thu, 20 Aug 2026 16:03:13 -0400
Message-ID: <20260820200322.3321036-2-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820200322.3321036-1-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce this to say how many control messages we have.  We did it because
we're going to remove the last one (RDMA_CONTROL_UNREGISTER_FINISHED) soon.

Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 438419d189..62a509b236 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -144,6 +144,7 @@ enum {
     RDMA_CONTROL_REGISTER_FINISHED,   /* current iteration finished */
     RDMA_CONTROL_UNREGISTER_REQUEST,  /* dynamic UN-registration */
     RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
+    RDMA_CONTROL_NUM,
 };
 
 
@@ -235,7 +236,7 @@ static const char *control_desc(unsigned int rdma_control)
         [RDMA_CONTROL_UNREGISTER_FINISHED] = "UNREGISTER FINISHED",
     };
 
-    if (rdma_control > RDMA_CONTROL_UNREGISTER_FINISHED) {
+    if (rdma_control >= RDMA_CONTROL_NUM) {
         return "??BAD CONTROL VALUE??";
     }
 
-- 
2.54.0


