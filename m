Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C973C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 14:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYmto-0002tB-5z; Tue, 30 Jul 2024 09:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYmtT-0002rh-SE
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 09:28:05 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYmst-0004tw-EK
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 09:27:52 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so7221259a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722345927; x=1722950727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iGzGVsveDnfov/YbIjnNANrPFX+tEMTkjytQu86Yrwc=;
 b=mzM5esM0uFLazDCltWcpmLVSv1P1frTy5H2PAMi5ntu9d4vcNck69UDoP6B3niLpfw
 ATKKhS8IByS4w3HieFE1+UK2Urym2q6KmnxRhVY5tmb2ffOxz9xs/1svnt8IC2+fctOw
 1k+6Qomxy4KpDV2LAa79124qfjHCj9c7heaG59lc/d1QhXbFATzNt8uGWnXN8+LOUVRs
 jxr/KzGmrRiRUc5jj1rUZJnAkznJavEu1VFECqTvyO/ru81fGj/VGcPLhYGN/qdEJIlV
 wUQqn9I+LKsHdwtx3FhBCQZbUX94sx092kwJec26ZlAt9jSJvPzBtz521ZffvMzP9Hxm
 30jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722345927; x=1722950727;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGzGVsveDnfov/YbIjnNANrPFX+tEMTkjytQu86Yrwc=;
 b=Su6Q8AVdwmTcslW68w0aakKWxRImUByzhAupU07AR1yzqA80zNFHD82XSUH0t67kQV
 hMdloSWSRI28BhvHXLJk46Sq0RDv/ZijxQErAZnBVM8VLDy8LovvcuzmuW7SGDiGxBAr
 cXv27dxRw+OCyn+SpKZ8la3+1MOtJcsLMgJ5EqOxJ1mKCs0sr7WMWce2Ul92J04uPh1X
 jxCSuq//+6/xBYYMQ7mocffRrrqXkH59wpWtd57Vn1pK0LSwIJlJjOc5S8LdbmQoSeox
 QQuoUOaq4ObPGzg25V42gn8KLwni9m+3xQu8o5mT/OAeEPFnmKyCff056u55Ortc2/vb
 WPTw==
X-Gm-Message-State: AOJu0YydzUA6vUgLozV5KiL6SgSl1E+rv7iU43fH0dBGqpjNTxVbCPPP
 2R6Iz0mgSUohwzzTWdtD/kcJLiMkCiQy/Mn55y9PBZ/qiSu9GenBnbjfhiYfG/g=
X-Google-Smtp-Source: AGHT+IEHnUAbZFn7tDnG9n1GUsD+L5Z9yHsFwZ+ndGf2QyPliar/s/k5KM9mXxcJzJAIeWwaY5hZdQ==
X-Received: by 2002:a05:6402:2353:b0:5a4:2c8:abda with SMTP id
 4fb4d7f45d1cf-5b02000c20dmr8915283a12.3.1722345927015; 
 Tue, 30 Jul 2024 06:25:27 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63b59bfesm7283110a12.44.2024.07.30.06.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 06:25:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A9965F867;
 Tue, 30 Jul 2024 14:25:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: qemu-devel@nongnu.org,  Jean-Philippe Brucker
 <jean-philippe@linaro.org>,  Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: QEMU unexpectedly closed the monitor
In-Reply-To: <8AFDCC22-C476-45EF-9119-2E3C9A2A91C3@linux.dev> (Itaru
 Kitayama's message of "Mon, 29 Jul 2024 15:33:02 +0900")
References: <8AFDCC22-C476-45EF-9119-2E3C9A2A91C3@linux.dev>
Date: Tue, 30 Jul 2024 14:25:25 +0100
Message-ID: <87le1jc8qi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Itaru Kitayama <itaru.kitayama@linux.dev> writes:

> Hi,
>
> Executing virt-install with the following options:
>
> sudo virt-install --machine=3Dvirt --arch=3Daarch64 --name=3Dtest8 --disk
> path=3D/var/lib/libvirt/images/jammy.qcow2,format=3Dqcow2,device=3Ddisk,b=
us=3Dvirtio,cache=3Dnone
> --memory=3D2048 --vcpu=3D1 --nographic --check all=3Doff --features acpi=
=3Doff
> --import --os-variant=3Dubuntu22.04 --virt-type kvm --boot
> kernel=3DImage-guest-cca-v4,initrd=3Drootfs.cpio,kernel_args=3D'earlycon
> console=3DttyAMA0 rdinit=3D/sbin/init rw root=3D/dev/vda acpi=3Doff' --ne=
twork
> none
>
> receives an error:
>
> Starting install...
> ERROR    internal error: QEMU unexpectedly closed the monitor (vm=3D'test=
8'): 2024-07-29T06:23:04.717118Z qemu-system-aarch64: could not load kernel=
 '/home/realm/Image-guest-cca-v4=E2=80=99
>
> I am not sure how to investigate as the kernel Image (Image-guest-cca-v4)=
 can work if it is used directly with the qemu-system-aarch64, like:
>
> sudo qemu-system-aarch64 -kernel Image-guest-cca-v4 -initrd
> rootfs.cpio -cpu host -M virt,gic-version=3D3,acpi=3Doff -enable-kvm -smp
> 2 -m 2048M -nographic -append 'earlycon console=3DttyAMA0
> rdinit=3D/sbin/init rw root=3D/dev/vda acpi=3Doff' -net none

Is there any way to get virt-install to dump its QEMU command line?
There obviously seems to be something off if it works when you build the
command line by hand.

>
> Userland is Ubuntu 24.04, and the host and guest kernels are for the prot=
ected VM (Realm) execution.
> Any help would be appreciated.
>
> Thanks,
> Itaru.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

