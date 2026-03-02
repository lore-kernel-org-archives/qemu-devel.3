Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBB4E9B357
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0PK-0007si-6I; Mon, 02 Mar 2026 05:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0OO-00077M-RX
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:50 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0OK-0007TC-Um
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446817; x=1773051617; i=lukasstraub2@web.de;
 bh=lcGEXTcmjSwo1uIOCMzYBcGqppfFNt21+FB9vZyidNs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ozaaGK9myaStShu24GbEZVTCvxdo0QBG/MHCJ5bJyfGrNMC4BW7TXKlK48naWeMR
 ChTRYItvCB4j3Iymy7mo6Tp9SLwDh26c9mTCR+YTqm5XpZMrTYyVsZnuCN04Tn+Bv
 dBQGfExBJh/6dDMZ3h+xcU8Zu8Ns34kkS3GdvvHsfp+GG3RPX6QljECkinqJ7uRPQ
 UhCIm77SgOo7T/drVcJYMB78ffUVe7JtQjfiRK7cvPyxqrXW5lDyHl6bFeYRYuLtK
 l4nj7rt/1j68HZbawkIxSm+Gu7JetRqa/q02ljCb4vdwWI8h8lAo8/j2l5lRn8qNh
 x9BB3SmScP3UpjC1xw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrfou-1vIQMv1A2O-00aKwd; Mon, 02
 Mar 2026 11:20:17 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 19/21] colo: Use file lock in primary_vm_do_failover()
Date: Mon,  2 Mar 2026 11:20:01 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-19-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=REq8s1GLond4/LcE4TppwatMZ1netju7z89n3hnA2Mc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQpg37n/xJ8kZPXbZqbSssw3S/IhiERc319y
 /WcoK89kgOJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKQAKCRA1qwsonF2y
 WNPdD/0ebxvcf868kYKkiJFd/ex0fkQ6ypBx7pom6ye1o27x7VT/+xUmy4ATcQU96TuNvwZPV9g
 gnk6/awF4//dNgSn5ZMmpyXcg+KCaEgD1h+yZJNQxqsHd4WcwZy6JgsmRzsqO6naiwNz3ftFUfp
 LMeq/o5g5uVCr96wwh+/CqEW1mWIf6uOaMjmBqQzomIu6FV0iIbdEmZ8UOOu9v9X5MMyBzIblKJ
 Av1vQojZw4lmyrCNTs7swDj/Be2x3ycnhFMm07EBIbdt2yrvCX6Y/7fWkZdE5ecm+twIZbIwKFf
 ulbZWyUC/xf+G9U/vljjpvCMU7NY5VaTTrWjcHi/J5A6rhVQbs2ejh3X83kMJxvqXHuTPc6Hw0p
 tEgxOUq3EyVekbRpNpngEqR6HY571XZ/4oZR2uIy3gAepNkvDC56t58CrUZSwQ69UE5n1v56xNx
 wOy84HSlLC4zxoS0x8VtceY20LRTSNxG/BmCdSUWSuLFuqRmHOHgbyLyStr607Zdk4IWc2dUidh
 T46KxBLRbSXoYRHoyugIZINGN3lCs8wVhTvrnqmyoglqNpu81wIkRnTzkQPnV0eyCciP6GLI/Kx
 4DN5Cuo81pLKE05L8+rq2dh+zAl9iCegwEE1Xrx53BMog+BJI7cYar+Qcg4eEhkWf7mWxRhBdj6
 8I5OuXFXtcfuaBA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lGgii7dR5ZU4V80yuXQzKwyjigFcqBUoPRytJzJgPteS0j44F4Z
 p9LZUGaR7QfDIcDm5RTEJytT+BADqUKzT9TVfHLtNMgzMfcGuQVkpW1p7j69vJCnygXs6nN
 ZjLAcKpA6CpvaCbh1au4HC5b8TNaMQX3HfEJJBi75qnqFYlTHklEZXarTJ4SyVJxOgqgIpS
 UkJcBjWGVg65puzLPSxbQ==
UI-OutboundReport: notjunk:1;M01:P0:pfnbOhTxB0A=;yVoiwlexcs0t1uy3yPXcmvMDgJ5
 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
 QxRjfpYQcMVCGfgApUAVjOFdQrgve5r1vQZqko
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Take the file lock since s->to_dst_file and s->rp_state.from_dst_file
may be changed in the migration thread.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index ce02c71d8857d470be434bdf3a9cacad3baab0d5..dc47d03874039b686d2a4072ac=
4e6c77e4ff1f87 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -173,11 +173,13 @@ static void primary_vm_do_failover(void)
      * The s->rp_state.from_dst_file and s->to_dst_file may use the
      * same fd, but we still shutdown the fd for twice, it is harmless.
      */
-    if (s->to_dst_file) {
-        qemu_file_shutdown(s->to_dst_file);
-    }
-    if (s->rp_state.from_dst_file) {
-        qemu_file_shutdown(s->rp_state.from_dst_file);
+    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
+        if (s->to_dst_file) {
+            qemu_file_shutdown(s->to_dst_file);
+        }
+        if (s->rp_state.from_dst_file) {
+            qemu_file_shutdown(s->rp_state.from_dst_file);
+        }
     }
=20
     old_state =3D failover_set_state(FAILOVER_STATUS_ACTIVE,

=2D-=20
2.39.5


