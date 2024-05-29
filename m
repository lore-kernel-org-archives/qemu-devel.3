Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D785C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCIu7-0002yz-G2; Wed, 29 May 2024 08:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sCIu5-0002xf-1E
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:59:41 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sCItz-0000tZ-Kn
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:59:39 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240529125358epoutp0233074278e2218019ab036f15add2317a~T9svUs01v0033000330epoutp02X
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:53:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240529125358epoutp0233074278e2218019ab036f15add2317a~T9svUs01v0033000330epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1716987238;
 bh=XOSTDNnpBFlIvv8h6EZ6WZyo1wZw3QEABDyzLGvi40U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UH0EahHsV0hMZxW7z0WwFpSnBAzqwd7cyLTczJ8FzOgDrh1mCw16YTi8pNWWOiWyj
 VN/hMSQGRzNwR7sidkbu7SBh9vtEqBkc7H0enGX7s7RaeDHMuxPZKpqE3pfHhNF80T
 pmMqWesz59IM7sVJB7BwQsRrVaUk+h1DpEyGbhVs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20240529125357epcas2p2c572eb49de1515c530477cef8136d560~T9su_pUr70039000390epcas2p2K;
 Wed, 29 May 2024 12:53:57 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4Vq8TK2Nthz4x9Pr; Wed, 29 May
 2024 12:53:57 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 7C.E6.09479.56527566; Wed, 29 May 2024 21:53:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20240529125356epcas2p12d3250098243e6271bccd6519fb79cff~T9suH8vo-0504005040epcas2p1_;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240529125356epsmtrp2f03cf2cf65e360b28fcc6ab2802b65fe~T9suEQYhm1667216672epsmtrp2D;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
X-AuditID: b6c32a48-105fa70000002507-e5-66572565054e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 33.6A.08622.46527566; Wed, 29 May 2024 21:53:56 +0900 (KST)
Received: from localhost.dsn.sec.samsung.com (unknown [10.229.54.230]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240529125356epsmtip262463068c0cf8c8aeb39f549be251957~T9st44-o60854208542epsmtip2B;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
From: Minwoo Im <minwoo.im@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, minwoo.im@samsung.com,
 gost.dev@samsung.com
Subject: [PATCH v4 3/4] hw/nvme: Allocate sec-ctrl-list as a dynamic array
Date: Wed, 29 May 2024 21:42:33 +0900
Message-Id: <20240529124234.1430707-4-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529124234.1430707-1-minwoo.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdljTQjdVNTzNoOMOv8WJKWEWNw/sZLLY
 f/Abq8WkQ9cYLZ6dPsBsMetdO5vF8d4dLA7sHlOmXWP3OLfjPLvHplWdbB5Prm1m8ujbsoox
 gDUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6Awl
 hbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBh
 QnbGp+Y2loL74hX/rws2MDYKdTFyckgImEg07bnM3sXIxSEksINRYub8I2wQzidGiQNrNjFB
 ON8YJW6d2s4G07JoaTNUYi+jxPPVa6FafjNK/N19ngWkik1AXaJh6iswW0QgR6J/5XcmEJtZ
 IF7i+Yof7CC2sICXxLx/H1hBbBYBVYmZP24ygti8AjYSByc9Y4TYJi+x/+BZZhCbU8BWomvO
 G3aIGkGJkzOfsEDMlJdo3jqbGeQICYGX7BJ/ug6wQzS7SHTPaIGyhSVeHd8CZUtJfH63F+qd
 comfbyZBLauQODjrNlCcA8i2l7j2PAXEZBbQlFi/Sx8iqixx5BbUVj6JjsN/2SHCvBIdbdAQ
 VZb4eOgQM4QtKbH80muoPR4ST/Zsgob0BEaJpnnX2CcwKsxC8swsJM/MQli8gJF5FaNYakFx
 bnpqsVGBCTx+k/NzNzGCE6WWxw7G2W8/6B1iZOJgPMQowcGsJMJ7ZlJomhBvSmJlVWpRfnxR
 aU5q8SFGU2BQT2SWEk3OB6bqvJJ4QxNLAxMzM0NzI1MDcyVx3nutc1OEBNITS1KzU1MLUotg
 +pg4OKUamNYftv5w/Pf0I7UHUxcYxf+qYbaakRa+qHzz37K069Y/mlSr1KZvjutSudAfKrbm
 xWvtItnv5hKfCoS3MHooXChhmbZr84Ey+RI9wwk/tv7W3LXf9fvmnW+mZBhdYZk774OVkfbc
 Q7W9qzU12rsF94tz+XV7iBav35kxseyr46POkyzHY1bvnblF0JyrI8zw7u2i+wosO3ZYBofO
 sz4x2WkKz9M/W5k9JjN+8rizomnXtcUVT/8/LTsVaxEe3X8ls8JiWqza1NI9AjWLGZtWmX7l
 +1E6vURI71Tehsr9x77sXc+u6+O9jNtN01LtusIWDob1Ov+zpc4/iVgsUlzh/13lYMI7qQyx
 YJ6u963u/5RYijMSDbWYi4oTAXGB9U0dBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSvG6KaniawcFfhhYnpoRZ3Dywk8li
 /8FvrBaTDl1jtHh2+gCzxax37WwWx3t3sDiwe0yZdo3d49yO8+wem1Z1snk8ubaZyaNvyyrG
 ANYoLpuU1JzMstQifbsEroxPzW0sBffFK/5fF2xgbBTqYuTkkBAwkVi0tJmpi5GLQ0hgN6PE
 8sUT2SESkhL7Tt9khbCFJe63HGGFKPrJKLGl4xJYgk1AXaJh6isWEFtEIE/i2sslzCA2s0Cy
 xPFlM8DiwgJeEvP+fQCrZxFQlZj54yYjiM0rYCNxcNIzRogF8hL7D54F6+UUsJXomvMG7Agh
 oJpFj3+zQ9QLSpyc+YQFYr68RPPW2cwTGAVmIUnNQpJawMi0ilEytaA4Nz232LDAKC+1XK84
 Mbe4NC9dLzk/dxMjOKi1tHYw7ln1Qe8QIxMH4yFGCQ5mJRHeM5NC04R4UxIrq1KL8uOLSnNS
 iw8xSnOwKInzfnvdmyIkkJ5YkpqdmlqQWgSTZeLglGpguvzgacrbFhkZlRm+S55azLAosDs4
 5fvvTH25yi2X7lbKBGhrmxvbSeetWKPaLsZX/C951u3LefdX/jBsCfq6d8G1Fe36d3bsbuD9
 1aR9u2btO6dex/aVR+Tq3hvda572aMm572LLZspd//Ctbnbn7fvrCi/va5tb8P8JU5HH7vSI
 m29+rFjxf8ORS3zuTxxu/jzvvqmNP/Nu4L9wsbCNX18pXk2XbBG7xZkg2urgsfSnE2/DIrun
 bw9dbFtSv/6b+KTGFmWzzw4PeRPnHpy5a97sG78iZHk5Dmz4sjAmcv7Z8nXhJkc3BIjGCu7c
 9LfN/ejOuMhZjdEPlu52vtm5ov6y07IKBgWd12vfvSmWq29VYinOSDTUYi4qTgQAhN/x+NkC
 AAA=
X-CMS-MailID: 20240529125356epcas2p12d3250098243e6271bccd6519fb79cff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240529125356epcas2p12d3250098243e6271bccd6519fb79cff
References: <20240529124234.1430707-1-minwoo.im@samsung.com>
 <CGME20240529125356epcas2p12d3250098243e6271bccd6519fb79cff@epcas2p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=minwoo.im@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

To prevent further bumping up the number of maximum VF te support, this
patch allocates a dynamic array (NvmeCtrl *)->sec_ctrl_list based on
number of VF supported by sriov_max_vfs property.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/nvme/ctrl.c   | 8 +-------
 hw/nvme/nvme.h   | 5 ++---
 hw/nvme/subsys.c | 2 ++
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 7cf1e8e384..90a58e71bd 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7863,12 +7863,6 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
             return false;
         }
 
