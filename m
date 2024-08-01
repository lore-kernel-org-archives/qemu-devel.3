Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57374C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWks-0007NB-TM; Thu, 01 Aug 2024 10:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZWkq-0007Dn-Iy
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:26:08 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZWko-0003oA-Po
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:26:08 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52ef95ec938so8445415e87.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722522364; x=1723127164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YBkM2j0NcezYrn6YO324onq9oz5rzqnzoHsPNTbVU3M=;
 b=TBftRRlx/rPiFWxgj7VxmNCxk64/jUkrm1NUDdlnsTEuVbetiFb48huPc8mgAZuRAm
 ipO9zGlrCOr8Xq1ogDBO9+1FIgJ6f9MlMRZiFWFUjsJbM+8bA+qDrcliUS57a/euFaMo
 zYsZdUAhVhiNdVLWnT2T9b54rlXCmQC/4176VxV1I3vv8Er9ZLRw7xbBcBPu4vo1zw8w
 2VsmIJPV4pGovkuOW+yfDo1pMLlpeJ/EcrNyV0Ivhg+fJzfMbpHau/MwJeuAa2ncWOHR
 oA7t9jFcojaBJ2PjutNl1EP69bg4iv0DqTBk3YlMFMcSANILdjQQ5cfQ/rGqNXTCn3aY
 KDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722522364; x=1723127164;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBkM2j0NcezYrn6YO324onq9oz5rzqnzoHsPNTbVU3M=;
 b=LkpA2fkxY7oDPXQYTiWNuDEMIxgijQZV4YGZioKfL2JYPk5m1vAcJXSRYYZSF3OKgb
 hW102CMOawRkpBCYbY2ZwqKySwz+6ApggV6POt5uvfhBRbX1kRUG139t0h+EEkXmtcYD
 Ek+uVW7QKQJQ8BMULoHr/bSVHGjGIUOTE7qWXo5o4lLrPkfalDuHUcFvm2jUR5bpeRxu
 01LhR9g3H8YOMAQVLw9bjqv8Ivi/IuPCrLptOss0zhmhkYBSy2PXEFMXhkwB8IeGs/4Y
 yMWVshd1Inx1AENUoiOenAVUHNCWXoZ8kTu3q8qCfLnKXjUEYclNRohlxFm0pDSk5mO5
 FB5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUa6hn/EC6kk1uC1qCv91rM8CHnk0AIfV5ZHam5wgXPzFrvjstc9O35n3gm6UshHQjWjeJQ1iq9niLtrZJQRb0ol1hPkw=
X-Gm-Message-State: AOJu0YxspHl+3sl9cHUC3QL3akkgoL3kpCPntasK8DD1lkRywZUrmTHi
 BCZtU/955d/YirJTpe5bm9Il/XnI8PnnAl3W94ubz4SfIRoqaIVZpNx4fvA+n6s=
X-Google-Smtp-Source: AGHT+IEjrlTiyBUYaINP9uK712VXKR5kixtvXc4di6YloeiU5uT5+Bl4vrpU/jHF166KdbS64KlpIw==
X-Received: by 2002:a05:6512:3a95:b0:52c:e084:bb1e with SMTP id
 2adb3069b0e04-530bb397748mr31883e87.13.1722522363952; 
 Thu, 01 Aug 2024 07:26:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63d4720dsm10348802a12.58.2024.08.01.07.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:26:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6CEA45F80C;
 Thu,  1 Aug 2024 15:26:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Daniel P." =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  qemu-devel@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Leif Lindholm
 <quic_llindhol@quicinc.com>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 kvm@vger.kernel.org,  Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>,  Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>
Subject: Re: [PATCH 07/13] tests/avocado/kvm_xen_guest.py: cope with asset
 RW requirements
In-Reply-To: <63ef2c5b9ab213f544173df027abf5b056d59e8a.camel@infradead.org>
 (David Woodhouse's message of "Mon, 29 Jul 2024 13:03:46 +0100")
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-8-crosa@redhat.com>
 <Zqd10nIix4gXKtDw@redhat.com>
 <63ef2c5b9ab213f544173df027abf5b056d59e8a.camel@infradead.org>
Date: Thu, 01 Aug 2024 15:26:02 +0100
Message-ID: <87wml0coat.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
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

David Woodhouse <dwmw2@infradead.org> writes:

> On Mon, 2024-07-29 at 11:58 +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Jul 26, 2024 at 09:44:32AM -0400, Cleber Rosa wrote:
>> > Some of these tests actually require the root filesystem image,
>> > obtained through Avocado's asset feature and kept in a common cache
>> > location, to be writable.
>
> Hm, I'm not sure *why* they require a writable image. Mostly they're
> just testing the interrupt routing. What's the failure mode for a read-
> only image?

There are no real failures with readonly=3Don although you do see init
complain a bit about not being able to mount /dev and open log files.
snapshot allows that to happen but doesn't change the underlying
storage.

>
>> > @@ -56,11 +57,19 @@ def common_vm_setup(self):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "367962983d0d32109998a70b45dcee4672d0b045=
")
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.rootfs =3D self.=
get_asset("rootfs.ext4",
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "f1478401ea4b3fa2ea196396be44315bab2bb5e4")
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if readwrite:
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
st =3D os.path.join(self.workdir, os.path.basename(self.rootfs))
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sh=
util.copy(self.rootfs, dest)
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se=
lf.rootfs =3D dest
>>=20
>> This is a very expensive way of creating a writable disk. Better to
>> avoid adding this 'readwrite' parameter at all, and instead create
>> a throwaway qcow2 overlay for the image for all tests. That ensures
>> writability for everything in a cheap manner.
>
> Or just use -snapshot?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

