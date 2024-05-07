Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F32C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4N8F-00071r-L7; Tue, 07 May 2024 11:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1s4N85-0006Yl-ND
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1s4N82-00059l-IB
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715097194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/p62PpUlXpQLcDK4AU7DZJBrUFG0lvrcdHAWwWeto0=;
 b=HxnSB9EyHw/zHpYlZDYLYAax1tJsORtOSzd58fZvQsYRegnJyljWg1qufBVDb+GuV8Nhn/
 CuFjk+SyS6HHtGv7WCpId/+eJprwFQUl5Awfk3PPTruw9TjKV+dJ3znR1X2Bb9V5a0ZAg2
 bMKiiSHA4Ax6K9/FvmAs8uosiXOe16Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-DlMw73eoPDGQeT1AdlXGrw-1; Tue,
 07 May 2024 11:53:13 -0400
X-MC-Unique: DlMw73eoPDGQeT1AdlXGrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DB763803526;
 Tue,  7 May 2024 15:53:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 970CF2141800;
 Tue,  7 May 2024 15:53:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 888581800D4F; Tue,  7 May 2024 17:53:10 +0200 (CEST)
Date: Tue, 7 May 2024 17:53:10 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Frank Chang <frank.chang@sifive.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Subject: Re: [RFC PATCH 0/1] pci: allocate a PCI ID for RISC-V IOMMU
Message-ID: <d4wsa62chc4dgxeakmsimk6tsvxhflgbofgbugpfjyyo5xx2oh@urgime5r4wqs>
References: <20240503124244.8804-1-dbarboza@ventanamicro.com>
 <CANzO1D0g=AoPkyFS_5d5mJwmwDX8hpaj0fjeFy9xt4xi70fh1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANzO1D0g=AoPkyFS_5d5mJwmwDX8hpaj0fjeFy9xt4xi70fh1A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 07, 2024 at 11:37:05PM GMT, Frank Chang wrote:
> Hi Daniel,
> 
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> 於 2024年5月3日 週五 下午8:43寫道：
> >
> > Hi,
> >
> > In this RFC I want to check with Gerd and others if it's ok to add a PCI
> > id for the RISC-V IOMMU device. It's currently under review in [1]. The
> 
> Is the link [1] missing?

Yes ;)

Also:  A bit more background on the iommu would be great, for example a
pointer to the specification.

take care,
  Gerd


