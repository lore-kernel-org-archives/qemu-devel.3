Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17967C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x8h-0001h1-MV; Fri, 11 Sep 2026 05:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8U-0001Zi-GB
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8S-00080S-LE
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P/dt9G1EklZEpM1Y9s4cFZiMEKzuwD4r1pjdVZY4uXc=;
 b=IhxEFZ1jgherkgJZ6GWl1zmSXbmHfSLP3qfmdPBolkB6R3GJn2eeTpavhEoYFXfQEc4y6o
 KaEoPUmG5SAdcU/z/hbVfJ4eGj4ff7qojrUFAmcGXaOebdKX3Yp4rh9ZUExleqmzl+oRtL
 zLn4d6E6siKcEMpdu4GYwiQZ4Ssf4/o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-WWIlYM9-Nla8Y40IuBeVag-1; Fri, 11 Sep 2026 05:01:26 -0400
X-MC-Unique: WWIlYM9-Nla8Y40IuBeVag-1
X-Mimecast-MFC-AGG-ID: WWIlYM9-Nla8Y40IuBeVag_1789117285
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c293743f5cdso72308466b.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117285; x=1789722085; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P/dt9G1EklZEpM1Y9s4cFZiMEKzuwD4r1pjdVZY4uXc=;
 b=qq7Lmgyo/9N9jkZ5Nf/EHzJ77HEJlog6sDahICoiiMohNc19shwml7C+aFEaCgyYUY
 jwzx+Baxu7iHLxCPK9j9E6iHMKAuyxWt/FOoJofBU5tnU3ynVNytXfthYE3RSOO6iDvX
 EU96r5HqGILdeKlm0g+0iyj6Sl2UM2UM1PBAYfbf003ukS+4xlYrtKjceyb9vgacUmnc
 dSNSS1MLVwsCDzfyJ1yLracTNdx45cib009AFin0GnC3ORU9g3YJXwrhG3SUieERim/R
 Y+hSvbt2M3xKCms/f5Mv13DQWWuwvZ/VFxfSmPWrn1hdr0qLa6/A9WTbwdwH/476d5m/
 zJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117285; x=1789722085;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P/dt9G1EklZEpM1Y9s4cFZiMEKzuwD4r1pjdVZY4uXc=;
 b=fVFIYcPiAh6AoLzoNHoW342AqitVRLQXTVE4U5ZW/26SWqC0BTaCnjxgatDc8Bpk34
 rVcWio39XV8UISOAcE1b6l0NmXDtW6x9EYqPlANP+VEvgOJcv9CyLI43vK6CNlBxOZzs
 0YlMopjp4jpastbr/AMTHLfVCzdqrvqd+d39rLSMzv0hPsCg0xGynMGPdDwkaOqrrQBp
 KNB9koqUAmZjsblyjD2SkoK0Xlzii/P7Zk0WL1NO49mjuuVlJbOwR+PgS1p4tTYKDOeJ
 upMLE+VmfwQgGJwOishnypQTnnIkZ6DIMUDZI8hLjiZENUQgUVP6jgfevnxfVHfTMeYE
 cCDQ==
X-Gm-Message-State: AFuF++neiHpJuAbxhMtPh+pyVsmwmjPjJWefTET4TQFnZOsxD+fMv48z
 wH4XCa8MkSgHJwy/sULOVifQzZkx9if5E2nOgyHbIJkQjK8iPh1QIGUycfmW37E8watLPcyQ4F7
 b7y9J4eDYst++OQsimvOn662Jg41HhPhoFsCGBtrJcT6vRl6lVgV2vNPYMANimBXbvbMPsR2XNU
 PWIeHW4ibdk+kceVWxEZvB7deBMZzv1doNgA==
X-Gm-Gg: AYBFou2axnVoWrnUY9M0YvR0nXCBZvalzU+JJgqdnFD9g9/hCY8jokM0AeZxfKufEsQ
 rtAutCcNFcQiuRYrl05Pe1ezReW1xcxCWXbEkuADaniCn3/LCEoGnseX7+6PhOrOs35ZLO7N0d0
 fuOMHrbowj8Z4hBAXEZI2g+eOmrvzOCkeT4E72E1ibwH7lqEBxzBhCmNx64rmHKdzzLtEJu8YOH
 3A1mf6pU8KBpcP0Pt136qxkx14CwoIMgnTRWSFWPQOvK+mAWUTtO2yi2z7+AToZgwIXW1Ws/p8y
 17t9P3usIj/iVG0eQ2CzhEycYffbZ3HCwPIPBWUXnrl1NEHB5DxS0WXBiGRicXf9deNvbmdffL0
 TcjjfjKui+uLQ1YBMx4TxzFU=
X-Received: by 2002:a17:907:6088:b0:c26:19de:913a with SMTP id
 a640c23a62f3a-c296674aa4cmr139061966b.45.1789117283919; 
 Fri, 11 Sep 2026 02:01:23 -0700 (PDT)
X-Received: by 2002:a17:907:6088:b0:c26:19de:913a with SMTP id
 a640c23a62f3a-c296674aa4cmr139055366b.45.1789117283036; 
 Fri, 11 Sep 2026 02:01:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2966063a2asm56268466b.27.2026.09.11.02.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:22 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PULL v2 02/75] virtio: fix config_len DoS in migration restore path
Message-ID: <2b35ded9c235145cfb31a8553b29e6faf65899fb.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

virtio_load() reads config_len from the migration stream into a local
int32_t variable and then, if the incoming length exceeds the device's
own config size, skips the surplus one byte at a time in a loop.  Two
defects in this loop allow a malicious or truncated migration stream to
cause a prolonged CPU spin on the destination QEMU.

First, the local variable is int32_t while vdev->config_len is size_t.
The C standard converts the signed operand to the unsigned type for the
comparison, so any value with the high bit set becomes a very large
size_t that exceeds the device config length.  The loop then counts the
signed counter down through all negative values and back around,
effectively running for up to 2^32 iterations.

Second, once the file stream reaches EOF, qemu_get_byte() returns 0
without advancing the read position.  Without a check for file errors,
the loop spins until the counter reaches the device config length.  An
attacker who sends a large config_len and then closes the stream can
hold the destination QEMU busy for attacker-controlled time.

Change the local config_len to uint32_t so that the comparison with
size_t is unsigned and values with the high bit set are treated as
large-but-finite skip counts.  In addition, check qemu_file_get_error()
after each byte read and return failure immediately when the stream
signals EOF or an I/O error.

Fixes: 2f5732e964 ("Allow mismatched virtio config-len")
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3891
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 34f1df260b..848fe8539e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3584,6 +3584,9 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
             return -1;
         }
         qemu_get_byte(f);
+        if (qemu_file_get_error(f)) {
+            return -1;
+        }
         config_len--;
     }
 
-- 
MST


