Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0CEEA8130
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpprT-0007IL-Am; Tue, 10 Feb 2026 10:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vpprR-0007Fx-70
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:41:09 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vpprO-0002mW-56
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1770738064; x=1771342864; i=deller@gmx.de;
 bh=ujbu75D7nBIMep8XKayKgczulLZVLEcFaTE+suuGuhU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LAhMHG3tQxC3nA2uZcnQR8V3QIKKDaL7pPSp0AS3IAzoDXZrA8XHvoKtkFlJ/jld
 utFL+KqbYAkmS00FxvgPGWHEzUqBCfQq3D78cHsN9Om+LJV0NNwjc51aOZaYKE1VU
 7ktv3aE9GJGU1vPInTBORiYApwZ8TT6PAAMAqoc/5N4vHElNcb74OJweyM2VYYmzk
 3iKFli11y+6xwAruKK+OBgXitbksaaPrQZv6xnNkhJWoGtzdhxuYfvhyXbb/VoFyZ
 Vs7AvMSov/2ne5GAm4+7KmZybUmTVklOh/bUP9dVuzRrc9ZrpLkJgseIlu4ZGdcoV
 tlvFysJjb+EfsiE8Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.36]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDjA-1vx2Cs0C8E-00G1iy; Tue, 10
 Feb 2026 16:41:04 +0100
Message-ID: <3f125fae-e7d1-44d4-af23-4746a384a25d@gmx.de>
Date: Tue, 10 Feb 2026 16:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: properly check flags in openat2
To: Andreas Schwab <schwab@suse.de>,
 "Laurent Vivier (odd fixer:Linux user)" <laurent@vivier.eu>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <mvmpl6d9cgl.fsf@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <mvmpl6d9cgl.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:87VZxLplNivwhjVaQk0hJrHV4XZ81neTzc2Mpx2SC9q5wn1aPgS
 VL6/Cx1GNeY6Ty2HpuUFbmH6AOMg14G5WMmC5Ebl9tdG+4Ids4O60LiXHRnZUm99vAMQRQX
 zacktir4OjUjDLshm1b3NVAeXk9BUvuN9AmZv27rOPTEOYO52Dq+OsVYvPRE3wb+wS+o1Rx
 ehbAZCZgMdAd7LnUm1L1w==
UI-OutboundReport: notjunk:1;M01:P0:qYE3qp0PINs=;GE/uUvZHEUo4xqS7ntQPQaGsfxh
 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
 REs/l5rw=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/10/26 10:26, Andreas Schwab wrote:
> target_to_host_bitmask truncates the bitmask to int.  Check that the upp=
er
> half of the flags do not have any bits set.
>=20
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   linux-user/syscall.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8469b81878..667aea6a03 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8822,6 +8822,10 @@ static int do_openat2(CPUArchState *cpu_env, abi_=
long dirfd,
>           }
>           return ret;
>       }
> +    if (tswap64(how.flags) >> 32) {
> +        return -TARGET_EINVAL;
> +    }

Seems a little hackish. Basically target_to_host_bitmask()
could be extended to handle 64bit values too.
But as long as all values which we test fits into 32-bits,
I think this is a valid patch.

Reviewed-by: Helge Deller <deller@gmx.de>

Helge

> +
>       pathname =3D lock_user_string(guest_pathname);
>       if (!pathname) {
>           return -TARGET_EFAULT;


