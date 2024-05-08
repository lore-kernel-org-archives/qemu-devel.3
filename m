Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E23C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ek4-0003xe-NW; Wed, 08 May 2024 06:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1s4ejn-0003uv-RY; Wed, 08 May 2024 06:41:32 -0400
Received: from fhigh4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1s4ejl-0007Zv-Kp; Wed, 08 May 2024 06:41:27 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 517CA1140231;
 Wed,  8 May 2024 06:41:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Wed, 08 May 2024 06:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1715164883; x=
 1715251283; bh=3F/PzoWHYx383sYOjKPIfA+d+BRmnzK96sLpmGMPkhk=; b=c
 QqoPto/QWDRNkN1YMTEzxfn/IJpTRI9yFyGDQ+ns0FgH9Tj4aFVIMJuKtKx+Lm5R
 o94g1s9sBkCGJ3b84mKJQGaW74HP5mP2XOe/NnNx3pTgXXb5PYGNNGUGYVptWL8Z
 NH2EwwOra0yA2HLukOXQ6oP7c6WRtdWbmLOoOGeSoy5eRJPzxbyruNBCloPfjNtB
 08Lmrmyn3q7zix7EbazynRhlVQ0lVtrGVRuBtl92U+hpMrT6ukOxKXNMC9px7K1M
 WpCJdcH30eVIsSF62ge/pH8SJHxHxfgqnmcaQw978kX3jIBDVAKFKTptVg1njSKR
 i7VqqSVE8ZK1IscW4EUqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1715164883; x=1715251283; bh=3F/PzoWHYx383sYOjKPIfA+d+BRm
 nzK96sLpmGMPkhk=; b=WmFWadnhLq0ms4kDq/t8rygrbLANur5Alr44KR/kFbK8
 CDb4W+hcINu7j4UwJuQfQ5QHlNAbKhO5kJR3WIGDTs0fIlwNT8IS4fAPk2ZpWsTf
 Ys0pzApWeLu80mMdhnijeBghMWkVtgNVLPAyMrwX8zaE8X7RqBmQY9UUpz8Oi5im
 iOVC5uaOzcHS+GBf1zSrQ8APdoY+xlzKHQ0PlsUH3KQr5I/I+np5YTEeqnQwz6lZ
 koiplHNTxASW+55xRFDaTRGlchSpPsVtHVX+POfiGmrNd8u1Rng3LJV6Fr8zOWGi
 psMdcuBd3DKSXboY0hSKJwz1S9Aia7cnCTOxWdi1AQ==
X-ME-Sender: <xms:0VY7Zpn4xusYAKrUkYtTHeVRiWSq2_qV61WniI3p2Jd9EqfAO0a0Qg>
 <xme:0VY7Zk1rE0ocpEIxtxa6YI1N-x9c8lq6qkcusAi4SSiCEQgYan07Z1qj_7o6spq0f
 XQOpnmqv_xjjJX9gXo>
X-ME-Received: <xmr:0VY7Zvo1CKXxt1ct59FZsiJPlASBsGVW_AyEozqc6s2h09kScWZjOoRJmUCS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:0VY7ZpkDWXhrLQiUzrLYlt5yecybj8PkxWOsSvk4qsELqadJdQn2Tg>
 <xmx:0VY7Zn3CcXLatCr3SuFl6KtYfKAw_uuMa_Eb2P4JwxO_ba2YGybfNQ>
 <xmx:0VY7Zou5TiHy991ylTMCrxkZGjdOu0NVLmvl63Im5O9dg4c1zO-zGQ>
 <xmx:0VY7ZrVz-fE5AI5OIQ_rulVC66Uug9-n74mtS_z4FOmEQeM5uRwYrQ>
 <xmx:01Y7Zu2epNpqmpoKPsjZRAqVmXHZ4pk1I1reokqEqZfDG0XT8hyVhPi9>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 06:41:21 -0400 (EDT)
Date: Wed, 8 May 2024 12:41:16 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 8/9] hw/nvme: add reservation protocal command
Message-ID: <ZjtWzNpqwxH9HTbA@cormorant.local>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
 <20240508093629.441057-9-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+PZ5rYTUSfFrT2QG"
Content-Disposition: inline
In-Reply-To: <20240508093629.441057-9-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=103.168.172.155; envelope-from=its@irrelevant.dk;
 helo=fhigh4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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


--+PZ5rYTUSfFrT2QG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May  8 17:36, Changqi Lu wrote:
> Add reservation acquire, reservation register,
> reservation release and reservation report commands
> in the nvme device layer.
>=20
> By introducing these commands, this enables the nvme
> device to perform reservation-related tasks, including
> querying keys, querying reservation status, registering
> reservation keys, initiating and releasing reservations,
> as well as clearing and preempting reservations held by
> other keys.
>=20
> These commands are crucial for management and control of
> shared storage resources in a persistent manner.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/nvme/ctrl.c       | 304 ++++++++++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h       |   4 +
>  include/block/nvme.h |  37 ++++++
>  3 files changed, 344 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..1f881fc44c 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -294,6 +294,10 @@ static const uint32_t nvme_cse_iocs_nvm[256] =3D {
>      [NVME_CMD_COMPARE]              =3D NVME_CMD_EFF_CSUPP,
>      [NVME_CMD_IO_MGMT_RECV]         =3D NVME_CMD_EFF_CSUPP,
>      [NVME_CMD_IO_MGMT_SEND]         =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
> +    [NVME_CMD_RESV_REGISTER]        =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_REPORT]          =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_ACQUIRE]         =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_RELEASE]         =3D NVME_CMD_EFF_CSUPP,
>  };

We need to indicate support for these commands in ONCS, right? And that
should depend on if or not the underlying block device supports it.

--+PZ5rYTUSfFrT2QG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmY7VssACgkQTeGvMW1P
DemDdQf+NHY2fGsC92FWsBPip4Trlspyea1NsGyjeN323k/GWTLYfvNV/OEAQOlV
UWvjy9mItMqQf0cjN4XlciJEMGgtS1Dq32imX8ZX0YJnC/+ADnFdWwCmM9U3bcHY
BadX2aD5E/ggXoHJ3ugy0IWhr4U81OWr3YznEPX8hxix71Me0n6swJ5wGx+v1TTU
BIdr71lGfQPFwXmLF0+Y8aygoZ+Dt1JoSKzN2eku+lSpF1UiF01JpvbVQjXAfeG9
NcU971ytUGk0q2K2ezYA/h5TAu9z3au+ritqELgIAq7N3MnwJ1ehKdkNZ5Fex2s+
7J7EgSQ42BWrbGNej74Z9in5hpmxgA==
=tuuq
-----END PGP SIGNATURE-----

--+PZ5rYTUSfFrT2QG--

