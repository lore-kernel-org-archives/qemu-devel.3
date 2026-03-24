Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C494F54AB0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w51nc-0004in-OU; Tue, 24 Mar 2026 09:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w51nA-0004WL-R2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:27:37 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w51n9-0001n1-8s
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:27:32 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7991db3dc98so17161007b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 06:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358850; cv=none;
 d=google.com; s=arc-20240605;
 b=dw4l8GaJBtQSS7oJysG93vypBMV7gcSUhunYODAmv7Su77EXkiLNhBNBRXuK9mJ9zn
 4HaU45Oe/o9yjLQzMdKIm6Np+aJAQpHvtnKWdPPr4jEP1swUrC/BA6WvgaKZAPrWT5zr
 aeVjUMuEONsxui5zEBFNtNEQn3c+SPP8PtjaeyGEXoQVH/1W+htnBxckXeMPpn8hjjSm
 B7uxH200wCJ6XsJxOPFO99KVUDGvhwTd6j5lj3fqzef2vtILTrX7gVfMuCcPBEq6Jk3n
 pWlLOMREN1RKf+DJsdQss4IWuSmqIT2yp1AjRfdwOjI6ExubJmWXUJVWfcqveoBtG8lD
 o9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pShKPloXeI1j6Yuqjx5wCMt8kQeJ6OpbT0kvU5q04MA=;
 fh=LX1KwUwY5Xjw2X9OctU0W2RwPLVzRWHm1DGhXLTLaBw=;
 b=b65fejAPvuIHww/g2opzTn3U8qsykluTuQhRzguTI0aX75Pl1d1IEquWP+Si9JnGIL
 AKG5Hv7qouSHzKNZfP11cF9R6Ra4jegMO9guKlDnhJKRNvIpni1SN9Ci0seYIfULhG9r
 rTl0mDYMy+z0WJJNi+rrxDQqcbsYuiusY2GvJY+LMK2qNaHK6ICdHIrEX7cft6m/2ufs
 IuKpaMWi6lpB8x05Ri+JfBWyhQpmruDSMGHDQ65XKeHVmKDkd78qX8czoTY3ZRbSkJ4z
 0wIlySa0bu43ldULeupfs2DI/1WoYLt5hmttqfg+Qd7fzgkPkUvCFggeU+hD1FF7pB/9
 jkqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774358850; x=1774963650; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pShKPloXeI1j6Yuqjx5wCMt8kQeJ6OpbT0kvU5q04MA=;
 b=EJxqxeCbP1Wx0/wfSyXKNKhI7dZx5x4WigllItzvAgaLN6HA3Gaz3nEO7K8UsehiyP
 PoHG+pn6S1vhZ+So7uMrCiMJtkYkkAr+RtAupD2UEDFyR6ooBAP78eE4pdNw97iVWk53
 vnfKb64bVG/expsxFIonlbi4lcYyJ8BwZl/YkKaGkuIgpBdKaIKlEnJRpl5n4hxRJfk7
 DNHMeVGlfR4cMPaEQfAL43TFntrTxE3JRn+yMANCmnJxGU6bhrMMIp3hkUJT7TXs7wD/
 BuQU4EByz0nLKie+a9VB4f0qBJPwtLlOCXj0yUbPcjAqcenM/LBzl2qi6khGoONkjGQY
 HKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774358850; x=1774963650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pShKPloXeI1j6Yuqjx5wCMt8kQeJ6OpbT0kvU5q04MA=;
 b=KbxsM5y3PYOj0dkj+zmisbkrpD/cLtbIB6GpXQTIX8QffDgboK91JWfBrqPSZJ31Nv
 OwRtNNQnUOIsRUOhQJeXraWy3SY8bpdxLbjEJF2+EYfkYOHThPa4YBVC6QWFeed6HBH0
 CVnv0IkW/2ovDufJ/R67l+5Sk2M4gAYBJnsNYgxV0etvi+2hwqNDGTM1B/4pVcf7fLiU
 jcQAEmyqQFioRvbA6W4IIOLNc2OJaK03SKNsSn9qOfpy//12XY2I1Q805jWT7AFzIMi5
 kGoUBftoKMNQK544X1UdfFgQYvmUJta8eJnbQBuiTsMQuJo+Y5k5qm+fP4Jh6T1AHkhW
 ZL7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4+THhELPLSFxSerfZFTjbCrKfETV/4PhTEdfsznkv4izlMPAG6OpVzDGG4JrijdxQD8DjR/wtprXZ@nongnu.org
