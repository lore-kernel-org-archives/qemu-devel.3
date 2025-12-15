Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDBCD5B16E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 13:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV8I9-0004Cx-KF; Mon, 15 Dec 2025 08:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vV8I7-0004Cn-NS
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 08:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vV8I5-00017H-Sm
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 08:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765804023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6gUl80PSWEt5wPPvkmIJU2iHQqGmRl3EzBIjkLOTxFI=;
 b=De1K2ioo4Pa0cu3j55IaNHJsAB6KBmXcDswEVxjqOV0uyfS6IyVvHAqCqV+XGeqj+nHO7p
 BZYYPL54LVnpxjZfcz8yNZCCxfJs9aFVJsOFN6XPi0YY9F69x0+3wW6enpV9YZ1bv4s8BR
 PK+WrsDZod3cn7V59Ece5+PDRfZmyQs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-hzoZpr01PIGKRw2uUg1Zrw-1; Mon, 15 Dec 2025 08:06:59 -0500
X-MC-Unique: hzoZpr01PIGKRw2uUg1Zrw-1
X-Mimecast-MFC-AGG-ID: hzoZpr01PIGKRw2uUg1Zrw_1765804018
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34c387d3eb6so1756792a91.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 05:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765804018; x=1766408818; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gUl80PSWEt5wPPvkmIJU2iHQqGmRl3EzBIjkLOTxFI=;
 b=l1pDlneGZu4kW9/14r/aqshioIw2APRXL77TGMvrS8B2tn3BMipfSdM/+8siHDCDtk
 zeQcKYYOYBJJlsd9UWrMEB1k9SpXXZ1Q9Hm2qxDYionqtjolRRLXjXanigr+2l2iYG5Z
 W4yzNI18eCJnK1ud1BaA6rbxjmdfoqpENsgZqmDgu8Xz6H8FKriV+mgMWOCSx4AmcQf+
 /7zz/tldEQkpEUIoRCYXDgsfiaIcdCgB+Kt+6v98FgxA+LgB6pTFuKqbx4y3dOYDkFT6
 FGUUJ+xmAzPAid3AiRgTov8Si2Jd1w20ap/nGJ66jz11Vhtq29aR12OBFgCN3qSsO0Q/
 h6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765804018; x=1766408818;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6gUl80PSWEt5wPPvkmIJU2iHQqGmRl3EzBIjkLOTxFI=;
 b=eiTLQ7YJxhEYx8j5W6ggHi+BPbFl+Txv/J77A3pquvI46KYP3fZ7l7jnV39FV34Khz
 5BNcrGRxiuJwkGgb+iTuKNToUbApnaTSSJxcjwFQSPIIOoKPenX+QqsFV5ILqD0YdKoU
 5kaG4cm0O/u0RUD7Cwy5O3HjnrJSYO3FyHvmBiwf8GYE3qyp3OXLppgRsCGlLVErFa/J
 WyNPeB/yi3U3icEDlNBe5fwv+a6ST3OR571UckRJ+xnF02N1Ian5vjr/1nkCKBRlivXS
 FGQBI0RzKFc4Ubcekp6wTil2E/c8ES9speNqP3TGzrb8Ru+8SngY6IR54D8jB0vvSdgB
 4I+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7uju+EaMoE2KvTNxaX3gg+I4mqtZy/qGTRS2IxRtaFvTxu5+d7kYkD2cg/fVMM6ObNdCjEFu6IblP@nongnu.org
X-Gm-Message-State: AOJu0Yykn09xFXe5UlClCt0Y4DTN3vtzfOPrj95ct7x3VpxMuaNzUIuN
 iv4/633qQCA/fv9cwPi4XIOfJlAn/nPz6HO9zm6YqGicDXeHnJ+y8UFL8UlLt1OZ6HSVMMe1DFP
 /YLwEF02jSGgy1BJN1n5FUGgcpkW+vEZTtmPxaGFmqM3CYHRT2JRjBOT8
