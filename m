Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEEAC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 09:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXHec-00089B-OH; Fri, 26 Jul 2024 05:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sXHeb-00087w-3g
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:54:25 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sXHeX-0005NB-UI
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:54:24 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a15692b6f6so2497529a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1721987658; x=1722592458; darn=nongnu.org;
 h=cc:to:subject:message-id:date:mime-version:from:user-agent
 :in-reply-to:references:from:to:cc:subject:date:message-id:reply-to;
 bh=FK/NTiPcvNWfnTKbzA0IYU+nXXTmEncI+KSPemSyA5w=;
 b=JXXGAuK3q8eIAZZj7zziWtGI+VACg87fyzwNnLTreApmzPgboUPjzApI7RS6usOFuR
 +Nd/ScAsB72fk2/mx7gsg9bGbwwR0Z7HPeVgRrUF67g5ZRhOW2MaW3BHghc4tDGN4vcT
 O9UjdshhVmexFXQ7tcRvEAB4gORLq2M0ai/wdSX7XFnZyzJraXamjZWP3lzJZ7Lx1yl0
 lFANnVQ9kG6iTs62QEv1QiojwOwYopcxlyWmDa2cT2MMx/quSjLqbRpeKaspRZyGNDCh
 AxdeMjK/qUaOL6kQ7IeooQwXO5E0BZOVE1IPqsbFUu0NctuY5pTzhW2UjOvgXv8EUsfI
 O6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721987658; x=1722592458;
 h=cc:to:subject:message-id:date:mime-version:from:user-agent
 :in-reply-to:references:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FK/NTiPcvNWfnTKbzA0IYU+nXXTmEncI+KSPemSyA5w=;
 b=lUdNZwUTRmqvsHn7ADqRTef9r63+rnmvtDS1f1p+ghKelQFv/t9XbFRETqjoy1wvOG
 3ePJtcv1yqHzDUKBsJ84YAxERF2dgh3MGIeUcDQP57XmbYCWFBGKEYrUBdjqy+tQwnrj
 li3N3mTXqbdE6SEEj7tOJICNqm5usnO20IpDmO15X2peaarP5SNfNMLAp912exRmHRnu
 pFJCeBRAB5jy6Zqlp86CmlCn6zGjLjGRR4YPD4YnqYm8uxGP1U9erzott7PEQwYJjj0n
 X7LdEBka1tqhuJ+Kdg8YLk2XImuFtL9dBTrGcmNAjFgwS7uINwUTJoSPDxBi8qrCJLFz
 cx0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsXqC1OkSWoGt/1CVQePefQoWImlZQ37wUQIA6htQu7BAlX7njwAs5PQgiIf0lvpI7I4fg6ybdLHGugjr9ubtd8jeaz8s=
X-Gm-Message-State: AOJu0YwX9njXZfPa4W0QVdZHTdk7NhTd1BP+E9cmm3ohPIbJkTef7U09
 Zc0tgbL5oAzFMQvwvAak9XRYgD1So8Ur3f/iiRPgYyCkzZjLH8FVarp0q9FP+QqK/Fa885heNUj
 rAwwixDgvT0dUhrf8ye5t1koHDDqYs8fli93F5Q==
X-Google-Smtp-Source: AGHT+IEIJtH3fiDF1uYd5J8mMRRWzNK4yZgeNxOdqmTiqgmtIy75H1Jl8l9EFWgIgsFkKuIE3SE+SqVwvP99pXhHsbQ=
X-Received: by 2002:a05:6402:5111:b0:5a3:d140:1a52 with SMTP id
 4fb4d7f45d1cf-5ac2a0ee946mr4274950a12.3.1721987657612; Fri, 26 Jul 2024
 02:54:17 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 26 Jul 2024 05:54:17 -0400
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
 <20240712023650.45626-10-luchangqi.123@bytedance.com>
 <ZpT1ZnOjx48_6q0j@cormorant.local>
 <58383d65-83df-4527-81e4-b4d12c409b22@bytedance.com>
 <CAO5cSZDc9_o4=VZRDFA-CXAkF12r=v95zhNQ0gBM0NHExgkbMw@mail.gmail.com>
 <ZqNBSGmVTg-xkTs3@cormorant.local>
In-Reply-To: <ZqNBSGmVTg-xkTs3@cormorant.local>
X-Original-From: =?UTF-8?B?5Y2i6ZW/5aWHIDxsdWNoYW5ncWkuMTIzQGJ5dGVkYW5jZS5jb20+?=
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
Mime-Version: 1.0
Date: Fri, 26 Jul 2024 05:54:17 -0400
Message-ID: <CAO5cSZD8Vk-=z-REXjusrXXemN4T4=-kA=_aXiPsiR4MsjL10Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 09/10] hw/nvme: add reservation protocal
 command
