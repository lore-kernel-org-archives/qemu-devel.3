Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661E0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 02:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbANl-00034r-5R; Mon, 05 Aug 2024 22:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sbANi-00030X-Hq
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 22:57:02 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sbANg-0002fX-3e
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 22:57:02 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ef2cb7d562so972051fa.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1722913012; x=1723517812; darn=nongnu.org;
 h=cc:to:subject:message-id:date:in-reply-to:user-agent:from
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JAq8I2sCkcX9cChWGPw8eAGXe99pddgncfo1O4lMiyw=;
 b=UxWqtNiuAxtN71Fl9W7vtNxvbwfANyND30FxeCpCHK6HpmFbJHfyzDjZFDhgXhf8WM
 qTRLLDc247WatZIxfuHvVOIf30O4qMCJkWktYo0t16A6ACrRaYrD0xe2npys9b+L33jT
 A3GrBRsXHjvKndZ8gV1wTeI8ywOKoqUIr6kh9WBoOf+uF49Ud/XKF2AMgZZAoTYcgapN
 O7Si8uC4c6noNsPGtFp4UBe27VCYrjDTmUzBxD+92gyzHPN5/RhmLyRNp2w8nkwRXRMb
 7xKsfG5FcapyLY39YHF1qWuia0pfIyzJha/Nl+4PWZ5K18cktUT5NaNsn6W5rKvCxOL3
 s78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722913012; x=1723517812;
 h=cc:to:subject:message-id:date:in-reply-to:user-agent:from
 :references:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAq8I2sCkcX9cChWGPw8eAGXe99pddgncfo1O4lMiyw=;
 b=hTX8DIrGcXoWNF/IIlMyIljoebJglD4n0t4GlRoNyvzi81gqdNO6D4gOoUBjpvkeEu
 K9K9z4+SGtbDtHEszsdtJAlb7JNMQ96LuHMoJS5QI5Jdyp9tcrbO9sGd3+JL6LaVSF+x
 52S9Q7ofVvrSrWulTkrIsfMRFAJ3K12g3ljhyiqp/af7OuwxfCKXmkLlrD6XqJsEwXLG
 rO8gj6EudC1gTxZOI61flZy2pMJP17vWAGpcNAe5uXqN26YPA2E/wTkhazVH90Ih4Z9q
 aJTNVvCR6i+E4eeS7aeAcSzbTix92aWLl+R3hVVdmRLgdK9Aa7qugjJ9gb5fyte02vtg
 WMJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrSWhVshjst0qaGCG/rYpFEtCFZgeOInMCUyON8PhQcGCj5PvRDlhgyPdqCSPRNmiG3dQZNZEWD05AQdiVAaYUa+u+aSU=
X-Gm-Message-State: AOJu0YxiPCKctFNJnEol+T3C2z2sw7Tm/lICDbCEinxyR6C9N/to8C+i
 4g0Q8xxvUIQkwrR5erEiPW8Um3jBfHpTHozn2rWbe/FA50A+rB/iSOxkRGheKClmJWu58Mxrr+h
 zbB3yrrm87lnToTkZWoimGeaOGEWqA1oidmHj8g==
X-Google-Smtp-Source: AGHT+IH6fhUZTGHRp/KRo5+tNE91gkR9cGdwkA95XM/gWJXQ7p44XI7db1uybv0jpZJovOWCZVVlb+RQ2/0l+6MyAYc=
X-Received: by 2002:a2e:9893:0:b0:2f1:563d:ec8a with SMTP id
 38308e7fff4ca-2f15ab24d9emr96683911fa.41.1722913012114; Mon, 05 Aug 2024
 19:56:52 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Tue, 6 Aug 2024 04:56:51 +0200
