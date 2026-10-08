Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF77ECA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEoW3-0004we-DW; Thu, 08 Oct 2026 09:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xEoVt-0004wE-1e
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:50:27 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xEoVr-0005yQ-Ad
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1791467415; x=1792072215; i=deller@gmx.de;
 bh=DCNJzjTGsCL3QCQN+1VWkwgXOauB6Q7EO4M9kJSDkyQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LZ2d/XCoWUensjqBS5Lf4T3RT4fRZFpLFEme/WOdat9mDPrxncm0unW20FCfJ/3b
 gQ+VWgDe9alVC7gJazvtHEdCTWEsC0uxDwII5s5MEirBW1ShzOGiQfWBAjvCOGIKg
 U3LN5ozm1/EEnV1CAWnA+YtNYrMzF7sHMj/vVBcn6diLB/0wG8MIIm+fqLvBdKqgF
 oJX7K3gtNzzKI5j/KlELk6QAi/OgW4o9ufAFyhK3xb3WV7ZQRp1iteWL7658QFFzP
 mgkjwJpcEjXqafQjvdiCpbM6aTMnrMldXAfSkXl27QGNzz1n6BLJniG9ZtWJbTuH2
 8IcycpxSTEINWQIYCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTN9-1x0HnG2L4P-00Rnwc; Thu, 08
 Oct 2026 15:50:15 +0200
Message-ID: <73f35e4d-ed99-41a1-b554-326f0fba130c@gmx.de>
Date: Thu, 8 Oct 2026 15:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
To: Andreas Schwab <schwab@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller
 <deller@kernel.org>, qemu-devel@nongnu.org
References: <20260728192913.61279-1-deller@kernel.org>
 <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
 <244987da-f6d8-47a8-ac4a-16a71c660e36@gmx.de>
 <CAFEAcA9F8rauUNc2NAqbnf1f7-0O_ivft1XOftwt1hW0YWeeJw@mail.gmail.com>
 <a8c13cdc-54c3-4913-bc6e-956cbfe082cb@gmx.de> <87ecgfkrg9.fsf@igel.home>
 <anEBr8nK-4nKmuXj@p100> <87y0emkhjo.fsf@igel.home>
 <b1fbcbb6-2e04-42e4-80ad-f9b4907676ba@gmx.de>
 <CAFEAcA8Mof1EDHoF0hBRcu+to0W6ny-KvX7mUwch+SGVgRD3MA@mail.gmail.com>
 <090faa9e-0ba2-4620-8d27-8fa4b7ac17af@gmx.de> <87bjbdhnh4.fsf@igel.home>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <87bjbdhnh4.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M8qC2OxPS+9Wm0fOUtJP0e/VmezDqqTztBTu+ueJX4lkY05RYKz
 lWhmknGjhPkxj1XTc5O7a9cV4Zh5tR2iRNIyJLHTBiGHc34pvValeTNICTLw6HTKT2gyTbS
 eDqn986bvYoncisKfWKEIxKqw0lA6lkbsY4inCZZtwUddI0B1QiBKVD9r2vEz6KEDW6xmRw
 lU6dpVp9kQA+gHYziUttQ==
