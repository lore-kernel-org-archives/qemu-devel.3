Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8660F3381A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Q99-0005hT-G5; Tue, 17 Mar 2026 04:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q8o-0005Xa-GR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q8l-0002fn-KO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyWuFR66FdcxTDSAYxstFIq6Xs0/vGMx54Hcusmh2ak=;
 b=YCWZlKljThvTETemHN3+BRFfVojQ3zm2hbqDZ11BHnc+D6hAbaURRRSXw5kd0X5FQcUn+V
 dZHjv3huruHUVw7KwEnP9ZY2CU+0sCZJwgxtjjDVocOjW/fNIPAxDLO0E4b7nTXn78dyP5
 wnVwyOY6p2wDOk2RPT2PMwz/YQ2w7Co=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-ncDgKbgcO86X6wrLXs9ZFg-1; Tue,
 17 Mar 2026 04:51:00 -0400
X-MC-Unique: ncDgKbgcO86X6wrLXs9ZFg-1
X-Mimecast-MFC-AGG-ID: ncDgKbgcO86X6wrLXs9ZFg_1773737459
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 918A6195609E
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:50:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 847F2180075E
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:50:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:17 +0400
Subject: [PATCH 03/60] ui/vnc-jobs: remove needless buffer_reset() before end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-3-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=592;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xRixSj8RZS1G5LmAMuX1LV8L9/rZyOWsE0ndlrOHExo=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGm5FdqjGseOH+Td505SITToILfsXUjYQAN/EIv/Afr4Hj0xH
 okCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJpuRXaAAoJENro4Ql1lpzljGIP/0me
 5PVNlKXeS5VuVDpbTMQtBxe3N+VbmAGRTZJo7x3LsEEIn4ZbtuRpP2wnoAOJyTjDnYjsVX4lkz2
 D3Pa2veMc5UpSW293jaImmdULHwWGGu8rjfoFvH6RNeG2wspt0pfPEaQsDA35ufx+XgMHaqksYu
 knG7J6izgW+99383bv0Ty1wI560GyUXt67W99cZGy1jZeegiY4mymH3Yj4AA6a0aocBF+/5RYJ4
 UZAUNhBAobcnpFJrw/rikgHhvNmP5mSP3ZP37YGw97NinmtgCKQD7oqv1/uxwFcXlqwISn5XAG0
 p5E8rokEJ8NoYofDiS3B3VbY4zWGT0ap/+3AyoOhRVFy9ySfxPe24JYj7AzCO5KUUctYQ1lynI1
 vdp+LXdxCmaxGDXHXBb3OpBPb8An2No5L6xoqq22J6z5BGDZ5hv1Fp7jgc5PqTJOlz7o9cShap2
 8Qjfi4uahkow73vTXNsIO3Fko+x6Q4dDMs078r8pLeuvvZmN14yJ84d+Csb9X/LvRqKw+MfAg6j
 hh7wMX3nmo+Z0jp30riFYaN58NxYlr0QMsVkobgBa8vK6DZOGu19FDO5/gqwhyevFiaPECjJGsW
 hletzcxOei4h52Y9uFuVMKoWOlb9eP02pebDhgmrrjlROVyOwceRqi/euGH1umgSOSgEi/bKM1Y
 bRaBx
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

vnc_async_encoding_end() does buffer_free() next.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index ec90ae6d5fc..a6ab733faa1 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -326,7 +326,6 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
 
         qemu_bh_schedule(job->vs->bh);
     }  else {
-        buffer_reset(&vs.output);
         /* Copy persistent encoding data */
         vnc_async_encoding_end(job->vs, &vs);
     }

-- 
2.53.0


