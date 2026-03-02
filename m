Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F411EEB3632
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 20:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxA6J-0001WE-An; Mon, 02 Mar 2026 15:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vxA6H-0001W5-IH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:42:45 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vxA6F-0005DP-J4
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:42:45 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ae523d54d2so2325ad.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 12:42:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772484158; cv=none;
 d=google.com; s=arc-20240605;
 b=NPeFTYXt/MD8zLTDz6LLoU90XH2MD0LS6Cw3s+tf2NssX3Q6QJN+l7dS79L/6eAlZY
 FzGsqBJSc1cebN5QQFF6RVaJlxBMajsJeFuZxQCNSTIY7K/DqbDlyIJ5BksLrwv39pLZ
 odpG4N3zFbMVsUEaim0nPY0+gfkAEUVoHC7yIW6UXohY2a2emKvPIn+wdZksRuSkVGVq
 gjvc8RN0dXqxijOWY5EeK6q5B6BUPLQnfqXDRPC26sMXOGgoLf+Xpe1D3gA1CdecV1H3
 kXTQGybd+mAPVWMI9HEtP5WRt7K557lPvB3+PAQASvf2LpYc2o9CrSTS3JQhljAQHcee
 SeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NDGO21nGjDwsFOiwIeoaD9qnbdrsIRx49pXQabH6bKg=;
 fh=pCEs+NADVRa4BouSTcHg13rR4xQRttNiwgoKgQmxxt8=;
 b=OhQecqFKd/p+x/9jFnS/KbcutH6nAZv+kW8s7SE20UkgW+Vo+XITRo+RkppMz9TIKk
 aTRToZH17jK/VB9MDibvFRni/8ykoMHj5DRC8h0a4tDh8p/2mB7snwoexCfCWdNrVrNt
 NStliJClZJ8xQKZBNvraomHDeImwzTFytu7Q/JUFjCOEcpIou5ykkrL8nICPeoqzfYvP
 aCh5GfcbjhZbdoGrp4h4DCi2Y58FBT0hyKkHhVFpckXBNgO+ro25PbwJUf6mT956eDRA
 zW5s6ojx6UBLpw25MAAKkMAMpVD0/LNr3aGD5hkQdOCQGVkvtv/nZHbyTkjlvC7d1Nqj
 8oTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772484158; x=1773088958; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDGO21nGjDwsFOiwIeoaD9qnbdrsIRx49pXQabH6bKg=;
 b=wWhbZcKhKfAi1CALPLA8h35xcqJ7kSTeGOUjj3/4fuiKGeJvxXhxsIG5nJvTuMEizU
 afHrWUq8qNgLDXv/jdDl7y4otu3z3hYtkrpWdnOpsmJh41aZ2PrXTRCDWJgWiEjoiPb4
 MBNLfRCfNQWypkKR+7gQ+dj9p+8/oPHxOR1eOQImr/ia+95z5R0aKquA3kpnvENvfz3e
 Sl5f/mIKQ17FiuaeeWSN5qU3S9Opv9NvKV/5KZ6PHHvUTIk78XgdsstmdGOExPdHlCuV
 omG4rkvm1UR7dtn2+71jld8zL4S9Fpbl9oqR8f5fMnE8asNns9VHN/Scts99uqCXd1AQ
 niWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772484158; x=1773088958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NDGO21nGjDwsFOiwIeoaD9qnbdrsIRx49pXQabH6bKg=;
 b=F5FftsYfCX5Hx4FQIUWEIH5IV7gHFgIeMIjM51vPMvMW+ImI5CDWljhzywazqfH5UL
 AwFmrTgGdCglTJwEPgsg08lE+nvkpfxK2j3vMSLJttxiiiCJOArsZkSlfUQ+D88ozCYA
 blWuI5YhxvaT0VGYZv9eLVaUb2xtMsXMU8F63C5B120fdRBTjbAttk2FcKAWtjaLXW25
 CRdc105gdfOalcDGENoa6MlC1mEtkvW70ESAYZ6kG7e3DJK6l/YrtK64shOdMLX142Lk
 iQOEJ1QJJGyMdCIrsTD+4UhoJBHwAb/RC4ikxhLHSfMJ4Y739vRmj5gHKypsnqy+QQeL
 rkVw==
