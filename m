Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD71E9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0OY-00078h-7g; Mon, 02 Mar 2026 05:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nz-0006aL-W5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:24 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nw-0007J8-CQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446814; x=1773051614; i=lukasstraub2@web.de;
 bh=q/mNNwnaGGa47jBNu/l/VsNCmpfLA9HBEoNXzcytdkc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=q0EQLhAyg78UZnTkn0L/Fe/i9T7Z3yd5DtMXzlE2YxNOKPAxS6zQWVeavrTz1JxL
 YCOCtXVZ1ZyMbIFMqltyQ6lzm/0oNVl3CCfhxWBBMIHmza0QrQOxSpqDjAMsCH3IY
 5nnPK/hyVFHr99qP+FXQYvNfOMFV/M7948nW40RDbhLoHC+nlg9ZoGYgt7y7tyMpR
 4uejLMuFFTtAi4EEwPF5EnX758hEmvIY5cdZzrkEVEyis3/TIDs21ehyFW9D2+Owd
 oxMlulYc2+M04iGp/2wmuKAkijkMv1imlWsiBrWzTyujWtLH/m/MY6zjQ1i+FomjP
 1WkikMZzOdUN0xcJQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtPvm-1vh8Do0VUE-012nMQ; Mon, 02
 Mar 2026 11:20:14 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 10/21] colo: Fix crash during device vmstate load
Date: Mon,  2 Mar 2026 11:19:52 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-10-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Jo9ygbD9kqkeUyQ0JD+anPkAvVD/vEUQ7S+iY6iqDJE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQpEUjBhGCnJtgscf1f1LPqK71terN6y2LNW
 FZmL0NKEv6JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKQAKCRA1qwsonF2y
 WMc4D/4j+k1w5T5EgaPvWQ2rkb+RFXS6jMDnc02Z+GxnIeo2PVRmLtUcm/bvrBVSKnFV8p9jTAf
 fs847pmM3E0rx1WviF6GvBbiynrUYRa6/vZKa8zkxxMzPgTD5FfrydYjpvDZLiNQr/V0ffKJobj
 AT7+hWNwLx+Z8cXANkBpcZOK08rOuidJG75nEoA6DHZCBcOk9+H/2ptPCLbUO0z13cQXewE055A
 uSQLk58OQN0hdAtUR9FHpTThaE0K9bq+gdJFknoig3AcRH2RbWSlSaxy6Zm/FAS6F30bGP2k5Tg
 gq3XvuBwhktWTfzJ6By89fhId6oLnbwK34q8FfveRJ9lwDEjAeUHhC1u/JcyWaX9Y6SusXNIvT5
 Cgfgly2LyFseeIUZtA1KW1Y+5T3YT2iE/3XpNc9mFXCibmIb6BfU8SxYEbje+KLz+Vv4krVqmLP
 a1A9npygnkI2l51oN9dIJKB1MQvhzdshQazHdTsneajbJFw/fs8TVPdahNhUbPy7aCQMENViwVe
 +Na83XMvBz/Yq2OMkjmVlw0ireqfEf2DxhOijS+zC1Ga9cy071WF0rGP6QL6rZ3PP/xbE89Eos+
 InhsD0z2+pdvPRTFAWI3YUfS5XdNtQOd/0aigwK16/YPHn378XaXOQXBhSJFfvEf736ke0Hifqg
 3P+PCu0xSU8VyAg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TZLgi0RghSfoXiXw3VXbIDly311C1IURdioFc0hwlaXjdOaZgxu
 UTgpd0hXb1mYMoKa+dPznZ/wEdlTFgDLk2/MwyQ/Fnfph5ezlNTbK2Q4LlwQcaWO4OtHetW
 u4//7FXV3X4RiCMpbZ1cEf08yrw5R0gsqzTxBV2e7OKiBBBz2hS33D/6nHWWR/hiAqc14D5
 LFytS7E3e7mJTpL3bSDfA==
UI-OutboundReport: notjunk:1;M01:P0:BQu1GUMRnTw=;Zcp8OOGm/AQH5TPMQ4mw/x5XZ7s
 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
 7LjwSYlM=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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

With colo we load device vmstate during each checkpoint, on top of
a vm that was already running. Some devices expect a reset before
loading vmstate on such a previously running vm.

This fixes a crash when using COLO with Q35 machine.

The reset adds 10-20ms overhead to the checkpointing proces in my
testing.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 96102c9d0fb3b60e063c81ce07b730011bc4919f..dc7cfa81ef7db78e3ee372642d=
e48567c5bc06eb 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -729,6 +729,12 @@ static void colo_incoming_process_checkpoint(Migratio=
nIncomingState *mis,
=20
     bql_lock();
     vmstate_loading =3D true;
+    /*
+     * With colo we load device vmstate during each checkpoint, on top of
+     * a vm that was already running. Some devices expect a reset before
+     * loading vmstate on such a previously running vm.
+     */
+    qemu_system_reset(SHUTDOWN_CAUSE_SNAPSHOT_LOAD);
     colo_flush_ram_cache();
     ret =3D qemu_load_device_state(fb, errp);
     if (ret < 0) {

=2D-=20
2.39.5