UI-OutboundReport: notjunk:1;M01:P0:Xk8v3n4/SQk=;FWwWI3w4KQYl8QoxEdEVa/c3I6b
 qq6NFK1nrYTA9CLfZIt46cYRzCq3uqJpGqjeLqfw56Cek4LFANSlrkzNjvSawV+LNwqcXQkZ5
 y2Cm7c4+fJa+3EwyVGDcQZErk4zfn/1sEidXUM80CuYacXmE6JL+fALf+8+fh77FnjQusE9/w
 ZD6eeFCKZ4uz3CdeDxSibd4lzn8REfHBkgC4slAeusr2cOiSfaqMRc/MT2hWe3Yf/OvkbRqCZ
 IhnXgoPClDpMV0I0uhnVPlk/hPuzPfmZQB4vHRVFzcR0G97G6vEfAWRCtw3ObNzxYLj5mJjev
 Ot9UlJ0newzSn6K8WTtnfV+dMHHerpIOG1unWCXaj3e0X84GNoYWDro5eGGaMwLHwB4EEi9r1
 +fXa4iOFc6VXMAWkHau6QxHLZafen8Lv4my4btAgRGTCxqLRUe9YgnXlAy300sQHaqksBrEbD
 fRUxmcUysnbiPVJ309YtXpAX6FtU6RnHiq+i8dhKK0qZ6b6wVpJVdy2BvGE96gJEkihyPbVfB
 O/Ou3ZGpMc/9reL9/hD6wFqMESd19WTqpAzdDBBpEWXMQyYvE991WNm72PIzVsBTUDodaniX1
 NO/5EJ9vAY0DbSgldlZVFqHS7TU1Id09o+pRJDmfw3WyywcxS1JQ39fOfxcveSDBk/KdXWnpS
 Vhd9sA5LrY7/u6VTGD4pQKrcSgfMiQ7zjmpN+GIG2nA59EmesJTj5flkLQJvgRtaRVUenaR/g
 +Cw6tu8zP0aO48OnUVLUHb/EprvfKOqa3mI52/CSVLASb3iFyiDSuJ4jKLEYKUjalwaKkzmkW
 wqhvn79qjp77aew0WswWmngnF6I3a2cc7qnIpoOK7PlkmtOeGgiFiqgawKpDJT7t8RnxY5Z3n
 GB+IPbhAx73q6+mGXsHRzUXB98s8uWJFdxyVzq8GOu1IE3bjtiwXMSgOjsW0PjhWHY5FAL/8A
 Wez/LoW9QKTVvj0gHthXAfK77IeNPnPgXpBtr+eu4fsMPCINN4aZRAea/hXt0VNffvjg3NEvs
 zD3s4u3ETMJsJ6Eria5XeHnku2oLHU/p0liJO/pRYsz65Y9VmteIf+oyEi8K46AYwbiCXC2EW
 c+dUl+wwE7grLOTPHKG6q0S/1t9eOUs4z9ZQeGaKhPfYFDIJXL/btUItSLoRz66vqgtAuPDju
 1LfRSAFMCPdNlvLKidXu4okwALSLxOJ1wnd6Hdks/iyyIwMY4Qrsc5tGMWOm2qPTrqDnfIpNO
 iQdjGfenNHRD/2DmYHQPFEafgkiH9HrNa/GuPT5gsUl2Oj0YYBglu9WHDrH2ItrSPodMSc4ZM
 dLjOzmMF7UPFgS2B4TbMWG3bsiKBRpP0yud8NA+wQXv/PvQtchceJa4MwPhY6Y8SdSpYmt5KJ
 iuYZ51EDSf5od2RnHxjTcQ6E1w6FqCUCAtn3THt9mhu2oeJPwRXkATXwiHTbL1Mh7IueJefl5
 7G4xuvj4i4/GlFAzg+ntQWJeWpU7k21o5tVJMLk09y2fLXMPwi6QrnQ7CGdGBfJ2L4FO4MCGa
 QAoCqMJeky9TIdAsPBYzoBihf4PD/XtjVs73uU5xmWly0GiMRNVBJ78PCvwgn3yqbdtUAsnZ8
 RsMHm12hZwb94kVyoF4bdkBCadmn3HUZhF8kbHmf3Q+KjSMCgaMbCLJuenmh5fIBJq/+z2Jro
 Ne2F41zDoXOKAQQB0ynYOpD/K08Dy6N9rOJZ5nlP5IaduIolICKfhfBfuzZtzQBFS5DPyWEU6
 v6z1EoozEaQ5jJnD5J+N2SfWgOolZ4CTVG0eXAUIzFwyK8Er+Ymxi6/jgnT6PkDHwU/hvPlzs
 TTL6HXyDzwwCFg6gf12dQxGDevkssttCRnOPPHrR+n9CYmlkYi6vKpiCeLVKkAHJupgXc+hPZ
 /LAF1Ztwc4hz6xItO5xzLCK/gHAmivM9dH/dFeAGgEY3zsIbVO9T8mkvHJQoclwaOAK+1086+
 Gfo3Bl6Qmzwkw1x50mE7GpWvAN62b1HYYTQS/kbPzPE9SZMfDX0YkYygOY/9J8ig3AdDeF0V3
 V+sEwLYj6AJ+gX4fZo8vNNAupF7CgFMkDCLkhRNP1D27okiUH3xgfvGJkmtAUDX0vNlMJmvXH
 lVrnGU0ULNahZwJbn5xxZU0yxsu6rBBM+ICF/Rm71PBujcOJlng1GTiKgH4GMRVjkvLKDKLDo
 mW9K2FcEd3/HGdmfBXnn5GUPkM8l8ouV4yWJ50P9ZXF59sEybAOavMbRIaYEWeuSTImXLDcE2
 DCSXKYKkwMf9Zi7tiEBPQgjnmSmt4WJKQ9LUhUwrIBgxCztt03aDx/qWN8ueVdSHF2aQ0PPcP
 r2d1QBkaxo7il0+uSpkxm75hlRcruWccPbGEQOUwKqe/RXae4oR625KXxrGpHQI7pboYo+hYQ
 EwuXuZrjcyQ8BGVka+EgVf7pc/NAQFIuCO1UqZM8x36C8UybhywyIjNYiF+bdn9FFm6TN2Icb
 mnzIo2kuaJl0Lh5sjKdHE3rNTyu1hgMl4QjRJw+fPm/CrPkZCsMJPBsMSfnFLUxxDfBpKeK/I
 PK+IoJ7yxond3R3xpJIf8w8hSpOD9n/zg+298Jd/Pe/KvDjVEOgmy1ttO+ZQJwgcohYKPCRkc
 /GKUzQe5nEel8jVU0iktewvEn1D/S21i7av2BCNmH3Gq//c9rYzZMx+cL7jjopO4WGrpuaSap
 g0mn3DoIMFtOrsVdg9X0+XgPmEPULg64pKgpDpqfsB7M+7dZWmv7+/s8D0WgHlzyc66iXNSCv
 JnDg0HXHUMF+z53uPDUrpxUDZYT5O02EI5AbNS+R+c1dFNXzKP7gOda2cn62/+DzW9suKCaQS
 6v1TSYV8xqRbybg8HcgGyXYsG5tO1h8o0icQvUra2ByG6jZKNQEa6KLuMg+y6veOy3CqR3Qg3
 31auMd+4JS40vO12VCJpNUtQsMC37FHKBsMTmPeMQXdSGtyxlKCMu8w+KH10yTtYIw1UQ5JQF
 9ojshRsD1tI1089nFm3LYcaeFaIAuKmagofB+8BMqh8IebEWA2RBgy8pj6iK7ABHIpsZFEsj+
 HKZhYKj9cnYF83gB4aRLT8+UDjPaNHy+i+IK23/U9DTDK2o15YXIxktBaD4DvzefGsyZ2yHD1
 /gdno9vDBcvezGgX6iJS8EBA7T1yVqFirRUyJMXIAppNcrh/d6EAcr7SatisTAqYS3h0Q9JDf
 8PvGCWFL/w5jB9kHLoZuuroFzgLkVK0CrBmOaD3JlpTmG1AfPp86uuwzD6mKKqZgJB0WsG9ap
 xP8Bq8h/gJPVDCMndTosS+k3V9r3jLpgffYahlOM6TqlI0A5UYODC1A0uwyF1FrPBlBHDVDCy
 dxivMGfXBH2HnP3jYEpEz5JwQDvIGOBVxoHIJ1uqZfopN5JVD/7MbmLu6V83K7VMNakpNHbGN
 QtrH65GozJ+4Jf53XQNpMNmskVprqm4rldC6IIvhQHW85nK29YXjOGPgpZ5SB8/wAJ+LZ/p7F
 PgD28Ssimm12SdnSPSfumTDuaqRJHFS9RwHMYhXaV7BskXzcebbsED8t1nzoBN4kGYh20VRsd
 NblkAHlSHJmlDN1uZI2TgS5qkYP5OlQ634MXF8OGRxBhszLLZDAYi0sZVrdbZUDzAgJxgHwdI
 aUGghl+lbg49bUmGdNxHB0UA11pTh3vJKe3iRtaYtVFR/NDXPNYFwTYw5irppp1uH6rsTiT7P
 vxQoXQzfpVcY/G90LQMVZJBGAmHL3GSre7kySrajpMu5eOhI7s2WpZwQkQHAf9rQQjpZq2pVt
 1tGKydR97SqUDtEulA+n8DWnQEYz0AyT5ohISHBhEShvOgW3OLrApLGo2ofM85dn1BUJjvysF
 pNkTbQQH805dBU9Z0Ts7M5KehNwMRVv939SJR7obggMPV+AJYqz8rhJ9m4vLRr99S29znFZhA
 LiYdY4VgKcnkV86QN5jKxHZhhuGa+IGalNT1osC1FAwbrZ3WYmZ3xy78L1Ic3BcDriD3VLl5Y
 u6jeTzkMFIiCjRL1qwXJwW/jOxDbLWBO9NdD4bM6Qi9N5UrcqMP0/uln5eJUZMbGcrxOOW90a
 7i6GeJ8iNSugv4Lyu+z2s4tKe9MYBUiMbg6P6YzzthDOPzv60rkf3ToM3JsD6bkHm+dJIExaI
 V5paBfbNVfV46b0Zd4eGYINZvuWDmRJ286mqEADFfNMM8WGjAwRUnFpPI+i1GTUqIXBlRWQPA
 NRO6ykC3LRLGwgBW5gGLiQHRray2heYbfaIwuj/fSlaYOdWDHBIuC3HLUb+idn1exNlI5MDmm
 Fk3h1C/Oc7ZxCfxzcvgunTwEudzaZdmx6p0uIrpWXx4/l2i9igEHZqe2VK77HcFg9Z4Zs60kV
 5srDz6W0JKXAfNXX2HYFVS4Eg/piEq3YdyefcUs6Kx77WIhmgdrypwxWPAd580wMVWa59tqZD
 0X/BE2bWiYnSqJfsciPNsRxO6wlqjwwg9Ux0fHXTduaTOThnfN0g38albd3wtKBFxIqzIhsQx
 9oXWdNRxikQnsz1guqcaXIh+FFK0vaZe2JgNosLI8tHqlhGbsMv5vVca3elqZ32pBdRYkuwUz
 9i24UtyjNP4rfSn72gnY0Kt45ZSytkOych2heDG8UUyqlouFfpVEL//i9X1NImlW6j3LKiQTx
 3jdIAlJru6+QYPW86KR3ZPqmzE8ACMjEV+PgWeA2YV5MKugn/l7koMu7/C7P+LZaQJE8tTfxK
 GADh8WQSpew3rEm3iuCq9VpSxzuY4ssOpbAn9lTBwpNYWsk40WNV2M1k2N+TP2OqTNmz42tkx
 ZAJrtl+R77vejEvYCTXokzXdRfrduJpa5qwHVhm8+XXB2vzSlv90XgdykIlD2jY0qaXhEaW/1
 HFXn2DzzLkwl51H1KmDhIkcU1eLxL7hkUuQ9QRYBa1A/Yyh54drI/ZJenC1itN42/Q8SYnetA
 KQe8u4L7xQCwJCMkHVnvStETx934WqkKn1SAp1XGQ+5mdMYuBJNX3z8cqqulWC+amKCp1V66G
 Byzs1BYue1cHKnhoH/6sRVrGaWtrY9QnIQUnsm/y1kgGeBLHnizIWJL96hEu48GLZmyRNs7sK
 i3DHpUl1OMNJp9jvdoBH/N7qMcJ1lD+aADMlr0tBq7aLVzIpLO7NMNx6G9zhU9UNzEQQfnhYg
 ZobyiF4tugoCV7WT8IOzMqrmec7vAht4Y4ZkWUcqClG9TnlQjMARJfHs87pvyLprAbS4ezcmP
 TQd8Q852xMWAjW5RjvpPGb1GbV8gib8G7s5qSFOarU85Zo1Q86xesDkrwHYzyonwIUcMdA58i
 vHNg8maX6xeHZ2qq9BbQWrh8uZMkJMxvp8BBDutHcHvbVhEZqPHNCLx8oLqXscoyOTpK5JnZP
 iGeY6ocyBgzjPW/1k3fATTkcKaKukznMOXxHs4Jvk6SqP57hvKFkwh4MFYu0jihSc5sSmjOiD
 m6ZTTR001/h7Hl+Drw1Dy0hsgW0KrH6XOzsOPKTEXOYyrX95reCQHM15ytely0T399AobTo23
 7aZo0FkWDitV/mmvHFt413czpVBt7x83/gQW+BRqdfcgbiP7778WhIc789IP+szYSOoPL1WGm
 3rH5h2bhqHKRjhwGpIy25jXd+dcdCPP7Z+AmlVZh+IrAWbVQaGUvVVNfVaBmU6mKSKjjIR3Wx
 UbqxU5Xe9+0LYugu79vcbrEpZLSdczEQ5CzjBNZ0k9oGKti5YDymvh8FFpkydlGCmiyjoHHdP
 EizFozfpW046CczNWohCquqnKwgo6R4g4p6lfoyLZ9NRRD97UPS87Qy2+kxmuerdbOhPWT3ml
 imeyhBwfLlIP9emVDSRxsifsxT2lMG4ECC4QkP9d0GwV5mXy3ALFSi9DCQvzKgeDrPN+45BeD
 RrOXdFQxC75ZdTyzNki2cL9GrFqEw6v3q1n7aKqyto8NHGO46QxAm5zOYJjA5HtlKzgni4qtd
 56AzpaSJoN3BOGDqECgR0Dwvg3uHujinK3J50mWsaeSWTf5pFffGR+AZSpkpLyNJFSMB92k/F
 zGPBJiVBpBSUKAbpWnFtastzBoST1eghwXaYxo3eVezrf2PhNYF/EfZlQC2kVHOcMsbEplx57
 hJ5h5HQyssTrowgdAc39JZu9NjewFA1xn6CJoArjX4L94WpqbtNLQpGmUMrS9jdQ6U3aetEEw
 wGv6kF7SzSmPQng5rCE+bSYYky8Cd4UsY4MP8Wt0KoD6sJ1D9y+Ql07he3WrsjbCzUCABpsWe
 sqYVguh+SCBsqvo6/Jq014caMW5nazPUFVIZlMolHbQGNJYlYb3KUZziOMdiAfgEScu3ZruUh
 RjykC105p6ZTU1kOgdMPYcmWNK7ArtP2b84DD14Ll89+PBI79mcmnSOg6fWZXFPLZr21VDd42
 YGvsS03cbWmGBBXoOjjxTpKg0tS0ItZkDHoMJd8BwpBDnjcnkk+yOOKs=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Picking up this problem again...

On 8/7/26 19:03, Andreas Schwab wrote:
> On Aug 07 2026, Helge Deller wrote:
>> Andreas, do you agree as well, that all 32-bit kernel architectures
>> should follow this path and we should drop the "preferred" thing and sw=
itch
>> to a native 64-bit time value?
>=20
> That would be an ABI break.  But on the glibc side, the m68k definition
> of struct msqid_ds is broken as well, having incompatible layout between
> _TIME_BITS=3D64 and _TIME_BITS=3D32 definitions.

Yes, that's the main problem.
It would be nice if the m68k arch maintainers could fix it somehow.
It currently is broken, and to fix it you will have an ABI break either wa=
y.
 =20
>> If so, I'd willing to come up with a kernel patch...
>=20
> Let's see what the kernel experts recommend.

Seems there was no feedback yet...

Helge

