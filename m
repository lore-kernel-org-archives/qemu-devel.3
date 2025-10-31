Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C317CCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 16:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vErh5-0006Uk-KP; Fri, 31 Oct 2025 12:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vErgv-0006Tw-2r
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:09:29 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vErgo-0007yp-UU
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761926940; x=1762531740; i=deller@gmx.de;
 bh=Ul0S5KmfSx2cZ5Uk8fa6Xnu7hUOYRMuqyZkHdjHt6uk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=avxpvAu9fvhNFD92tIKiZAaX9dSdqUSl5b4WFMTgJMji9rOkQ0m6hbupYm+tfa7P
 vC8BasxxBpqE40tN62ZR0G20SVAyWgjH4OgXCSv336GnZu2oncznr3JLgDrwd6Usv
 YYlal7XYWKKB7bauJLwopMa2tx4F0VIXsIh1K+7cDmk+zbehTeYJY5ezHBIjSzlex
 LEmiM3JnRDB5TZD++L1GtXrPylt0mouLzQpgV/05LrhG5HkGaJR+BmG4CDSJ/KZxe
 YZd+uG2XfYvyCOqp5UQYEuzAwTAb6zuKtZ/i50yo/a4JRBJaJMj2tEft+I21gaFio
 0lPTFmZkTRhLmErJLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.214]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1w6XjT3Y9k-00z7CT; Fri, 31
 Oct 2025 17:08:59 +0100
Message-ID: <35addd9c-9e82-4972-89e9-a911f8e43e4f@gmx.de>
Date: Fri, 31 Oct 2025 17:08:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi/ncr710: Fix null pointer dereference in
 `ncr710_transfer_data`
To: zhaoguohan_salmon@163.com, richard.henderson@linaro.org,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: pbonzini@redhat.com, fam@euphon.net,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
References: <20251031032437.107674-1-zhaoguohan_salmon@163.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251031032437.107674-1-zhaoguohan_salmon@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0VyA4x7qqr5zh7Zd1L1FQuTc4mEF3u2YjxK4+KcgYkBey0ZvyRc
 WjXoVBnsUO7LStjSBOkIeixcDRmdb+scr0g9zpafmZYxI7tqZr+0Lw5bxK/C/OJkHoBf6NO
 KpzGv7Ao3Q2ZW6MuMzXQq8vNMa8x3uhfbm/FpiOC/PuNdlF5bM34F/0nm72ACzZc1mOEbls
 YlpwSJSthYjF5yjSGOsew==
UI-OutboundReport: notjunk:1;M01:P0:puYRjd1vIiY=;K6AuxZlozYuwyKKSmcDe9aT4Pdc
 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
 x2lwy7KuSaRru4gJA=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/31/25 04:24, zhaoguohan_salmon@163.com wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>=20
> Fix a null pointer dereference issue.
>=20
> The code dereferences s->current before checking if it is NULL. Move the
> null check before the dereference to prevent potential crashes.
>=20
> This issue could occur if s->current is NULL when the function reaches
> the "Host adapter (re)connected" path, though this should not normally
> happen during correct operation.
>=20
> Fixes: 9ce93b74cdc0 ("ncr710: Add driver for the NCR 53c710 SCSI chip")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>   hw/scsi/ncr53c710.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
> index ade951b1d107..e479a212bc54 100644
> --- a/hw/scsi/ncr53c710.c
> +++ b/hw/scsi/ncr53c710.c
> @@ -831,14 +831,14 @@ void ncr710_transfer_data(SCSIRequest *req, uint32=
_t len)
>           }
>       }
>  =20
> -    /* Host adapter (re)connected */
> -    s->current->dma_len =3D len;
> -    s->command_complete =3D NCR710_CMD_DATA_READY;

^^
I wonder if you need to keep s->command_complete, and not move it...
Maybe only dma_len needs to be protected?
I added Soumyajyotii to Cc here...


>       if (!s->current) {
>           return;
>       }
>  =20
> +    /* Host adapter (re)connected */
> +    s->current->dma_len =3D len;
> +    s->command_complete =3D NCR710_CMD_DATA_READY;


