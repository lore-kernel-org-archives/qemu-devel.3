Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23DA606A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtSX-0005QE-A1; Mon, 02 Nov 2026 09:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xNtSF-0005Ms-Ch
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:56:15 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xNtSB-0001p7-DO
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:56:11 -0500
Received: from k3-03 (unknown [159.226.43.8])
 by APP-01 (Coremail) with SMTP id qwCowADnDvlxpOhqD08sAA--.4790S2;
 Mon, 02 Nov 2026 22:55:58 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: jasowangio@gmail.com, mst@redhat.com, Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH v2] hw/net/virtio-net: skip automatic zero-init of TX iovec
 arrays
Date: Mon,  2 Nov 2026 22:55:43 +0800
Message-ID: <20261102145543.185183-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADnDvlxpOhqD08sAA--.4790S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4rJr1rGF45XFyUAFW5Wrg_yoW8Zr13pr
 WIka97XrWUtr43t3W8tanrCr9a93Z5Jr47CFs0gw13Grs8Gr1qvFWrK34jv3WfCrZYkr1S
 qr1Ut3yUt3WDuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
 rcIFxwCY02Avz4vE14v_Xryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjfU8HUqDUUUU
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

virtio_net_flush_tx() has two large iovec arrays that are populated
as needed. Entries are initialized explicitly or through iov_copy(),
and out_num bounds the entries subsequently consumed through out_sg.
Zero-initializing the entire arrays is therefore unnecessary.

Similar arrays in virtio_net_receive_rcu() already use
QEMU_UNINITIALIZED to avoid automatic zero-initialization overhead.
Apply the same optimization to the TX path.

Performance was measured with iperf3 TCP_STREAM and netperf UDP_STREAM
using a single-vCPU RISC-V KVM guest with QEMU user networking
(-netdev user). Six interleaved baseline/patched runs were performed
per workload, with 30 seconds of measurement after warm-up.

Median guest-to-host throughput (Mbit/s):

                         Before     After      Change
UDP_STREAM 64B             40.26     46.95      +16.6%
UDP_STREAM 256B           163.17    185.21      +13.5%
TCP_STREAM                480.02    484.83       +1.0%

Median QEMU process instructions during the perf sampling windows
decreased by 23.1% and 24.5% for the 64-byte and 256-byte UDP
workloads, respectively.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---

Changes in v2:
- Add performance results and perf instruction-count measurements.
- No code changes.

 hw/net/virtio-net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 54e42cfec9..76e3281831 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2783,7 +2783,9 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
     for (;;) {
         ssize_t ret;
         unsigned int out_num;
-        struct iovec sg[VIRTQUEUE_MAX_SIZE], sg2[VIRTQUEUE_MAX_SIZE + 1], *out_sg;
+        QEMU_UNINITIALIZED struct iovec sg[VIRTQUEUE_MAX_SIZE];
+        QEMU_UNINITIALIZED struct iovec sg2[VIRTQUEUE_MAX_SIZE + 1];
+        struct iovec *out_sg;
         struct virtio_net_hdr vhdr;
 
         elem = virtqueue_pop(q->tx_vq, sizeof(VirtQueueElement));
-- 
2.53.0


