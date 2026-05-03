Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAB0CD3426
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 14:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJY0h-0000rK-Ry; Sun, 03 May 2026 10:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wJY0f-0000rC-QL
 for qemu-devel@nongnu.org; Sun, 03 May 2026 10:41:29 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wJY0e-0003lF-AO
 for qemu-devel@nongnu.org; Sun, 03 May 2026 10:41:29 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-651bf695701so3113849d50.2
 for <qemu-devel@nongnu.org>; Sun, 03 May 2026 07:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777819287; cv=none;
 d=google.com; s=arc-20240605;
 b=hts0k79c4tatXgxNOJyNSvs67JjsJlyC6OTLHpzBlm/9nACxsxm0v6O5fznbAbYEQI
 3MgAO92OoANoB6qH2lN15wSK6oWUBqd8YKD7LQArKiDGk5jyg9GrPWcDFOWnoSjNyPC+
 3ZMMPDdyo5O2PMd2rohcWYACpRDfxQCoBHNNfkL+OjE+TPqiqz91N6i+dQmPwiUCAdh+
 NxDIX/avQ9Up3bZP+JM2JIWxvJa0zE0SEBHx+TADviURBgHrqi+NNIB1uYao9831J+n7
 WX23m/k2s+KY+8YmIW2cGi5UfxU+IJoUeSnW8wkWCQ+Vsbae4ska2NWnWNVbJw1s2wSQ
 e76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7WOcIr+/gJWc/WRnMK7An29JDOsKuF4u/LgcR5DP+Vo=;
 fh=L0+NiO1dk2svgH8TdO1hLVvvgiN+SVSZdG3CsBcLNBc=;
 b=PlOassjGCHGi/sGq5JaAItD112upEaJNFpJp9kBkTG0fwtyes1ytg5iCn0UjIl7qOg
 EHxkY5Sm5YRiRqu/ffnu+22nGTCphYSTHp7gSfaXuGRx7xVRHoNU1uN5Z/EodwQJUt+T
 t0U6zD1pP8piYwJk6Cu6a5lEyaHt6jfcjRT0LX1IRI2rFL56Tw7u0M1ihSyD28UQt4QA
 fZywjahz2Kq2FleOGTA1HWSkwcEzbxwHpVdZzYS93TEQlrdYD/btSgXzM8WMoYWMg6uN
 E2kPKBZME3fUSU339YlyMgwxUpp3dam8PtuNC3z3hSIwd3aMrot/+ERx4K3pIgN0Ouam
 lnDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777819287; x=1778424087; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WOcIr+/gJWc/WRnMK7An29JDOsKuF4u/LgcR5DP+Vo=;
 b=hZBVptR1yIdUDbWHtCXjRkjAicAKsKt3wpw2FAxRh2hof3hlH02YHqjmbddC7Dyabg
 pcdXjj3JXSBDWdZKgfKw+ezRoBAgThqJiZbmhiCbqnzKgtyAlRjO6sNTxPWn0SibBV1w
 UuBrR0PfCb3hNoW6HaxvSlx/jnQK2viE/OxkxJIZISH6XIVVYFWkuIBEnguqXYnt1aR/
 z4IohoQWoCRss6YrNqP4/gyC0oJLzc9QY5DZzbyERc7FoOsHcWdvNG43PiUlP+Ii32Mh
 2iTKRjksC+Ce50MCp16PrwSOkYkSewgBvlNVGXsFMslnrPVz1DAqj2GY0DmafLM0kYtQ
 qPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777819287; x=1778424087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7WOcIr+/gJWc/WRnMK7An29JDOsKuF4u/LgcR5DP+Vo=;
 b=jJunEEJ5kT2mYgnLtkiuyU2Yd77Oo2SCd6ioak5w6WXuZENK8zkubXI4NJqa5GDD4h
 k6+bVHGGdWouecfN2YH2JaqjEbT/Dny/DWf1lgodJhUKxboZcSs3KsMSLrVwyfd2Ll/B
 iAwTN/WHfuaUbFAqC8q1oeOqQdMwbWlnPpRvEB65vcNz1ZFIVBQwEXAEmSRTAo4UtafN
 yZ2W4MvPtHxXLgHsanGDhAbjEFLN7QSEZTD9iQ/guOgaQIngvgjZx5DskxMN89GX9rWu
 EJCWQWPbFfJMi4UZc5YluYCRy0ck/EDvKR6I60GIxkiiCFuUcxNXqIKkYC0D6Dpyqx3d
 3LaQ==
