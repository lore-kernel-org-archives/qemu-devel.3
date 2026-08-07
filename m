Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6203EC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 05:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsD6I-0001Km-FV; Fri, 07 Aug 2026 01:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD6G-0001KO-F2
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD6F-0000k9-39
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786080390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ds3ELgiFjPHuwUmXMHjb6LoAFKBT/u0B05y4PCqDrU0=;
 b=E+b6WJfeVcYouke088nh2qlmf+gStO8YXGOXAkzlGoKBChZ0lvA8d1JHndn1DLbUDtF8UW
 aQu9m6gUGOMW4U5zDZsL54ish1OuZ03JfnbQRD9XTY4hZb8wARQq4meCSNZkNosl5ZopdD
 iozOg+hasWFSUQV7h47DnGN1G5OeHvA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-Hc25koQLN9OfsRTQfvlwFQ-1; Fri, 07 Aug 2026 01:26:23 -0400
X-MC-Unique: Hc25koQLN9OfsRTQfvlwFQ-1
X-Mimecast-MFC-AGG-ID: Hc25koQLN9OfsRTQfvlwFQ_1786080383
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so5003356a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 22:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786080383; x=1786685183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ds3ELgiFjPHuwUmXMHjb6LoAFKBT/u0B05y4PCqDrU0=;
 b=AWkw4LHHDEHH9OEDY5qeKZGiSMHS4G8WqZhZjowzcHlfdTOgTnLgv8StY8aXQoc0KT
 Pf92SVp/ghHCSfrMbHFMsas05CDegbfHJzuXeVW3sK13TsLW7rWuYBmdhYWkAFvDaoI9
 cNLt8aoVgKEtA1orXFhEh5CbpbnCp1xl1XVRna2zOSWgnhds5mfU4CCJ1C3kr1dRgj1R
 v5wyBfwvThqSmvijsE/Z+39p8C5ry7pionlP3d6TswjejSRzmhsaSvtUFOx5En/NUTPb
 7PEcP6rxs/leyXjM0KM59YgdCwrnyxfwVd7KlhXKGr4cYQPdM+uqDW+MS8Pp6JNv5VSn
 Rhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786080383; x=1786685183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ds3ELgiFjPHuwUmXMHjb6LoAFKBT/u0B05y4PCqDrU0=;
 b=cdzYTxjFyPHmWXpCvMfXBKwAfJV5M8pnG8fXZaIOr7nTo7U8Ks3ZXwQKesBx8S3juz
 /4uFsSLRX/Ci0J+wxh5WVtnLlaLkGXV9rdDKuJ/ramMRDLQEQFaCuwJRUjhUXrNsFboQ
 edtiLw2X7vGDsPivPLy665eR05ohp0mT7MCcZyq8V8pYQQSIdGKHVm0ZbCCFJUOMkrXw
 gaYZ6MkzolNCmq+o7yf/x3Ws50SMWJGCAivpnTkdEa/wtlNrYotQkxN9stDgZnYT1aai
 vUMjsuwvpHf0JyNMeLwD39obyDuh1izJDe4kcfNeMR07nVcr7ADCdMTYGkPLdJJxOefq
 bzMA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9xQtmTJLRINtUc1wJqpguHGXl2lDNVLmUSKd3lxjSZpSQjQJ9u00D7fFXojoTmtxssFb3FOhvp7wa@nongnu.org
X-Gm-Message-State: AOJu0YwZC7yJID5zUlEq6fLfF8LUTWvnkXQIjNf95cfXEMZDHGF0uYAs
 WCddyH/mnFveOuh6Z4rzp4vBonz9F4IgyaYQ1G2CQjWPkQHbtXMG+D7yyGPATM/5bLUWMG3iRFi
 MA3fEPhwSKZkUZKa7sFkMLqc1IGgfLGoNAUjRmahuzGto93dlKzd6ghX3
X-Gm-Gg: AR+sD13cOv0qY0eqOEq4dKpC2i0aLZoZ5WTC6DW2dwJEkdK3KSk+n0H1poaUPxi/bqq
 t7AHVo56hFw2WLkSopoXahrdtS0Uim2VqM5g6aRz9ln4b3qdrguI2ScOkIc62yGnInD2FnStwcA
 gWeIZVO2IrSoKFVFd4NFlKSpLKqjCYvTHLTcb8lhfBAQ/ixILtPrRAxc3odsWcZBRnjl+oDq6xL
 yksGD3YBj4xC/hzyAIfRH+GOHUFMI9Zvnh6JrhBDeZ/Dzd2rkHEKV6HbEx/bU9Tx00iM48VkAeq
 EIhRix2A/thchgh3Zp2LTn4FC2JswrgLTw0cUwlSXJuaCvbVANwtQy+p9trunJ3bTdU5hknUEMu
 rwgQOKmI0QakXeld3aeyj7CVGqiAMYOBCjg==
X-Received: by 2002:a17:90b:4b81:b0:38e:7f1b:efa with SMTP id
 98e67ed59e1d1-3903c582798mr18677501a91.11.1786080382762; 
 Thu, 06 Aug 2026 22:26:22 -0700 (PDT)
X-Received: by 2002:a17:90b:4b81:b0:38e:7f1b:efa with SMTP id
 98e67ed59e1d1-3903c582798mr18677464a91.11.1786080382312; 
 Thu, 06 Aug 2026 22:26:22 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3908616d21esm3316334a91.17.2026.08.06.22.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 22:26:22 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: agraf@csgraf.de,
	graf@amazon.com,
	qemu-devel@nongnu.org
Subject: [PATCH v4 05/11] backends/igvm: add a tracepoint for
 qigvm_cleanup_memory
Date: Fri,  7 Aug 2026 10:55:47 +0530
Message-ID: <20260807052559.50643-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260807052559.50643-1-anisinha@redhat.com>
References: <20260807052559.50643-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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


