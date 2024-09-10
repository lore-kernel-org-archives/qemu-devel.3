Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47848EE01EE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9AK-0008NN-Lu; Tue, 10 Sep 2024 18:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so99v-00072j-VE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:16:28 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so99s-0006Vs-Ug
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:16:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-718e1ce7e84so3015522b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 15:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726006582; x=1726611382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8E41vvCuzFfFnWNVteAbOukx+NZntvmSmJeEnMZhnio=;
 b=kQXqe8EZd5MJkDKysWif9bigJi5cEeyuihaPnl+l6I+CFXHMrf/+lshxHlqtOlNLMZ
 Zw8TKwnN8XHmOlwezyimKoS/FsK403QCWVd64GAXwEGgSVv3go/0hM8b4LQNPMXxjr0m
 2UANvhvaGRpMf+txypjRTsCAMXMzqezKop0BmJbxE0UK0PCEAKGRCW4Q7ZOQrqDUrjfr
 ErFlfK4NpT9db6ce9xUvzGbGnEnLiII0Fiu85LGr6Hsh9b5CLQMsuPktlVsU9IlRNFup
 H78pkHiKorm64kyl85GYhoFO1b/i3W/Nuzf76wypQ7wWi6xvZKiARWsIkIQH9tMKiu/Z
 SejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006582; x=1726611382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8E41vvCuzFfFnWNVteAbOukx+NZntvmSmJeEnMZhnio=;
 b=DLqNtnRK0OXY9saWlNmQzFoOu/yesZiSzDYBv/hq6O750WVKmW/T6aVryYdeFX8gkA
 iPTKy7cw5aYPy0ZIN3c45uQlV5ursrhP3XOTCzsxvkWm8BIMTWFo893zMFQFojXosEzJ
 m/g/4LlpulxQ4NOwEuAPKKgxqmtTtwP321p4Seu+wAZ9QZteF7ou9UayZLwQzohEPpWd
 Sp1mbtvFuVFarG65PwPOBzThhHB8liXIcoT03ZuKwzxLT2wGsOARm9dmn4dz2YY8hEUe
 5GjBWuph9MUiM5T5X5ENDFBuuP2/DDnlmezH/O/OnBhS3dSVXcNcoCwTZqZoc1dFkIkp
 kbFQ==
X-Gm-Message-State: AOJu0YzwrHLiqLFJYO0KZ6SSujSYyikZOnmOcnxj4nShPnoOIq88e5ez
 qE1hRZFXRpY2cUc7EYs5hboL9SguShxAAVTxXMYBMNyruh7qyxa9udbj4msdxsU2k0Rqi76nHMg
 //FqX5Q3r
X-Google-Smtp-Source: AGHT+IEpm92TEZ7l/i72e03p8S1n7AWDI6NeOOFfrUtGzNn7Eo7pwNzB53KVkJOarI+xWw/0AjoAnw==
X-Received: by 2002:a05:6a00:218e:b0:717:9768:a4e7 with SMTP id
 d2e1a72fcca58-718d5ded0acmr15822990b3a.2.1726006582456; 
 Tue, 10 Sep 2024 15:16:22 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003d0esm1884055b3a.93.2024.09.10.15.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:16:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 05/39] hw/core: replace assert(0) with g_assert_not_reached()
Date: Tue, 10 Sep 2024 15:15:32 -0700
Message-Id: <20240910221606.1817478-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/core/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index f8ce332cfe9..14283293b42 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -380,7 +380,7 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
         }
         lb_data.data = node->bandwidth;
     } else {
-        assert(0);
+        g_assert_not_reached();
     }
 
     g_array_append_val(hmat_lb->list, lb_data);
-- 
2.39.2


