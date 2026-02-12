Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA06EB48EC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 09:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqT6l-0007pO-Bh; Thu, 12 Feb 2026 04:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqT6j-0007o5-CS
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 04:35:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqT6h-0001pK-Dy
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 04:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770888929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6kZCUvfcUN0sqrLcIwVqiFlS3h7Q2YDKZdlgvZICkg=;
 b=T3+lLfWV5r3jvCNvb63BfBm8afuqfPI6livR+kAKbx1FKmGX/Px8plSMNj+M94uYqrhDrO
 KZ9PGeKxGpPoX1Lrypwd5rkjri0fMD6U5+WdjYuwKV8k41dwACprYkw6AWFZeFkWuI2May
 QlTKnKx0F2tsOhF25J5/LNdH8NT+bJI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-Ws80MJK2NFmfKs0cFmT6VQ-1; Thu, 12 Feb 2026 04:35:27 -0500
X-MC-Unique: Ws80MJK2NFmfKs0cFmT6VQ-1
X-Mimecast-MFC-AGG-ID: Ws80MJK2NFmfKs0cFmT6VQ_1770888927
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-824a02e4d29so758689b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 01:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770888927; x=1771493727; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6kZCUvfcUN0sqrLcIwVqiFlS3h7Q2YDKZdlgvZICkg=;
 b=OfRCdzMUtoGZ529RL+GsEgk29nvp/s6+wkFnIkABCCIk+cG9kGBCSIWtsZMofw7XXX
 AeJBK18xcGpvLL5SLcX9+0BCBteQmAqq0cccopX0etJto4nm0jcT8FgNviJAzFOpYIg5
 C3uSMPY0OQprOTfZ4AaCVyvwiNitw+l9/BDnRrYkaRsA1HbkGNFHWoncOhqQKqAf5aQI
 ju9sHIM0JDwcfzDnvKZTNqfAOoSor74CsYWVJ3bXizOIbrkj8I1XuXwKoUfXLBTxg4Ir
 lR6uNvdUuy/AVEHRcaWQBaYDQSwmJwbpMGMGPpqWcTxLZ7pgZJUt7sc0JwbFXMEVXSqw
 x45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770888927; x=1771493727;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r6kZCUvfcUN0sqrLcIwVqiFlS3h7Q2YDKZdlgvZICkg=;
 b=MIhqnmv2Lh7+ytf1MT8tbOdnNFuoYSz/clY1hfobBZ6GWA2ktwGp6iMyCQXtVvBjuO
 pUHtFlk6Fx7j0kXCxI+TRrlAwLACWAklPF4VfaEz66dbXgIma+cnYbL5AKm2vZpQbcrg
 hPqxj4+R5pv6Q3MekLQ6nDwbxQ69M1v7Ld2Gl8LoRwA4jMPHaeqiEBn9AxCCB/iI/tQo
 ak0Sx8EE2x2ty9ew8b112EU5rWKghxtfyH+Ht5SyECOVHk0Gcpg9JSl08rmfNfkrWZk0
 owzVpOtYXCQjWJsmLZWsUrQKAYEhsMA7bVCNzfnL6AW/jmCkOcVkKAIBdtiB9HSFk8Kb
 RlLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc5bWKcGnEFm35k8bjApsO9ipOpCIrmh5yqhdGTkRh4xFgKpQ4GYD/+Snnytg4KfNZketlVQ79SS8h@nongnu.org
X-Gm-Message-State: AOJu0Ywe9lXE+DdEEapIbwE5squIX4ZMvDlM1B8C5RmTsg9Wiq/1GIJg
 3dwLnbgpNq/4y9PGhNDaLN7y+E5WAid0nXxGkz7H7ucg8px1VbvxpPC5eMa4NO+QWXTfzHsUnPv
 /2ih/nExRu7gbyHAxsHAUSr5YpM2Ap9eYGAVpzfciZWC+gy+lOe5SKoln
