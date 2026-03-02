Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E0AE9B365
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1j4-0000fs-7k; Mon, 02 Mar 2026 06:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1ih-00009N-MD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:53 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1if-0006EZ-OG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451942; x=1773056742; i=lukasstraub2@web.de;
 bh=lcGEXTcmjSwo1uIOCMzYBcGqppfFNt21+FB9vZyidNs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=WhNG9+vrR5Rq62GlvsTvYcozPs/bo+q7VHKWZ0w5ukzyArwM9d/nAWsIbT9QMYig
 fiV8ifEKsTXtu4PzDvX80NWsR02d8VwyLlzguI5L+GSQcGDHiaZ1oLPkSbcp6044q
 0lDEmhy8iq5GgK0bS7F10cteIQpLKhyPrhLa2GuneOJW3KYbE6yHi8WKSweB2ONJU
 OKkywnk8NzNO6nJ0CYhArIeUErEIQFXoZEH1+/QKvzMEESYryFoP6Hg7NAuTJw8/d
 lYX6NYoct8dQQvId/VGzxVKeSXzKEAbngLRUL2OIXAbABAfw3VfrlSo/7PQR4vxA2
 P9KQD8fZ7PCNdflJNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59nK-1vvvms0004-005v8M; Mon, 02
 Mar 2026 12:45:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 19/21] colo: Use file lock in primary_vm_do_failover()
Date: Mon,  2 Mar 2026 12:45:34 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-19-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=REq8s1GLond4/LcE4TppwatMZ1netju7z89n3hnA2Mc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6UPR6KYAFCkgGs33nSeSHaK1bCGvu2p4x3i
 btdhY94edeJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVulAAKCRA1qwsonF2y
 WKxAEACfpTiR4IZjGQPhB/dXHOk7DOcprg9Y6JNVcIrybefSsmskcthY8VVqP1/360cuL1S0QbF
 zSh/LyvJqf5rY35p3T3U+0X4Qcr5blc+vd995kJXzoWvoATivgf9dZj/jdnELHLdnRM8hUPEP+z
 qi0b3ddl3hsonSu9cHXlVyjB9u8acDw30gJ+ypm2KOVese56UX2KIkpQLnfOyJMyOrqK0Jq+rGs
 O3b8BdERpRAYPolnlRCqkwQe/CCVvwfzrTyOPJe9ADnqFyk6gk+KD1EMKkbjoRPhFqKo8+BsMSH
 7qgZtEe6eWgfmGdTgIPllAJNPknhWm4sluSEPRpxBBeFubn+x0OUKBT4xoe+Q7gDXG1KL5T82Jm
 3nIeUfQQ48MhC+pB8GZiLbExk5x3oj0AEJNtk+iUs9V2Dbit0DpQMHd6AU7rpFr/MuWF8iVdQuV
 2dcObTpPaWtQMvQVdUJANEdaMwETcqjbd/RD9G6iUyKu6Nl3t0KMt2Nn8wQPBx151IWUIYvPg/P
 /4mWpdzSSq+NAqhfsde0ViTX5Eu3mn7xlv73mFisrgbj7chSF6LYNBW957KlT/ure+L95lqkKO3
 Aw1CL/SxaZcuHBsZDqSIsLEOwEzmToIhuwxnsKQV4f/rv9d5ICHx+hpHKT56XDXjVBrXCIOUyyn
 lHK1IWP9rItW7Ng==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IHfOAmMes8zA6VyoI3rOazCBFKj33ZqmM8bSorzp0ohW8bFZrwR
 2M7GjMBRIKQXQ5VypLROkJ78N9gm7AsmrCc97Yuu5c2icDSIeEyDMc/sFEe8zLJ19aQH1rY
 ZnE5LqBO8d+oN6DOmglyMQqlYFrrcK8J9sWUyiGDSTGdj6m41TiMtWCLCIJBv24qj8TpR8b
 AK1r4JWIZxVoya9lJvP0w==
UI-OutboundReport: notjunk:1;M01:P0:GG55q8yd8bs=;/enacubCTEJaDR3/3GwZR4I5RJt
 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
 9/8pAU7vN9Cs8akfwf/ZokfHi1o+vYnru3SSG6
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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


