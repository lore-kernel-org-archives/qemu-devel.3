Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64ACFC369CB
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Apr 2025 06:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Z9U-0006DG-Q8; Sat, 26 Apr 2025 02:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u8Z9S-0006CY-E3; Sat, 26 Apr 2025 02:36:38 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u8Z9Q-00084m-9l; Sat, 26 Apr 2025 02:36:37 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3031354f134so2575504a91.3; 
 Fri, 25 Apr 2025 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745649390; x=1746254190; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7/DYVcSZH+ZAOykmkKdDPPXfsHSN4FIgsDv2mq8ftDk=;
 b=iCVIGAbIltzIgM33pC7lQtK7m4dPXxwqcExomcSYvaSipipO83JK9mjEUPAxxFa/eF
 4RP8secAR838B/fzqxv0KJCitFPrnH+BPk6+XqEBQtalLRAAhtMHzqnKvUsZurCv4aKf
 RLBGgUespxDILqrGXkWnU+4zFJxcmFRP0w84BT4UyCw1xGIVAjlwvvgcRLS5+6xwECqc
 SDKn3RDSAM7kICitpXsCkH6JDseHxqhKtk8+B1h7T99l8FHx3rkcb3sNoMTH18saxm7w
 /xO+P4jA0NPEv4NDY280WdpvdSk874zhirV8MqYxKHtm0qnPoq7+BdTWDcuI0KAGsc8Z
 5+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745649390; x=1746254190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7/DYVcSZH+ZAOykmkKdDPPXfsHSN4FIgsDv2mq8ftDk=;
 b=IimPoj0JWYjV6AB3PKNFn6jkCTAIn8ePGkMx/K8iQGhiiHdvcSlT1MAwaYMeQn9Szq
 +f+Nh6Pd3BTaRxonlSd3noBvVveezsD4m5MFEtQqozPReXlwu8VWrRVxaMk31KrrzPFh
 mC22Z3t9VjbsEC6XUR91kcvzpuvvL+wTH7qbgAg+VTIY5uXWQ4N4e0pk0/c3mbp78quh
 uZBBg3yaLCv5plzzglkfgIWOZJY8uB9DtYw+TvTSAG+zmdnkbu86Z3gMxK3jklVjK8oQ
 /D8RhgE0izEVRr3MlZz6AdVavsy4V36CAEg9N1ZPy3S0qlARH/uSIl7CAgV65UxELznA
 jH+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU26Gn4HnE17OV9tBNc8oQyVVbqumSCZLgmOhYSrwWYLhngum0m4L6Lf4becUgYIB/YweACrV1+lMg=@nongnu.org,
 AJvYcCUEj06hNYI5g1P+yVLzuEI7ShJ6iRDHpfqpXCuvX6/FWkFxQUZjxmTCtq5NQUX9t29vfqhyFyPcUA==@nongnu.org,
 AJvYcCWDbEsyAid96FOYr0M5nb3ZbffO4KQT/ktwFagQg+8vvpATm20al4IX5dqS7rqskN5DBjctHJ/6LePtrQ==@nongnu.org,
 AJvYcCWRkiDk6Ye9WYWM8eIv5VNFAF+EaUPKavpIC8bRpUBr1M8ajQxaxN4jBc9cl08LCe9ecd1dAVYAPHvbxQ==@nongnu.org,
 AJvYcCXBNuGXCSzZfuFd8fLkNZvk1NC+X/BuLc+98ytsDJYtPdlMolPzOb8yyvsQWMetGQCRu5rksxMg7IqKEQ==@nongnu.org
X-Gm-Message-State: AOJu0Ywfuk0Opfa+XZOtrjDzLGtAt3os3H/cpOJnHFwBBWoycjxsqnCn
 S3oMm/nZgc5QOg4ts+BqlmxoS9na4M09Ru26Ko74mGcdudUlneHSwQ4kKrji8OVsLQWBBiawv7C
 +Jsega4kskUglQ9IhlWcjCZ7RTos=
X-Gm-Gg: ASbGncuaUK20RVbvNAvAvmi5+8ZOMnIlUGG14dVS/1kjgXmoNQ9TBqBXFtxi1/ms1F1
 E2ngAQHzCRzh4kpgGCVGrAh0XP8Dw/jw1HyL7LCI+PjIr37HXKJUdEggDR55MRAb5TyigOSJaiL
 vXtHy5+gtxXK2MIxEgpqZLzNGDAF13e4r7ChaPu3wXHOGInwGntTgt
X-Google-Smtp-Source: AGHT+IHMcheiRX7erJEHMS9wBhZL3GAzAbFVYxcWM3rTtUBOTQfuoJgV8JtbSD2j87Ul7lrwoc20Wvu5/d2oBjfRKdE=
X-Received: by 2002:a17:90b:5101:b0:305:2d27:7ba0 with SMTP id
 98e67ed59e1d1-309f7d87675mr7518197a91.6.1745649390456; Fri, 25 Apr 2025
 23:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
 <edc1b2ac9a26dc5bbf9a3897e842fbb36c69ea87.1745295397.git.ktokunaga.mail@gmail.com>
 <06c52d58-1b12-4036-b243-91be7a1b841f@redhat.com>
In-Reply-To: <06c52d58-1b12-4036-b243-91be7a1b841f@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Sat, 26 Apr 2025 15:36:18 +0900
X-Gm-Features: ATxdqUENhsWBICk9wxb3d5lIslSKZKSH5r1a65cIaeR_TLmUoy57ps7Ep6Mfc3E
Message-ID: <CAEDrbUbq=r_xuKcBLJ+1p5O4rkVVfaq_q5gP7pDuei_5+zCBSg@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] include/glib-compat.h: Poison g_list_sort and
 g_slist_sort
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d212ca0633a8ab3e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102b.google.com
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

--000000000000d212ca0633a8ab3e
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

> Cosmetic nit: Multiline comments in QEMU should start with "/*" on their
own
> line.

Thank you for the feedback. I'll fix this in the next version of the series.

--000000000000d212ca0633a8ab3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Thomas,<br><br>&gt; Cosmetic nit: Mult=
iline comments in QEMU should start with &quot;/*&quot; on their own<br>&gt=
; line.<br><br>Thank you for the feedback. I&#39;ll fix this in the next ve=
rsion of the series.<br><br></div><br><div class=3D"gmail_quote gmail_quote=
_container"><br></div></div>

--000000000000d212ca0633a8ab3e--

