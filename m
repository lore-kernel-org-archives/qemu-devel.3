Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B0FCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 23:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKlrr-0004ed-1B; Wed, 06 May 2026 19:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wKlrp-0004dy-6o
 for qemu-devel@nongnu.org; Wed, 06 May 2026 19:41:25 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wKlrn-0004h1-Lb
 for qemu-devel@nongnu.org; Wed, 06 May 2026 19:41:24 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bc264a50e7fso42793066b.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 16:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778110882; cv=none;
 d=google.com; s=arc-20240605;
 b=JuEAZKwvkrtIXXa1mZkbW0w+XNq0epkoxv7ufP9+d3oVxljr13m07Ncizkh5vSqK6B
 9fauwCU6KGFJtEFchWG3oZn/F4uvTWeCX7Ejum4ltxw3VNS8fwwVMMN0g8D8JNFQm75X
 zDx7AWQwmhNe8+Z3ug8on0sG3O57EjnRuynRPBTYv0Mfj8O7uZRVutUOhrQvX2Hq1GAz
 dssDBs5bjVIJu70hQF0oYl6hG937FTpaKtEVYh/QGXrgprb+L8T0X1z+Cvn+3aIkFV2r
 9x3lYyRVFwsO30VDYB1S1Xnz4z3OgPzHjdBImNmpug3jab5Ef9i0fLCOpZwd1iBmNLwu
 yWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3oyT2/4Uedr1lTR+vpIpFn+MNKivgv+FApmgRdq0U3A=;
 fh=X6JgSI5cWW67MkRiou9w6CwoJEitt2kCPfXIEVFWsOM=;
 b=DIZAhzNm+SYATAcID5jO9NtDCakmi1xDgJDOlScphw2L1q5hCdX9cpq9u876Ct4DEb
 iAWA80LTSCI1A/crXWe9fe2Fw1eMsaS0MjDlnGcv3b6wIChe82iNnxAr6GbEvBrN7oiB
 9lP7fEEHpX13lNeSeolRr5KpwqH5y3T3vSZDtuqjPE4AP7c0kOFluhl1Tc6I5n16s49U
 ynl7TUrrP2KwwS8FdG141ysKuyJygGYPJSwARdlpgm6BUwR/fx9C4h53ETkV2uH+Rnpa
 DIGJsr6uWtjOX7iElUKrX6iGpuUkPlvdkmCufTrv1r8QsSNYa/Nd30g+75tgBvkAm+AK
 opIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778110882; x=1778715682; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3oyT2/4Uedr1lTR+vpIpFn+MNKivgv+FApmgRdq0U3A=;
 b=L5gPIM7tIZ86qGDSmyYqrQGXybaVxvpf53sUlASYRRyW3NRaCx4ncMOEPyC8bwPOEv
 ArSkt2vw0VGOFrOcvvQZd9Gf2enMRwL4cKF4j7zvMtWflawYr+g3RBXfJkAD6J9LR0L5
 JvvD7SnSdiMwXwHaWkFUWLNlFe+iK/u83PgyY76PkyiAGHZIR394spuLnaE/hmo1lKmI
 Wlwkn4FCkmv7kemxwSdqD/CFvPuxlAxB+aXy7e7AUwGTkuy+LHNEapfo6JQPLSwRIG1E
 7FbBz1J8990TQ6LrBv4xWL/BCNeV/czh0zqLpfFgMnHBxc30grHt2tJTv8ZOnNGjnxk+
 WDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778110882; x=1778715682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3oyT2/4Uedr1lTR+vpIpFn+MNKivgv+FApmgRdq0U3A=;
 b=Wf0qZyAuJPAmofrNM7MFShNU5YMy0/7+CP8CBM2fQKWg+/8Bf6OUp1fhdPdJv3zmrD
 db/4FIHhulvfhmdsYWk4t1DJYgPeWXNT81Rt5VvTT4Jydgl9ggXjly2uoCacvAcVFXV5
 jlErQusUB47ZTm1VmJILE9Wn2i8bqmntJpWleDk7y7DmaHoRTBHza5LYWmKe6TWl6Cql
 ngrUHYPzF82FduoD6ikcJisoE0aeERAurJphpoattzc8I6dZy2V6o66KVbF77okCaaam
 ZjBNegbrgIrmvzInE9H3iJT6bBiJwt8kJfYXI2biF4Eua2Kwmv4a5ooKY5vms/tfbt5V
 HuAw==
