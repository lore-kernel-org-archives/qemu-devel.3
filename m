Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF66CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB0D-000577-88; Mon, 28 Sep 2026 09:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0B-00056h-Kw
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0A-0004KO-36
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ux77QkOlHCa4NF/rvx8ihTOVQe/ui4LtamGz3z//b7c=;
 b=EIEht8FmnbD49IEFEDgdiwtklgB3aVkgcsW37eV2jfb4DIYr+5yJFoEaL2ih6eqQfGGBGo
 VqsX7Uw1MK04ea/KZxpHllQMuLhook/tW99uJCh5WHcIGhorI/Lj2aiDzij5UQZwdc8gYm
 GmqqxXaE7xutssRudcf+hBFUWPYnNmE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-24_irJwlMkSiCZyLhhTexw-1; Mon, 28 Sep 2026 09:02:35 -0400
X-MC-Unique: 24_irJwlMkSiCZyLhhTexw-1
X-Mimecast-MFC-AGG-ID: 24_irJwlMkSiCZyLhhTexw_1790600555
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c29958acf10so3989166b.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600554; x=1791205354; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ux77QkOlHCa4NF/rvx8ihTOVQe/ui4LtamGz3z//b7c=;
 b=UhuYuQrNsqUaYOFHih46WWCMUpkNPF7AZj0tVlgaKGv0/2W6sLylSGNkUV98qvY62o
 +jE1RlXWqGHrJf9SSy8eIYd9ysZOGKu4o4WPayz4lkHaMdcBp56gkuuIQEW3zVTJHXK1
 qy4G3VdoiNkTEK+F18HRNDmrJV3S+RPUuY0z5PW49dwdHa6ujooNIAT+0zr0y50zlH50
 SV0mfPk5yxggRrnW3mDdIVX8Rkk1wHZpz80xd3Ix8h+GDEHSMllUEVrzu5Roavh+ej2x
 QKZH/MFMqmBzAj/VUZjKFxVJuy1SBw/llr/ic+ft1N8ZHDLBSWp4gjOvBbknQTcyRY/o
 XJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600554; x=1791205354;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ux77QkOlHCa4NF/rvx8ihTOVQe/ui4LtamGz3z//b7c=;
 b=vFI1iY57Fx7zAruV052DxyY7ecm8WXNd94WIgwjOshEm215hBUJ4Hzs7uxpR2aM0F4
 EdKJi0OLbuy8A2is9SerjgKLgP4oBox/4EOfNWjgkIXF7ZzXwBv9vRl9DjmKbWUl5Cy8
 78es7ZtOxPe00MlMj/M7ZdUHShdTW4PmupYVNy790qjsB39qK7A/fgRPGCLp736jc1MI
 PaTQHLzqEx6dnLE6LwiRvn2g/yPNjUeyFDVnW/3zxhrUrco3bMAl9W/zBUyvPuRfwv2p
 05OFs5NvOhPcizM+DulA+OZWSoxeHdzIfcSkarVmNO6CYXMr8bWNUX8ScouFL6xVNT1W
 OGQw==
X-Gm-Message-State: AFuF++lNdLAUS9sZvHiurOAKOZCkrVBh087gq2iSEAKe1LdNCKoP9jKQ
 VETZ8Dw+y/gb2bMPwUEs40ej0GQCPYDQJtUYRmpQEQA2cdjXB15KI5aMwud5+cTKxpSvycTXLAZ
 OBtzYlbdWUU5eiFAHGLRUpFor8eHKi9zPMivcKTMk+IChdPjgZMuIopWrMQ28kPKsrywZ6HrlLM
 TO8hJeVo1fU3gzhqQT+M5gwPIH5hP7JvH4jDpIflsZ
