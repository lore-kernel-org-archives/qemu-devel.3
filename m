Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04E4C47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 17:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTQ6q-0005mw-KL; Fri, 26 Jan 2024 12:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+5cc348fc898a3f56ac6c+7460+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rTQ5S-0000BW-9q; Fri, 26 Jan 2024 12:33:55 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+5cc348fc898a3f56ac6c+7460+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rTQ5O-0001jF-GF; Fri, 26 Jan 2024 12:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=4MfAr1yLI5YhElasbf+xYz8slg97fPxYAJHsYCE6HR0=; b=QCcaZ/6C5Iz4cXurFdCGdwPkbs
 Tx+OFOX65z8WZLMrj3r1M1OMa1uCBfhIBkcTalLwyCSVgdp6MRC0yngtPLUk5QQopCNkJxAPjr8jV
 gHBfM+h8Ivnb1jSyeRCUQN44kMg1saXw8rCMBiZrSz0X4jfd6xIpolJgUrAOJCJSl5DCO184V81xQ
 YRJVYKJmmArP7BgFHFDffL11xggxzqvuYlMBM/FYtZ++qK5KeLTkvIsQV7g7OmUG8MlMaO9v2/PFx
 5M7WoyLiczrNts5+qs1F+3zrEq194HhwpwIokm0ghvWCjhXCW0mVX+pXANYl+JThRACU+DCvFtyGJ
 gN/pe2eA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rTQ4B-000000069V8-2yGf; Fri, 26 Jan 2024 17:32:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rTQ4B-00000001eoX-07cN;
 Fri, 26 Jan 2024 17:32:35 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rob Herring <robh@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <huth@tuxfamily.org>,
 Laurent Vivier <laurent@vivier.eu>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v4 46/47] net: remove qemu_show_nic_models(),
 qemu_find_nic_model()
Date: Fri, 26 Jan 2024 17:25:23 +0000
Message-ID: <20240126173228.394202-47-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126173228.394202-1-dwmw2@infradead.org>
References: <20240126173228.394202-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+5cc348fc898a3f56ac6c+7460+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

These old functions can be removed now too. Let net_param_nic() print
the full set of network devices directly, and also make it note that a
list more specific to this platform/config will be available by using
'-nic model=help' instead.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/net/net.h |  3 ---
 net/net.c         | 39 ++++++---------------------------------
 2 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 00ee1af7ab..588ee55f28 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -203,9 +203,6 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
 int qemu_set_vnet_le(NetClientState *nc, bool is_le);
 int qemu_set_vnet_be(NetClientState *nc, bool is_be);
 void qemu_macaddr_default_if_unset(MACAddr *macaddr);
-int qemu_show_nic_models(const char *arg, const char *const *models);
-int qemu_find_nic_model(NICInfo *nd, const char * const *models,
-                        const char *default_model);
 /**
  * qemu_find_nic_info: Obtain NIC configuration information
  * @typename: Name of device object type
diff --git a/net/net.c b/net/net.c
index ffd4b42d5a..d705e9b0fd 100644
--- a/net/net.c
+++ b/net/net.c
@@ -977,38 +977,6 @@ GPtrArray *qemu_get_nic_models(const char *device_type)
     return nic_models;
 }
 
-int qemu_show_nic_models(const char *arg, const char *const *models)
-{
-    int i;
-
-    if (!arg || !is_help_option(arg)) {
-        return 0;
-    }
-
-    printf("Available NIC models:\n");
-    for (i = 0 ; models[i]; i++) {
-        printf("%s\n", models[i]);
-    }
-    return 1;
-}
-
-int qemu_find_nic_model(NICInfo *nd, const char * const *models,
-                        const char *default_model)
-{
-    int i;
-
-    if (!nd->model)
-        nd->model = g_strdup(default_model);
-
-    for (i = 0 ; models[i]; i++) {
-        if (strcmp(nd->model, models[i]) == 0)
-            return i;
-    }
-
-    error_report("Unsupported NIC model: %s", nd->model);
-    return -1;
-}
-
 static int net_init_nic(const Netdev *netdev, const char *name,
                         NetClientState *peer, Error **errp)
 {
@@ -1791,9 +1759,14 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
         }
         if (is_help_option(type)) {
             GPtrArray *nic_models = qemu_get_nic_models(TYPE_DEVICE);
+            int i;
             show_netdevs();
             printf("\n");
-            qemu_show_nic_models(type, (const char **)nic_models->pdata);
+            printf("Available NIC models "
+                   "(use -nic model=help for a filtered list):\n");
+            for (i = 0 ; nic_models->pdata[i]; i++) {
+                printf("%s\n", (char *)nic_models->pdata[i]);
+            }
             g_ptr_array_free(nic_models, true);
             exit(0);
         }
-- 
2.43.0


