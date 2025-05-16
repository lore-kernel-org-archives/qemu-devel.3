Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC8BC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 21:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uG2in-00080j-Nn; Fri, 16 May 2025 17:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uG2il-00080P-QK; Fri, 16 May 2025 17:36:00 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uG2ik-0001cr-32; Fri, 16 May 2025 17:35:59 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a206845eadso1663797f8f.3; 
 Fri, 16 May 2025 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747431356; x=1748036156; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6V7361DESuppG/Yq9lhfGVsJFGM0upbrObYpBym9nkg=;
 b=dP+1PpvN6spujLn9x37Ul1vlEbI0643ZSxndyEgn1tBQDEoxGgi+80s/NvziHd0pyh
 KyBCoICaUB0AHbSZUVJfgFy1Q8uBuBYoKPgW//qpDNTw4e14LCuVFomST+Wfxg8J8T28
 vLmgkM1eumVqtIkPunPOrMtIY83bJrRsqsz0OKCCs8AqUnLOuxLOm64Waoa1mvv170R6
 md6O2XProDj+c4ND4AqHJh55EmuPJpD4OckKTBmdTR0GW8Ns+5DGLoTAVHBWHCd9gVao
 QPb3kF7K6r1JRwDDagmQ1uEte+6UEStMP/oQ/IHytxV2z8hItihbP9WQe7UoD1rKsgvf
 Zu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747431356; x=1748036156;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6V7361DESuppG/Yq9lhfGVsJFGM0upbrObYpBym9nkg=;
 b=PW7DhcDyoIyL8XwuLpZudv3bTZE1UlX+aZXjbOaDmIA3pgg1SR7V42cQC5es2/HP8q
 hz8cwxGDfFzWRKtydsoS0O3EREZAGClIA606SXal949IDIay2HvCgsgfKvpXOqEkwYKf
 7swroRVJhFlT2BeA3ConcPSEWGaPsJ+hHv6C0i89nym6qFW5/AdByBMoU6bBgkgpfhT6
 i8zCmG9vLrXPkrByW1XPdWNP3G9nWITiscLAECw6MaLFXELLQw9yrV4tO3aG/7Q575Lw
 PepJQEun1ghHygwZ9571Y+ei6cziQFGU+b2EL0tRMxyXUztGpkfWsLpBRVM4pwkGGSwK
 xG9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCXBH6nTSq9uVBHBeCSu+RSRgCCS0FxsZrY9yqbWV72DSdmiHg8d/0sxqErkiPCt5fT7IDo9EPj/K/@nongnu.org
X-Gm-Message-State: AOJu0YzUKJgSBWF9Z8n2sEJd4UoOUgDwuWPzdsUjeprWOcwC0w5K2Fys
 hItBnHY+CWo6BheMS/UvyJ6bMACs/YWj4pB2v6HpTKR25szuF9mcv6a+pxICxefD6Lg=
X-Gm-Gg: ASbGncuHgmwcBjBt1REoYhR6J7QTF/JfjPKJG5dlvm5WCHS9Jblp6mjcSn0QPBUXLsO
 cnUJxWt/0nYIL7OxovFInwdzE9Fyr1ZXQtZhi1mO+QK/mV+QDNWi1m+ZkTbT+oDHja8w+xPoWrW
 7nNgTiqKz5XTtKiibn79gseFs5IlgEpn6j51qIIMn6Pe90pXs9SUwD+JvImjrTBJ/lMQmRYJTxc
 SG2znYQgLud+EJ+liNj+qBC87EMaUlM77wphYBlA0nxnsp5YiaafRcARyvFLvAOlNlnd0eVhBrW
 FKv1i7PSx0WacctDWQK6g5Hf1XNEmRtvZG5Z6YRmO2+TY0QlHrx9bukbu4gY/cLPEtX3ewkaERh
 KnBZXZIx7gFAi4tIlSzFHviZsF7epg6dEajuBBv9raEg=
X-Google-Smtp-Source: AGHT+IGFyq/j/yXgrutdiptdSFwNKtwpmB7ueUpgmFVZsZWlksQqdU263I6yPCz2nANyi6ZCQeuSPg==
X-Received: by 2002:a05:6000:2384:b0:3a1:f684:39a7 with SMTP id
 ffacd0b85a97d-3a35fde361amr3837615f8f.0.1747431355431; 
 Fri, 16 May 2025 14:35:55 -0700 (PDT)
Received: from smtpclient.apple (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca62c70sm4131434f8f.54.2025.05.16.14.35.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 May 2025 14:35:54 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 1/2] block/null: Report DATA if not reading zeroes
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <87ikmbel0y.fsf@pond.sub.org>
Date: Sat, 17 May 2025 00:35:43 +0300
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F23FC6D3-454B-46AE-8A87-8BB4BBCCD7CB@gmail.com>
References: <20250430203717.16359-1-nirsof@gmail.com>
 <20250430203717.16359-2-nirsof@gmail.com> <87plgjg1kh.fsf@pond.sub.org>
 <87wmarelsh.fsf@pond.sub.org> <87ikmbel0y.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42e.google.com
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



> On 8 May 2025, at 8:20, Markus Armbruster <armbru@redhat.com> wrote:
>=20
> Markus Armbruster <armbru@redhat.com> writes:
>=20
>> Markus Armbruster <armbru@redhat.com> writes:
>>=20
>>> Nir Soffer <nirsof@gmail.com> writes:
>=20
> [...]
>=20
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index b1937780e1..7c95c9e36a 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -3293,8 +3293,9 @@
>     ##
>     # @BlockdevOptionsNull:
>     #
>     # Driver specific block device options for the null backend.
>     #
>     # @size: size of the device in bytes.
>=20
> Missing: default value.

This was not added by my change, but I can add another commit to specify =
the default size.

But it would be better to make this required, default size does not make =
sense for a block device, expect maybe 0, but this is not very useful =
default.

Can we break compatibility by requiring a size?=

