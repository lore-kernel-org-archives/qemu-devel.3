Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5EAC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubNM0-0004tN-5J; Mon, 14 Jul 2025 13:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ubMJB-0006mB-SX
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:45:42 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ubMJ9-0007oL-Ko
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:45:41 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7481600130eso5176314b3a.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752511535; x=1753116335; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ncCyV0aoZ/6qo09uLJz5eMmCg2hr2we7Tu7Iid9x4is=;
 b=C7+K9B71ZCfi3wzidlz3RvkVUH6G3m+hWbAdHiFLhtkDDyYAKFBdEcywfwr1pNbHBF
 WJryn+0Z2wBHlYHogBZrjKXH7sdr/H2mgZt1fJRn4p6O6b/reD8XxSxoQQn1JupaJm0Q
 LFOe6hAz7W4c8ZhdmZSy9XQga4bt9IJ85kSawj1Bh2MbJORb2TBc3zO7lR59d+lCmcIN
 iirrvqivfJKTdiU93RCVpP7zVzO6tUWSVr+BfOCJXi0E1dVzYqsb1KGO9AOnrytrD4fC
 0l6QIs1jaJ/WiXKsAKCQ7fqxkO8P5fKH8FEtFUJV7gy/x71xnB7Yii6fPnKvUg09zSgb
 gj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752511535; x=1753116335;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ncCyV0aoZ/6qo09uLJz5eMmCg2hr2we7Tu7Iid9x4is=;
 b=PAjRzmsS9RGUXolTJfDKp0ZJPyF5Ew4d43qkdCCkKmwywmg540zcFJCKqVfLOIz/xl
 XAj6NfQuyl3I9sO3nRbuoxhGyLwlc2v05tD+72LlbRAQgjjjwumTFEaJ9o3x8uZwmvaR
 7dYhixY+VXF/wq8cgLhX3Zc62GtBu+s654pDQZW3HuVh7Jq/qZiC+/JKyjxTs3ej8ceV
 8+Kxky3ciuefkI5Qks9fhjCIY17V9OxP12ScKfQ1CtnXJbh6u8uUAlD//BQg7ZbYsFVh
 TRVuuQ0ybqo2ZMe1RRCtRi8GC6UT3MCzq4tt1GClfPzWoCj5Kk234Z4YLFfAyOxHu2ew
 Io1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD/xQLzHgXPZl82X6/re0PTU2rH8AIoIpep76fnYLDC2Qei4SXMJw+jzw5oJxcVYAxITLNgrhL+bbZ@nongnu.org
X-Gm-Message-State: AOJu0YyqTHUJ+2anJJhjHsFqMpmBWDoYszRtXXQIw8IXbCSIU2E+0xqI
 MQUVhmqBcPWCbHHW/XgRVeBHrZNp1UDGGzdMh8YVY+oBM6rP5lh4WQav
X-Gm-Gg: ASbGnctErrMPHar2/7LWGmJ5WxtH6Rou5ENd++WALNp0I7K/qmcC7PKhqVX3RVKS3I3
 4TRkeeYbqlq48fDvgqeTSdioPIf+LSQmQtv8LDJ2OsVHLJ5tF2gYQ+zfiV0DsXVt8GUd3An6ioL
 GKKIeEdZW4u8xuoX2Jg/FoV+gReUvDrQKj8U3OkMOzt64Lq4PLe41tVS8hJfS5jDTXJEaj7vm4v
 VBhDmE+LYc1CrPOajXsoSJMNGHUgfE4f+BvJS7UUZl8c5gK8mKWEteAuQkNJkgNUo0v+HOJwXUk
 owPuSUQLNT8WSk73nIOS7P8qqc64Wjd3/TzBH5ENk7GUDzxvqeoM1YWcC1Un3+5PmSl4PF6lW9+
 FqP9duQDsMok3KPUx3//uMjQ=
X-Google-Smtp-Source: AGHT+IFJVe7YMzCa6bbCexww2jlzcc1c8cj0MKXOGeuxUdKTtEKzyTlxvUPzIaawdf+MnCiLeW3RYA==
X-Received: by 2002:a05:6a00:3d47:b0:746:24c9:c92e with SMTP id
 d2e1a72fcca58-74ee09ae484mr22673386b3a.8.1752511535251; 
 Mon, 14 Jul 2025 09:45:35 -0700 (PDT)
Received: from lg ([2600:1010:b0b9:68c0:c4fb:1c2c:4273:7950])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9dd5ccesm10752144b3a.27.2025.07.14.09.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 09:45:34 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 14 Jul 2025 09:45:31 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH qemu 07/11] hw/cxl: mailbox-utils: 0x5602 - FMAPI Set DC
 Region Config
Message-ID: <aHU0K4bXbPLsed5t@lg>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
 <20250702160219.989731-8-Jonathan.Cameron@huawei.com>
 <20250714052757-mutt-send-email-mst@kernel.org>
 <20250714150218.00006c95@huawei.com>
 <20250714151512.00000a2a@huawei.com>
 <20250714151638.000038ac@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714151638.000038ac@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Jul 14, 2025 at 03:16:38PM +0100, Jonathan Cameron wrote:
> On Mon, 14 Jul 2025 15:15:12 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Mon, 14 Jul 2025 15:02:18 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > 
> > > On Mon, 14 Jul 2025 05:32:19 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Wed, Jul 02, 2025 at 05:02:13PM +0100, Jonathan Cameron wrote:    
> > > > > From: Anisa Su <anisa.su@samsung.com>
> > > > > 
> > > > > FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3
> > > > > 
> > > > > Reviewed-by: Fan Ni <fan.ni@samsung.com>
> > > > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>    
> > > 
> > >   
> > > > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > > > index bf1710b251..1fc453f70d 100644
> > > > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > > > +++ b/hw/cxl/cxl-mailbox-utils.c    
> > >   
> > > > > +/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602) */
> > > > > +static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
> > > > > +                                              uint8_t *payload_in,
> > > > > +                                              size_t len_in,
> > > > > +                                              uint8_t *payload_out,
> > > > > +                                              size_t *len_out,
> > > > > +                                              CXLCCI *cci)
> > > > > +{
> > > > > +    struct {
> > > > > +        uint8_t reg_id;
> > > > > +        uint8_t rsvd[3];
> > > > > +        uint64_t block_sz;
> > > > > +        uint8_t flags;
> > > > > +        uint8_t rsvd2[3];
> > > > > +    } QEMU_PACKED *in = (void *)payload_in;
> > > > > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > > > > +    CXLEventDynamicCapacity dcEvent = {};
> > > > > +    CXLDCRegion *region = &ct3d->dc.regions[in->reg_id];
> > > > > +
> > > > > +    /*
> > > > > +     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
> > > > > +     * This command shall fail with Unsupported when the Sanitize on Release
> > > > > +     * field does not match the region’s configuration... and the device
> > > > > +     * does not support reconfiguration of the Sanitize on Release setting.
> > > > > +     *
> > > > > +     * Currently not reconfigurable, so always fail if sanitize bit (bit 0)
> > > > > +     * doesn't match.
> > > > > +     */
> > > > > +    if ((in->flags & 0x1) != (region->flags & 0x1)) {
> > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > +    }
> > > > > +
> > > > > +    if (in->reg_id >= DCD_MAX_NUM_REGION) {
> > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > +    }
> > > > > +
> > > > > +    /* Check that no extents are in the region being reconfigured */
> > > > > +    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_size)) {
> > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > +    }
> > > > > +
> > > > > +    /* Check that new block size is supported */
> > > > > +    if (!test_bit(BIT((int) log2(in->block_sz)),
> > > > > +                  &region->supported_blk_size_bitmask)) {
> > > > > +        return CXL_MBOX_INVALID_INPUT;
> > > > > +    }      
> > > > 
> > > > This does not work: test_bit works on unsigned long, while
> > > > supported_blk_size_bitmask is uint64_t.
> > > > 
> > > > Why so funky? what is wrong with:
> > > > 
> > > > if (!(BIT_ULL(log2(in->block_sz)) & region->supported_blk_size_bitmask))
> > > > 
> > > > And BTW why cast to int here?    
> > This became obvious when your suggestion didn't build :(
> > 
> > ./../hw/cxl/cxl-mailbox-utils.c: In function ‘cmd_fm_set_dc_region_config’:
> > /home/jic23/src/qemu/include/qemu/bitops.h:25:39: error: invalid operands to binary << (have ‘long long unsigned int’ and ‘double’)
> >    25 | #define BIT_ULL(nr)             (1ULL << (nr))
> >       |                                       ^~ ~~~~
> > ../../hw/cxl/cxl-mailbox-utils.c:3436:11: note: in expansion of macro ‘BIT_ULL’
> >  3436 |     if (!(BIT_ULL(log2(in->block_sz)) & region->supported_blk_size_bitmask)) {
> >       |           ^~~~~~~
> > 
> > Now I look again, this is effectively 2**(log_2(x)) or x. So
> > if (in->block_sz & region->supporte_blk_size_bitmask)
> 
> it (!(in->block_sz & region->supports_blk_size_bitmask))
> 
> I mean.

Make sense to me. 

The only thing is how to detect the violation if the passed in block_sz
is not power of 2.
Or who will do the check if not in qemu?

Fan

> 
> 
> > Should work as long as we know block_size is a power of 2 (which the specification
> > says it must be).
> > 
> > Anisa?
> > 
> > > 
> > > Change looks fine to me, so I'll prepare an updated set with this
> > > and the missing semi colon.  Anisa if you can have a look at this
> > > that would be great. 
> > > 
> > > Sorry I seem to have missed Anisa off the cc for this!
> > > 
> > > Jonathan
> > >   
> > 
> 

-- 
Fan Ni

