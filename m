Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8D1E6ADE7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 20:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXmg3-000797-99; Mon, 22 Dec 2025 15:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXmg2-00078z-20
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:38:46 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXmg0-0007PR-I9
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766435921; x=1767040721; i=deller@gmx.de;
 bh=uZoujtJD4n2N42eC9PR/YDfOIxXg0VX7nvaMBYKav58=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hsCUKROs+ziQHMB4y4rsK/H/0oxhDvrt9VdhMakLiikRLRGwCBSF41506V9slI57
 eeY717Nzsp/emhqwW1lscRcw2rKZmsw35Kov6vzoNWKepU/ttpXEzLKYvcV1pJMHN
 zxNE/oLmlwMJTOz/EaxOK10EWTer7LSA5FYDa5U+K8NwlTFFYeCPK2pj2aqGzlDwI
 +gwcCW0Ig+kRuuiKKB3q6KIOBaMd9GUAsAldXIAp/cqCMp/xWVBFXRIfFuwcEGJoF
 OOHCbqlS8oCwXdCoiKaR8VDy94p2R0u03ErrZN+CundTLbtFGgV+LM02zQh0Do+8D
 2JN5w6lZMsX1KTSKcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.229]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zFj-1w2m5y2xP9-017lZ9; Mon, 22
 Dec 2025 21:38:41 +0100
Message-ID: <24783330-0970-4d44-81c0-8896313b9c82@gmx.de>
Date: Mon, 22 Dec 2025 21:38:41 +0100
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
X-Provags-ID: V03:K1:7u6cQ0Wfwt5sHMEOZEcm24O1OLubAECuWZ1slhuodA0Za4+2qBB
 LklLbyRuF8//1rtYtZC2/oTDAEErIABjeQXI0PuGHGbg3xekNzJ9OyOgh9sizT6ldrZOTvC
 VUh2Uqz7gjPp3A1PUEchcQ/iFNv0Dvuxg9d93lrYmfeZgpycvfhyNX7MfYcrX+PCX4DI4Qf
 zWZfNo7Nhc7x2pzrRI6DQ==
UI-OutboundReport: notjunk:1;M01:P0:Hq9xeT6ZC0s=;edBtFOVwlFV6Zyx2zD3tpwwYHGI
 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
 DyHUyiSCE03SJ3R+p2AKVDqt/cIJY
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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

Tested-by: Helge Deller <deller@gmx.de>


