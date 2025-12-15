Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B1BD41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 10:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV6H7-0007jE-1h; Mon, 15 Dec 2025 05:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vV6H3-0007iX-P8
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 05:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vV6H1-0007JM-Vw
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 05:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765796269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ow/Q4ZR2DKljZANqWsJMAfUlQBtvd/Z9C3rCByzO63w=;
 b=c0odHVdr56gy/zt0u+GQF9X8cqk4Xlh8Uf2LHzdpUSZzVwI47OQYsmkstpi4pxyniTx0MO
 kxyUB4JjWUYBAPnlcQxTSM4uFamt6n0jUmsswlVIJtzBPThNmv0sTHMCvgAdTm2HJ0+rsC
 bnlaZSKUwSHT3eqrAzeYViz5vTS7E2g=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-M3DKAKD_NJefPdAoY2SyDA-1; Mon, 15 Dec 2025 05:57:47 -0500
X-MC-Unique: M3DKAKD_NJefPdAoY2SyDA-1
X-Mimecast-MFC-AGG-ID: M3DKAKD_NJefPdAoY2SyDA_1765796266
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a0d058fc56so15917135ad.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 02:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765796266; x=1766401066; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ow/Q4ZR2DKljZANqWsJMAfUlQBtvd/Z9C3rCByzO63w=;
 b=iSt/Ohl1zYoXZj5mIQDFogYObBKF4nLHGoq8SdKf6Bc5j2+AIBTLLCyTyGoOsnzer4
 44renp4y344o+pgkeZs501R1Nkrgy5QHaUNrK3W4KV1AZmNSckd4VLrngZCraGQLomo/
 GMfRXGl/I4qE+s62+TDjMeg3aWxczWhH/etpt4sTcFkapQv4+eRDnIwQmRTVRIHEierq
 6+O1nr/gSRlfKOWtF1IAV3nYC8swCdIORyAdUoCGH5fO9Hc98XFueARYSElHkuZlMGf8
 0LgFrw1s56VWHS5+IRkDZGG9dILakPkz4KdtZ+HZam7WpMoHf52/ct+EcYkQ2IuSS5Ge
 3SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765796266; x=1766401066;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ow/Q4ZR2DKljZANqWsJMAfUlQBtvd/Z9C3rCByzO63w=;
 b=id6wL3Tk0BiGSRAp/WhHO77MRQFZupgPOKkeXT/MZM4Uzq6vK29IZeaxJziB9Ua0nC
 49MaBgQ4AGdH9LJwi/2BBKHWeCIRk//py4XQ/8Tuf8TaMJsf5MYBf3xg1WtEuusQ2m7x
 cvYd6pB7iaq9W6XkhOLDw91Y8EeaWHDApKTsgp55jQddPGJOPnM8c+XGYvzpmHcY7bU7
 R3kZ+gVMaXZQ91xKIit+NCqs5xw3hO58lVFApRjzBVp/vb5eZvmF8/os27FIvpFeWQJg
 3n/i/Z/uwzccAR1XYOqpQb0WJMjPS+j/0/WvroRosWNGUNIg2+e+jbc5uO1k/gOkMA2R
 DOJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAO5Ts5AHiO/SmJFnG2uSpvGboP7AgYo88olw9w2+7MKgrD8hC49Xoi3BMmMKG91JS9NFdwWo+xmIi@nongnu.org
X-Gm-Message-State: AOJu0YxlWk/2hDdZ7dMfegZV9nH0dLZ7Of/muvSjVU7CGXJxHLxO1zbd
 A4gW+d9WZG55cVl8Bd7mKAEkNdjHtTdyncLwLbqeS06oyfehrjaTLfQHhggbFX4vkCNcbZ4bz/l
 wojlXyO02xgh+H1cjm+sLrE/+tKnBrenPWZw5q+M6WzzfGmn6GWWr5IRo
