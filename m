Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096C1C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 20:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYtjb-0008VL-QC; Tue, 30 Jul 2024 16:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYtjW-0008UQ-30
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 16:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYtjR-0007U7-I6
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 16:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722372363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6y1lSwXYkCKOrANSRMSIBcpwB1bECugWyhG3TV+rt4=;
 b=i+fuT/1d15HtX8kRjGUCGx5SQZgpLvt8cthTVaKdM0ILCln+ljDVw3Gxsw47THHBTCqTb0
 gQgEH7hBFivVlAlF+w+NZMrYJrD/Gje1crw9R+wPSAmmf7AZK2xw72O8nSJERG9QrjVkYO
 36cEqiKAO92OwFjhEZWn5q0JJIieMAQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-BmbTbMeLNRGiC2cGrcF6kw-1; Tue, 30 Jul 2024 16:46:01 -0400
X-MC-Unique: BmbTbMeLNRGiC2cGrcF6kw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7a8281dba5so390521366b.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 13:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722372360; x=1722977160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6y1lSwXYkCKOrANSRMSIBcpwB1bECugWyhG3TV+rt4=;
 b=rAaJSU8YrDs6yBn31wY/CFLnas7Ptu+QYkXlzbX/KZdmpRup7VyNCuEbCKeTJm9Ruf
 7XYi15OhcXjZL8MGEBJAwyXlDPjssX3b2bLdbfIb7O67axvcmh8NVQFLgTInBWG6xADf
 c93ywE4EuRVhRizu+r72YKM2PDbe7YW9mzIf8UjSTPNYQOHdVtsx3QYFbNX+lPt2dzZw
 8ZiliVdeG+WUpZv5kX+yVg+bApttzSouHxNrHYbyUECjJgFTpgTdPwVQ4VulgMUZbLS8
 4cgcMXopvriNJ5NHEgu6KDKGrxirmGQwzkeQy2YJDQEbkd2HJScYrSzMektF0ECy8pzf
 gTlA==
X-Gm-Message-State: AOJu0Yw2ZQ7pEANtoruB9FEm9cET4tT2ZUVOCewERkBTkv+oLBHIc/yY
 UaZnNHHCFD2p2akfSaCoBmvtnQ9fksgyCjKa1+1wFLEBiVjXUP1ziWFM9oM5WwwA4pa9ENBlYb4
 4/mmJ4Hde5xhXC0JgcmeydjmjqKf2gBcaU6jgIoLY0lBwRpW3lEqp
X-Received: by 2002:a17:907:c00f:b0:a77:c827:2cb2 with SMTP id
 a640c23a62f3a-a7d40138f7emr547686966b.44.1722372360589; 
 Tue, 30 Jul 2024 13:46:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaVREwSiJvASaLwyvBOSza909PptwLqrsLsvRt+byv+WW+KgGFt7STCGb4dsaje1pVOiGW+A==
X-Received: by 2002:a17:907:c00f:b0:a77:c827:2cb2 with SMTP id
 a640c23a62f3a-a7d40138f7emr547684466b.44.1722372359789; 
 Tue, 30 Jul 2024 13:45:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:d5c3:625c:d5f0:e5f4:6579])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7d9043ca41sm79301566b.72.2024.07.30.13.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 13:45:58 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:45:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Subject: Re: [PATCH v2] hw/acpi: Add vmclock device
Message-ID: <20240730164434-mutt-send-email-mst@kernel.org>
References: <bc85aba60523e0d63e760d5143c5cb57688779d1.camel@infradead.org>
 <20240730135143-mutt-send-email-mst@kernel.org>
 <546A904C-FEEB-4365-B7AA-CA4E3D03300C@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546A904C-FEEB-4365-B7AA-CA4E3D03300C@infradead.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 08:04:17PM +0100, David Woodhouse wrote:
> On 30 July 2024 18:53:18 BST, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >We don't want to manually sync headers with Linux.
> 
> Indeed. I was briefly tempted to fake it, but figured it might get lost if we subsequently do run the script to automatically merge from Linux, before the guest driver is merged there.
> 
> >I think Linux abi should live under uapi. When it is there, we can use
> >./scripts/update-linux-headers.sh machinery to import it.
> 
> This isn't just Linux ABI. It's intended as hypervisor to guest ABI too. In the fullness of time I'm hoping it'll actually be a virtio header. In the meantime, best not to overthink it. It's fine in hw/acpi alongside the device itself for now, I think.

This is exactly the same as e.g. virtio. We use Linux as a source of truth, it's
easier to share with other hypervisors this way. And UAPI and hypervisor
ABI requirements wrt stability are mostly the same. It works.

-- 
MST


