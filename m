Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DF4D111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObqc-0002cW-RB; Thu, 27 Nov 2025 08:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqL-0002Xh-Jx
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqI-0001AI-84
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VCvRN3OWsF1O4M8RCr/9wSLhXxc99p7+KHRdfTdsKPk=;
 b=EplMVTLsbi5VtTwOYGf/zR6AuUepEw7ZmK/xcL0Nu0tZTV0x/QabYKsGsaGbbin/MVeQje
 xZQX91ACe7j9tkbKyslUhwTX5Pch/XilZ5nd3z7qBFNghgZiTQZ1Y1UvcB93RUeCUup+rZ
 ju9yA+zNdRirmthUlSTqC7BfCgYAkU0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-rHUzViLvNAWn3wLlEQz_ow-1; Thu, 27 Nov 2025 08:15:22 -0500
X-MC-Unique: rHUzViLvNAWn3wLlEQz_ow-1
X-Mimecast-MFC-AGG-ID: rHUzViLvNAWn3wLlEQz_ow_1764249321
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b763acb793fso81452466b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249321; x=1764854121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VCvRN3OWsF1O4M8RCr/9wSLhXxc99p7+KHRdfTdsKPk=;
 b=JCM+s/QPh6X27zD2c/rOPTyskwsgLbOrm+T1cj//lQBsy8MJ6YStblZaP2ozjUMKF3
 XUs42xaVZqPOVVE3MBlQ2fIxKbIlLWWF/uhoKU3R2PbM1dlKNP022A+b9867FBfNRfUg
 nGXkyDAy08iiKPA0q09gpzO8Zms9BBF7JCRnS54k4ghZlDl0iWK25AekaBfxs4YC+XwF
 2QMVR7u/+w+sniMBr4wa4d9lLOXUTynTYFDXcgk/7rpDojBW/MFUZxDo3sim+UkCQoBR
 PYPUUR4xmRXhG2vIPgnbybuktVnTbkwzd5YxYhnhv+Vxa24fwh7sdMCuXp2U3GOBmfXL
 MPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249321; x=1764854121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VCvRN3OWsF1O4M8RCr/9wSLhXxc99p7+KHRdfTdsKPk=;
 b=VjifBPcaGZ9LdlBa4hAL4r0yC1/fn+9LZbzNiOluBSW07g7zj4q15AU8yUmnMxKhwJ
 J/7V8aN4T6utd8BD+qrxjh4eUlIKBiBb8pPlHA2ZHBDFS6eiQGma6WUj37d8TQSjGZTY
 2Dez16mFAsH41Dy0WvpPVKvH2nQdvSjNcZxIu8XFvHIsoN6/EUh9/xb8YUd/lwyev6Oo
 5PUZYZcLQ377iK6qvvQrZx5RZ6iMWqYWTtCyBpvh7ghv6LDV36dne0YEquqtWNjFf9o3
 QFZ12RvgwdqmkGE77VJC0YraI9Cm6elbGyoUi4RfP7iBdop+E5kJWitJnOrOymHOWg8u
 saxw==
X-Gm-Message-State: AOJu0YyvuSFIO70bsDpzeQPy3PeQz5e73ZP8c91CduL2BiM0MoKoK4jm
 AtEsUE8v9WkEhPK/rinx7tCAOfomVZMMWSbIVZ2NivTc3v90HCOycGgaPvOcudrHqZf1ONGWo9g
 R8pz36I11fqIVLBQQgeGEI315xODUb8fw9eF/a/bNYRZDcl1Pn5ltNrgXlvXWwDEOiCs8dxrw/f
 qpvf5bSoALYS25d4S5XwQgeMMUGcq+heUENvsP4MFR
X-Gm-Gg: ASbGncucfksmn558s1ozb2U20ty2S9IHwlFfk4YhrxAUTcff0yF3//gkHZ8Ou+tS83w
 WklDRmIcb49T5tLU1qq2V/Di9KTN2rNkQeCDM+KNSqMqSYJRDjblZd8aD2vT1NRLu47guX5LiZ5
 WO2OU05/PGQVuubSPfHoj9zbsmp1jlbl9BtqPD7nXhey+jLFNllTRcOFDv0vJlWii6BDyZ21Mo/
 J3avANmTzeGBf2O5Go0/vgj7bBxhH7xZ369ICYtBKoFmRcu3ybZJZQx6zUCdEzSytuPcjJKLpfM
 g3O5CmlogKRuIigowJ5ObQVLGgddvkXb11aC8ntHrYVGJf1Fd4Oc5t4IYswBBygPZOKyiYQgsYH
 YWYkGRRIXtoO73ZWD4Gvc0dHJ1GjCehRTiyWP2tNEdOGkc4n3Ye80Omg9hIL9M/R7zMiiYuuQ9L
 cIJN1bd6AFm4Q++qo=
X-Received: by 2002:a17:907:7ba1:b0:b76:b7fe:3198 with SMTP id
 a640c23a62f3a-b76c5514685mr1220214566b.26.1764249321030; 
 Thu, 27 Nov 2025 05:15:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjQiX6akvTpQn6cIkESqS1So+Y0aaXF9df3jVMBUm6k0KOUMc4pjj2mz6IUMPNwAZlXf5Dnw==
X-Received: by 2002:a17:907:7ba1:b0:b76:b7fe:3198 with SMTP id
 a640c23a62f3a-b76c5514685mr1220210266b.26.1764249320445; 
 Thu, 27 Nov 2025 05:15:20 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f59eb401sm153647966b.54.2025.11.27.05.15.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/28] include: name the MemReentrancyGuard struct
Date: Thu, 27 Nov 2025 14:14:49 +0100
Message-ID: <20251127131516.80807-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9802b6896de..018c134011e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -209,7 +209,7 @@ struct NamedClockList {
     QLIST_ENTRY(NamedClockList) node;
 };
 
-typedef struct {
+typedef struct MemReentrancyGuard {
     bool engaged_in_io;
 } MemReentrancyGuard;
 
-- 
2.51.1


