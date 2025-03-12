Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823BFC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 13:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMWR-0006LS-MO; Wed, 12 Mar 2025 09:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tsMWB-0006Jd-6q
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tsMW9-000712-45
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741787582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=im2KCwwdQnBghJ1esIRkFjFQE89vutbXtc+FuAPAlJw=;
 b=KjTIiX+cZfBXkPeNKwob9fyS/gXgxU0DlyFTM/N82+jvkxBB2EPiH114ebrboe6gVIxvLn
 JPjEO/iBttnvLLdUsIjcvJdFATPP2G9azxpeAJ4cwshU1SRK0d0YruJbFdvzP9Z7AcqEoM
 8C0R0JyZCqXOsfu/N8wW1LQVTC4cTJA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-UJ0uWmfXPYqEc2KW9_LA5g-1; Wed, 12 Mar 2025 09:52:56 -0400
X-MC-Unique: UJ0uWmfXPYqEc2KW9_LA5g-1
X-Mimecast-MFC-AGG-ID: UJ0uWmfXPYqEc2KW9_LA5g_1741787576
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e8f184b916so9116476d6.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 06:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741787576; x=1742392376;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=im2KCwwdQnBghJ1esIRkFjFQE89vutbXtc+FuAPAlJw=;
 b=jAlyc3Qh/+TubiO4zmZS9MaCmVJBbyBDP6pceTp6KfDf3C/J3cuYYttdUMz19aheF4
 8wcq5TjOr7C3q0DzPbWJJlaaA8W5QzmwZ7Ab7QWH2VsCXSokWF/aKs16t5maGsCzZRXK
 Qp+AxE+w2mSTVJ4iTGneL7NHHasW6YCebgN5LApr89pXXIMM1xMh7TGKpA6tdvDqAtkv
 bqwPJrYLBeoHmoPip3G2eupQxTPLHU8EFbMMkMun+qoXd7C2YVoNugnauNT/SdyLlt74
 fT2X4bYIE1PFHRjtLnqb7+9Kanz3JBcXFgDm5zOHTO7G20fBENWZZFJLJ6GCfayf1kTa
 WUpA==
X-Gm-Message-State: AOJu0YxhUGH+XC0xhtMSkOQBNoVH2oenq5DDboWgLeh3RTJOC6N2kkQh
 BUXpE9J95uaVULBAEtK0p4f1EJNY0D5+lwJjdxDI4Ilun5T2MhSsgBwDvumrk/7LaDdfX4K2349
 giFWRwp9vX+o4fbv+mLyPbiB7/MrP+4ntT8Ji0SvLpMIuSmGDxPgC3IHMcIJWk29+pHjQUfXx62
 i05JrGX8yTuDSE2gPttiTG7GWwMf7OK8KeGmoqQQ==
X-Gm-Gg: ASbGncuTwmrM7/b7VLGcWHF7NS57xKL38UHKybPESYH5odb5kE5BK58P9v1pHsQhWoY
 0eqHkjQsHOkL52D15c5l7IxKDHXwmH0LLhMq82+wJGUxkpv9ixFe9BmBSODvbQMytuDNe8wGDWv
 4=
X-Received: by 2002:a05:6214:1c43:b0:6e2:4859:f062 with SMTP id
 6a1803df08f44-6e90061fd6amr304956136d6.21.1741787576314; 
 Wed, 12 Mar 2025 06:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7+GdocetvRrie/8ak7eRdiy1UH5OMfLGvJyxKsh8E5TerYfG3M6fju2SCmDoNX8uOJvgDK62qDtLxU3aruNc=
X-Received: by 2002:a05:6214:1c43:b0:6e2:4859:f062 with SMTP id
 6a1803df08f44-6e90061fd6amr304955776d6.21.1741787575847; Wed, 12 Mar 2025
 06:52:55 -0700 (PDT)
MIME-Version: 1.0
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 12 Mar 2025 15:52:45 +0200
X-Gm-Features: AQ5f1Jq7lmo0h75S4MbI9b35Xu7ZQaKvCd5zOCRvsoWquIfDdhB3q9UA9KiUvlU
Message-ID: <CAPMcbCquaBmWhx3jWBKMC1oLrMZBUVhfWFcW=_5uhVqOep4NWw@mail.gmail.com>
Subject: Cross-compilation artifact is broken
To: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bb9aaf06302585cd"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000bb9aaf06302585cd
Content-Type: text/plain; charset="UTF-8"