Mime-Version: 1.0
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
 <20240712023650.45626-10-luchangqi.123@bytedance.com>
 <ZpT1ZnOjx48_6q0j@cormorant.local>
 <58383d65-83df-4527-81e4-b4d12c409b22@bytedance.com>
 <CAO5cSZDc9_o4=VZRDFA-CXAkF12r=v95zhNQ0gBM0NHExgkbMw@mail.gmail.com>
 <ZqNBSGmVTg-xkTs3@cormorant.local>
 <3a799eb6-3350-4b35-8e75-68d9020443cb@bytedance.com>
From: =?UTF-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
X-Original-From: =?UTF-8?B?5Y2i6ZW/5aWHIDxsdWNoYW5ncWkuMTIzQGJ5dGVkYW5jZS5jb20+?=
User-Agent: Mozilla Thunderbird
In-Reply-To: <3a799eb6-3350-4b35-8e75-68d9020443cb@bytedance.com>
Date: Tue, 6 Aug 2024 04:56:51 +0200
Message-ID: <CAO5cSZDgv0V=bJx2Bj6p-Bx+1_2E4QcMrq2fSSdgoU_BtPLkrg@mail.gmail.com>
Subject: Ping: Re: [PATCH v9 09/10] hw/nvme: add reservation protocal command
To: Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, 
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de, 
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org, 
 pizhenwei@bytedance.com
Content-Type: multipart/alternative; boundary="000000000000114d3d061efaf27c"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-lj1-x22f.google.com
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

--000000000000114d3d061efaf27c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi;

Klaus, Does the test method in the above email work properly?

On 2024/7/26 17:53, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
> Hi;
>
> You can test it in spdk.
> First start spdk and execute the following command.
>
> ```
> dd if=3D/dev/zero of=3Dtest.img bs=3D1G count=3D10
> RPC=3D/root/source/spdk/spdk/scripts/rpc.py
> FILE=3D/root/test.img
>
> $RPC bdev_aio_create $FILE aio0 512
> $RPC iscsi_create_portal_group 1 127.0.0.1:3260
> $RPC iscsi_create_initiator_group 2 ANY ANY
> $RPC iscsi_create_target_node target0 target0_alias aio0:0 1:2 64 -d
> ```
>
> Then start qemu and mount an nvme disk.
> Execute the following test command.
> ```
> #reporter
> nvme resv-report /dev/nvme0n1
> #register
> nvme resv-register /dev/nvme0n1 --nrkey 3 --rrega 0
> #unregister
> nvme resv-register /dev/nvme0n1 --crkey 3 --rrega 1
> # register replace
> nvme resv-register /dev/nvme0n1 --crkey 3 --nrkey 5 --rrega 2
> #release
> nvme resv-release /dev/nvme0n1 --crkey 5 --rtype 1 --rrela 0
> #clear
> nvme resv-release /dev/nvme0n1 --crkey 5 --rtype 1 --rrela 1
> #reserve
> nvme resv-acquire /dev/nvme0n1 --crkey 3 --rtype 1 --racqa 0
> #premmpt
> nvme resv-acquire /dev/nvme0n1 --crkey 6 --prkey 3 --rtype 1 --racqa 1
> ```
>
>
>
> On 2024/7/26 14:25, Klaus Jensen wrote:
>> On Jul 25 19:42, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
>>> Hi,
>>>
>>> ```
>>> 2685 nvme_status->regctl_ds[i].cntlid =3D nvme_ctrl(req)->cntlid;
>>> 2686 nvme_status->regctl_ds[i].rkey =3D keys_info->keys[i];
>>> 2687 nvme_status->regctl_ds[i].rcsts =3D keys_info->keys[i] =3D=3D
>>> 2688 reservation->key ? 1 : 0;
>>> 2689 /* hostid is not supported currently */
>>> 2670 memset(&nvme_status->regctl_ds[i].hostid, 0, 8);
>>> ```
>>>
>>> Klaus, I think hostid(2685) is stored locally like cntlid, i
>>> can get cntlid by nvme_ctrl(req)->cntlid, but I can't
>>> find a good way to get the host ID(2670). So I add a comment
>>> "/* hostid is not supported currently */". Could you give me
>>> some advices?
>>>
>>
>> The Host Identifier is just a 64 or 128 bit value that the host can set
>> with Set Feature. So, it is fine (and normal) that the value is
>> initially zero, but the host should be able to set it on controllers
>> with Set Feature to indicate if a controller belongs to the same host or
>> not.
>>
>>> And using spdk as target will not fail, but it will show 0 at hostid
>>> at present.
>>
>> Host Identifier 0 is a valid value when used with reservations; 0
>> indicates that the host associated with the controller is not associated
>> with any other controllers in the subsystem. So if two controllers have
>> Host Identifier set to 0, that implicitly mean they are associated with
>> two different hosts.
>>
>>> The relevant tests in qemu are as follows=EF=BC=8C
>>>
>>> ```
>>> root@node1:~# nvme resv-report /dev/nvme0n1
>>> NVME Reservation Report success
>>>
>>> NVME Reservation status:
>>>
>>> gen : 1
>>> regctl : 1
>>> rtype : 0
>>> ptpls : 0
>>> regctl[0] :
>>> cntlid : 0
>>> rcsts : 0
>>> hostid : 0
>>> rkey : 6
>>> ```
>>
>> I was hoping for an example on how to setup some simple iscsi stuff so I
>> could test the feature.

