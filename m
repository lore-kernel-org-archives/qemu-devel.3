Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A7CC982C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rHR-0004of-9T; Wed, 16 Sep 2026 11:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x6rHC-0004ls-Tn
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x6rH7-0004H5-3o
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789571416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOGgYjCQ/eE/ZQO6VLQZA05Bps2xeA+ra0/sSQXijm4=;
 b=JYnr6KGfsIDda5f0y1+cdb7PJ6xuMFevkfrTqIV52cZWLMbRwF0nqZr58eP0N7QUMUl1FK
 lm/EspTawHW8upx9SVmlQnHv2YZifxyJq1Ri6vnwkdShF9yUvTxd3JCNir2L4aUFYJcbjZ
 019wTSEmo9fDygDHaMGy7ldE9ACeNsM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-jjqSXYtdMCWWTh-uhVeR9Q-1; Wed, 16 Sep 2026 11:10:13 -0400
X-MC-Unique: jjqSXYtdMCWWTh-uhVeR9Q-1
X-Mimecast-MFC-AGG-ID: jjqSXYtdMCWWTh-uhVeR9Q_1789571413
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso47944065e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789571412; x=1790176212; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XOGgYjCQ/eE/ZQO6VLQZA05Bps2xeA+ra0/sSQXijm4=;
 b=J4Rj+tuYJ+RD+V/HlRF6bjmj13eiCKHXIafWTA3vnFNe3AjonUxXhCAxnkc/fQm6by
 mYR6sgghWeUec1G89LmgbrafXhmZJwCnK658jNmZEZdOsvZ78grQMjeTBcRuq+GfyTgv
 GHRXiIEtcM40+0iVpqgYVeWdIwpP2UgszPcCscZrYiDiXcWMYeYaC+XbJuiSJwaoSWez
 o5ofEZ3NlexkXN2KCCQtctQMmMfdp1rzzO5nAq5H4zcv9Dw8EFvL37a8thzcE0tgR6Ij
 MJrCeo7z4u02TP3n84arcbWBv8oQw9jXKIdAgs7+oANK6zIhuZ75gSmpSpo2Zs1BvD2U
 LW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789571412; x=1790176212;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XOGgYjCQ/eE/ZQO6VLQZA05Bps2xeA+ra0/sSQXijm4=;
 b=LIPnzoN9MKL8Of1zdCsJkVyrDmEdWBg5zY+T8rhiZLWEHFgHsAmfe0xd6w+JNXXBj9
 m+jObQz0qRjnGjKV/KdizDYDSVtFG4DdRuMEPzpxv9a5XgHVe2uSHRcDfqyFqam949S7
 rxnhypqT7Ij+gGwisPWtFN0fAzns/ywhEWR9xJ8orKxMD4KHjkFx69a/Xv6PFf8llSBG
 qn1M12/p1qTN0tR6MANFBbqxEmTLgWkKpSb1+TnHQhteslbooo8miC7CTbp6O0KurcYL
 lnMZm0WO/CFf/v//OKouOm9POM/2HhMLhdvJR70a2T2qdYKpeavwrS8dMjGoYceJ2bI7
 T5Cw==
X-Gm-Message-State: AFuF++lQ+ZHoZuBkqUsCGU9UFyCqL8tIwLGgv4ZRu3VgoiSCRDXEYdM7
 WgcOwjGbzT18gJcwl7Qimj8LyNINliq/CJM8vW2PdmNjiEz1+1dyNGeFPLnZI7/XjoYm4xN8c4K
 zQuwFCEB06/Jguw6U+g7HY3A+FrqjOuSelEeBPdwsxOeycC/jnnsiVfyGIKFx/5CYhWB+nIVMHx
 89RoSMpNzW2+qsSeelcDE1sUMjc1bAhfL45B1O0WJLfbQ=
X-Gm-Gg: AYBFou1nQ1tlTjfGrRoUADpbmYotabD6a2i/q3d7U1CrLHSg05FG8T5rVb3N5AtnMxm
 yD7nVWHLbgdFEUquKZYLs4atI/L3aR1KRqZ0ZE/7wY4No8M6ZGzTwkkVvMSKlRwn2zeqObndf3M
 a2lV/ARRAO+MYSji2/gdiie/8H89mxj0QjdpaCi20OAgjsQ7O5ubqCj8oGQpza8PxbZU6f3buj4
 4xJbgAOeoDyij/DH1pfsNWpe+NQ5a7FinXtpz7X/QpM7whWsDIi6P4d8fsR181j2UpyuL9+/6QT
 NMa+4WDpLktqM4IUbIZ9ttx2GifGxDKCfCb59KT2tk73YkLWwq6i1lkTjpOyWCgHQUBtvg53NEp
 7CMXKaEMAZGOoF+6Mo8Wr9KbfAkB8PzWd+ePZM570MetTnDyjjfnHK0qLKNzajTgm2Xdy
X-Received: by 2002:a05:600c:1c1d:b0:49c:fc6c:be08 with SMTP id
 5b1f17b1804b1-49eb733de1emr44827455e9.31.1789571412678; 
 Wed, 16 Sep 2026 08:10:12 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1d:b0:49c:fc6c:be08 with SMTP id
 5b1f17b1804b1-49eb733de1emr44826695e9.31.1789571412179; 
 Wed, 16 Sep 2026 08:10:12 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd112455sm40865e9.12.2026.09.16.08.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:10:11 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 16 Sep 2026 17:10:06 +0200
Subject: [PATCH v5 2/2] igvm: mark qigvm_find_param_entry as static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-fix_offset-v5-2-11cf8ef37854@redhat.com>
References: <20260916-fix_offset-v5-0-11cf8ef37854@redhat.com>
In-Reply-To: <20260916-fix_offset-v5-0-11cf8ef37854@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 qemu-stable@nongnu.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
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

Previous commit removed all external usage of `qigvm_find_param_entry`,
therefore we can mark it as a static function.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c                | 2 +-
 include/system/igvm-internal.h | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 9a2bafc0ca..ec7bee428b 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -85,7 +85,7 @@ struct QEMU_PACKED sev_id_authentication {
 
 #define IGVM_SEV_ID_BLOCK_VERSION 1
 
-QIgvmParameterData*
+static QIgvmParameterData*
 qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
                        Error **errp)
 {
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 0467eff0ce..b3b64cb584 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -77,10 +77,6 @@ struct QIgvm {
 
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 
-QIgvmParameterData*
-qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
-                       Error **errp);
-
 uint8_t *
 qigvm_get_param_data(QIgvm *igvm, const IGVM_VHS_PARAMETER *param,
                      uint32_t *param_size,

-- 
2.55.0


