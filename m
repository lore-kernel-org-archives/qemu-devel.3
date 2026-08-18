Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16110C5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwFln-00032B-1j; Tue, 18 Aug 2026 05:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wwFlk-00031x-P7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wwFlj-0007Ux-Ha
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787043962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=x0Iu8+g+zE+utRLvfdrKtcNTAlPcRxf20zT/6QEHFsU=;
 b=CaRquTqlILdJEYqtaTgFIdmnmU3RESsnPYPsGQfOgUX6j66gwwgOFIXVWA3ZjYU6CXrp63
 UjtLphA/AQ1datXYlAuDepv/RDgNl1mi6qCImKdTKt44/xaRatCP8I5vbIEgQqBhsya2Am
 oWggppMkr5WJl+0eASaPfw3Rh6KoCA0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-SJFzjDBNOZi_KuEXntP4jQ-1; Tue, 18 Aug 2026 05:05:56 -0400
X-MC-Unique: SJFzjDBNOZi_KuEXntP4jQ-1
X-Mimecast-MFC-AGG-ID: SJFzjDBNOZi_KuEXntP4jQ_1787043955
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-388b404eaa4so6243571a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787043955; x=1787648755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x0Iu8+g+zE+utRLvfdrKtcNTAlPcRxf20zT/6QEHFsU=;
 b=mfjH6DO8wATx+074NF+cBDY0/a+GNzPKdUWD1Q/eld2sAZ+UjoAVOZEgcdfI/5B/ZX
 fYOPko/aU/PaLDKV3rE1updGqJs21Qkr35nuSdK8FEpmqUAbT03LfZQJGbs9IRH++Xcq
 NEAPxx/t9IgPbIqYManZLEndY5MkUkRafrVS3men4Z2dp6KR4cmjay0t6y34TVbJNVnN
 X5vT6YQpwIhLRzMCwoFl+xedquUDRI7BYXxusGkkKfIqJIU8QdmM5NGdz88Ix5GpVSQY
 x6buybiPudD7vg2nVtEnLCBLhKp+k6njYSTLptVUuglM12SCau5tSF5uwyrGA1uxfgk2
 /few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787043955; x=1787648755;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x0Iu8+g+zE+utRLvfdrKtcNTAlPcRxf20zT/6QEHFsU=;
 b=qR/ou1By6eMGLQ3zKmw2ck9HmIUl1hxb3IytFyeg3Ngpje0RFfacuhm/+Aeox5GUAV
 UG7bJIU3b7zeZf03ufs3MfS54+rFMik+Yl7YaBBKLZGficvKScTf/qeG8jXAnxAtAf16
 wzBNU2Bf/MZltrpWYVhKaxzY9w9AKOF3jbsSg54C+Ekvf9172tvqmdF8M+ToLjmDxmP9
 +13VI1y5WiaqTBrnuU0rmWoVHhJH5+LvphoiEZSJUJlCEamtIpgd7ZvfqHDlnv/ju5wO
 cuDLvnsDHr/PDiQFTd4JmaLuIF6r9r35YAKobYXsybKtMATlmXTXOcJ0sGTMYFCfF80f
 rpMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZpJ/YdXameXuB1MBdzHT4x4wYJLj/C97IhoLrA+gU+jGAbHTRELtocd7+QJj0mrCYa9rqMS1dGpyi@nongnu.org
X-Gm-Message-State: AOJu0YxOjeCsp/T4qtn82nEPhj1GsDSESIOl5CP1rAdvptylNIqUCqyl
 yWtAKDPl95bNYno488cPNrWTaaHkPFZRPvlNAhD5BvMX6GIRUi1MNHVkBvK3ZNx3xrghCsj1kBa
 0gsrK5nqXOmdtVb62YuqoDhVE4qHJhnsTa1gtYBH+zZaUlnu7bpWB+H+v
X-Gm-Gg: AR+sD11zuWPL3JOYet37Ei0WWqW4Yg5h7oGwZjtir2mS9CGittom7EtuBaYPc4gDq7t
 oYCIfszNHoEjhWT/f6b5Y1VimQKHyyHCrTdHtF8dGH0FNCVpvIhHGN3xjyysk0DMk7hRQJhDBkR
 IQOTVJXTlbpPSYnrIe1NRZNwDk14H/1opxfbD1kbBgMusZFTIAYvEwrB5B2c8sF1PkGROxEPKOS
 VQCTs1LwuC8pLkoW7Hgbq8cg9V8Lr8kHY6JkrdwouSzW/yoRnlIEtenDzYk+bdRt785Mi6D/nJ0
 2Z2ZjxssCYgYyFbGFFFnEGNlRClRi/NYXvVwaifV9LWI9eYsIgKBS9uJPAZfLN1aaZa6zTD0o4x
 kOkRjKrlfeDEQf9yJF4zqRV52/Dx/8fxelw==
X-Received: by 2002:a17:90b:17d2:b0:381:9028:5945 with SMTP id
 98e67ed59e1d1-3933e60c1damr30708110a91.14.1787043955037; 
 Tue, 18 Aug 2026 02:05:55 -0700 (PDT)
X-Received: by 2002:a17:90b:17d2:b0:381:9028:5945 with SMTP id
 98e67ed59e1d1-3933e60c1damr30708050a91.14.1787043954600; 
 Tue, 18 Aug 2026 02:05:54 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3954d3b40basm5406821a91.14.2026.08.18.02.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 02:05:53 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] MAINTAIENRS: elevating myself to be a maintainer for igvm
Date: Tue, 18 Aug 2026 14:35:42 +0530
Message-ID: <20260818090542.86870-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
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

I have worked enough on the igvm to be confident to elevate myself to a
maintainer role.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b51f5c3e60..9e0a2a656f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4118,7 +4118,7 @@ F: tests/uefi-test-tools/
 IGVM Firmware
 M: Gerd Hoffmann <kraxel@redhat.com>
 M: Stefano Garzarella <sgarzare@redhat.com>
-R: Ani Sinha <anisinha@redhat.com>
+M: Ani Sinha <anisinha@redhat.com>
 S: Maintained
 F: backends/igvm*.c
 F: docs/system/igvm.rst
-- 
2.42.0