X-Gm-Gg: AYBFou3f2/UtIG6B8MYlOfjTIgu6+9vgUxv3ieiKy6CBwl4ISMhG4Ktgx8jtyrDhOE4
 +mCvuoXRH/2DtR/svHOenDpaQjkBtWzef8UKBlyHo0jGvZDugBWrmFuuZQZCxst3/OovkNxAfGE
 ZfuMeJkUERJrP5tUHVJPBhKJv+hgOJ+TdZBXqyD/Jv/br3EgN50eRGG4Z/Pwo/Duod2pczUQfDx
 gNju9Fd3LxclN5GIEGlz8WlboxRxgb/zktX3j+6KHs5zmEr2FVySwwOULTwo6sQfrAwGEPTemxP
 rnZFZb5qpmGlseTxrIjKtS17V6sXy5k6akUSodDtW18say+OFIS90Jw03ZOcXH1hRO4WfbEEo4x
 XW76lcgQSlPsCcF9v5I5Sw+LeKKfeZExWIpG9Nv+EsnSjw37KD57rppOoVWh+X6fHmlnkYzKnjm
 rp1nmZ
X-Received: by 2002:a17:907:7291:b0:c2d:c6e7:9e9a with SMTP id
 a640c23a62f3a-c2dc6e81bfcmr391537266b.11.1790600554550; 
 Mon, 28 Sep 2026 06:02:34 -0700 (PDT)
X-Received: by 2002:a17:907:7291:b0:c2d:c6e7:9e9a with SMTP id
 a640c23a62f3a-c2dc6e81bfcmr391532766b.11.1790600554025; 
 Mon, 28 Sep 2026 06:02:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2af70056bbsm387784966b.49.2026.09.28.06.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:02:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Jakub=20Lipov=C3=BD?= <lipovyjakub@tillia.cz>,
 qemu-stable@nongnu.org
Subject: [PULL 01/30] target/i386/tcg: raise #GP(0) on null SS load with RPL
 != CPL
Date: Mon, 28 Sep 2026 15:01:59 +0200
Message-ID: <20260928130228.877003-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

From: Jakub Lipový <lipovyjakub@tillia.cz>

In 64-bit mode, loading a null selector into SS raises #GP(0) if CPL = 3,
or if CPL < 3 and CPL != RPL.  helper_load_seg() only implemented the
first case: the null-selector path never examined the selector's RPL, so
a null selector with non-zero RPL (such as 0x0003) loaded successfully at
CPL < 3.

This was caught by test_sreg() in kvm-unit-tests x86/emulator64.c, which
additionally fails its subsequent non-null check because the wrongly
succeeded load leaves 3 in SS.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4204
Cc: qemu-stable@nongnu.org
Signed-off-by: Jakub Lipový <lipovyjakub@tillia.cz>
Link: https://lore.kernel.org/r/20260818164414.245189-1-lipovyjakub@tillia.cz
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 6d424349a58..cad19f9ca6b 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1411,11 +1411,12 @@ void helper_load_seg(CPUX86State *env, int seg_reg, int selector)
 
     selector &= 0xffff;
     cpl = env->hflags & HF_CPL_MASK;
+    rpl = selector & 3;
     if ((selector & 0xfffc) == 0) {
         /* null selector case */
         if (seg_reg == R_SS
 #ifdef TARGET_X86_64
-            && (!(env->hflags & HF_CS64_MASK) || cpl == 3)
+            && (!(env->hflags & HF_CS64_MASK) || cpl == 3 || cpl != rpl)
 #endif
             ) {
             raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
@@ -1439,7 +1440,6 @@ void helper_load_seg(CPUX86State *env, int seg_reg, int selector)
         if (!(e2 & DESC_S_MASK)) {
             raise_exception_err_ra(env, EXCP0D_GPF, selector & 0xfffc, GETPC());
         }
-        rpl = selector & 3;
         dpl = (e2 >> DESC_DPL_SHIFT) & 3;
         if (seg_reg == R_SS) {
             /* must be writable segment */
-- 
2.55.0


