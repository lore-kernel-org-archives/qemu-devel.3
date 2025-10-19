Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8FACCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 21:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAaZ2-0007Qa-Tz; Sun, 19 Oct 2025 17:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaZ0-0007P2-Tp
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:39 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaYy-00021L-ES
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:37 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b456d2dc440so590934466b.0
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760907815; x=1761512615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqDslS9NKjHnUWYR3Oq3CSi9/FfiBOz9NHEnZxcZS80=;
 b=JdT50y4pTYhg+g9mxUO+Gozw1kBVM91ffYWoztdmf3OF5EOOVIwAAhdVGw7nXq3VRq
 +ved9IA+EX39WIZBOITN9Rz52QSPsdFe7EKvtZH591CYtPNskX3Z+ojApxLVdvsPXXb/
 I3pCTNWnMlLwpHBZLOItgmWoMn1xQDMh0EliU2m2oAY2OVlXgRk1NBbrYsZKFnzlKnk2
 /F+08VhMwVSB0Um9GJ95pcVj70eqsDTrxA/E84Cwp7Bjnal/SWeFoAhT4GafuvszG2LE
 RLIOcl92c67pxcj1AT4wI7Fmb82M4quQRtrE6KRaXRuxj984G2edFLxkEQvLRJrTcyYT
 edPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760907815; x=1761512615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqDslS9NKjHnUWYR3Oq3CSi9/FfiBOz9NHEnZxcZS80=;
 b=WUrDi+Ro8hDjtRIcBQqJEGOkxt3TcrH2Ocg/T5vDo5V/mFyc0UrvT8fJpWrFzO74/J
 lK8/QaXu89fXEXZn9cIR3Uu033Na7Zw+IbSAP0q/e2FyACzqCywfpE1ofALTFDVcXf5h
 NpggN2XhLebpAnbaKvAPKovjiHliLSfZY9kVOanCMRRYrntG6miJSGiE5X1B2ddwed4s
 /X1Aiok5g6j6A4t5qtfD55+0RjlY29ixNZTMn/EOPm389L7S9eKozWJTPPIgoWkwL5Cm
 HH/hmZB18wBF7xtvT4XXrHhOvg4ukCBpONH7da7iwvoc8+0Vt1EWMVKvU8cOiL3J0olb
 IrgA==
X-Gm-Message-State: AOJu0Yx9KyRA0bon6AKzxkt9/tnN8ci9Z8hCpA9ZbDdy/0AB+DYye7lR
 O9rEWNzqcj3HUJXeiufWedO1YrlN+6h3mIDaYQcxpYiVRIonYv7TnzuJMrvDnFfo
X-Gm-Gg: ASbGnctwgeVt+Rw8JFjQswINbi6u54afUxjjdmGicmgpgE9wxebsV9VNmY0QYwwuFvl
 WQFuxZ7sb3FmsK3I8S72zbKaOAi7WcxHRZBQvPY/lgGyDjUa3AlSHlCZ7JCuqEPueoeGmZhimfq
 a4mZ35T+i3amashY2/RLp7kF6q4Iba+3UVf7X5CAI4KXkTO8jDhT41GBxPjegXH/+lEupjdSAfu
 NqNGchrAJkGKd9fzvT+t+HJLJUzTGyRYX5ffskMyKJoQ3H2WQQiVtDFD7503RVIHHs2hF98rWx/
 es2f0UqfihHmq6k8lfI/OAWvDDeBpVWJPdOvPknJoOVlr9y/6NWdLV0muvbilwS/3DI2GpGSjYC
 HOu5yMbQ97O5BZ0LJKA+rXkmtElZlZmgox42Cgg69LZPYBoSLngOi4gB2hrfiIemv1ZWJVbFmQK
 srfy0A4eZzuk6si0Jq0I8mPKkBDVqaIYRpRt/TrlwlyRugIK/NONNh55gsFdR3b56ELdpL
X-Google-Smtp-Source: AGHT+IGPfPy34v/udZLQXvm5jDIXrAZ61l/oD9nGQpnV8TbdI46dqjRmVUAcVk/yLDzjHgyLvbFqIQ==
X-Received: by 2002:a17:907:728c:b0:b57:5353:1032 with SMTP id
 a640c23a62f3a-b6472b5fab6mr1140469866b.5.1760907814623; 
 Sun, 19 Oct 2025 14:03:34 -0700 (PDT)
Received: from archlinux (dynamic-002-245-026-170.2.245.pool.telefonica.de.
 [2.245.26.170]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4945f003sm5107655a12.27.2025.10.19.14.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 14:03:34 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 05/10] hw/rtc/mc146818rtc: Assert correct usage of
 mc146818rtc_set_cmos_data()
Date: Sun, 19 Oct 2025 23:02:58 +0200
Message-ID: <20251019210303.104718-6-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251019210303.104718-1-shentey@gmail.com>
References: <20251019210303.104718-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The offset is never controlled by the guest, so any misuse constitutes a
programming error and shouldn't be silently ignored. Fix this by using assert().

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/rtc/mc146818rtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 5a89062b4c..8631386b9f 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -726,9 +726,8 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
 
 void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val)
 {
-    if (addr >= 0 && addr < ARRAY_SIZE(s->cmos_data)) {
-        s->cmos_data[addr] = val;
-    }
+    assert(addr >= 0 && addr < ARRAY_SIZE(s->cmos_data));
+    s->cmos_data[addr] = val;
 }
 
 int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr)
-- 
2.51.1.dirty


