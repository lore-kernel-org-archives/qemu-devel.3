Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D25E9A03E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 22:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsU2R-0002pk-CV; Tue, 17 Feb 2026 17:59:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsU2P-0002pN-OL
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 17:59:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsU2N-0004xZ-NB
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 17:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771369160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=il0IO40dlCf8CRhaTHzhMGY41U6uroR9xUmFBNQEMIE=;
 b=BafC5iTElhsMz6yVOtNdtWuGefp5f589NhQcnjh/JSCNY6n6VP85hq3GuNatXDRqbqp92Z
 LxSteTIRFv2FYB+IiaBgBzzAl+F+qWWDT++utMsru98CebXMXj5OteHzf4C1RB+9ueYckO
 miNkg+fN05kixImyQzz9DDJ44y7G9Uw=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-TsEDmG_ZN5CSQy2kfAaVIA-1; Tue, 17 Feb 2026 17:59:18 -0500
X-MC-Unique: TsEDmG_ZN5CSQy2kfAaVIA-1
X-Mimecast-MFC-AGG-ID: TsEDmG_ZN5CSQy2kfAaVIA_1771369158
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6445cf02fcbso6184801d50.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 14:59:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771369158; cv=none;
 d=google.com; s=arc-20240605;
 b=GB+KWsl3OeMZ7MwOrW83KzSsdPwHUTZKrmqQJbP+fKcFX/UCV51NQlQgoFOhHJBdHY
 lZrxPTNepIEcXTa0NPfX5oQPtgBhRaIzM3jfPoHZ7qK/QnvAY8zrn2/8OGqRd/6msZzo
 /45eaknFN0hVmqNi0got+3UxViLXck6h8p60TqHNr8+FGPGOawGc5HtAAgyQGQ8eXx5R
 tRVf5pcyoxIqrY+n3RWzfQpqsN2mkm8QAMhv7XcgdQzWXO4trkrcSdKy0dwhG5AyyejN
 /u+2wsJRdRnxkkyHHR4g1M12Ax1ABUsmzCVjgEeKmZr1BsEXsOIkbcyHVcWCTl6UG82v
 aGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=il0IO40dlCf8CRhaTHzhMGY41U6uroR9xUmFBNQEMIE=;
 fh=8C6y83VEMDKlK39gq6r2vep4v8J8/aEe9p+XfkW5wUA=;
 b=IlyuzqvZ17WUsavPm/P3uDFqg2Rc+jzWkXkXlzXYEgg67/eAJkXGCL2hKq7hHd9yFR
 ugxxtXZF19e+E3uvCdBLhoCSjXz/HbZhWX97xbgkHD6gSiU/RRfs7SvKbXNzahgOl/ek
 ryw8K5eJgsQjGGgRVd4u7nuqUx2A6p4yIItQxux78A9afjEoxlMdBmgHVO0UtGaCcJwp
 mbQfioBPtfR4uAnBs91Awz71+xzfnsx6PLJI86ZsmHC2j33kOII3tkE3KD/IpVwVBuHI
 B5a+NJU/3VbHd9PeBD0REcmdUvoa/bdLXEdPSTNwyZ1cqjsthl5lZynscOdS/2rRqDRd
 ccxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771369158; x=1771973958; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=il0IO40dlCf8CRhaTHzhMGY41U6uroR9xUmFBNQEMIE=;
 b=kJIuKzlWEdFRSSyhJ3rxEDjZw6qUgzqUjsyAQXw1VkDMUM5xgPiFUvBFGxILqvA3Uj
 8F523fZwjEqW6PH85VC1q5SYQxLB4bWIT6Qgn9CJd3o/WzidEQ+4icFjjVLj3uCnXWCM
 yG92JD9W07StXG2Niv9GhDmsllWgc6eaoaHp1I60N51PUbNc6jwu4FuOIBzWVlvCJ1EC
 GtaQlr7AB2P+xYs7ltdJJLA0TWZzHQXIaK1B6WxZ5pWnWxKHMCJ1dmDbVXRGToe9LuAi
 Lvok3IHpmZOijn5Y4gvUpZ4WM05puO/lkwTmyhA5ePxaF2s5FCmhjwnW/wsTp9mjiccK
 zarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771369158; x=1771973958;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=il0IO40dlCf8CRhaTHzhMGY41U6uroR9xUmFBNQEMIE=;
 b=Gwa1kEYvXaELgxUwpviWiFKxZM++wgnfCWPRpEsy5TMIw2rg4gie22l8HR45Pf7kLD
 2zA/JdCOC7pZEJDCOqZx3Fjk047NnP5CPgFilc1OlIk3dDYXrNBj1N6G2HrturQM7YZe
 D7EbILiSuRHid9xGXJbKjT6byPAaNoHpmxXUFqUsUtj6vAArqDMPtjiFNfRYx53kmtfV
 qilATwphToAK7AP/OTQtO4wXNO0Tb6x8Vt0E9esCZ+IXYwAnnaz+PWFooae771Mxdugk
 CBqfuAuusFGgMtgrpnCUB5z6Wu+g9NKLl8jLe9rWicNDbCwBNn+cYc9g54uoxqhPW17N
 MvhA==
