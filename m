Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA95EC5472D
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 03:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1si3wz-0006NB-AC; Sat, 24 Aug 2024 23:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1si3wy-0006Lg-3P; Sat, 24 Aug 2024 23:29:56 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1si3ww-0007wT-Ad; Sat, 24 Aug 2024 23:29:55 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 12F4960BCB;
 Sun, 25 Aug 2024 03:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F77C32782;
 Sun, 25 Aug 2024 03:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724556591;
 bh=4xLQFMqugB1RpTJGmvAdJwsDVt72hgC3qjvoz1pST8Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tard5wd2nGNJTdz6lR0jQA+aqKJVfCUuPemaF8G+jaWP5kycYAtSDz3xlOFGAVREw
 f6w/sxlVfuH9soTJhFbqTYAMa4i8byEwEkTj8/huE7jdiJ8WcnzsLsAAqa4UVyZNK8
 3bgl/SlMchVy92OoTcnOkgTQDzUNrxby60X1mGl4hhNea+si7CKHcfp81clnCBro/Z
 TYvoEY2nkB04WzwSc/jYUEtGLHGomAoyfcijFTmAIOO74l3QqVTJlsgsD9NvVbPYpH
 AwYXW2dir8qzampyVBw8UVWUUymfDdhLcirAClIgS0fpTJ6q0IfORkAyhvb6KkLVCW
 EK+zNfyNJOadw==
Date: Sun, 25 Aug 2024 05:29:23 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 06/13] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240825052923.715f88bc@sal.lan>
In-Reply-To: <20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
 <20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Em Mon, 19 Aug 2024 14:51:36 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > +        read_ack =3D 1;
> > +        cpu_physical_memory_write(read_ack_start_addr,
> > +                                  &read_ack, (uint64_t)); =20
> we don't do this for SEV so, why are you setting it to 1 here?

According with:
https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-h=
ardware-error-source-version-2-ghesv2-type-10

   "These are the steps the OS must take once detecting an error from a par=
ticular GHESv2 error source:

    OSPM detects error (via interrupt/exception or polling the block status)

    OSPM copies the error status block

    OSPM clears the block status field of the error status block

    OSPM acknowledges the error via Read Ack register. For example:

        OSPM reads the Read Ack register =E2=80=93> X

        OSPM writes =E2=80=93> (( X & ReadAckPreserve) | ReadAckWrite)"


So, basically the guest OS takes some time to detect that an error
is raised. When it detects, it needs to mark that the error was
handled.

IMO, this is needed, independently of the notification mechanism.

Regards,
Mauro

