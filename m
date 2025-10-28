Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A3DCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjx1-0002y9-B7; Tue, 28 Oct 2025 09:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDjwy-0002wT-HU
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:41:25 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDjwq-0005EZ-Fa
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:41:23 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7847f4265e3so62958827b3.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761658872; x=1762263672; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gE3QvbRywZ8J/ACR7I8MQ4JSg6nMvjBekUNtG7xeyxQ=;
 b=QvoG4M5fveSu1kiJaaKG5mkSvwO3u4MEad9LgqOoVuYYvGwdyZimYZMdBvfQhN5nma
 +1Jpy9Hj5qKRfa7yObp1rhop4Zp/AM5tYBJAnnTlW6N+5ELVTP1LY8UTCPR1xKHYCA8F
 ifXbK58B7gP9gHKMaqq87QwkX8JGceZnLWrTZESEZ2vg4QVmoR57zKd7eEeYsjjDWkll
 nLFN/OJplIIJg32MCDb8TfcCse/kLZG3FobPtQsh4BbKTrG1kxqzzRSzwulDIZ1FfEqL
 e4+dzReYJgstfZH6cmN3ZLb/rHKE30kQXQ6feGhgDrvOWXDbCCHJLn6Mack80joUdfMo
 Zz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761658872; x=1762263672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gE3QvbRywZ8J/ACR7I8MQ4JSg6nMvjBekUNtG7xeyxQ=;
 b=SAXVQcyuF+CCZ8BmQ++cbUjl5DTd00PWqa5HmZ/6SGD6I3CfI9CmySSa5BsT4m2xku
 pe0CQcUAHe7fDdQYCtu3TbDBEmd81teR/cF+Nn0gFJw1LGBJHolDxKC5Rs28+Awc39tx
 0PkknX3u30RocLbi1KYBF6oqGAafdfW+gv9bYPiESl0h95gdBKc4Zcme6XAKfY6AMLVd
 BubYruZQeXgVGTfveiHpZWyWJtCLaiynjSqhB1uhjW13DoWwEpx03X7r3+rzTMB6jmMv
 neCtOe83XyM8y8eyuXPKugHBSXREKgkpJLMnnghcCDVLaTaCeputbuiSlB2rqfaoVpiP
 xVqQ==
X-Gm-Message-State: AOJu0Yz7/UDE9UThVKFzm5YXfcn3iIXBHFWH5CV4ABvc2YRbPsTYkfvN
 TfJ4tA8Ye63BVDBi1U7xn8LwGZ3Zx1V3o2tixhQ7RqqjiFbacKE7O5qmeZWP9ZZlfa+MK14FTeZ
 kel/7kg5tefQFayzy78OZ0OsK92RAXHGf8pTjKv1GTw==
X-Gm-Gg: ASbGncss49lEDzf2SzzwKxEQrZFw4Kq0lRBqMgUduaXGCkM84lig0bZAgLPqqhJs9E6
 Yl8BYhk6C/ERgjalO5mlQl47T82v0qhfH/wn/hl1hNjFU/9h20XCrOA5XvpHDF1nBCk9NDUedm7
 lGPgxZYbjw4rBLUvYZynKr2KitkvBM0Yf4KtwBlpd27erF9UY3D1qVoGGpC5mEeF1OugNBnLQ4L
 lz7z/6KbacjAK0UeQ0jswVidvOCSAeAVKKImEiLX4vUTubPN1yYCLl6thTNIA==
X-Google-Smtp-Source: AGHT+IHLMxmbr3XOhUWOlIAyfMNT/LbAguJnCqhXnqYiy2ZaA5gEXiFDkwd8DIYMcaDvDt46V9H+wgA+xb8XTUY0Z28=
X-Received: by 2002:a05:690c:30b:b0:781:64f:2b3a with SMTP id
 00721157ae682-78618002621mr28563777b3.60.1761658871804; Tue, 28 Oct 2025
 06:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1747223385.git.mst@redhat.com>
 <40ab4ed107757e1c5bdccc906e8a44cb4e2cb7a4.1747223385.git.mst@redhat.com>
 <CAFEAcA8Rqop+ju0fuxN+0T57NBG+bep80z45f6pY0ci2fz_G3A@mail.gmail.com>
In-Reply-To: <CAFEAcA8Rqop+ju0fuxN+0T57NBG+bep80z45f6pY0ci2fz_G3A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 13:41:00 +0000
X-Gm-Features: AWmQ_bneC3e-ffmK--iUqa7hA3QAaHDd5M_U6HWAyi0ZujJX59gpo4AI5Iso9uY
Message-ID: <CAFEAcA99KqkF+T-vBo2yihaTy5GhUmPoNFkii_cDM0+WX-5Epg@mail.gmail.com>
Subject: Re: [PULL 05/27] hw/cxl/cxl-mailbox-utils: Media operations Sanitize
 and Write Zeros commands CXL r3.2(8.2.10.9.5.3)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Vinayak Holikatti <vinayak.kh@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Ping -- these issues in this change seem to still be
present in the current version. Would somebody like to have
a look at them ?

On Thu, 10 Jul 2025 at 14:23, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 14 May 2025 at 12:50, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Vinayak Holikatti <vinayak.kh@samsung.com>
> >
> > CXL spec 3.2 section 8.2.10.9.5.3 describes media operations commands.
> > CXL devices supports media operations Sanitize and Write zero command.
> >
> > Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Message-Id: <20250305092501.191929-6-Jonathan.Cameron@huawei.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
>
> > +static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
> > +                             size_t length)
> > +{
> > +    uint64_t vmr_size, pmr_size, dc_size;
> > +
> > +    if ((dpa_addr % CXL_CACHE_LINE_SIZE) ||
> > +        (length % CXL_CACHE_LINE_SIZE)  ||
> > +        (length <= 0)) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    vmr_size = get_vmr_size(ct3d, NULL);
> > +    pmr_size = get_pmr_size(ct3d, NULL);
> > +    dc_size = get_dc_size(ct3d, NULL);
> > +
> > +    if (dpa_addr + length > vmr_size + pmr_size + dc_size) {
>
> Hi; Coverity flagged up a potential issue in this function (CID 1610093)
> Partly it is a false positive (it thinks vmr_size etc can
> be -1, but they won't I assume ever be memory regions of that
> size), but it did make me notice that this address/length
> check looks wrong. If the guest can pass us a (dpa_addr, length)
> combination that overflows a 64-bit integer then we can
> incorrectly pass this length test.
>
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (dpa_addr > vmr_size + pmr_size) {
> > +        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
> > +            return -ENODEV;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
>
>
>
> > +static CXLRetCode media_operations_sanitize(CXLType3Dev *ct3d,
> > +                                            uint8_t *payload_in,
> > +                                            size_t len_in,
> > +                                            uint8_t *payload_out,
> > +                                            size_t *len_out,
> > +                                            uint8_t fill_value,
> > +                                            CXLCCI *cci)
> > +{
> > +    struct media_operations_sanitize {
> > +        uint8_t media_operation_class;
> > +        uint8_t media_operation_subclass;
> > +        uint8_t rsvd[2];
> > +        uint32_t dpa_range_count;
> > +        struct dpa_range_list_entry dpa_range_list[];
> > +    } QEMU_PACKED *media_op_in_sanitize_pl = (void *)payload_in;
> > +    uint32_t dpa_range_count = media_op_in_sanitize_pl->dpa_range_count;
>
> This looks dubious -- a packed struct presumably from the
> guest, with a 32-bit value, that we are reading without
> doing any handling of host endianness ?
>
> thanks
> -- PMM

