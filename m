Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9A2C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYgy-0005q1-3U; Tue, 30 Jun 2026 09:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1weYgw-0005pe-CV
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1weYgt-0005PA-HE
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782826792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dVJjTqLJ7aZHl2k4bqz6Gqsk74v2Sb2nqrLLUKq9MGg=;
 b=MyBdS41eI1+GCfjJCwl4ubnhrRlXwllpiYAbbsX7s20gFApJpIU8NXg0DsE64QuoD+defE
 WqF2PTyHNYjUnGg+lJ4+11BHYhSRyAEd+9bqziIfoxQZwBwrd+39Ck4zZI+hE8jlJqRrQ2
 ogSEUCnlIjKo5suSc4+FFJa7hMcLXHI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-MQFDhLo6Pj2IqAs52c6FRw-1; Tue, 30 Jun 2026 09:39:51 -0400
X-MC-Unique: MQFDhLo6Pj2IqAs52c6FRw-1
X-Mimecast-MFC-AGG-ID: MQFDhLo6Pj2IqAs52c6FRw_1782826790
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4767036f8faso41276f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782826790; x=1783431590; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dVJjTqLJ7aZHl2k4bqz6Gqsk74v2Sb2nqrLLUKq9MGg=;
 b=WGRZMi0X1OUdE0T0cd1VcTQYuyq2ypJdHv7aPtgLO4U+TFYzXFc1QXOs2f8N1BCko8
 Wn5c1QsiTXnBoX100BQF1OFHljFLX8SDGotTrxqPnxUCZv2ZqdA4mrhBHilpPZ+l+q36
 7mEeyy+0u0CpMYK4MLCcI/7NAzRZHExfEB8HddomGlaM6Iq8k9EFsMU6PW6gN+uGpIuQ
 W1cVyuBvyl/8lTwjwkfwIrPpwTxnohCk5FjYwcLjV5wOXjXxqpTzGCH6IvZgKIn063fR
 Zy1h2L//dgiK/abWnuqXGtBtHpIUXd2UExNV4CdUSD0OdJp9BQv47N9ru6cS89o+HCDq
 t2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782826790; x=1783431590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dVJjTqLJ7aZHl2k4bqz6Gqsk74v2Sb2nqrLLUKq9MGg=;
 b=K3xLgBMF6c3zRC6tTCtny/YkNiAcHLT/TYNOqI+AnRyN2ZNOsydFZTTTz42FIiledw
 0nY0j8tGzz14ryw/pj/4kO1MLHNYocgdiUpytJSt+rgTmUSjhnatXIFsnWc6DPSd8Oe2
 WRoQ68c4ChDGXp4PBZFcKYkwZXRRDwz+Tv27DVAzk+DwlgwS1JJv21LW4M2neCIrFlZD
 MKiWL7QCuKiS9hrKKbgx1LY3mP9mJ3jIJGy/naHOmLc5rk1+GltZswXItllN8O9cGVfR
 lPOJNfyREYWxkDa3EFGyJ613L3/W+qqSXJqrQCBwBb1pcNpWItTGBeCKBspE28fwKArH
 WPhg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpz/16pyjTkuhoWoPoswn2ExHHORfgUfCtLmfbUmDGEG7L/m/4j+X3OsN1N5rNqaieGLAF914MQsdbr@nongnu.org
X-Gm-Message-State: AOJu0YxyuVfZ2P09X9yg9Tuh1hDalTAW7qB73dUKBvXkUKinn3bIH2CQ
 LKmdweaqt2zwxpi2wjuRB5sL5knicPAhJU6gKMUE0RZNi4FvT52Dyee1EwCh7S6ljlKeQPjoDrd
 sPqP0XTmSUuAZL6DBRlLYZhtXvdRU1Tf5PhJbSc4lBeAMDLj1LGS0zpmK
X-Gm-Gg: AfdE7cmYNFStlNQlU86q89rG/jyANp+4OS8M2TzcFTsfxQ4GM6asSzYfAYpECYrOYw+
 +FALVUc9GQLiTpno2Yt6Y1gJl587aXLiqRcMNp1yhNHWFGQG2zjaerg/0ElXXm/7jt5F8NKWYWu
 p8cWoGRK1lmha5wh5l/d/dKIHX8501jGlrBDny5HcxjLgXjFEWjcLCI+XGM2UIpKsk47ipp5x8G
 +mnXYA7ZPEB+FtYe0phHY59ocIXiv9tyxnEPg7mrm4dZekVUGgK1qYZvRXut3mZxliSQZOT+DOI
 o3gzWFTc7+7ih3e087bmTVMGmenczvlmlpKNbhpfgxx7jQ3MYYVCPMEb9zprOd+VaJfYp76LXEW
 8+t+KH/nq2HuF8rJxnSNKsYIdseUd0Z9A
