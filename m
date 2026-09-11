Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6550FC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAQ-0004KD-Sl; Fri, 11 Sep 2026 05:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9u-0003hV-B1
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9r-0008FL-V8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5re7lxkrkt8+upQzc9fNBwoUOfPVSS5sXD8pGJHek6w=;
 b=J4s+3IFjL2wstmi3cCYONxuPPqJrpkRwU4MNEfLXJQ5SaPXrmzpCDss+l0W+XO4mHX/8o4
 5Qk/GeTiFjuNECdRbaCY6UsfS9lkgMNDbIQRM53BntLY+VJ/yIGUkDJBCwdw4OWrS2/FsW
 n8OfvncTkJu7Z9uSw7Y2KGZWd6JEEXI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-XGv7e90QPK-KaV-lr6NmzQ-1; Fri, 11 Sep 2026 05:02:51 -0400
X-MC-Unique: XGv7e90QPK-KaV-lr6NmzQ-1
X-Mimecast-MFC-AGG-ID: XGv7e90QPK-KaV-lr6NmzQ_1789117370
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e6683d48fso1171415e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117370; x=1789722170; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5re7lxkrkt8+upQzc9fNBwoUOfPVSS5sXD8pGJHek6w=;
 b=pFKBjkcqLvpuB71Fp50wVnBrCy1oTohX+AQc80Bfuf8ey9SIhQx5Er+tEq5XWbA3Xn
 iAk+p5P1SOl2r0tGxtC2xOwQ0gPI0tvtLI2TzOqtM9pkje0qlbFqGPmX16kvBx3APmrr
 oiUn1HYSdnblPr2HmuAnd7XcH+NxjszINa6CxMMNhM/sdgpIWgngYwkqYzmEKthDX6Pk
 CickmPUM51hv2QeG69WVMOJlnRGXkl1P7Icl9DT6qtIQd1e3edRCOFOxUgp5gupDYaLU
 nUahsCCcMAP0B9ER0w6rTd9EasqcT3eT3XBf7zFcJYByX7TKMOdFsbPJY73BbflYw3fs
 xoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117370; x=1789722170;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5re7lxkrkt8+upQzc9fNBwoUOfPVSS5sXD8pGJHek6w=;
 b=E462e/xKV1P/LrKT+HPyNG1qyeUeC99xAWFV6oWGNwtsLzaSsHnpanM+7T6r3UB/Bm
 bnfazBGnqdHut8N0mUCn9VoGsMUzWWEUo7RdGpz/BMbB7AlPAJcY/uPDzusjnsXIqYEc
 zmFWGtiAbs/637VKlAHnqsNSFdtcJjEG/VTVi36WFgBd8nyBdkaYWvCeMsPIiO46qIVh
 bK51puGQloEPK4kPCWUwJ+XMOXP37zhHBvGUmhjSuPo808irwoiGNEJBNdmdprC8C1e1
 GIvWZxX4KC2y4yRJh0EQ8eizYREwIBzGIo5+0++de1JwWwHhSr8jwlu4ueqwekP4NG7z
 J3oA==
X-Gm-Message-State: AFuF++lIxYQoE39DmRnPCbuoI49bNCEBw9ek/B5h+6GvS3jKYw0amp0q
 +2LeKSg2wah75ng838/aOATko7DWx/e4+W9WR4vwbtxufloModEx6MKA2IdVTy0GsD7a9VugJ6D
 j8MWxHkVuBnAQv1BNGfwHXjRZV2cDpvVv3Sw64wCo9ZmQTLS5gQONvlf04VnvWj0WnMBfpYFLu+
 N51T7OzR0pLl8yP5nsO+vCi2z6kd+D2EmEhw==
X-Gm-Gg: AYBFou29gyljazSe7nLp3w0INGVsMG7MFkrlngSEP3nN8oqsS+IVediNVvW6Wc/3t+D
 ixvQ8CtaPW+QP0ghyPATuD021XOIw3BevQgGhcOlXg6064JNUbrYtUMLNAfAWzntezaS9fO028N
 0sNvqpg/5qCBed6Hg/CUUtPND1Pn8EIU3uz6BLMfbSTA+8anSLtckAovGqhcXGq/8O7Ogd+L7D4
 Zsvghg06Qpn3nEJ4/0W94oIFbMNMmhDHmJmBda83/1CAgTa9lKt55UVEQ2ZpzVviqHNqHS2weuZ
 4Ab4cwsCs0cmpC2LDeXmnRRmePoAkRQv5Zh/8B9Tucx9kpKG7rWFmt+lBpRih/BWGGMkKpuSEpv
 esZdj43iz4H2eTxPAU885x7s=
X-Received: by 2002:a05:600c:3b90:b0:49d:16df:8521 with SMTP id
 5b1f17b1804b1-49e619805f1mr34590815e9.4.1789117369747; 
 Fri, 11 Sep 2026 02:02:49 -0700 (PDT)
X-Received: by 2002:a05:600c:3b90:b0:49d:16df:8521 with SMTP id
 5b1f17b1804b1-49e619805f1mr34590175e9.4.1789117369073; 
 Fri, 11 Sep 2026 02:02:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e81asm4602336f8f.7.2026.09.11.02.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:48 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 37/75] meson: disable "maybe uninitilized" errors with -Og
Message-ID: <9eb79bc1aa06d89b19273562dec8206d1e38b70d.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

GCC's "maybe uninitilized" warnings depend on optimizations
for code flow analysis, and produce false positive errors
with -Og. Default build gives us coverage with that,
so let's just disable with -Og.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <f559b622eb2d1a384b4f30583a8af10531f4b032.1785144729.git.mst@redhat.com>
---
 meson.build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meson.build b/meson.build
index ec9b05414a..e2da31880b 100644
--- a/meson.build
+++ b/meson.build
@@ -746,6 +746,10 @@ warn_flags = [
   '-Wno-typedef-redefinition',
 ]
 
+if get_option('optimization') == 'g'
+  warn_flags += ['-Wno-error=maybe-uninitialized']
+endif
+
 if host_os != 'darwin'
   tsa_has_cleanup = cc.compiles('''
     struct __attribute__((capability("mutex"))) mutex {};
-- 
MST