X-Gm-Message-State: AOJu0Yxox7zC1fjPOkUyhH8Cx6YQN8sAYLppWNZbdbZfvi8lAvAYGxwG
 ewZqIUZcuEdzbIEWRYbaL0n0smi6F0AvXfSqlcSmri7iZC6folbN/5GjTBSlXif4AVRT0OQkyLJ
 oQrsJVH9M1Vnr2+SekI0/mlV2XCBN3S4=
X-Gm-Gg: AeBDiesAFxSSeK2M49BNf7dNwEI+jJX7KFV6PBMNo8KNPBjXD2W6Jzq0OFzw0IPtZEE
 ON4e7aYyLY0qwqoRXYi7pjVPU6S16JVe9ZDSpj31QQ5rJVObtXWGfWH4F46XFp2jz2miRXGvWps
 BsNhiYbNUSzvcQik5uCWemO8w9eR4NisE5xPOf968HMGKtdGM8d7NvCK6dPRqNdgd2N/1znjV6Q
 6BAo05YAVL6YgUhAX8mE0unXFm24sewCWMwld5k89rZpoZt1USXOKtfwDs7OJIWoBwuJhG2ixRB
 JwsWDl0e6EgnkvmQuYpoIiz+U57v8ocDE5ZjzGCpRiw5/Wjd
X-Received: by 2002:a17:907:3c83:b0:bad:52bd:8764 with SMTP id
 a640c23a62f3a-bc56e3175eamr341389966b.24.1778110881778; Wed, 06 May 2026
 16:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <87y0hwbvbp.fsf@pond.sub.org>
In-Reply-To: <87y0hwbvbp.fsf@pond.sub.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 May 2026 09:40:55 +1000
X-Gm-Features: AVHnY4Jkh1y7GMZ9g22mQk4ezJrPPwcD5gRmQDa1uaZYuXcgURUa-qKVT2r1m1o
Message-ID: <CAKmqyKMC0jxMMV0RuPHZrwBbsAeHhOvM+Ak_+=hGgM1C8eeUxA@mail.gmail.com>
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
To: Markus Armbruster <armbru@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Guenter Roeck <linux@roeck-us.net>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-block@nongnu.org, integration@gluster.org, 
 Zhao Liu <zhao1.liu@intel.com>, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Mark Kanda <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, 
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 6, 2026 at 10:03=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> I'm cc'ing reviewers and lists mentioned below, and frequent
> contributors to MAINTAINERS.
>
> There are a number of MAINTAINERS entries with S: other than "Orphan"
> without M:
>
>     $ awk '/^M: / { m++ } /^S: / { s=3D$2 } /^$/ && s { if (!m && s !=3D =
"Orphan") print t; m=3D0; s=3D""; getline; t=3DFILENAME ":" FNR ": " $0; ne=
xt }' MAINTAINERS
>     MAINTAINERS:1736: Microchip PolarFire SoC Icicle Kit

Conor, Sebastian and Guenter, are you still using the Microchip
PolarFire SoC Icicle Kit? We currently don't have a maintainer for it.
I'm tempted to deprecate it, as I thought it didn't really work
anyway, but I wasn't sure.

So is anyone using it and is anyone willing to maintain it?

>     MAINTAINERS:1792: SH4 Machines
>     MAINTAINERS:2022: Machine core
>     MAINTAINERS:2226: ACPI/HEST/GHES/ARM processor CPER
>     MAINTAINERS:2555: vhost-user-scmi
>     MAINTAINERS:2862: XIVE
>     MAINTAINERS:2872: Renesas peripherals
>     MAINTAINERS:3165: CheckPoint and Restart (CPR)
>     MAINTAINERS:3719: Checkpatch
>     MAINTAINERS:3746: RDMA Migration
>     MAINTAINERS:3894: Record/replay
>     MAINTAINERS:4029: OpenSBI Firmware

I'll pickup this one

Alistair

