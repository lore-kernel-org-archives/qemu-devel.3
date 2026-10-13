Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4EDCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXL-0005Fc-Bu; Tue, 13 Oct 2026 09:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVd-0003J3-C3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVa-00050t-Ll
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKkOng6uSCS/S/dn9xXbwyo9++LscSGqRiylk1JivZc=;
 b=OO+Q+v64MwsRaOHdWiCSUCLn6Pzawk3bdsohx8cflAUShtQwQ5DA8fzLgrJlq/zBbgyoTn
 LhzvflcUyXk1T69X/gofDTevtrF2fOVIyGiiapbM6k5gpwWQWUVYxTAXSRCaO8JeQQoNCr
 iqhnCoU1WAQfTc84sMoYXQD1gqltk9E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-ZR5NLJ_gOw-BGkjxN2LLJQ-1; Tue,
 13 Oct 2026 13:25:29 +0000
X-MC-Unique: ZR5NLJ_gOw-BGkjxN2LLJQ-1
X-Mimecast-MFC-AGG-ID: ZR5NLJ_gOw-BGkjxN2LLJQ_1791897929
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F277A18558BB; Tue, 13 Oct 2026 13:25:28 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31B441955F73; Tue, 13 Oct 2026 13:25:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:32 +0400
Subject: [GIT PULL 35/40] ui/vnc-jobs: assert rect coordinates and
 dimensions in vnc_job_add_rect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-35-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=835;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ASlrPnVgDsYFSYGH8DuhlrTh1rG3IX+ZZwH/PTB1zz8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDEw5f6Af+T4ti83nq6U1RWm96macRTYgacO
 8sRtcem5fuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wxAAKCRDa6OEJdZac
 5aMTD/9X4hNBBHeLj+cUsmwiKyO9QjqJkpwT3nZY2mOO5kfQoBSajBWjYuTgJ8BoW5fwaCaCIfL
 0Nqpak9FJzz3VHcVoz75/EW7HWbSMarycBIHAZjcsDVu4muqlv9yKadSCOxqxY8o9NCdR0XegLV
 bGd0kKjYj8M2Dqz0v4gAd6HSi20FT9PiQkchCUjPESQjSBLzNwqX3d+qS1ysInDMykxSlaHpzI0
 ggnkB8zBLOg9cnBBDnqNGjPgFx7eKB1SBjPUTtkgf3bRXrEiv4cEW1LF+cEqW9s/HuZjoPF5Pps
 JJp5/RbWkmrlWOr6Xz2lByFitfNfBBF8VbadNYQXjVDC9MP33hLOTOYBu0MRfDEVjQB5WlwQ96c
 WrbYIAmV2LpzwG79Pgsv4vOmp3KATl7rJmgIblZ/TEJM34zj569KoD3Qhc8J58SQcLVG2Tr4L2t
 XA1XSY7KjF0tmAjzhrGXXc0AxRDGlqaQfs96UOMFHB34B5xWdB6EpUUeRIJUU9q0lNrIQ3GI+K7
 PWNqUHZu8p4qCeuiCf7XlcIajQKFufEHMqSxJ1mSWKfguB1FTK+fUq0ObGMMhWCNcdWGroybESK
 uhzsIbWyytqIwsuqv0cU3Ez7X8dNDVi05VxdbwupVk4Fsg20QuMNKZaXu+dJ8tGQR1I7ZEVBO3p
 dRTgqe3RAjGZYiQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

All callers guarantee non-negative coordinates and positive
dimensions. Add an assert to document the invariant that
vnc_worker_clamp_rect relies on.

Reported-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-18-ccbef537cbeb@redhat.com>
---
 ui/vnc-jobs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 90b68bf4cb98..81c4fa5dbdbb 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -87,6 +87,7 @@ int vnc_job_add_rect(VncJob *job, int x, int y, int w, int h)
 
     trace_vnc_job_add_rect(job->vs, job, x, y, w, h);
     assert(!QTAILQ_IN_USE(job, next));
+    assert(x >= 0 && y >= 0 && w > 0 && h > 0);
 
     entry->rect.x = x;
     entry->rect.y = y;

-- 
2.56.0.116.g6de20f6092dc


