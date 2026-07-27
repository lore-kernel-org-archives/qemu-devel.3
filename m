Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A67C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woOGq-00048x-Mh; Mon, 27 Jul 2026 12:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1woOGo-00048V-L8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:33:38 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1woOGm-0002kb-QW
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785170009; x=1785774809; i=deller@gmx.de;
 bh=F7QzoEZjBaVflQlojpawKUBYYR62Bg9wMon5adI7mIg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cTv/9fMBKo995ww+SPr2tGKtvqWKbneKIgTTfOLbrrd4D1kre1McO9ei6K41hFqz
 1hFGSrZsYSbSJMkND//WC9bTEg+Ncv9JO9zYEnoei211S0uU/fg9bwaGOZrJVzxKG
 opd2ZCPn78cuqSVxj27E77cEMSbRW0DJQKy4VfeSCbZ9D8ANA6yZ9MGd3OSVXYkkL
 dfWKbyRy7izN9usjAn1/bmAewicm3Ax8fuLjqAcwwo2epCo7v/cA6JtTj6N1idSkN
 qioz1hZSNzCOKMRdJXPIkQqGTd8/CH1vNITudoUnsfdo7H+xuQyTZo2DSjNMHx4It
 msbv3RhgUX/1pOzklA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1wxyfk1fgb-017reE; Mon, 27
 Jul 2026 18:33:29 +0200
Message-ID: <bf1884d4-8503-4e77-b158-112adcb63bfe@gmx.de>
Date: Mon, 27 Jul 2026 18:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: fix guards for the fsmount(2) syscall
 series
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260727160656.2821120-1-mattst88@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260727160656.2821120-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5SkyRWJidVL84tA87Rb1paUfHIxQlzotmyvMCnjm4DKuBZa4Tm9
 RGb73IRrJBknewssifmPZHDgEJ0/Q0pkXWFZBYMCDFAxoKPjI8e0kxu6H/K4RB5q7gLMul4
 hxSJgQtzjQEreKs/JFPtWzQ0eFmf3nSUvkdm+jZoa+S9u3RqC9gZMis7MY4MGtmmAFu+bLC
 LY/AqOt7ti6KmjJbqi4uQ==
UI-OutboundReport: notjunk:1;M01:P0:gY5lveWfxik=;54KUaBsxIGc4XQ7WmSy6cmaDD0l
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Matt,

On 7/27/26 18:06, Matt Turner wrote:
> The fsopen(), fsconfig(), fsmount() and fspick() implementations are
> guarded by defined(NR_fsopen) rather than defined(__NR_fsopen). No such
> macro exists, so the guard is never true and the entire series compiles
> out. Guests calling any of the four get -ENOSYS, which for example makes
> systemd's credential setup fail with EXIT_CREDENTIALS for most units.
>=20
> The strace bits for fsconfig() have the same typo.
>=20
> Fixes: 767c32fe6983 ("linux-user: implement fsmount(2) series of syscall=
s")
> Fixes: 6e0aa9f6c731 ("linux-user/strace: add fsmount series of syscalls"=
)
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   linux-user/strace.c    | 2 +-
>   linux-user/strace.list | 2 +-
>   linux-user/syscall.c   | 4 ++--
>   3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git ./linux-user/strace.c ./linux-user/strace.c
> index 3a81cc95f4..af1cf9548a 100644
> --- ./linux-user/strace.c
> +++ ./linux-user/strace.c
> @@ -4344,7 +4344,7 @@ print_statx(CPUArchState *cpu_env, const struct sy=
scallname *name,
>   }
>   #endif
>  =20
> -#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
> +#if defined(TARGET_NR_fsconfig) && defined(__NR_fsconfig)

That's basically already what I had in my pull request, nevertheless
the build failed as Stefan reported:
https://gitlab.com/qemu-project/qemu/-/jobs/15553379213#L2358

I can try to check later today or tomorrow, unless you find the
cause earlier than me...

Helge

