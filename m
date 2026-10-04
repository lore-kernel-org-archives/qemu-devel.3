Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80775CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQI-0001zE-Hc; Sun, 04 Oct 2026 06:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQ9-0000yO-Nm
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQ8-0003Oo-4d
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+fwnNec8E3jcq1ijdcJqyfFHoAx+afd3Zr988iUhHQ=;
 b=cDpxnK4/N0KkVncJXUm6X8e0fJTyIdh81jl8Muf2o+ce3oIa06G1KuIVGx4JFp+SxaxC1A
 XtzyfaD3qj7XcgzEGiPYM2Q98Y3UrpLcXpmL+qpBqbVpTkBQsXr9/zYuwyK1EoCYL0SWP0
 xBHlV7DKZTz6MgsyWDzTK4cKTey0Oow=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-So2UJHBuOoC_XuMHn1BhVw-1; Sun,
 04 Oct 2026 06:26:12 -0400
X-MC-Unique: So2UJHBuOoC_XuMHn1BhVw-1
X-Mimecast-MFC-AGG-ID: So2UJHBuOoC_XuMHn1BhVw_1791109571
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24F6F1953941; Sun,  4 Oct 2026 10:26:11 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AB29180034F; Sun,  4 Oct 2026 10:26:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:57 +0400
Subject: [PATCH 43/63] hw/display/ramfb: validate guest-supplied stride
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-43-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pwzXqMiw+qUGWPZKexEf3qmBaz5O1KpJaihmc+TJbNM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikk36DfqcXRrayJlNbtT0cjFuZ5136nWHCcS
 Jxt8+Knd12JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJAAKCRDa6OEJdZac
 5bAUD/sEAKEAi1XFgKpFOqS5xdllHKgQ4kDdk4yg3tcaiGK/8nxgnyaVWB4nd16PcyWqyt10n+9
 IocRm7YL7bgFs6mCBkEcHT1osaWzsC5bs6TDSFEkZIqzDRhAF68qbXjSd31Yt2APNcBQ9oBpSw1
 MXp1ExwS6E0d+8ul8nn2K/e7TTcBrw5y/dXNWX0R2LzZFuROTrf2iYy3lvxFnqnG+P6D6M53rLg
 ttQ5DYt7W/7LVSPw+ZPWIbvycKjmiYjzFnZs8fnI3fKEd1bE+gaY1XaXGamC1YglNS6a9DvTouK
 +ndBMHXdNe3k8sbqweOe3jpuC9muIDDZZ84zJZQkPAOn1Bpfh8U5IQkexRvwAL8mgd5tTk1S/wp
 yR/2b1Twv+Bg+oqxq+mfywYjwg6a3w8iql4pi9tJbR14vrEJcw+dF5uUkTog9HGWvUjYnEDRz4U
 AChCZr9prQo4OBOSqGSst//mOnq+P1Cevu/vGi6qxLyW/YdTgj5FEQ+z1gT5jgAGEaIX4i+OXgF
 v2yvyNnEs30C5UcJuhJ15/T7KHdARS4PemLk0npRkXG2Ty8d7VU5r6H+vU7QWRs1R+q5eKiHHL0
 cw4w9BQaxO83FYgrLmgE4zR3X1LXMY6OC1avM1MlsxHwm9Xvt97l/QYlEfmr/mBTQbBYQHO06AI
 dgwdaLa4Gmmydeg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Validate the stride value provided by guest firmware before using it:
it must be at least linesize (otherwise scanlines overlap and the
mapped region would be too small), 4-byte aligned (pixman requirement),
and the stride*height product must not overflow INT_MAX (since
pixman_image_get_stride returns int, used in the unmap callback).

Without these checks, a malicious guest can craft stride values that
lead to undersized memory mappings or integer overflow.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 3fcf15df0073 ("ramfb: fix size calculation")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/ramfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index f477bdcc2186..2d5378754717 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -63,6 +63,9 @@ static DisplaySurface *ramfb_create_display_surface(int width, int height,
     if (stride == 0) {
         stride = linesize;
     }
+    if (stride < linesize || stride % 4 != 0 || stride > INT_MAX / height) {
+        return NULL;
+    }
 
     mapsize = size = stride * (height - 1) + linesize;
     data = physical_memory_map(addr, &mapsize, false);

-- 
2.56.0.rc0.29.g47ce80527c56


