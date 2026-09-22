Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B1FC98308
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9763-0007GM-WA; Tue, 22 Sep 2026 16:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972W-0001cm-Gf
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972U-0000cU-Nj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7QnVogbhUbKdgZBYIdVlAq+P5/ZtfauAADlehJVHlos=;
 b=hTM3cEQml95rvynyQ1U1eDMfuKq9OfwMKFhSkB8rBflXOqdEvdrtA5+JGsgm7WSF5fQRWx
 C43jml+lmjNKO4i6Rw5N/gy4SNFMQ5R+wMGKjWYOHsm7/Dmfdf5oBy0bdVeVRVz9MoT25C
 yug05C/JmHIRTFH2j1eIRReT8MdyOoA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-inAEdBCRNCusul06X7p7nw-1; Tue,
 22 Sep 2026 16:24:28 -0400
X-MC-Unique: inAEdBCRNCusul06X7p7nw-1
X-Mimecast-MFC-AGG-ID: inAEdBCRNCusul06X7p7nw_1790108667
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35D73180062D; Tue, 22 Sep 2026 20:24:27 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4643E3000223; Tue, 22 Sep 2026 20:24:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:35 +0400
Subject: [PATCH 88/88] block/monitor: redirect HMP qemu-io to HMP stream
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-88-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=852;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uV7/bbEQoJq2iAPaDJgtHcGaWRlRRLOYr9IFh9xCnKo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuK0NtPldp9EwcV5HDIK9XGYM4eXuphytHemu
 UsN2qRQ6KmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLitAAKCRDa6OEJdZac
 5YdYEACgL8eKPeJ/lfwSf+lqCOcHoPXeQaGEmjwafPJrI/5qxVS6Al6W8JsyKeJt46hJRVRK7KJ
 hdxDIN6wqQOowKPPBSsXe4ETqEi9s6Onr8AGDHxndBIpVQUQCBvEGSL6Vu3zy/aMGWYYsBPasBS
 9cEzkjB7ll2A2xe33+K9GvGuEf7veCVSUXkSSVptCWTZCH1DYyz3oiehDc4jhI9HvR93tSfYa5Y
 MTX6eMtEEt807RPu326OmrJBXmo3mLy+SnUCa+a8KmVMomQEWuXoWPX/DcbSyqmtUNx4DY6l/YS
 NSetMa7PECpkroGqY+nQX8QQsN4rweoxMhUlJkyjB9+oQnWkEUT7W0bSkkCbN+9zH2IWLBoEGZF
 +oJbT3m1YTotAzF+ifvTpFTguPSCMuazj9Sx4APbgTW8TSfvlGEV2mcii+gq0uii5ID45SQQ0gX
 UWX1ug9PYu3cpQs6NQpfOYclCyYNLHK3capVF3fvlWLCoXy56JVXDGdUq2qWfWP7ftc3/LWWH1R
 4YtmqLAHjGuj5obWKFYGIBP/mACy+qa0r7x7YRfaDJ0rN5i8iBsRspNtDshiiI1G1aOHA6Rqyxo
 O5pRMupbCOAzkR1nQRh7HuFmkQBbmjLx+qV/UD7KbaLeukXHAzw/nkDlAzXSGVzRWTUqmL3zi6H
 IJhc2iOQIgOV9bg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that all tests have been converted to rely on QMP stream result, we
can also redirect HMP output.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index ed071c0f4144..b1a1b4bae127 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -553,8 +553,7 @@ void hmp_qemu_io(MonitorHMP *hmp, const QDict *qdict)
         return;
     }
 
-    /* use stdout and not monitor_puts() for compatiblity reasons */
-    printf("%s", out->human_readable_text);
+    monitor_puts(MONITOR(hmp), out->human_readable_text);
 }
 
 static void print_block_info(MonitorHMP *hmp, BlockInfo *info,

-- 
2.56.0.rc0.29.g47ce80527c56


