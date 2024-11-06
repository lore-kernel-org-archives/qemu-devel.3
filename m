Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6E7D59F52
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 16:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8itA-0000s3-NA; Wed, 06 Nov 2024 11:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8it8-0000rY-LI
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:28:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8it5-00020G-Jv
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730910485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WpSDDapmWAfVnm0Tcp8qmXghYA7JeZXasK/49MWIqGQ=;
 b=Q92lqfOPbKJEv9hcKCzh058nbIb/cCzAsn598K0gnoBUgokbYKB8/wtnD+ITaU825W0SFn
 hilbyyXAbR/OW91GuHf2+ihODWhdC4BgoQmQM20noJuult6ji0U4H7jg2OwlCgjjIMktlF
 jeGSnw4TEnzVTlAh+rYEww73QjAz7fI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-dOQCl5u5Mh6jrQ1AA0ho1A-1; Wed, 06 Nov 2024 11:28:04 -0500
X-MC-Unique: dOQCl5u5Mh6jrQ1AA0ho1A-1
X-Mimecast-MFC-AGG-ID: dOQCl5u5Mh6jrQ1AA0ho1A
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-381d0582ad3so3512581f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 08:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730910480; x=1731515280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpSDDapmWAfVnm0Tcp8qmXghYA7JeZXasK/49MWIqGQ=;
 b=DYUdcqD6qeVpIOpvPDbfzRTco5CxPVSulW3ECmT5jg46/Bz7AwrmG2+CkG7xdkn0iK
 pM2Myc43/ECxHCNIHOLMzrS2G+Z69OZXi8+m93ibgw+dHDVLtpOdSHKhw/wZXXTUiR0H
 /LMGi66rvDJwa+hVDmiLIcT3lqKnmYukD2k/DxtTmisSFiV9qCHhLGgHiES+kjSWpBxW
 v5/MB5M0bUxCDXsuP8ULblwT4AW+UdfGsBK90I16frFlTLCfmaVubhoPiZGCDqFeIH8g
 vFjG5AcSF/Ll7SeXG5wQlOhHAyDuTERgZS43zQyd3s1EdY1wxSluHTIdDwwmkCBz7g0J
 rSkQ==
X-Gm-Message-State: AOJu0YwbZpe6lBv/cpNRm5RJ4M6xojqpOewSAUC0N30v4oh2WATK+ouT
 NG9zEb0bieQsnTXRPaJ7HdkkA3e8Pe+W8Qjr73SuVRt6R1oPtk+Xlrx/moPqgOpxJgl0BFwUZyz
 sPincE0X7ihFjMIS9dopw1sTWs3+eikFeezXy0OgmN1YDp1XYI10K6IVidCKUVfS0rMeedFd09K
 DBS1JFQW6NbrnQPyEQ82mKkLsD8IE=
X-Received: by 2002:a05:6000:2c3:b0:37d:4eeb:7366 with SMTP id
 ffacd0b85a97d-381c7a461e4mr24993235f8f.4.1730910480318; 
 Wed, 06 Nov 2024 08:28:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEo9sfjJJ36vEYQBoLj465wJb6gA4f9ZQQqHixKY/J6iwizTtpPPrYBQ4ZY68WQg+UyswovyR3JCRAf5MbZTM=
X-Received: by 2002:a05:6000:2c3:b0:37d:4eeb:7366 with SMTP id
 ffacd0b85a97d-381c7a461e4mr24993197f8f.4.1730910479762; Wed, 06 Nov 2024
 08:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20241104172721.180255-1-pbonzini@redhat.com>
 <CAFEAcA8JoYxokZxcf66ivkCAMXuVFvDdrC7tCguNvQ43aAr_kg@mail.gmail.com>
 <CABgObfbzpioAQ7czF1TfPnEApykth1gJm67WZveVY9bo_FYs-A@mail.gmail.com>
 <CAFEAcA8WKODD_ZqQb7t_0KxnSk65Vsx-5-z9WSD2d8HeqD02zg@mail.gmail.com>
In-Reply-To: <CAFEAcA8WKODD_ZqQb7t_0KxnSk65Vsx-5-z9WSD2d8HeqD02zg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Nov 2024 17:27:45 +0100
Message-ID: <CABgObfbQQ2JXX=rdJyyWW0SNyWZA8tvSMXP47M96ONMC0Xzf9w@mail.gmail.com>
Subject: Re: [PULL 00/40] Rust changes for QEMU 9.2 soft freeze
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 6, 2024 at 4:00=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
> However, this does seem to be causing the functional-tests to timeout
> on the CI job that now enables Rust:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/8284623145
> https://gitlab.com/qemu-project/qemu/-/jobs/8283637798
>
> both fail with
>
> 01-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_virt:
> INTERRUPTED
> 13-tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_virt: INTER=
RUPTED
> 15-tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_vexpressa9:
> INTERRUPTED
>
> (which I suspect will turn out to be "all the functional tests that
> use a pl011").
>
> Could you have a look, please?

Drat, I'll just drop the patch that enables Rust in CI. Not really in
the mood of debugging device code.

Paolo


