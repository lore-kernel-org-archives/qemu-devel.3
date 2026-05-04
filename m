Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C395FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrcl-00039M-V5; Mon, 04 May 2026 07:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcY-0002Dh-Na
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcV-00016G-6l
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gVFopIo4aSSG9uooap2o+5uLHAWlxkdOp59XKcHx7rk=;
 b=HZif3JeQ1zs3KM8uNLb0JrV3QX47kvc4Q0j9fQco3nbXduwx8DqEX+tYaHMeNKkGixxRyT
 ADLBjudCvyIeM+QeZ5pCv4B6PYnlRBuzkKzWyG9pi8yP8MVdy4546d3Tdcd1h3sAKMuMVn
 ghrU/ltKNaaGKK+/QZjvMIKz67bHEq4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-HogCm4hkNRioY7Qz0HDcsQ-1; Mon,
 04 May 2026 07:37:44 -0400
X-MC-Unique: HogCm4hkNRioY7Qz0HDcsQ-1
X-Mimecast-MFC-AGG-ID: HogCm4hkNRioY7Qz0HDcsQ_1777894663
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BD5118004AD; Mon,  4 May 2026 11:37:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9843B180045E; Mon,  4 May 2026 11:37:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:14 +0400
Subject: [PATCH v2 26/46] net/can: free ifname on socketcan finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-26-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavel Pisa <pisa@fel.cvut.cz>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Zz6LxsmODDv3AxwQF3PTITI8cMLmWmAnaqtuQzNPavQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtP/pxDCUA7gzmwBBgDaAXf2tPzWjir9CVN
 mhXb5fLtfGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5aqZEACoc+x0pzK3+Ha3fErGfb03Im66Oig27xFf5Y6akdleok27fjDwFwSky5yfDpTvsXt8mmC
 LuwdwRs0mRqKovcPX7P/if68pxukbBPcx8GiRGoS6kryKapjh4ntRrn2D6r4Oe5AIsaPXpQgOk/
 b6V0LcCIPLv2E4O9pllHl96NGtxoGitiiKajVpTllqAMB7suMMa/vBnnHY/V+THQP/o9hbWR7sA
 0AvBKfVKIJT1Wsb+I29yojnRR3aVDpdVLRorBGPF9+Q+aXiG3FBBaYweXyrF2R4iX0CXQptxlsn
 cBzY0aW0O5Q6SHbo70sdAoZij+irCqKNOKzWnOB1/RuECQNoXkYwBHaCHkden7+3k3xEOO2FKVD
 a/yaOTXRzlrRKfQLv1WgTVGPJVntBQ/zaS5PHQDcyTrc1HS16/uz8bt3Mx+H/LQX3evvGrhncdz
 YFTSqUx88oKDJFT0ZH3jXd5jDy5F6DS/hx8FUax0n+wZWQFLkMMAZ3+1kHLMFDDBXpp/0FzcAHH
 vYREhtL9SMqGVoLoEb73SH0e0hBChy1ChkZnYvFPUXlPW85J2Pugo2fkcNVEOuP0tlq716kzvQE
 3Soa/KvrD9oggdpX9Y6MSSOxmSdinqSXRxCkB88L8bh/DMmeDrUKF7HpqfkgCKNeykjQhAXZ5N9
 onDFho4D8ihSSAA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

can_host_socketcan_set_if allocates ifname via g_strdup, but no
instance_finalize existed to free it.

Fixes: ea15ea8a7c67 ("net/can: support for connecting to Linux host SocketCAN interface.")
Acked-by: Pavel Pisa <pisa@fel.cvut.cz>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/can/can_socketcan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
index 8a57ae07178..be67ed7f5a9 100644
--- a/net/can/can_socketcan.c
+++ b/net/can/can_socketcan.c
@@ -319,11 +319,19 @@ static void can_host_socketcan_class_init(ObjectClass *klass,
     chc->disconnect = can_host_socketcan_disconnect;
 }
 
+static void can_host_socketcan_finalize(Object *obj)
+{
+    CanHostSocketCAN *c = CAN_HOST_SOCKETCAN(obj);
+
+    g_free(c->ifname);
+}
+
 static const TypeInfo can_host_socketcan_info = {
     .parent = TYPE_CAN_HOST,
     .name = TYPE_CAN_HOST_SOCKETCAN,
     .instance_size = sizeof(CanHostSocketCAN),
     .instance_init = can_host_socketcan_instance_init,
+    .instance_finalize = can_host_socketcan_finalize,
     .class_init = can_host_socketcan_class_init,
 };
 

-- 
2.54.0


