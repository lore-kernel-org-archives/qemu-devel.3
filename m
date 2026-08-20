Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7581C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zb-0008FH-EF; Thu, 20 Aug 2026 12:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zZ-00085f-On
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zY-0005k0-3h
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=80v1QcfBEPNNdkHRB8tf/eG9Xs79pj54gkTWeLWtnks=;
 b=ZeNvntZmTwEnyp9H236lrAj+i0H0Xv3jqgQM9YCYT6Orj/IfhYzdfVJSYb3XMRwomOWm4E
 U5WVrV2t5Iexi3Fu+DWvHiaIohi5WRuJaVmY1Sfz2BTywplQH6ntJAdmOKxx424//3clxn
 yEUe1hLBosqBaZ32EuNL46f/gw1NhR4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-UPmqEKcLNfSjLWyPmCUEcw-1; Thu, 20 Aug 2026 12:51:45 -0400
X-MC-Unique: UPmqEKcLNfSjLWyPmCUEcw-1
X-Mimecast-MFC-AGG-ID: UPmqEKcLNfSjLWyPmCUEcw_1787244704
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47fe23b5acdso98396f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244704; x=1787849504; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=80v1QcfBEPNNdkHRB8tf/eG9Xs79pj54gkTWeLWtnks=;
 b=rBSe3JViBoqPOPpD29D+NQ3w0E+8ekI3358AGrDZzGl5jfUVGrqErT4TnvKfSgkf6I
 f2PMI5XytN8nr4C305Km27RNg4mYJS+twvgkJXJF+wlqTp099QdwZsnFsqylWmxllAfB
 zaEglbXnHckzOGNKdkuR5xToTBbyQ5c8cJ+Fw1JIK5XdUbu/Bv/8N9/7uKGV9H69EloF
 2FOjhLjou19KkF9DgXNt1TF6T07wyupep69F6AzzgtBMAG+Qx4IORbnf9cDKSHqzX5Jy
 E/oNB+fRXav79CizZo1Oc+0x97AMtX+6Bl2999c1VhpKhRS5yg4HJQZa+6QF3z4AiAoy
 YDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244704; x=1787849504;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=80v1QcfBEPNNdkHRB8tf/eG9Xs79pj54gkTWeLWtnks=;
 b=dEtR2YkssUmfEBUW85ef0cbeBD3iZ09FJzcFW+XEPwzDGR4/3PuIc0sgHrVyoiFEMv
 xiZfR5Y35phJD88Xon8yLnm+OSzn1sggctidI6JWy9NMS2BDndui6+5G2TYB5WiihntA
 KhshG0nlwD2QqdPZu7TUSJKR/nMH7xXpFdBGpblcvs4iaRJ5/17YGODQQ0Uxc/mOddgv
 c/J9DTX9XMEmOEOJNztZ8w9XlRM+KoitJjBU2ekKheRKynZJJ+C6W1aSm4nJh0eUoVJV
 4zUBUuzjUf7233TmSluN2aj40RAutLi4bw29NOiHCqT/tNw06GOVRBppBxq7j87gy9Pk
 vgPg==
X-Gm-Message-State: AOJu0YxEnUd+7J+Ed65u4GpV3xCH3nWH9IewX+ldckGosKHBcU0HY/MM
 47k114RZQEUgaqgYS7zVHwfaFig/oc0JLD3YdVVSfPdMQZCA/kZ9Menqsq4T08F178dxxF8iNcf
 xy28XmdUogPCQAbK/OZ3tMiUvRQ9C8h+jgBhvE6DKKYvjD5TX3Mia4Zo9uzX1ZC0lbdaLwurzHv
 O7lF9cVhsLRVAFGaTNRfQ7tZdi/5b2VPCX7NZSe5/2
X-Gm-Gg: AR+sD10sxE7yS3YL0sSuflh4WcPyFdBfV1Ez1xN+VHZA8lsqBu6Kaw8GaQB1D/TjiTX
 ybTGKMakvqJ4E9I1W4aWG+uXyW0tLzbD8YQ/kKBjsjljwspyFt7D/BrD2H0lB8T5lVAADllrJUc
 zyz4xWLkhBAglv8W1qJZqAsiLrw5+w9SWHy3EzKHHlbEosuIIw1GLuS/pdpMhiYuFj6R4151bYm
 tE1A8Efp81LIr/fb4138KMluD2AlEu7zX2rtqXLG9vceGp6hYE3nToA1n4MBAS03Pry0NGochW5
 rnXb0ZowXAInnYwYQw5xXRbT7MpYGxAOoyIptzKiALu4QD3ikTIRQ2WvXHPYrhMm842RNhMlzPT
 9tef1OOpRhejCiL0gaOGVVIIRZNJLbeCHf/PyVq/0oxp3AFSrNzlIyaXXEyCA4d0SpOK/ZfyoGP
 ll/2Y=
X-Received: by 2002:a05:600c:4e47:b0:499:60bf:c6f7 with SMTP id
 5b1f17b1804b1-499b8464503mr3532485e9.13.1787244703862; 
 Thu, 20 Aug 2026 09:51:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4e47:b0:499:60bf:c6f7 with SMTP id
 5b1f17b1804b1-499b8464503mr3531525e9.13.1787244703464; 
 Thu, 20 Aug 2026 09:51:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa11f832sm148644575e9.7.2026.08.20.09.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 37/53] serial: clear transmit retry callback on unrealize
Date: Thu, 20 Aug 2026 18:49:40 +0200
Message-ID: <20260820164957.1895963-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

The GSource is removed when resetting but remains active (and can
cause use-after-free) on hot-unplug.  Remove it before the character
device is disconnected.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4125

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 0729cd2ce9d..4339562ab00 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -936,6 +936,7 @@ static void serial_unrealize(DeviceState *dev)
 {
     SerialState *s = SERIAL(dev);
 
+    g_clear_handle_id(&s->watch_tag, g_source_remove);
     qemu_chr_fe_deinit(&s->chr, false);
 
     timer_free(s->modem_status_poll);
-- 
2.55.0


