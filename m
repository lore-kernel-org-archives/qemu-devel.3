Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41347CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 19:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEBjK-0002M5-Lf; Wed, 29 Oct 2025 15:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEBjI-0002LH-FS
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 15:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEBj7-0003WB-TJ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 15:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761765649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sx9skujbOzAhJaA8ojljNZyg41FYTwyTZvmXGxrCr4k=;
 b=MYjaPP0Caj/kyJY4cXjmhu5F9rHDyFnIsW1g4uwspAPImo//SA+xC1ZbPtnXjk9Qhq5IxS
 AlpiAN4ha7JdoqbsBafNPPIoQgm+yFUQRf3I0PZf3SONLrQRoQGfDK8IPSURuaXxzX0DBF
 ln6qCuvkWn1yl2d68EChzks7YB9vOgs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-orPuQBfPPkS5dI4yDTJyjA-1; Wed, 29 Oct 2025 15:20:48 -0400
X-MC-Unique: orPuQBfPPkS5dI4yDTJyjA-1
X-Mimecast-MFC-AGG-ID: orPuQBfPPkS5dI4yDTJyjA_1761765648
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8aa1a684953so81201185a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 12:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761765648; x=1762370448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sx9skujbOzAhJaA8ojljNZyg41FYTwyTZvmXGxrCr4k=;
 b=OLO1VQLy9RiYSNIzMt+gsXZhs6CqOdoF6wAPzxSBbaRaK/on1lb9aAMLqDg4nrPMb9
 iqWmov4NJe/d1QHFkk1oAVp1fmL+ukhw/Ct1//byFJkt9BsMiMCh5CACUROXyqM6EhQC
 mXi2fynakxzAqYVggb6QL5CQ5QqlQ8Jn/0PNHB0xtBWmSTMA5NyPCEcPuxBOCMySqCLA
 BaeSaf5gonKjzGvg3Z0BlkSb6C/dWGUehdgOmhFFdQhynjorRnyzTA+U07cxKuBExZ7w
 oPYgNvwLgaHoIxdsvkNDvI5gKoRA08BGxChH4EanAUbIRAAfl5c/9BNV/Qx52J5qtLyZ
 xCNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9jchNzbpz6s1586SM2kMUcwaRohffw7H0TE4KAqqeOBA5+G6m1aDJDl0jtxLgeG9692sCyMlJlcpF@nongnu.org
X-Gm-Message-State: AOJu0Yy80lbDvSC372JLFYA1EtIGH4x5ng+/8U6cU2RsWtkwK7as6i2r
 WoosvJARfaN5gdKxwr2IENrRB9BrmW0jHhyuba4RfWuwYuwJBK5XVT3WI5mkvBZ0+LEhEJxVMej
 PSRfts2ZuPGna/ZQJQw4rmgd8BmB8h0/bB6ZeSJUmx0TMNvIhGu5+VBbl
X-Gm-Gg: ASbGncuaU9MS9pQG5yuIlLg4VxLIWO1mm3ebovmn0xDuVxWDohsfEvDhhlDDa1QFzp0
 ffF9mgJI1nMRQpFm5g7FFDulZzhgCiKRXx1qW0y5BougAJzdiVHebCAORdGPsptLeG/66owUJLr
 aCTURJJGs5nrDO1du6BT88wVyB8YML8a4UI7KJq76dM5ZVxBT+Tu9vOnP6IXgH3e9oC+Nig4zoT
 xX173oS2VENJTaLcu20B+5DWnGcScGjNnPfNRAUL5N6L1/EGwIZPv+cetF5bldALtMXmYj6XKmO
 ARdnwEVhFVy0Li8tR8Q+ZBZEXorasOhCsHYOpUPsaqYfPW94ZwVYvVDySmzDF4PjhMo=
X-Received: by 2002:a05:620a:31a5:b0:8a3:c4fa:9b77 with SMTP id
 af79cd13be357-8aa2a559c30mr133386185a.6.1761765647746; 
 Wed, 29 Oct 2025 12:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVIij/rkczZgHCy8mdZKOEtx2chkJ8ndmT87UpohU/0euylD3KBpGvA6fpA2eNsDFcbERYAQ==
X-Received: by 2002:a05:620a:31a5:b0:8a3:c4fa:9b77 with SMTP id
 af79cd13be357-8aa2a559c30mr133382085a.6.1761765647292; 
 Wed, 29 Oct 2025 12:20:47 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2607f05csm1102334185a.53.2025.10.29.12.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 12:20:46 -0700 (PDT)
Date: Wed, 29 Oct 2025 15:20:44 -0400
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
Message-ID: <aQJpDE6FvkIF6GgE@x1.local>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
 <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
 <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
 <dbdbc78f-3d4b-c0b2-87ac-85e24568a115@eik.bme.hu>
 <802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp>
 <28c6f065-ba8d-e5e2-922e-d5fd1fb58b60@eik.bme.hu>
 <db06bf5e-b7f5-4980-a054-393529e188eb@rsg.ci.i.u-tokyo.ac.jp>
 <759b6b4c-1155-184a-fa99-1df384f0fac3@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <759b6b4c-1155-184a-fa99-1df384f0fac3@eik.bme.hu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 29, 2025 at 11:30:10AM +0100, BALATON Zoltan wrote:
> > memory_region_new_* will work, but I don't think removing unnecessary
> > but harmless fields from a device state structure does not sufficiently
> > motivates adding them.
> 
> I haven't given up on this yet, that's why I alternatively proposed
> 
> object_alloc (same as object_new without object_initialize)
> memory_region_init
> 
> which is just a small change but should also work without adding
> memory_region_new convenience functions. Then only object_alloc needs to be
> added.

IMHO if this will ever happen, memory_region_new*() is better, unless
object_alloc() can be used anywhere besides MemoryRegion..

It seems to me, MemoryRegion is the only one I'm aware of that may need
such tweak, rather than using object_new() directly.

-- 
Peter Xu


