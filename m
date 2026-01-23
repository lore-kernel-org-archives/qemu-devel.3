Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D74DD74ED3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIEM-0000Af-J6; Fri, 23 Jan 2026 09:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vjIDd-0008MA-G5
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:33:08 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vjIDb-0007dn-JI
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1769178775; x=1769783575; i=deller@gmx.de;
 bh=G715eEAi6uuP2kxr4WVZ41qUowhTTwPswEwQSNgCfB0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=D1PkhfpzUF5duYhicE1yKESyRW6+TC2+b9hHkNZUOCHsi0xzEGSvrcpZKswBBjCt
 b7gzJtNbVq5s6zRwBEoOBdFbDXyJI+wD/mJIyTuDF4W5QPPnjz8Quh+witzwAnxSK
 m9AbHgNQAPSaLmBihByvnBo1U5mLEsQxkm20lBIB4eStsIp6/7Stj3Gp1+eOmcxbq
 +jzScFogrbydxq+h6QN3yibQnlXd6j2O8yrW5TaBReqgK6+x8faUdVFpORmrw4SzT
 TWwWa6hlwW+8vPGpJeElVTwU39SgD9+Si75/TqduPy+5CXA+zc4duj2mFTSuJLC8N
 1b/GbzBqZemBCWHMWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.51]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUnp-1vyNI60fkH-00tQbU; Fri, 23
 Jan 2026 15:32:55 +0100
Message-ID: <c332e60e-86ed-47e9-bee6-b71657f9cf5e@gmx.de>
Date: Fri, 23 Jan 2026 15:32:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: look up executable in emulation dir for
 execve syscall
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <mvmtsyixb4m.fsf@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <mvmtsyixb4m.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tKlWWoh9c1AEKGiC4C+EqmFMT++iZ5z7lbNRpiXWNRRL9B6Veik
 vz6556YrMhBj2ITulNs12k5Asr8U65KPQBqepNDdGqBRyauKCLEnRJIBGPMnoc9IGdoRXnO
 lGohOez993ns/2YO8T2vwsu2ELfxjZE/77ntw5Xb5AW5CPgRI85zbyB2qz1ZvO5KyX05i3M
 bUkKlZif0DWCcoS17VEmg==
UI-OutboundReport: notjunk:1;M01:P0:Q9ioHgs43lE=;sv3xtN1ucfQyKYrFHRIaJ/oXOek
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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

Hello Andreas,

could you maybe explain why this is needed?
Did you face a real problem?

Helge

On 11/25/25 18:42, Andreas Schwab wrote:
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   linux-user/syscall.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f7ca155679..e379ddb1b7 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8972,6 +8972,7 @@ static int do_execv(CPUArchState *cpu_env, int dir=
fd,
>       if (is_proc_myself(p, "exe")) {
>           exe =3D exec_path;
>       }
> +    exe =3D path(exe);
>       ret =3D is_execveat
>           ? safe_execveat(dirfd, exe, argp, envp, flags)
>           : safe_execve(exe, argp, envp);


