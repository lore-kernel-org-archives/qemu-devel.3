Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFC1FCE083
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 13:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvbc0-0006b1-SA; Thu, 26 Feb 2026 08:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvbbe-0006aD-A1
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 08:40:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvbbb-0002uA-Vo
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 08:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772113238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=By1sTgAbCGDiohxe+SKKTRoQrefzeZotSCr2eN5JuIk=;
 b=b7CQnv03v0xxm5T1p8TUb9oKjO+I7P8LS3vGsgZHIzZyFu/ES3nFq52I5KDEVDt37svGJc
 mPleiqKBDDZK7/+hvYuY5mytpXR5OgFQTf6Uedyym+5pDsUfThpvon/75v157RNTs80w6Z
 eeQZ+Rv5DSsohBEYvxvTJAsBZKp539k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-BS6pzTZSNR6k_pDR7Hwkuw-1; Thu, 26 Feb 2026 08:40:36 -0500
X-MC-Unique: BS6pzTZSNR6k_pDR7Hwkuw-1
X-Mimecast-MFC-AGG-ID: BS6pzTZSNR6k_pDR7Hwkuw_1772113235
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836b7c302fso7837535e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 05:40:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772113235; cv=none;
 d=google.com; s=arc-20240605;
 b=Ka/oXfGzo07wzCwBtI10xIWr+lf75VYVhCXyBjCDMATY045lzuJJsYynLHerQgWY/8
 PjFFHW9cD6yHGYmbpzIwT0VADASB6I3oLGckCzOKlx8WyDI+TUfkciDzbZ5u0TTen3fx
 TPE9aNahg9X0CHjKsiUoXsYl4f/3X/o9zYN9t58VHVGuKvAHhtf3b4C3rG6vBxwD1RXK
 4MXdvntLEyExMTqPzNO8dNDDsf0HgLQGuuEUwOHgLpWIlo0YTcsM9oumKuJuMo0tTulC
 sWd8H0kJ1wNgrDsRwWVYECHp8+0KJr/klPbxNMZRvL19mF0gVYA4nPdgwVLN16I1PO7B
 1zYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=By1sTgAbCGDiohxe+SKKTRoQrefzeZotSCr2eN5JuIk=;
 fh=DkcsS+wDAht8mg8Un44vEXzEP9PftsclVxpMktWLF+E=;
 b=UjdjY9JPSTmV1oe8wTrSAPKjZRrdXRBO28QsZIh68E14Pz9OAUGYUtMvyAGSpTRRvz
 CdmH7qONm0TA12sFX2omgIvXYeiOQa83nlN12qPVMrIuNFag/YM8+FDKRGVYeANV5qVv
 5FsjpaG7mpv2P93/ecWkjodUxO3/Duk0b2wf28tpKcxbgNmvxlyZRRkp/Xs3kPBHyli0
 g8qvRVswtMeSbJAbic3dLw9YN5XcsF1x9O/8XgSmglEiSxhDzr7Jxhbf5wnBXPjjPCu6
 hC8wbpZCZkurFeLnUT1U/4YJOVEFudnpxZJbvaMvpQneOKCIvbh1mUTX5gVN3+ae6dWI
 MUbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772113235; x=1772718035; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=By1sTgAbCGDiohxe+SKKTRoQrefzeZotSCr2eN5JuIk=;
 b=N0v4QVhkt8dg+o7LOBxfiWhVOFTKDsDvXvTaKp6duTR07wTA2m55d/fSc5FYaX2yas
 6xNoNU2/PIm+7oadCWbmhnmZLh8YVO9H1MGMoBAucwxyIHL+W0FaVpjXDgHZ0C75HLs/
 C1RRB7UMnFhTqV2uJ1k2h924UgW6ZBHDn3KI1BYHSzozPxTAL2yRVN2X42NMlgOvzVEw
 zCDSjwiIZWY/i0kjBVVXzEHFsRRyEVyhFrzWm6zsQMTPe96U7c+RwBG37wOynzglsnwY
 tE1H17CHbZal5DwwQqW3hyfcXLI9vgUSNeNVxqDOQGptThdc9tyyZeyBJtWX8nJWHAQ6
 2MmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772113235; x=1772718035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=By1sTgAbCGDiohxe+SKKTRoQrefzeZotSCr2eN5JuIk=;
 b=la5q3phS/k4hMSjZyYpuRjFSxtxNIwKdNDQrFkNbXeLa1tIoe9g3igL0QVBcSu6EQp
 bLkINDOZb2x4oVZeNkY6eO4+pmA4BJqn8pJxKivZmADsRlMFPI8WFS2h0go//Llx8Yo5
 hECnlXdQirVKBK7Cvi5Zrp6GAQWts7nNJ83QJRflk+ArL07jisrEfuOV0o9qMOjwPdHI
 qH6kkcG+PJuXJHPUPxlnBEvhWXcgKDuFe98r6+33iwkskcNpoifSqFlKLUWGseHf3vpa
 nRB9RJppBOguvSgFFt2PxtaEMcX3VRISoTVtlvqe0uIrjdjx4PmyzlAYMKwMG/5Po03K
 Z7Mw==
