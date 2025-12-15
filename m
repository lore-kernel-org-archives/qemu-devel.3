Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DF3D5B172
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 14:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV9ki-0000Uh-Qv; Mon, 15 Dec 2025 09:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV9kd-0000UP-3C
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:40:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV9ka-0003uN-O6
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765809634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UbOkrmN0InfswuuNQjZQ96p7Ib4QlsF6NXAwo63Dfmw=;
 b=eEZ9LmVS3Oag5d+Kp1UnJ6RM3Dao1afxbySOJKRUNMHQYn1gxh4RmqfHmqda3BY7zSVhHr
 xo2CZaiQdfqZbytm/Npw+pGH6teuuF4OHquStRCtlf+VjTcCoq320BnqAC5AFtDzLRXxDH
 pd7JZ6hMtSoGZcGv8WYC3x6/XVlqWbc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-5zvK73I9N2OjEm0TohKX5g-1; Mon, 15 Dec 2025 09:40:32 -0500
X-MC-Unique: 5zvK73I9N2OjEm0TohKX5g-1
X-Mimecast-MFC-AGG-ID: 5zvK73I9N2OjEm0TohKX5g_1765809631
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47799717212so29489625e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 06:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765809631; x=1766414431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UbOkrmN0InfswuuNQjZQ96p7Ib4QlsF6NXAwo63Dfmw=;
 b=p9gQs+K2aQ3z/rBRCfxcbIink6tXlbqRxLjhEpJw+GtT0YrB2j/Np0txCFJMrK+4qa
 OCsxxQYs+zxTDyQkI5EljfscyL1+T7MVFAi3F9zrFxxjdQsaOMjj/KFzuPj3x16j0s6c
 Cal0sFNScgzLJPRvUSUgDajU+Gw/OaOw1cq3MH22eFfZ2xDXr2WwZfPrhQRodnyaT8jb
 JwOl1JvIOe4RZPnHDr0d09Rkoj6Wi0RZeMKrbgG/0Fyq3RjNNC5Z+3+x+c8I0NGrrcRr
 fr4DYt84nDYnq23u4Yzh7EBn8mx0jIk42w0G4KvKfFA02BzaDWy1Q/W17SsvUOzJbqcN
 TTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765809631; x=1766414431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UbOkrmN0InfswuuNQjZQ96p7Ib4QlsF6NXAwo63Dfmw=;
 b=sEpFB9Nf0B1EA1gr7kDXsxkUlvngm6tXQf12O3bSH+5/yZXUud3BmI70nBuGRhiB11
 sCHauRlZoUKi/a1Jnz9FerzjInXnFyOO40qx0efP52WAj/88ULd/2jz3P47aBJxImpoY
 p6vzmk7XUv4qT1+8T8yNwHXLxuhK8wjcVdGUOJgOqLiAuBTGi2pE6X0EgopMZbBIVoUC
 /M6cV9cPAQCxp+8C6hCWH2TsyQ4Dqf9bOi3Gb+eoH8CBsTrXl5OLAwJ6xTp38D819gI8
 LrgEPVu2dyx63OWy8noUNhfBh6GSlWTXYa3vWwGYEwpRW3YMvwjyfgyZh5vJe+P8zWnY
 ZFDQ==
X-Gm-Message-State: AOJu0Yx8CRcXqOB3Z3vn6ng8P+dRH2jQtF6FJmGVf63EVBLdkvi4krBx
 1oMWNwZdjFknFhTfO0gwZacSKzAAaKQA3t2EBYPq+Ut4Ansly3S8Tn8hQpbGJvN5S+dhrRIK+MD
 NDIi7HAuHJC1SaCh6yCvNIJfNru/7J10wV42olZNNhzoYXl8FIr+H/yRIueiu2HbUabGxfS9bhX
 yA2Uicg7b2MkdLOrBmQXXxx9I4dluHAAOR1ZzoTIf7
