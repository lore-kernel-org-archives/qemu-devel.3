Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925F2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPBc-0005mS-9A; Mon, 29 Jul 2024 08:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=joD8=O5=kaod.org=clg@ozlabs.org>)
 id 1sYPBa-0005kt-I6; Mon, 29 Jul 2024 08:09:06 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=joD8=O5=kaod.org=clg@ozlabs.org>)
 id 1sYPBY-0005wO-DK; Mon, 29 Jul 2024 08:09:06 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WXcbF5f25z4x6n;
 Mon, 29 Jul 2024 22:08:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WXcbC5VW3z4x3d;
 Mon, 29 Jul 2024 22:08:55 +1000 (AEST)
Message-ID: <51155ede-a34f-40f0-8122-540e25974466@kaod.org>
Date: Mon, 29 Jul 2024 14:08:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 38/96] hw/ssi: Extend SPI model
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Chalapathi V <chalapathi.v@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
 <20240725235410.451624-39-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240725235410.451624-39-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=joD8=O5=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/26/24 01:53, Nicholas Piggin wrote:
> +static void transfer(PnvSpi *s, PnvXferBuffer *payload)
> +{
> +    uint32_t tx;
> +    uint32_t rx;
> +    PnvXferBuffer *rsp_payload = NULL;
> +
> +    rsp_payload = pnv_spi_xfer_buffer_new();
> +    for (int offset = 0; offset < payload->len; offset += s->transfer_len) {
> +        tx = 0;
> +        for (int i = 0; i < s->transfer_len; i++) {
> +            if ((offset + i) >= payload->len) {
> +                tx <<= 8;
> +            } else {
> +                tx = (tx << 8) | payload->data[offset + i];
> +            }
> +        }
> +        rx = ssi_transfer(s->ssi_bus, tx);
> +        for (int i = 0; i < s->transfer_len; i++) {
> +            if ((offset + i) >= payload->len) {
> +                break;
> +            }
> +            *(pnv_spi_xfer_buffer_write_ptr(rsp_payload, rsp_payload->len, 1)) =
> +                    (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
> +        }
> +    }
> +    if (rsp_payload != NULL) {
> +        spi_response(s, s->N1_bits, rsp_payload);
> +    }
> +}

Coverity reports:

>>>     CID 1558831:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "rsp_payload" going out of scope leaks the storage it points to.


rsp_payload should be freed.

Thanks,

C.



