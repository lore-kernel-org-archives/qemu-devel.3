Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6B5C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94aX-0002F0-Vq; Tue, 22 Sep 2026 13:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x94aS-0002Ar-VH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x94aR-0008Jx-0P
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790099242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Au1S03sZuhKhQA7TY1/gr8SPznpnyCN3Z0wO3TBERwA=;
 b=UqywXuAQlwsCZu2qoAHoTzRsb247KMRXa5WYzVbsqhC7D0y1T6q4yRuOiFr+YIB9cHu9/j
 Qpj25WWgHafF1n44OWEuao/iXDZCJsEXJxUZ75Zv7qSPhAccwYpePXRUn4S9IcS7XY1cdc
 3KhR9I1+ZM4nt6vaZUmFe5eEw9iU06A=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-iP0Iaj_6PRWjcMWQuyVO6w-1; Tue, 22 Sep 2026 13:47:21 -0400
X-MC-Unique: iP0Iaj_6PRWjcMWQuyVO6w-1
X-Mimecast-MFC-AGG-ID: iP0Iaj_6PRWjcMWQuyVO6w_1790099240
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-671562ddec3so76007d50.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790099240; cv=none;
 d=google.com; s=arc-20260327;
 b=Z1XFvq5BuCPlk5z/W1v2jKpw8MD6yb/liW/TOcDnJh9Fh2eBvxJoLNewmfeB2P4wu1
 jKuEnOKQ9FbjtjWLc0TVymAdgcpRECv/A4iO4Qerrozut4Zy1irSBK1xo/vi6wP/8idC
 mKRrcVqm0R54MOIwrlQVIa8aJ0GKZwrU2GhCEqaHo3dsNZJC5coSB0k1UgiDxRKARtry
 i3P8HBX16dUNbDW8KE6L4Y9NAYDiHIQHkFLbZwt2dv75f442MTi4MW5vsdXf8ayNC9bj
 giCN1DT72nLV36w5wrarcNSFTHaqov6VnHR8qF5GcPZrUjhOGqoOu+R2dhYi9o7Q1Cmp
 C8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Au1S03sZuhKhQA7TY1/gr8SPznpnyCN3Z0wO3TBERwA=;
 fh=BzoPGq5Jo41weusZz633tQuPuwEKbqvy/dnjcvDNpyg=;
 b=rbohxD/ENBWYAv5DnAn7gwuU5059VZ6a0XPpI7z39XVDoGg9alnsYfGikh3/VIcAjh
 kV+x3Tlho1C/h/zgo7P2X2FkJNF0mjKwUC91cGoXlJIa8pgNllb9zbP8/x4U4SSNyQU/
 Xi4YP92w7VBqZ5qbNDWbw0maYoaNxZJxwFebAlsD+P4ibpBGU64fDWd6MfYf8CaD7vvd
 geR5e1ESY9v3X2QoTKbw5VM9rZf0FRQBk/J7L5YlgJ+cWhAbjkgq+7CYZd+tmlCgoGHU
 Q9XzwgAwHS6IhTStZHnK2s4E0xBTF6aS+lpvWyEvJjmhgg4AeGeP+AlAykIrwnkgeNh2
 d32Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790099240; x=1790704040; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Au1S03sZuhKhQA7TY1/gr8SPznpnyCN3Z0wO3TBERwA=;
 b=tumKbxnU68ukOlyK14zjMImPslP9E1OAhiYEXggwKBpXmzAPe1O4HZ2/rxs8L/xdrC
 P3FfxA2G+3JBo3rWLxI1yO3ymNAeciILHaNkVNAbsXfsPNrvTf/R9sMx7SAuvjRgEglT
 q2Dcsd3t8SxiYUXkkNBhVV0c1eaJuYJpkAfQSwF2ip6XeRyosxPFe+nEEfldJ5y3VmNp
 UvP1F/f9R9+WXEHrWbJk9B4XgAaEuQUchaVdPJhrIspCCQpHJgxvoVfxYrm2pr/oSWCG
 2KLnd0x0uz2Rr/zBxsa8fMwQixCtrc9IdcvEocJlMsGbscADSMLortvVBBybOvs5vJCW
 sHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790099240; x=1790704040;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Au1S03sZuhKhQA7TY1/gr8SPznpnyCN3Z0wO3TBERwA=;
 b=jwGZ6ReEk7fpPz2jsLOwvZboeW5FctJspltRzpQWUltbmxToMZzq1M2hMYyWPSFHPY
 hEdihd+W2nLGXC6zRm9obCT6M5iKcjLc454PeTlRE6ghD5IrwPEZAX0CXc4zH7wIvWd2
 wdpeW4kVf9nbncJ1LR8iTF5BpcoJrHCGRiwl3Rn1CUkAE9EfNf6aejEF1GXCegKFKVAe
 ZhaRDSPF3DGXO9YmNfLID1B/ZUbiNhkkHrM++DAvLb0FFzB+PPN8LO2AxfonmI912wQW
 kebiokYQxSVm4hLTMYWRYBFf06n6q/XDkHYIIKOVnIwHGQHhgF9oPzejGkB8glny86rT
 QIvw==
