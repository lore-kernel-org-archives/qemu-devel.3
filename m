Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9671CE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFr-0001tG-RD; Thu, 19 Dec 2024 11:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1tOG9P-0007bB-S4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1tOG9K-0000Wl-US
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734613265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGkKVaPODV83lxyFfjK9Te+LbPVqMXmKuxMKzLBF2TE=;
 b=YmOhs+Hh7xDOzZ4DuuAgxQzf+5DPyhdkAYMPy25TGPwhBWzfdquCGszcJPkRknTsI/tsn0
 9jcuJ18XxvOfiTqhNBU3BL3aCZC8BXvOzkfTA0Tf0WAmWfI/+urWgSpwwVWTFq8RFewnsn
 lBtxBaPO9CkRCfGxl6OwaGQb8JIwda8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-uErNmljdNi2RmRZ84R9jWA-1; Thu, 19 Dec 2024 08:01:03 -0500
X-MC-Unique: uErNmljdNi2RmRZ84R9jWA-1
X-Mimecast-MFC-AGG-ID: uErNmljdNi2RmRZ84R9jWA
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3eb9c1ce675so586647b6e.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 05:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734613262; x=1735218062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGkKVaPODV83lxyFfjK9Te+LbPVqMXmKuxMKzLBF2TE=;
 b=rYVqKUJ/K62vMpazdTwbhq8L2axT5qYu72egb0O68S/2heCimgXro2jwkR/dpf7QB7
 CTgETSAv0O8F2H25Pyl7VtCXFkfAj59/0800h0Xv+pwPYlSIA95Nu3VSpAQ3hveRcOqv
 DCAPJZvMP6GyGig/Ear37jNEeUUNOozQvOIpaBpFIwweMCFavK00sCBsTin+vzpGVnTZ
 ZW9O5f7LllD4iawVP+DmKhVr2Z8FJd9Of2BPVswVqUYv5JgXSLWvBZ4Z7KLeR43gLAyk
 43uSScsVvi1oZmaYqEtOEt5EvcvcvxuggXmVjSL9g0z1yb59XH+WDSteFtWWaaYeVax2
 BidQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwDUKHZxS5R8BmbhBvcLcCrhCd5bg1+lrCJVOJSwNjuqCcihL1JcyoMhwfq1wNfRSdhkPIgcgxjIc0@nongnu.org
X-Gm-Message-State: AOJu0Yx0xSEsmL4VtO1MgD2UYN/EOkVV01DGkqF6ze2/IT9gMom4zgAn
 UzdH5j2vy9rZ1O0E1I8+43ooAeguBncJm0TNBYB6jDZb7bDTZSnqQcbtyksBLLMO3q3K51KhaNM
 w6Okh+fiibvBLE898DVJkEQd8uCPQm8Hk8jsnjShZyBxbQRvW8DVhf8mEYO7fh2Fn7mokTIn3vH
 1TRZYfa8Av4etOEerS5Clssi8Yfks=
X-Gm-Gg: ASbGnctiRhxC7dG960g3PWGvuCfTFbYCu531iqNMxfkCVj8z++fK+bqZRkRMSPRLOVM
 ypbm8C6vpgVaaW8WTDqarQsOC11CJ3ekAZ9hGjBs=
X-Received: by 2002:a05:6808:218a:b0:3e6:5a7f:e102 with SMTP id
 5614622812f47-3eccbf2fddemr4609160b6e.9.1734613262482; 
 Thu, 19 Dec 2024 05:01:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGem+u4pXMY2/fxMERtjxOD/e4n9ZDzvIrCCP3AGa2QsHt8m2uZ/JX6QkxHHtxhC488RElcTIfAldR7RJ1gblE=
X-Received: by 2002:a05:6808:218a:b0:3e6:5a7f:e102 with SMTP id
 5614622812f47-3eccbf2fddemr4609138b6e.9.1734613262197; Thu, 19 Dec 2024
 05:01:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <Z1CpIA7_o7s-NzJ_@x1n>
 <23398782-6d92-48ae-99f3-855b405f366f@maciej.szmigiero.name>
 <Z1N4qYOsEcfsC-H5@x1n>
 <5c6a0bc3-ab9a-4514-8feb-f3c17978d3af@maciej.szmigiero.name>
 <Z1se0X6eq1DRYLa0@x1n>
 <CAGYh1E89i-AeHMOt5ddmB_-oGVYqBHr1Oj55OUDyhpzor9bDuQ@mail.gmail.com>
 <44e311d9-3af1-4a84-a2cd-da3a64cb8a94@redhat.com>