X-Gm-Gg: AZuq6aIvm3XtjBrnhI3Sj1OS28ljLTFFSxMgob4rbpyOwl7dehXE4E3B/Vev/m6uG+C
 teSi3MyLnhfz2Rs7YRR4WQMAO3+K+ec4nJ92wgYCIExQbJ1gB1tx7hB3EH7blth5PrGq7QVxsU1
 kgY4Pn9xbx46A7Abctvslyl/NVfdOSF5fSJTT6zvr6+4oAk5uba1Yb6ZheIuBIyE5Nw2DEGmfHG
 7TmjgMNXskt4dgWqVP3yO+vBXzDb/meWJlL31nWWF4Abxy2pl7yPKhstsIM2qzHttG8Wn2zDldz
 +5GD1AwTydnOHEL/n7wMuFNPDOwyZlCrG6AlQAfML+DF4GH/HL2+dqtfbQG5XuzUJfRB/58eQ2l
 cXrn7i7rOINzLUZ97uZUVJjkq+ZQWu7tMcnKK9XNAaqZXW/7+X1/6Abmho2SN6vijh6ujcA==
X-Received: by 2002:a05:6a00:1da5:b0:821:70e7:b10a with SMTP id
 d2e1a72fcca58-824b03f66d7mr2101733b3a.8.1770888926737; 
 Thu, 12 Feb 2026 01:35:26 -0800 (PST)
X-Received: by 2002:a05:6a00:1da5:b0:821:70e7:b10a with SMTP id
 d2e1a72fcca58-824b03f66d7mr2101715b3a.8.1770888926360; 
 Thu, 12 Feb 2026 01:35:26 -0800 (PST)
Received: from smtpclient.apple ([122.164.27.113])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8249e7d78dcsm4718664b3a.31.2026.02.12.01.35.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Feb 2026 01:35:26 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v4 00/31] Introduce support for confidential guest reset
 (x86)
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <820317C2-F452-4985-BC4F-26F7D29B4787@redhat.com>
Date: Thu, 12 Feb 2026 15:05:11 +0530
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Graf <graf@amazon.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3C677B3-D6F1-483F-A6D2-4EA7A37FA320@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
 <aY2K_9mEj2oT_I0l@redhat.com>
 <820317C2-F452-4985-BC4F-26F7D29B4787@redhat.com>
To: Daniel Berrange <berrange@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 12 Feb 2026, at 1:44=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 12 Feb 2026, at 1:40=E2=80=AFPM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>>=20
>> On Thu, Feb 12, 2026 at 11:54:44AM +0530, Ani Sinha wrote:
>>> This change introduces support for confidential guests
>>> (SEV-ES, SEV-SNP and TDX) to reset/reboot just like other =
non-confidential
>>> guests. Currently, a reboot intiated from the confidential guest =
results
>>> in termination of the QEMU hypervisor as the CPUs are not =
resettable. As the
>>> initial state of the guest including private memory is locked and =
encrypted,
>>> the contents of that memory will not be accessible post reset. Hence =
a new
>>> KVM file descriptor must be opened to create a new confidential VM =
context
>>> closing the old one. All KVM VM specific ioctls must be called =
again. New
>>> VCPU file descriptors must be created against the new KVM fd and =
most VCPU
>>> ioctls must be called again as well.
>>>=20
>>> This change perfoms closing of the old KVM fd and creating a new =
one. After
>>> the new KVM fd is opened, all generic and architecture specific =
ioctl calls
>>> are issued again. Notifiers are added to notify subsystems that:
>>> - The KVM file fd is about to be changed to state sync-ing from KVM =
to QEMU
>>> should be done if required.
>>> - The KVM file fd has changed, so ioctl calls to the new KVM fd has =
to be
>>> performed again.
>>> - That new VCPU fds are created so that VCPU ioctl calls must be =
called again
>>> where required.
>>>=20
>>> Specific subsystems use these notifiers to re-issue ioctl calls =
where required.
>>>=20
>>> Changes are made to SEV and TDX modules to reinitialize the =
confidential guest
>>> state and seal it again. Along the way, some bug fixes are made so =
that some
>>> initialization functions can be called again. Some refactoring of =
existing
>>> code is done so that both init and reset paths can use them.
>>>=20
>>> Tested on TDX, SEV-ES and SEV-SNP. Tested on non-coco hardware. =
Tested with Xen
>>> emulation enabled.
>>=20
>> I see no QOM changes here, so is there any way for a mgmt app to
>> detect that QEMU is now capable of guest reset with TDX/SEV/SNP,
>> compared to the current behaviour ?
>=20
> The thought did not occur to me. So other than the availability of =
'x-change-vmfd-on-reset=E2=80=99 machine property there is nothing else.

Looking at the code, actually =E2=80=98can_rebuild_guest_state=E2=80=99 =
is the one we want to use. It=E2=80=99s a property of =
ConfidentialGuestSupportClass . Maybe we can expose this somehow.