--000000000000114d3d061efaf27c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>Hi;
<br>
<br>Klaus, Does the test method in the above email work properly?
<br>
<br>On 2024/7/26 17:53, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
<br>&gt; Hi;
<br>&gt;=20
<br>&gt; You can test it in spdk.
<br>&gt; First start spdk and execute the following command.
<br>&gt;=20
<br>&gt; ```
<br>&gt; dd if=3D/dev/zero of=3Dtest.img bs=3D1G count=3D10
<br>&gt; RPC=3D/root/source/spdk/spdk/scripts/rpc.py
<br>&gt; FILE=3D/root/test.img
<br>&gt;=20
<br>&gt; $RPC bdev_aio_create $FILE aio0 512
<br>&gt; $RPC iscsi_create_portal_group 1 <a href=3D"http://127.0.0.1:3260"=
>127.0.0.1:3260</a>
<br>&gt; $RPC iscsi_create_initiator_group 2 ANY ANY
<br>&gt; $RPC iscsi_create_target_node target0 target0_alias aio0:0 1:2 64 =
-d
<br>&gt; ```
<br>&gt;=20
<br>&gt; Then start qemu and mount an nvme disk.
<br>&gt; Execute the following test command.
<br>&gt; ```
<br>&gt; #reporter
<br>&gt; nvme resv-report /dev/nvme0n1
<br>&gt; #register
<br>&gt; nvme resv-register /dev/nvme0n1 --nrkey 3  --rrega 0
<br>&gt; #unregister
<br>&gt; nvme resv-register /dev/nvme0n1 --crkey 3  --rrega 1
<br>&gt; # register replace
<br>&gt; nvme resv-register /dev/nvme0n1 --crkey 3 --nrkey 5 --rrega 2
<br>&gt; #release
<br>&gt; nvme resv-release /dev/nvme0n1 --crkey 5 --rtype 1 --rrela 0
<br>&gt; #clear
<br>&gt; nvme resv-release /dev/nvme0n1 --crkey 5 --rtype 1 --rrela 1
<br>&gt; #reserve
<br>&gt; nvme resv-acquire /dev/nvme0n1 --crkey 3 --rtype 1 --racqa 0
<br>&gt; #premmpt
<br>&gt; nvme resv-acquire /dev/nvme0n1 --crkey 6 --prkey 3 --rtype 1 --rac=
qa 1
<br>&gt; ```
<br>&gt;=20
<br>&gt;=20
<br>&gt;=20
<br>&gt; On 2024/7/26 14:25, Klaus Jensen wrote:
<br>&gt;&gt; On Jul 25 19:42, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
<br>&gt;&gt;&gt; Hi,
<br>&gt;&gt;&gt;
<br>&gt;&gt;&gt; ```
<br>&gt;&gt;&gt; 2685 nvme_status-&gt;regctl_ds[i].cntlid =3D nvme_ctrl(req=
)-&gt;cntlid;
<br>&gt;&gt;&gt; 2686 nvme_status-&gt;regctl_ds[i].rkey =3D keys_info-&gt;k=
eys[i];
<br>&gt;&gt;&gt; 2687 nvme_status-&gt;regctl_ds[i].rcsts =3D keys_info-&gt;=
keys[i] =3D=3D
<br>&gt;&gt;&gt; 2688 reservation-&gt;key ? 1 : 0;
<br>&gt;&gt;&gt; 2689 /* hostid is not supported currently */
<br>&gt;&gt;&gt; 2670 memset(&amp;nvme_status-&gt;regctl_ds[i].hostid, 0, 8=
);
<br>&gt;&gt;&gt; ```
<br>&gt;&gt;&gt;
<br>&gt;&gt;&gt; Klaus, I think hostid(2685) is stored locally like cntlid,=
 i
