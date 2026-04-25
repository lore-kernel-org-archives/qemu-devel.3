Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8C4FF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 15:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGell-0002fO-Lr; Sat, 25 Apr 2026 11:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wGelL-0002dL-Gr
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:17:55 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wGelI-0005U3-CZ
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777130250; x=1777735050; i=deller@gmx.de;
 bh=YQ637Yk5VvZWDGH8C9Jgv9u3g8Usi7X5GwT/yxWCHPQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FEK8U/edI8GX9/Awr08Vh649/TQOjS3wSWKclaXv49+endID/HyeQzGQFWISfouB
 csipFwm+Hw8xM1Tm7up9DES0hb5BnY/IXgFxWD1Pjb3gzJnAewTSk/mD8RM1OgAAe
 x8tJA/WW1rqhOSNZo8FMBY/kjx5L7E5uM+RP4tC7V/QaS1st+8k15c2vN4Mr8zhnZ
 OYK/ddv1CfjissI7W5HJgi6oQrCCak7ur3CXbgIXvsbJYZZFVz07LAe2bNk61MyzW
 aIMYv1sBaivwETnr0mW/jBnBki6XJbGG+Bp4J2gL40jeHn9x63tehCSSfFW1UQSdU
 Yt1StLk674jJxFcYWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlTC-1vY0cO3CIo-00f7CO; Sat, 25
 Apr 2026 17:17:30 +0200
Message-ID: <d54586b6-8213-48e7-9e7e-2c966948872d@gmx.de>
Date: Sat, 25 Apr 2026 17:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Flush errors by using exit() instead of
 _exit() in error path
To: Warner Losh <imp@bsdimp.com>, Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260425144852.46590-1-deller@kernel.org>
 <CANCZdfoOPvn0JJiF5Nar_UNEWMzmQCvEiTKV1vbuVFy2qiMpfQ@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CANCZdfoOPvn0JJiF5Nar_UNEWMzmQCvEiTKV1vbuVFy2qiMpfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aKB70iIy+mnCNpMDqIjlw3wY1R4fY4Qu4G16UbxNUqiHTLBebCT
 39lpZFWaF1UgIrIrzQUZr/DgDfgXFK09mjcjUJ8COlmZL/ANVA6ZYGweIK4Jaxt8bnAnpYT
 VUttQes+eLOnlMLjC+QojTFGaL/4x/dw2kj1SNVWrERp9jqlk9oGWQFypLVPgZAb1eVdTM8
 /aWsTGfuhQSRaRn8XiUIQ==
UI-OutboundReport: notjunk:1;M01:P0:vzECafbiO0I=;bZB3ONAlSbcC9B7YTAThHKA56Yz
 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
 GmrCYLSa5IbQsp+AQBYHqwjvOF8K990uCwzg=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/25/26 17:02, Warner Losh wrote:
>=20
>=20
> On Sat, Apr 25, 2026 at 8:50=E2=80=AFAM Helge Deller <deller@kernel.org =
<mailto:deller@kernel.org>> wrote:
>=20
>     From: Helge Deller <deller@gmx.de <mailto:deller@gmx.de>>
>=20
>     Qemu user mode does not properly flushes error messages related to b=
ad
>     arguments when exiting (at least when the output is piped to a file
>     instead of running on a terminal).
>     Ensure that we always flush by using exit() instead of _exit().
>=20
>     Reported by: Tobias Bergkvist
>     Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2544 <ht=
tps://gitlab.com/qemu-project/qemu/-/work_items/2544>
>     Signed-off-by: Helge Deller <deller@gmx.de <mailto:deller@gmx.de>>
>     ---
>      =C2=A0linux-user/main.c | 2 +-
>      =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
>=20
> Reviewed-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>

Thanks!
 =20
> Note: I've added the linux-user maintainers to the CC list for visibilit=
y.=20

Ok.

> bsd-user has the same problem.
I hesitate to change things I don't not test at all :-(
Even this patch here is not widely tested, but I think we need to add it.
If things break we see reports anyway.

Helge