X-Gm-Message-State: AOJu0YxRCM+914VmQMFl4d3CrZ6+wrGJhMaHBIyetWhWgbdtTR80PZkO
 zbDWAzL8NVOyO3EmpiysfBscjlERX66e4wgA3H7OfpnJ6i8SDEbWbyZpfz6MFFLSYNw6W8nxIE2
 kYHZjrVIJjUv5FsXv8O1wOI+k3blS60CB1/s7a0IRagRSyZa8mjjo/LLDy+Q9RxUIjXPGts7peU
 fLrwrWqLp8BpL8Qll5XjQHO6Rv35oEAUyEv4zX7v0rKQ==
X-Gm-Gg: AZuq6aLvBFEVqYMJ/J1cAFo5buVKC0F6KLgaV5TZp8wkTPb4NOES40sw24IKphVf6lm
 qsoLInVRXMBOQge/juJzeVTZ+/nnZUq+/iJvtJO8tssvWceEDvH7MfcmVOb1WiqrMmQ2J5XEprA
 2OlVrSlZ1uiYk7ptNfC15DZql7cLtxO2KzkbxhDU02E8SY3curXAXyve2E4uZRQvgGYiLS/n0Hj
 QAriDLMb1iUCZCXopafqyN3sQhm8B8adrt9qg==
X-Received: by 2002:a05:690c:6c09:b0:796:2ee6:3fa7 with SMTP id
 00721157ae682-797a0d09a16mr266206657b3.70.1771369157817; 
 Tue, 17 Feb 2026 14:59:17 -0800 (PST)
X-Received: by 2002:a05:690c:6c09:b0:796:2ee6:3fa7 with SMTP id
 00721157ae682-797a0d09a16mr266206287b3.70.1771369157370; Tue, 17 Feb 2026
 14:59:17 -0800 (PST)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Tue, 17 Feb 2026 17:59:06 -0500
X-Gm-Features: AZwV_Qg6s_tZEP83Gzr8jo8LKofznZLJILyO4M7Glz2QE8i3_6Af4psw0GMOlDo
Message-ID: <CAFn=p-YGckyEF8GCOviMJ-FfWsM_dDa6nqEBJChPmUxP7Ydi_w@mail.gmail.com>
Subject: CentOS 9, Python, and other Fairytales
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

FYI,

bash-5.1# cat /etc/centos-release
CentOS Stream release 9
bash-5.1# python3 --version
Python 3.9.25
bash-5.1# dnf install python3.12-setuptools python3.12-wheel python3.12-pip
Last metadata expiration check: 0:02:24 ago on Tue Feb 17 22:39:26 2026.
Dependencies resolved.
==================================================================================================================================================
 Package                                    Architecture
 Version                              Repository
Size
==================================================================================================================================================
Installing:
 python3.12-pip                             noarch
 23.2.1-5.el9                         appstream
3.2 M
 python3.12-setuptools                      noarch
 68.2.2-5.el9                         appstream
1.6 M
 python3.12-wheel                           noarch
 0.41.2-3.el9                         appstream
166 k
Installing dependencies:
 libnsl2                                    x86_64
 2.0.0-1.el9                          appstream
31 k
 libtirpc                                   x86_64
 1.3.3-9.el9                          baseos
94 k
 mpdecimal                                  x86_64
 2.5.1-3.el9                          appstream
86 k
 python3.12                                 x86_64
 3.12.12-3.el9                        appstream
25 k
 python3.12-libs                            x86_64
 3.12.12-3.el9                        appstream
9.7 M
 python3.12-pip-wheel                       noarch
 23.2.1-5.el9                         appstream
1.5 M

Transaction Summary
==================================================================================================================================================
Install  9 Packages

Total download size: 16 M
Installed size: 66 M
Is this ok [y/N]:

...

So we actually probably have decent movement we can make as soon as
Ubuntu 22.04 is dropped; enough to do:

Python 3.9 -> 3.11
pip 21.3.1 -> 23.0.1
setuptools 53.0.0 -> 63.1.0
wheel 0.36.2 -> 0.38.4

With most of the new sticking points being debian 12 (EOL in June) or
FreeBSD (timeline uncertain for when they'll re-modernize their python
stack)

One edge case here, however, is Sphinx, which does not actually have a
modern package in centOS stream 9.

CentOS currently ships 3.4.3, but it would not be usable if using the
optional 3.12 upgrade. If we ignore this, both FreeBSD and Debian 12
have sphinx 5.3.0 to offer us, which is a reasonable version jump, but
it means that CentOS would not be able to build docs unless you
enabled `--online` for configuring QEMU or sideloaded Sphinx
otherwise.

That's enough to delete a large amount of the horrid crap in
docs/sphinx/compat.py, though not all of it - version 6.2.0 is the
version that would allow me to delete the *entire* thing.

When Debian 12 is dropped (June), we're waiting on just FreeBSD to
modernize their stack and we could make that final leap, too.

My plan:
- Wait and see what happens after the current QEMU release
- Gleefully drop Ubuntu 22.04 in April (Allows Python 3.11+)
- Gleefully drop Debian 12 in June
- Hold my breath and see if FreeBSD happens to modernize by this point
(They have until October 2027 to do so, so it's a dice roll if they
will or not)
- Do a big round of Python modernization all at once; either to 3.11
or 3.12 depending, and either to Sphinx 5.x or 7.x depending, pray for
forgiveness that I am removing CentOS stream 9's ability to build docs
offline so I don't have to wait another six months and then do another
big cleanup round

Updated version dashboard:
https://gitlab.com/jsnow/repology-dashboard#results-overview-as-of-2026-02-16

--js


