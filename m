Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A80C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 15:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZuee-0008MU-AL; Fri, 02 Aug 2024 11:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sZued-0008Ls-Jw
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:57:19 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sZueb-0001tC-I7
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:57:19 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7ac469e4c4so614832366b.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722614235; x=1723219035; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pQAFKOPNB+4y9yf4Qsr2kFSCrNmKo53sTuSiQ/lpvNA=;
 b=f5Xv2cGHRPZ8N41mHy94Gk1Hj10GqwER4AzcB8JHaM8bP1usHwWgJ/ojMky0k1/LUy
 5G+3aUlgmj6fpmMYjYHvVxDRnNQjwg5hOvONXA7mhjNXJnPifvSzG2y8f7aDB/+sxlRe
 NWHFTINgAWOrIPGH8t437s/8w4b9JEw6+EhnuEC0YT+SfvlrllSa5htq5+i3fKTO8Krr
 +mMCPyfs7D6sl7WOyf9SBuQyfivzm3HskfM4ViGZig5W+NGLT97BdmupOzLd4QXWDoge
 fgcyR24I7o7/nIkHTz7+2Q1yzsDioB66H5LB/PWwrW6buFHcFqe5HtxloWFnK5YbPvYk
 fFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722614235; x=1723219035;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pQAFKOPNB+4y9yf4Qsr2kFSCrNmKo53sTuSiQ/lpvNA=;
 b=ComyZW/7l2O5nNCCkR3NKC6fomM2AJ9Jrr3S0GlM0RTzH0Rse9mPBAkqpg0RWYu+Sg
 Di2T0/ch6/pTyh9V6LOJvtak33I4mLto8kdOe3eD3aQydanSAp0UrbgzFTtaKcB9PQ6w
 o+8Oojea7KH3/uxMCDImfg4A6KejabBlN2Owv/n9e/EQWwF+wDQeiIzSHIz5HJdgr8UD
 iSo+STMNxoHsjTPcHaOROhWFO1I257bhoEf9Sl8FvHpBkRd75iYfmJF22WJBCVEv01rF
 +QPXEIdpRFCs5H6TV87iUZ7rvf0B93FRXetBcRlznL54U63tUUIebTsc5lnq9lLls8kl
 Ozag==
X-Gm-Message-State: AOJu0YzpkVfd1aj1W/2GAPkoPfGAg9oAGasaVRPHOChCraPaB83mnrpE
 zxtqGKbry+lri25GSb+KcVF01ErqXlAibr6ejysYI/4GtjW5J/u+ad2kScEK7vQ=
X-Google-Smtp-Source: AGHT+IE5VjlMHTcP8gDaHEPpKrNA47xcCZVJbDu6x2A731ELwzmrZDxxRlhN8btJc/r/btx6NW4OqQ==
X-Received: by 2002:a17:907:7290:b0:a77:f5fc:cb61 with SMTP id
 a640c23a62f3a-a7dc5cfc963mr353516566b.0.1722614234539; 
 Fri, 02 Aug 2024 08:57:14 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c9c4sm113564666b.66.2024.08.02.08.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 08:57:14 -0700 (PDT)
Message-ID: <826f5161946e4a26f9c1c6a08fdbf826d622d5b2.camel@suse.com>
Subject: Re: [PATCH v4 00/17] Introduce support for IGVM files
From: Roy Hopkins <roy.hopkins@suse.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>,  =?ISO-8859-1?Q?J=F6rg?= Roedel <jroedel@suse.com>
Date: Fri, 02 Aug 2024 16:57:13 +0100
In-Reply-To: <ZqEr-YpjHHM5cT07@redhat.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
 <ZqEr-YpjHHM5cT07@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=roy.hopkins@suse.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 2024-07-24 at 17:29 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jul 03, 2024 at 12:05:38PM +0100, Roy Hopkins wrote:
> > Here is v4 of the set of patches to add support for IGVM files to QEMU.=
 This
> > is
> > based on commit 1a2d52c7fc of qemu.
> >=20
> > This version addresses all of the review comments from v3 along with a
> > couple of
> > small bug fixes. This is a much smaller increment than in the previous
> > version
> > of the series [1]. Thanks once again to the reviewers that have been lo=
oking
> > at
> > this series. This v4 patch series is also available on github: [2]
> >=20
> > The previous version had a build issue when building without debug enab=
led.
> > Patch 8/17 has been added to fix this and I've updated my own process t=
o
> > test
> > both debug and release builds of QEMU.
> >=20
> > For testing IGVM support in QEMU you need to generate an IGVM file that=
 is
> > configured for the platform you want to launch. You can use the `buildi=
gvm`
> > test tool [3] to allow generation of IGVM files for all currently suppo=
rted
> > platforms. Patch 11/17 contains information on how to generate an IGVM =
file
> > using this tool.
>=20
> Am I right that, currently, we can only use this IGVM support for plain
> SEV/SNP boot *without*=C2=A0 SVSM ?=C2=A0 I'm told SVSM has a dependency =
on host
> kernel KVM features not yet upstream, and I presume this means also needs
> further QEMU patches ?

Yes, you are right in that the host kernel does not yet support SVSM. Howev=
er,
I've tried to ensure that the IGVM implementation in QEMU will not require =
any
further patches when SVSM support arrives in the kernel.=C2=A0

This obviously cannot be guaranteed as it is not clear exactly what the SVS=
M
support will look like, but as an example, take a look at
https://github.com/coconut-svsm/linux/pull/6 which is a kernel branch that
contains patches to support hosting COCONUT-SVSM which works with this QEMU=
 IGVM
patch series at V4.

>=20
>=20
> With regards,
> Daniel


