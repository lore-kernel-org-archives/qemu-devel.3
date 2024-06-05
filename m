Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA58C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0Bu-0003x2-SA; Wed, 05 Jun 2024 19:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Bs-0003kT-OG
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Bq-0005yr-QB
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4UiaVaJHqFRMzcgj8Lsoa2O3CKB9KU5Hs0p0vn09PA=;
 b=W3T3/mYqvI9roFRJFZU6CehW/wI5SpTVksBd9cGp/v8WEgNTuITy/C+SfxCSMzp5gNorHi
 B5QapFliQVmz+LReKTLChEloTki3uHnADY2kAC3bCEu9mQy/cMZxHLRdsNTruKOBrFZyhY
 z/VCrfNZkqdqnIQXb/f+RZqbQ9X0dtI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-SbfYliuFOvSrKmKgrtaWHg-1; Wed, 05 Jun 2024 19:37:09 -0400
X-MC-Unique: SbfYliuFOvSrKmKgrtaWHg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57a306c4b1eso129320a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630627; x=1718235427;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g4UiaVaJHqFRMzcgj8Lsoa2O3CKB9KU5Hs0p0vn09PA=;
 b=haHxiSXh41s3hYwkWEi58wa6hsLJMF43icZLYAbYKe/MDYsmfiOJQlPbUHhxHwR4Pw
 Zho0TMgBmP13s2Kep8SNUin/qDPYf2irvtWTNo4m5VhnIIU3Z0ggkhcNhwaur76cJ62e
 1U2RZtXGAM0UEqKyH6dolFvGu/qWYTtH7S2hK4BgdKcCt73F9N+sbqnQVBQtQ2i+t/iK
 xdYdIvd87spU+kMwaL8oBhemGlzLejsTnHVZ/FDEG71WuumkYs/RZz5yeT37yc1r4S7P
 CK2jgGfihmV6w/HhCK7WxUtkT9plEG6rpAm1ouXl+9qp0XVaEj+ePCCnm4U6n8xwB1CU
 5NHw==
X-Gm-Message-State: AOJu0YyteF49wKdzYLyKDTWM1VIkNlY2Kqz8iulERz9cx1E6CicAkz+3
 bdZ7HpqWj5CjWhaLbQI24kPAd6RLe/82LcKO+oajqqdJXz59xU2gGsDko7mZlEAomtiYBfdI6JX
 F5ZS8S0e52cNhppusnTA++E8GpK7mQ5ZrOo3N68NGUb3qQ0t6y9Au1gC9WQaXbVj6PmqX9IVv3D
 itxbKoLEf9sq4sLHeZojbPCFyZZDOmTA==
X-Received: by 2002:a50:8d1c:0:b0:579:d01e:bc4a with SMTP id
 4fb4d7f45d1cf-57a8b6f0fcamr2488076a12.23.1717630627424; 
 Wed, 05 Jun 2024 16:37:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbgOibedZ86c6XPLojH5Srm+ffFsLXJaUTl/mdoQQBFjBkzpWcuzjgSZdRCihBWzNlCKiRTQ==
X-Received: by 2002:a50:8d1c:0:b0:579:d01e:bc4a with SMTP id
 4fb4d7f45d1cf-57a8b6f0fcamr2488065a12.23.1717630626888; 
 Wed, 05 Jun 2024 16:37:06 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae201a6esm94575a12.71.2024.06.05.16.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:37:06 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:37:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 39/41] Revert "docs/specs/pvpanic: mark shutdown event as
 not implemented"
Message-ID: <e71399725900a1d4edb0e0fdc61fdcd2bc3e0fff.1717630437.git.mst@redhat.com>
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

The missing functionality has been implemented now.

This reverts commit e739d1935c461d0668057e9dbba9d06f728d29ec.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240527-pvpanic-shutdown-v8-8-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/pvpanic.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/specs/pvpanic.rst b/docs/specs/pvpanic.rst
index b0f27860ec..61a80480ed 100644
--- a/docs/specs/pvpanic.rst
+++ b/docs/specs/pvpanic.rst
@@ -29,7 +29,7 @@ bit 1
   a guest panic has happened and will be handled by the guest;
   the host should record it or report it, but should not affect
   the execution of the guest.
-bit 2 (to be implemented)
+bit 2
   a regular guest shutdown has happened and should be processed by the host
 
 PCI Interface
-- 
MST


