Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BACFCA1016
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 02:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuirX-0001VP-Mj; Fri, 05 Sep 2025 22:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuirT-0001Sw-HE; Fri, 05 Sep 2025 22:41:07 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuirE-0005hJ-0z; Fri, 05 Sep 2025 22:41:07 -0400
Received: from [10.40.4.92] (93-51-222-138.ip268.fastwebnet.it [93.51.222.138])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5862dKwa051529
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 6 Sep 2025 11:39:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0Wmecb1gZcgzIN0AvJLb87Mi6Fw68Dtp7HJg/gw6MA8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1757126387; v=1;
 b=etjyPR3my23ArPJxSoWy39JBX4jZVpZJUtMMBy8EjJ6GQioXfkvarpAoPRvQGdnX
 8Ei/TWA/xCh3NdIN5ih+dBjJPIM3qpoK2udM+qhMMCAeKeYhcioJB1Yke1yVZEDS
 eulwEDKtTnj5RxHV/6mG/FLC5HeOPLAOcji6SuKhHvJ6uv1VGz/zPewDXA59DytL
 wVoLEfwe/gU7vSVNbp/M/kp2v1mTJzNbeOj08CqDfpvTKHgXdJTqBb+B/OenjNx0
 kQeebQZ4GHmkvkkMD52Od58z34PNG2B6D8EADn8lGd7GcKf76XcCtehWpAYqAo3i
 RYJj0GS15GU1gdBDFAATVg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 06 Sep 2025 04:39:04 +0200
Subject: [PATCH v2 1/3] qom: Do not finalize twice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-mr-v2-1-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
References: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The next change adds code to retain references from an object to the
parent when it is being unparented to ensure that the parent outlive
them. This change handles the following scenario with the code:

1. The parent starts being finalized without unparenting.
2. Unparenting happens during finalization.
3. The child retains the reference to the parent.
4. The child gets finalized, and releases the reference.

In this scenario, the reference counter of the parent reaches to zero,
gets incremented, and gets decremented to reach to zero again. This
change ensures that finalization will be triggered again in the
scenario.

Note that the reference counter needs to reach to zero again before
finalization ends; otherwise the object will be "resurrected", which
is not clearly defined and prohibited with an existing assertion.

One thing that looks concerning with this change is that it adds a bool
to Object. This is not a problem in the most situations where the host
uses 64-bit addressing because the member is added to a gap needed for
alignment, and possible double-free scenarios handled with this change
are more serious than the extra memory usage for 32-bit hosts.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/qom/object.h | 1 +
 qom/object.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 26df6137b911..7f7b1ffea8fe 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -158,6 +158,7 @@ struct Object
     ObjectFree *free;
     GHashTable *properties;
     uint32_t ref;
+    bool finalizing;
     Object *parent;
 };
 
diff --git a/qom/object.c b/qom/object.c
index 1856bb36c74c..b766b2e9baa7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -725,6 +725,11 @@ static void object_finalize(void *data)
     Object *obj = data;
     TypeImpl *ti = obj->class->type;
 
+    if (obj->finalizing) {
+        return;
+    }
+
+    obj->finalizing = true;
     object_property_del_all(obj);
     object_deinit(obj, ti);
 

-- 
2.51.0


