Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3085CCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 03:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwugz-0006zZ-A3; Thu, 11 Sep 2025 23:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugw-0006ys-My
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugl-0007up-Fc
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45de56a042dso8761365e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 20:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757648582; x=1758253382; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ll/JrM/39KrxwsO7SgDwAOKo4qPF2KTHNIS97BipdEc=;
 b=VcA1Mj8IKZNKHwlu7mM9bq7Lf4YW9IdKXO94V4C0BYYA60Yqd4T23uh/LBAD1uXy9N
 Ul1n7tArh49ZYBu8vlzkSMTwkzbfvi+ukgk+QOx7+VlkTcNKg5GKsGDegpbQBnwy346W
 RPtSwe1RkmYqcNo/zOFE5JTkYSeB5fqzeEYoMSUPwZZyPe7AVrXjS1bEusBlL2XYZ03D
 +elYqhq02/nQfTOdZjqbN4h274RStkPfb7AmtyQwmPBTeYWfx+5C1q2mwI8J4LS7pG7v
 EOsp7MbB17/I7kJxR9yHLAsVhnjH72u/dG2J1K+Zp7Qq/SYmnXufzXIgUMBaSFHB5x4J
 ZXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757648582; x=1758253382;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ll/JrM/39KrxwsO7SgDwAOKo4qPF2KTHNIS97BipdEc=;
 b=GHuiaUP1BHFGuAK/Tzh8wT7smgFMgA+EjzTkQzk2E9JEoI2cxJCaxdbhT356JFw8tS
 f4oVuIY3o8qMt+UHcnQfZl6zNM10uua11OsroKXHP3TcWZg/TC/fghjWvLoXDs0IMSrL
 oJ40h94B604aQ14BWclQZCo769eIlfkHAG4CV8KHWeAoLd+98QotlCRqN2N9P7VJUlW0
 rObrgst+OosMfRvvoGz94hj1ky7dFGEWRAqLddm9bxvTcjKzcwD8ii96uxazbTJ81bJ8
 RcVRIAzBkSjXBvdvp8NZVUc+V5JWgShvk4vOrvGUDW5UcZm/xfaGtgy6wTnIrSDZo7mc
 BYaQ==
X-Gm-Message-State: AOJu0YxoLXY/URZJddcLe2neYKAVVR6LEYYR2Eko/JGOnAcF54Ab9o0w
 uo4qUXxqAo14raRhaByzfpxAfQuEqzdJB+8zGt1l4ojGpr2zzCeD6U/53m/duj6He7M=
X-Gm-Gg: ASbGncsfa1azEK2Ukv0hEeit7woracQbYi+1WqyLMqwOLAKBEoQeGmM+M+DDnyp8FAl
 KQo694j2Jgl8LDqrnwi0luTHxBrRxkYplVZKWk19ZWMyBrg8KRWiLl9AGfBBP/f1a2S4hvwwGMU
 jq3Hn1aiCgPHSopM0kmC0VYjIKCakZSXpaPkUEpzWzUhyQd2AHKOjKxLqkWSlQ5r8ONB+P8mRqN
 Z8LThu1yumK1DWyLYvIb04jd4H+tSUB2VqwGFdNofv3U0LkR4sNO7j7wRFLQFw+2UGy6MsC5++h
 tuwsibdsgfrD+r1OM4PRDQJW77mTev/ooXn+JNG6m0DtFd0bh7GWxVn7Bn4Fqec/b9duQPxxGI6
 /i1qYWUFqbrfV+kPHGcvbFNTo3nrAl0AFDrMSOdHZcC3tzzMfqObm9aVoPunIGeg=
X-Google-Smtp-Source: AGHT+IHEr3ko1m1f2nZUPik+J9EjkvaAIjGTuUmZSUxS9Huf+h/Ka1+jDcoT8Pf0KO55dOjlwn/UXA==
X-Received: by 2002:a05:600c:3b95:b0:45f:2207:ab2a with SMTP id
 5b1f17b1804b1-45f2207ab66mr7272705e9.27.1757648582277; 
 Thu, 11 Sep 2025 20:43:02 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3e760787417sm4972731f8f.21.2025.09.11.20.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 20:43:01 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Fri, 12 Sep 2025 05:39:47 +0200
Subject: [PATCH v4 02/10] chardev: add CHR_EVENT_RESIZE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-console-resize-v4-2-7925e444afc4@gmail.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
In-Reply-To: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648576; l=9153;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=ug9xDk81wAxSNAh4SOoDU5gH9cGzzrxsRWSHUn88X1Q=;
 b=/ULY2OJVQC8UYkU2/VrnKM4OIbE2u7yVRl978IqxD5HddGVDbUQbs0I2ZTMURrPMJUXSuzJ2D
 xT2T8LOHQshCc9wLsQztUrTJhbc5gPaFMXFgpa+28LYUrb3hwe09dtW
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Szymon Lukasz <noh4hss@gmail.com>

