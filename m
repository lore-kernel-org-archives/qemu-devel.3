Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E42C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFSH-0003yJ-7R; Sat, 20 Jul 2024 15:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFSE-0003pN-Aa
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFSD-0008IS-02
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721502552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vUyBbKeQrZ+nfQvxj25plekZeCd0lrD4h7eC8vQTj+U=;
 b=Pt4pzRS095LhKSpMYiE//oNSnSFlH6zW75mf0spjtdmX1iWf+11y4EHWiSl01nZYiNAJvU
 zb/kpMxpcDbxcRpUhZpXSAm6ORpD+q7kUe5LlnpzEZ+2LnLqLlp1AeydpFxARarV/PpZUs
 dqBDa2bKQtOF+16NDxv5F7IGrYwKcSQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-Kv42mhnlPyCxuKwBU3OF2w-1; Sat, 20 Jul 2024 15:09:09 -0400
X-MC-Unique: Kv42mhnlPyCxuKwBU3OF2w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4265d3bf59dso20219775e9.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 12:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721502549; x=1722107349;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vUyBbKeQrZ+nfQvxj25plekZeCd0lrD4h7eC8vQTj+U=;
 b=u+XcUdf3KAK0AhFzJ/sp1A2LSbzQkn0kZMX/O0L4umtVe84ZgT0Lf0fGUlziKk7vrQ
 hDn/Il6qWR8ESuVDmsAyHdMAsXIiKej4ly1Sg6NsA0ZhDdavBdX2mNhEV4GySYchxRFD
 YkJ7+Y79Tb/8veG2SeJ1tmgDHetQ7HvB2RLBAfTTvWIqR665iNaa//sPXEEfdDkxhU67
 bCLMznKCA7U/2GDcUHOrJDXCGdDoqSJYIhpcSViSsRtv0/Ae6c0lWh5nObcY8D3Z1Lhg
 a8KuAxKh2FQGeeekbq18o8w8LUJKrYDcpe/MXoQS9qq3OiH2vQQn729EsEnpbws6NFF0
 XLrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8pC15k/1D3i1Lc0GeDSuowD2AyT/mVHiSjUBUjPT0rCC7IqFUz6sP+Fo6rtqmGCtY9xr2qSt2wg5dgxx1xvAP6j3IQs0=
X-Gm-Message-State: AOJu0YwqTfowahyH9n8Sv/ergNp5OTst0H9rKGIzEHfkveF82bejB5BF
 K2cmoXloB9JksDaAybxS8YcphhqSpPT1wk5KbNSzq5/mk7701m2hsK5pLAZQtNrKfalUCrnp/92
 R8JmooFoE+OA8AKwQZC2I1fREekU/bY7gv7yUFxD6oyKnKHZNZjoi
X-Received: by 2002:a05:600c:444d:b0:426:686f:cb4c with SMTP id
 5b1f17b1804b1-427dc57886emr15866295e9.32.1721502548895; 
 Sat, 20 Jul 2024 12:09:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMPpmD9RhDQw1HS79wF9KFGjcCWeZbE8wRwThnZdZdJUaOfLuJwkcnPFa6nnh8w8DIMrNkCg==
X-Received: by 2002:a05:600c:444d:b0:426:686f:cb4c with SMTP id
 5b1f17b1804b1-427dc57886emr15866175e9.32.1721502548334; 
 Sat, 20 Jul 2024 12:09:08 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69071c5sm66626245e9.27.2024.07.20.12.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 12:09:07 -0700 (PDT)
Date: Sat, 20 Jul 2024 15:09:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v4 4/4] intel_iommu: make types match
Message-ID: <20240720150853-mutt-send-email-mst@kernel.org>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
 <20240705105937.1630829-5-clement.mathieu--drif@eviden.com>
 <c592cd1f-f007-42e3-9961-750122e7a6fc@intel.com>
 <20240720144539-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240720144539-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jul 20, 2024 at 02:46:14PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 08, 2024 at 03:20:45PM +0800, Yi Liu wrote:
> > On 2024/7/5 19:01, CLEMENT MATHIEU--DRIF wrote:
> > > From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> > > 
> > > The 'level' field in vtd_iotlb_key is an unsigned integer.
> > > We don't need to store level as an int in vtd_lookup_iotlb.
> > > 
> > > This is not an issue by itself, but using unsigned here seems cleaner.
> > 
> > a nit to the subject. s/"make types match"/"make type match"/
> 
> Hmm not sure I agree.
> There are two variables, they have types. We make them match.


ignore pls this is on old version

> 
> > > Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> > > ---
> > >   hw/i386/intel_iommu.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > index 37c21a0aec..be0cb39b5c 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -358,7 +358,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
> > >   {
> > >       struct vtd_iotlb_key key;
> > >       VTDIOTLBEntry *entry;
> > > -    int level;
> > > +    unsigned level;
> > >       for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
> > >           key.gfn = vtd_get_iotlb_gfn(addr, level);
> > 
> > -- 
> > Regards,
> > Yi Liu


