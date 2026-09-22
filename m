Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14D4C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 11:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8yfa-0004QE-U5; Tue, 22 Sep 2026 07:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x8yfZ-0004Pz-Iy
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 07:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x8yfX-0000d8-Fy
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 07:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790076493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oIpn3pgAhAa05j2aGcSKU/KqcD+0fYLRZnpTgTHFaRw=;
 b=gVVDVgTtJAa2D8rIYUuBcBwYifYT8o73yEp9rm1oYTKqx61kCYuVnJ3gSn0eF+LL9RsboV
 +yHIIFPzNMRr878VqYudjMCxt31ou7u46XPGpL9EZ8QHY1zud0OVo0LDIMa2D3Ve123N3E
 LpLEZQDYbjvV3kI8rWQo9hoqtE8KyVk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-zZan9_H9MzC2tI6CucTJ_g-1; Tue, 22 Sep 2026 07:28:12 -0400
X-MC-Unique: zZan9_H9MzC2tI6CucTJ_g-1
X-Mimecast-MFC-AGG-ID: zZan9_H9MzC2tI6CucTJ_g_1790076491
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-486f768517dso2855870f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790076491; x=1790681291; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oIpn3pgAhAa05j2aGcSKU/KqcD+0fYLRZnpTgTHFaRw=;
 b=Emw7fDYwxhrKCCNUBvi96GMyfISwr8sro845VQalVQx1bXlQMghCA07C/6ArKaPtgZ
 PIyyHWhZfxknHrK/sRsQLUIw+HO7gTZs0FkUmvmyJWuTtNf3q0MkTsWn9VWJmi8IZcxu
 FbMOp43Azm2Lb7Uh9hLf21HVunFOTLECEMjuxil5BRCn3H2p1cd/RZMof6bqu300pXT7
 DUwQ9MWtVdG0VFbDiGl8GgD2vzzq/PCeoU8EGxJumDs8Cws0eNPnx3Brf5r3QaOm/4/0
 vNnN1pOGoQOisYtNjBdaJAGQetckqOoPEeO89v24JielSnni+l3+WXcYvHjpBfXSSwmX
 51wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790076491; x=1790681291;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oIpn3pgAhAa05j2aGcSKU/KqcD+0fYLRZnpTgTHFaRw=;
 b=KBpwLz04loied49qFepLm0E3IK4cvbrQSagUguJctqG7Nu97XCQOvrgBQUb5P1SEW1
 DHtQchlWKw4wHpwQks/rWghYSQOpYH21L1U9IF56qzxffT0MCFTFYbTrJNTuCoB11bx0
 dAQBOa+JcWUmpd2bmVliClaiRus2iyu3/+KMD7fPlDj4GvNGVKwtaFzW8iqUdTtCQ1PM
 RW51E3iXaix/P4EKVJ0fuDCt4KNIApVWZIe/ZIFMViOHagr8JDnsErTHchH4njGZKuS/
 R6HLWeDGRDnmkvKmaWdetkjCOC5JlLfz+eO/rOkyLOOe25/YBqBvey7LwKzkH04Zf2Bq
 Rh2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpnbq+8EofjotEQGHgCF5OXRI+u5artiYGo4BS7tMQJb9T9RHfyBuFhK8/hkiv1N8Os+aNAICT1jE1@nongnu.org
X-Gm-Message-State: AFuF++k5Tn3HYlbTCkQ7zP/t2hNjRlpnw6APXs8mlEyVLYofLvq9cgt7
 6xnWMzPoasQqp94yQiL/DE4x03ond9R7grUZ1uc4kmD+U5pvN/oFiCqxJKomSoTk2XWPDR7gwWC
 SdHmXfxAlz6NwWMIuAJI1A5K+fjBwE3/xKLRPeaqinM3Ry55A7F1EoMEj
X-Gm-Gg: AYBFou1LYjdhRzNpmFYlWWsVBiyXfKSDcd6lFa3CWdJUaRF3fwzKQgR+NLfLdPFVU4A
 /3DTVObyYq5BX2TbLQB/mX3oDRnfjh9Jt7OISWMWRn7n2SKrpWExGWnGsRPl/xFvdBTqo6rh0Pz
 OYzd2bJQshMpPuiH/sKBd9T7B9ifC5wZDM7tpg7/ZUCYZGU1sWsNw1S3UO+18ljDFTIz0wz4DQU
 feIDqsgU4tSEq0onqqCAduXAsoLpAT8yZ9d+pyzh6EdLOH5PgHRx4IicgLnlBow6stcQJIrZTdL
 jePf0dNmAjb/4u4qHrQuWBsv7Dlw8r7H61Anehffh0hwgOmywEwoPVt01K2+NVtW+s+WpiZx
X-Received: by 2002:a05:6000:2010:b0:487:27f9:82b with SMTP id
 ffacd0b85a97d-48727f90b71mr14216585f8f.32.1790076490871; 
 Tue, 22 Sep 2026 04:28:10 -0700 (PDT)
X-Received: by 2002:a05:6000:2010:b0:487:27f9:82b with SMTP id
 ffacd0b85a97d-48727f90b71mr14216560f8f.32.1790076490523; 
 Tue, 22 Sep 2026 04:28:10 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886277406bsm4609853f8f.12.2026.09.22.04.28.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 04:28:09 -0700 (PDT)
Message-ID: <ed2c9aa8-1a62-42f6-9694-f6e998b490df@redhat.com>
Date: Tue, 22 Sep 2026 13:28:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/usb/hcd-xhci: don't assert on NAK when retrying an
 isoch transfer
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Feifan Qian <bea1e@proton.me>, qemu-stable@nongnu.org
References: <cover.1789968699.git.junjie.cao@intel.com>
 <44227b05b22064a22f4c135e025ff0b1d838b9e3.1789968699.git.junjie.cao@intel.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <44227b05b22064a22f4c135e025ff0b1d838b9e3.1789968699.git.junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 21/09/2026 07.46, Junjie Cao wrote:
> The endpoint type in the xHCI endpoint context comes from the guest and
> is not checked against the device. A guest can configure the interrupt
> IN endpoint of usb-kbd as Isoch IN. The idle HID endpoint NAKs, and as
> soon as the transfer goes through the retry path in xhci_kick_epctx()
> it hits
> 
>    assert(xfer->packet.status != USB_RET_NAK);
> 
> No device model NAKs on an isoch endpoint, so this only triggers with a
> mismatched endpoint type.
> 
> The two retry branches differ only in what they do on NAK: the isoch one
> asserts, the other keeps the transfer pending. Merge them.
> 
> Fixes: 3d1396842d ("xhci: iso xfer support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3886
> Reported-by: Feifan Qian <bea1e@proton.me>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/usb/hcd-xhci.c | 27 ++++++++-------------------
>   1 file changed, 8 insertions(+), 19 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


