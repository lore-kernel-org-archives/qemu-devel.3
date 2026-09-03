Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5B4C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x22Gy-0008Fa-3O; Thu, 03 Sep 2026 03:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x22Gv-0008FN-MY; Thu, 03 Sep 2026 03:54:09 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x22Gt-0005Lr-22; Thu, 03 Sep 2026 03:54:09 -0400
Received: from [172.21.96.1] (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowADn8kCXJ5lqiQHQBg--.16018S3;
 Thu, 03 Sep 2026 15:54:00 +0800 (CST)
From: Wang Yang <wangyang25@otcaix.iscas.ac.cn>
To: Alistair.Francis@wdc.com, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 chao.liu@processmission.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 2/5] target/riscv: save ELP in MPELP for RNMI exceptions
In-Reply-To: <d0de80b7fbf7981fceb58f921580616e3751745b.camel@wdc.com>
References: <cover.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
 <ce36a27e6346228b12c926a6f95835521ba56f86.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
 <d0de80b7fbf7981fceb58f921580616e3751745b.camel@wdc.com>
Message-ID: <178842203941.34748.15055654521332091813@otcaix.iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CM-TRANSID: rQCowADn8kCXJ5lqiQHQBg--.16018S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GrykJw1DGw47Xw13AFW3trb_yoWftFbE9F
 17J3sIk3W8Zw45W3W3trnxZr9Fgr98Xr1rAw4DJr1qvw1kZF9rAa1kur15ur1aqay0qrna
 krsxW3y7ur92gjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb3AYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z2
 80aVCY1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
 cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx
 0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x02
 62kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
 4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
 CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
 nIWIevJa73UjIFyTuYvjxU45rcUUUUU
X-Originating-IP: [124.16.137.194]
Date: Thu, 3 Sep 2026 15:54:01 +0800 (CST)
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alistair,

Thank you for the feedback, and sorry that the commit message was unclear.

This patch fixes the Smrnmi and Zicfilp case where an M-mode exception occurs=
 with mnstatus.NMIE=3D0. QEMU currently saves ELP in mnstatus.MNPELP when red=
irecting to the RNMI exception vector, but this path returns with MRET, which=
 restores ELP from mstatus.MPELP. As a result, ELP is lost and a subsequent i=
ndirect branch requiring a landing pad may avoid the expected software-check =
exception. The patch saves ELP in mstatus.MPELP for this path; the true RNMI =
interrupt path using MNPELP and MNRET is unchanged.

I also found that Zephyr Li has submitted an equivalent fix, including a TCG =
regression test: https://www.mail-archive.com/qemu-devel@nongnu.org/msg122208=
4.html. Since that patch fixes the same issue, I will not submit a duplicate =
revision. Please let me know if any further clarification is needed.

Best regards,
Wang Yang


