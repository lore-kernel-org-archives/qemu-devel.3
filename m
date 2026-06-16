Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B68CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZW4y-0001Ag-4k; Tue, 16 Jun 2026 11:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZW4w-00019z-Vu
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZW4v-0002IJ-HE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781625112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cFnbQnGTJ2IewXTUH8bk5sEhzZ/zFLPWGs1+B8RGTCY=;
 b=VWRjdEufJvE1iypCvSDHNWLFBVStytT4maMTcQ2eXnqQZ4w/IQJGkQyFvHLPo14r2kkI2w
 vuGM/tKIAyZo/B8xtys8DXpnvbkNLFBoVkKml2N8sadvbV2MCH7kl9fYXbesDHAW5J7CPO
 NbAIR9+ZnuvGnQP3Hpx5mA8x2vunids=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-CPmf3eUKMdOULWy3J82GUw-1; Tue, 16 Jun 2026 11:51:49 -0400
X-MC-Unique: CPmf3eUKMdOULWy3J82GUw-1
X-Mimecast-MFC-AGG-ID: CPmf3eUKMdOULWy3J82GUw_1781625108
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aa607bbfe2so2489545e87.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781625107; x=1782229907; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cFnbQnGTJ2IewXTUH8bk5sEhzZ/zFLPWGs1+B8RGTCY=;
 b=naUHq5kQAt2EWOmmPSYkgaCUWACzzM4ZSoIFeUmXWDyrrB/4XfDwOT/W2SiRu3w51d
 LGfvFlkQEML0ru2DP57GMQZL2e4ry4iygKnIMsm/Cy8B+a9A/qXnmUWHmab0w3gGSjNx
 cRFm/2UWXvjeWmAOUoOuiVOfFFg6mzI3aK9oVbTaUEu+r5n0X7wWuXxyQCWdoZYwpS8F
 J0dGwPysS/i26XNhA0WiQf+uY72JwJZ63el7nqkwjVyNccqtcFVbJBOQuGC2PCj/laSY
 UziGzX8btsoINRXkP0B7S2Cbh6FXhWitJfZlsE2FPIBgH08Udp3FO8wiXm8joihtBmps
 cZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781625107; x=1782229907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFnbQnGTJ2IewXTUH8bk5sEhzZ/zFLPWGs1+B8RGTCY=;
 b=Zhgg32Pnp59LqkfgpisHKOZYk9qDHMW9zikIM6oeIeyMXUAiUXqHkGKus8CYMwIkjX
 BOAkojD9W25AKK6rmorBBug2i7GZukWQMNR5vBNTmdIg/2TAXwxshOhzti58lkdFwJUO
 v5T+5SPFB8Rh99bP6TJU8K8HwTi4l0EWACPOTTBPT3gy7NmIgJlF8NAbNBQVqrO7/fyP
 nrMyT65FKr3WH6K+yYN0T+ksOVVdSh3Ahwz6pGdcEmqiNrlptBuCHwNfdHY0nYrQ5Ri5
 BkLiY1MTjS0W1C/Idi6uIIN/nNWBiWjv127tbihytIPWL64rBQMEwEKH2bwHzYXWacuT
 fzeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ClAMy4xDE9kb1YjDUgi46NKg6P0eGuF7UwO8qiV2XDwQbcMuLZdPnwbbF5nLKiVWmTSDJLFHcCqJg@nongnu.org
X-Gm-Message-State: AOJu0YzKkp/ZNujID0ZxkXbu7warO7ohW736sl+LuMxmk74Asef6xxGE
 0+qL1acDpOaJOLJpU+H6Gl4Q4euFR1ZxXr1DGpdZXAWMeVynXJB4dkuySY9lcTzssf2xrH/1GYC
 XSYpqpzYWBvtxPBYVdS9le76UKOlINgBXS7JPjRWI4EItcMqcvip0maLv
X-Gm-Gg: Acq92OGPJH3gEPq210h+a1ety5upbW8gQ9g1F/U5WQfielptWUYAj92Fp6JpCSSDJyq
 n2O75z7xVvCnSWcjZ31zo0urFBisRnjMTXyAr0nvN3N1REqfSTY4vlt+CtICSB4pwP2u7uS5+Ak
 IKgFlHexnFUcpJGKjXXY7ha4+U/kjkmcB5eOUkMmVijU1t/U94coXnmEBr+FxcBJx9Okymsi2WG
 kMmAyHQEvY2bG3yPC9jzHADzwHMKDFtmDIoYx4rHZnABAeJJueIdm+ivwpL/E0OgfxrR+vFpWCS
 sWdc3iFhaVPbQAS24YikVLkM7X2vc4xnraZeQ8x+sGihyFMTojggwxfwG9dr0cT9KTsTsD9oFnG
 PDQfJUXtN2k22+/H0coc38iNRMVmOOId9pBtWYHQdJs0=
X-Received: by 2002:a05:6512:b95:b0:5ad:2fde:cd8f with SMTP id
 2adb3069b0e04-5ad46fbccb8mr22196e87.2.1781625107355; 
 Tue, 16 Jun 2026 08:51:47 -0700 (PDT)
X-Received: by 2002:a05:6512:b95:b0:5ad:2fde:cd8f with SMTP id
 2adb3069b0e04-5ad46fbccb8mr22185e87.2.1781625106959; 
 Tue, 16 Jun 2026 08:51:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e1b49aasm3607701e87.77.2026.06.16.08.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 08:51:46 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:51:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ding Hui <dinghui@sangfor.com.cn>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260616115004-mutt-send-email-mst@kernel.org>
References: <20260616052552.389021-1-gshan@redhat.com>
 <20260616052552.389021-2-gshan@redhat.com>
 <20260616021153-mutt-send-email-mst@kernel.org>
 <dfc55b58-5f5d-4ac8-a508-b208cf9565fa@redhat.com>
 <20260616054555-mutt-send-email-mst@kernel.org>
 <ecbd8c97-29f4-4e80-af15-ef5c25f2a66b@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecbd8c97-29f4-4e80-af15-ef5c25f2a66b@sangfor.com.cn>
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

On Tue, Jun 16, 2026 at 08:50:27PM +0800, Ding Hui wrote:
> > What is the question, exactly? That's why I made the list of 11 issues.
> > Is that unclear, somehow?  Another reason to include that, maybe.
> > 
> 
> We can take the e1000 issue on aarch64 for example:
> 
> Link: https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn/
> 
> The software allocate ring buffer for hardware to receive packet.
> In normal case, the hardware fill the RX ring descriptor, and with status DD bit=1 (Descriptor Done),
> then the ownership of the ring descriptor is converted to software, after the software consume
> the descriptor, it will write status DD bit=0 and give it back to hardware to refill data.
> 
> pci_dma_write calls memcpy at the underlying level, and on aarch64 with glibc 2.24+,
> the memcpy/memmove implementation uses a branchless sequence that copies
> the same byte three times when count == 1.

Yes this is issue 11:

10. on non-x86 memcpy will do multiple overlapping stores even
for single byte writes. E.g. it does it to avoid extra branches.
This is causing issues in practice.


-- 
MST


