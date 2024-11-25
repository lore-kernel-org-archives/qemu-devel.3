Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC65D58094
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 12:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFYLk-0008Fg-63; Mon, 25 Nov 2024 07:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFYLf-0008Ey-9Z; Mon, 25 Nov 2024 07:37:51 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFYLd-00069G-QE; Mon, 25 Nov 2024 07:37:51 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-212776d6449so47261955ad.1; 
 Mon, 25 Nov 2024 04:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732538267; x=1733143067; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5W1qTOBYUQet13FtB0D0yLiFF8HatBm5KD8hCvnFtg=;
 b=aQyjiuO3IVQ3CTwXlZwYTj0UDi/U/9ygTCVb7uCWWHTA8Ou44w0+gFSEM1xQPsoLCI
 hWUz2krQFWS5IqBNrMdXE1GaYIBS7idq2E9c8AXNuYlTLqex/TnqEhUqykZpebgGoZkj
 HFK+kY5mdGNiC1GJ8QMsiKBQ7MMJPTZOW05ZwCb2LgDMKvaBXzDR0GkvKqo+Ma/97leY
 w7vnpgeCsdeOkwPnW622pVCEYwGYD66YSWFGuwPt7Ez9OAcPNihOkpLlWU69Uu5A15U7
 8s5b6l9b5FGT8Ydk7QRPOtwlNXCdBs7fhcCGcN1oTgtT2aRLmwqN/U2qJW/4flko/yub
 yKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732538267; x=1733143067;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U5W1qTOBYUQet13FtB0D0yLiFF8HatBm5KD8hCvnFtg=;
 b=UA+KUbKymgZ7wqnE6iTPtfijHtlE25c4PyoqgW8VUQQnMIZOOUrHc50KpjPgSE8qwD
 VpW1MEzJirvWVGvqd7L7U5mJAaxzKHZ1z/23L5+BT7urewNsU2zw5rqZmD6FAzfDcakO
 iJIgfyD1HZKzQS0IRaxGfjtDWvotSGhvBgDnkGa0Jms7HnIAuQWNRol2k3qaxfce5/Jd
 znUucigq+psSKJFUVNOa73xvrMYtF6Ao7bxmj5tpqNlEhl4Kyi4bkO9N6WiCzp00neDO
 C6BeEHsyflkz3DKe/6bzVrUAp7Rzs9pFAeq6F8z1cspsHU8JuKxaKHZNsVUKidt5QCrC
 4sgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYR5l6Kvt1kL31HqK8RUZdgw0UaKPi8hbClvJS1uuAltaETDuqVyjWzrQhTa7bQd+MpYG8ijCobKc=@nongnu.org,
 AJvYcCWLNXMnyHYDB5sGnTBaBcb2on7MOsiEzsqN7cziLSWIdWNVXPswV0DZKVBqqguPCYUxtOcvTzDpj2yI@nongnu.org
X-Gm-Message-State: AOJu0Yx4N9Sz8AnYSPSpXlfesmKTP5nYdGOJcqVXQts1en5tACkwJqOc
 zWJ53HcxTugTYhZbwPrJyup599WOFHayZSBg4JEorb+zTQzaAcxWbe4lBg==
X-Gm-Gg: ASbGnctDaznoiXCCpDICitpVXnaowmACsrCZGUZ7FPoBQBj4haib0vPsoStOLXegDGd
 L4MQL/216N55zkmBtU0ywNSlTNgAye0yDyn4Ks9WX6M8Jd+ramgtmkxcqjl53ky03G536g3Sky8
 r9AJeO1Qe5zEy9o1bh74Z/F4dC5aZrBH483qiA4CNeOSfGImluFiCUMy23UqRE98/5Z1waG+fUS
 fomCRXU5i8T4Zphgd9B/9ZLtOk+bVGO4dmHyU3qt2hoecFc0+g7Cl91D0eDJIQ2448nFHY=
X-Google-Smtp-Source: AGHT+IE8XQbHfwkIBQSTUTpdAc+m+p55g3KS8iDFk5W3A+yX1NhS64drG94BZBoXZ4BNaG/lA88u2w==
X-Received: by 2002:a17:903:228d:b0:211:f335:aba with SMTP id
 d9443c01a7336-2129f5790edmr215761675ad.31.1732538265396; 
 Mon, 25 Nov 2024 04:37:45 -0800 (PST)
Received: from localhost (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dbfa6ebsm63352785ad.144.2024.11.25.04.37.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 04:37:44 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Nov 2024 22:37:40 +1000
Message-Id: <D5V9K11FTTVF.Z46ZIKO60UU7@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
Cc: <anushree.mathur@linux.vnet.ibm.com>
Subject: Re: [PATCH] ppc/spapr: fix drc index mismatch for partially enabled
 vcpus
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.18.2
References: <20241119090849.1335829-1-harshpb@linux.ibm.com>
In-Reply-To: <20241119090849.1335829-1-harshpb@linux.ibm.com>
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

On Tue Nov 19, 2024 at 7:08 PM AEST, Harsh Prateek Bora wrote:
> In case when vcpus are explicitly enabled/disabled in a non-consecutive
> order within a libvirt xml, it results in a drc index mismatch during
> vcpu hotplug later because the existing logic uses vcpu id to derive the
> corresponding drc index which is not correct. Use env->core_index to
> derive a vcpu's drc index as appropriate to fix this issue.
>
> For ex, for the given libvirt xml config:
>   <vcpus>
>     <vcpu id=3D'0' enabled=3D'yes' hotpluggable=3D'no'/>
>     <vcpu id=3D'1' enabled=3D'yes' hotpluggable=3D'yes'/>
>     <vcpu id=3D'2' enabled=3D'no' hotpluggable=3D'yes'/>
>     <vcpu id=3D'3' enabled=3D'yes' hotpluggable=3D'yes'/>
>     <vcpu id=3D'4' enabled=3D'no' hotpluggable=3D'yes'/>
>     <vcpu id=3D'5' enabled=3D'yes' hotpluggable=3D'yes'/>
>     <vcpu id=3D'6' enabled=3D'no' hotpluggable=3D'yes'/>
>     <vcpu id=3D'7' enabled=3D'no' hotpluggable=3D'yes'/>
>   </vcpus>
>
> We see below error on guest console with "virsh setvcpus <domain> 5" :
>
> pseries-hotplug-cpu: CPU with drc index 10000002 already exists
>
> This patch fixes the issue by using correct drc index for explicitly
> enabled vcpus during init.
>
> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5c02037c56..0d4efaa0c0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -701,7 +701,7 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int=
 offset,
>      uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
>      int i;
> =20
> -    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index);
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, env->core_index);
>      if (drc) {
>          drc_index =3D spapr_drc_index(drc);
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_inde=
x)));


