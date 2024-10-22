Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC869D15DBB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 11:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3D6v-0007tC-Ch; Tue, 22 Oct 2024 07:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1t3D6t-0007sY-H4
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:31:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1t3D6r-0007hb-Os
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:31:35 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37ec4e349f4so3054889f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 04:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1729596691; x=1730201491; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xkr82NUDudlbiBxWMD5a6FTwo9ru8kEZOYwBieRwxVo=;
 b=a75eZw6/nYrV6EQKdcvu451aHUP5juwhbW1vJiajNZuDZXes613lwSRP1kc0TdahEG
 0bQ43nXEi/DX2+HFaoxW1Y0rj2551QvoFTnTl0Mgs/2mKP2IELIa/4ioQFxRhm0i5nfz
 zBmkz2998IB2ZJeUQphi/1uzfovxOtBgok7QlplFWrMafzJCDWeQWXsAF7EPm38DShKZ
 byptqZSBPuZEobMUzkYGuWN7wYlmSla0GYAcmmb864/meDeKSxAGhyFlkhTQLZNzFbG1
 IbvlVPnIjCi7Q7jesCayL2U4UeLrTWaxo79rEwjAnuynH44gYu1kY7SS+DFfCmv9ar2+
 UnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729596691; x=1730201491;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xkr82NUDudlbiBxWMD5a6FTwo9ru8kEZOYwBieRwxVo=;
 b=uCLH+5blgc9soMqI8fYH4i/Ce0s6taUb/FmCKgU1YVewflEMC1kqJG0YBaWabMKPwD
 uKJbXQxLNLoBW0SRbHwKnuw2CrxlVm4c7SeQMDqcNZc2pz7rYOjfUC9fMw7q6ubBZ+Yv
 3yDS4+EEymSFeWINa5rMpCqYAuaQgu5CyoS+kmIop89BIN500v7TUHjEcj1RG8E/cVX3
 vORL928hr9fs0b+s5oVuHVum1frqw6a1dtlARfVknTrxWGPc+KVv0eQXLo8IYytLMnTl
 rHnwrE0cH7OfLYFwA4Cig3XDizXytVFfOJWgcm5pl4kI+dw49KwgY/uj9qAedchUH2HO
 GXvw==
X-Gm-Message-State: AOJu0YxAW/Ijb43te8DILmzwh5skPmM5xtZzbbcYMIAEgMfmPhPCHa6U
 4CKdquIuJuLPGPEOuk1rWpJEdKCQ6TolC/wYJYu8dsCeAoBqntvmQRONZ+1kSVI=
X-Google-Smtp-Source: AGHT+IFHA5wUr2acLf5RHBJv2V9VL+5TsVHBsQdLcbC5+Gt2lTQy1FUp6QLNBqzAPCjwm3C2GN/sSA==
X-Received: by 2002:adf:f783:0:b0:37c:d1bc:2666 with SMTP id
 ffacd0b85a97d-37ea214022dmr9200519f8f.4.1729596691191; 
 Tue, 22 Oct 2024 04:31:31 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a37aecsm6458485f8f.8.2024.10.22.04.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 04:31:30 -0700 (PDT)
Message-ID: <0bc1682c46eed2805156e04b61c35c8a6a5549c7.camel@suse.com>
Subject: Re: [PATCH v6 00/16] Introduce support for IGVM files
From: Roy Hopkins <roy.hopkins@suse.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P ."
 =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia
 Huck <cohuck@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?ISO-8859-1?Q?J=F6rg?= Roedel <jroedel@suse.com>
Date: Tue, 22 Oct 2024 12:31:30 +0100
In-Reply-To: <mz4kfys6rljozu64ow6q2hpokf2zghn5f4onummomu23wivvro@pr4hhhjoq45x>
References: <cover.1727341768.git.roy.hopkins@suse.com>
 <71c6e846d1988f985e9902909a75f6f5a57a2967.camel@suse.com>
 <mz4kfys6rljozu64ow6q2hpokf2zghn5f4onummomu23wivvro@pr4hhhjoq45x>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=roy.hopkins@suse.com; helo=mail-wr1-x429.google.com
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

On Tue, 2024-10-22 at 11:05 +0200, Stefano Garzarella wrote:
> On Mon, Oct 21, 2024 at 03:44:26PM +0100, Roy Hopkins wrote:
> > > Here is v6 of the set of patches to add support for IGVM files to QEM=
U.
> > > This
> > > is
> > > based on commit a5dd9ee060 of qemu.
> > >=20
> > > This version addresses all of the review comments from v5 [1].
> >=20
> > Hi all. I'm just drawing attention to this series again.=C2=A0It has be=
en through
> > a
> > number of review cycles and all outstanding suggestions and changes hav=
e
> > been
> > addressed.
> >=20
> > Are there any further changes required before this can be merged?
>=20
> LGTM, I think I reviewed/acked all of them!
>=20
> Thanks for this work,
> Stefano
>=20
Great! Thanks for your review Stefano.

