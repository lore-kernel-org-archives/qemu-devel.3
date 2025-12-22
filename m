Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D945E69165
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 19:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXlze-0003ee-2U; Mon, 22 Dec 2025 14:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXlzc-0003eH-Nq
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:54:56 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXlzX-0005ez-QI
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766433287; x=1767038087; i=deller@gmx.de;
 bh=AuB9Bdmy19uyCIzsgVxwmBQGSlYveZNikUyS56+Pvog=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lVsfRilLMq6khTJt/OraUm7rO6sBnjna6JkHk9Lqdh3NCk4YZp+uRxMT8kdoUi9V
 e1qsL8yyfFlCUEjzTzLhJwR4KqLVbm7+Hvjd1xuuQ6aCzfZ3bNuxAOrivDYMgCL84
 5Cv0TlDin81lE8uKn5YLxKgfx7muOP6BDWFjpUVuhidoEKUURWNpDPzRy8N0zRQ3x
 U43iNqAOAJDkd/yZ8LrNWGCsrH9F+x2E8sP9RWEBXDJbrHLQnxHhuep633ExmOJz2
 KZrYomFdOF3eB877N5m6NZcN8Pa0yiRYLpahjqyD8hjryzS1BURslLttpZsYSdmru
 eu7fm3iITEDDW0oYhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.229]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O6Y-1vXEYj0vD4-006xYe; Mon, 22
 Dec 2025 20:54:47 +0100
Message-ID: <96eeea97-ac6f-4c04-8738-29575bfa7463@gmx.de>
Date: Mon, 22 Dec 2025 20:54:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] scsi:ncr710: Fix DMA State machine and flow control
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 qemu-devel@nongnu.org, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
 <20251221142317.266293-5-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251221142317.266293-5-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FNGivLMVNR+4Xtw1aLNSUG733oIVMnq/ziBpCWq87gk2Td4h946
 YBXq+bKXsJRJ7ntUdUCQ13T65kKP5xKDdRr2T512vuidQdZwCdhw1jpLwSIwEKhF73YHVZN
 kmDLCX0Qj5xlUgTNS0QbSrm4w4po+gjLmEFnZ4/acsE5jCmYZLYM8i4sTejT2c+jCSTyENn
 5YUVIEwX4VT4POnQVQhVw==
UI-OutboundReport: notjunk:1;M01:P0:/aNuag7dbOg=;r1KlNvUlPqVThmglNdgDiRLXodQ
 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
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/21/25 15:23, Soumyajyotii Ssarkar wrote:
> Set waiting state and return after scsi_req_continue() to prevent
> re entrancy when DMA transfer completes.
>=20
> Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>   hw/scsi/ncr53c710.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
> index 0b7734a129..e17d1f3fb8 100644
> --- a/hw/scsi/ncr53c710.c
> +++ b/hw/scsi/ncr53c710.c
> @@ -718,7 +718,9 @@ static void ncr710_do_dma(NCR710State *s, int out)
>       if (s->current->dma_len =3D=3D 0) {
>           s->current->dma_buf =3D NULL;
>           s->current->pending =3D 0;
> +        s->waiting =3D NCR710_WAIT_DMA;
>           scsi_req_continue(s->current->req);
> +        return;
>       } else {
>           s->current->dma_buf +=3D count;
>           s->waiting =3D NCR710_WAIT_NONE;