X-Gm-Message-State: AOJu0YxVAtPxv29Y9OZYVoL5psoSseSIympRPp0+rdTjmk0uOBpJIuMR
 pARnJu6+NsDLySWmH4HTvN/SHASqflEEDMS2rYChk2MZ8djbz8mRqUI78JvcgmTVVcIZ58vnrgJ
 iUZHaAOBxa03ksAdlSM/FXqT1DP3NrYW9GGSzTyypdg==
X-Gm-Gg: AeBDieubjvG53513GT9EbrqfY2/Ry5MzwU2oOpDe/YkE8NwZJLFiWtOCSHsIgCV7BRJ
 fI9oAJbaRPlyp9jup6SP23sn3KSZl10fd9UjIwTehYFrvCvHzm6NwqtYSCSjofkR8CpzLN/lQay
 dBmYsn8CLVOBdGgV/4jORq0QUVuK6q40SNwcbHWgnSGJfai9asEmEFSleGvTpjtdC0GxLTcKC1u
 hu3HPZhYfYNakMb7rgZgWunf/403IX2klehaefiuuSipPBTDzTHYbaiSyBhrPEi4Z8kBUTnR+3P
 RakHPYLxr6JJ2jgdsk4bvjhGtY+cBcpF6CykTkIU8IjysxGHTcqWujtay3tbAZD59zovd93mOrW
 1/w==
X-Received: by 2002:a05:690e:4349:b0:650:379f:3580 with SMTP id
 956f58d0204a3-65c3da72fdbmr5376418d50.21.1777819286684; Sun, 03 May 2026
 07:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250802110549.23438-1-pali@kernel.org>
 <20250810130948.3yzymcxtkmfkgk67@pali>
 <20251109134141.ur2s3bk5e6dgquxv@pali>
 <CAFEAcA8+cycE_JvFDEtAmbJtXwRVwU026rOBYNV+cZaq5wZ+XQ@mail.gmail.com>
 <20260418012012.by2qdlkbryjf2ugv@pali>
 <CAFEAcA8VcTN1ANX0EpCqCiyBVDckCp-D99TxabAghxtLdnMkgA@mail.gmail.com>
 <20260502154649.yuf7j7224duwveje@pali>
In-Reply-To: <20260502154649.yuf7j7224duwveje@pali>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 May 2026 15:41:15 +0100
X-Gm-Features: AVHnY4KzmRTp6jr-93Vn4VkjGUaBL__e829pCBGaN2DOlrMte-GvGm1-aWDzCYg
Message-ID: <CAFEAcA8KJ91_KyN6x9qhkdHPmHgEkLAxfqB5=c4c-Ts_y7gWnw@mail.gmail.com>
Subject: Re: [PATCH] qemu-options: Improve description for -smb option
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Jason Wang <jasowang@redhat.com>, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 2 May 2026 at 16:46, Pali Roh=C3=A1r <pali@kernel.org> wrote:

> I have one just question regarding the (English) wording:
>
> "... to tell it not to send QEMU NBNS query packets that QEMU does not ha=
ndle"
>
> Should not be there word "send to" QEMU? Packet is "NBNS query", it is
> not "QEMU NBNS packet", packet comes from Windows and is sent to QEMU.
>
> E.g.:
> "... to tell it not to send NBNS query packets to QEMU that QEMU does not=
 handle"
> or just:
> "... to tell it not to send NBNS query packets that QEMU does not handle"
>
> Sorry if this is a stupid English question, I'm not native English
> speaker and sometimes I write or understand English words in wrong order.

No worries. It works both ways in English: you can say "I sent my
friend a letter" or "I sent a letter to my friend", and they
mean the same thing.

But I think I prefer "not to send NBNS query packets that QEMU does
not handle" because it avoids awkwardly repeating "QEMU" and also
it avoids the potential ambiguity in "QEMU NBNS query packets".
So since I need to reroll this pull request anyway I've updated
the phrasing.

thanks
-- PMM