X-Gm-Message-State: AFuF++mQINvSw4nLVCHFGj+z7KpRN9xK3uM1a42zBJQFi2/XPkHSbbd0
 H1CIwAKlxoUzj+U3Ufbd84BaF4/wMHy/Ej8iLncKzkB30fE7Tk4+aZb8w1pSKRnGZexkD+RCh9U
 L64nqxDYTnLmsKBjUcbUa9Ffe9O7RhiCR92pgkWeJTfS9vq0zf6EfsbzgfBBsGpnnC532yyTvZi
 PZuFv5QMeDe0ICR5fMz5g+mFOrUa8licW3Vf9UTfg=
X-Gm-Gg: AYBFou0c27BoNmfpqKiBM2U8An8naF0u8EIrmyAUujR+7GKGx0NGRBTC6CTF+5K1FY/
 9TvLvNis0GsoCB4Pc4x6CM/aFVLOgPstENKH3YkQNk80p6pkkxvDFeJUnewKuQHz/cT8Nhec/dp
 BFxus5hUN/jF9Q8Q/DIbHBAwAqlY+EEYrmFD4Opzjn5883KYlsPQerIAGV++7ooJut7CrcDuaPs
 BY/MnBcCVUCnlvn
X-Received: by 2002:a05:690e:454f:20b0:671:203c:2fce with SMTP id
 956f58d0204a3-672d5751276mr146665d50.17.1790099240414; 
 Tue, 22 Sep 2026 10:47:20 -0700 (PDT)
X-Received: by 2002:a05:690e:454f:20b0:671:203c:2fce with SMTP id
 956f58d0204a3-672d5751276mr146649d50.17.1790099240021; Tue, 22 Sep 2026
 10:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260921205147.1857168-1-jsnow@redhat.com>
In-Reply-To: <20260921205147.1857168-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 22 Sep 2026 13:47:06 -0400
X-Gm-Features: AcwNN1VWMem5c6zZaljL-lEPK92qlepT5HJ0RAuuYZABnkXPAvzGq3TYMRYqcPg
Message-ID: <CAFn=p-Z+UCaZKo8RBnmRECSUHU+jnYe-5K9CyLeoNn2-1s=Zjg@mail.gmail.com>
Subject: Re: [PATCH 0/9] qapi: convert intros for qga, firmware, etc
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, 
 Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 21, 2026 at 4:52=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> One day I will send patches that do something else.
> Today is not that day.
>
> John Snow (9):
>   qapi: convert remaining simple sections
>   qapi: convert intro sections for unit tests
>   qapi: convert trivial intros for qga/qapi-schema.json
>   qapi: convert simple intros for qga/qapi-schema.json
>   qapi: split intros at natural cutoff points for qga/qapi-schema.json
>   qapi: split intros for qga/qapi-schema.json
>   qapi: convert intro sections for docs/interop/firmware.json
>   qapi: convert intro sections for docs/interop/vhost-user.json
>   tests/qapi: generate output in source order
>
>  docs/interop/firmware.json                    |  76 +++---
>  docs/interop/vhost-user.json                  |  27 +-
>  qapi/block.json                               |   5 +-
>  qapi/machine-s390x.json                       |   3 +-
>  qapi/machine.json                             |   3 +-
>  qapi/net.json                                 |  24 +-
>  qga/qapi-schema.json                          | 249 +++++++-----------
>  tests/qapi-schema/doc-good.json               |  10 +-
>  tests/qapi-schema/doc-good.out                |  95 ++++---
>  tests/qapi-schema/doc-interleaved-section.err |   2 +-
>  .../qapi-schema/doc-interleaved-section.json  |   3 +-
>  tests/qapi-schema/test-qapi.py                |   9 +-
>  12 files changed, 206 insertions(+), 300 deletions(-)
>
> --
> 2.55.0

Markus: assuming I should wait for your reviews on 3, 4, and 8 before
I send a revision.

--js


