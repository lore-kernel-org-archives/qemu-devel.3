Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119F3CCFA08
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lf-00011b-GA; Mon, 03 Nov 2025 16:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lc-00010d-OI
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lR-0005K5-Ls
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMnNyaDw8H4jjvpH2pgcjNifIuVybefC2pc8R54zGE8=;
 b=b8YUbqfnCp2ruyY6Qmkk/maoT97rMGbI/UWT2m+8kIv1iKV6mYBWFmPq5TjLjcPxQ4ZQ6h
 vw0TPJJLpJHX4HTK6UtjAvuhPZdwvKC25Z2RYtIFbq87NFQ5g1pCOwrtkfHYeltTGymSk4
 e9AgVgpxryPkWC8+/rjzBqMRcHOH6Xs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-qMDd5HXuN9GaQH43FkGRpw-1; Mon, 03 Nov 2025 16:06:51 -0500
X-MC-Unique: qMDd5HXuN9GaQH43FkGRpw-1
X-Mimecast-MFC-AGG-ID: qMDd5HXuN9GaQH43FkGRpw_1762204011
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8a65ae81245so1487498485a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204010; x=1762808810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMnNyaDw8H4jjvpH2pgcjNifIuVybefC2pc8R54zGE8=;
 b=cTT0fpRaL09SBpBNbesrSSYdOaJJBNsL1DsI8wPqtn0gvFecq++rei9F+Yl/t33IfA
 cwkIKRO2lLu7BnwTpj88Q/ByQxKoTbJ0kasEXSc5S43IA5fg8AR9/gTFGRw7Gex5+umc
 WL0uII/wNPY5/qCpJ+J4OMmplWB1pyriOC0S1XksN6DqS78ZhYg3YsFYFoIGGK1ro/GA
 Mvyc2WU7ADS0kvGCyHOpSAZUHrtdctyBAPGy9xP+Rd9EckPemQOI3a6vVWBt09E9D5F/
 fuXxtg645PK3BsHX/BhC92Jfj8RGlyBfqJS9hQpZNIrayBDtHTJcN88Q5KJAdMUrVuZg
 BhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204010; x=1762808810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMnNyaDw8H4jjvpH2pgcjNifIuVybefC2pc8R54zGE8=;
 b=ToGeeii+ARTnBJjISZmEIscPKn738iFqARGiCXeRKKQ86T7to4ZMwmbkvwr6Jdy7QP
 DdwHFK+oVqslppiNGa29aOrlMKAZBGJSeiObkmYoZr7JetjZmuVGHVBwnqfpBOHTZ8Wz
 iN4ISd4F3QUa02oHnTrcLoEX2MRMNTa7bKr8WFJZyxYZ0OUguaio1kmsngSLTIdphHDJ
 uFRMoHOizSuOGzM1A1kgnZmmqRN8P8If8CdQrBrAORAIxN+pjnyypF3cyrzRlpV4iqn6
 tzDFYLJRzFRvpmas8haSg3esZTIQMrEXA85aFRjLrbYIW/xC8jj/bsaRG4Gqp/ZnWrwb
 D9yg==
X-Gm-Message-State: AOJu0YxWCjOVxnyKsamYt9K3UlknayVv0AWpmhINIrs8QiL4l2/0Lr1B
 CzvqwAV/Z7jq/ILZ7WdSK0MrfBUlB02v6tfXKeRR6BGe7PMEAtbA4XOuTukXCofUpb8WzuwgslW
 FIHwg94y4s/VnyCs9x0+qTZ9B+OxK9C8aRmlzOaguV+QT04aqW1N62tsRUqgWhTS33pbSOrSTc/
 ZHs6vDroTmbLXXZ3dYQZLFTRMDBQo2SWMIdAqCmQ==
X-Gm-Gg: ASbGncuBYLiI+KeCxsouZwVe/BpNbGi2q8Vuwq9WTfhwi0UpHM2XHblHrjbP1ziT8Kr
 FMH500L488041A6P323DwoqThGp0i2h3ENZUbkPQKUlgQCwGE7Wk7G5JMiQC5maDqgFryb5yr5P
 OTzdTEjJcFPrMAFMY26+uoBoFjBZUPhI5BPA4no1Tt18XCFzsLvJ954EWp7g5pthXcxxO6Se9/z
 LA0bfVcfr2JVai557CqQulSE79uVrAEpjwOP9o/JuRc3H4+J+leFmluYlBvBVqAF2NKuak7XNZV
 jDrOq9SWEw+YbkL3KX6CuHbZn+yib0Cjc3MxqvLx5fLv1JkhlaIT80/pTRr7BQRN
X-Received: by 2002:a05:620a:3724:b0:8a2:db64:2f13 with SMTP id
 af79cd13be357-8ab9afd2fcdmr1723628785a.55.1762204010500; 
 Mon, 03 Nov 2025 13:06:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4FVW6RmePVO3C5tM6InWV0y++MuBOKCQ+vy5A3bBe6vz2AWjfnLcS9mHcPd9Vju8nmW1ruw==
X-Received: by 2002:a05:620a:3724:b0:8a2:db64:2f13 with SMTP id
 af79cd13be357-8ab9afd2fcdmr1723623085a.55.1762204009936; 
 Mon, 03 Nov 2025 13:06:49 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:48 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL 15/36] hostmem/shm: Allow shm memory backend serve as shared
 memory for coco-VMs
Date: Mon,  3 Nov 2025 16:06:04 -0500
Message-ID: <20251103210625.3689448-16-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

shm can surely serve as the shared memory for coco-VMs. But currently it
doesn't check the backend->guest_memfd to pass down the RAM_GUEST_MEMFD
flag. It leads to failure when creating coco-VMs (e.g., TDX guest) which
require private mmeory.

Set and pass down RAM_GUEST_MEMFD when backend->guest_memfd is true, to
allow shm memory backend serve as shared memory for coco-VMs.

Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/20250721065220.895606-1-xiaoyao.li@intel.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 backends/hostmem-shm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index f66211a2ec..806e2670e0 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -54,6 +54,7 @@ have_fd:
     /* Let's do the same as memory-backend-ram,share=on would do. */
     ram_flags = RAM_SHARED;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
 
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
                                               backend_name, backend->size,
-- 
2.50.1


