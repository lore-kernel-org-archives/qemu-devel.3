Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A1DC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WwB-0007hz-99; Mon, 07 Sep 2026 06:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Ww2-0007bR-QO
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Ww1-00081A-CX
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yIsDQ7SF4Y5V/f7VhC/dfF80nAzeJReiUN4a4Q0MiRU=;
 b=OoqAwDEIDbkOdO0pLQ0riQX0pYvaqPubYL9DFyDbEe5Me6P7F+1GJWSKLdX/2y6zrX/y01
 57hjGYZFar2TLaWtXFVu2ju9S/K/pmK64aRsQkpy9jSPTqwqp3AB9jV9uuJ2xnro5HYRVy
 J8rNG2DqWy3HmJAecHkiDlMepfbyCL4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-0IyGKdFZMXupR1ZI3IPoLw-1; Mon,
 07 Sep 2026 06:50:41 -0400
X-MC-Unique: 0IyGKdFZMXupR1ZI3IPoLw-1
X-Mimecast-MFC-AGG-ID: 0IyGKdFZMXupR1ZI3IPoLw_1788778240
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E9911944B3D; Mon,  7 Sep 2026 10:50:40 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65FF5427; Mon,  7 Sep 2026 10:50:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:07 +0400
Subject: [PATCH 09/17] qga/vss-win32: use GetLastError() after
 FindFirstVolumeW failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-9-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LzkJ1faH8qS1b7Va7YhYWJzWvojAW35layjF1nwooOg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbjZR5JjNXdbELL6MgPCE7oq1V1xOtaG5xS2
 NQDFAoVQMqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5UNND/48jmkjO4iDiCjQu+kJDzDndPvrPjr5jBmqkaFJoORf4AEHGAhR6MuwWW/+jmmXmJ50uKc
 71p+uylRXKweYPIc93dA3f5kewCChz1Hlk7ce5/dml4r9c7M1owpAzaxhRb9+QcGW2XJ+UHQwGF
 oOaDC/s6xwU8dvKgWi1xEXd1TDgY8xGLqu2+8Cc1/hE205hbIxxNrMpstw2AeSR8QRVMnscp8OR
 A0uXTT9Ykc3EWdROfHyl6jEP+pHNKvkUKJh/TIjyPad+ZQgigqJYJ8/r/W24mowu8YecSN7egiH
 RXf/6lmjBkDn6/SCrNT0qo0rN8sGgrwQz1NF/KszXF8BnnhtqDntwkoHMOKrgbL9v9DrC+lOTUI
 8lnDuyUfzNSaPE5HHxlC2Zh3PBjXi6iie++VFeWc5vcqNG0ErM0Ay4/Kgc7oCLtB+svshYwodpm
 C1uFQHeU1BPwpQS5cZ8GdzR9PlBg0B1Lt6h/RlQFSsNZJTcL6YRkyFJKA1gVNpfiimG0faYOd6E
 nXYRVZTXALx3SZPEh2drwsVUsm2Zh+RruUFW528Ju/kCJIs+rTP9nKmcss4cHX7n/pe3cHYV8PI
 +FcY3ZZuBc/Xvo2ZAC5R2XvQ2iXEGdEG1ltfRtsopaWXtDh0GsRYvDR3SMAM6cMfI2C/8isCltd
 cLxYNbWxW7tD47w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When FindFirstVolumeW fails, the error was reported using a stale
HRESULT from a prior SetContext call instead of the actual Windows
error. Use GetLastError() to report the correct failure reason.

Fixes: 0692b03ee135 ("qga-win: add support for qmp_guest_fsfreeze_freeze_list")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/requester.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 1fd73312bab2..d7907c230656 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -434,7 +434,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
     if (!mountpoints) {
         volume = FindFirstVolumeW(short_volume_name, ARRAYSIZE(short_volume_name));
         if (volume == INVALID_HANDLE_VALUE) {
-            err_set(errset, hr, "failed to find first volume");
+            err_set(errset, GetLastError(), "failed to find first volume");
             goto out;
         }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


