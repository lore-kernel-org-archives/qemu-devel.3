Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768DAC44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 03:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkCWS-0004Jk-Fx; Wed, 15 Jul 2026 23:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wkCWP-0004JP-DO
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 23:12:25 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wkCWN-0002Jr-Dk
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 23:12:25 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-44868d6a066so1910365fac.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 20:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784171541; cv=none;
 d=google.com; s=arc-20260327;
 b=G+tZVR6ua8XhXIofeoqgXUFRvWPVNLagcQPAb7nqD2pXZRaFX2WlOZ9ZQiANknokso
 vS3+eyz1Im2bGxVnLhTqhbgy/dM32rxwbmZvTCj6AWFPkYOPjmgmBr9nqb9Vxt7Alsxn
 w1ODr24PO8F+eJz+JVm4M8MFbJ7EnlXfN43vVloqVNF5rR3jnPKqAw4GA782+gXJGFHK
 pG/I1lKU+Ytirzprbr8k2w146RgttvCwCY6t4usDjwXkPVuDxZevIE/n+4q7u38JUajw
 13Yssjogo1zcRvyd3ZUHglDVrC8fslGJrKV3irFqRJ2eJPa+bxv9Q2VLmtdvbn6w/fYL
 XwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vyTXD7ySDOCjGwGbXmWie3IsN9gh0OGDuLDAbjfL2NE=;
 fh=2FgDXYcT2rpPWrAx6xPXGLSmBVPW80aOuSRSIUZghos=;
 b=iYnjbK/knLv3n/ufvHMS24Wlf79R3FFu5oFTNleJDacA4i8kF/fgCyH+l8oyDiVgvO
 dbb8L4sxPawwdWhj/x8IfDUUNqZc/iFTn5iSAF8/JZIdEAZv13EQLWT/iJZfT1E344dT
 TAnOz81z44tXeD0BfpQBMdJMerzMZoYELsTvUVj5rYeXIb1qCGjiWDQb98YtVUqFUWoo
 ys3eGhRUYdjP3jPMYe2fC1ALuhqfvm5Pq4UxtDEptniXHPYSG77g6UhZIsxmqmBtTtB9
 yfswXiJO3verANCgZHuJt+IDpuQ8HJKTJTr1Kk4V6O6z1VASBvrRDYsnK1nimmXorpjP
 JnGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784171541; x=1784776341; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vyTXD7ySDOCjGwGbXmWie3IsN9gh0OGDuLDAbjfL2NE=;
 b=MiKcMe4bDKzHO2D+kQJH1siuZkqStuzMtSQ/B9Gyb0xtvvAcXmOYmd5AhL8Mha8WtJ
 vkCUd7Ss/kzBVGacN9Ymex+yB55aJWKQRqA8pkZfkGa8UXTEPFCRh0KojOBPgRi8OM/c
 OtLWpHh9qKJYsqwM4+OuwfVYZUVz3zDx1CCj420p1nlaWm5BOWFegqlOeOo5wEnLVLDw
 pG0vUxaR3QJJetAT+DNKToKRtDViVgp71sVfASEqLWqD+zzCKKl9NIKP+tymnPMnV2qt
 gvVLn7bxU/RRnOaQl+SIXvTqe9axcSbhQW7Y+rS8fV+Z0BC9b6dO8LNbs2bazB9xBfeC
 rmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784171541; x=1784776341;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vyTXD7ySDOCjGwGbXmWie3IsN9gh0OGDuLDAbjfL2NE=;
 b=qgxfZIpOzx16DgjLM3KlQR3RCLZk0Y+8QfbilS9AS+Q5cTqI/AHeamV47oHHK2N85O
 vcaEVqm3FBTwnlblzFpY6oRMseSmdl6uEx1jsJcLQYBod8uC1n9ntWwA6Y+E6z7+8XxD
 4LdwBPaOnQodOxiklJIYWOw/yb8tPwNewvx0rPMEWaUATRVQfqQY67qwZt3FvKaHTy6Q
 SovF9PXt34QNGtUgS7cL6wKHI3FbHC/+ginp2CLPgew+N16cK/i0+r6M8OW9XDF+8K7U
 uUW52Xd51ESzciTORGWKABMdyjLgfuPIP+spZCvzw3qy+WXSSY2oUA1X5GGsqRi4dS9z
 yoSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoN9+pFx562Df0R3Owc3W4HQc3pEMyv0b1fuKbvSmiIc5CL8sLjbr05GjoLdZQzxmJB7edRS/VzHNcJ@nongnu.org
