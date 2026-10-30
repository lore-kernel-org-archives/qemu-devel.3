Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A1606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=x6z.top header.i=@x6z.top header.a=rsa-sha256 header.s=lark2301040359 header.b=GHY0aDaJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnwY-0000ZZ-FJ; Fri, 30 Oct 2026 10:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMnrz-0006jP-6q
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:15 -0400
Received: from va-2-42.ptr.blmpb.com ([209.127.231.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMnrx-0005Uu-Cx
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2301040359; d=x6z.top; t=1793371565; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cEWfKqB+aECplJFpivAkH1qEgfvRKPrQt1tvAVScsL0=;
 b=GHY0aDaJEoOEobYnR5AZbYEgJS2Ib94vXgG2358+lrtc8L0GQDtr+hjAz/JRr11LwHPRyR
 LEHfuHymVl0j1qvRxFDeF7BZvBo6cFR1m7UTsU4efh3LRm9GMy8HPDB3vtswgM6jogaBDV
 T4byss2gOKJ/itKwl9vTv5eHbUKl1FlhTr59JDv3LE0LQbbxOCuPmiyMO4guWnZrW/O9fv
 jqeak15LiVbg5TNxMsimkoBW/0UQ6IfN6SPOsWJvi1LqqhIf/BG7+uACthcHuGSol1I+zq
 nOmUHd7+hX9exUyPRuRHysThoUVUwoj0feUGOj/1yoGnjuZHjgi008mylIDaPQ==
To: <qemu-devel@nongnu.org>
Cc: "lbyxiaolizi" <lbyxiaolizi@x6z.top>, "Gerd Hoffmann" <kraxel@redhat.com>
Message-Id: <e2d4f7c2bb173d18ed0428129bc9d028c07476a1.1793370600.git.lbyxiaolizi@x6z.top>
X-Lms-Return-Path: <lba+26ae4adac+4080a2+nongnu.org+lbyxiaolizi@x6z.top>
X-Mailer: git-send-email 2.56.0
X-Original-From: lbyxiaolizi <lbyxiaolizi@x6z.top>
Content-Type: text/plain; charset=UTF-8
From: "lbyxiaolizi" <lbyxiaolizi@x6z.top>
Date: Fri, 30 Oct 2026 22:45:41 +0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
In-Reply-To: <cover.1793370600.git.lbyxiaolizi@x6z.top>
References: <cover.1793370600.git.lbyxiaolizi@x6z.top>
Subject: [PATCH 3/9] hw/audio/hda-codec: mask stream and channel IDs in
 post_load
Content-Transfer-Encoding: 7bit
Received: from localhost.localdomain ([120.236.174.193]) by smtp.larksuite.com
 with ESMTPS; Fri, 30 Oct 2026 14:46:04 +0000
Received-SPF: pass client-ip=209.127.231.42; envelope-from=lbyxiaolizi@x6z.top;
 helo=va-2-42.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:50:50 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_SUSPICIOUS_NTLD,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AC_VERB_SET_CHANNEL_STREAMID masks st->stream and st->channel to 4 bits
(& 0x0f), and hda_audio_post_load() uses st->stream directly to index
a->running_real[st->output * 16 + st->stream].

vmstate_hda_audio_stream loads both fields as uint32_t. Mask them with
0x0f in a post_load callback on vmstate_hda_audio_stream before the
parent hda_audio_post_load() runs.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4774
Signed-off-by: lbyxiaolizi <lbyxiaolizi@x6z.top>
---
 hw/audio/hda-codec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 173fe56..f452bae 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -761,9 +761,19 @@ static const VMStateDescription vmstate_hda_audio_stream_buf = {
     }
 };
 
+static int hda_audio_stream_post_load(void *opaque, int version_id)
+{
+    HDAAudioStream *st = opaque;
+
+    st->stream &= 0x0f;
+    st->channel &= 0x0f;
+    return 0;
+}
+
 static const VMStateDescription vmstate_hda_audio_stream = {
     .name = "hda-audio-stream",
     .version_id = 1,
+    .post_load = hda_audio_stream_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(stream, HDAAudioStream),
         VMSTATE_UINT32(channel, HDAAudioStream),

