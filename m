Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05EAC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1R8J-0002dQ-CT; Tue, 01 Sep 2026 12:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1R8I-0002dA-Au
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1R8G-0004H2-OH
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788279284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WySw+qD1EXnv/Halwn9LSs8Ht6hRcdx69kEf/h1Wz9w=;
 b=ZENiyA5J9D1jnoPxllcFmBvUcP2tJa18VU87vOVyHmihHtKvKJP+flx5u2x016DdqxGbyI
 gPHmHmGBEj8Wyy2JIawD9UPOFr5ozynXSRxtDdoK1yadUu7JFe/haIenS4ZTwvluU6a2YK
 aAyealRDkhkcm8pTYGMpriiNL7n04bY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-YQdHAMpbOVC5WN2fxSMKdA-1; Tue, 01 Sept 2026 12:14:42 -0400
X-MC-Unique: YQdHAMpbOVC5WN2fxSMKdA-1
X-Mimecast-MFC-AGG-ID: YQdHAMpbOVC5WN2fxSMKdA_1788279281
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4955fd77c18so27905755e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788279281; x=1788884081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WySw+qD1EXnv/Halwn9LSs8Ht6hRcdx69kEf/h1Wz9w=;
 b=nuff5myxDS3+ZopAg7knbZ8KIt6cCc8+MVqrI5BhIyW4mCdNFNltIrpMSmLqPJQmAW
 RrSULGuOTZuCfD6sYhT9MgnF5Ggr4xk9R2Qu4AZT/1/oXWDj7m4l0UvLi5zbTc/7NS7O
 wL7xsVI2sSc/sxlNiT0j399R155mpvlqM3MDC5zg3Fov6VLDUJ0F8bTidfAVQHq+XMm6
 +MQIZW2mvA/4+ZdWx/Nsm/V0uNDP/BjhL3LbIlq2xpFpXeNY0Kq1jABz097DHW8M/DnL
 a46a33jIzADKgXUJzwebNp/j3zM9IVCRbj9U/rQLBX8H2ykCLtrRBfjD9kKCpY7G9TXF
 KhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788279281; x=1788884081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WySw+qD1EXnv/Halwn9LSs8Ht6hRcdx69kEf/h1Wz9w=;
 b=YQHsLOHd2ofXz721jCOXTrxOZDe1SDCVaNTou6K4OHYpCSBgghX1Md5IcKsauMnUpt
 SC/6Q589/rJPIOksSs7mZW/MgMUsydHllrn1S+7vTFOg4uYqMqsgZMnM00/vETtV8u/z
 LisR6GqdH0VR2pW2eEmPyk3FL4JJ0XxgVjjs65vP1329S4RppxzwuWme5BieT0p+vP86
 9eCK7hFMtKbbaq19VMg205VOnGlcmv84oXQQ4BIL3U688I9kyBklLWtmWYrzPFBZA3pq
 7xB5153A6Jc/npcpfN02k13VopVfGuapvU/7BJ524bX+O8vjnwlZWl+jgCql3LyNbQJ+
 EvbA==
X-Gm-Message-State: AFuF++ntl5pPz2uSyxgC+ykZStrfgtL7AJkr5BcqSv04n4MfqAXHksB5
 BLmQ1dcDajx8UMDuK/auebO2P/sNOqOd54gyyJj396goujG9tiTrlMl6Kh2k8VpHw96ZsJOrRrn
 gvBF/5AfxOv9YK7J2y0/5HjuL0pz7r94cQeeQArvS7UDfgh2KSA5iazvSup/CEB0CfZF1gvRdup
 qeBCUKECgxvswlD0gtgkrWMv6BVpxNIShnUlXQyDYx
X-Gm-Gg: AR+sD10RkItIGvOe2G74s3VJrAsNXPgXkOVXnFU3PplQH84UXFG9+Z8myZOrIqetoJM
 iO3gunxt3Ha8VVPHCddqHdmDm5HIOPLXsETew7CABqHAqz1QfFkwk9c/XWhzz0FdRoMkAAiY4f1
 vml7pha6KVX0UHBG6/V1/fWVtHq96Xuo34W+1UAFymDp3zSx2V6ap7BGQpWRDgdI9FoWccyDz/H
 3g1I3mqEyvIcgklCNLSrSyMUa4QD/N9kYiyCjp0udkm6dTsosvj0qekfpZ3qwD8iiwmuWlfl5qS
 evjHMJWAyp0MOFBvA6bLwENjjfqXbHJKBzK4ZD4AQ1DcO1/c6FTXsRZgQrBkr/3f2q3PspDamFX
 ruc+x6xr6U1Z1doUToNXlOVL6G1MtVVYgRpUUjEHCTOaXp9Ah+O/ctieFW4ZHCqbHK9uJpC3PwP
 9yLZE=
X-Received: by 2002:a05:600c:138a:b0:49c:e3c3:5efd with SMTP id
 5b1f17b1804b1-49ce3c35f48mr19362865e9.9.1788279281359; 
 Tue, 01 Sep 2026 09:14:41 -0700 (PDT)
X-Received: by 2002:a05:600c:138a:b0:49c:e3c3:5efd with SMTP id
 5b1f17b1804b1-49ce3c35f48mr19361045e9.9.1788279280612; 
 Tue, 01 Sep 2026 09:14:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9267c369sm251233005e9.3.2026.09.01.09.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 09:14:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] AGENTS.md: make the human part of the design process
Date: Tue,  1 Sep 2026 18:14:21 +0200
Message-ID: <20260901161422.314581-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901161422.314581-1-pbonzini@redhat.com>
References: <20260901161422.314581-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

This came out of the experiment with the first version of the AGENTS.md
file, corresponding to the previous commit.  This addition improved the
behavior of the agent from the very beginning.  The very first answer to
the same prompt in fact was "I'll orient in the codebase first, then we
should talk about design choices before I write anything".

In fact, after thinking it pointed out from the start that this requires
pre-arrangement and asked two questions (how to represent the pressure and
temperature in the QOM properties, how much of the behavior to implement).
Even with a single data point it seems worth trying.

When asked to commit autonomously, the LLM also clarified that it
wouldn't add S-o-b trailers and that pre-arrangement was on me.
It included "Message written by an AI and to be rewritten by hand; not
for submission as is" in the commit message, a "handover notes"
section about design choices that were made without the user input,
and the umpteenth reminder that the work may only be posted if a
maintainer has agreed beforehand to review them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 AGENTS.md | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/AGENTS.md b/AGENTS.md
index 8fb96ebfc38..c3cb6978191 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -66,6 +66,22 @@ In order to protect the project's scarcest resource, which is review time:
 - You must **tell humans about these expectations** at handover.  Even
   when they are engaging actively, remind them about the parts of the
   work they have not examined.
+- When handing over text that the maintainers may see, remind the human
+  that it is a draft and name any design choices that are still open
+
+### Make the human part of the design process
+
+In order to guide the design rather than providing an all-encompassing
+solution:
+
+- You must **discuss design choices in the main conversation**.  Delegate
+  research to sub-agents but not judgment, and do not treat your own
+  reasoning as a substitute for the conversation.
+- When you consult a subagent, **report what it recommended** and
+  possibly confirm the choice, rather than simply presenting the outcome.
+- Reinstate as visible text any design decision made while thinking.
+  Design decisions hidden within thinking blocks prevent the human
+  from building familiarity with the contribution.
 
 ### AI usage must be disclosed and/or pre-arranged
 
-- 
2.55.0