-        if (params->sriov_max_vfs > NVME_MAX_VFS) {
-            error_setg(errp, "sriov_max_vfs must be between 0 and %d",
-                       NVME_MAX_VFS);
-            return false;
-        }
-
         if (params->cmb_size_mb) {
             error_setg(errp, "CMB is not supported with SR-IOV");
             return false;
@@ -8461,7 +8455,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT8("zoned.zasl", NvmeCtrl, params.zasl, 0),
     DEFINE_PROP_BOOL("zoned.auto_transition", NvmeCtrl,
                      params.auto_transition_zones, true),
-    DEFINE_PROP_UINT8("sriov_max_vfs", NvmeCtrl, params.sriov_max_vfs, 0),
+    DEFINE_PROP_UINT16("sriov_max_vfs", NvmeCtrl, params.sriov_max_vfs, 0),
     DEFINE_PROP_UINT16("sriov_vq_flexible", NvmeCtrl,
                        params.sriov_vq_flexible, 0),
     DEFINE_PROP_UINT16("sriov_vi_flexible", NvmeCtrl,
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 485b42c104..d8ec4bad6a 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -26,7 +26,6 @@
 
 #define NVME_MAX_CONTROLLERS 256
 #define NVME_MAX_NAMESPACES  256
-#define NVME_MAX_VFS 127
 #define NVME_EUI64_DEFAULT ((uint64_t)0x5254000000000000)
 #define NVME_FDP_MAX_EVENTS 63
 #define NVME_FDP_MAXPIDS 128
@@ -532,7 +531,7 @@ typedef struct NvmeParams {
     bool     auto_transition_zones;
     bool     legacy_cmb;
     bool     ioeventfd;
-    uint8_t  sriov_max_vfs;
+    uint16_t  sriov_max_vfs;
     uint16_t sriov_vq_flexible;
     uint16_t sriov_vi_flexible;
     uint8_t  sriov_max_vq_per_vf;
@@ -614,7 +613,7 @@ typedef struct NvmeCtrl {
 
     NvmePriCtrlCap  pri_ctrl_cap;
     uint32_t nr_sec_ctrls;
-    NvmeSecCtrlEntry sec_ctrl_list[NVME_MAX_VFS];
+    NvmeSecCtrlEntry *sec_ctrl_list;
     struct {
         uint16_t    vqrfap;
         uint16_t    virfap;
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 561ed04a53..77deaf2c2c 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -61,6 +61,8 @@ int nvme_subsys_register_ctrl(NvmeCtrl *n, Error **errp)
     if (pci_is_vf(&n->parent_obj)) {
         cntlid = le16_to_cpu(sctrl->scid);
     } else {
+        n->sec_ctrl_list = g_new0(NvmeSecCtrlEntry, num_vfs);
+
         for (cntlid = 0; cntlid < ARRAY_SIZE(subsys->ctrls); cntlid++) {
             if (!subsys->ctrls[cntlid]) {
                 break;
-- 
2.34.1


