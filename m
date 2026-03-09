Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56BDF41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEP-0000cD-TI; Mon, 09 Mar 2026 11:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEO-0000bN-O5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEN-0008IN-B3
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWcGLprdpXgo2UanWZOxr3c/Uu5d1zE+FoOX3fFgguc=;
 b=Pq8uXTLK9hKBxu7F9zUpfcxk9ymEZ+NqEoKofjiopBDLccFlPzXXLSwF3TGhlRc4mxdJDN
 k+AoxuKmwuiUUAxKuoWth9OeE8cQuxm1UYXD0Xhbk01qQvjwa6BH6jGpoyqZXwvLAzyrB7
 BvpzB9qv/D5wquTwAfzVCabA5V9jynw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-m-o9joejMzSNlNxPwQj6fQ-1; Mon, 09 Mar 2026 11:09:13 -0400
X-MC-Unique: m-o9joejMzSNlNxPwQj6fQ-1
X-Mimecast-MFC-AGG-ID: m-o9joejMzSNlNxPwQj6fQ_1773068952
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso138886095e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068952; x=1773673752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWcGLprdpXgo2UanWZOxr3c/Uu5d1zE+FoOX3fFgguc=;
 b=P5IRwU7+4wM/AP1tnpMigp8OkY/Me/VBvHpkp1Jn4MAsVKYz4Yk/gwFmUZ1EFv6wg3
 tvR/jiY/xAHKUsMmrwQ1qx20T5uDRn7fUZpIfKx4JKlMgcZciXwWt0YMCavU/QMHbXcd
 iMyPKamnpFeXERcBHgMU0VdtT91PYl2QZknQIHn8q+cyHQ773wPpYvLi1WCc312WAB9n
 tWob8hI5nEk8vS6j8g4Ddtd9VDNNaGs17fmmGiK/w/UHF9jDKafW8wY8IWv3oRatRD09
 3CWgyfcl7eoYKER2BrulwDXkthcpraBAy4CM9pa523IZxBQAJ/6vwHYDtutc4RbFrsll
 0f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068952; x=1773673752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yWcGLprdpXgo2UanWZOxr3c/Uu5d1zE+FoOX3fFgguc=;
 b=GS0grPAQrH8SX0kjQWW2AEH1+1Qxsg8jJi07vq/oEHwKjmMMAdqrfIc1N/nZedjG2u
 UwXOvpArMNnvZIoKArJeK1Eno8W9KOTvdHBedpSpYFbNXDe1WvDeTJUkKLyyJzqrlhsu
 sZVwSUXq+tYF11NKI+E9fdOqotjIUkmAJFgS4f/QsAXycBjz82NEEPcQMUFtcXkpunOJ
 RiT8WCS1b6NpINLRlHKuG18v+p353mkJ8PoV9k5hH+Xc8X6Ut/Lzy5OND1HbzHxN9sDf
 7WoaoapcD+3FNO3S4X/ygjndQB6cEIXjuTxS/rFBMdrC1/bGj5bXwATSJLeUBNKDtWPp
 Hozw==
X-Gm-Message-State: AOJu0YxKmpJ9PFdxXGXyMRSrB4I2rp6wM6g7oF/iVEU8g5IKfsRS7GTQ
 NZPgMNlQuX68K9ILrXdqjhiT2S4Fzvhe0vtx2gzRlBcjO0wn+0F4GfnbzFET6VR4JT/LLTVQr3F
 6xzhlC8g593TahlxYkmsrnAZpotkV10+YUO2iBBh6ajloJv39NxIngzzP
X-Gm-Gg: ATEYQzwz0XsKp1ReLKwagfzKeyMfXWc/4hd8JVzmTB4M1sIqvNtarszV2YJFJLGlNFi
 MlpAtN2uEWSaZobbX5oxTuRu52TtUy8wNwopvv1cVKhPuldOEUB67cXAqR2P/T1/EE80GKBgQ6h
 LNiaVUC2sKbRW5QYGZ+OKMQzX51BQ60KyliU4VXBp1NhszDrs2C5vHF/6C0lKOw4JDO3c0lVjjy
 /KF3lPtL6zTt0vTyWx0/AvvVxOIzYJt8Ll3M6VSVFfXdfnw/1eh4J0lkiE7rwNC+B0xN7HbrD9+
 ypHkI0lHWGhF0br/GSqflGLvKF5oulFaRoEZ95IRObAqo3eE5WlIaLuTcSJxjAQ+l90liQaxXrw
 WMyvbVWyUF83lstPIN7vuxC9U50RBU9HSXLz3zBYLuE4lCRJGnxTqaU8XtSTfGSWKx/mK0w8olb
 +dgQkx
X-Received: by 2002:a05:600c:8719:b0:485:40c6:f507 with SMTP id
 5b1f17b1804b1-48540c6f66amr16944005e9.30.1773068952164; 
 Mon, 09 Mar 2026 08:09:12 -0700 (PDT)
X-Received: by 2002:a05:600c:8719:b0:485:40c6:f507 with SMTP id
 5b1f17b1804b1-48540c6f66amr16943385e9.30.1773068951608; 
 Mon, 09 Mar 2026 08:09:11 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485345acc69sm46428185e9.25.2026.03.09.08.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:10 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 02/25] fuse: Ensure init clean-up even with error_fatal
Date: Mon,  9 Mar 2026 16:08:33 +0100
Message-ID: <20260309150856.26800-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When exports are created on the command line (with the storage daemon),
errp is going to point to error_fatal.  Without ERRP_GUARD, we would
exit immediately when *errp is set, i.e. skip the clean-up code under
the `fail` label.  Use ERRP_GUARD so we always run that code.

As far as I know, this has no actual impact right now[1], but it is
still better to make this right.

[1] Not cleaning up the mount point is the only thing I can imagine
    would be problematic, but that is the last thing we attempt, so if
    it fails, it will clean itself up.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index cea9de61f1..2ed22c6b2f 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -119,6 +119,7 @@ static int fuse_export_create(BlockExport *blk_exp,
                               BlockExportOptions *blk_exp_args,
                               Error **errp)
 {
+    ERRP_GUARD(); /* ensure clean-up even with error_fatal */
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
     BlockExportOptionsFuse *args = &blk_exp_args->u.fuse;
     int ret;
-- 
2.53.0


