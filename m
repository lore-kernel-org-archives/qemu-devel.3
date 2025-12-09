Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BDDD3B7F8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0bk-0007ca-1o; Tue, 09 Dec 2025 11:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aU-0006HV-17
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aO-0001xV-8L
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765297749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VanT2WE+ursr7xSZ+Eyjo7XPa3JsB+zXfwgcoUfeiZg=;
 b=PNND0n+CcdFN1Fnjr5p5QKbRycN6WmC4/AVPVkB89hLcMvtasRID5TMh2dWIa0wwqH//9B
 wA5dJxFIH0YGoOENd3eGyvrDPRP4aTIZteVO6mdxyVSRaF8qkGgnQTlbCD+rSWzCNUF/pT
 ndNx8I8F3U3UmqLFji5W4hH6hgyoqMo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-vvaUjIVxP7K1MiaR24JMWA-1; Tue, 09 Dec 2025 11:29:08 -0500
X-MC-Unique: vvaUjIVxP7K1MiaR24JMWA-1
X-Mimecast-MFC-AGG-ID: vvaUjIVxP7K1MiaR24JMWA_1765297748
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b17194d321so667683585a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765297748; x=1765902548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VanT2WE+ursr7xSZ+Eyjo7XPa3JsB+zXfwgcoUfeiZg=;
 b=TOOgyew0Bc+VUGYGdKLDJ0ESJtsVpgAXAZhJN2iKWr9F6TZaFqLuRg8U0k29K1VWEd
 MWEaBxsradLimURMhhf1AcU9iwpGEfDSesVVJvLuOGGUtJmSl6wdETsbvsMC6folY/Me
 o+z9ZdcEtCX7f8TxPcsdOppy06k4yD7QTkiD6F1jhIgo/Vdmzcl4HLr128hbPen6ULjj
 bTeSPsDYKW6lTd5L8JSwu/hZNgYqwPDjUJIu8UUCg3pr16z/TpG8YZ9R2kuqHx9YYqEe
 7lEpmb2RgXdVdvxM+tidD8azwVtYYb0dDjebempJLpUN9j8Uv3oPWymOOUm87Wj84LHJ
 PbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297748; x=1765902548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VanT2WE+ursr7xSZ+Eyjo7XPa3JsB+zXfwgcoUfeiZg=;
 b=BkCqV/P2JgTd//pNYSAZ0RdzurDlaRQSe/lHTO4Qd2I9oaTwDLliZno6X4C2xaxiqz
 xHLZqaFxc3eWjI3m/3zL26LVqLnolo9WSF02q92KUxZQod2UMGUSAovT/6k02G1iFSyY
 O5x1zKw0FMgsNxi8D9IStE4+9exLo3nwyEudtQyOn89st+0NiKj+QrBM/WyOui0VvGQG
 wADH5XXHMgopN6S8OUPAzUYqhjcjoE/lc8mbdv7TysL4hRdN7SdHwy+L8soSzi0wuO3A
 rZ8mya2Z0+Ql+9OB/VlZGbfbUO+JC2b3Vfw5pJWp4JmddI/nAXbFODp3zC1gRK2mHGwH
 0Liw==
X-Gm-Message-State: AOJu0Yx05kB/0hvHlWLQtAC9e3yvyvSgSL6yIe/iS5EzY5kfWyQElnnV
 xDwzoNt7svGBXywGqJK7cmn/KA1cC5ypv/roF/dwZJuYEp+C/X256YKzd+mz9MpRFEyAvYaDDx0
 PI/UrI/mEGmYXvv2lXTSjvLL/PxwgJByxqDIG2IbcrvOXxz2q6KXmMH2OCa8MAx97pB0v5NgeHf
 qO5KzIUTMBYrP/G/lPDrXBk5VWsYTIvN4gE3JLNQ==
X-Gm-Gg: AY/fxX4VDaLePi+KfQkRjjwRWqrdUDVI0v6TU2Ykcpa2D2I2WxVu20xpzJ+pEdIFr9u
 a/TnuFaygUlBpSakG38/SX5vgTN3oeCDHSQUFM8cL8G+jIbb0Smzg2qnnpT8/jSJpCdlluAP3mh
 WPrFIBSIXwvHxJP+P3CFDUPx6sg79+g60AODENPKe/C9n3LKDW++gNmYe2rtXHtWDJ4O7M7JHEp
 Bew1D1TtcwuoyHRvZRn9fzw9GUjDWdQlxcFs2pi/c787vVOd690eG+UvTNHOhtl7Cg57GO4eEFZ
 WjNvYq9aR5dvR6obYL7MUJZo/0mXHVKFyY6nNDelVVGOtms+GWgOoeygfxOiEqcm4T2AjgeUcDN
 AX3c=
X-Received: by 2002:a05:6214:590c:b0:880:4c73:9e3b with SMTP id
 6a1803df08f44-8883db086a7mr178387336d6.15.1765297747893; 
 Tue, 09 Dec 2025 08:29:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyxH7vWD+j8O/RuCo97N8G9CphIRtFeRLPH66EqPO31aN6mODeEEsRjk4OJ9yKKhrvlNiXbQ==
X-Received: by 2002:a05:6214:590c:b0:880:4c73:9e3b with SMTP id
 6a1803df08f44-8883db086a7mr178386506d6.15.1765297747176; 
 Tue, 09 Dec 2025 08:29:07 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f334d8sm131110256d6.10.2025.12.09.08.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:29:06 -0800 (PST)
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
Subject: [PATCH RFC 04/10] accel: Inherit from TYPE_OBJECT_COMPAT
Date: Tue,  9 Dec 2025 11:28:51 -0500
Message-ID: <20251209162857.857593-5-peterx@redhat.com>
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

With it, remove the explicit call to apply compat properties.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/accel-common.c | 2 +-
 system/vl.c          | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/accel-common.c b/accel/accel-common.c
index 850c5ab4b8..b08eba35cd 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -134,7 +134,7 @@ int accel_supported_gdbstub_sstep_flags(void)
 static const TypeInfo accel_types[] = {
     {
         .name           = TYPE_ACCEL,
-        .parent         = TYPE_OBJECT,
+        .parent         = TYPE_OBJECT_COMPAT,
         .class_size     = sizeof(AccelClass),
         .instance_size  = sizeof(AccelState),
         .abstract       = true,
diff --git a/system/vl.c b/system/vl.c
index 5091fe52d9..a93201ef53 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2404,7 +2404,6 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
         goto bad;
     }
     accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
-    object_apply_compat_props(OBJECT(accel));
     qemu_opt_foreach(opts, accelerator_set_property,
                      accel,
                      &error_fatal);
-- 
2.50.1