<br>&gt;&gt;&gt; can get cntlid by nvme_ctrl(req)-&gt;cntlid, but I can&#39=
;t
<br>&gt;&gt;&gt; find a good way to get the host ID(2670). So I add a comme=
nt
<br>&gt;&gt;&gt; &quot;/* hostid is not supported currently */&quot;. Could=
 you give me
<br>&gt;&gt;&gt; some advices?
<br>&gt;&gt;&gt;
<br>&gt;&gt;
<br>&gt;&gt; The Host Identifier is just a 64 or 128 bit value that the hos=
t can set
<br>&gt;&gt; with Set Feature. So, it is fine (and normal) that the value i=
s
<br>&gt;&gt; initially zero, but the host should be able to set it on contr=
ollers
<br>&gt;&gt; with Set Feature to indicate if a controller belongs to the sa=
me host or
<br>&gt;&gt; not.
<br>&gt;&gt;
<br>&gt;&gt;&gt; And using spdk as target will not fail, but it will show 0=
 at hostid
<br>&gt;&gt;&gt; at present.
<br>&gt;&gt;
<br>&gt;&gt; Host Identifier 0 is a valid value when used with reservations=
; 0
<br>&gt;&gt; indicates that the host associated with the controller is not =
associated
<br>&gt;&gt; with any other controllers in the subsystem. So if two control=
lers have
<br>&gt;&gt; Host Identifier set to 0, that implicitly mean they are associ=
ated with
<br>&gt;&gt; two different hosts.
<br>&gt;&gt;
<br>&gt;&gt;&gt; The relevant tests in qemu are as follows=EF=BC=8C
<br>&gt;&gt;&gt;
<br>&gt;&gt;&gt; ```
<br>&gt;&gt;&gt; root@node1:~# nvme resv-report /dev/nvme0n1
<br>&gt;&gt;&gt; NVME Reservation Report success
<br>&gt;&gt;&gt;
<br>&gt;&gt;&gt; NVME Reservation status:
<br>&gt;&gt;&gt;
<br>&gt;&gt;&gt; gen : 1
<br>&gt;&gt;&gt; regctl : 1
<br>&gt;&gt;&gt; rtype : 0
<br>&gt;&gt;&gt; ptpls : 0
<br>&gt;&gt;&gt; regctl[0] :
<br>&gt;&gt;&gt; cntlid : 0
<br>&gt;&gt;&gt; rcsts : 0
<br>&gt;&gt;&gt; hostid : 0
<br>&gt;&gt;&gt; rkey : 6
<br>&gt;&gt;&gt; ```
<br>&gt;&gt;
<br>&gt;&gt; I was hoping for an example on how to setup some simple iscsi =
stuff so I
<br>&gt;&gt; could test the feature.</p>

--000000000000114d3d061efaf27c--

