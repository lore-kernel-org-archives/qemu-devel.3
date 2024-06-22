Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B408C2BB85
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu3d-0000Zz-IX; Sat, 22 Jun 2024 02:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3O-0000Sj-O0
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3N-0006Uf-Cr
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719037008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrycet3jL1WSrURyl4kYUHh4gIffr2JcIs+cSDvgvbc=;
 b=I5HbbvpvLtpX52JYXAen92RQhZk0Nb15mL96GpdPzfDIMSRSqX9ihFtUTfHaLSlvUWU91P
 iv1RaMOsZe/VEu90p6ETPNYREHMY1EUVExhqMkM5+9DtObZW1g0hZwDsMFs4VGHLwLyg4G
 dCEGsMFbmI/uCX70E8SfxEJhbCeHZhk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-BUyPwInlNt2yhZJF7BGTvg-1; Sat, 22 Jun 2024 02:16:44 -0400
X-MC-Unique: BUyPwInlNt2yhZJF7BGTvg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6fe871a5aeso8412266b.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719037002; x=1719641802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrycet3jL1WSrURyl4kYUHh4gIffr2JcIs+cSDvgvbc=;
 b=Hc/Cm/TM94l6EfFp9MYhUxpPHxLDLZWOuVk7xKKNpJuycY38krI/B9tgVDddWrSftm
 FXRhQh6qBOyargP9KsHLIXIKmpaCRjMUK+j5rerqyFI0iN09dgIzNwkjDNNdfxyHqD5x
 qYaJZaY3zLg2nEa2ScRoAqPQV8knMQCray3NaqiUGiJIe8vfoIAXW7AbCvnkAPf5kMIS
 dGVdIqYn+vYiMXhEg8KcOs27tjFYz5rmubVgcumIpsS4apb97XnrvVciMrcr0Wnoc0PA
 KZPHlmer1nTq3k0c+sJ1x8+SYMOladxBHfipm2Uf1K9XoNdl0w0OhBssG3L6Ejf+qksy
 owJA==
X-Gm-Message-State: AOJu0YwM9lWa/NwGURFGyRoNl0vlbxeRBQ2sffW5PlZTp4smtQG1DBUQ
 hdXAyC+oQ/k4jsC2qSPF9J/JMxGGJ57Q1nx6gvlPn16ctP9+lu2kytsKZxIE36WfWhlE/iuDg/T
 d/q0/phgBCoLRnWsxYUo5kkEPE8sKayaGbAb+A/YbBYm8cjj15CAD7VnGEMdDpGB+Pf65GhKXgB
 3MqmeoUOeCivKqiVdJ2XmkluD7V4gyDl6/ZHNN
X-Received: by 2002:a17:906:bf45:b0:a6f:5db5:71a0 with SMTP id
 a640c23a62f3a-a6fab602c9emr712358666b.14.1719037002612; 
 Fri, 21 Jun 2024 23:16:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG02UMRoMIQfh+0IUhhOOuBtKoryQodMVv5YNLt8O0yU4nfSjN1jAB9D9ZlT/3pTSXFC04Rag==
X-Received: by 2002:a17:906:bf45:b0:a6f:5db5:71a0 with SMTP id
 a640c23a62f3a-a6fab602c9emr712357866b.14.1719037002238; 
 Fri, 21 Jun 2024 23:16:42 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf560ad2sm158996266b.173.2024.06.21.23.16.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/23] block: make assertion more generic
Date: Sat, 22 Jun 2024 08:15:52 +0200
Message-ID: <20240622061558.530543-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

.bdrv_needs_filename is only set for drivers that also set bdrv_file_open,
i.e. protocol drivers.

So we can make the assertion always, it will always pass for those drivers
that use bdrv_open.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 468cf5e67d7..69a2905178a 100644
--- a/block.c
+++ b/block.c
@@ -1655,8 +1655,8 @@ bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
     bs->drv = drv;
     bs->opaque = g_malloc0(drv->instance_size);
 
+    assert(!drv->bdrv_needs_filename || bs->filename[0]);
     if (drv->bdrv_file_open) {
-        assert(!drv->bdrv_needs_filename || bs->filename[0]);
         ret = drv->bdrv_file_open(bs, options, open_flags, &local_err);
     } else if (drv->bdrv_open) {
         ret = drv->bdrv_open(bs, options, open_flags, &local_err);
-- 
2.45.2


