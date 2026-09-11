Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDAFC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9c-0003Fk-6L; Fri, 11 Sep 2026 05:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9P-0002bx-GU
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9O-0008AG-0N
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YYj6Zo8VlXl2zP5B4qr6Yw7Ml5uWH4dbodIZUAM6V0A=;
 b=SZ4JfrZQww8moqa80aLGy4HTyZHdLssmSZ6nvYO52PKn0uTmpLvBlOIDXTBBOYFIQCnzBd
 B7FJVNkBl2e++SIC55rx+7crHoH6B6dB18HEM48YK5oYMcVv/d0ALNZRNz1Nl5UHXam7/p
 ivEe4dOSVBX1wupbwSQ0KcYm/jQnPj8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-UkC8hZPiMGuZY7TYjOTGCg-1; Fri, 11 Sep 2026 05:02:23 -0400
X-MC-Unique: UkC8hZPiMGuZY7TYjOTGCg-1
X-Mimecast-MFC-AGG-ID: UkC8hZPiMGuZY7TYjOTGCg_1789117342
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-486f187f2cbso145764f8f.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117342; x=1789722142; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YYj6Zo8VlXl2zP5B4qr6Yw7Ml5uWH4dbodIZUAM6V0A=;
 b=QFqyLMDsT56Xle17Fjfz5oJ1JIFDrw+O8V02JXk3jIlWB5paHSaS1mcuYCvLOjGOCg
 NVwLVSiFPWdhw9+ZhGrTqxHJZkrkXrf8hPzzu0cfyLOvrqsbEhW+/dDqV5kODGdOhqQ9
 olgX5fDjxd6Bv+dUlD0c1ZQQ5QfvNqjIqRO6/pHRJ06F1nKEiR8sIPo+QUfSsCfrly1O
 WINIoiMVp1Vtza7b2iip88g5bm+L2MmpJP+9auFEq51qs3pqMCsocOLQpfUWTpaGNgy9
 8f9H8KQ1J5MpHHLkcY/ic0P8iZDMTF/XTHkiWsm3UDepK8RoXSvBfGc/0iLfMAsRfskz
 lbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117342; x=1789722142;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YYj6Zo8VlXl2zP5B4qr6Yw7Ml5uWH4dbodIZUAM6V0A=;
 b=VQnQhyCDOX15cjxKh+sztDtCvrYib8RoGRaI1im/WzF8dM5Z1626PJUqt2uoVTidnz
 /gar+MDGoifOVsdHTNgrVkoju5Ilryu4AgRTXzbEfQ7dDV4oDJKZM+mU+OYgAC54L/Dt
 41FnXzhNoxjKfSkiaNK3T7EqW6sAIdIukCtb5jMXFf4MosgFa4nRU46z0UiSfI0TXyUC
 0+h3s9ePSZbff5bxXoaFEF1I55RjYGlDsFDPzPmPwM9YSfjJ0RmBdUiOA1ycD1yFE0S7
 H9V+5e1A1svb5GrodHvqSOIbVeg3SeWxI6lWnJgaJUhpwALYLXUzkDQSBGtbZzca6oxI
 kOdA==
X-Gm-Message-State: AFuF++mVegbgvoE8TlRUh/kAnNT3zHLTkNhgJErJmmpf399i1KJmDIML
 S/pv2qcXTzXhkVGFhj1YAgL5ABz+5oOU61Ann2ZufbkqzcJmzIVngOY7VdS5Zh0bQJWtltumjmf
 J1HXdfj6oqqxiMUcLKIWhpLOkWPBnoMe06qyl9EbIGxdwSLmY8dkSUBjMlFZSdIgdoWaBYdUs+w
 AV9zL8+RgQWu6Us98wx0TGMN3eJKt1BEo27Q==
X-Gm-Gg: AYBFou1coXQYH0fzjR8860ymw4TCdmSSdlnmVftS8wywrANlHx3wn8tqeAcVTEW2UGm
 FLlU0/YnCnh7Y59ou9KsLqDAI+wmxYrt2ik7rvzigNLFhiQ8d6zg3u46IsanDgKS+nA51lxKjEd
 uSRGwGOnsVpU2WtLe6VvR6a8lZwCa/KC4wKcZkjUK+Opvy6QQYGc+M2c1bIKeil4C01d7m7M3h0
 +JFewXDJfzVD+7QGL0LLUjScTbIWs49X3IIRtk++29BlKt1jwCXA5zzEo/weuYY8RIjwgmpP2cR
 CLdfLCfnLwEwHAhHFHRBT10N17q0DQJUICa/xAp8zH+ZrcnegU7drH3dQnQFeYNBcMyJQKOqz+u
 OpJwZzNX2iEWAZ0+DSME8ZzU=
X-Received: by 2002:a05:600c:548f:b0:499:8174:9f39 with SMTP id
 5b1f17b1804b1-49e61639fdbmr70631845e9.0.1789117341578; 
 Fri, 11 Sep 2026 02:02:21 -0700 (PDT)
X-Received: by 2002:a05:600c:548f:b0:499:8174:9f39 with SMTP id
 5b1f17b1804b1-49e61639fdbmr70630755e9.0.1789117340995; 
 Fri, 11 Sep 2026 02:02:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60a8a89esm59268305e9.1.2026.09.11.02.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:20 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 26/75] hw/cxl: Drop Back-Invalidate from default CFMW
 window restrictions
Message-ID: <ec95bd16944f4d0f844e726282552174b63144cc.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Davidlohr Bueso <dave@stgolabs.net>

The default CXL Fixed Memory Window restrictions advertised host-only
coherent together with Back-Invalidate.  A window advertising both
simultaneously is undefined behavior per CXL r4.0 9.18.1.3.

Drop Back-Invalidate from the default, leaving device-coherent +
host-only + volatile + persistent.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260720233242.901544-3-dave@stgolabs.net>
---
 hw/acpi/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index f92f7fa3d5..75edb2c0a6 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
     build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
     /* Window Restrictions */
-    build_append_int_noprefix(table_data, 0x2f, 2);
+    build_append_int_noprefix(table_data, 0x0f, 2);
 
     /* QTG ID */
     build_append_int_noprefix(table_data, 0, 2);
-- 
MST


