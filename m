Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589C1C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hgE-0005gR-0g; Sun, 13 Sep 2026 06:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hgB-0005fy-HA
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hg9-0008Gp-Ul
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mplfvlplDsIbQ8CMTjUFhZCHSDsPoCfX4+C9HdFifGo=;
 b=QHMPb9SQ9t/9qxitVJMrluOFeuS4VUOKeY43xquCFKNkFOYOm+YUs56BN9qX+/2y9xqRlN
 kraAM47nqsQ7NRxZni6f/5Ifz4xMJlXDMIzqTdAT8AXDA8d6/pvEiH7qegDXFSsDU2+r7L
 uDf436UXgnhsV+nxLWa0YBBhMbZsVHI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-j1njv5XfM06zOWd5yR8loQ-1; Sun,
 13 Sep 2026 06:43:19 -0400
X-MC-Unique: j1njv5XfM06zOWd5yR8loQ-1
X-Mimecast-MFC-AGG-ID: j1njv5XfM06zOWd5yR8loQ_1789296198
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACF7B180216A
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:43:18 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B609019560AB; Sun, 13 Sep 2026 10:43:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:27 +0400
Subject: [GIT PULL 09/14] ui/gtk: Remove glFlush() after eglSwapBuffers()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-9-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DnWtgdAB0TNC1em2ijioKVEwDSkKLW8GRb8IIzQ74vo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4irjd7NS9zKmxhoRC+k2kU22uNAPq3ggVZd
 /jsAR7R/MWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IgAKCRDa6OEJdZac
 5SdzEACAUk0S44pLL/q/yeqY1vxqrqqIgl+6PCTDXZceXGycNRRPikTRCpgKpudPoJe+orXLD9q
 +1Um1wT6+WvuOUpnFpqOL64CaWjtbnxUS1CdrEpGERsEpRbLZ5Q2fMjjAJFsiG9lJBfJUmbH6fF
 9gGIjYhWJzFYXupT+7WnkCp87+z/W0GchD0i64aWBd6W3q+l7jEo82j2WXT1T4fAvGZ4KDEXiKZ
 x4kyLi5xHHzmT98L+eqbLAH3jTN5DQdO/EHpXRJYxV4SRSuFC3ykzUEUxpzJ9LpHGrGGJAy3WMc
 MUy0epkh9wjjrMzmUm8cLGUJPpKHatK+u22vYe8Y9xSN4DX0gN1aJXmBMJtElT2MagKdvvdfJUo
 jQb2EYoCuKwp6w+ZgTa7+wBCsI+4y0rap71oaUCk3lNsecMFb+YGnzxQiHc1grtmYkr2ZeJYbfa
 2mVBC8oN8d8KXv+2FmYuKkvnIDCq/q3EXVKd9Ji0CjaO35RIHPo3MuiUwdYGk2a16orr81LFCGO
 d/I2bGErwJVmeJZe9bCvPjkKeZccZ7iBnsxrpYrJEk310RXXvh3wjdVCXuPKqzWKpGP7wIct64E
 NYlc7crb/IU6MEW7hES6fxf6y+ezVBmcb6ERug8ZbjtttH3BG6GRgksp2IifcnmIXf84ypYMiAV
 1iMBkiuHq62npjw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

It is redundant since eglSwapBuffers() implicitly performs glFlush().

Message-ID: <20260913-flush-v1-1-229efa3f1e53@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/gtk-egl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index d595916476d9..0eec06826bdd 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -104,7 +104,6 @@ void gd_egl_draw(VirtualConsole *vc)
                         surface_width(vc->gfx.ds),
                         surface_height(vc->gfx.ds));
 
-        glFlush();
 #ifdef CONFIG_GBM
         if (dmabuf) {
             gd_gl_wait_sync(vc, sync);
@@ -122,8 +121,6 @@ void gd_egl_draw(VirtualConsole *vc)
         gd_update_scale(vc, ww, wh,
                         surface_width(vc->gfx.ds),
                         surface_height(vc->gfx.ds));
-
-        glFlush();
     }
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


