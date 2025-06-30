Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735E9C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 10:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWBLb-00013g-DC; Mon, 30 Jun 2025 06:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uWBLX-00013I-QR
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 06:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uWBLT-0007Un-LP
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 06:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751277754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BYG5a851oZPn3BU3e51ZM2Hp1tNku3l0+msmEYv051k=;
 b=Q4TJuNoPHO4rujW4bg62+/TRHaDV0FDeuf/Atgxk0E3Vv2b/lQJz9sg8A4c3r9Yvw4W/Iy
 QnJGJ2cTuDcruXMdogI4fgoa9kRn06vkbcSho8Y9Bndu7lrR2WPwPc4jsNmnJs2j6IvYIR
 mvpFMfdVSPYdmd9QVFQYEDkfN1zPJrI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-BYp6--_WP2ahIV3fH2B5UQ-1; Mon,
 30 Jun 2025 06:02:31 -0400
X-MC-Unique: BYp6--_WP2ahIV3fH2B5UQ-1
X-Mimecast-MFC-AGG-ID: BYp6--_WP2ahIV3fH2B5UQ_1751277749
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 974F11944A8D; Mon, 30 Jun 2025 10:02:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.226.82])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62FBF19560A7; Mon, 30 Jun 2025 10:02:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0565218000BA; Mon, 30 Jun 2025 12:02:26 +0200 (CEST)
Date: Mon, 30 Jun 2025 12:02:25 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, 
 anisinha@redhat.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com, 
 pbonzini@redhat.com, david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH 1/3] memory: reintroduce BQL-free fine-grained PIO/MMIO
Message-ID: <ehnkq6m3mdnrh2my5ui7agknq42js7y2rlu4ghtvj7egscryhg@4g4kapalbj62>
References: <20250620151418.1166195-1-imammedo@redhat.com>
 <20250620151418.1166195-2-imammedo@redhat.com>
 <aFWR8rM7-4y1R0GG@x1.local> <20250623145146.4462bf59@fedora>
 <aFlYRWc7rRwBGM8S@x1.local>
 <uyuhe6pvmqtkb3ruywgsvwc3hh4hu27c454an4avme6xxfrls4@fwoathup2su4>
 <20250624124527.656d567c@fedora> <20250627140259.3f88db17@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627140259.3f88db17@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

  Hi,

> As you've said in comment
> https://bugzilla.redhat.com/show_bug.cgi?id=1322713#c6
> it's strange that patch causes issues at all, especially with
> '-smp 1' as in reproducer.
> 
> Also repeated with -smp x>1, it still worked fine.
> 
> Perhaps issue was elsewhere after all.

Yea, looks pretty much like this.  Guess we do not need the
'make only read access lockless' part then.

take care,
  Gerd


