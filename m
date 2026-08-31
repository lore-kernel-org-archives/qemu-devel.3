Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFC9C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x15Ry-0002t3-QG; Mon, 31 Aug 2026 13:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x15Rw-0002oG-DU
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 13:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x15Rt-0001Ya-2e
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 13:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788195930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=asgAc5dWjjb38a9V+qk1adPMSmyly73cIk2R1tCMdVg=;
 b=FwT3U05moxF6lJ+OuIKFr/n01asvj5uVYbTmtAj0nd1b+13Txj4Y9U0uFIgYMWfYKlPdK+
 xF6m07wB0wWB5Xx8pJP4AtGjXcUEFDxsNAxAlCVCYYe7oUi7EqM0jhpQ+hMFXQCd9zTpnG
 xV3YKxn4PTRhutim34LeJcOXccOyyRU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-Kxqi9QaPN_m3VhHyRR82FA-1; Mon, 31 Aug 2026 13:05:25 -0400
X-MC-Unique: Kxqi9QaPN_m3VhHyRR82FA-1
X-Mimecast-MFC-AGG-ID: Kxqi9QaPN_m3VhHyRR82FA_1788195925
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90cc2b97f8fso65044706d6.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788195925; x=1788800725; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=asgAc5dWjjb38a9V+qk1adPMSmyly73cIk2R1tCMdVg=;
 b=hlTRYFvHEkO7zey9Vd65eQuPX38v2RPFWJAgR2vSEuc8+LV/IsPl+5mYesWVN1r485
 +ILvUkMR+HpP3DNlD7ZLfNVYOUW6puBDCTiDBqEeccFNouwJPYrPzPGJYhhgSVDtVOLk
 5QOsYH+wVXV0zCRJs1dRrGHhhyj0/IfASCyP/+HwdinnMVKCnVyGfVfMiQiTITgCuUz0
 HEliDnioLvp9nayZhDYMQuIwNMKUbnQkgZg/mAvgLdR7TamvRgAst7d7rs7P7fYulRnu
 Ct2ubpH9GYBieVRIkDsFGqZjfh0N5c6wL6tGQyIMVBz3n3Q3+x/hWAq2GwmzY5SBaqxV
 rZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788195925; x=1788800725;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=asgAc5dWjjb38a9V+qk1adPMSmyly73cIk2R1tCMdVg=;
 b=KIMYIRFjC1WCHYz+tlmja31mac3ELF+LoauKCv/zfK3ER5suXKrDbekLWFPvSpWZFp
 r6kPqqfqW+xrXxqZklsHUiRbML2sz6cxxem5bezipIIaSfZhEAEyeaUyG3pmfZj0WR2d
 VEiyMZ1CeB31jOPaP4yLdsTpoiX4kpDLdRNgwwJqtGoMurPhjfHEhCxGTNgtK8/BbRCS
 J9OcRfNrgYJvktV/FlOP5Uuvmz33DKxZVQdavOr4j/YQJfHSBPU66uY5mwZLeHuflzNm
 k2y0SoKQ9km3begPDq8oiWPpW5zuUyqg29GWdz5ym4golgIK6iv8m/ECRvifcFPKgZ+p
 N0wg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqiln2EeLDJVDapIBiAlNRzbwtok6D0VfyJiQC5elyNAFyJAS6ypXsca3b7/smiaNl8viZfTVDRSS7q@nongnu.org
X-Gm-Message-State: AFuF++n+cd4m0HQsCUFu2dLowtYHrSXs7Hn7AiIfgEKFC8qjoY6lN5cs
 BVys7bFKDNCHaZNee+fiAsaiRADndYdxn+cHiJXOm+lZX94AUbuaIqLfQrmcdvIKdO+D+juLAEX
 QaYunvjCpF2Rabf7KBCOm08nYutI+9GwDC5T+EtZrjUrmtH0ICXLXC4Cj