X-Gm-Message-State: AOJu0YzJQp2ADBMdNA9T1LwWZwlnRO6wfVnDcNDovXg3SpKlGhFGeIP8
 cGeMhfBQrNSd/WojwdFDJo1KKCpumjJIonIWf7NcxdbMEJXKPc1RNNPddQZSt5Bg0zrQMOo2alQ
 jfUHN9OX1nUyetPYap5jUV3UpX0tN+pQHTQzLB15X0A==
X-Gm-Gg: AfdE7cnGydrk6CQGFScRAc+jwiC6jne3ejLj1pRizl+2BzJ687XcE+2oPp2W6PvBw/w
 qGa17i63/cZ11xdsNXzCVWdcocCxoIFiH1UVeiRcifdcp1NPV7aOLIJ07H1Fm2Fcg2lmIlwOwqh
 c8G9SFSvm26NWAvgetPFenBAaRPUUhEMnYH6Gael9f5xFNo3jzyn824i9RY3xuZzl7JromMdyOH
 1/Wlwe2p69ExatSyTDfJK6NmMV1zWIBlv8xa2UhHH6bkmiBZ9DU6QidB8J50cEn
X-Received: by 2002:a05:6808:8947:b0:492:285c:4da8 with SMTP id
 5614622812f47-4a495eab7b6mr3808975b6e.13.1784171540942; Wed, 15 Jul 2026
 20:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260209115846.2276651-1-jim.shu@sifive.com>
 <7be3b4f7-7516-40ab-8a95-b3b4a2aea095@linaro.org>
 <CALw707rbMvg1mf1S_3qiqDWbZ0qjzgx4UJ9pUGmQODKWttKFyQ@mail.gmail.com>
 <08c5f243-5aaa-4fe2-bc71-6a3fd9a1914e@linaro.org>
 <CALw707pP_5a_EeUQLRw51nLCoFo4vKkKPGaVtJJdWEqR8K-u-A@mail.gmail.com>
 <CAFEAcA8V-eNMTF6dmR2AHwSjWj_MWaijgG_inepf62BRLYo8DQ@mail.gmail.com>
 <CALw707pb5iKy-CAnVn-npdP8NRGwaz+yZKGi2ZbjafqNLNJtKw@mail.gmail.com>
In-Reply-To: <CALw707pb5iKy-CAnVn-npdP8NRGwaz+yZKGi2ZbjafqNLNJtKw@mail.gmail.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Thu, 16 Jul 2026 11:12:14 +0800
X-Gm-Features: AUfX_mxLSELIxfvXd7AwVyXuoVlWM-u8lL5RFdE4gRkEGjP1CXFu-y69FeSrzbs
Message-ID: <CALw707ozF4se+s7CUYNHY+f7xHCc5mqMiQQf+GK8eM1WrjN1qg@mail.gmail.com>
Subject: Re: [PATCH] exec: Add RISC-V WorldGuard WID field to MemTxAttrs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@kernel.org>, 
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=jim.shu@sifive.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 16, 2026 at 10:47=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote=
:
>
> CC: philmd@mailo.com
>
>
>
>
> On Wed, Jul 15, 2026 at 5:57=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Wed, 15 Jul 2026 at 07:52, Jim Shu <jim.shu@sifive.com> wrote:
> > >
> > > Hi all,
> > >
> > > I'd like to discuss this issue again.
> > >
> > > On Wed, Mar 18, 2026 at 2:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <=
philmd@linaro.org> wrote:
> > >>
> > >> On 18/3/26 05:40, Jim Shu wrote:
> > >> > On Tue, Feb 10, 2026 at 8:25=E2=80=AFAM Richard Henderson
> > >> > <richard.henderson@linaro.org> wrote:
> > >> > ...
> > >> >> Hmm.  This really overlaps the secure and space fields from arm, =
and possibly some of the
> > >> >> others as well (e.g. user, requester_id, pid).
> > >> >>
> > >> >> I don't really have a good suggestion for that right now, but it =
would be nice to not keep
> > >> >> expanding the count of these sorts of fields that somehow specify=
 the originator, but