X-Gm-Message-State: AOJu0YzzuxIHRbEw0mT5skK61zGJHhJf7kQmMqVRsB9UMoX/eDldRrtf
 JFsid/DDJkKfn2ri/uF/dMR9OZTgQiTCxPHkvLwudth3W/TCqyV/JaYANPKnQdLJG4t2RhDNdqH
 1A7aj2ZQ92JnNh1q12UuMwSkNjz2Bm2+T4JAcIhI+Ng==
X-Gm-Gg: ATEYQzxo0CADNkP2E7rRXTLAowAwRU7mAU+IrnJ20ZfTdr2wg4DnTEmMffhSmgarojg
 tcTSQ6g8Db5enCY9UXe9faQjIp6iHLYb2zT0zNfKwVsOEiRiM0KgKou+CFFhBGhfUvsc5VzhL1Z
 eYDvZhoFvj7KQL5ueVjf4olZWn5GYOFwhz+zMBf2LTo/IRyVA8XVENjLQn6XYV9e1KWVnnCntks
 bHqBK3fg9GOx6bdzu+2mvGhWP90WsVy+/3MZSL9dP14zXW6krEr+3rmehnI474N3D/yzhgKjjLs
 UyGRWCSaQ+/N/IxmWgVhW/mdN3fIup+v2Wsg7X9XCHLUbDDK6+8jNGClwfy4vlF2pj8=
X-Received: by 2002:a05:690c:6d81:b0:794:6fa2:a037 with SMTP id
 00721157ae682-79a90a92a96mr154756537b3.8.1774358850037; Tue, 24 Mar 2026
 06:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260320155107.2143191-1-alex.bennee@linaro.org>
 <20260320155107.2143191-3-alex.bennee@linaro.org>
 <f2f9f07a-4c92-4856-bcf6-7d2e0a5d43f1@tls.msk.ru>
In-Reply-To: <f2f9f07a-4c92-4856-bcf6-7d2e0a5d43f1@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 13:27:18 +0000
X-Gm-Features: AaiRm52qkSfz_yGX0h-JnxaoVcChCgyRd0c-gfZ4Fll-MYuDUSyigqZywfzhuRQ
Message-ID: <CAFEAcA--8-mRVdvgOzX+WEg3gXOH8Om3L8cebDRSP31G8-T=yQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] tests/tcg/multiarch/linux-test: use portable
 alternative for dirent64
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Brad Smith <brad@comstyle.com>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Tue, 24 Mar 2026 at 13:15, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 20.03.2026 18:51, Alex Benn=C3=A9e wrote:
> > From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> >
> > dirent64 and readdir64 are glibc-specific and not portable to other
> > C libraries such as musl. Define _FILE_OFFSET_BITS=3D64 instead, which
> > portably instructs all libc implementations to use 64-bit file offsets,
> > making readdir() and struct dirent equivalent to their 64-bit variants.
>
>
> > --- a/tests/tcg/multiarch/linux/linux-test.c
> > +++ b/tests/tcg/multiarch/linux/linux-test.c
> > @@ -16,6 +16,7 @@
> >    *  You should have received a copy of the GNU General Public License
> >    *  along with this program; if not, see <http://www.gnu.org/licenses=
/>.
> >    */
> > +#define _FILE_OFFSET_BITS 64
>
> Afiacs, qemu has always been built with file_offset_bits=3D64, one way
> or another:
>
> meson.build:
>    '-D_GNU_SOURCE', '-D_FILE_OFFSET_BITS=3D64', '-D_LARGEFILE_SOURCE',

Those control the compiler flags for QEMU itself. This is
a standalone test program built for the guest, and it isn't
built directly by meson.

> Now, with only 64bit host support, defining _FILE_OFFSET_BITS to 64
> makes no difference, since it is already 64 by default.

We still support 32-bit guests, though, and this is being built
for the guest architecture.

thanks
-- PMM