X-Gm-Gg: AY/fxX7ZXvyBPUkI6DeSV+a5LjPiY3yoKUb0CeVN4ojuweh6uOSyTvNl+GvVZ6LXt5x
 wBzfIQWBJNmbEantdPZsbXINT4M6CLgM33ejYngHL+qCkwsrku2KRB64z94A9zIjp40Xo2e1jtJ
 uoQFDn7yO6mJ2JP7YrWjf0BUfQsSHI5Iv3FLQ+fx+nRf3VMGWQREkSXqzi8w4fD1RToVnlt9D5G
 pfp1v+EGTF3Xoomd2ew3qD1tsb1APbEdlSYZkJtYZ9d/ZAPpRDs5wKh62QzfBoKmTCKM7Qw+rly
 64qfcjYCgEiLN+q8qvktDWfm2yKlXpc2aElXzFGiHI8apM+v4ziG4WExQsu8HXH4p2IwZhP+1FF
 StdzonoJUsdBHxjS1kzsdAe+rDfBhCIMiDKOAXevQVUDtjV9f+qIj6NP5sg==
X-Received: by 2002:a17:903:238b:b0:295:5b68:9967 with SMTP id
 d9443c01a7336-29f24484ec0mr105220015ad.49.1765796266413; 
 Mon, 15 Dec 2025 02:57:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECz4ON7Bj7v/JllUIQe3rv8qfodGg3aun/6Su+UYI2GKHiHTxOoS/wFS6OyhQ+MNGyaqEPHw==
X-Received: by 2002:a17:903:238b:b0:295:5b68:9967 with SMTP id
 d9443c01a7336-29f24484ec0mr105219875ad.49.1765796265978; 
 Mon, 15 Dec 2025 02:57:45 -0800 (PST)
Received: from smtpclient.apple ([223.229.163.80])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a0833e24fasm78615805ad.61.2025.12.15.02.57.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Dec 2025 02:57:45 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: [PATCH v1 00/28] Introduce support for confidential guest reset
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <aT_lP8l7lS-QlMBd@redhat.com>
Date: Mon, 15 Dec 2025 16:27:31 +0530
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0E616C9E-3C41-487A-8683-1B83DF3508C3@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
 <aT_lP8l7lS-QlMBd@redhat.com>
To: Daniel Berrange <berrange@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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



> On 15 Dec 2025, at 4:08=E2=80=AFPM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Fri, Dec 12, 2025 at 08:33:28PM +0530, Ani Sinha wrote:
>> This change introduces support for confidential guests
>> (SEV-ES, SEV-SNP and TDX) to reset/reboot just like other =
non-confidential
>> guests. Currently, a reboot intiated from the confidential guest =
results
>> in termination of the QEMU hypervisor as the CPUs are not resettable. =
As the
>> initial state of the guest including private memory is locked and =
encrypted,
>> the contents of that memory will not be accessible post reset. Hence =
a new
>> KVM file descriptor must be opened to create a new confidential VM =
context
>> closing the old one. All KVM VM specific ioctls must be called again. =
New
>> VCPU file descriptors must be created against the new KVM fd and most =
VCPU
>> ioctls must be called again as well.
>>=20
>> This change perfoms closing of the old KVM fd and creating a new one. =
After
>> the new KVM fd is opened, all generic and architecture specific ioctl =
calls
>> are issued again. Notifiers are added to notify subsystems that:
>> - The KVM file fd is about to be changed to state sync-ing from KVM =
to QEMU
>>  should be done if required.
>> - The KVM file fd has changed, so ioctl calls to the new KVM fd has =
to be
>>  performed again.
>> - That new VCPU fds are created so that VCPU ioctl calls must be =
called again
>>  where required.
>=20
> Presumably this re-opening of VCPU FDs means that all  the KVM vCPU =
PIDs
> are going to change ?

Only vcpu file descriptor numbers are going to change, not the PID for =
the corresponding threads. The same thread is going to be used.

>=20
> If so, this is a significant semantic change that will break =
management
> applications. vCPU PIDs are exposed in QMP and applications like =
libvirt
> query them upon QEMU startup *BEFORE* vCPUs are started, and then do
> things like setting CPU pinning or NUMA policies against them.
>=20
> They cannot re-query the vCPU PIDs at time of reset, as by that point =
QEMU
> has been running guest code, and so mgmt applications must assume that =
the
> QEMU process (and thus QMP replies) are hostile. They cannot trust the =
vCPU
> PIDs that would be reported as QEMU might have been compromised and =
now be
> reporting vCPU PIDs of a completely different process as a form of DoS
> against the mgmt app.
>=20
> Can we get this reset functionality into KVM natively instead so QEMU
> doesn't have todo this dance to re-create everything ?=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|