In-Reply-To: <44e311d9-3af1-4a84-a2cd-da3a64cb8a94@redhat.com>
From: Yanghang Liu <yanghliu@redhat.com>
Date: Thu, 19 Dec 2024 21:00:51 +0800
Message-ID: <CAGYh1E81ZgmaB0CK3bdovSU8FtTOzvMBwpYUgwc2X5Y9PF-_ww@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v3_00=2F24=5D_Multifd_=F0=9F=94=80_device_state_trans?=
 =?UTF-8?Q?fer_support_with_VFIO_consumer?=
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, 
 Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex.williamson@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org, Chao Yang <chayang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Sorry for the inconvenience.  Let me try to re-send my data via my Gmail cl=
ient.

Test environment:
Host : Dell 7625
CPU : EPYC-Genoa
VM config : 4 vCPU, 8G memory
Network Device: MT2910

Test report:
+------------------+---------------+----------------+
| multifd=3D0        |     outgoing migration         |
+------------------+---------------+----------------+
| VF(s) number     | 1             | 4              |
| Time elapsed     | 10194 ms      | 10650 ms       |
| Memory processed | 903.911 MiB   | 783.698 MiB    |
| Memory bandwidth | 108.722 MiB/s | 101.978 MiB/s  |
| Iteration        | 4             | 6              |
| Normal data      | 881.297 MiB   | 747.613 MiB    |
| Total downtime   | 358ms         | 518ms          |
| Setup time       | 52ms          | 450ms          |
+------------------+---------------+----------------+

+------------------+---------------+----------------+
| multifd=3D0        |     incoming migration         |
+------------------+---------------+----------------+
| VF(s) number     | 1             | 4              |
| Time elapsed     | 10161 ms      | 10569 ms       |
| Memory processed | 903.881 MiB   | 785.400 MiB    |
| Memory bandwidth | 107.952 MiB/s | 100.512 MiB/s  |
| Iteration        | 4             | 7              |
| Normal data      | 881.262 MiB   | 749.297 MiB    |
| Total downtime   | 315ms         | 513ms          |
| Setup time       | 47ms          | 414ms          |
+------------------+---------------+----------------+



+------------------+---------------+---------------+
| multifd=3D1        |     outgoing migration        |
+------------------+---------------+---------------+
| VF(s) number     | 1             | 1             |
| Channel          | 4             | 5             |
| Time elapsed     | 10962 ms      | 10071 ms      |
| Memory processed | 908.968 MiB   | 908.424 MiB   |
| Memory bandwidth | 108.378 MiB/s | 110.109 MiB/s |
| Iteration        | 4             | 4             |
| Normal data      | 882.852 MiB   | 882.566 MiB   |
| Total downtime   | 318ms         | 255ms         |
| Setup time       | 54ms          | 43ms          |
+------------------+---------------+---------------+


+------------------+---------------+----------------+
| multifd=3D1        |     incoming migration         |
+------------------+---------------+----------------+
| VF(s) number     | 1             | 1              |
| Channel          | 4             | 5              |
| Time elapsed     | 10064ms       | 10072 ms       |
| Memory processed | 909.786 MiB   | 923.746 MiB    |
| Memory bandwidth | 109.997 MiB/s | 111.308 MiB/s  |
| Iteration        | 4             | 4              |
| Normal data      | 883.664 MiB   | 897.848 MiB    |
| Total downtime   | 313ms         | 328ms          |
| Setup time       | 46ms          | 47ms           |
+------------------+---------------+----------------+


+------------------+---------------+----------------+
| multifd=3D1        |     outgoing migration         |
+------------------+---------------+----------------+
| VF(s) number     | 4             | 4              |
| Channel          | 8             | 16             |
| Time elapsed     | 10805 ms      | 10943 ms       |
| Memory processed | 786.334 MiB   | 784.926 MiB    |
| Memory bandwidth | 109.062 MiB/s | 108.610 MiB/s  |
| Iteration        | 5             | 7              |
| Normal data      | 746.758 MiB   | 744.938 MiB    |
| Total downtime   | 344 ms        | 335ms          |
| Setup time       | 445 ms        | 463ms          |
+------------------+---------------+----------------+