To: Klaus Jensen <its@irrelevant.dk>
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, 
 kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, 
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de, 
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org, 
 pizhenwei@bytedance.com
Content-Type: multipart/alternative; boundary="000000000000a3dc88061e237eff"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HTML_MESSAGE=0.001, NUMERIC_HTTP_ADDR=1.242, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=no autolearn_force=no
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

--000000000000a3dc88061e237eff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi;

You can test it in spdk.
First start spdk and execute the following command.

```
dd if=3D/dev/zero of=3Dtest.img bs=3D1G count=3D10
RPC=3D/root/source/spdk/spdk/scripts/rpc.py
FILE=3D/root/test.img

$RPC bdev_aio_create $FILE aio0 512
$RPC iscsi_create_portal_group 1 127.0.0.1:3260
$RPC iscsi_create_initiator_group 2 ANY ANY
$RPC iscsi_create_target_node target0 target0_alias aio0:0 1:2 64 -d
```

Then start qemu and mount an nvme disk.
Execute the following test command.
```
#reporter
nvme resv-report /dev/nvme0n1
#register
nvme resv-register /dev/nvme0n1 --nrkey 3 --rrega 0
#unregister
nvme resv-register /dev/nvme0n1 --crkey 3 --rrega 1
# register replace
nvme resv-register /dev/nvme0n1 --crkey 3 --nrkey 5 --rrega 2
#release
nvme resv-release /dev/nvme0n1 --crkey 5 --rtype 1 --rrela 0
#clear
nvme resv-release /dev/nvme0n1 --crkey 5 --rtype 1 --rrela 1
#reserve
nvme resv-acquire /dev/nvme0n1 --crkey 3 --rtype 1 --racqa 0
#premmpt
nvme resv-acquire /dev/nvme0n1 --crkey 6 --prkey 3 --rtype 1 --racqa 1
```



On 2024/7/26 14:25, Klaus Jensen wrote:
> On Jul 25 19:42, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
>> Hi,
>>
>> ```
>> 2685 nvme_status->regctl_ds[i].cntlid =3D nvme_ctrl(req)->cntlid;
>> 2686 nvme_status->regctl_ds[i].rkey =3D keys_info->keys[i];
>> 2687 nvme_status->regctl_ds[i].rcsts =3D keys_info->keys[i] =3D=3D
>> 2688 reservation->key ? 1 : 0;
>> 2689 /* hostid is not supported currently */
>> 2670 memset(&nvme_status->regctl_ds[i].hostid, 0, 8);
>> ```
>>
>> Klaus, I think hostid(2685) is stored locally like cntlid, i
>> can get cntlid by nvme_ctrl(req)->cntlid, but I can't
>> find a good way to get the host ID(2670). So I add a comment
>> "/* hostid is not supported currently */". Could you give me
>> some advices?
>>
>
> The Host Identifier is just a 64 or 128 bit value that the host can set
> with Set Feature. So, it is fine (and normal) that the value is
> initially zero, but the host should be able to set it on controllers
> with Set Feature to indicate if a controller belongs to the same host or
> not.
>
>> And using spdk as target will not fail, but it will show 0 at hostid
>> at present.
>
> Host Identifier 0 is a valid value when used with reservations; 0
> indicates that the host associated with the controller is not associated
> with any other controllers in the subsystem. So if two controllers have
> Host Identifier set to 0, that implicitly mean they are associated with
> two different hosts.
>
>> The relevant tests in qemu are as follows=EF=BC=8C
>>
>> ```
>> root@node1:~# nvme resv-report /dev/nvme0n1
>> NVME Reservation Report success
>>
>> NVME Reservation status:
>>
>> gen : 1
>> regctl : 1
>> rtype : 0
>> ptpls : 0
>> regctl[0] :
>> cntlid : 0
>> rcsts : 0
>> hostid : 0
>> rkey : 6
>> ```
>
> I was hoping for an example on how to setup some simple iscsi stuff so I
> could test the feature.