X-Gm-Gg: AY/fxX6gHQP08ItT+GOuiV0+ew1niBYtfbHVzPWFqBZjzUoOfkSwIrGyBK6YeyLni9F
 cvg1u2GPsD1Bk4kKEkIfcAA+0FTP6cgPVRuvxt1YiEgET6iaSjOwWVV9U8jxLXm8p2CszXfA5+l
 LKhUAfXIiY8KUEtk2mXLgqaGQ4Fb4gyO6qAigsLKh/uV3JhsDN4LGAOZDu3jjG8hJFEVQ4Jqhwo
 bmUKV2gGx61v3gTRdmvRGiaDEHLXdhGbcWIQuC9o+fWzeG/ZDbxrra5478vzyIJ9Eg/il3cfABE
 Iw/pgveQ7tp3nE2Vmcu3BRaOsv7dxWP0nQi/KtuRKI/zwpPBpjSzE1SoIgGlk7DOgVawz6tBe4i
 X/grUUC8cRSlHmDz4uuE0jBvO9hrFejJYJUARloWdE3O/0OyzikUq1wVP/yiNhf8obgBRW25O3O
 aogVC2umNGGfheP7A=
X-Received: by 2002:adf:f4ce:0:b0:42f:b65c:1e4f with SMTP id
 ffacd0b85a97d-42fb65c1fd4mr7744804f8f.17.1765809630691; 
 Mon, 15 Dec 2025 06:40:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwKmRNf6pNPq9BAE9CTiZdtzAhUxl5vePXnbctXKd6kGr+hakF/KCsx9keqCm3eO2uXvD57Q==
X-Received: by 2002:adf:f4ce:0:b0:42f:b65c:1e4f with SMTP id
 ffacd0b85a97d-42fb65c1fd4mr7744775f8f.17.1765809630108; 
 Mon, 15 Dec 2025 06:40:30 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fbc6e3392sm18070736f8f.13.2025.12.15.06.40.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 06:40:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH] reorganize sponsorship page
Date: Mon, 15 Dec 2025 15:40:27 +0100
Message-ID: <20251215144027.567313-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Put all CI resources together. Azure was replaced by OSUOSL and AWS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 sponsors.md | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sponsors.md b/sponsors.md
index b68779f..8ac7d45 100644
--- a/sponsors.md
+++ b/sponsors.md
@@ -7,17 +7,17 @@ QEMU has ongoing sponsorship agreements with a number of companies and
 organizations, who provide resources (software, hardware, monetary) to
 assist in the project's operations.
 
-[Azure](https://azure.microsoft.com/) and [DigitalOcean](https://www.digitalocean.com/)
-provide QEMU and [Patchew](https://patchew.org) with virtual machines and
-other cloud resources through the [Azure credits for open source
-projects](https://opensource.microsoft.com/azure-credits/) and [DigitalOcean
-Open Source Credits](https://www.digitalocean.com/open-source/credits-for-projects)
-programs.
+QEMU's continuous integration is supported by:
+* [AWS](https://aws.amazon.com/) through the [AWS credits for open source
+  projects](https://aws.amazon.com/blogs/opensource/aws-promotional-credits-open-source-projects/) program
+* [Digital Ocean](https://digitalocean.com/) through the [DigitalOcean Open
+  Source Credits](https://www.digitalocean.com/open-source/credits-for-projects)
+  program
+* [Equinix](https://www.arm.com/markets/computing-infrastructure/works-on-arm?#Equinix),
+* [IBM LinuxONE Community Cloud](https://developer.ibm.com/articles/get-started-with-ibm-linuxone/)
 
-[Equinix](https://www.arm.com/markets/computing-infrastructure/works-on-arm?#Equinix),
-[IBM LinuxONE Community Cloud](https://developer.ibm.com/articles/get-started-with-ibm-linuxone/)
-and the [Oregon State University Open Source Labs](https://www.osuosl.org)
-also provide QEMU with access to compute hosts.
+The [Oregon State University Open Source Labs](https://www.osuosl.org)
+provides QEMU and [Patchew](https://patchew.org) with access to compute hosts.
 
 Downloads are hosted by [GNOME](https://gnome.org/).
 
-- 
2.52.0


