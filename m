Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD01E69160
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 19:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXm0g-0004Ik-9i; Mon, 22 Dec 2025 14:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXm0a-0004Ho-Nm
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:55:58 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXm0Z-000600-9F
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766433352; x=1767038152; i=deller@gmx.de;
 bh=18yACD8TFft2W2W0JWvbNhPyu3CqmNWrhDKLZ5M7Zdo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=d4cJBooQDP6/iitU4w8KnSlKlUabe3V8G8Pr3swhVksqaFJg8fWv2dZtyxtCcCLJ
 QJwoJeojUk4+k3Rny4Jv5FyfLC2r4yv6BXSnmap1PyLj7vVO3bRIhWgnocrnSOgwt
 E3wQCChviEcsE3eb9kcgl/ihRung41ROBT+xXVM9KAqMHd/WFhg29RDQHVTWTZwAI
 gxfF4jQ+ZMk50PwqEzCNoFvpNyYxUUwqbxkiKHdu9zaVUETsWSzpYSZuvp7Jrei1H
 f4BSMFiaTBsjzmxsomHDJUhZ6Fie/GTtLUdBVwCSwJR1GAk1j/FlUR19IZ4nC9Pvz
 xsr6iBgk+sVrCN55BQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.229]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mBQ-1vwyw82w0K-010KUE; Mon, 22
 Dec 2025 20:55:52 +0100
Message-ID: <d938b581-efc0-4c6d-8670-a739b704474c@gmx.de>
Date: Mon, 22 Dec 2025 20:55:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] scsi:ncr710: Fix table indirect addressing
 endianness
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 qemu-devel@nongnu.org, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
 <20251221142317.266293-6-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251221142317.266293-6-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:boYdX5TNFFhW0A0lG7VhnHjmo2QqrHchcVepaQnchgnAebz2z8+
 lSSrBN0Vs5ixoqGrxRVuOtPzXEkzyUmt/l+waAssY3y8DHS1OmNZfRcg3Psk2t4EedJoW8T
 FH2a0SRM6TwKz6f1DdzE2QJ2hzUTfLQSC/XxS6BNRVo6EffAypsqL6QD4J2G+w1wiM82poj
 +rRFx0hk4nvGnmMY4xgjg==
UI-OutboundReport: notjunk:1;M01:P0:YMe6Q0LbxAk=;4tXrzNIbHWH82etPjyR48SSq8J0
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
> Correct the endianness conversion for table indirect addressing
> Now we use be32_to_cpu() instead of cpu_to_le32()
>=20
> This fix descriptor table parsing when using indirect
> addressing modes in SCRIPTS
>=20
> Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>


Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>   hw/scsi/ncr53c710.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

