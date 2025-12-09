Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA67D3B7F8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0bo-0008Gs-HG; Tue, 09 Dec 2025 11:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aW-0006I2-OA
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aV-000236-97
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765297757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oUhACeP27aeW8CqqEIeBeQbpx7grv2BnAZbCMpedjyM=;
 b=Y9vzXUPzm1PDZLTBCqx5cdCG+pQv5iAE7XjXJ/Dw5ZTaPnTUpoxfYfJ1DgqGS8r1jdX8KB
 FKL5Cu0nX2dOmm/M6CWwCD6J3KZw7IDginrFcEAc3A7AsLCy24EtYc/vHYHC3uj280nzt9
 IX4idzniEUAiLHgMSizrP84Myexs+SM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-TSeNg1cCPe-JTQSdWJ6gvg-1; Tue, 09 Dec 2025 11:29:16 -0500
X-MC-Unique: TSeNg1cCPe-JTQSdWJ6gvg-1
X-Mimecast-MFC-AGG-ID: TSeNg1cCPe-JTQSdWJ6gvg_1765297756
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-882380beb27so101387776d6.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765297755; x=1765902555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUhACeP27aeW8CqqEIeBeQbpx7grv2BnAZbCMpedjyM=;
 b=rBvyXpk7tcndQHFicQLFh6imTpsgzf8BRcOW9teRbo5mOxAYrdsEwao1angMNn290s
 izCxdhp6+faFo23d8E5/d29HtUjS/izuL+1QieqzRamkxxGdm7vlWawuDW7gyxgQL1ul
 62FFsnZ7VIYL+hhe/E9j1YeWJ76bs8lLtGcOlD2bxR0aQIVgbQkWlZmAHTkRpWsLZvBV
 AM6hsJ+2WDNTX1hKBUXWnw0mrxLx1v3gBj2KRovdUjfPiE7dRvx+1Fc79u+FQ6RFzmTA
 /BSLuXYbq/PjlugEbgrrktsiOqaysvSd9Gs2DMS9dzk7mQeRnFPWVtHRVffoUI4uVvKu
 pCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297755; x=1765902555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oUhACeP27aeW8CqqEIeBeQbpx7grv2BnAZbCMpedjyM=;
 b=vtQByx0IHL/N82czuexX250MN2ZTILBzxi19yNINDGAurBDQRKl8TAj4KpgddtnXXx
 n8Twt3vzFUAywaB8KLa+3a1odfaO5D1IGvamQGs3PK+0XkkH/5DZM86F8PvpSnDc2yZX
 TuJmQDkgb6tDXzQul4gOzNhXowMIx3gUNPE3zyrtVN81rqBngvyGX79s4QXWI7uCoOpZ
 EmMzQFDmlQ7AyF7mrz9clX5kaOOWmmOnbaeM5h1tTsFUCYEbtOz0OShWxwosvvZBB9Hs
 TxZ2NFIiY3KQl5iu6WPwheS59Smho7gTWgodR6VYlrgitErXd3SHH72D0boiNdCR2zS7
 Z/qg==
X-Gm-Message-State: AOJu0Yw2Mi8QTjy6YEF8eN3jNNFbsh9rhkT+gMngzwezJUKBHE6bXZQ8
 d2CMPEq3nSgWZobmhFnz405PjU6/xu9kqPrMYWO8us64dpyFgvabo8hy3DOVFKMVa2bneVmcYYm
 YovBgDMJx+ze6rZPBN9ps1Asfk83b0p5wCttjEIOLL7I1bb8KNjeCjm/zrqBmN8eFOiAhWjuiD0
 HlgWBbYq8LdzVdLpZw4zf7JvK9lE75gMcC/sDHGA==
X-Gm-Gg: AY/fxX63mUVKEdFNjvzGcT9v9YdzVyl4e7uWzH0dfkCWT2enUViV9kUR6E8s7pKNSIC
 XbUCqTErIXd3wK292ySj6UvxtRaAmjmaI8qKcDBpOt+yo9XWED6mhE72P6IedptZNf7ktW/hRPx
 0yaf9sfPz+xCeQOyX32+SHwGTxz4fiHs7zBXdFqNQ69rUSVqRoCsLKm7SAyRPPYtqtIzE4AkoQA
 RCax13HyPy7GDsZ21n8S3cAw70FfUxrbszyzlznS8T0c0Zb111A8YGqEw+SjZuyFiCyrx2Atp8p
 +tMYnn3GRjwXd3THRyyF484DY+sLdGxArVsdfOrUA4McUEBlESPOD6mVEGeihsHoRfuUFMkAcwz
 ciAQ=
X-Received: by 2002:a05:6214:3308:b0:888:5890:2d55 with SMTP id
 6a1803df08f44-88858902f35mr48764256d6.47.1765297755171; 
 Tue, 09 Dec 2025 08:29:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIimkXcA13C2s8FkDttY4MZsc83WmSaJSpHpJjlTSIUCua7xIxn29bHPwDy9/qixwDQGOYSw==
X-Received: by 2002:a05:6214:3308:b0:888:5890:2d55 with SMTP id
 6a1803df08f44-88858902f35mr48763466d6.47.1765297754667; 
 Tue, 09 Dec 2025 08:29:14 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f334d8sm131110256d6.10.2025.12.09.08.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:29:14 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH RFC 08/10] qdev: Introduce helper object_apply_globals()
Date: Tue,  9 Dec 2025 11:28:55 -0500
Message-ID: <20251209162857.857593-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209162857.857593-1-peterx@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The helper allows one object to apply anything from -global command lines
to an object.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/qdev-properties.h | 1 +
 hw/core/qdev-properties.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 60b8133009..f064992ba3 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -226,6 +226,7 @@ const GlobalProperty *qdev_find_global_prop(Object *obj,
                                             const char *name);
 int qdev_prop_check_globals(void);
 void qdev_prop_set_globals(DeviceState *dev);
+void object_apply_globals(Object *obj);
 void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
                                     const char *name, const char *value);
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index c8110ff0b8..7d1a443266 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1036,6 +1036,11 @@ void qdev_prop_set_globals(DeviceState *dev)
                               dev->hotplugged ? NULL : &error_fatal);
 }
 
+void object_apply_globals(Object *obj)
+{
+    object_apply_global_props(obj, global_props(), &error_fatal);
+}
+
 /* --- 64bit unsigned int 'size' type --- */
 
 static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
-- 
2.50.1


