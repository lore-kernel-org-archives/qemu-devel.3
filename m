Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C12C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 17:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfjoA-0001PZ-Ii; Thu, 29 Feb 2024 12:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfjo3-0001LU-8V
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:02:51 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfjo1-0000MK-9R
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:02:50 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d2ab9c5e83so12687531fa.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 09:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709226166; x=1709830966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKc83gjhF/N5xX0Rbjj2fPfsii6qz50uemvQoLlKB/k=;
 b=mVXxIHQqbCmoaMH8JBhzfc8cjV0OtjKOAdZIo+K0DywGkdl2basawO/I0K0m8+XjHX
 ZWYNms1F84IpvLwo01kMdlu6riA+ZuQUCa4QDUbu8MG0N/F2eH8IMg4zLX/O8WQDEh73
 IHAacyac88MrTychS3szOIG+LcOCE0iDI80o17iOwj0IEgKoVC9P30/Oc21aqhA49KMu
 mrFCeZr9706WabkxaEV8tz1O07oRc+pcsoeeMUUlETThxRIMCdpi25NHORXYtA+z/CNY
 pGG/w8Fy5kMeLPiDUOZZT/cSxzxbsIt7y98R1kFthZSDLmE4SGs64TazEtn14BZNKGjL
 qJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709226166; x=1709830966;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sKc83gjhF/N5xX0Rbjj2fPfsii6qz50uemvQoLlKB/k=;
 b=r4ujp41xzFFSuj1MZ5QCeu/kRXGGHDdHzwiXQIIrb798adQsQE8HZ/y1UHRnNXLWth
 LhNnLnDb4VNB0mAaFi1EVPAKthJqPF/Og0Vxc8WRbitTPsVEB1chqNHXeRpkfFTvAKrx
 50YEh2tsa7fiKH/Lfxa5oVOI0tjxLYByVP8Wranjhf6W97JlmJ7OBw1otxexM7M2L485
 CjZoc8c7Y0KsXrc3ti97tT4upDpUhl9zISWx3kDBmBdfRICC99L8mSZcpDHLOMP+SlHV
 AQXksJZu0JuH9MRsc54NmJiwtr2Nz+xEFx/PhglUrRWGt8CuiR2Gayb+D5ARY7sK2alP
 lHpg==
X-Gm-Message-State: AOJu0YwmKYyxXLF6QLKUT2E1uzmXOSRksaGG3ysYvGC1M6t5CM1uONqr
 OV3wx/ov0Ci9zXoY/u39UMUzhgvBu1ro05lb9QZ48ga6pS/pJSTCc1p721BdFQGNtiaERGyh9PX
 P
X-Google-Smtp-Source: AGHT+IHX/yiPmwkjZnXm448MVIdvZp1lRTREvzjMrVPqF/QE+y8OAc37ihvG8KhhKreMKX3Vi5VKsA==
X-Received: by 2002:a2e:7206:0:b0:2d2:936a:f8af with SMTP id
 n6-20020a2e7206000000b002d2936af8afmr1524273ljc.48.1709226166266; 
 Thu, 29 Feb 2024 09:02:46 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 da8-20020a056000196800b0033b87c2725csm2206884wrb.104.2024.02.29.09.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 09:02:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 83A135F863;
 Thu, 29 Feb 2024 17:02:45 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paz Offer <poffer@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: What is the correct way to add linker dependency to QEMU build
 system?