X-Gm-Message-State: AOJu0YxdZkB1DUbcvRocPoZVXsKmNnfv6q4zhSXXLTwDfaNME6zXv/Ve
 wg+FgTBgJ9iLwr+ZqxfGiam1oFAv/8XdaHma2eyQJgsO24GAX1eKi6nb7gLksNrWzPMr3m5Csx9
 KgEcAJSqFzZV6JAV7tiBdOqmvs4mHUod11nKI4tqj
X-Gm-Gg: ATEYQzwaUB289EULF6GI1Hu8Ny0l1PHAsT+0t+aDtkmnRSlUHajI0+nV55Jkx216Pye
 eojHNEisXf7nhsnQzh+wNq8WNusOO/tE4ieV73xtDbnqmmaQZY9mfN357U49e83Q2A162wrBu9K
 iN4LjCNAlqPW1mfI9Sw8P/3nJ/O66nxxHZZsJ3Ecec5mAHhoXR4UgLcNSBJU2EWAZfsMW5B6XXo
 uQy5DCIPhyXJZn6gQdbZ4bYNNC67IPFH2qrAd5JbfZxpsez+rvwMqvHIEMnJsrBiK96azRAXSO1
 aQmjyy2rSbB6AvsTv/0ZkPi6QgLOKgXiDDxfpQlTyk4R7smuIr6F1Yq1wzyQhavjbPR6A6h7qJ8
 c9E96HU+huo3PZxu6l0vCSkrOJ71nI9iBkGeh
X-Received: by 2002:a17:903:fae:b0:2a0:867c:60e2 with SMTP id
 d9443c01a7336-2ae3b5554c6mr4224695ad.19.1772484157858; Mon, 02 Mar 2026
 12:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20260302193931.382228-1-clg@redhat.com>
In-Reply-To: <20260302193931.382228-1-clg@redhat.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 2 Mar 2026 12:42:25 -0800
X-Gm-Features: AaiRm53nltaR3z9EER_xiuFEK1-uoBrR11Jyb9jywqdiKYijI4tz0wmiel6evEs
Message-ID: <CA+QoejUbMDi6NXQtEVzOLxn7MK3eotjg_BseX2nAmPPgyaXo1A@mail.gmail.com>
Subject: Re: [PATCH] hw/i3c: Fix array bounds and storage in i3c_addr_is_rsvd()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Joe Komlodi <komlodi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=nabihestefan@google.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, Mar 2, 2026 at 11:39=E2=80=AFAM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> The size of the is_rsvd lookup table in i3c_addr_is_rsvd() is 255 but
> should be 256 to cover all possible uint8_t address values and avoid
> potential out-of-bounds access.
>
> The array should be static too as it's a constant lookup table.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/i3c/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i3c/core.c b/hw/i3c/core.c
> index 8a37099ce3ff..0a266e00a279 100644
> --- a/hw/i3c/core.c
> +++ b/hw/i3c/core.c
> @@ -525,7 +525,7 @@ int i3c_target_ibi_finish(I3CTarget *t, uint8_t data)
>
>  static bool i3c_addr_is_rsvd(uint8_t addr)
>  {
> -    const bool is_rsvd[255] =3D {
> +    static const bool is_rsvd[256] =3D {

Given that we're using hex addressing for the values in is_rsvd, could
we make the size `0xff` so it maintains the same formatting?
Otherwise, it looks good to me.

Reviewed-by: Nabih Estefan <nabihestefan@google.com>

>          [0x00] =3D true,
>          [0x01] =3D true,
>          [0x02] =3D true,
> --
> 2.53.0
>

