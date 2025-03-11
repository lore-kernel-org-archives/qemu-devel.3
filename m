Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C16C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trv9X-0003yu-1n; Tue, 11 Mar 2025 04:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trv9V-0003yH-9D; Tue, 11 Mar 2025 04:39:53 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trv9S-00051h-AO; Tue, 11 Mar 2025 04:39:52 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22403cbb47fso98360865ad.0; 
 Tue, 11 Mar 2025 01:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741682386; x=1742287186; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a74RCfqnyxLLY7O3SOu428D80/bapQuYWKqPnoc4ZgA=;
 b=A7psM9O2xX+1I/wSyTvKqWgt/9MN/tPdy3k6ST5666Vt/6SUWmYIDNICKh1EVi8ne/
 ttECCz+RvB6IL+JXamNklv46h993eBKXsgk6DLBi1eji8s1VsMyTqurygEsF3VQ7wd7W
 4tGxUq4QPyD0CL1UvJASfGBLH/tNOWKL6MUmJM8wWtJ9eXxfCipWxQFa+c8GTUcaS7e6
 WluS98f8GBeOF5CgXadPxKqMoLXL8GPBFXB7yyu6YrJmxaHd+8Q5ZpV0E5Rwg4fz7Be8
 1TOitTy0YReGIW1ZYtIQ4opSaPNKgNlV2EMvjDd9OMs6euDlg7hyHVc/3RBBhGZT/bFM
 gL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741682386; x=1742287186;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a74RCfqnyxLLY7O3SOu428D80/bapQuYWKqPnoc4ZgA=;
 b=S9r5f/GP241K8ZD6Jos0JQFwop8oCxcm4/yYuDTMeHVMTXhxy15dISCUI+5IsGs/1z
 mAfQAL9gVpIUKwgsm+BNDORu4m+EnXguzcRf1ODBq9orgdaRmXD8vGZYllAn8m4PvgHL
 NyXPb2GRsnzWTbRvYhbAqk0CxWGWbNtAcOZVxF9Kc514UWmbKKj/0O1UgX/658qDKN//
 4VetdpvIF+sFUrFW9JtKxcpSqjoMqFol1RvwR5b9D4iYlfqelu3hiYholRbjVMDZqYci
 nvVMLe0wsrSwcCdzMZdSfNq0ANHxt7bRQdxTiKxHTyb/Gvu74PxscbKPbk2PoVWEHC+x
 HHxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKuwp0eTc3uAwPuv2wR2jQO/67D/LaZC+v8wfZJZjZvQ8wZwZ+pESBkhHXVnxlixDHuD7LWGGd8A==@nongnu.org
X-Gm-Message-State: AOJu0YyFAGdr3SKLLNSLMLEqthOwqgfez8WQZSFxGeoRleJ6/mfaRC3K
 eU5LKtWH3yGT3PLt2lvePVEpixQytOiW/gGcXH9w/QoqQ3gdIy4P
X-Gm-Gg: ASbGncsR4U4k3B7FV9Qpvdsi+nIPsOTu8YRijGK/+EZU8rz9afnIE7Qe3cTwfWmaQUr
 2EJh9VXeW2eeUsb6ThwJGT9yuoawrSEdPkXDRfY0lW4mPsP6w5e2WKxdIGDETDNJto6q3OHqqNZ
 thbxoaS1Hu8T5CuuMlVkgdAg5lyENdGPwKVAcrta+ctwNGFFaBT6+vWHUjOzeYxh67XQc28f9id
 AjVtat3LAe6qmfcCXxCTm8qW+bCiM33Zvc6eBlbtAbApTTTTtt2kfNhTbcQ4SCKgilnoZwxxSj8
 eMP6g9EjekOfjrbgAngEvL2EWw3VPpTo+qt5p8WM
X-Google-Smtp-Source: AGHT+IHb13jyn3rFxlxElZ4Sp9tBl2P6krWJjkbAu6aJ2nIAhVrXWUehj8N0gemRvJIeLD+nYtuUWw==
X-Received: by 2002:a17:902:ce0a:b0:224:1af1:87ed with SMTP id
 d9443c01a7336-22428a8a8e9mr263705665ad.27.1741682386277; 
 Tue, 11 Mar 2025 01:39:46 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109e97d0sm92404465ad.79.2025.03.11.01.39.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 01:39:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Mar 2025 18:39:40 +1000
Message-Id: <D8DAVJVMV52X.240ECM32F54AO@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v5 8/8] ppc/pnv: Update skiboot to support Power11
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Aditya Gupta"
 <adityag@linux.ibm.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>
X-Mailer: aerc 0.19.0
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
 <20250308205141.3219333-9-adityag@linux.ibm.com>
 <f9ea56e0-a104-4acd-a27e-7d2813efe319@kaod.org>
 <094f0623-e483-4097-aca0-9f320b27af1a@linux.ibm.com>
 <04b8c4ce-0a58-4f50-97e4-b1cc30b8b340@kaod.org>
 <d9ca52cd-6afd-4ed2-9e99-76ca5cbf7b80@linux.ibm.com>
 <1d1021e1-c138-42f3-a563-365a22cfd3d9@kaod.org>
In-Reply-To: <1d1021e1-c138-42f3-a563-365a22cfd3d9@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Tue Mar 11, 2025 at 1:33 AM AEST, C=C3=A9dric Le Goater wrote:
> On 3/10/25 15:59, Aditya Gupta wrote:
>> On 10/03/25 17:15, C=C3=A9dric Le Goater wrote:
>>> On 3/10/25 11:31, Aditya Gupta wrote:
>>>>>> <...snip...>
>>>>>> =C2=A0 pc-bios/skiboot.lid | Bin 2527328 -> 2527424 bytes
>>>>>> =C2=A0 1 file changed, 0 insertions(+), 0 deletions(-)
>>>>>
>>>>> This change should come first as a sub maintainer PR, to avoid sendin=
g 2.5MB
>>>>> on the mailing list :/ See how SLOF is handled.
>>>>>
>>>> Sorry didn't know this. I just checked the git log of skiboot.lid and =
thought maybe it's this same way of sending patches.
>>>
>>> For example, see=C2=A0 :
>>>
>>> https://lore.kernel.org/qemu-devel/CACPK8XfoKNxr6_KkDFFZm0P5w9m_ddD5E4S=
euAkypXXr7swR7A@mail.gmail.com/
>>>
>> Thanks for the example C=C3=A9dric. Now I see.
>>=20
>>=20
>>> To be sent before v6.
>>=20
>> Sure, will wait for the maintainer to send it first before v6.
>
> AFAICT, this person would be you or Nick, or one OPAL team member ?

Yes, I kind of butchered the skiboot PR message but no matter.
I was planning to update skiboot bios because it contains HOMER/OCC
fixes we need to test the QEMU updates to those models.

Power11 support is nice too, unfortunately I will skip the P11
patches for now. They will need some updates after the HOMER/OCC
changes but that shouldn't be too hard I can help with it if
needed. I will try to get your P11 in asap next time.

Thanks,
Nick