--000000000000a3dc88061e237eff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>Hi;
<br>
<br>You can test it in spdk.
<br>First start spdk and execute the following command.
<br>
<br>```
<br>dd if=3D/dev/zero of=3Dtest.img bs=3D1G count=3D10
<br>RPC=3D/root/source/spdk/spdk/scripts/rpc.py
<br>FILE=3D/root/test.img
<br>
<br>$RPC bdev_aio_create $FILE aio0 512
<br>$RPC iscsi_create_portal_group 1 <a href=3D"http://127.0.0.1:3260">127.=
0.0.1:3260</a>
<br>$RPC iscsi_create_initiator_group 2 ANY ANY
<br>$RPC iscsi_create_target_node target0 target0_alias aio0:0 1:2 64 -d
<br>```
<br>
<br>Then start qemu and mount an nvme disk.
<br>Execute the following test command.
<br>```
<br>#reporter
<br>nvme resv-report /dev/nvme0n1
<br>#register
<br>nvme resv-register /dev/nvme0n1 --nrkey 3  --rrega 0
<br>#unregister
<br>nvme resv-register /dev/nvme0n1 --crkey 3  --rrega 1
<br># register replace
<br>nvme resv-register /dev/nvme0n1 --crkey 3 --nrkey 5 --rrega 2
<br>#release
<br>nvme resv-release /dev/nvme0n1 --crkey 5 --rtype 1 --rrela 0
<br>#clear
<br>nvme resv-release /dev/nvme0n1 --crkey 5 --rtype 1 --rrela 1
<br>#reserve
<br>nvme resv-acquire /dev/nvme0n1 --crkey 3 --rtype 1 --racqa 0
<br>#premmpt
<br>nvme resv-acquire /dev/nvme0n1 --crkey 6 --prkey 3 --rtype 1 --racqa 1
<br>```
<br>
<br>
<br>
<br>On 2024/7/26 14:25, Klaus Jensen wrote:
<br>&gt; On Jul 25 19:42, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
<br>&gt;&gt; Hi,
<br>&gt;&gt;
<br>&gt;&gt; ```
<br>&gt;&gt; 2685 nvme_status-&gt;regctl_ds[i].cntlid =3D nvme_ctrl(req)-&g=
t;cntlid;
<br>&gt;&gt; 2686 nvme_status-&gt;regctl_ds[i].rkey =3D keys_info-&gt;keys[=
i];
<br>&gt;&gt; 2687 nvme_status-&gt;regctl_ds[i].rcsts =3D keys_info-&gt;keys=
[i] =3D=3D
<br>&gt;&gt; 2688 reservation-&gt;key ? 1 : 0;
<br>&gt;&gt; 2689 /* hostid is not supported currently */
<br>&gt;&gt; 2670 memset(&amp;nvme_status-&gt;regctl_ds[i].hostid, 0, 8);
<br>&gt;&gt; ```
<br>&gt;&gt;
<br>&gt;&gt; Klaus, I think hostid(2685) is stored locally like cntlid, i
<br>&gt;&gt; can get cntlid by nvme_ctrl(req)-&gt;cntlid, but I can&#39;t
<br>&gt;&gt; find a good way to get the host ID(2670). So I add a comment
<br>&gt;&gt; &quot;/* hostid is not supported currently */&quot;. Could you=
 give me
<br>&gt;&gt; some advices?
<br>&gt;&gt;
<br>&gt;=20
<br>&gt; The Host Identifier is just a 64 or 128 bit value that the host ca=
n set
<br>&gt; with Set Feature. So, it is fine (and normal) that the value is
<br>&gt; initially zero, but the host should be able to set it on controlle=
rs
<br>&gt; with Set Feature to indicate if a controller belongs to the same h=
ost or
<br>&gt; not.
<br>&gt;=20
<br>&gt;&gt; And using spdk as target will not fail, but it will show 0 at =
hostid
<br>&gt;&gt; at present.
<br>&gt;=20
<br>&gt; Host Identifier 0 is a valid value when used with reservations; 0
<br>&gt; indicates that the host associated with the controller is not asso=
ciated
<br>&gt; with any other controllers in the subsystem. So if two controllers=
 have
<br>&gt; Host Identifier set to 0, that implicitly mean they are associated=
 with
<br>&gt; two different hosts.
<br>&gt;=20
<br>&gt;&gt; The relevant tests in qemu are as follows=EF=BC=8C
<br>&gt;&gt;
<br>&gt;&gt; ```
<br>&gt;&gt; root@node1:~# nvme resv-report /dev/nvme0n1
<br>&gt;&gt; NVME Reservation Report success
<br>&gt;&gt;
<br>&gt;&gt; NVME Reservation status:
<br>&gt;&gt;
<br>&gt;&gt; gen : 1
<br>&gt;&gt; regctl : 1
<br>&gt;&gt; rtype : 0
<br>&gt;&gt; ptpls : 0
<br>&gt;&gt; regctl[0] :
<br>&gt;&gt; cntlid : 0
<br>&gt;&gt; rcsts : 0
<br>&gt;&gt; hostid : 0
<br>&gt;&gt; rkey : 6
<br>&gt;&gt; ```
<br>&gt;=20
<br>&gt; I was hoping for an example on how to setup some simple iscsi stuf=
f so I
<br>&gt; could test the feature.</p>

--000000000000a3dc88061e237eff--

