Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1060CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNt1-0005ae-Ea; Sat, 30 Aug 2025 11:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1usD2a-0004Ph-Ro; Sat, 30 Aug 2025 00:18:12 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1usD2X-00015z-HL; Sat, 30 Aug 2025 00:18:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D84F4016F;
 Sat, 30 Aug 2025 04:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544D0C4CEEB;
 Sat, 30 Aug 2025 04:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1756527479;
 bh=t8gk6uMODJM5CfcMPcA53dgmBHdQNJMqjHmVDwp3hqs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IgEAIPTmphR+Yfi2wcqQy9/X6PNiT3dz1Wbqi21dBC5Lgxpn3IXwYZonmbmAibLW9
 LebEmAQpCyUIJ3qB18fAq1fmdweHK07gAGmVAHGyOeDJc148Aec7Y00Mx5T3xKtLbO
 0rPv3LH3AWPLhyZQ6dypsSO/RgyscO+6vXwpoQPMNCa2lfMpokLdVlyV9jvOBMpaaq
 ouuK7o9VjsMrsQ8q0ETHxbohFB9yQWRLQigxttiOKaO0LQy3ex0aszF8QgQ3uVkeBx
 Sbwmof/QPKfyYCbNMD4BMwE1ub4EJDuF/ef/BTmWg7fomSFh4GnfbWS2FenG63CO1G
 1C08hTHxtcjBg==
Date: Fri, 29 Aug 2025 22:17:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v2 3/5] hw/nvme: add NVMe Admin Security SPDM support
Message-ID: <aLJ7dKOgu-tJvk28@kbusch-mbp>
References: <20250828072532.425592-2-wilfred.opensource@gmail.com>
 <20250828072532.425592-5-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828072532.425592-5-wilfred.opensource@gmail.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=kbusch@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 28, 2025 at 05:25:31PM +1000, Wilfred Mallawa wrote:
> +static uint16_t nvme_sec_prot_spdm_send(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    StorageSpdmTransportHeader hdr = {0};
> +    g_autofree uint8_t *sec_buf = NULL;
> +    uint32_t transfer_len = le32_to_cpu(req->cmd.cdw11);
> +    uint32_t transport_transfer_len = transfer_len;
> +    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint32_t recvd;
> +    uint16_t nvme_cmd_status, ret;
> +    uint8_t secp = extract32(dw10, 24, 8);
> +    uint8_t spsp1 = extract32(dw10, 16, 8);
> +    uint8_t spsp0 = extract32(dw10, 8, 8);
> +    bool spdm_res;
> +
> +    transport_transfer_len += sizeof(hdr);
> +    if (transport_transfer_len > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    /* Generate the NVMe transport header */
> +    hdr.security_protocol = secp;
> +    hdr.security_protocol_specific = cpu_to_le16((spsp1 << 8) | spsp0);
> +    hdr.length = cpu_to_le32(transfer_len);
> +
> +    sec_buf = g_malloc0(transport_transfer_len);
> +    if (!sec_buf) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    /* Attach the transport header */
> +    memcpy(sec_buf, &hdr, sizeof(hdr));
> +    ret = nvme_h2c(n, sec_buf + sizeof(hdr), transfer_len, req);
> +    if (ret) {
> +        return NVME_NO_COMPLETE | NVME_DNR;

The "NO_COMPLETE" is a special -1 value so or'ing it with anything
doesn't make sense.

But more importantly, what's supposed to complete it? This is supposed
to be used as a return code when you have an async context to complete
it later, and there doesn't appear to be one here.

