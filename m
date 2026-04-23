Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B3FF9936B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKl-00012Q-QY; Thu, 23 Apr 2026 06:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJy-0000ib-DZ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJw-0005kK-5c
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOuPjc89EHllUFep7jGoHo94oMz+W7UU+Hi8tYvFcJs=;
 b=OJY8FrRgOsrPssycs26+jCyvwbwGIgxfeDvmLjJVzPKc583coFZEQxN6V6a6Z/iXvHKYCC
 hjDgepTA5Nwcrynp9KrFV4d4K6O+acGkD+bvPVy5IZQfnyjSM0ag3QNMHEowLxjHtP7FLi
 lhe0Wqt1tfx23CDFLTKfelqZ+/5Uw3c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-rfv0lUC-PTOPt6F-nFkk9A-1; Thu, 23 Apr 2026 06:30:06 -0400
X-MC-Unique: rfv0lUC-PTOPt6F-nFkk9A-1
X-Mimecast-MFC-AGG-ID: rfv0lUC-PTOPt6F-nFkk9A_1776940205
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488d1b5bca0so37746815e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940204; x=1777545004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOuPjc89EHllUFep7jGoHo94oMz+W7UU+Hi8tYvFcJs=;
 b=l4viq246YTVDn1Byn2rA4ABjdkxVm82Vvt3Z5rEXl8+uq/9Sm94w6aVGX6Sz0RzEFu
 S/0rrhLnqxG2IQ9SZYYFhGAwbNZBVEXAdnWBfzW2Ihgr5MtCBAeDwmIQfZqYIiGXJfbu
 eUK//tpRh8/jDEqzMURdLHHQq5ky5MVa7A0iQDbOFPU8EeO9DpB6ZB0+TndOkdH0gEgT
 dVVusvSXAeljLQmqvCLhH/E+C7fKvhCxzZAtYAw5JhRIbwBPWmcqOoWCq0jpavjcsqBF
 W4ZChF1NB3vKC5JP3au2Hx42HAwHIz0mWRddNn6bwgqulxrnCfpMEyVlhhK010eGaiZF
 FG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940204; x=1777545004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zOuPjc89EHllUFep7jGoHo94oMz+W7UU+Hi8tYvFcJs=;
 b=gVLyjsYOnRv0t++sN9WenBiYM4K158LCTK9zff1fbS2XGXNQokyJ/nmE9EfPtpSkmW
 jJXN0RMZCsIuoCCw978wv9jJOmR9T3LGJnPBrGwXcvTL07e0TPgXOPxLVfBlTedqPPmg
 W+lCRgO1ZYppwFXFvcZfxKPO+D0nJiKlmFqSF6HwsWExh4ojrLhz1klwFHXMap8tezYv
 sVaVu40ONx5jV0rJ+ZsCVLaT4on5eDI8/uWv4z58z9atBW2nNWK1mpRS+rZxOwjFOR/3
 AEPdyvT1V6yrQY3/WsTV9M5iGSHcAiyhpC4x52K/OESc13adYOepPeKGz0Miuj0iyO1z
 pDwA==
X-Gm-Message-State: AOJu0YxRR155HqHXfaYkkM4Rs7CJ4u43mdenCxkgT2lX2tZmcLIj5QWf
 3dF21a0et6JTUrmYAtgaStAmVeE9p2+73h1RjAGcSPP31eF+P6GrVMtcn8n4wzoJGOIjjeBXLwx
 txp4u0K+wVxf5In4yB5ZWWC2sTfy1EmkAv42BTlBRvB6o7XLk3uGnEMFDTCqz+LoLusBxyUYX5W
 PR4xVIyb/6ETd12rdQPROPamrDIPehBsdRnttnrlrR
X-Gm-Gg: AeBDieuAsETQDnSdJ740elBFOiGIEEOg4Umivc16uXg3iaxwA5yn99byAIV3dkzDpmp
 r55gyWWQTa5Yin5grP+NvmPNIIMjj1Z3cc0IQkVKz6fJkxA9lgCM1U7ncDboRlQfk6Xw9Fifvrj
 TFUKaxYtKJ3seTTDG89ptQPHT5cvviZfHoZy3/MaD47Q/MD3T4gK0J3imN1bBRkHBqKh78Vs31I
 WyY3FUaVH15KoNo1pgW4kwpszADWU+1tX/lpH37nNxxVlV1+29EuJL83+Y9UuPz1fGjAqUAWr/M
 xw1/k6XicA3qFDXr9CsJLhbYxase/d2qLiUqRef0lMsRfxod/DMYP8z6wjlsvwJ1tpXiPNltlu7
 HjqxQNNf7PsfQ3gl5EqSucGlATLlbhOLQ1ljkcF+/X6Rvmj8s1W1wmSi1PXMyY93kWQhivN0klh
 wVyg13Dae78W8GPiKrxKB/YQzdweHpdBzZf4o=
X-Received: by 2002:a05:600c:a416:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-488fb73b31dmr316563415e9.6.1776940203938; 
 Thu, 23 Apr 2026 03:30:03 -0700 (PDT)
X-Received: by 2002:a05:600c:a416:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-488fb73b31dmr316562845e9.6.1776940203364; 
 Thu, 23 Apr 2026 03:30:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f82bbsm875487775e9.3.2026.04.23.03.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:30:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/25] util: Remove unused dirent.h
Date: Thu, 23 Apr 2026 12:29:11 +0200
Message-ID: <20260423102922.443639-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

This one is OK to drop, because the rewrite of path.c in
commit f3a8bdc1d5b26 removed the uses of the dirent.h functions.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260327134401.270186-13-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/path.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/util/path.c b/util/path.c
index 8e174eb4364..72a255890e5 100644
--- a/util/path.c
+++ b/util/path.c
@@ -5,7 +5,6 @@
 */
 #include "qemu/osdep.h"
 #include <sys/param.h>
-#include <dirent.h>
 #include "qemu/cutils.h"
 #include "qemu/path.h"
 #include "qemu/thread.h"
-- 
2.53.0


