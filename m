Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BD3CA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 14:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuXJp-0007XK-Eb; Fri, 05 Sep 2025 10:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuXJn-0007WR-3e
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 10:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuXJc-0008FI-3T
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 10:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757082082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eUnAleF54zHWLtK6x5C95lNix9wdJClggXJb7jgC2Dc=;
 b=QHXUqvxcU8Em9B3L0FvDmG2gintALc51RuBFvPheM0OJ6pgRDusIeRS+3Y3zhDma5cz2mH
 WPchTdymD6b4v1amf88Pqtfsd7Q/mBG1kquGuj5AG25WoGU2is1AbjTGF2EqbGkfg8Rvlb
 Q1TkhI+myjXtSPqUhW6ltvnak67b0V8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-QnwSxdfiM2S47VFFMM1W1w-1; Fri, 05 Sep 2025 10:21:19 -0400
X-MC-Unique: QnwSxdfiM2S47VFFMM1W1w-1
X-Mimecast-MFC-AGG-ID: QnwSxdfiM2S47VFFMM1W1w_1757082078
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b345aff439so56547571cf.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 07:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757082078; x=1757686878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUnAleF54zHWLtK6x5C95lNix9wdJClggXJb7jgC2Dc=;
 b=FMUokYkgLAn67Z+QNVMx2YH9HDQ406HS7sogGHl8VDWTRoT757M4itSu3Fpw5dFiAL
 +6EhIDh74XcwkPSH/b187/lY6k5vHqhBB4AnHWxmfdASJsea+moH0GXu/W/FzxySHfRC
 pQRj0Ss6rovo9/Ef9N/yT0Gul5iYc7GMjgyQcKpe6WwOGrm/KNHRUfnt8Mg0LrsP7zJH
 tH98DHftmpKOkfyWicRyrszOtWi4xjt7EgupyKfsrJj0BG9pujxuM9OUOZN/2JbasGmK
 FzjH4XKMiS+dxNig4MKX28nUxFhsi2TSWMwxm41bI5PZdlPdiPXSxgOCXqSMAbehxo42
 i0Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXyqZ4eJi5AvDQX81Fgzb8s5jcOMp+we9XsE2UZau5RKgLHp9fj0xNZR59qja550FOZ7njgTBzyzT+@nongnu.org
X-Gm-Message-State: AOJu0YykqT3srvc1vjZZHGzyC2lLf37JU7SlpyJd3iK+Vo0PsJtWgoU+
 029A11TeCl3zlYQQEAyVNdb8ahINxxDXB1NqQnogNUZiWgImP03Io8gllThRSqJM455dK3nsI+I
 Dl94qIlNN3JEwEExbvJ7xoHDz6YDS8taIvSJj+LfIcDVpMPRcaD95/obX
X-Gm-Gg: ASbGncvqCUeM/bEt6yQmiH6fvB3B5Rp5NqwJE54PSWCgRPm3GzB73ZW68xEm9fdUqUl
 6eAIEHl2Ji8y28Gxk7hPE5W22jK5P+X7EQpeP3i5Kp3XP2/aeZnVJgVbcVna6bVlsVr9X5BiRZB
 m2vhMoIxvx0CnTiFkx44LJ9deZmlEcqE1JxhNhRx0ID2A3Tgp3HRVg876V123B/nhLEwN/J8wM9
 7ETa8frG5Zsbe/Xhcu+PHnItG76R0DwFH4cngk6jwSkaZDa5H6sv3MSLsBn8Hi0EPVd1RuLIk1M
 SXUts4MhZlMFUKttFmUgkWU6fNEJYWr2
X-Received: by 2002:a05:622a:47c4:b0:4b3:4c51:643e with SMTP id
 d75a77b69052e-4b34c516d88mr151826961cf.68.1757082078248; 
 Fri, 05 Sep 2025 07:21:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEapsx7hdiwyAtz86wiBs5ovYT7iicwjCRqOzxZu4Gh3/sDmYc1nsrF6JpCKn3Fs+++gIlX/Q==
X-Received: by 2002:a05:622a:47c4:b0:4b3:4c51:643e with SMTP id
 d75a77b69052e-4b34c516d88mr151826171cf.68.1757082077635; 
 Fri, 05 Sep 2025 07:21:17 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f780b9fsm45731361cf.41.2025.09.05.07.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 07:21:16 -0700 (PDT)
Date: Fri, 5 Sep 2025 10:21:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: CJ Chen <cjchen@igel.co.jp>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>
Subject: Re: [PATCH RFC v2 9/9] tests/qtest: add test for memory region access
Message-ID: <aLrxz-ULSP3rrm8p@x1.local>
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <20250822092410.25833-10-cjchen@igel.co.jp>
 <CAFEAcA-r5DdZj-+BxBkN+XqWJ3QrN6g+RshjShVoD-Zf1weYPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-r5DdZj-+BxBkN+XqWJ3QrN6g+RshjShVoD-Zf1weYPg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 01, 2025 at 05:57:57PM +0100, Peter Maydell wrote:
> On Fri, 22 Aug 2025 at 10:26, CJ Chen <cjchen@igel.co.jp> wrote:
> >
> > From: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> >
> > This commit adds a qtest for accessing various memory regions. The
> > qtest checks the correctness of handling the access to memory regions
> > by using 'memaccess-testdev'.
> >
> > Signed-off-by: CJ Chen <cjchen@igel.co.jp>
> > Co-developed-by: CJ Chen <cjchen@igel.co.jp>
> > Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> > ---
> >  tests/qtest/memaccess-test.c | 597 +++++++++++++++++++++++++++++++++++
> >  tests/qtest/meson.build      |   9 +
> >  2 files changed, 606 insertions(+)
> >  create mode 100644 tests/qtest/memaccess-test.c
> 
> There seems to be a lot of duplication in these test functions
> (for instance, aren't all of little_b_valid(), little_b_invalid(),
> big_b_valid() and big_b_invalid() identical?  and the various
> _invalid functions seem to have if() blocks where the code in
> the if and the else halves is the same).

Besides that, I don't yet understand some of the test code on endianess,
this might be relevant to the question I raised in the other reply.

Taking example of big_w_valid() test:

static void big_w_valid(QTestState *qts, hwaddr offset)
{
    if (qtest_big_endian(qts)) {
        qtest_writew(qts, base + offset + 0, 0x1100);                     <--- [1]
        qtest_writew(qts, base + offset + 1, 0x3322);                     <--- [2]
        qtest_writew(qts, base + offset + 2, 0x5544);
        qtest_writew(qts, base + offset + 3, 0x7766);
        qtest_writew(qts, base + offset + 4, 0x9988);
        qtest_writew(qts, base + offset + 5, 0xbbaa);
        qtest_writew(qts, base + offset + 6, 0xddcc);
        qtest_writew(qts, base + offset + 7, 0xffee);
        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x1133); <--- [3]
        g_assert_cmphex(qtest_readw(qts, base + offset + 1), ==, 0x3355);
        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x5577);
        g_assert_cmphex(qtest_readw(qts, base + offset + 3), ==, 0x7799);
        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0x99bb);
        g_assert_cmphex(qtest_readw(qts, base + offset + 5), ==, 0xbbdd);
        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0xddff);
        g_assert_cmphex(qtest_readw(qts, base + offset + 7), ==, 0xffee);
    } else {
        qtest_writew(qts, base + offset + 0, 0x1100);                     <--- [4]
        qtest_writew(qts, base + offset + 1, 0x3322);                     <--- [5]
        qtest_writew(qts, base + offset + 2, 0x5544);
        qtest_writew(qts, base + offset + 3, 0x7766);
        qtest_writew(qts, base + offset + 4, 0x9988);
        qtest_writew(qts, base + offset + 5, 0xbbaa);
        qtest_writew(qts, base + offset + 6, 0xddcc);
        qtest_writew(qts, base + offset + 7, 0xffee);
        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x2200); <--- [6]
        g_assert_cmphex(qtest_readw(qts, base + offset + 1), ==, 0x4422);
        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x6644);
        g_assert_cmphex(qtest_readw(qts, base + offset + 3), ==, 0x8866);
        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0xaa88);
        g_assert_cmphex(qtest_readw(qts, base + offset + 5), ==, 0xccaa);
        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0xeecc);
        g_assert_cmphex(qtest_readw(qts, base + offset + 7), ==, 0xffee);
    }
}

It tests on all MRs that are (1) device using big endianess, (2)
.valid.min_access_size=2, (3) .valid.unaligned=true.

First of all, I don't understand why a test case needs to behave
differently according to the TARGET endianess, aka, qtest_big_endian().
IIUC, each of the qtest_writew() should request a WRITE with an integer
value to be applied to the MMIO region, when we know the endianess of the
region (in this case, big endian), we know exactly how it will be read out.

Taking above steps [1-3] as example.  Here [1+2] will write two words to
offset 0x0, 0x1 correspondingly:

  - [1] WRITE(addr=0x0, size=2, data=0x1100)
  - [2] WRITE(addr=0x1, size=2, data=0x3322)

Here, IMHO the result should not depend on the internal property of the
systems (e.g. MR .impl values, after we have unaligned support memory core
should resolve all of these issues by either split 2B MMIO into two 1B, or
do proper padding on start/end to amplify the write if necessary).  Because
we know the device / MR is big endianess, so we should know the result of
the write already, as below:

  - After [1] WRITE(addr=0x0, size=2, data=0x1100), data should look like:

    [0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, ...]
     ^^^^^^^^^^^
    Here it should always follow device's endianess.

  - After [2] WRITE(addr=0x1, size=2, data=0x3322), data should look like:

    [0x11, 0x33, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, ...]
           ^^^^^^^^^^^
    Here it should always follow device's endianess.

Above would be verified by step [3].  Basically it verifies READ(addr=0x0,
size=2) would result in 0x1133, which looks correct.

However the problem is, when GUEST is little endian, the test, even if
written the same data [4-5], expecting different results [6].  That's the
part I don't understand.  I think it would make sense if [6] should also
verify the same as [3].  IOW, the chunk in the "if" section looks like the
right thing to test for both big/little GUEST endianess.

-- 
Peter Xu