Hi All,

I cross-compiled qemu-ga from current master branch
(825b96dbcee23d134b691fc75618b59c5f53da32) and found strange behavior.

Configure CLI:
./configure --disable-docs --disable-system --disable-user
--cross-prefix=x86_64-w64-mingw32- --enable-guest-agent
--disable-guest-agent-msi --disable-qga-vss
Build CLI:
make -j8 qemu-ga

Linker wrote the following information but exited with 0 code:

/usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin/ld:
qga/qemu-ga.exe:/4: section below image base
/usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin/ld:
qga/qemu-ga.exe:/24: section below image base

As a result, this binary failed to start on Windows without any details,
just a message that the application is not compatible. I also tried to run
it with wine and got the error:

wine: failed to start
L"Z:\\home\\user\\Documents\\repos\\qemu\\build\\qga\\qemu-ga.exe"
Application could not be started, or no application associated with the
specified file.
ShellExecuteEx failed: Bad EXE format for
Z:\home\user\Documents\repos\qemu\build\qga\qemu-ga.exe.

I bisected the tree and found the commit that caused the problem:
https://gitlab.com/qemu-project/qemu/-/commit/563b1a35ed1f1151505d4fe5f723827d1b3fd4bc

Adding --disable-split-debug to the configure CLI fixes the issue.

$ x86_64-w64-mingw32-gcc --version
x86_64-w64-mingw32-gcc (GCC) 14.2.0

My question is, is this expected behavior or is this a bug?

Best Regards,
Konstantin Kostiuk.

--000000000000bb9aaf06302585cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi All,</div><div><br></div><div>I cross-compiled qem=
u-ga from current master branch (825b96dbcee23d134b691fc75618b59c5f53da32) =
and found strange behavior. <br></div><div><br></div><div>Configure CLI:<br=
></div><div>./configure --disable-docs --disable-system --disable-user --cr=
oss-prefix=3Dx86_64-w64-mingw32- --enable-guest-agent --disable-guest-agent=
-msi --disable-qga-vss</div><div>Build CLI:<br>make -j8 qemu-ga<br><br></di=
v><div>Linker wrote the following information but exited with 0 code:<br><b=
r></div><div>/usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-=
mingw32/bin/ld: qga/qemu-ga.exe:/4: section below image base<br>/usr/lib/gc=
c/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin/ld: qga/qemu=
-ga.exe:/24: section below image base</div><div><br></div><div>As a result,=
 this binary failed to start on Windows without any details, just a message=
 that the application is not compatible. I also tried to run it with wine a=
nd got the error:<br></div><div><br></div><div>wine: failed to start L&quot=
;Z:\\home\\user\\Documents\\repos\\qemu\\build\\qga\\qemu-ga.exe&quot;<br>A=
pplication could not be started, or no application associated with the spec=
ified file.<br>ShellExecuteEx failed: Bad EXE format for Z:\home\user\Docum=
ents\repos\qemu\build\qga\qemu-ga.exe.</div><div><br></div><div>I bisected =
the tree and found the commit that caused the problem:<br></div><div><a hre=
f=3D"https://gitlab.com/qemu-project/qemu/-/commit/563b1a35ed1f1151505d4fe5=
f723827d1b3fd4bc">https://gitlab.com/qemu-project/qemu/-/commit/563b1a35ed1=
f1151505d4fe5f723827d1b3fd4bc</a></div><div><br></div><div>Adding --disable=
-split-debug to the configure CLI fixes the issue.</div><div><br></div><div=
>$ x86_64-w64-mingw32-gcc --version<br>x86_64-w64-mingw32-gcc (GCC) 14.2.0<=
/div><div><br></div><div>My question is, is this expected behavior or is th=
is a bug? <br></div><div><br clear=3D"all"></div><div><div dir=3D"ltr" clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><=
div>Best Regards,</div><div>Konstantin Kostiuk.</div></div></div></div></di=
v>

--000000000000bb9aaf06302585cd--


