Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DC3CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8OM0-0005oV-TO; Mon, 13 Oct 2025 15:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8OLz-0005nV-7t
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:37:07 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8OLw-0004Ff-LK
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:37:06 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e430494ccso26489035e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760384221; x=1760989021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILvSF3WsZxulQy/peuKeQc/syQw8y66TKZyReDbmr2U=;
 b=TEYObowgjAeXulIcp9ZP7SqMxERQv0lHtSW4pUKde+HT04hSbZ51KpSmXjfD9Cbzt1
 QU2fOj6p7Ic0UlDKyTbhyNKw/+fj3N5mGvr0SDkSQbLrDcElj2PXMmVA9zqca3+73Uue
 H7suK488Y9enQLEpjzQ9SAFMxGdR9y4LqHxjbk9ilPPeb/9XCgNX5SRaPu0Q4PFULw8c
 Sb1KyQyhIPlur6Ut1fBFMpmYUCfKTumsVGImNeVUKqhbASchGaeFTgQ+54/tAuWoEo9D
 MeOvL5A1O5TblriejORpIVZ/tFsoPKpnbMcny57rAtCe1hcNmC8qC6fphUORv1YFsykg
 sqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760384221; x=1760989021;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ILvSF3WsZxulQy/peuKeQc/syQw8y66TKZyReDbmr2U=;
 b=WB+uLZ1VLJEZFj9SQDx+L7c75ohVrjX9cy1U7LxVMxmcSC+kv4Swe/6mFae5f+MTEY
 biGsNo2jDkI9BonJN/lgxy9pkxoHOg9yIgCi69TRyida42xUEtceBT4Uce0SYxON1V+z
 yFYxfro5PgWPOVuap31JrR6kwPn2CKPpY9M86TacPEQlMWJjHwTck4TBc7Um5IG8Tu2t
 8jvttgCjO8WlPB9/cGier3faCH2U7Z115UbT1T1v7gC4CL872yMH4MFn5CkQTjtaEDM3
 IirxyqM/FUe10Ogi2uQK/JopuU0tG93qpUwn1wYlUXhEb2gGEDXkHWadEpN16In6UxNE
 0Qlw==
X-Gm-Message-State: AOJu0YzNTqmKHC1tWzqFAxTK0ERQyKk0Bb8ybUrzB/e3l67iYyxxa6CM
 E3UXvX6yHZIWH9PX51sQ5HugvMdNeJEpHvRiGPAKYLrCqBVkRvZHod5Z
X-Gm-Gg: ASbGncuAujBTe2skfbu7D7zV20TED8lS+OeIuvd/37g4KUF5XFKu6bQ0BXn5SRWGT5g
 uxykM5strpfG87uCkFFozE6nEbETOWdSKQg8RNrSFtcCOpFB1s5eEbJBnxtsaGlTNXxkx6GEWsQ
 Og/DZxaomuIHdtz2k+naSIsunfR+zuC8uDUQ8mCSSPug6suyFkfx2QN2POcXSNlXqWRZR2tnSuD
 Lfy6rv/bsGPN8OthhwSkcei8ro17nReHkXle33FhpCZ4p69dGQHNR31k9jFs98V3ad+Rzh5NxQN
 m67yNIENK4n92fiqgJvaupE2nvcqtK0Zr4MJUa7U7LVx6tH3FtaEB2MYK4GzuG51AsWezfLiMbX
 qjOuhFLTEVguWlYl9w6sVmiefP3dtS+2bQPRWqoWAEWbxZq4UpsKGo254Lt2+uct2EA0uq8WKPl
 7AkJGYIVv+LhCgn208WEV73UrMXLTvzB5pDABNwU7VupNijZhjg6w13VV2Oo4=
X-Google-Smtp-Source: AGHT+IFeDrtycQwIlQn5eUkVGNVAemXbvOWCVKTpe5BdQRh1U0cMNYkoU7+TPAr/8iDHuANbd6Qwkg==
X-Received: by 2002:a05:600c:628b:b0:46e:4814:4b6f with SMTP id
 5b1f17b1804b1-46fa9a942b1mr164926605e9.2.1760384221325; 
 Mon, 13 Oct 2025 12:37:01 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf27140090f580845fcf2f0a.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:90f5:8084:5fcf:2f0a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fc155143fsm141394485e9.11.2025.10.13.12.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 12:37:00 -0700 (PDT)
Date: Mon, 13 Oct 2025 19:36:58 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH=5D_docs/system/security=3A_Restrict?=
 =?US-ASCII?Q?_=22virtualization_use_case=22_to_specific_machines?=
In-Reply-To: <aOzm2ukHfkPF-zhT@redhat.com>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <20250908104125-mutt-send-email-mst@kernel.org>
 <46AA9C03-CA7E-4C4B-AD05-A9053666BA52@gmail.com>
 <20251013070945-mutt-send-email-mst@kernel.org> <aOzm2ukHfkPF-zhT@redhat.com>
