Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEABCD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 12:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR8AX-0005vZ-7l; Sun, 24 May 2026 08:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR8AN-0005ua-Co
 for qemu-devel@nongnu.org; Sun, 24 May 2026 08:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR8AK-0007Nl-4A
 for qemu-devel@nongnu.org; Sun, 24 May 2026 08:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779626566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=z6hslnT7ov6HN+YTdPziUOB64cJrlsczhCk2igAstqY=;
 b=MXMFAEvzqh/Obwyk4RuAZesclLrbOEG4x+JxknxEaG6ayhBRIAB3PrlSWNd76Ua57fEd7p
 doYNziPUg+Kko5tt+p6YgUyBRaJ37DDdEZcvW7//ehlhHhYAF0U3eIiN7vy09GSRCet/kl
 3O1JstGg+pqP+HoUGTda0UujZjs93M0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-CsOx0VeIO3yUWNsZHE6HRQ-1; Sun, 24 May 2026 08:42:44 -0400
X-MC-Unique: CsOx0VeIO3yUWNsZHE6HRQ-1
X-Mimecast-MFC-AGG-ID: CsOx0VeIO3yUWNsZHE6HRQ_1779626563
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44b186b715aso5537548f8f.0
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 05:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779626563; x=1780231363; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z6hslnT7ov6HN+YTdPziUOB64cJrlsczhCk2igAstqY=;
 b=CsysZoCXi4Xsw6lPS2kRy94K8WEetNZXCjzBylLYNjvQkBBkD9n4vIPekaL+yv14SD
 j/6H/Pd6pJLUXHDPPrUNaoBWtMElLP0PqYTwqB/iVDw+eGDi3jxkP+D2lns2+E0qhddH
 cKdSM/yI29ZG2nQ/rVgLpxgQxPog4ZJXux8hK0+Ko4hlA208WzuUg7SARnX7mKJu6Nrn
 yABIHwQuyLT/ifyT6/yBmNaCUJUru7ISFScDqBrrYuZ78Pwr0lCnZPMYRPd6vD0qPLXF
 2ZuhfLFy9OedfplKhj1O5GCy57y0smxNPMJkWLIQyBSM1GI4VJ0a5Yf2mfjQm7hHzuPD
 e3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779626563; x=1780231363;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z6hslnT7ov6HN+YTdPziUOB64cJrlsczhCk2igAstqY=;
 b=BYthHP1Xt59UqAnAzol9ssM6CusRETlRi90RNvSxoVGilyEeJhBTQ5Ih1CRV6jhNzn
 GT17Z30tFq9uh412Y002/eeL2uz5yMYNOH4gqwyo3MkI6gYkd1/X4CmrpQ3MxpBfLegb
 vhOPzWoI07cStX7UMq1GUjLn7d4jsgwm1vwItiN/gTGU7HUg1JbUiDarUau0Ni3DNcJJ
 9/CY7XpAcjU/PVz26+hBWcGYXom+gM4XF+WXm1hf5tvwgiCOPv3QIu+RfKPhS80ekaHB
 /0Q8BdMIY4PV1L9ti68jhDEpj3V25j1rOsvaXGy9T+RxQS/dCJEqINL5+Vkoh3+D1gA3
 DTiw==
X-Gm-Message-State: AOJu0YwOnk8emhG4nvUUD9gy6eytWRJe0mQzb1BpTzy0rMke9WDct79w
 HzHLDGIo/CaV4TJ3I8oghALxEs6l4g+4nZVNgn46aj8mLVxOIEVtu4ZIvk3xoF/IWfwFRkRv2jc
 qDyELXC4+x/YuK1jIK6RY4pgg6erk7I/TDqo5zfLU8yDWpFP9eYH9kRJcG4hwWw8TxQUPDnMYaE
 2RRGlYvFi889q1yQu3a+cK4AFQg57G6njIrg==
X-Gm-Gg: Acq92OFtX8Q/NyZeF0lF9En9QlvIsMUET2qCrYG3Xkly5U2PSpnX0WNU6JAgy+PnVp/
 xYK1UhCGI7MO3Vv6xHCZejXlY8pnxohKwHFNsOL4Pb9EerIY9ZY4/bKg7F191dLVVOc4KJn86gu
 lDF0ds4UD66Cblem9uHrifNW97kSXxKLmlgn/b10huKyvqAAMNCDS1N4+CVqtTDoYVXscAZR7wb
 EjrtMNsa8njdSuOuFse9yZS3yRka5BzicxlGPg0LWIgSCOtQURex+czriwodk69e72Znjm0+WXi
 A4pQ3TS7wrPk+ljhkSLNcmSQtPWcPYSv2HnpDYa/dG7Qen0JPPSOpAPjCkLL07KnEgNn2Wy6mgd
 8vPQVmxwGZdQphsJp8hTwlRaZ4dNB1wwUaQ7z2lPb8m0=
X-Received: by 2002:a05:600c:4ecb:b0:490:44eb:c1e9 with SMTP id
 5b1f17b1804b1-49044ebc303mr169572565e9.26.1779626563121; 
 Sun, 24 May 2026 05:42:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecb:b0:490:44eb:c1e9 with SMTP id
 5b1f17b1804b1-49044ebc303mr169572105e9.26.1779626562516; 
 Sun, 24 May 2026 05:42:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49041781fc4sm88863365e9.1.2026.05.24.05.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 05:42:42 -0700 (PDT)
Date: Sun, 24 May 2026 08:42:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: on ai generated and code provenance
Message-ID: <20260524083329-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

So, I had to reject a perfectly reasonable patch:
https://lore.kernel.org/qemu-devel/20260320193746.242704-1-jinpu.wang@ionos.com/
just because of a tool used to make it.


	How contributors could comply with DCO terms (b) or (c) for the output of AI
	content generators commonly available today is unclear.  The QEMU project is
	not willing or able to accept the legal risks of non-compliance.


But, since this was written, Red Hat's Richard Fontana and Chris Wright
published this piece:
https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues


Saying, in particular "
	We understand this concern, but the DCO has never
	been interpreted to require that every line of a contribution must be
	the personal creative expression of the contributor or another human
	developer. 
"

I propose adopting linux's rules instead:
https://docs.kernel.org/process/coding-assistants.html

which boils down to attribution.


-- 
MST


