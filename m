Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C257EC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 11:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPhPE-000881-NM; Fri, 05 Jul 2024 07:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sPhP7-00087M-U2
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:47:08 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sPhOx-0000BV-3j
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:46:59 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7523f0870cso177657766b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 04:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720180013; x=1720784813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJW869YmlCIAYzX0Hbf3XJ2muKOBcrbLR8ldy6V+obI=;
 b=IjpOoeBdaQF9REKC8tNHhKQWbwavcp0O3ePlSihnzE66L+vK2/vrBdEULIFmqaH5DY
 UVPTeMXR23NCxTDBDNTHd6L0atw7GStYiCHBBfbfAUnZF5iF/rGKLqpE3WQ5fOq2nE3U
 3rba7H6l0TT8x9fiRTMpR+zWT0P1KjtXDWL4phkFynt9I6sg3HseNm2Anpe8/cNAH9eC
 y81I1YxBRqJTA2JuXTcnHoUqIrwsKq9VjKkXA8QXAWDRNjQtWViZGbRLwJHlJE7u2Ato
 1k3MjNg3oBSvqJAbck1KARKcX8DY1Wd8cTfSuEvbOfw5zJkIFMB4OA8+qx6qV8qkCQFF
 nxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720180013; x=1720784813;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJW869YmlCIAYzX0Hbf3XJ2muKOBcrbLR8ldy6V+obI=;
 b=MmAWP73XiHIIzufba+VOo5N+pL0pkEVJ1E1ThWbl5vAmDzu8S9FIf/RHnslPhcAwew
 kwahvJbOc6/fRFDn/nBuUbkjRz8YX59C3NtxnGH9b3H6pVT+R1mEKJNd8LLPmRMaMowT
 xunFqhubbtVl7YrfOfv+T7g6SZGV2hr5sa6yfSTQsMQxRKpzZzqRk6Pg1bSDao1rFXdM
 nMuue6nLhCM7DfCfrAsA0+Hlo1UInn9GLPSQiAxFPg424wFp+glbDe3sJoHM5NbPa73w
 lt0tw11uH4Ci3kaE4eMtx36pWlGeJQjdY3D9OJyXELZVElIF7xsH5xfxa4ssNrRecFMu
 RW5A==
X-Gm-Message-State: AOJu0Yw6s27iUDsgJbAQvAT8oZhazdn2ikwcivpASk6YGzrVdCYzp3f3
 JaXOykyEm9tiiE3Ba2rg3uNdvgsgQTXTvLldRdo/biEG1FdDvkvC
X-Google-Smtp-Source: AGHT+IEz2sSKO0imGVQXzy0apbO11a9Tl4uIyMDK8Hb9FZ2OL1+nQ59cl7+iKossCcArh6rHGJnQXQ==
X-Received: by 2002:a17:906:58f:b0:a6f:badc:8d2 with SMTP id
 a640c23a62f3a-a77ba7223eamr299633166b.70.1720180012923; 
 Fri, 05 Jul 2024 04:46:52 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-230-110.77.191.pool.telefonica.de.
 [77.191.230.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77abd2a82asm169625466b.214.2024.07.05.04.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 04:46:52 -0700 (PDT)
Date: Fri, 05 Jul 2024 11:46:49 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPULL_17/20=5D_target/arm=3A_Do_memory_typ?=
 =?US-ASCII?Q?e_alignment_check_when_translation_disabled?=
In-Reply-To: <5E575AFE-7E8F-4CEA-999E-30D9881104A8@gmail.com>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
 <C875173E-4B5B-4F71-8CF4-4325F7AB7629@gmail.com>
 <72ED7A80-9EA7-4FF6-BE29-9583587985C7@gmail.com>
 <f6976b40-e3d5-4157-8597-ce7db6ceb068@linaro.org>
 <CAFEAcA-BD1TmaBB_5ephnRoNsOCWsS4w3C_oj0P_182+fOLPUQ@mail.gmail.com>
 <C27AC9E0-AB61-483E-BF07-B435AABE3D13@gmail.com>
 <b871bf81-ed1a-4720-ae70-9dbc517f155e@linaro.org>
 <5E575AFE-7E8F-4CEA-999E-30D9881104A8@gmail.com>
Message-ID: <FC32203C-AD71-4032-9219-9CACB8AB36FE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 27=2E Mai 2024 17:49:26 UTC schrieb Bernhard Beschow <shentey@gmail=2Ec=
om>:
>
>
>Am 27=2E Mai 2024 16:20:44 UTC schrieb Richard Henderson <richard=2Ehende=
rson@linaro=2Eorg>:
>>On 5/27/24 08:29, Bernhard Beschow wrote:
>>> I think the kernel's output indicates that the MMU is active:
>>>=20
>>>    [7e849b05] *pgd=3D2c552831, *pte=3D109eb34f, *ppte=3D109eb83f
>>>=20
>>> AFAIU, the value in brackets is a virtual address while the pte's are =
physical ones=2E Furthermore, the `info mtree` QMP command tells that the p=
hysical addresses are RAM addresses:
>>>=20
>>>    0000000010000000-000000002fffffff (prio 0, ram): sabrelite=2Eram
>>>=20
>>> So I think we can conclude this to be "normal memory" to speak in ARM =
terms=2E
>>
>>Normal and Device are attributes on the page table entry=2E
>>See section G5=2E7 Memory region attributes in the Arm ARM=2E
>>
>>But it's unlikely that the Linux kernel has messed this up, even back in=
 4=2Ex days=2E
>>
>>If you want to make any progress, you'll have to share a test case=2E
>
>It's a proprietary guest, so I need to strip it down first=2E This may ta=
ke some time=2E Thanks for yor feedbak so far!

I finally had some time to look deeper into it=2E While this patch trigger=
ed alignment issues, it is not the culprit=2E The culprit is that the sabre=
lite board sets arm_boot_info::secure_boot =3D true which causes the Linux =
kernel to run in EL3 mode where hardware alignment fixing is apparently not=
 performed=2E Setting it to false fixes all problems and the guest boots ju=
st fine=2E

Question: Does it make sense to ignore the secure_boot flag on direct kern=
el boot? If not, what do you suggest?

Thanks,
Bernhard

>
>Best regards,
>Bernhard
>>
>>
>>r~