In-Reply-To: <MW4PR12MB69979E8A2E0F9B62D6C2A703A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
 (Paz Offer's message of "Thu, 29 Feb 2024 16:09:03 +0000")
References: <MW4PR12MB69979E8A2E0F9B62D6C2A703A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 17:02:45 +0000
Message-ID: <87frxb6w5m.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Paz Offer <poffer@nvidia.com> writes:

> Hi,
>
> I want to add library 'libdl' to be linked with QEMU build for a particul=
ar target (e.g. - qemu-system-arm).
> Using meson I would typically do 'compiler.find_library(...)', and later =
add the returned dependency to the binary
> dependencies list.
> However, in QEMU I understand that these configurations are done in
> the './configure' file?

No I'm pretty sure all the library finding is done in meson now:

  21:elf =3D cc.find_library('elf', required: true)=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  22:procstat =3D cc.find_library('procstat', required: true)=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  23:kvm =3D cc.find_library('kvm', required: true)=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  663:libm =3D cc.find_library('m', required: false)=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  665:util =3D cc.find_library('util', required: false)=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  679:  pathcch =3D cc.find_library('pathcch')=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
  680:  socket =3D cc.find_library('ws2_32')=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
  681:  winmm =3D cc.find_library('winmm')=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
  693:  socket =3D [cc.find_library('socket'),=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
  694:            cc.find_library('nsl'),=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
  695:            cc.find_library('resolv')]=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
  697:  socket =3D [cc.find_library('posix_error_mapper'),=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  698:            cc.find_library('network'),=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
  699:            cc.find_library('bsd')]=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
  735:  nvmm =3D cc.find_library('nvmm', required: get_option('nvmm'))=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
  827:          xen_deps +=3D { l: cc.find_library(l, required: false) }=20=
=20=20=20=20=20=20=20=20=20=20=20
  986:  libaio =3D cc.find_library('aio', has_headers: ['libaio.h'],=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  1029:    libattr =3D cc.find_library('attr', has_headers: ['attr/xattr.h'=
],=20=20=20=20=20=20=20
  1075:  libcap_ng =3D cc.find_library('cap-ng', has_headers: ['cap-ng.h'],=
=20=20=20=20=20=20=20=20=20
  1122:  vde =3D cc.find_library('vdeplug', has_headers: ['libvdeplug.h'],=
=20=20=20=20=20=20=20=20=20=20
  1187:rt =3D cc.find_library('rt', required: false)=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  1254:  libmpathpersist =3D cc.find_library('mpathpersist',=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  1259:      mpathlibs +=3D cc.find_library('devmapper',=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  1262:    mpathlibs +=3D cc.find_library('multipath',=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  1332:        libcurses =3D cc.find_library(curses_libname,=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  1382:  brlapi =3D cc.find_library('brlapi', has_headers: ['brlapi.h'],=20=
=20=20=20=20=20=20=20=20=20=20=20
  1425:  librados =3D cc.find_library('rados', required: get_option('rbd'))=
=20=20=20=20=20=20=20=20=20
  1426:  librbd =3D cc.find_library('rbd', has_headers: ['rbd/librbd.h'],=
=20=20=20=20=20=20=20=20=20=20=20
  1519:  libbzip2 =3D cc.find_library('bz2', has_headers: ['bzlib.h'],=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
  1535:  liblzfse =3D cc.find_library('lzfse', has_headers: ['lzfse.h'],=20=
=20=20=20=20=20=20=20=20=20=20=20
  1554:    oss =3D cc.find_library('ossaudio', required: get_option('oss'))=
=20=20=20=20=20=20=20=20=20
  1660:         cc.find_library('gpg-error', required: true)],=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  1774:  sasl =3D cc.find_library('sasl2', has_headers: ['sasl/sasl.h'],=20=
=20=20=20=20=20=20=20=20=20=20=20
  1784:  pam =3D cc.find_library('pam', has_headers: ['security/pam_appl.h'=
],=20=20=20=20=20=20=20
  1808:  snappy =3D cc.find_library('snappy', has_headers: ['snappy-c.h'],=
=20=20=20=20=20=20=20=20=20=20
  1824:  lzo =3D cc.find_library('lzo2', has_headers: ['lzo/lzo1x.h'],=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
  1840:  numa =3D cc.find_library('numa', has_headers: ['numa.h'],=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  1857:  libumad =3D cc.find_library('ibumad', required: get_option('rdma')=
)=20=20=20=20=20=20=20=20
  1858:  rdma_libs =3D [cc.find_library('rdmacm', has_headers: ['rdma/rdma_=
cma.h'],=20
  1860:               cc.find_library('ibverbs', required: get_option('rdma=
')),=20=20=20
  1933:  malloc =3D cc.find_library(get_option('malloc'), required: true)=
=20=20=20=20=20=20=20=20=20=20=20
  2420:  inotify =3D cc.find_library('inotify')=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
  3164:    fdt =3D cc.find_library('fdt', required: fdt_opt =3D=3D 'system'=
)=20=20=20=20=20=20=20=20=20=20=20=20
  18:    cc.find_library('ole32'),=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
  19:    cc.find_library('oleaut32'),=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
  20:    cc.find_library('shlwapi'),=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
  21:    cc.find_library('uuid'),=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
  22:    cc.find_library('intl')=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20


>
> What would be the correct way to do this?
>
> Thanks,
> Paz

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
Date: Thu, 29 Feb 2024 17:02:44 +0000