X-Gm-Gg: AY/fxX59A6mIQtJAgi6FSyYfNb67ZCqbfHjkQ66fYoLqw14ss1fG/T63WzUze7ei8xT
 N4eJmSNzAEeA2rPkvEHNRg7Be1vVCWlo6vn9cteI/Cz2ANKsX6WVCeMeZ1C57cKqNazJdKG3f6U
 wyFndz82oovgRcJIHltxUDCu5z1VMzkkMzcOQCAstPMgr7M+LF+NENHwLEeHiixFd4qKzfhuQS5
 bzMfGRZnbNxD+pUupBbNNXsYCrxWJcRm3RV3Kb4sXVulzfwODCowjp9MncNoW46Gv0O27q/cb4Q
 1UPnXKWhu5HqcG6z8bXbbTsluGvNJNr8raSZdH7/wRf6k++hTPX/YauN3pQqDEDiqvtYAKmD/9h
 ltFRF79tEehEyGSIBQSmNCoEEm86bEjlfi4gA4RRjVeuYpcFY5yhR5CN2Nw==
X-Received: by 2002:a17:90b:28cd:b0:341:3ea2:b625 with SMTP id
 98e67ed59e1d1-34abd6d8751mr9510315a91.12.1765804018333; 
 Mon, 15 Dec 2025 05:06:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5NSIlH/2Ej2MheM/6EL3hYn3Dtne1u/Y7Lm9u0BJvllsw/QQjfDCYNKkbrG+c/zoTZG08RQ==
X-Received: by 2002:a17:90b:28cd:b0:341:3ea2:b625 with SMTP id
 98e67ed59e1d1-34abd6d8751mr9510289a91.12.1765804017835; 
 Mon, 15 Dec 2025 05:06:57 -0800 (PST)
Received: from smtpclient.apple ([223.229.163.80])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c2589d4f7sm12701824a12.3.2025.12.15.05.06.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Dec 2025 05:06:57 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: [PATCH v1 00/28] Introduce support for confidential guest reset
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <66e03fb0-d885-44db-b77c-99d8f1f43815@redhat.com>
Date: Mon, 15 Dec 2025 18:36:43 +0530
Cc: Daniel Berrange <berrange@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7A85420-46ED-43FC-8287-A4386AB98A75@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
 <aT_lP8l7lS-QlMBd@redhat.com>
 <66e03fb0-d885-44db-b77c-99d8f1f43815@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 15 Dec 2025, at 6:11=E2=80=AFPM, Paolo Bonzini =
<pbonzini@redhat.com> wrote:
>=20
> On 12/15/25 11:38, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Dec 12, 2025 at 08:33:28PM +0530, Ani Sinha wrote:
>>> This change perfoms closing of the old KVM fd and creating a new =
one. After
>>> the new KVM fd is opened, all generic and architecture specific =
ioctl calls
>>> are issued again. Notifiers are added to notify subsystems that:
>>> - The KVM file fd is about to be changed to state sync-ing from KVM =
to QEMU
>>>   should be done if required.
>>> - The KVM file fd has changed, so ioctl calls to the new KVM fd has =
to be
>>>   performed again.
>>> - That new VCPU fds are created so that VCPU ioctl calls must be =
called again
>>>   where required.
>> Presumably this re-opening of VCPU FDs means that all  the KVM vCPU =
PIDs
>> are going to change ?
>=20
> As Ani said, no - the PIDs are attached to QEMU threads, not KVM file =
descriptors.
>=20
> I can answer this though:
>=20
>> Can we get this reset functionality into KVM natively instead so QEMU
>> doesn't have todo this dance to re-create everything ?
>=20
> The answer is no.  Unlike normal reset, resetting a confidential VMs =
entails performing all the encryption and measurement from scratch for =
memory and registers, and the data is not available to KVM anymore.

Wearing my FUKI hat, between resets one can also change the state, use a =
different starting CPU state, registers, firmware. So saving the old =
state in KVM would not do any good in that case either.

>=20
> QEMU can retrieve it again, just like it did when starting the =
original VM, but KVM does not save and therefore does not know the =
original contents of the memory.
>=20
> Paolo
>=20


