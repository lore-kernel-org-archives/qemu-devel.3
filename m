Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7BBC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ouj-0001mc-C7; Thu, 10 Sep 2026 20:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4ljr-0001gI-Pl
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4ljf-0006Qy-4H
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789073463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hrTN7OVSCNm9vbc/NCEC/WvGaVnoOJUhrqiC5Yh7fcA=;
 b=QaDSaHdhRzUuLtDy0yuq67Q12pY+w8vwyopXybTCqLGwdeTQODKMvrhyKYLvaAaq9MQ3OI
 kWJ28gX0/6Gi/3E5Fk9bTZQRudvBJiii/tMY+gTG9B0++37dTOjmuyInrMNopjZDWIsUhQ
 Cb5ZB9cMbfvcSlU64rm2O6az/Cj6gYI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-iy4EpvhXMjyVYc2al5Y48w-1; Thu, 10 Sep 2026 16:12:10 -0400
X-MC-Unique: iy4EpvhXMjyVYc2al5Y48w-1
X-Mimecast-MFC-AGG-ID: iy4EpvhXMjyVYc2al5Y48w_1789071130
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48597bbd963so91978f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071129; x=1789675929; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hrTN7OVSCNm9vbc/NCEC/WvGaVnoOJUhrqiC5Yh7fcA=;
 b=O5Fk62u0X84WbDL03XFxRStj/8VJs7pEGDum5lPF+ySOHKL+zPCE2CnmRuOsYGJzIH
 E5MEaq6X658bGJQehc2NcGwDWuhBAbSALGbLGO7VSynG4bgV0PYLC5OI9Fb3pQ+TfAEa
 wMQlp+v1g70LO1y3iQ7oLLrVT/IMhzk8HClt7pUf0iKE3x6WcMahT8dIROn1fGJXgFmo
 9lznMZnT4XjrexcrNAmgPmLdRlLVumLoz84X7Ug7XG40GOwU+dhvxGb9OLMOm3i0ajpJ
 Olx2LqawimiKy2kYjK2DZTpZKmzC7UpQuYfNE4pc/ElYrCH6n8XTbeicNv1VDWCz9A1j
 9z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071129; x=1789675929;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hrTN7OVSCNm9vbc/NCEC/WvGaVnoOJUhrqiC5Yh7fcA=;
 b=X0mn4K2hs6C/vsLy+FqBn+fVt4CXYYbQeJTWo9FozMXQQsG15LpikAO7Vr04RiyTT5
 33xagD/PgvtfLwF9ft3xqBCI95NJ3ju79XVv35YrpeBzd6M9CzdykHND8+6BezsgIy0l
 V4yRlD2FQWrLC7Kpxnq/PIwD22IqH1ag+aNEMdrt4aMb9W0/mjAuG82aPnMS3tWlXM3X
 n2tbTifTCC8FfmerLFwYarh2LsT6n/OHMLzFMd7qAYR0kJON15Z9yMLNZ3UEuEHkNwme
 DdUv0JcO6RoSiY3EGQNAWbBNTjYNNzq1I1LK4LamLG69Upi5RoljYo2x877P19Pyjbdc
 yBCA==
X-Gm-Message-State: AFuF++lP4W2Ner1tClM3b5wfGtTYGwTuZchAbd29EHBsw1A6Ef1QfrDn
 RqWHWz0V/21uOIeGq/QuqY5Jum1If2DFJ2J329HsCP37sUZjBzdnOLeRGqqBMavfxpi2B97S6wq
 V0joZi9PB4rHh0ghVk0uSaUo0vblAsLNeifeHGFzPm5I7mfQSUE92vqNPA1TDzTiS9sXrejKaSD
 VBFJa5/4MAhY/4Rl92gRwVZAdpAwUKTccxiA==
X-Gm-Gg: AYBFou2BJL49iBegvonaGu8FLetADjJl8teB8/LQge648jhlgcfcr2Fjhe664B7Qdam
 1vmtKIcpwlarfS3mVxc6PkXVzPoh/sHxWyOpx09IWojWuuFjK51An8/NnKbQPodwTy2WZVCNhME
 LtuyK8dYN1cdsAKHMFDQzM019Ghv1kTemJUl6hpJJN7+PT/Ms/OH2GWTCwJZD8RfT4wvtzboihL
 BLukr7mu0zQztlCNZ4Wv2NwetADDa3VOP790lQshXTFnB28ZCBMzdj/fxGDvwXI+Mcxfla1R562
 cCto8JfV/0lWU98jDfnVctTPir58aUPnwvhMXRW8bnOJXbOPiBo7igW0OcdPc+t182Pt/ENDztW
 EXvejeg8HqEmFvZ7hqJMOb7I=
X-Received: by 2002:a05:6000:240b:b0:482:ea08:8c8a with SMTP id
 ffacd0b85a97d-486eb33c4f5mr972951f8f.20.1789071129508; 
 Thu, 10 Sep 2026 13:12:09 -0700 (PDT)
X-Received: by 2002:a05:6000:240b:b0:482:ea08:8c8a with SMTP id
 ffacd0b85a97d-486eb33c4f5mr972872f8f.20.1789071128909; 
 Thu, 10 Sep 2026 13:12:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm842549f8f.9.2026.09.10.13.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:08 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL 19/90] net/tap: rework tap_parse_script
Message-ID: <5a3751757db840eefeef8d0e061281edd31445de.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Factor out tap_is_explicit_no_script() helper, to simplify
further changes.

Avoid extra copying by simpler code flow: first check for
NULL / empty / "no" cases, then get default or do copying
respectively.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-2-vsementsov@yandex-team.ru>
---
 net/tap.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 57ffb09885..2076f5b780 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -92,19 +92,35 @@ static void launch_script(const char *setup_script, const char *ifname,
 static void tap_send(void *opaque);
 static void tap_writable(void *opaque);
 
-static char *tap_parse_script(const char *script_arg, const char *default_path)
+static bool tap_is_explicit_no_script(const char *script_arg_value)
 {
-    g_autofree char *res = g_strdup(script_arg);
-
-    if (!res) {
-        res = get_relocated_path(default_path);
+    if (!script_arg_value) {
+        return false;
     }
 
-    if (res[0] == '\0' || strcmp(res, "no") == 0) {
+    if (script_arg_value[0] == '\0') {
+        return true;
+    }
+
+    if (strcmp(script_arg_value, "no") == 0) {
+        return true;
+    }
+
+    return false;
+}
+
+static char *tap_parse_script(const char *script_arg_value,
+                              const char *default_path)
+{
+    if (tap_is_explicit_no_script(script_arg_value)) {
         return NULL;
     }
 
-    return g_steal_pointer(&res);
+    if (!script_arg_value) {
+        return get_relocated_path(default_path);
+    }
+
+    return g_strdup(script_arg_value);
 }
 
 static void tap_update_fd_handler(TAPState *s)
-- 
MST