+------------------+---------------+------------------+
| multifd=3D1        |     incoming migration           |
+------------------+---------------+------------------+
| VF(s) number     | 4             | 4                |
| Channel          | 8             | 16               |
| Time elapsed     | 10126 ms      | 9941 ms          |
| Memory processed | 791.308 MiB   | 779.560 MiB      |
| Memory bandwidth | 108.876 MiB/s | 110.170 MiB/s    |
| Iteration        | 7             | 5                |
| Normal data      | 751.672 MiB   | 739.680 MiB      |
| Total downtime   | 304 ms        | 309ms            |
| Setup time       | 442 ms        | 446ms            |
+------------------+---------------+------------------+

Best Regards,
Yanghang Liu


On Thu, Dec 19, 2024 at 4:53=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> Hello Yanghang
>
> On 12/19/24 08:55, Yanghang Liu wrote:
> > FYI.  The following data comes from the first ping-pong mlx VF
> > migration after rebooting the host.
> >
> >
> > 1. Test for multifd=3D0:
> >
> > 1.1 Outgoing migration:
> > VF number:                     1 VF                           4 VF
> > Time elapsed:             10194 ms                   10650 ms
> > Memory processed:    903.911 MiB             783.698 MiB
> > Memory bandwidth:    108.722 MiB/s          101.978 MiB/s
> > Iteration:                               4                             =
 6
> > Normal data:                881.297 MiB             747.613 MiB
> > Total downtime                358ms                       518ms
> > Setup time                        52ms                        450ms
> >
> > 1.2 In coming migration:
> > VF number:                       1 VF                            4 VF
> > Time elapsed:                10161 ms                    10569 ms
> > Memory processed:     903.881 MiB                785.400 MiB
> > Memory bandwidth:     107.952 MiB/s             100.512 MiB/s
> > Iteration:                               4                             =
   7
> > Normal data:                 881.262 MiB               749.297 MiB
> > Total downtime                315ms                        513ms
> > Setup time                        47ms                         414ms
> >
> >
> > 2. Test for multifd=3D1:
> >
> > 2.1 Outgoing migration:
> > VF number                     1 VF                           1 VF
> > Channel number               4                                  5
> > Time elapsed:              10962 ms                  10071 ms
> > Memory processed:     908.968 MiB             908.424 MiB
> > Memory bandwidth:     108.378 MiB/s         110.109 MiB/s
> > Iteration:                               4
> >    4
> > Normal data:               882.852 MiB              882.566 MiB
> > Total downtime                318ms                       255ms
> > Setup time                         54ms                        43ms
> >
> >
> > VF number                    4 VFs                        4 VFs
> > Channel number             8                               16
> > Time elapsed:            10805 ms                  10943 ms
> > Setup time                   445 ms                       463ms
> > Memory processed:  786.334 MiB            784.926 MiB
> > Memory bandwidth   109.062 MiB/s         108.610 MiB/s
> > Iteration:                              5                           7
> > Normal data:            746.758 MiB             744.938 MiB
> > Total downtime            344 ms                     335ms
> >
> >
> > 2.2 Incoming migration:
> > VF number                       1 VF                      1 VF
> > Channel number                4                            5
> > Time elapsed:                10064ms               10072 ms
> > Memory processed:     909.786 MiB           923.746 MiB
> > Memory bandwidth:      109.997 MiB/s       111.308 MiB/s
> > Iteration:                               4                          4
> > Normal data:               883.664 MiB            897.848 MiB
> > Total downtime                 313ms                   328ms
> > Setup time                        46ms                      47ms
> >
> > VF number                   4 VFs                        4 VFs
> > Channel number             8                              16
> > Time elapsed:             10126 ms                 9941 ms
> > Memory processed:   791.308 MiB           779.560 MiB
> > Memory bandwidth:  108.876 MiB/s         110.170 MiB/s
> > Iteration:                          7                               5
> >   Normal data:             751.672 MiB           739.680 MiB
> > Total downtime             304 ms                    309ms
> > Setup time                    442 ms                    446ms
> >
>
> This is difficult to read. Could you please resend with a fixed
> indentation ?
>
> We would need more information on the host and vm config too.
>
> Thanks,
>
> C.
>