> > >> >> clearly cannot overlap.
> > >> >>
> > >> >> I'm reasonably sure we've had this discussion before, but nothing=
 has come of it.
> > >> >>
> > >> >> Time to paint the bikeshed again?
> > >>
> > >> Last discussion IIRC:
> > >> https://lore.kernel.org/qemu-devel/CAFEAcA8vKNkfKgp_Yymo9NA1=3DE2XJY=
XAMTgO3z6q6DHgqkAwRw@mail.gmail.com/
> > >
> > >
> > > Follow the idea in the above thread. I'd plan to add the 'src_cpu_id'=
 field to 'MemTxAttr', so we can get the CPUState from MemTxAttr. Thus, we =
can retrieve the RISC-V world_id from CPU and we don't need to add world_id=
 to 'MemTxAttr'. If other security attributes are stored in CPU states, the=
y can also reuse this w/o adding more data to 'MemTxAttr'.
> >
> > We already have a requester_id field, which is basically
> > "what is the thing that is sending this request?". We
> > shouldn't have memory transactions that happen to be
> > from CPUs indicate the source in a totally different way.

Thanks for mentioning it! I think re-use requester_id is better.
Then, I think we only need a boolean flag `src_is_cpu` and we can
rename it to `requester_is_cpu` to match the naming of `requester_id`.

> >
> > > The whole plan is to add the following 2 fields
> > > ::
> > >     unsigned int src_is_cpu:1;
> > >     uint16_t src_cpu_id;
> > >
> > > src_cpu_id is the CPU ID from 'CPUState->cpu_index'. src_is_cpu is a =
boolean flag to check if the transaction is from CPU.
> > >
> > > Moreover, I think this idea is extensible. DMA device transactions ca=
n also have security attributes like world_id. We can also add src_device f=
ield to 'MemTxAttr' to store the 'DeviceState *', so we can get the DeviceS=
tate from MemTxAttr to get security attributes. If 'DeviceState *' is too l=
arge to add to 'MemTxAttr', re-use requester_id as DMA device ID is another=
 possible method to support this.
> >
> > I don't think that having the thing that receives the memory
> > transaction get or get hold of a pointer to the source of the
> > transaction that it then uses to get the world ID is a good idea.
> > (Especially not putting a DeviceState* into MemTxAttrs: the
> > size of the type needs to be kept small so we can conveniently
> > pass it around by value: we currently assert that it is 8 bytes.)

OK, I think store the DMA device ID in the `requester_id` is another
way to keep the small size.
However, IIUC, the current SysbusDevice doesn't have the concept of a
device ID. We need to add an additional device ID to the device to
support this idea.

> >
> > I think we would do better to follow the way the hardware does
> > this to the extent that that's reasonable. On hardware the
> > bus/fabric is going to provide the world ID as a signal along
> > with the memory transaction, and we should accordingly put
> > it into the MemTxAttrs. The question for QEMU is then how
> > we organize our MemTxAttrs fields so that we can share between
> > different architectures the fields that are basically doing a
> > similar job, just with different terminology or semantics,
> > so that we keep the overall size of the type small.

OK. if we prefer to keep world_id / secure / space bits in MemTxAttrs
and conbine them together for smaller size instead of adding cpu_id, I
will try to plan for it.
Thanks for the feedback!


> >
> > thanks
> > -- PMM


Thanks
Jim

