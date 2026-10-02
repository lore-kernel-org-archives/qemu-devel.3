Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D983ECA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCaPq-0006A4-Dj; Fri, 02 Oct 2026 06:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xCaPo-00069H-J5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xCaPm-0003l6-Ij
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790936572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vzCGSbOPHwGPcue7zOnS4TZOOV71o7lrVJu+YeHWZnA=;
 b=ECkavjLcGdsonzOUKQUd4VuWjM+9/Pb4HpaOLlh6n0NjQRUSFLf0YclBB6Vkx9Gf9FNNJC
 EFHu68LX/Q3pyUEXAM5CdKeABrVldRTzlMVnScMjHAt2ExHBiprEFqO0s3P3WzRrrnIUos
 1EC9Qixi51EOde/qhV3wuUCRnVPTXRs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-MP0wZIieNyOW3twHxcEHBQ-1; Fri, 02 Oct 2026 06:22:49 -0400
X-MC-Unique: MP0wZIieNyOW3twHxcEHBQ-1
X-Mimecast-MFC-AGG-ID: MP0wZIieNyOW3twHxcEHBQ_1790936568
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48b01a74792so2000725f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 03:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790936568; x=1791541368; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:cc:autocrypt
 :from:content-language:references:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vzCGSbOPHwGPcue7zOnS4TZOOV71o7lrVJu+YeHWZnA=;
 b=n0fULK3k/xKc2O/wATEnO1JF5G0hwu9AUjpIFp9qqqDRWpLhotKov3xeScF8WtEFQe
 K/C7/5T7JtY6J79MO8tGdaVPSdafaRe3EVxOdpjOget9YEBgXp2U+6jy77C7g/gM/NKP
 Pb3aT2nB8UFfifNVw8Z43t/vtkCxt2LOxQteTgIOqX6FI9mz6Ug68zreq9wjuKuWrBZb
 byStmuriB6lcjXrAv1yYm8bTicRxE8n/7dPa2QeAapKB7e8PIAQ9duxoG2IGPaoZg5cC
 VnBmip7oJYLurhP892UQnlma01/P+sQ+YAz18GnbHgrIfXlcFv2IrHlVeuqUJQzaFISX
 djcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790936568; x=1791541368;
 h=content-transfer-encoding:content-type:in-reply-to:cc:autocrypt
 :from:content-language:references:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vzCGSbOPHwGPcue7zOnS4TZOOV71o7lrVJu+YeHWZnA=;
 b=Q+S1Z52arqAazB1Mz3psM0F3BO883tiJlQTFUwR9HJcplc5kQuKKE/LH2GrwvQGqmy
 05hYBTdJcHJWgNVywF3gaLV8gkx3bXpA/Ipsdv/zBzXktyjD8NjWlNLtnW1x8EH6392V
 03kQcV3nQcRxsJgjYcO93ajbA85/5KI8J4UdaoS1svzTui7qCmgFTAeg+o1SFNeP+Gda
 PBw6WGCLxxh3sUzI+CeZ6A7GgOZCMGVFyL+gFtwIsBx0b0/7/V9duQ5l1xVqi5F4cxj3
 ppS0OcobE3/hOepyj1OFvjFn7ehkMQVmq+DSWV7aszArvBZEXODAN96wKCU0CeP0c4j7
 RVyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3yeQOy4oaxRyZZxAbIbFIG+xxX50P+GAk6iLm2lKZ3EaPJtjnrPwAZrYUXZikyvvbINYrR9dUe6R0@nongnu.org
X-Gm-Message-State: AFq9FYKjDpTi4utyxYRGOa/yEySSXoLIC0qjQHzyYm/Os2XZdYCkNhvo
 4TC8X4skLIZSn1FgX5U9c46kG3uxOZyV1/hy+m0+1i9RP/VctVHOLWuv869mesBu86Y4rlLVEcZ
 ck1tOerVSOUb3WoemxWdUCXRHGvIC1CPxcFaX7PGRY9KG5OJWFrSP9H/+
X-Gm-Gg: AYBFou1SlVt6owKRV46wBU5+3D49d/lleRvHrM6fIQkfvLvHORPcrcoAyYcljaqyMCR
 Q6f3zL5u7ec87lww8BEgtj7HtV/12zLUmxyLbLYa6I8cKh8kVaCOAmKCx7+CmWQe4yKIq9kJVnp
 HiCCcXmliJxpuehHdXaf44FCaqcWxdtoTHPBdndwlwx7kQV0Y2lVpzQUGOlTPV2Api2iaBMcyOr
 tdgii0FZV96AsDrO04WcK+ZKUk4JWil9WM7wLtbn6HUSfefb3aJzcFCN9qdCMnOjnooRUQSOAFv
 7ZqHg1XLPJR2ql9tUAJYsEDFMlAwO9sd5PtTd7vC7PzYbaaURYN6DD5sSp8kiZLfRxDbH5rk
X-Received: by 2002:adf:f98a:0:b0:48b:26b:7f8b with SMTP id
 ffacd0b85a97d-48b12755b99mr3018484f8f.57.1790936568381; 
 Fri, 02 Oct 2026 03:22:48 -0700 (PDT)
X-Received: by 2002:adf:f98a:0:b0:48b:26b:7f8b with SMTP id
 ffacd0b85a97d-48b12755b99mr3018458f8f.57.1790936567947; 
 Fri, 02 Oct 2026 03:22:47 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b82253e8dsm4099872f8f.4.2026.10.02.03.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 03:22:45 -0700 (PDT)
Message-ID: <a3dd935a-0e15-411f-837b-3cfdc1c5bf63@redhat.com>
Date: Fri, 2 Oct 2026 12:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fail iso packets sent to non-iso
 endpoints and vice-versa
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20261001194756.3003085-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
Cc: "Daniel P. Berrange" <berrange@redhat.com>
In-Reply-To: <20261001194756.3003085-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01/10/2026 21.47, Peter Maydell wrote:
> The OHCI USB controller requires software to set up an Endpoint
> Descriptor data structure.  This specifies (among other things) both
> an EndpointNumber telling the controller which USB endpoint to talk
> to, and a Format (F) bit which is 1 for Isochronous transfers and 0
> for General transfers.
> 
> The specification requires that software matches the F bit with the
> endpoint it's setting up the descriptor for, so that Control, Bulk
> and Interrupt endpoints use F=0, and Isochronous endpoints use F=1.
> It doesn't require the controller to check whether software gets this
> right.
> 
> The spec isn't totally clear about what happens if software creates
> an ED with a mismatch, but I believe that the controller just trusts
> the F bit, and tries to talk to the endpoint with the wrong sequence
> of USB tokens (notably, isochronous transactions have no handshaking
> and the others do). This probably results in the transfer failing.
> 
> In hcd-ehci.c we check for the "iso transfer to non-iso endpoint" and
> make it fail, but we don't do this in hcd-ohci.c.  The result is that
> a guest that deliberately sets up this situation can cause us to hit
> the assertion added in commit 7b1eba96aeca, where the endpoint is not
> isochronous and returns USB_RET_ASYNC to an iso TD handling function
> that isn't prepared to deal with that.
> 
> Add checks for both "iso transfer to non-iso endpoint" and "non-iso
> transfer to iso endpoint" and make those TDs fail rather than blindly
> sending them to the endpoint.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3729
Looks like this issue got assigned with a CVE number, so please add:

CVE: CVE-2026-7180

With that:
Reviewed-by: Thomas Huth <thuth@redhat.com>