X-Received: by 2002:a05:6000:27c3:b0:461:9950:da50 with SMTP id
 ffacd0b85a97d-4765963cc87mr661168f8f.11.1782826789626; 
 Tue, 30 Jun 2026 06:39:49 -0700 (PDT)
X-Received: by 2002:a05:6000:27c3:b0:461:9950:da50 with SMTP id
 ffacd0b85a97d-4765963cc87mr661135f8f.11.1782826789079; 
 Tue, 30 Jun 2026 06:39:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636cf98sm5915718f8f.22.2026.06.30.06.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 06:39:48 -0700 (PDT)
Date: Tue, 30 Jun 2026 09:39:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 harshpb@linux.ibm.com, npiggin@gmail.com, fbarrat@linux.ibm.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com,
 calebs@linux.ibm.com, milesg@linux.ibm.com, jishnuvw@linux.ibm.com,
 adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v5 0/9] pnv/phb5: Update PHB4 to the latest PHB5 spec
Message-ID: <20260630093929-mutt-send-email-mst@kernel.org>
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <d58ee809-02b3-49be-b927-eacf2da8bfb5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d58ee809-02b3-49be-b927-eacf2da8bfb5@linux.vnet.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 30, 2026 at 03:52:04PM +0530, Saif Abrar wrote:
> Hello Cedric, Michael,
> 
> Is it OK to retain you Rbs in the next v6?
> 
> or would you like to review this v5? (as the patches have evolved since you
> last reviewed.)
> 
> Regards,
> 
> Saif


I took a look again.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> On 17-06-2026 15:20, Saif Abrar wrote:
> > Hello,
> > This patchset resolves the review comments for v4:
> > https://lore.kernel.org/qemu-devel/20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com/
> > 
> > Thanks to all the reviewers for their efforts.
> > 
> > Major updates include the following:
> > - Rename to phb5.
> > - New file for common definitions used in tests/qtest/pnv-* files.
> > - Initializing PnvPHB4Class members within class_init method.
> > - Updated IODA3 PCT table max size to 128, each with 2 entries.
> > - Multiple general cleanups.
> > 
> > Tested with 'make check-qtest' , 'make check-functional-ppc64' and 'make check'.
> > 
> > Regards.
> > 
> > Saif Abrar (9):
> >    qtest/phb5: Add testbench for PHB
> >    pnv/phb5: Add reset logic to PHB5
> >    pnv/phb5: Implement sticky reset logic in PHB5
> >    pnv/phb5: Implement read-only and write-only bits of registers
> >    pnv/phb5: Implement write-clear and return 1's on unimplemented reg
> >      read
> >    pnv/phb5: Set link-active status in HPSTAT and LMR registers
> >    pnv/phb5: Set link speed and width in the DLP training control
> >      register
> >    pnv/phb5: Implement IODA PCT table
> >    pnv/phb5: Mask off LSI Source-ID based on number of interrupts
> > 
> >   hw/pci-host/pnv_phb.c               |   1 +
> >   hw/pci-host/pnv_phb4.c              | 581 +++++++++++++++++++++++++---
> >   include/hw/pci-host/pnv_phb4.h      |  16 +-
> >   include/hw/pci-host/pnv_phb4_regs.h |  66 +++-
> >   tests/qtest/meson.build             |   1 +
> >   tests/qtest/pnv-host-i2c-test.c     |  13 +-
> >   tests/qtest/pnv-phb-test.c          | 235 +++++++++++
> >   tests/qtest/pnv-qtest-common.h      |  24 ++
> >   tests/qtest/pnv-xive2-common.h      |   7 +-
> >   9 files changed, 868 insertions(+), 76 deletions(-)
> >   create mode 100644 tests/qtest/pnv-phb-test.c
> >   create mode 100644 tests/qtest/pnv-qtest-common.h
> > 


