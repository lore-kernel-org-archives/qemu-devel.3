Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3F1CA1016
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 02:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuits-0003F3-Bj; Fri, 05 Sep 2025 22:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuitb-00036s-Og; Fri, 05 Sep 2025 22:43:21 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuitV-0005pH-DN; Fri, 05 Sep 2025 22:43:19 -0400
Received: from [10.40.4.92] (93-51-222-138.ip268.fastwebnet.it [93.51.222.138])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5862dKwZ051529
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 6 Sep 2025 11:39:27 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=DICOysjlnRT5HnoCRMBRPDLSC40s3EH7K+pp1h59vjc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1757126377; v=1;
 b=eV0AOTG4o9tIgBsNeUVLRbdyP9pk77Q79QQf3f541WFhN7KPUuJcTXHi7wc1nVMq
 TfFA6G2DxkruuoQaQss1/3V31S4C+GIVXr3T10s8uM53nSGK2gWocikCCRra/ZYe
 xDR3qF8F1IksB1ys3CMZ3KXNjHDf8wI2o60GASGsGdF0oF/y+7BPd7bwQtQs/U56
 NFzSLuxB4BBLxLwoXiD5GqvqtkV0HjEHX38QtUIfx3gYveD5utschDWu/l1EVm4W
 zrOW4l9Fmk5yykTELCwB3q8iwjK7WUK1OnjQSgJ+uVOJyG4uv++YqHwM4tVE9taT
 Vck4092Mg+UnIer5x+vbAg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 0/3] memory: Stop piggybacking on memory region owners
Date: Sat, 06 Sep 2025 04:39:03 +0200
Message-Id: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMieu2gC/3WPSW7DMAxFr2JoXRmkJXlCUeQeQRYaqEQtHKWSb
 TQIcvcqdrddfoL/8fHBMqVAmY3VgyVaQw7xWkLzVjF70dcz8eBKZg00CnqBfErcgbNyUEY7RFY
 Wb4l8+Nkgx1PJl5DnmO4bc8XXdK8PsNVX5MCd66xpDcoezCHlc21DHeqFz/HrHmtt688bOz13e
 KLvpYjN+wVmdCZu4zSFeawIAZ0Q3dAoATAIr8GAbkl5KUi63nqSqkd6eU6Us94+Gqv3P6OWL4W
 2KVmFVmvvkEz3j9JHcXr+At2t4F00AQAA
X-Change-ID: 20250831-mr-d0dc495bad11
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
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Supersedes: <20250828-san-v9-0-c0dff4b8a487@rsg.ci.i.u-tokyo.ac.jp>
("[PATCH v9 0/2] Fix check-qtest-ppc64 sanitizer errors")

Based-on: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
("[PATCH 00/22] Fix memory region leaks and use-after-finalization")

MemoryRegions used to "piggyback" on their owners instead of using their
reference counters due to the circular dependencies between them, which
caused memory leak.

I tried to fix it with "[PATCH v9 0/2] Fix check-qtest-ppc64 sanitizer
errors" but it resulted in a lengthy discussion; ultimately it is
attributed to the fact that "piggybacking" is hard to understand and
forces us design trade-offs. It was also insufficient because it only
deals with the container/subregion pattern and did not deal with
AddressSpace and DMA. Fixing all possible memory leaks require checking
the referrer at many places where memory_region_ref() is called.

With this series, I remove the "piggyback" hack altogather.
The key insight here is that the unparented devices have the finalizable
MemoryRegions and they do not need them. I code the fact by calling
object_unparent() in device_unparent(). This eliminates the entire class
of memory leaks caused by references from owners to their MemoryRegions.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v2:
- Expanded the message of patch
  "vfio/pci: Do not unparent in instance_finalize()".
- Changed to exploit the unparenting timing instead of the unrealization
  timing.
- Link to v1: https://lore.kernel.org/qemu-devel/20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (3):
      qom: Do not finalize twice
      virtio-gpu-virgl: Add virtio-gpu-virgl-hostmem-region type
      memory: Stop piggybacking on memory region owners

 docs/devel/memory.rst         | 41 +++++++++++++++++-----------------
 include/qom/object.h          |  1 +
 include/system/memory.h       | 51 +++++++++++++++++++++----------------------
 hw/core/qdev.c                | 16 ++++++++++++++
 hw/display/virtio-gpu-virgl.c | 50 ++++++++++++++++++++++++++++++------------
 qom/object.c                  |  5 +++++
 system/memory.c               | 33 ++++++++++++++++++++--------
 7 files changed, 127 insertions(+), 70 deletions(-)
---
base-commit: e101d33792530093fa0b0a6e5f43e4d8cfe4581e
change-id: 20250831-mr-d0dc495bad11
prerequisite-message-id: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
prerequisite-patch-id: d464fda86a3c79ff8e6d7a2e623d979b2a47019b
prerequisite-patch-id: 17b153237f69c898b9c5b93aad0d5116d0bfe49f
prerequisite-patch-id: a323f67e01c672ab2958a237ea54b77f1443e2d1
prerequisite-patch-id: 019969fe248bd57ddcda1ff5fc960b214ccffefe
prerequisite-patch-id: 74ded25b212b75b2f7d1859fedc601cf33d59107
prerequisite-patch-id: 43f841a1924749e2a5a3b74b35e54f89afb7e3c5
prerequisite-patch-id: 44300da5065efee0390be5d450225868e01cecfc
prerequisite-patch-id: 4af306d6f3d0a4585015c5907ca1e1dcfced77d3
prerequisite-patch-id: fff78c7af9b0a56190a1b4afbb122c460a6b0e7d
prerequisite-patch-id: 3d38803ce09ba9c93f2a876f54309e673b396ab1
prerequisite-patch-id: 822094864ad7a6a702fee098e4835621bd8092fe
prerequisite-patch-id: 5757efd81557b060257b5db6dec6fd189076ee77
prerequisite-patch-id: bd912830a326f13186bf38e916655ec980e11af8
prerequisite-patch-id: fe6b92112288829e60f10c305742a544f45e8984
prerequisite-patch-id: ac4ff0c11dcc1fc5d08b4fc480c14721fde574ad
prerequisite-patch-id: ff398fa97b5f2feee85372fdf108d82d8d5526b0
prerequisite-patch-id: 7ac446ae76e05dd267a63889ff775ac609712c31
prerequisite-patch-id: b49a74cd5f31348c3dc13dcfd1dad629e6b30387
prerequisite-patch-id: 8f61fe1b81cf3ec906ebbf61776573edd96c1e8c
prerequisite-patch-id: 01fb8ccbe7326021a94a8d7531189568d2e311a7
prerequisite-patch-id: 974b0fc6d7c8d6d56b8f44597260647e1a53cf38
prerequisite-patch-id: 55c4711a2a4e6b02b8b512e0283f8feaf7d3bfa3

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


