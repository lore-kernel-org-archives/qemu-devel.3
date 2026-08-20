Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7467C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5ze-0000Ey-7n; Thu, 20 Aug 2026 12:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zd-00007k-37
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zb-0005kP-KV
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRs9ooiaAGbBPTn+lYObem+X3XzELNql2asth0V7gOg=;
 b=e3wPWaW+sNLhaH+12iXT7eNT112LDZJEFARlCeykIvsl9jSPoEa2RJYZC9y9ODmhAR2Lj8
 LImlc1yPN7wsI9kzgQSz3n1dwAK0vFcubY2zqSEgDV2Q7bMRhz1i8OrZj8OhSJcYHY+f28
 ByOzVN8K/l0cXQ7Rx2AP1sDiyuJ9h7k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395--y-0xkTaP4yERsmV3Vy7DA-1; Thu, 20 Aug 2026 12:51:49 -0400
X-MC-Unique: -y-0xkTaP4yERsmV3Vy7DA-1
X-Mimecast-MFC-AGG-ID: -y-0xkTaP4yERsmV3Vy7DA_1787244708
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f835ac1aeso67121f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244708; x=1787849508; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kRs9ooiaAGbBPTn+lYObem+X3XzELNql2asth0V7gOg=;
 b=AI8s7kS9z72OhGLqbca4SmqOGQ1rXkcH0c0Kp+IjGNGLF4ajRVgPgJKDTlSTyzJHfS
 byH/cbaxkdfAAjWK4n2GssRFt/zrODC/IaijKiH7ddodPd8uchT8qqXviwHuBLK+q0Sd
 ejsFRcI7xU3bdrL2trly13BQNQ00T2dfkDXWVXoXpjl7MiLzju0gO1lLuw582f0OToMm
 tQiX2HitBc/2F2oZxQS2FIwcpYyhflca7HwDP/XqviAm5d6Vf4cfulLL8UKIbjN1koCO
 HERfQNhdsI70NQ80o5lB+GUjv3S2vQv1K9bylsWk+SGnyzE4VXdZ9s2MLAvLzXkUGg6k
 Ezyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244708; x=1787849508;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kRs9ooiaAGbBPTn+lYObem+X3XzELNql2asth0V7gOg=;
 b=i8CnsynpPN+XlE1lspYDQouK5NK7Xk9abNIKdrLhxC07SO34RpA+jpU4dPxCUBAF6I
 Qp4lfSANVPRr51uhIifJ/6+8SeAV7PvXfa9jzT/rbNVfE0QDQBA5ebh3F2/muRwnx818
 R/HX6ukL34v0MlMWT0qa36yDvOUaEGR8uQEwPZw+9Qr69lSY9j9h2QpCBqMpfS8LAvZP
 +EflnIeZXfc6xhIAFKO+eqaNIFeExWU5SoBoP4FN1Rs1GSJMB3yrOjYjC2uhrBS+vVCy
 ij6p/urAM8dBaSYapTmMvOxzGEWjYVlxJqQJ0IjzsqoWbVxwL4IdiQDokBtCHdG8AlQS
 5RFw==
X-Gm-Message-State: AFuF++mZWp1kFnGz7s8WaB2+xosG6O1XwWUmxfggXTWsy4fhQquUtYJr
 42MT3CUys5IzLFNVN155xTLONBBMW2WNbyUCyrkQ4vd+YTaxKGAtIzcldYMIb+FQHrNGnfT8YQN
 3OiDP7iJWOhL7cbHMKh/wKXZL/2a5V6UqU5LI2Ey56XZhxviV6L4MARcQ495qNv7jyoRNjkCkes
 kcTCTDpNvEbgR/ipjHG7a3qVzaCyPJGeCkrmNr9dwo
X-Gm-Gg: AR+sD11eVEJCbaEg/xLr4r+4X5IoLJBrRDiyZbzEcgzrCIp/G76RWZNbM2XZbJ4G5w1
 D5w35CmGn2V/N+tJaO8oIFAYjNc1T0jRo7dQNtISnSkO9GsueLwL79SckTEsJWs2Qgfl5cahncK
 6JpxBcytcL21nVFStMMSj7gjFjpFPDUlurM69qkok37jRM53fe1w3uDkuqWGrE41euWCECMEFeA
 pG1gpn2Q8IUGz1eE/rpO0qTA5iZkuLLo4fyuS8iFUErpPO2eOsJD8YGDanIRhpMFFdjsxiyR1ew
 A4KS980sCSFhlCizSEEmw5Lqwg9TvdZMoJZUVkan4D57uY1JcOLRy9Ld0ySn+McZCs6zrTCMUCe
 5XyPMYg1cYlZ65pXjJ2qSqdMrzziBnA5mVSIxfuknnHglu2bTHfox0Qap5XbWZTg1tR/oasRmQR
 RJhsk=
X-Received: by 2002:a05:6000:25f3:b0:481:4810:d701 with SMTP id
 ffacd0b85a97d-482b1feb276mr29084462f8f.19.1787244708167; 
 Thu, 20 Aug 2026 09:51:48 -0700 (PDT)
X-Received: by 2002:a05:6000:25f3:b0:481:4810:d701 with SMTP id
 ffacd0b85a97d-482b1feb276mr29084324f8f.19.1787244707662; 
 Thu, 20 Aug 2026 09:51:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1450e54sm15497331f8f.11.2026.08.20.09.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 38/53] meson: make linker warnings non-fatal on Linux
Date: Thu, 20 Aug 2026 18:49:41 +0200
Message-ID: <20260820164957.1895963-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These cause a werror=true build to fail with Meson 1.12.0, as it now
makes linker warnings fatal as well.

Cc: qemu-stable@nongnu.org
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meson.build b/meson.build
index 49a5baf5b52..40e3f4ec44c 100644
--- a/meson.build
+++ b/meson.build
@@ -602,6 +602,11 @@ if host_os == 'windows'
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--no-seh', '-Wl,--nxcompat')
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--dynamicbase', '-Wl,--high-entropy-va')
 endif
+if host_os == 'linux' and get_option('werror') and get_option('prefer_static')
+  # On glibc systems, glib causes warnings about getpwuid, getpwuid_r
+  # and getpwnam_r not being supported with static linking
+  qemu_ldflags += cc.get_supported_link_arguments('-Wl,--no-fatal-warnings')
+endif
 
 if get_option('fuzzing')
   # Specify a filter to only instrument code that is directly related to
-- 
2.55.0


