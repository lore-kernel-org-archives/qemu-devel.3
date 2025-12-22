Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2476E69160
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 19:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXm2A-0005HB-IL; Mon, 22 Dec 2025 14:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXm29-0005Ft-A1
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:57:33 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXm27-0006Bz-88
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766433450; x=1767038250; i=deller@gmx.de;
 bh=AfX8fDpAthsMJQfAJ+zSwvs811SvLpj3NXgYVji9utA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=e3KHdmvj+m0udyf+KvCYb6NStGoSn/Io5gWag5ShTdVjMQqIjdBNyuG5WAG/mQFn
 M1PAF7n72klWXQ+2r7BSQeN1K/xOeausE1ieXOWe928Yd//yIYoupE5cNkGw7ae47
 24T63x/DOcNpGJfqWeLq/2vZGfmUSn1nd8gmVRLH3XtDpfNkfM4e0RyhO4ocnuZ/n
 85LIBHmQb+xufu6rTZYfjEhkx3DK7oud8DrgsyePJ0+gh5Dq2TRReF6WaUnmNKTvk
 D5S53z9ZheAa7cnVFPMHPFEq4lXoAlZY3smVBbIuRghuYr1F1tbuSo85eskT8oqM3
 g1WDkSuzG26T9ZQtqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.229]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1ps8-1vVaAj444W-008dYe; Mon, 22
 Dec 2025 20:57:30 +0100
Message-ID: <a92209e2-3e1b-431d-a229-b6ebab0e8cac@gmx.de>
Date: Mon, 22 Dec 2025 20:57:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] scsi:ncr710:Mark command complete in status phase
 and fix disconnect
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 qemu-devel@nongnu.org, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
 <20251221142317.266293-7-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251221142317.266293-7-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mtKtBsoruFnEgVt/AepLDCqFljOsjtcjIPKWwzWF03kRT9nOQwT
 wAoacdJL1fJIvDXOBVxXg5GKquDqJGb03F6VnMxS3ifIkxb8NPXH5ltNoht848gyiBqlEFs
 cYiYyBzalOQLbU46EOxkio1hg/n4CPlNWVq0YPnrr6TfTL/LB+1tdMclH2DHwNf5M6KLr8B
 xcNa4jtiPw8QxV1fHSjcQ==
UI-OutboundReport: notjunk:1;M01:P0:9XQnYc3z23I=;1XighSMWvHO+xmmPm/OdRECtIKc
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
> Set command_complete flag after status_phase and use_phase_clearing,
> instead of full disconnect during message processing
>=20
> Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>


Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>   hw/scsi/ncr53c710.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
> index 4b42fab754..3d7318c12e 100644
> --- a/hw/scsi/ncr53c710.c
> +++ b/hw/scsi/ncr53c710.c
> @@ -997,6 +997,7 @@ static void ncr710_do_status(NCR710State *s)
>       ncr710_set_phase(s, PHASE_MI);
>       s->msg_action =3D NCR710_MSG_ACTION_DISCONNECT;
>       ncr710_add_msg_byte(s, 0); /* COMMAND COMPLETE */
> +    s->command_complete =3D NCR710_CMD_COMPLETE;
>   }
>  =20
>   static void ncr710_do_msgin(NCR710State *s)
> @@ -1041,7 +1042,7 @@ static void ncr710_do_msgin(NCR710State *s)
>           ncr710_set_phase(s, PHASE_CO);
>           break;
>       case NCR710_MSG_ACTION_DISCONNECT:
> -        ncr710_disconnect(s);
> +        s->sstat2 &=3D ~PHASE_MASK;
>           break;
>       case NCR710_MSG_ACTION_DATA_OUT:
>           ncr710_set_phase(s, PHASE_DO);


