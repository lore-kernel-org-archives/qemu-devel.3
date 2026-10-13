Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB036CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXH-0004kl-9g; Tue, 13 Oct 2026 09:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVP-0002zc-4L
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVN-0004ow-Hr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pq+XtLlTbGEFXSd96d4bvBrBI9X2kb2f2OC6Qq5ljW4=;
 b=crbwBMiGjRqLKt+nZfRABOjSt8YOuRreY7gUA7+Xl5CWAaPPlzmbHchg7TZJ68cX+vRc3n
 WTHL2Xg61AZVQZYS2pGNzF6u1vovxGgZaEnB8fioLGsM/e8GbrGBEQz9Vu496wMhhNuQ5L
 phMzEs+biGXehFaL7HApDyYPQvJW6+8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-4_vX4Pg_MeqMoGQVzuaimA-1; Tue,
 13 Oct 2026 13:25:12 +0000
X-MC-Unique: 4_vX4Pg_MeqMoGQVzuaimA-1
X-Mimecast-MFC-AGG-ID: 4_vX4Pg_MeqMoGQVzuaimA_1791897909
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2755197702B; Tue, 13 Oct 2026 13:25:07 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C49E530000E6; Tue, 13 Oct 2026 13:25:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:26 +0400
Subject: [GIT PULL 29/40] audio/wavcapture: prevent freq overflow and
 corrupted WAV header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-29-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=902;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DJRoYYsnfdOyjGlCjfxv4dkJTB2abH/QKaHe/wywQ9U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDECxoy1sPo9FNwNjgUO8DKSXD/W5Il8e1C+
 +9+DwUhqByJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wxAAKCRDa6OEJdZac
 5ZDgD/9b0VKrTfNtepaybg+KXRE9wcTY8rq6Le9PX/EBY0hV1fuXRH7BO7OFMmLeQ8xFrmiID3+
 eg5LAjqKiy6rF6Ow8I2oHeoDXPgzoU/VwJL/+Xb4NTZqCgfycNnY3NEzBv1ER9bc6LC9shBfqFS
 9WgCMVeJt+iKIQijhSwZ/V4ul+E7eI5qFRhFgbhdrbk4IfChfQhuWFE+CdP+hCWlF/7IBR3Ct0D
 TSWaZXfKlQrtPt2fkkcXVCICtIu7cNd2ntp4L4+tNJ50BeUeBsYTkdZmCqPOe+XCBHfUW+e4+P6
 Ub4px874OrEtBuh4iiKOkhfJ6Ls9GfY0uTmuMivWSUHC9zF0lVKFVq11KR9BaExqintANn8rHH5
 QqKpYkupD37IUO7w/nH86uLlMzTkzfoXEIgkyFFGPOWeM0HaZoseYeHuCYQUxLx+IyUgYxV20/C
 0Qv4bwKGFP1Jmwgj7XZQg2HML9zu4P62b9nod+uu+W1LmSjMCn0/quIhnLngr8bf8+BQcny6bOV
 VfS1qdJlUiC5eb5psZNWWWTFp039U7RlknwVoWC5lrr9v0TjJDxbP5rDBpzG7Gh/8bGZHGpvoUz
 HHIxmw4qtr8n7gJA4SHjbZripgRbPV8lWjWNuCedYY5kjs69oEnPIy63S64Sf0FHwZjSnPMx6o6
 GH0ls89V2TTrasw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reject freq <= 0 in wav_start_capture() early, before it is used to
compute the WAV header fields.

Reported-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-12-ccbef537cbeb@redhat.com>
---
 audio/wavcapture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index 2dac94617104..67bac380ac7d 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -131,6 +131,12 @@ int wav_start_capture(AudioBackend *state, CaptureState *s, const char *path,
         return -1;
     }
 
+    if (freq <= 0 || freq > 384000) {
+        error_report("invalid frequency %d, must be between 1 and 384000",
+                     freq);
+        return -1;
+    }
+
     stereo = nchannels == 2;
     bits16 = bits == 16;
 

-- 
2.56.0.116.g6de20f6092dc


