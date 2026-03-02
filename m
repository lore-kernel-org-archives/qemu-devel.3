Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9FAC624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyze-0007is-CI; Mon, 02 Mar 2026 03:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyws-0003Ds-7i
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywq-0002DA-40
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xOgp1TyXySYCJXAWxrtyTkQClS+QjMqnGfrNC3gHDoU=;
 b=D+aLgtmZNhE/EL7bSFuA5QRazya5Rck2PcX+/QyuDVy7Pyhp/UP6cc67U3JYTIas8tjH6O
 /CUoLRqyA7WiBJFMXjnJ0pbr9jAS0L1sG4OOSXs/JYYgATB8E7sbRjXiuOil+RCTdWgdSW
 H3Rj7819y9EPcU/kWNei58Rs+ChUjHM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-jEU0CwkePxmSc5d24YYveg-1; Mon, 02 Mar 2026 03:48:14 -0500
X-MC-Unique: jEU0CwkePxmSc5d24YYveg-1
X-Mimecast-MFC-AGG-ID: jEU0CwkePxmSc5d24YYveg_1772441293
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836c819456so28196515e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441292; x=1773046092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOgp1TyXySYCJXAWxrtyTkQClS+QjMqnGfrNC3gHDoU=;
 b=lExUTYvERMplugioUeJZpJ1ENSqIr19RM4yFWoxNBtKJpULRK7gIT64lwah8LK2Ve/
 j6Rq4Eyg67WdPbkPCsxVaIbSez01TUrIWIgr5/7rcTXPDmOvIQUtg545+DPgT2OtNhrV
 2W86tr2LQkvUJdNQYaexuC2QShyRUgC+xBSTUZ5WFw2MvhnSNU/xGA9swH6mshs1FT0+
 rLP5iw+a1Zqshs6zNzWuUJBNWeCyV4KS5kot7/w/j3rrwTqFg2YfjM+4czw8KrSQSaGX
 lZ+s4BgPc8vLiFDtUOd73cbILStLU3u2HVQjfH+rMBaCIghiMvrXybBH5qnWeFibyOfD
 +FeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441292; x=1773046092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xOgp1TyXySYCJXAWxrtyTkQClS+QjMqnGfrNC3gHDoU=;
 b=UxXDlytUjcNDehi1FqT3jK29eN1Oxd91fzufqfV/HyLEeJ77Y+sIk+HpUx9RRMhQkq
 dUe10liieLI8wBvemnaFVUUlN+/RGBal0mOaH71u/dtT27h7coBFFq+TF1jhSEfc4dQ1
 dE8ycFcTBHtT0Bz+Mb9IPl+UeP3F5TjGhLj1uIwgBLOe+Limk4+CxQthScb9oSoFL86m
 3RVcdaa8IH4FenK7t/kA3j1crGs7ibaET2Pu4CFbPEJHgnsl7gJRplo+bMDKLum+KEGg
 eYSGEQ956auqloxyL5IiEyXRU7Js1OONF7C8Umn3PKu4lQdWbmGxPuGUoFxyK0W/bsms
 kmMQ==
X-Gm-Message-State: AOJu0Yy5ta2jXAoV+RVE5NoRE1KP3/0qjcIzcpA3aOPmg4vodzIPhs9D
 DNkJ5Mwgd9zgMeLsKm2sb7onHTj6f88G04pSiuJJyWYSL8rcbI3QCRHoVNWnIBL44PpII2+kN/p
 WTS6Ka0YS8udbUwKATrLY7sXSFsUEJKcQZvS/d53HTsC5jEg6i8NVNgM38cVNT9MkXIXT7eDvdB
 4VPOe7ZLH68QLiOgwhqrgX/HNgPRGxtMwop4G7cXu/
X-Gm-Gg: ATEYQzx2WS3d7bOFimlYGJvvA2qwP1qRyd4xC7UGq6SmyQeifjvTX1o/2vUrPUUIlJV
 BqgZDRzg4Z6N2cCAv/Q/AU6b6oJkSnFAseXa6HcCvhQIcJkmz3tSZjUlTrYxRWlZHxKkpHtk8Qp
 m5b/0mbqRkn7Bn7PNTlgN2k8GJN+aLgnapANSPAleW8pl75ZrfozZ8AbbHFjbZsVgv9IG1ukw/8
 LlPUoF79qmHQ4NOLFW7ea9FKHeI8KoOzVctSCIHxT1plwq7XjxP6z/TqKTWXh0KcRc7pO+n+BUA
 LN4nZTXXb2bWT79N8dVWl7X3Wrq7tP6Ahh+wqzDBrN+AYuXLcRUjLs8zVaA0w/ashiWHdSeH/uo
 oE1XFXlBEMUXgoUERQPDk2T4M7rMvRPKI10WPLvp52O+ZO3zytL/3eyWKkI9NHHNJeacqw32LfD
 MC4/Gw1WdyGc8MHSp7kiJEiXiiml0=
X-Received: by 2002:a05:600c:8b54:b0:47e:e20e:bbb4 with SMTP id
 5b1f17b1804b1-483c9c24124mr187287545e9.26.1772441292454; 
 Mon, 02 Mar 2026 00:48:12 -0800 (PST)
X-Received: by 2002:a05:600c:8b54:b0:47e:e20e:bbb4 with SMTP id
 5b1f17b1804b1-483c9c24124mr187287145e9.26.1772441292010; 
 Mon, 02 Mar 2026 00:48:12 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcb318fsm194677365e9.6.2026.03.02.00.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 076/102] audio: fix nominal volume channel (cosmetic)
Date: Mon,  2 Mar 2026 09:47:22 +0100
Message-ID: <20260302084749.474955-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260211-cleanups-v1-1-e63c96572389@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio-mixeng-be.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 37040450511..5878b23e04e 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -1649,7 +1649,7 @@ static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw
 
         sw->vol.mute = vol->mute;
         sw->vol.l = nominal_volume.l * vol->vol[0] / 255;
-        sw->vol.r = nominal_volume.l * vol->vol[vol->channels > 1 ? 1 : 0] /
+        sw->vol.r = nominal_volume.r * vol->vol[vol->channels > 1 ? 1 : 0] /
             255;
 
         if (k->volume_out) {
-- 
2.53.0


