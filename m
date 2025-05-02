Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46614C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAxpF-0007Co-1a; Fri, 02 May 2025 17:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <superbisquit@gmail.com>)
 id 1uAxp8-0007BP-Bh; Fri, 02 May 2025 17:21:34 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <superbisquit@gmail.com>)
 id 1uAxp6-00067B-7p; Fri, 02 May 2025 17:21:33 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6e8f43c1fa0so36269216d6.3; 
 Fri, 02 May 2025 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746220890; x=1746825690; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OXJ6C//gEikyQWAqvRYgEjEYJfR2mIjtstpxrq5DIn0=;
 b=be3qF4IzzdwZCN05p6osVQZekHMgk2eyDQc4tce0xGExzjWAIc27Kb+pWO3VMSqkAC
 2FIIRaFdZ/3TZg1hqzam0hdZ7/Z7i0TZCkCEPimoQ5FpWQXb1eNLqMztq4GSEerbvNlV
 b92iycXiYs1XVot/ILEEXUJcnlXbRY66/V+bZhfAeEO/hVF2AFAEVsY97M7FAr85gKGQ
 lEsgyU1oKNCU5iDrekIFYpY+LUCsBYKrX+RWMk0Ktj5JD8huG6NBziIhpRrw/xgAdL67
 nUQHNoEsaV575hbJdHGG4O+XKn5cb2aE27x1e9TgjteiaWyNZC2zOjvYVdUVy+GSMZ3A
 +3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746220890; x=1746825690;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OXJ6C//gEikyQWAqvRYgEjEYJfR2mIjtstpxrq5DIn0=;
 b=nngf5FriUKn5POHc2ZWZNKdqrsugBOJimvXASqZXQcdpd+UqhGOd71S5EN4BcsNxj0
 Z9G62Kn3LhjjGzhdsXNFYQjl6/EMmSwCsi2X1CwNVoP8lY7/xcSkxxSLagnKrMTOZL8t
 Pt1I2YIbASvB40eaQ9TcGEwbkOdhjgtarIBw5p4jRN0EtfP3e0uHXYHF/nLdq094gf+n
 xjK9OFjJ3r0QckbH8nbqGnvt0v/qBxZKoToGmYYW5Zzhy99UBN2dVLvZHYKF0EoOgg79
 o1oLzuJrR8Go6w84PL1PL1f6r3cbIEuu659BZ+XhTmz/ZkySbzlgw2v87jDMTwQT154n
 i29Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ7SoEh1wgHIReiuiT5pjFW4//Hn37ZVNAs26pX/srl5QQGRLq6kta9fNOAu1Bi1twWVW6fbvuNwri@nongnu.org
X-Gm-Message-State: AOJu0YwX1jtrarm4o+NuL9KsuGWtjjnzQeUUJaohq7S42Cp6VUDKEUPg
 3CHsSYY7CLOfUVwJk8FlcxdRLPObNjMYbX8pU4jGCQCojTJ2jwARLyK6MaURqdIN/MWlYTZiJnc
 fu0DJQ0oCn44IYjuii59nU0ulZMLN6ZBm
X-Gm-Gg: ASbGnctV2fJ0etorIUwtnQvmLLtgNHCDg4aUsQyqGrgbKhVdszuEtWZqGY7A8QzD2g2
 A4petKYgUcbxN69vOFWMIfA/bLVJSgZ7/tQtW3PvEpVio98v9Ow8aKN6G9/c9HKiDrVMENUFlue
 4wRePYJ5/2Ugq4aA5lHxOEYA1OX/tRulc4SS5lXgNNx6VC/YNnaaTCeg==
X-Google-Smtp-Source: AGHT+IH3ovs7h9pJlEHGxJVf3HNuVdURZcfvwJ5t7xNNHOGFaSobaDaveKXpu/yLqTmtr2mBLEA6qzWkzu4ZjyP1+aw=
X-Received: by 2002:a05:6214:d03:b0:6ef:cc6:953a with SMTP id
 6a1803df08f44-6f515276d71mr68728636d6.12.1746220889794; Fri, 02 May 2025
 14:21:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:318d:b0:6ee:cff0:2fca with HTTP; Fri, 2 May 2025
 14:21:29 -0700 (PDT)
From: Joe Nosay <superbisquit@gmail.com>
Date: Fri, 2 May 2025 17:21:29 -0400
X-Gm-Features: ATxdqUFddwwwHNrAIy5NayB2JL6Q6-eOzyQeIxKbiHF84gCLRCK_SfGW3QY5gcE
Message-ID: <CA+WntOs8z3Fp3G4q=bUHKcMrC=j+YZcz-AcsZY-o4M1Gf1ZWKQ@mail.gmail.com>
Subject: BHyve on POWEr 64bit machines with virtualization support
To: qemu-ppc@nongnu.org, 
 "freebsd-virtualization@freebsd.org" <virtualization@freebsd.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 FreeBSD Hackers <freebsd-hackers@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000d5ebb306342dbb29"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=superbisquit@gmail.com; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000d5ebb306342dbb29
Content-Type: text/plain; charset="UTF-8"

In the source code of BHyve, there is a reference to qemu. The partial
solution is to ask the qemu poc and development what the CPU machine
parameters would equal the physical CPU. If that is not available, then the
virtualization would need to be the most recent CPU software translation.
I thought about this; and, you would also need to study what the Xen
project did.
If you could find a work around for the hypervisor problem on the Cell CPU,
then you could test on any PlayStation 3 that still has the other os
function.
I am aware that the FreeBSD hackers list usually are i386/ and64 hackers;
yet, some may have experience withRISC architectures.

--000000000000d5ebb306342dbb29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In the source code of BHyve, there is a reference to qemu. The partial solu=
tion is to ask the qemu poc and development what the CPU machine parameters=
 would equal the physical CPU. If that is not available, then the virtualiz=
ation would need to be the most recent CPU software translation.=C2=A0<div>=
I thought about this; and, you would also need to study what the Xen projec=
t did.=C2=A0</div><div>If you could find a work around for the hypervisor p=
roblem on the Cell CPU, then you could test on any PlayStation 3 that still=
 has the other os function.=C2=A0</div><div>I am aware that the FreeBSD hac=
kers list usually are i386/ and64 hackers; yet, some may have experience wi=
thRISC architectures.</div>

--000000000000d5ebb306342dbb29--

