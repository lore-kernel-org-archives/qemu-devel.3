Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B070C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 21:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Gic-0002ui-R9; Tue, 08 Apr 2025 17:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dionnaglaze@google.com>)
 id 1u2Gia-0002uO-A0
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 17:42:52 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dionnaglaze@google.com>)
 id 1u2GiY-0006SP-G1
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 17:42:51 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac2c663a3daso1122252066b.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 14:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1744148568; x=1744753368; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9kRobnYoK2fs4IXh8qQND+m0DOVoSZkSj84zCGZECQ=;
 b=thRocOJI1psMycIHsbd1OkmGoSe4o9rMkG7/gGRVd2p9RJcJiQLHaK6ZAL3R/+QUCZ
 i7ZrDdiEI4EVnYkPo18Gf5wk3l3SLCYkrTVBtmntGIpzklVz8eLXucxXCODbkeC8pXiO
 VVOEH2FibRf+BdeXf5z4VA3F205t6e/1Tun2KpAreYoI1l4ijHFiauzIr3Puken/6vmj
 gG4FuEd6jkze1DSCb2sBnflTtguFgOHuPdX4Jz2za0MFhD+3sQuZ2DHv8bYWzbq27mY/
 Rk6ogF19tkvu/l1VYhKpB7grutEODON+7hTDUG1SYYRW6ahpOIjzzfPXyrwtPAv8WZvk
 KHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744148568; x=1744753368;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9kRobnYoK2fs4IXh8qQND+m0DOVoSZkSj84zCGZECQ=;
 b=NWssOTr+kbzKhxITanG1SiUtDsFbe69ixgtMqq6CamltdyGnrYcnwaoEi3/if/On9L
 vEisKY5Z5y/Wh7BA0Z8PYpaodDLvHaw2GYow144qYReCS89ewWQU7ESBzmT9kg6HKbzc
 uY0nKtHpWE20jBK8tL7HIWak6h5F/g4EN/b1DUZ+WuBg6wfrNbLHtU1EHo1z5G9F9ujg
 HVOtqj3XXjaGa3jR73WP6XSn78QRdMM9y+R5iHyi97zUQkBumnuUs/SGdBN8nQz4ZJD/
 wo260GQDbke10U4oj9zErUWcJ6alSLmYxU7pmMwjlJCzJbHCN9kkKnIfwpChEvjAAzZI
 nMNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ8flh8aH3qmBwpBeCGsxSIJiVvFdlBl+VVgZ6rqbMOrdfkG7CqDXxH3hjwldPnIcO1fpAlI0ZPcmc@nongnu.org
X-Gm-Message-State: AOJu0Yzx7nyrNaKcpGm7mVOsMiHoXS/OyPivqiInRG+tkGUQyrVnjJ58
 Db3Jd938RlS4Ob54nv+Chd/mVPQxKs8t6K+cH7+cr9ViFgjLID0PyquCsDUrWihzy/uCNZ2SZE1
 0vYAFocG4lM+jPc6lSoiGY2PIg55etaQhtD+A
X-Gm-Gg: ASbGncsU+1BzL1j8v/RjfjgdGJy5ehxLThDvIYcPjncRWTbrxRG7GJAIHWvDxoPfZpk
 Y7B+2d/Qvv/OTttY21OmBNU7ea5EkMsAPgMsmW87yQasV9rewUbRfxgLOvKqoa+qQd1QXrlLnBB
 l4jfGqRIBNX6kiW9UwP1tvapK2dw==