Add a new chardev event, CHR_EVENT_RESIZE, which a backend should
trigger if detects the size of the connected terminal changed.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 backends/cryptodev-vhost-user.c | 1 +
 chardev/char.c                  | 1 +
 hw/block/vhost-user-blk.c       | 1 +
 hw/char/terminal3270.c          | 1 +
 hw/char/virtio-console.c        | 1 +
 hw/ipmi/ipmi_bmc_extern.c       | 1 +
 hw/scsi/vhost-user-scsi.c       | 1 +
 hw/usb/ccid-card-passthru.c     | 1 +
 hw/usb/dev-serial.c             | 1 +
 hw/usb/redirect.c               | 1 +
 hw/virtio/vhost-user-base.c     | 1 +
 hw/virtio/vhost-user-scmi.c     | 1 +
 include/chardev/char.h          | 4 ++++
 monitor/hmp.c                   | 1 +
 monitor/qmp.c                   | 1 +
 net/passt.c                     | 1 +
 net/vhost-user.c                | 1 +
 17 files changed, 20 insertions(+)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index cb04e68b022abcc4d794df741dfc25181db660bc..9daca4b0f91e802f67cf3c7af1f8f26479026e1e 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -173,6 +173,7 @@ static void cryptodev_vhost_user_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/chardev/char.c b/chardev/char.c
index bbebd246c3a46c848847effc775f6390b5078e14..635d19fea4fd4bd0c7f171f055fe940f9f5ebed5 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -75,6 +75,7 @@ void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c0cc5f6942815aa5e8d972553b3c76a623523ba4..942bc46171824017c98774d6fe793059082385b6 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -412,6 +412,7 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index d950c172921f91e41fad2b86a8d2a3791f6b0330..2fdf823e3bab3187fa6a4d2214ecd991bac5f473 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -172,6 +172,7 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 0932a3572b78eda866cd7680a32866f2077a91dd..881c862ce9d12027f392031bdea7dbe280ec5493 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -168,6 +168,7 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 9f1ba7b2f8715daf3558fedde358c625c74da20e..b1f28c5b7db71d2cbd828227f176a484629a14f7 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -436,6 +436,7 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 25f2d894e7c827744a41302473712e7b34672536..a8d40046b714e5899262af7382a02611cb7f9a81 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -226,6 +226,7 @@ static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 1eea21a7337747667e9b1db97900c67b061f3729..08fec48dbe00cebef7e73053f2be76932175fb47 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -323,6 +323,7 @@ static void ccid_card_vscard_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
     case CHR_EVENT_CLOSED:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 1c116d8b0fef7b23dd076aa6e7e81e52bb51cdbb..dd70db7705def9b93bd69cf176ff0ed7d8cb2cad 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -576,6 +576,7 @@ static void usb_serial_event(void *opaque, QEMUChrEvent event)
         break;
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index f516ff42a114d014033ab9f2fce93d1ca48983a6..68c9b48f7a07558441c6d6cd3deccb98e833910b 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1390,6 +1390,7 @@ static void usbredir_chardev_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index ff67a020b471b2edfacc6d238ffc50b3ba36afc4..57ff26e775df46135b84449f22929fadd33c684a 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -267,6 +267,7 @@ static void vub_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index f9264c4374e87cb78f8937fda852089487b477e8..180787ec6d94793d4915a26389ae2bece231064e 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -214,6 +214,7 @@ static void vu_scmi_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 336b2e68d099e70a9abe71ef842b160bf12ea932..45cb6349756ac8072dffab9354108caf90cd3565 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -22,6 +22,10 @@ typedef enum {
     CHR_EVENT_OPENED, /* new connection established */
     CHR_EVENT_MUX_IN, /* mux-focus was set to this terminal */
     CHR_EVENT_MUX_OUT, /* mux-focus will move on */
+    CHR_EVENT_RESIZE, /*
+                       * the size of the terminal connected to
+                       * the chardev changed
+                       */
     CHR_EVENT_CLOSED /* connection closed.  NOTE: currently this event
                       * is only bound to the read port of the chardev.
                       * Normally the read port and write port of a
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 34e2b8f748b425e1e4446e8e64aa25b1433d1162..be623a0ef0d0ebdf091d87e4d620175ad60d1566 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1444,6 +1444,7 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
         break;
 
     case CHR_EVENT_BREAK:
+    case CHR_EVENT_RESIZE:
         /* Ignored */
         break;
     }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index cb99a12d94175b395033569e8ead908d9453e759..ff7548422bc60c64e47fc4f24adf092fc81c70b5 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -484,6 +484,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/net/passt.c b/net/passt.c
index 32ecffb763b48af4e17b20b98537a4ffb3a6d3ea..2308e3b4d44aa410c374eb1b47e5081c2bef5cec 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -421,6 +421,7 @@ static void passt_vhost_user_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 8b96157145a7ab719b15b1b70aadac1e88ebfd5f..1c7fdf8267d8c214dcb6ae92e0521747a9f59a6f 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -367,6 +367,7 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }

-- 
2.51.0


