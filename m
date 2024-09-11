Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF440EE4990
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 10:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soKpI-0006vL-Mp; Wed, 11 Sep 2024 06:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soKpH-0006u2-EO
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soKpE-00041N-MY
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726051430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qp8HthLEtEI1BIHmUeGQtWxbIttNaWqUnHB/Z/UzX0g=;
 b=ioZnwGHjUO1FUdXa2CFoomgLnSiAoxbNS49VikDtPJjGc1/Ljb7RFIp2oBH/luX6mIc6ru
 OYtUZ+LP+YMKk6pcObrFSShEUw+vbBUpIl+L05q5jkcW0f7rK9gwjVcsqV2hxp4wEUui/d
 OJ1xTEH69z73sO7eEbThWiQghul+n5s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-wiA3vIPNNUWaixUVQw4ZQw-1; Wed, 11 Sep 2024 06:43:49 -0400
X-MC-Unique: wiA3vIPNNUWaixUVQw4ZQw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c25e0a50bfso4689889a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 03:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726051428; x=1726656228;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qp8HthLEtEI1BIHmUeGQtWxbIttNaWqUnHB/Z/UzX0g=;
 b=PzRLGt2keWZqZuver7TAE9R/EYSRnJIRvARw0IyHVSEOwOXbeVP4xtrk0yRFZDizpF
 EEQc3ki0AzXk4K5hBKpZDf9ji1T+rqjORJYpOpbx5RxazITEd8Nm9aBbSpLcUBdo+w01
 CBqyyVFsU8VgLxWLfFU3R8h449Cp6are4XN9gTIUc/pACeUcnXbv3z6XFGIeilB00qHh
 0mwua112Wvo181BmcLt35rLniFolblaRuDTSurxwLI/7ddQ/I8sL3akAvoJ1AQCDRe3b
 TIr/gmVz2ufcnn9vtvglsBPRIlvKP4nKpTQQI86C9/RwDF4aRRBYxlbYgACLtr4VTz7X
 rbYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeiDR8j3K8oo/xT57UsnV4YQ8Q0IdbtHEshhRPGCMwIKNY1yjkvZEuuFFymxvZmsJ7NjNTULyRYert@nongnu.org
X-Gm-Message-State: AOJu0YxF28B20Qfc358u7g88IN5VSu/cVmMfJpxmBbK6dMAbCz4l1f+x
 Y13SycAnR7em7e2BZvbyF28Xh5E2MgitghXCzMIMAaAjeuVwo3fcYytB75kt19LeiKpzNzUS/2b
 wTeGAUpLFL4Ki20uyZhyGvU6xS9ZXbNNmuucy/Jj3I3X5ZqM2ZKa3
X-Received: by 2002:a05:6402:2708:b0:5c2:58f7:fe95 with SMTP id
 4fb4d7f45d1cf-5c3dc7c3e2cmr11914120a12.31.1726051427989; 
 Wed, 11 Sep 2024 03:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5HyGTlndQ5dLPjQNRU7WzdR5xJpJkOLFB2i4skjH8k19ZUbPXmzPddSPi2BCkDODBiVPOBw==
X-Received: by 2002:a05:6402:2708:b0:5c2:58f7:fe95 with SMTP id
 4fb4d7f45d1cf-5c3dc7c3e2cmr11914082a12.31.1726051427028; 
 Wed, 11 Sep 2024 03:43:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd46886sm5232813a12.34.2024.09.11.03.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 03:43:46 -0700 (PDT)
Date: Wed, 11 Sep 2024 06:43:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v3 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Message-ID: <20240911064327-mutt-send-email-mst@kernel.org>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <c84acb53-bd3b-4f3a-8c0b-7d4cae1fa8a8@eviden.com>
 <SJ0PR11MB6744522A7192F1FA3794651F929B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR11MB6744522A7192F1FA3794651F929B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 11, 2024 at 08:43:10AM +0000, Duan, Zhenzhong wrote:
> Hi Clement,
> 
> Thanks for your review. Hoping it could be accepted in the foreseeable future.
> 
> Thanks
> Zhenzhong

the comments are minor, so just keep iterating.

