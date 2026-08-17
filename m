Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB19C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyCv-00007n-RE; Mon, 17 Aug 2026 10:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCu-00007c-9z
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCr-0002gm-Pq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786976453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ds3ELgiFjPHuwUmXMHjb6LoAFKBT/u0B05y4PCqDrU0=;
 b=hyji7tdtqNHgzy2yH1HYLTcV03KiscyhTAfR+2Tc3ReLNjbHbaVITOEZB6r9xwx7Upz8Pq
 ZVzKSPDrZMypGTr0l10RpgN3SJaSGV14ieXAyJGHF9Jf8jdNn77Xz6xNV3oIAcIA0WRIIj
 +3UH2T6R4B5VanBnI9rS2eV7tMgMG9U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-U7I0btxlOjWt_-dgvjkuJw-1; Mon, 17 Aug 2026 10:20:51 -0400
X-MC-Unique: U7I0btxlOjWt_-dgvjkuJw-1
X-Mimecast-MFC-AGG-ID: U7I0btxlOjWt_-dgvjkuJw_1786976450
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cacf17c7e0so52025025ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786976450; x=1787581250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ds3ELgiFjPHuwUmXMHjb6LoAFKBT/u0B05y4PCqDrU0=;
 b=BUpPnpXR6B8CxRslZ5kznp2ekfRbpviH/yBUI4bPqVKRed/80l+GFkdjoZRgT0b3ii
 /mpo2QG3pnyiBkgLf7m/wDfXBojfWACiFER63Z8x1mEDDcsO2hpUfHMF6oh0rhFawySU
 SGjaNKuWpnEaKd+wbKtGeXH9hPYQIjCF/vvPz5WlehmzJcZnydDfHKuG5vyCnqKg+8CU
 +6VWJ/a9Az35y4nHy83FieSdsRJOZDyREiYQWn/jgCr8OAzFbZh1lwdvhIclx1Dwpgp5
 Y3YNJRVUbF/gQB0srBzUZ5r25tIgw8YAN6h2viF3UYhWfJO33IwODbKFmNsA+lcQcD7z
 NXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976450; x=1787581250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ds3ELgiFjPHuwUmXMHjb6LoAFKBT/u0B05y4PCqDrU0=;
 b=g3oExxUzMNfwTLwEWN4EF2BZptPG2EMoZF+Nxs8i0x2RXsvQxlbjXEikLKcBraBAeK
 bsVCaY2ci9B1earUJrmSeZJCI4egQxiTLPr70fk+AOR1edqZ4k31RBcv9mkgPz1UcKX7
 k/wcjnIsez3AsMZ5Kqq07Y3T5jqyKXsS9FLG7Ozq2nQsMNKlURPdeDmLXkcHiU20zt5N
 YsUe+MD/47KO1b4mEuiZWUiUfb1h/0P6ZvOgmXfdCJJodu0b5yqJBygXJRRLUEZBesXU
 YSIBMvgRl+23hTeHgSCiSDor205itFIdRWzgbAG2DHOfVGIci52dca+VUB/MtmzWDA0w
 uE3A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4+6qaZ48ptW3+gPjQ0onHb3B7Hl5IFqCz4sIepKSBDXseo6mDya7XHsVot69kvkKQ7nsjnch7TWK6@nongnu.org
X-Gm-Message-State: AOJu0YxGpzSeD0jlx89NNsB0tX4EbGNwmzYTjAliEU4N3iMDOsol/S3q
 vTdSGsxfERVXQ99pLeVYaDgQI7ElzSrYXT2z2OK1kI4fFBt6yCPFwGgIaNpIVEADfzIqwnMzkH/
 5/bvmX+VCzzZZXFiQOiymn73N44D/RvXaVuDAYqjFV6OkWo4X1Cpdu3hc
X-Gm-Gg: AR+sD10AInYJjN7HrBouaA6/9Pdfy6XeV7F3H4hQoI0Kp4hx1AZ0C/YPnWc8QgKzh2o
 NyCNErXsYOk2KeeZFdrxuDpZsfCGQKWu3Qt4+msImjcWOUvDve1kIhQJNPHCAvl8H0751r0vFck
 HHb5/1QNCLV3124PzBDHf94IBP57/dtBJR9ijFF8f48McoSbsoQA2H5Yno7+Qf5UxVA1iSrbXXi
 OVgXmW4ul6sDcFKN14w5TTJpYfGPr2Mpm5x6N6M/FEuGDTz3WnON+1lS/oPSAEXYICxLkVRl77+
 76Zcyq6oQhEWVoIcFrDNfwn8oDPSzOqhvCAmyRjgF5MqR6Jatj0POrAWCqGAbxUPQvo3+JzryDw
 WPZl85qQ7mN5KAnfrHIpPNs2WtUTeIFsUTg==
X-Received: by 2002:a17:902:da82:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d3b0d5ed01mr255791035ad.13.1786976450322; 
 Mon, 17 Aug 2026 07:20:50 -0700 (PDT)
X-Received: by 2002:a17:902:da82:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d3b0d5ed01mr255790535ad.13.1786976449830; 
 Mon, 17 Aug 2026 07:20:49 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d5c1efd10fsm3705105ad.81.2026.08.17.07.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:20:48 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: ani@anisinha.ca, agraf@csgraf.de, graf@amazon.com, qemu-devel@nongnu.org
Subject: [PATCH v6 05/11] backends/igvm: add a tracepoint for
 qigvm_cleanup_memory
Date: Mon, 17 Aug 2026 19:50:00 +0530
Message-ID: <20260817142010.80693-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260817142010.80693-1-anisinha@redhat.com>
References: <20260817142010.80693-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Useful for debugging memory region cleanups.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 backends/igvm.c       | 1 +
 backends/trace-events | 1 +
 2 files changed, 2 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index 9b101c8182..7b7bdc72b7 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -1120,6 +1120,7 @@ void qigvm_cleanup_memory(IgvmCfg *cfg)
 
     QTAILQ_FOREACH_SAFE(imr, &cfg->memory_regions, next, tmp)
     {
+        trace_qigvm_cleanup_memory(imr->mr->name);
         memory_region_del_subregion(get_system_memory(), imr->mr);
         vmstate_unregister_ram(imr->mr, NULL);
         QTAILQ_REMOVE(&cfg->memory_regions, imr, next);
diff --git a/backends/trace-events b/backends/trace-events
index 009a25b0be..9b7b9b7d68 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -33,3 +33,4 @@ igvm_reset_hold(int type) "type=%u"
 igvm_reset_exit(int type) "type=%u"
 igvm_file_loaded(const char *fn, int32_t handle) "fn=%s, handle=0x%x"
 igvm_process_file(int32_t handle, bool context_only) "handle=0x%x context-only=%d"
+qigvm_cleanup_memory(const char* name) "freeing mr %s"
-- 
2.42.0


