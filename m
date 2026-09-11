Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46C7C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9Y-00036U-IX; Fri, 11 Sep 2026 05:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9M-0002WP-PR
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9K-00089i-Hd
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GnRjJ65SGrC9am8hi9r7ANKDtkiUG6pnQWAw9MHk3fY=;
 b=ec4Mk1AndS7a5oAos/ZiElPkyOt0ebRFwdDfvI204CPX3xvNICJord3+CLog8hhIMCGLcc
 xWV4DRAv1kn2bKN1ikjOIWg1yGg4E8mbQ7fLP6HHC4pgZ9I8suGFhOqchamOSxlCNBEHLo
 S7intH/UOAHgH+3kQo6+S5fIYUYHIeM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-0g2nlY88MG-qocOJfnLFnA-1; Fri, 11 Sep 2026 05:02:20 -0400
X-MC-Unique: 0g2nlY88MG-qocOJfnLFnA-1
X-Mimecast-MFC-AGG-ID: 0g2nlY88MG-qocOJfnLFnA_1789117339
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4957287363bso4185735e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117339; x=1789722139; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GnRjJ65SGrC9am8hi9r7ANKDtkiUG6pnQWAw9MHk3fY=;
 b=rLsmQsUfOMFvqlrGT74AC7tkLZ5UH/x/AyyiDONnMu8vLZvX6Ftc0onM2wTHmxtnoF
 oXyJOl0N4EK+UnvvzNsxQT+pbIbjr3ADRGdXJ2EJMCCcLrxF62zIyvapalePwdtgIRT4
 f/NHhFK7GdaSVDSzGVnAOkgn7sdyL/li+mA68dFLSh0vPCl+pcDNog30j/FRU+7sOPqn
 s01UtmQF6+AmTxhJ8o2M/e3IFICjjxgPcAap9fDcYBU/ltuK9NI1T1MZqUTX0vaCFQ1i
 mkKwwTk1OTOiuLLDTZvkqheICwUF2Rot9ZPg0EzaeQ7me8ipf/uZxuJ5MvAVcfRWomFg
 nr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117339; x=1789722139;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GnRjJ65SGrC9am8hi9r7ANKDtkiUG6pnQWAw9MHk3fY=;
 b=YEx1GXeMTr9MaQ9zsVYTRKEdzIkN94iIb6gYKRUDJz0EPzW3JAqWyrO3q6S32VtYjU
 z+aFjU/WLQZs9bf5fplMWikSHOpX8Ft37/SJEikVyqDC25N2eB9Ay4Ui03yWDwPY7DFT
 LWCkmEdNljzkRNDia8A70zirsd7Be5Dw/YLeqvorEXWaRaOfrXo3S2/rpnM+3Z85Epvy
 YbRgSIdTI/0hATWGxaUaxFl5/3h8oJhj2WioW288D78BgcJJ8AtZGmNgEoBHNR39i2ss
 grJJEJPHm372jJylMKFvtCDXiuLRRkUCpoOoTUw9ZyeYFiBHEyWUgXEOL2/njKI8JCO8
 ogRw==
X-Gm-Message-State: AFuF++krIqQyCPNCUxo747bT7YShyXQgIhGGyxac9rvPaMrPog5PALu1
 lAhawyjPRMpRPVGAf6pQvB4fVfXLANntANOkEmWU/A+JHeHZ7ddo0vUI5Ufk5t65kvo5CjPBvGv
 zlVEREgF2+rLoSD4j3eGm6uxSWIGcSebtxi/mgYm9SIXHBDX5UYI/v6k1rrv5YFJ9AH3YEFGikQ
 M2I0RgssJbGgUqxf19/ZNhAvOPua7xpE9nqg==
X-Gm-Gg: AYBFou3gcHB9fJnHGaIc91zuq8AJL2UwCW2V8W/QHDqAHGVdOCJYJgHx6JeBYL19xdI
 VkyYbumKTnajhRV2D4dCCT5RoA4DO65E/J2FYk30rIuWgWjYomVcy/bkggh7bOBCeFd2xDObfnY
 GRK2eTl2Fhz6Nn/MiDcQ5Buu3kTpx/ka8DSnqa9bW9az+jzlINxHwEcoiggMuP3EwGUSCmy8e2c
 vUNtVJHRHbG1+AfDXhXWJHHx+EqArRhdGh4YhxESeisGWoJ2vse0fsGmDSksxRvx8zLR5KkLUld
 JhrcXANu+soojOc2/dCpddBVT6xUj+UN1TOfZURiWSGYq2KKVerquRUBnL0MWn7IgFlsn9gMGpY
 24yLpeFsCPS4HxNZ+TimkDHE=
X-Received: by 2002:a05:600c:1386:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-49e61887f7emr37195945e9.7.1789117339357; 
 Fri, 11 Sep 2026 02:02:19 -0700 (PDT)
X-Received: by 2002:a05:600c:1386:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-49e61887f7emr37195245e9.7.1789117338841; 
 Fri, 11 Sep 2026 02:02:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26d4e3f3sm154070505e9.15.2026.09.11.02.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:18 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 25/75] tests/bios-tables-test: Exclude CEDT.cxl for the
 CFMW restriction change
Message-ID: <d6c53dc82516255a75c3fd201de0b8631d47416b.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Davidlohr Bueso <dave@stgolabs.net>

The next patch changes the default CXL Fixed Memory Window restrictions,
dropping Back-Invalidate.  Add CEDT.cxl to the allowed-diff list so the
comparison passes until the expected blob is regenerated.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260720233242.901544-2-dave@stgolabs.net>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..b4646b5b31 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/CEDT.cxl",
-- 
MST