X-Google-Smtp-Source: AGHT+IHGNrz28aVBpnfWJGH2EjilOx5sKA5NUEbrPkJVaEl2sbT249qwzMj+i6YwJ89mcptRfdyAFtFPnGnUkUfBmCM=
X-Received: by 2002:a17:907:97c3:b0:ac3:446f:20cb with SMTP id
 a640c23a62f3a-aca9d6f4a9fmr23525466b.43.1744148567793; Tue, 08 Apr 2025
 14:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
 <CAK3XEhPYmBsn2-=PMR7qVQHiu0ydoh3EfJOEuunLccriSkKipg@mail.gmail.com>
 <53jhridwtejsuy4qojjr66rcjdebnyarwke4bs3m3w2afmqhe6@pab5zfyo46fx>
 <4f6a21a9-746e-45ac-88c7-dc0204480a86@amazon.com>
 <kmqzqeaatk3iyrpl4tvfxtfv6gefyusxpyxtz5bollw7jlp3wk@5c4zawrzehwq>
 <d79cff63-324f-4624-aef3-b6570cdb23e2@amazon.com>
 <rtbmlitus6unzibiatblquot2bthx4dmozbxgcbovisial6qar@konful7gzrsz>
 <6d815066-9977-4683-a2d5-871dda3e5369@amazon.com>
 <fwdk2pc4rfa5o22gdfqq4cfsqged4v6hmlrtqdwltgqj2bkpl4@bicazjx5d22l>
 <CAAH4kHZhEX0kaE3r5PVOOWh1PhzZNOfyWMixDm0PbCnjfmZceA@mail.gmail.com>
 <xjdm7m65w6hmnq3ik2psbfhizypk76c3hdriujh27kcm7ex5tv@7lq3x3k7y52h>
In-Reply-To: <xjdm7m65w6hmnq3ik2psbfhizypk76c3hdriujh27kcm7ex5tv@7lq3x3k7y52h>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 8 Apr 2025 14:42:36 -0700
X-Gm-Features: ATxdqUGyRogAIjBi2rJE7BarXNqMRrZWYArr9FTAsK5yMScPTFi9bLf3wv9xGZw
Message-ID: <CAAH4kHbFBekcmxBQcOA9K1Y+sFc2Jf56YEa4iv0M88ib7pCjgg@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Gerd Hoffman <kraxel@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=dionnaglaze@google.com; helo=mail-ej1-x631.google.com
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

On Tue, Apr 8, 2025 at 1:33=E2=80=AFAM Gerd Hoffman <kraxel@redhat.com> wro=
te:
>
>   Hi,
>
> > > Well.  If you want put the db into the igvm and the igvm into the uki
> > > you've got a chicken-and-egg problem.  Moving the firmware from the m=
ain
> > > UKI to UKI add-on would solve that.
> >
> > Why is embedding a public key that will sign the IGVM in the IGVM a
> > chicken-and-egg problem? It's only that if db were a list of
> > acceptable measurements, which it isn't.
> > I'm not sure why relying on secure boot makes any sense for
> > confidential computing. I still think that tearing down the VM context
> > and rebuilding it is more secure, given
> > the need for an honest launch measurement/MRTD.
>
> Current idea is to allow passing EFI signature databases for db/dbx to
> the firmware getting loaded.  The signature databases must be part of
> the launch measurement.  Not clear yet how exactly to handle that, one
> idea is to add a special page type to the igvm spec, so a igvm parser
> can easily find and update db/dbx.
>
> So, the VM context will be rebuild, the igvm (including db/dbx) will be
> measured, the firmware can verify the payload using db/dbx and standard
> secure boot hash/signature.
>
> This allows to use both signing (pass CA certificate in db) and hashing
> (pass authenticode hash(es) in db) for payload verification.
>
> The chicken-and-egg problem arises if you go for hashing and want embed
> the igvm file in the UKI.

I don't really see how signing the IGVM file for secure boot helps anything=
.
The VM context will be reconstructed by the hypervisor, and anything
checked or stored before loading
the new firmware is suspect.
SEV-SNP has IDBLOCK_AUTH to have the SNP firmware check a signature,
but TDX has nothing of the sort.
Your initial measurement is checked by nothing trusted.

Do you need the UEFI_APPLICATION that uses the vmfwupdate interface to
be signed for secure boot? Seems unnecessary.

>
> > Revocation is just not a real thing that works. Short-lived policy is.
> > Policy services can be updated more simply than the UEFI variables of
> > every node in the fleet.
>
> In the model outlined above you'll go ship db/dbx in the igvm, so the
> launch measurement will tell you what is allowed and what is not.  Which
> in turn can be used in attestation server policies.
>
> take care,
>   Gerd
>

--
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

