Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F34CCA471
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4KXR-0001To-Pw; Thu, 02 Oct 2025 10:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4KXN-0001Rx-2d
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4KX6-0003u1-AR
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759416217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9rrcUC+gzDyEMjCtBSzxmOK2Xsj8RXVs22FZMi4vvac=;
 b=jWjQ9Aj64ojOrIBFOPvuPkwsxq20uJ/dviAfkL6baPPKcYRyoj+EuDXJiIb7L7CSPBYvNe
 m2U4TXsLs41jAb7q4seRNTmLnIVTWGDhE/P9Qq1mJ2idh23dU0fYJNvoa7GJ9T8eMyxAuc
 gDJBgmbGO+ndg7ogBqRxA56tcuBL4I4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-TSg_DLwOOXOv2SLOqjNc1Q-1; Thu, 02 Oct 2025 10:43:34 -0400
X-MC-Unique: TSg_DLwOOXOv2SLOqjNc1Q-1
X-Mimecast-MFC-AGG-ID: TSg_DLwOOXOv2SLOqjNc1Q_1759416214
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-872d2ad9572so247346885a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 07:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759416214; x=1760021014;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9rrcUC+gzDyEMjCtBSzxmOK2Xsj8RXVs22FZMi4vvac=;
 b=GhuaBm5oSSrrGfRZQvdSv7XXdEBJ52qJg56n3YPsqrOUrBSJRmjRWw2JGj3NYx/qg6
 JhLiIA29R9kfWKp83h6ySdnCpKWDoPvZXzTjcEp54KZo9n+nqLY/2sigtkPy0nAR4uoy
 vubG9fKPSrFg0Cu4pbdNSqeF4dDf6dnSeljDAzU1If+ji8jr652gtq9gJvyat/jwblUc
 oGAcjRgOuohgClsi4dQiLjIvjV+ZvurC+yuMlzWJQTzrMP7J5KTTtIIkVK/NMw4T5de6
 zy9KYf8mEKSIaBGD44H0P3302ksZrg43FSGG4uhwoVTRmmvOuzm3KcoPR4J9PyI4uBdh
 OMWg==
X-Gm-Message-State: AOJu0Yyp13mLxNOyAwOTzer+D7zSvBo0lB9mjXSnNAdeiO9hkNS0Jgux
 nxqIyUXDwKAFGG3XDhsdr0Bd7Q1445/sDUg+/Egy38aqKYLhAeQCefj9vJQuFsEU6KimT/FyUEY
 avT7L/qsWZccq6YTGwIZCNa5Tv72DFMlBr/tpNxYDtoDIp/QEoEV027bq
X-Gm-Gg: ASbGnctKySsa0+m8x+uSzzQ4PW4ILUwaEZKhIe1+/kraN8/PbqBtpbsYFinIigEkJFN
 KdY8ltALvIM0O1455EFjwU+xksHmAKTplkiwMkqxdHq17wK4BSY8CGKk5eikbqlUYXPtp6Lv5GH
 LmnWGi4pvwLbB2eatJAB7WS7qZBBu50SaXr2hZisPEWCw2PokfxbFfUleeHYIUY2ZUatJ6BC8gb
 syGCOOBtRul36qzW2CbMKoN3uWumkk4bm3ncX0dYjqM5hMB/jn/j+l3l7IfZRlsYtRQ3AkpFzig
 pXHuQ6ARiFnniLgegIgoy7RzXSf3vdD4qsy/AQ==
X-Received: by 2002:a05:620a:1910:b0:853:20b1:cf12 with SMTP id
 af79cd13be357-873768a536emr1089056485a.65.1759416214200; 
 Thu, 02 Oct 2025 07:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYhhy9AiOFVdgEwVsdNu041FmEbs4JKWJfK2nsAoYrsrPMBghvMcNluzdipR5aoQkuErP90Q==
X-Received: by 2002:a05:620a:1910:b0:853:20b1:cf12 with SMTP id
 af79cd13be357-873768a536emr1089052185a.65.1759416213751; 
 Thu, 02 Oct 2025 07:43:33 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e55a84a055sm22561111cf.15.2025.10.02.07.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 07:43:33 -0700 (PDT)
Date: Thu, 2 Oct 2025 10:43:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 0/5] system/ramblock: Sanitize header
Message-ID: <aN6Pkeu_tb5giiPc@x1.local>
References: <20251002032812.26069-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251002032812.26069-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, Oct 02, 2025 at 05:28:07AM +0200, Philippe Mathieu-Daudé wrote:
> (series fully reviewed, I plan to merge via my tree)
> 
> Usual API cleanups, here focusing on RAMBlock API:
> move few prototypes out of "exec/cpu-common.h" and
> "system/ram_addr.h" to "system/ramblock.h".

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