X-Gm-Gg: AR+sD123t5DoC7LyuIqkf+WEfQpzRjAeUG+9us33QLBGYJZAVNn8dExS83UbDLr/AcV
 P9MeSzelvuBIkiGu3gRqi3aaMGIrqsA9cHnqg3QP8SyT6Ar/9l8bcOdDdnq+8WaRoX9ysd7hVY1
 EqgRMzAW9+xuTY+/qc9HQxt4WMl84HjiYwl0z+Tt0x0dhWxFimfjFpnqpCyWH9ZFl2x7QW/U4v3
 786PbyAvVsxh6HpGHjE9f+QUzXvTzjb5gCeROV58ha3EFKv9MPZgsV1+NVtW1MUREX3ADXqS00B
 wsc1id6AXq8eAWgA7m0cgpxUn1MChaKWGyDLq3ZAYfBNhQYvyRNw7xupA54cxiAqPZsDA1swRKv
 2EB3hWSiIBN+u2q8wDSKzeeIRzuW2xot0nNjs8zf8yAzFyGO9WwYq0aa0og==
X-Received: by 2002:a05:6214:21e6:b0:90c:4d1f:f88e with SMTP id
 6a1803df08f44-90ce0ed1626mr323776256d6.16.1788195924467; 
 Mon, 31 Aug 2026 10:05:24 -0700 (PDT)
X-Received: by 2002:a05:6214:21e6:b0:90c:4d1f:f88e with SMTP id
 6a1803df08f44-90ce0ed1626mr323774196d6.16.1788195923685; 
 Mon, 31 Aug 2026 10:05:23 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90ce444e2c5sm88932886d6.10.2026.08.31.10.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 10:05:22 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:05:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: BillXiang <xiangwencheng@lanxincomputing.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, cw@f00f.org,
 dbarboza@qti.qualcomm.com,
 Demi Marie Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 helge.deller@googlemail.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>,
 jacob.oursland@gmail.com, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, utsingh@redhat.com,
 Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: Re: KVM/QEMU community call tomorrow - agenda items?
Message-ID: <apW0SkNxWPCyvVV6@x1.local>
References: <877bl6eoqv.fsf@draig.linaro.org>
 <413b9ba2-20cf-4af6-9998-be46da277c84@lanxincomputing.com>
 <48cef34d-18c1-4b8c-a75d-19d1d1321634@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48cef34d-18c1-4b8c-a75d-19d1d1321634@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 31, 2026 at 05:46:12PM +0200, Philippe Mathieu-Daudé wrote:
> On 31/8/26 13:49, BillXiang wrote:
> 
> > How about discussing the patch[1]:
> > "virtio: Add aligned ld/st accessors for vring".
> > 
> > As pointed out in the patch, this has been a long-standing issue. It is
> > now necessary to introduce atomic accessors for fields that require
> > atomicity, such as the avail_idx field in virtio. This support is
> > especially crucial for architectures like RISC-V, which do not natively
> > support misaligned memory accesses.
> > 
> > I'm particularly eager to receive more suggestions for it.

I saw the last email was from me..

https://lore.kernel.org/qemu-devel/aoxiBB2Wn8NiL5s6@x1.local/

I believe that was what PeterM suggested. I think Richard also at least
partly agrees. so I thought we had at least partial consensus on the rough
idea, if not exactly how.

I confess I haven't fully got the latter part of Richard's comment,
regarding the possibility to reuse accel/tcg/ldst_atomicity.c.inc: that
path seems to invole a guest CPU context, where in the case of reading
virtio ring it is from host and it has no guest CPU context.  But I think
we can continue the discussion on the list in that thread.

> 
> This is a very technical topic, not sure if the community call will
> be a better place than the mailing list, in particular if no virtio /
> atomic expert developers appears. We'll see :)

Yes, I had such similar feeling that the problem was not yet blocked by
something that a video call would better help..

For example, I still want to double check if that change would work for
your current use case, it will at least verify the thought, no matter if we
want to use it or not.

Thanks,

-- 
Peter Xu