X-Gm-Message-State: AOJu0YyneaD066HmGq62KyUrHqJ6hj2sLViGbIRtOT1oGy7/SpCByFjh
 D14CGjtujgEwSQaPkm0qsm9d4MQ+QavCTtdvxHb0VeMtsdy09CeM7j5uzQp7RxNR7O/NwkR7VIS
 FbvtdwSKpbRwpfUQ/sHo+4dvl4I9AGRCMy8pOnwMjkjTD2NsYKPres3vBz4kxWFaiBBVksv1abs
 eLjL17qKkviBi61QEhx1+EMwuyQH7DvWw=
X-Gm-Gg: ATEYQzw85bVumne2urWVbGUDy3d62IPE3PYu03OB7s2OkDM9E+VARUxINfhoH8qdaA1
 xvQZbRMIn1VSt1KTieXR+ufotxtPGeKgOGN1iMIat+HwWdPpltwcoT9MXFAOk1abOVxc9nsDUcd
 8zX8Skt1Gp0elTFbd4NjRwVHbsDaN6asDyo5fqeDdUF628xRN1qSJbkr6EfT3wcWrol7FOdJc9B
 M41KP0/ewhC47bZ4nMSu2RIFfSrAvGH5+mnK0SISnbBzugngbrJpLBtYegbQ3+9vYMukXih5Ds5
 I+i9EwI=
X-Received: by 2002:adf:f10c:0:b0:439:867d:1818 with SMTP id
 ffacd0b85a97d-439867d1a31mr14988492f8f.19.1772113235065; 
 Thu, 26 Feb 2026 05:40:35 -0800 (PST)
X-Received: by 2002:adf:f10c:0:b0:439:867d:1818 with SMTP id
 ffacd0b85a97d-439867d1a31mr14988457f8f.19.1772113234632; Thu, 26 Feb 2026
 05:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20251227091622.20725-1-pbonzini@redhat.com>
 <20251227094759.35658-32-pbonzini@redhat.com>
 <CAFEAcA91Ghhhve2=aSB+Af6C_Hhdh1-MMQCuUWDpwwMFvYHJgg@mail.gmail.com>
In-Reply-To: <CAFEAcA91Ghhhve2=aSB+Af6C_Hhdh1-MMQCuUWDpwwMFvYHJgg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 26 Feb 2026 14:40:20 +0100
X-Gm-Features: AaiRm52tlf3bIbK7kKWN4IHS7N0Ey3GJdMerQcd0YQGPIXSQZZclTJFcA8hB8Hs
Message-ID: <CABgObfbaGUUCXEOpd5r3ymybbmN6XnTq+L18a79QJF9JtS-SCQ@mail.gmail.com>
Subject: Re: [PULL 106/153] bump meson wheel to 1.10.0
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 2:39=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Sat, 27 Dec 2025 at 09:55, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > This version includes several improvements and bugfixes for Rust.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  configure                                   |   4 ++--
> >  python/scripts/vendor.py                    |   4 ++--
> >  python/wheels/meson-1.10.0-py3-none-any.whl | Bin 0 -> 1057029 bytes
> >  pythondeps.toml                             |   4 ++--
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> >  create mode 100644 python/wheels/meson-1.10.0-py3-none-any.whl
>
> Hi Paolo -- should this change (now upstream as commit 8c04b6a48b15a)
> have deleted python/wheels/meson-1.9.0-py3-none-any.whl, or is
> there a reason we need to keep both 1.9.0 and 1.1.0 wheels?

I think someone else must have reported it.  I have a
patch deleting it queued for my next pull request.

Paolo