> >-----Original Message-----
> >From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
> >Subject: Re: [PATCH v3 00/17] intel_iommu: Enable stage-1 translation for
> >emulated device
> >
> >Hi Zhenzhong,
> >
> >Thanks for posting a new version.
> >I think it starting to look good.
> >Just a few comments.
> >
> > >cmd
> >
> >On 11/09/2024 07:22, Zhenzhong Duan wrote:
> >> Caution: External email. Do not open attachments or click links, unless this
> >email comes from a known sender and you know the content is safe.
> >>
> >>
> >> Hi,
> >>
> >> Per Jason Wang's suggestion, iommufd nesting series[1] is split into
> >> "Enable stage-1 translation for emulated device" series and
> >> "Enable stage-1 translation for passthrough device" series.
> >>
> >> This series enables stage-1 translation support for emulated device
> >> in intel iommu which we called "modern" mode.
> >>
> >> PATCH1-5:  Some preparing work before support stage-1 translation
> >> PATCH6-8:  Implement stage-1 translation for emulated device
> >> PATCH9-13: Emulate iotlb invalidation of stage-1 mapping
> >> PATCH14:   Set default aw_bits to 48 in scalable modren mode
> >> PATCH15-16:Expose scalable "modern" mode and "x-cap-fs1gp" to cmdline
> >> PATCH17:   Add qtest
> >>
> >> Note in spec revision 3.4, it renames "First-level" to "First-stage",
> >> "Second-level" to "Second-stage". But the scalable mode was added
> >> before that change. So we keep old favor using First-level/fl/Second-
> >level/sl
> >> in code but change to use stage-1/stage-2 in commit log.
> >> But keep in mind First-level/fl/stage-1 all have same meaning,
> >> same for Second-level/sl/stage-2.
> >>
> >> Qemu code can be found at [2]
> >> The whole nesting series can be found at [3]
> >>
> >> [1] https://lists.gnu.org/archive/html/qemu-devel/2024-
> >01/msg02740.html
> >> [2]
> >https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_stage1_em
> >u_v3
> >> [3]
> >https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfc
> >v2
> >>
> >> Thanks
> >> Zhenzhong
> >>
> >> Changelog:
> >> v3:
> >> - drop unnecessary !(s->ecap & VTD_ECAP_SMTS) (Clement)
> >> - simplify calculation of return value for vtd_iova_fl_check_canonical()
> >(Liuyi)
> >> - make A/D bit setting atomic (Liuyi)
> >> - refine error msg (Clement, Liuyi)
> >>
> >> v2:
> >> - check ecap/cap bits instead of s->scalable_modern in
> >vtd_pe_type_check() (Clement)
> >> - declare VTD_ECAP_FLTS/FS1GP after the feature is implemented
> >(Clement)
> >> - define VTD_INV_DESC_PIOTLB_G (Clement)
> >> - make error msg consistent in vtd_process_piotlb_desc() (Clement)
> >> - refine commit log in patch16 (Clement)
> >> - add VTD_ECAP_IR to ECAP_MODERN_FIXED1 (Clement)
> >> - add a knob x-cap-fs1gp to control stage-1 1G paging capability
> >> - collect Clement's R-B
> >>
> >> v1:
> >> - define VTD_HOST_AW_AUTO (Clement)
> >> - passing pgtt as a parameter to vtd_update_iotlb (Clement)
> >> - prefix sl_/fl_ to second/first level specific functions (Clement)
> >> - pick reserved bit check from Clement, add his Co-developed-by
> >> - Update test without using libqtest-single.h (Thomas)
> >>
> >> rfcv2:
> >> - split from nesting series (Jason)
> >> - merged some commits from Clement
> >> - add qtest (jason)
> >>
> >>
> >> Clément Mathieu--Drif (4):
> >>    intel_iommu: Check if the input address is canonical
> >>    intel_iommu: Set accessed and dirty bits during first stage
> >>      translation
> >>    intel_iommu: Add an internal API to find an address space with PASID
> >>    intel_iommu: Add support for PASID-based device IOTLB invalidation
> >>
> >> Yi Liu (3):
> >>    intel_iommu: Rename slpte to pte
> >>    intel_iommu: Implement stage-1 translation
> >>    intel_iommu: Modify x-scalable-mode to be string option to expose
> >>      scalable modern mode
> >>
> >> Yu Zhang (1):
> >>    intel_iommu: Use the latest fault reasons defined by spec
> >>
> >> Zhenzhong Duan (9):
> >>    intel_iommu: Make pasid entry type check accurate
> >>    intel_iommu: Add a placeholder variable for scalable modern mode
> >>    intel_iommu: Flush stage-2 cache in PASID-selective PASID-based iotlb
> >>      invalidation
> >>    intel_iommu: Flush stage-1 cache in iotlb invalidation
> >>    intel_iommu: Process PASID-based iotlb invalidation
> >>    intel_iommu: piotlb invalidation should notify unmap
> >>    intel_iommu: Set default aw_bits to 48 in scalable modern mode
> >>    intel_iommu: Introduce a property to control FS1GP cap bit setting
> >>    tests/qtest: Add intel-iommu test
> >>
> >>   MAINTAINERS                    |   1 +
> >>   hw/i386/intel_iommu_internal.h |  91 ++++-
> >>   include/hw/i386/intel_iommu.h  |   9 +-
> >>   hw/i386/intel_iommu.c          | 694 +++++++++++++++++++++++++++----
> >--
> >>   tests/qtest/intel-iommu-test.c |  70 ++++
> >>   tests/qtest/meson.build        |   1 +
> >>   6 files changed, 735 insertions(+), 131 deletions(-)
> >>   create mode 100644 tests/qtest/intel-iommu-test.c
> >>
> >> --
> >> 2.34.1
> >>


