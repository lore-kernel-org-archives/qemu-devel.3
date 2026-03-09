Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD06FCA178
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfnx-0003tK-33; Mon, 09 Mar 2026 14:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfnv-0003t3-Ne
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfnu-0007ol-C1
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773082689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=barQm0ytYadQlbHRY+PvBMzrx7IGIkBCbHT+M4DhJKE=;
 b=HNEy3Ouc9hXUXQtHxvDtRvDQ0M/YgOah5FkfwZq3b075+actH/hSyT4zFhzJc+x9+6XLlQ
 8VRVD3tI0D8IXGyRwhO0tHpXhSn08S4b6xb8SK4iqYgd5JRyUP57cQFn362J/jyC1ALG3t
 e48p8Xi+UhnC1Bx5AJmbW5JBE4Nq/AM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-GFuDroE0OymMmjN8xL9U3A-1; Mon, 09 Mar 2026 14:58:08 -0400
X-MC-Unique: GFuDroE0OymMmjN8xL9U3A-1
X-Mimecast-MFC-AGG-ID: GFuDroE0OymMmjN8xL9U3A_1773082687
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439ae2cba40so7126589f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773082686; x=1773687486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=barQm0ytYadQlbHRY+PvBMzrx7IGIkBCbHT+M4DhJKE=;
 b=i6W0ECcyemJC4AtnkGGHgPX3ozjfj5Isn+OF2WSuKkexhN2zH1rR5lnxkL1xohJEbn
 YtngrInfQm8coyY3N2+v3uF1GMS8WBz3QRflQhV4ZtYATFSv4MNeanwpb27+le8v9912
 KdWdNYED5ctEQbUYum7lIagdahY93n2CDlJt4ABjT8T+h9bs6fqyvMFtvFJlBVyc9zzK
 ZlCpXjLg06RjJykwi2sjjd18gmakSmkhtrqYTDEUCjLuSBkGcCPOrH2rsu0jgKY0aL9Q
 9bh1yPFd3fH51+TcOczTly9a8H2YMVV19OaKaeQzd/iFitTIAA7gmWFelOfE9+4b5Lqj
 yh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773082686; x=1773687486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=barQm0ytYadQlbHRY+PvBMzrx7IGIkBCbHT+M4DhJKE=;
 b=tobHTkFJBfh9ZTz4LVysVt4Z3X6nQhdgj5aPhx1HT47MwwGB4cBPk3tB6chenmTB4k
 jw70dJU5Y1RPZxhwg06BhS9agPFTPjoMU253dBjZSZ4waai0YShq2/vshmbcEnZmcC04
 DRuH/2ZhIQAsVW/WMmyNHWJ+mH3Sp1jqwzLdhaaU3lmK33UVf8/AuxY2nVyKwGqOtTq7
 LJeyOvFu50w6FP9jpSJ70iOG8TBP9RNUZlZLw6v1ohNE+RBvNrWmZ50x9Vkjnoe4Rngt
 ZXLMA1t7zseJV3PMnqSgpxO4miDzEHMOmAfPZz5XBYzoksIY8sUwKxvgVAsXaCPMEgYU
 CVRA==
X-Gm-Message-State: AOJu0YwnfYpiiyjSK3LrHjuMXtG6wF9PGUdfbmc76Oc9ano2wKw6lKms
 R9Te0f3BmgeaGkT/u57yJDIPMR1wIQw8T95rS1/ZaqzPRRBwjvLMFlUFQBuYuwghbVo0vSS7OyP
 pwe3gVUsLUIExHMqs1BIMxJ/JtLs2v37QqyoWBwKGBzKX5/TOrx4bz1o1sR9ixqRqGYGc18YHxp
 iFKVRpbuf6tFf0zGjaF/LBTjIVxA03JEiwGTDv7R0A
X-Gm-Gg: ATEYQzxs0y4ZTtaU4X8HnSHWNboC5g9BCILUlgbEnRXSJSPyjjhirygTtqgxWOzRbz3
 pMVZusDdnm8FvxgPYan5kwbanEYRNutjm1u1ijMLiE+jvddBprmpge7Ud87HdM0iButUR8OZqbO
 OoFG5M9QiEkINWsfQAW8S0jjtDUun5LxQe90ta/cwdHIfKvE+oIlsdtEQ3z4fiOYMAUxelecfan
 MU6kKuLT6i9gofsgbVreFQcb7FagLcjowKsMC2YMTMZHczxT9TD9ST/XsWpkawwvDA1xl0u0/je
 +kulZEZolqzNzBnCA4MHZnvg0Xay3s6Zf5I6rmKyoAxDA3lfpz2P+E588E4/JHRlsGli3+I4/Is
 0DTBD1OTaRm9X+UJ6Ieo+tNS5JD59dIUyDNqwolSZfmmiPiJHQnYoLpCfTveeyu6tbxWqiTa/79
 35B67hz74VnvsEcaP+o1fJyATtNAE=
X-Received: by 2002:a05:6000:310c:b0:439:b28c:d47c with SMTP id
 ffacd0b85a97d-439da8820eamr22385321f8f.37.1773082686383; 
 Mon, 09 Mar 2026 11:58:06 -0700 (PDT)
X-Received: by 2002:a05:6000:310c:b0:439:b28c:d47c with SMTP id
 ffacd0b85a97d-439da8820eamr22385294f8f.37.1773082685873; 
 Mon, 09 Mar 2026 11:58:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae35cf7sm27245539f8f.26.2026.03.09.11.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:58:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 05/10] whpx: i386: do not enable nested virt when
 kernel-irqchip=off
Date: Mon,  9 Mar 2026 19:57:47 +0100
Message-ID: <20260309185752.76865-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309185752.76865-1-pbonzini@redhat.com>
References: <20260309185752.76865-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

This combination is not allowed as of build 26300.7939 and results in:

qemu-system-x86_64.exe: WHPX: Failed to setup partition, hr=c0350005
qemu-system-x86_64.exe: failed to initialize whpx: Invalid argument

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260307181856.2209-5-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c172e86886b..9c60295d553 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2160,7 +2160,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (processor_features.Bank1.NestedVirtSupport) {
+    if (whpx_irqchip_in_kernel() && processor_features.Bank1.NestedVirtSupport) {
         memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
         prop.NestedVirtualization = 1;
         hr = whp_dispatch.WHvSetPartitionProperty(
-- 
2.53.0


