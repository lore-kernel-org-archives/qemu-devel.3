Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D13CAC58D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqb7C-0006VO-AG; Tue, 17 Sep 2024 12:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqb7A-0006Sq-FU
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqb77-0007gb-LC
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726590700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tHqkD0pmjErPIFP65tjTasg+tKIM+VQAdf/Okz1lbbI=;
 b=IOUOQxnt5Udw7HlPBqLM+t9tHNdA5vuIAVhiANCzVsAoldcU+2DBYChnJ7BCo53NtYU75m
 lN5so+uRsQ7PL8+aBlBK+44/pH89s5pr23DyQnqO3Fu1stJNoLt0Ze4vU0DVvxtaE686xv
 ZD//PxfaO+MMoFMXfdAy7SIQjF05Kuw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-E5Y_amSuPT62JW6aBBESqw-1; Tue, 17 Sep 2024 12:31:39 -0400
X-MC-Unique: E5Y_amSuPT62JW6aBBESqw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a66b52c944so1290904585a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 09:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726590699; x=1727195499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHqkD0pmjErPIFP65tjTasg+tKIM+VQAdf/Okz1lbbI=;
 b=p/BqgIERfUqcjcKCLEuP4yurs3hSk164mELybCVRj4q9sdl9FBh//0W8zl1+X/KNUb
 DNBdr5ZslaebZVgkisUZVrDtKbJ7R4CbyVWqmdBcLaJ9eNUx35IFtieWj6GVdG3EJqeX
 cTLNVmHq9uOHtEN5UPrar9fGe85hM75/GrmnL0xCBU0OejKgVfY5BGlRwblMqWMGPr3Z
 PO1INBt0AgGed6tYQuiD3g8rmjROztaiINlqftySJJhDDcMg4W5OkjhTA4JTaSlEFxJ2
 6QZHK5rSlEXjFgWgFSy8fxsNqUPHcHwwo9odRkisfoj02lAmypvrX++byhwDDuGbRnMH
 p69A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCL4Lia8jTz8BPr/GmU73vKefcagphxS7D08oVTRKSerB71kIbIpTvfONmQUBPuuj5RR3gsJJJ/Y38@nongnu.org
X-Gm-Message-State: AOJu0YzT59W6IavgeucBf4pVraYjcxOqkWLaGuc9KpRkWQxlgf64vwN4
 xwQupk7Q1qPj9VV6Uu4F/+f4PWA6OpTwZCsnvgy5SVpwEFP7HprsrljjzRODo1zPqJm2tB8fiqh
 +00kcNmEZPCunZCfLSL6wZ3gJ/aCPzg9y+qoPzX1Dl3GeP/RmqcuU
X-Received: by 2002:a05:620a:1a0c:b0:7a9:c0c1:4140 with SMTP id
 af79cd13be357-7a9e5ef636amr3119054285a.14.1726590698668; 
 Tue, 17 Sep 2024 09:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvfmL0XyOG0eaPMA0/grEKiKyi13Frv+hd9PH1+GLHt1SUKBoO2kmSic2msn2mrgIb3IsjgA==
X-Received: by 2002:a05:620a:1a0c:b0:7a9:c0c1:4140 with SMTP id
 af79cd13be357-7a9e5ef636amr3119051685a.14.1726590698301; 
 Tue, 17 Sep 2024 09:31:38 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3e95bcaasm372604485a.5.2024.09.17.09.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 09:31:37 -0700 (PDT)
Date: Tue, 17 Sep 2024 12:31:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>, John Snow <jsnow@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
Subject: Re: [PATCH] mac_dbdma: Remove leftover `dma_memory_unmap` calls
Message-ID: <Zumu5x-_jzwI52FD@x1n>
References: <20240916175708.1829059-1-mnissler@rivosinc.com>
 <c7ded7f1-3985-4694-b033-6070911f49dc@ilande.co.uk>
 <CAGNS4TZP2yOCurhWoskzswDvMjmW7xd4Xeg-dCnEuMc7tAJTsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGNS4TZP2yOCurhWoskzswDvMjmW7xd4Xeg-dCnEuMc7tAJTsQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 17, 2024 at 08:25:06AM +0200, Mattias Nissler wrote:
> Mark, thanks for testing and confirming that this doesn't cause any
> obvious breakage.
> 
> For my curiosity, which path should this patch take to get into
> master? Peter, are you going to respin your pull request with this
> included?

The pull has already landed master branch, so there'll be no respin.  And
considering this is a fix from the device side, may make more sense that
the maintainer takes it, which points to John Snow here.

John, would you take it via your tree?

Thanks,

-- 
Peter Xu


