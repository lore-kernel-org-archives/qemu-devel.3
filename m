Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B4DC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wghvl-0002Ws-Rh; Mon, 06 Jul 2026 07:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wghvf-0002Vv-Oe
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wghvd-0005wo-46
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783338957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lgYVW59/fDsCyALounqfA/qP/ubVHf62vYUx92E9MTY=;
 b=YQofZYOtlcksjTWPpDTfp5lOBNeu6bFAcb/uTB0fzs109YuE0cIMWy/Z04u0r0OoffyxGQ
 uhzj2NfZIDaukQBZGGwPZbiKrosrobP0ynYsJoBeGB75LX3K6t05MjVmjoiKzsb8E7JPdl
 PHHqKllDpd++/8ItNfTj1SSmDG0x6GQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-4J3JW7SHM4-MSmH2TUp1JQ-1; Mon, 06 Jul 2026 07:55:55 -0400
X-MC-Unique: 4J3JW7SHM4-MSmH2TUp1JQ-1
X-Mimecast-MFC-AGG-ID: 4J3JW7SHM4-MSmH2TUp1JQ_1783338954
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493caa3c54eso25572815e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 04:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783338954; x=1783943754; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=lgYVW59/fDsCyALounqfA/qP/ubVHf62vYUx92E9MTY=;
 b=tooZ/JWhy/4LMnqwybIp0cw1R4EyiBZpgHH6fySNElR0anZsAakNUN3fz+FDEp5Ctk
 NF26kIm1lGCm0of+ns9TExM8X6MaFsVq3yAQ9ajQR9u5uDYnroJtZL7wKr8XrY/2OCyQ
 MyXwdqHQKwjOjaBpXL78l496Os4yLP+CRwiNS8oSBa8jt9LddU1qaQftAccsWATieVkx
 fVX0TzKM9RxjQOx8L8KxFgmOMMzL1peV53an8bgtJulyCewrUunA1v8qwp0LIlI5aZFW
 uJf/DkOD/+QIyFaAsGZeMbkFiNqmd7yeBXkAM7CdbSHQD6SwvS9/IV2wJ9PmtH3eGrfx
 JwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783338954; x=1783943754;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lgYVW59/fDsCyALounqfA/qP/ubVHf62vYUx92E9MTY=;
 b=h3MYZxvX6jLwTRGlZmq6iCKEL4dWUsvGuT3XKRc8CJmocCYTQ0o41t+z3sg4SD0VTf
 8MGA4gp3OlMQnXcu5l0aTWGKifn7j0Lq6OJbifgNt/Yjt2JxUYs9MnlvqosHvQgajVJb
 xPeD9X9riCVEK9BEtUeoKrP3YxpmCaUDL+cjShU9IurgM/xEvvnrh0aqpGpLipABNTBL
 oC+irht3biufRN+8xPGwbLu56uphfIFkvw5zqRcv9GsbPZQLDyWFvufMk9PPvM8tiYWy
 xGhSPcHNX7xPFP99jh3W8RJz15nkzYnHUY3HQClZutAH1jCteffc4b1WoxCKSBkkT7FE
 9Tng==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0tHGkYU5e3bt5wP+Uwm2IwJkFYonJ0/sEcRD8/Fq32Kdkq9+HtEzx2QC8+XuR61ZNakLtVl53z3p9@nongnu.org
X-Gm-Message-State: AOJu0YxXObB+7FGcu8dKrj4Bgo4+tgVz4z5Wl7v+64SH3svOF/LIjCSe
 Xded4sdQQK3rv4eqN4hQrq3PzXmrUSgNxWTRy0Gx1PNIH45H+aMk28ZUpZ+uOb5uuniihJlIAWs
 AOhv7gyQis8OGdI8Y5Sp6F/pZCK7635ZNx92BXPVj3cvJ4GfGnKfvxPN1
X-Gm-Gg: AfdE7ckgi+YztfU4q7BdZgKIrvNq61sU4tbEiXIt7Xn6/gAg7uVtLCC+fz9tTLV287p
 F8m1+ckbaoqvAxPvORyx88iopUeY8oJis0aVH6s4JWfH/py4JB0iEcQHFJt1z3UEuS6qNsrZUiK
 PbI9C9rlbluAt1Lw96MwuT8sVrWJJ6uLWQnGn1UJU5zsroU0tEpkouG8HGX3P6+vfCgMhTZDhDr
 JEES61TOyHKUN1Pv534Y0Z/kRzUGDY+fRKruJ1nN0QOqWiC1+LSwTo7TN+ptqfVjPRZ06FFqIfd
 Lwe3xR0A3db3zc4O53CQYk2Memg2i3+d9UM4mrFgo18mdajMg0AbaDGPMyxdB1NEi6vwUyx6Aca
 uQ3sKRNQX5371gUpekHK8YDD3vlFcZxvEN0ZkVNCiRHpcUPrfhD2l8X8a/2vQ
X-Received: by 2002:a05:600c:4708:b0:493:bc4a:d5f5 with SMTP id
 5b1f17b1804b1-493df0885dbmr902635e9.39.1783338953941; 
 Mon, 06 Jul 2026 04:55:53 -0700 (PDT)
X-Received: by 2002:a05:600c:4708:b0:493:bc4a:d5f5 with SMTP id
 5b1f17b1804b1-493df0885dbmr902355e9.39.1783338953586; 
 Mon, 06 Jul 2026 04:55:53 -0700 (PDT)
Received: from rh (p200300f6af371400309b667846b924fb.dip0.t-ipconnect.de.
 [2003:f6:af37:1400:309b:6678:46b9:24fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63ba971sm608724945e9.13.2026.07.06.04.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 04:55:53 -0700 (PDT)
Date: Mon, 6 Jul 2026 13:55:51 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Eric Auger <eauger@redhat.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/3] arm: demuxed ID registers (CCSIDR_EL1)
In-Reply-To: <CAFEAcA_0KOc_4DHioDbXKrAy-R45PEyDg1iS_dz7XgB0=0m9jg@mail.gmail.com>
Message-ID: <45959999-1382-1ea8-355e-d088754f2896@redhat.com>
References: <20260702133606.34529-1-sebott@redhat.com>
 <CAFEAcA_0KOc_4DHioDbXKrAy-R45PEyDg1iS_dz7XgB0=0m9jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Peter,

On Fri, 3 Jul 2026, Peter Maydell wrote:
> On Thu, 2 Jul 2026 at 14:36, Sebastian Ott <sebott@redhat.com> wrote:
>>
>> Handle the demuxed ID register CCSIDR_EL1 as part of the
>> idregs array. V3 of this series was posted here:
>> https://lore.kernel.org/qemu-devel/20260622135627.40573-1-sebott@redhat.com/
>>
>> Changes V3->V4:
>> * added R-B from Eric
>> * incorporated suggestions from Eric
>
> Hi; there's no description in this cover letter of
> what the series is trying to accomplish. Could you
> explain a bit what the motivation is, please?

Sure!

"
To support efforts to generalize handling of writable System ID Registers
[1] this series addresses the demuxed registers that are kept outside of
ARMISARegisters namely CSSELR_EL1.

CSSELR_EL1 is moved within ARMISARegisters and accessors to retrieve
and set the demuxed values are provided. Initial values are gathered via
the usual KVM_GET_ONE_REG ioctl.
"

Thanks,
Sebastian

[1] https://lore.kernel.org/qemu-arm/20260616132625.1732031-1-eric.auger@redhat.com/


