Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34684CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKqq-0004t3-Rh; Wed, 27 Aug 2025 14:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqZ-0004gO-74
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqP-0005lR-6r
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BYZBzbSuHz1ck9mAe9qDxSmyxZe5JBQ+ptoP0h/no4E=;
 b=C0v0O2KVnGg7FHxS9aBLe+kaaOYe8fzSvwN+4RRdn3+T7mAnS+kH6bi3Xn5oANKr3DSkIG
 LQ2WQKfDIO3T8Vn0mU1lraoHMzKQTZP7wcRRP6VMnWDHd0+tH3eirh/tcROorTXpHsDOUJ
 CrkeGlhg1zkuaieTNm6NprmG0HdCBzc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-OnyVD0O6Of2n3xQ2Y0t3XQ-1; Wed, 27 Aug 2025 14:25:48 -0400
X-MC-Unique: OnyVD0O6Of2n3xQ2Y0t3XQ-1
X-Mimecast-MFC-AGG-ID: OnyVD0O6Of2n3xQ2Y0t3XQ_1756319147
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b612dbc28so723135e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319145; x=1756923945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYZBzbSuHz1ck9mAe9qDxSmyxZe5JBQ+ptoP0h/no4E=;
 b=cuWKJH1mh77L2CUTbT6PH4F85UspQCBP7xKrUPiNeHpr/eZuydo2bGnlXQqzFm3IX1
 7VXVpieNU4FQaIH822UOQA/EoaD0La2Enu/Kbh52WdpJG1pbt5hQ42GeeI08LeHIlcFA
 wjFnr5bDm4Fhr3Ege86/3lZTVRUWbgJZuP7MSEEiV7lfgE4slZs5eEJOi1xFZUSF6YHQ
 kP/F9GIRsiAGebt6I8+5guYubUQXbTu0wg4AW+8GISSaahfkWR5cRMEuNiEg4iJFRY28
 5JPyakXWWS3VnCH0oU+QUHy43L1FXVS3nDR7v90L+2aojNnWcmLVIIOzevJs3+AKraNd
 0EvQ==
X-Gm-Message-State: AOJu0YyQpEKONyJTSQM47K/Z5V/oSJnVGiwmpLOmifD+Nh++ET/ykVGt
 WrEYg4kNb880g8omGriUkf+AmfO6Hbd6WPAcuoTG54ltN5nkTfgbILYVdTtltF4IWvw96l1FPpe
 kUbX1F1lty37duQGO45jWf1H8yBGbksn6wGSw088f+OgmaFfI+PZ0oSl9foUWLxUYx8sJIFyQH/
 KSgdZjkOOAyg+sBMdH0MeXeI0FzwMyqYZwoyT/H/O3
X-Gm-Gg: ASbGnctdkBYb/kMIEvg2ypgWQRdq5GChCHRj7b9J4gd3Puh80RjUsiTjmGka/25DbvB
 m7LZ0qdB2/2FM+50Tv34zn4U0f/2o1u03O68ovldm1PaR/oVEdus8z3tHeNjLWut0ck0XEwQEPK
 HhgVYD5dmB7CjGWWXQVYFA3L0Ir7A/39s028LI0lMduhdfhHeOiJ09Q7wf5kCYWTevNjOr/iEBX
 EoGl34Liyo65h4NR32fwOANEch++hFIb6VIPgh6G/dycly0uL9pffCu2wsDhpxtJpE27rbu0H09
 iokHLC8CYY8b+xfhDEDqv8MMzKKq8tHPdLMDtw0rtxzEAa+Qfv8nmf9ONqbwkMJ6vAaRQejaxHe
 3eeIa34iAgCciP9/jOsPu0N5xpdg4z9qA02jBgP+VA7Q=
X-Received: by 2002:a05:600c:3baa:b0:45b:7699:fe6d with SMTP id
 5b1f17b1804b1-45b7699ff37mr2668465e9.17.1756319145535; 
 Wed, 27 Aug 2025 11:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkA2x4fl3Zds+J8KrosOJepd6JN97I3W0c54Zg9TmOizRHK2RyhQU13VIdQTBoMsddcG8AEA==
X-Received: by 2002:a05:600c:3baa:b0:45b:7699:fe6d with SMTP id
 5b1f17b1804b1-45b7699ff37mr2668315e9.17.1756319145023; 
 Wed, 27 Aug 2025 11:25:45 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b69b7529asm29941395e9.0.2025.08.27.11.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:25:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 02/14] scripts/minikconf.py: fix invalid attribute access
Date: Wed, 27 Aug 2025 20:25:20 +0200
Message-ID: <20250827182533.854476-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Fix parse method to use `defconfig` global variable instead of the
non-existent KconfigParser class attribute

Fixes: f349474920d80838ecea3d421531fdb0660b8740 ("minikconfig: implement allnoconfig and defconfig modes")
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/20250820-scripts-minikconf-fixes-v1-1-252041a9125e@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 6f7f43b2918..2a4694fb6a3 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -340,7 +340,7 @@ class KconfigParser:
 
     @classmethod
     def parse(self, fp, mode=None):
-        data = KconfigData(mode or KconfigParser.defconfig)
+        data = KconfigData(mode or defconfig)
         parser = KconfigParser(data)
         parser.parse_file(fp)
         return data
-- 
2.51.0