Message-ID: <FB00047D-8A4F-4725-BC20-AD809DE70098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 13=2E Oktober 2025 11:47:38 UTC schrieb "Daniel P=2E Berrang=C3=A9" <be=
rrange@redhat=2Ecom>:
>On Mon, Oct 13, 2025 at 07:12:31AM -0400, Michael S=2E Tsirkin wrote:
>> On Mon, Oct 13, 2025 at 10:40:36AM +0000, Bernhard Beschow wrote:
>> >=20
>> >=20
>> > Am 8=2E September 2025 14:45:40 UTC schrieb "Michael S=2E Tsirkin" <m=
st@redhat=2Ecom>:
>> > >On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
>> > >> Currently our security policy defines a "virtualization use case"
>> > >> where we consider bugs to be security issues, and a
>> > >> "non-virtualization use case" where we do not make any security
>> > >> guarantees and don't consider bugs to be security issues=2E
>> > >>=20
>> > >> The rationale for this split is that much code in QEMU is older an=
d
>> > >> was not written with malicious guests in mind, and we don't have t=
he
>> > >> resources to audit, fix and defend it=2E  So instead we inform use=
rs
>> > >> about what the can in practice rely on as a security barrier, and
>> > >> what they can't=2E
>> > >>=20
>> > >> We don't currently restrict the "virtualization use case" to any
>> > >> particular set of machine types=2E  This means that we have effect=
ively
>> > >> barred ourselves from adding KVM support to any machine type that =
we
>> > >> don't want to put into the "bugs are security issues" category, ev=
en
>> > >> if it would be useful for users to be able to get better performan=
ce
>> > >> with a trusted guest by enabling KVM=2E This seems an unnecessary
>> > >> restriction, and in practice the set of machine types it makes
>> > >> sense to use for untrusted-guest virtualization is quite small=2E
>> > >>=20
>> > >> Specifically, we would like to be able to enable the use of
>> > >> KVM with the imx8 development board machine types, but we don't
>> > >> want to commit ourselves to having to support those SoC models
>> > >> and device models as part of QEMU's security boundary:
>> > >> https://lore=2Ekernel=2Eorg/qemu-devel/20250629204851=2E1778-3-she=
ntey@gmail=2Ecom/
>> > >>=20
>> > >> This patch updates the security policy to explicitly list the
>> > >> machine types we consider to be useful for the "virtualization
>> > >> use case"=2E
>> > >
>> > >This use-case sounds reasonable to me=2E I also imagine that
>> > >some machines can get fixed down the road perhaps to
>> > >the point where they enter the "virtualization use case"=2E
>> > >
>> > >However, since we are
>> > >getting this elaborate, would my old idea of a runtime flag
>> > >make sense now?
>> > >
>> > >To recap, the idea was to add a "-virt" flag that will
>> > >block any machines, devices and so on not considered
>> > >part of the "virtualization use case"=2E
>> > >
>> > >We could also create a mechanism for downstreams to
>> > >tweak this as they see fit=2E
>> >=20
>> > Hi Michael,
>> >=20
>> > Thanks for confirming that the use case seems reasonable=2E
>> >=20
>> > For now, we'd like to sharpen the term "virtualization use case" to a=
llow for KVM to be usable in machines that aren't inside the security bound=
ary and where maintenance commitment is unrealistic=2E The current approach=
 is to adjust the policy and to spell out the machines where these commitme=
nts are made=2E
>> >=20
>> > The trigger for this RFC was to be able to add KVM support to the imx=
8mp-evk machine=2E I have it working but can't currently upstream it due to=
 our policy=2E It asks for unreasonable work and commitment which adds an u=
njustifyable burden on the maintainers=2E
>> >=20
>> > I do see a need for further enhancements on the broader topic like ad=
ding a -virt switch etc=2E Maybe we should come up with a different term th=
an "virtualization use case" which appears to leave a lot of room for inter=
pretation=2E I propose these topics to be addressed separately=2E
>> >=20
>> > What is missing for your R-b?
>> >=20
>> > Thanks,
>> > Bernhard
>>=20
>> rebase on top of this:
>> https://lore=2Ekernel=2Eorg/all/20250926140144=2E1998694-1-berrange@red=
hat=2Ecom
>>=20
>> if there's anything missing there, add it=2E
>
>I don't think that its desirable to rebase on top of that series,
>as it is liable to unduly delay Bernhard's work=2E
>
>With a very minimal wording tweak our current defined policy could
>avoid being a blocker for enabling KVM in imx8mp-evk=2E In
>
>  https://www=2Eqemu=2Eorg/docs/master/system/security=2Ehtml
>
>where it describes the "virtualization use case", we could simply
>tweak it to always require a versioned machine type
>
>Change
>
>  "These use cases rely on hardware virtualization extensions
>   to execute guest code safely on the physical CPU at close-
>   to-native speed=2E"
>
>To say
>
>  "These use cases apply to versioned machine types when used
>   in combination with hardware virtualization extensions
>   to execute guest code safely on the physical CPU at close-
>   to-native speed"
>
>Since imx8mp-evk won't be a versioned machine type, it is thus
>trivially excluded, without us having to enumerate all machine
>types int he docs=2E

Yeah, requiring the machine type to be versioned makes a lot of sense to m=
e=2E

Peter, what do you think?

Best regards,
Bernhard

>
>
>With regards,
>Daniel

