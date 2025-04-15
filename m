Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E104C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 10:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4dmd-0005Xy-Rg; Tue, 15 Apr 2025 06:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u4dmS-0005Ws-7p
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u4dmM-0003Op-B7
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744713869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=goo5vWCSpOpjb64ZVAcFTM1Mdn8YiKnVyqoz1ENmxZs=;
 b=dnUHucCGUhIQa1uFLhimaLLTGYQYxHkbtbpi9S/R0R8qmjw9pAniixa15I+KzVHYQrllpl
 B7LYOn5G65ZgeduMPV0El3fVz2snDI6Csa0ibLIF+EkEjY/BxoT9eqfvGCkclLQrMrXnXy
 qSuPhVQW5PGxAsdDffoLqiwONiPAkUc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-AKUJXTsXOpW6w40Dspd4rw-1; Tue, 15 Apr 2025 06:44:28 -0400
X-MC-Unique: AKUJXTsXOpW6w40Dspd4rw-1
X-Mimecast-MFC-AGG-ID: AKUJXTsXOpW6w40Dspd4rw_1744713867
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913aea90b4so2301738f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 03:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744713867; x=1745318667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=goo5vWCSpOpjb64ZVAcFTM1Mdn8YiKnVyqoz1ENmxZs=;
 b=j9D4ESYn7QQAxcYQ2YFoV48q/vCukaeTZuHDOJ0eRw65tKhCpK+RXSDyGtURsz0qBC
 mg2HVnp258N3Gb7+3QVJVa2SxCmoQWk9gkCGn3ERV5z6wlnSJz0WOGtuNOBSqzmgPaOC
 KhlwiDQ1rQDoPqNLok4L5lwUlh/gRjs6Y9I2lLhnRYCO2XAAJtrsjdww1K1gMxZF0tqE
 SANuqf5DkCrvlRHNGBgeoF717RdEdzCQ0FAlypkN/+sNAJiE2KVP6R8w/HkXS6E75EQ5
 PdehhZr3XOkvrL/s951oLqtpzymEU2cTEQioGaN7YQeMhZHrryegAYXfBPn3D+ONCBMB
 VfEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWIxIF9dYCMVQr91eF9EqcaZilVdgblkgVCz+6HUvCVnuBU4EvosmnF6FLpn0YMJre2Wk/BrOzRaJa@nongnu.org
X-Gm-Message-State: AOJu0Yy9YAgfTH4nsU0vGzPMNz1EWFlBY+CKDT5jI0Sm9AhskEPiAD3L
 AV9hmQZm3J64qsJgx/zZ+SioxmoWIsum0D/w2Qbfc9E8yLSD0kZ4sGFSdfx5luMuptXa2JZ5ZOj
 rOAUxpgMFgeMDdO3X65EobKOCCJVvqWtG8UzCB9vdTHvQA11sMkxdLI7PUALeLscOPfi5vqQP39
 KMy4sO9SxlBK0n85+q7v+Jb4dQE8E=
X-Gm-Gg: ASbGnctlKrYOoKjdhQnl0Psx0gNdrzZz2ADs6g4IaXi4DYCVqBD1naafzkHe4kuht29
 J/aH8WDnMG5K0gT9oe3WsJWbyVXTKE/llWtw/syAEEQwat1XOuixZCoIESnUsUdRZcZ+6hlo=
X-Received: by 2002:a05:6000:220c:b0:39c:3107:c503 with SMTP id
 ffacd0b85a97d-39ea5212945mr12385073f8f.31.1744713867037; 
 Tue, 15 Apr 2025 03:44:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiC7DV87IBwXXUu/NWbo4fZt5hD2l0REoTvFEdwfjHWrjjpryVbY7uWj2B3/jugFqpWcgWw35+TtMwAkIinBw=
X-Received: by 2002:a05:6000:220c:b0:39c:3107:c503 with SMTP id
 ffacd0b85a97d-39ea5212945mr12385047f8f.31.1744713866685; Tue, 15 Apr 2025
 03:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
 <Z_4zL4y0UbmLJTsP@redhat.com>
In-Reply-To: <Z_4zL4y0UbmLJTsP@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 15 Apr 2025 16:14:08 +0530
X-Gm-Features: ATxdqUG34JG-rlJWyDRDlcjFmZR65V1OMvREfspQ9o7nSwD1u7uQH9z9yypKMWE
Message-ID: <CAE8KmOz-yGRXo2RiPpnhtcg2K+j38sK6C1eGHvpQf0L_Hfe3vw@mail.gmail.com>
Subject: Re: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Marco Cavenati <Marco.Cavenati@eurecom.fr>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi,

On Tue, 15 Apr 2025 at 15:51, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> It is actually NOT really connected to lseek, and as such

* For file and fd channels _FEATURE_SEEKABLE is set  when/if  lseek(2) work=
s.
    -> https://gitlab.com/qemu-project/qemu/-/commit/401e311ff72e0a62c834bf=
e466de68a82cfd90cb

> QIO_CHANNEL_FEATURE_SEEKABLE is probably a bad choice of name
> in retrospect.

* That's plausible. Because while reading code,  _SEEKABLE indicates
(or hints) that the underlying stream allows random access at a given
offset. Even pread(2)/pwrite(2) manuals say that -> file referenced by
fd should be capable of seeking. So correlation is that, since
QIO_CHANNEL is an abstraction layer, it supports different
streams/channels underneath, maybe some of those underneath streams
support seeking (random access) and some don't. Hence we set
_FEATURE_SEEKABLE when the underlying channel/stream supports it.

> In QIOChanel API specification, having QIO_CHANNEL_FEATURE_SEEKABLE
> set is a pre-requisite for use of qio_channel_{pread,preadv,pwrite,pwrite=
v}.

* If *_FEATURE_SEEKABLE is not connected to lseek(2) or seeking, what
is its right interpretation? Why is it a pre-requisite for use of
qio_channel_{pread,preadv,pwrite,pwritev} functions?

Thank you.
---
  - Prasad


