Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C900C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x8r-0001rF-37; Fri, 11 Sep 2026 05:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8j-0001jI-4D
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8h-00082v-Iy
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hrTN7OVSCNm9vbc/NCEC/WvGaVnoOJUhrqiC5Yh7fcA=;
 b=ZDSz2EJbfWChx8MaHu4Z4R83pAuBd28TF7By9q7G4yBpQgUKXeR/rZsU7a5zsX6UXJAJqQ
 8W/8abiraNKYAS7MjKV7K993aJGFdohwaERizXi1EEbBciIWvXcLCTdFycFQeYBZe7+vAw
 wsNTV4D1jLjUFONfIt2gp59RTJIgZtg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-WoB3_NbnNV6CbdH1I7cShw-1; Fri, 11 Sep 2026 05:01:41 -0400
X-MC-Unique: WoB3_NbnNV6CbdH1I7cShw-1
X-Mimecast-MFC-AGG-ID: WoB3_NbnNV6CbdH1I7cShw_1789117300
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49ccfad90f1so3707835e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117300; x=1789722100; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hrTN7OVSCNm9vbc/NCEC/WvGaVnoOJUhrqiC5Yh7fcA=;
 b=oH2Dt51rHWFKRkYmKfp13btVrhhYp8t9u1pxehDbdLjHPxIO5ukyIB1z9DzvQowy2E
 1nNs3sKsIuVaNhh65MnrHtRgThCfc1SgCA788mPRVMAxn+paem3/5dxn5k9R+U73NPEv
 YjH1QIJ//wj5e+7jQrEDwiGYNJXuFzIFRZCXAsI2JoAqkrh311v7Z7SQiyJ2FyAaM35l
 miYKbORXWRu8yX2Thm8YwJNASv6U++9qpafeUAb0dQLkuEENLs5M1VBX4hRcZyavR0YE
 J0lWui8p5IvNnaJyWOg4WXEB12AfHzG4aYWnH38XWEzHNBnxd1+aSHR81rdjEdhePfux
 ITlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117300; x=1789722100;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hrTN7OVSCNm9vbc/NCEC/WvGaVnoOJUhrqiC5Yh7fcA=;
 b=MDikhgtr8DJyRqVAqV+YFpAGEIE7upcwYfHLWAPSqiqGffXhItj3iWUrLZaVxJZxk+
 +3C/ca3/Zr39zcCBcwQQlIMyaZmHartoJ1sQ+FWJQdwP07QL7B7FUsMRInLqkiNz63un
 UVRLyWyy+LyHpkQ3EBBCRSfEBIZz1+/Ysz4wGl+PEkA9Q5QrbrR4jO37rVYXSksElqgn
 QuU4Eg452E9sLsDPKTOduZVFIJWaloyX7sPBEIFlMfG751vuxWxqGLtk6mQcTUMPlyDP
 lgubhrUUbwAIlTc1Q9Qp3YjtU/SC0DI7J8/0AP+wXAnRzHYEdmxf4Rs7peCHOJvuX9um
 ugVQ==
X-Gm-Message-State: AFuF++l2A7xNhkgmal3qwbYXKB1h6LMHcyCKGmQ4AjcZHHzHsdTow9Bf
 nz2YS+379BWL5mUvHl7UbieUZafO8+7tY7MzNrl+Uk/RCUxZAW3EVLB6sTZQPKbyFGVSYY540KS
 yam4BQ7fFBItfAf8lU8pcIv6KT57W6kx2Y1IVKoxrje77anOzhcYIPFH7y0A1YM+LAc/9SSJ25X
 yoaXW5sMbSStCTiUNb7dbbA/9spZ063uIwUA==
X-Gm-Gg: AYBFou1dbkQ6je6Yoha3LJeQvfBRphhVkrK5OiHOYtRzo+W7i1WLi7G/8McMgqQUpMY
 AS1ChiomL4i0pnsC3wFvYZlrpj+85fLhPzfbWCbIbkOlDBdGaqtRm4S82UGJqC3T1XVOK787a5U
 MtwigjQj8EsZdTyb5hMBMwz/Pgzk3tTzWMcAgo1nmDkr8uuTlze8OWV2WVDIBOQJEb1sQC3iLrh
 uQA4DOLLLquRVTKF8TnDzvuI6eU8P6oASB+D7BaWovOObIHQGGHZnuCy7+42cW/JmgMAysTTboq
 UiIi+3kG12xuP8z/JAO+gtW/JW8TLRkh8ypXvlmeh/ZxOQ4WVBDWA5wjdDRkfepBU7BiYviPA9V
 aycJYDPL7OV00VEcF4+6Oxo4=
X-Received: by 2002:a05:600c:c490:b0:49c:fc6c:bdfa with SMTP id
 5b1f17b1804b1-49e619e1cf0mr31421755e9.17.1789117300326; 
 Fri, 11 Sep 2026 02:01:40 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:49c:fc6c:bdfa with SMTP id
 5b1f17b1804b1-49e619e1cf0mr31420675e9.17.1789117299211; 
 Fri, 11 Sep 2026 02:01:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a7a686sm40644845e9.1.2026.09.11.02.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:38 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL v2 09/75] net/tap: rework tap_parse_script
Message-ID: <a225c01f02fa7648dbe3c23fd9a46b2c171b239c.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


