Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9462FC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3VaT-0006Ma-1l; Mon, 07 Sep 2026 05:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x3VaR-0006Ll-AA
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 05:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x3VaP-00024y-R8
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 05:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788773061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MTr5UwxO4Cqc3fOb8vc8m9tnhH1jpx4Go/BW6KFEozs=;
 b=QLXXdyU39PZmQmCiQR6KWEW3LsEOWwqiqCYu77+YdIxdch1y22gF8C+FC4U1skZkqNIgKq
 EyoKDkA93R6B+6FgEzOs0thuGwO9TAvWRYspUxn761r3IN8p5q7tNx4dy9bYXPGvXOgkeM
 /yRZ1fwoDqtuYzL/UCELDWspn8bylAQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-lC2i9B0bO0eDQsOQ4PmeyA-1; Mon, 07 Sep 2026 05:24:19 -0400
X-MC-Unique: lC2i9B0bO0eDQsOQ4PmeyA-1
X-Mimecast-MFC-AGG-ID: lC2i9B0bO0eDQsOQ4PmeyA_1788773058
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48439ef42d8so2731064f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 02:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788773058; x=1789377858; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MTr5UwxO4Cqc3fOb8vc8m9tnhH1jpx4Go/BW6KFEozs=;
 b=o0cH/JMea+49B5YmadPl3SXiTsLi9VPhuuHLGwPYVqlxJhxNdX+g/G0jqjniA8W5Rn
 Y05BGKEs+rmsaGFV91SR2krTu4MnhKWxD9Xb7WDIWhmvNBBkDbmHjJhX4x6OfuYlCEvd
 zGKaThev2+1G4hEeb7715J1amhMAwJ2j0JdDRI+v231+RSmjdgHaTtstVarwc23664wG
 ATbvRkRv8c9ieGW+soL4Nembk3JicRVTbMP1kqTqKn9AzDNoGhOrOBAspkij10GC6m3C
 ATpqknorXAXiZofX2SFvQogKIDX7GMoWpkpSiUwBcZwcHd20XUZbBX/U4zxb+iIQo6Cu
 EkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788773058; x=1789377858;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MTr5UwxO4Cqc3fOb8vc8m9tnhH1jpx4Go/BW6KFEozs=;
 b=CYp8p6btMfTHgY0BCYALvYsvjZn88UW+vmO9yNeOjgkeSGOWBR3tBkJTQQ1AjKXqDn
 8W1wXVpLsW9QFa2jAxBhL60CLhJ1sOFnNdpZawX2170PPf5N0sAIos/C3/BWRarBPMoF
 I4tdpZSIMRphu1nIF8qq3ajI72ztZS0h/jLuf78tnVd15EbNUM9bTbBbjGtpgbFTLb9O
 /g3VXKPobIYBsfDGRzCgSCFgz9RLYsjktFsZJoFM1F6truPNwP7JpzKGFnYpkGkAdkHA
 vNS/F+YQuAVq7ckZjM0ABK6lLUMo5r4da+7ucn6E9vjDOPB7KH8uhfBj1feqj43rYzaG
 ybGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzd0194NSOHmVyc0gB4s33B90qJWcI68g1HkrJzcokEJQX2q9jskA6JlaETPEM4vwTN/7IE5SS23mUZ@nongnu.org
X-Gm-Message-State: AFuF++lH0M5XXDzLdYwaRAV1lWYWtxNz4Mj91u9mbRpIx4UlQpGkAm4C
 /QNxwMw4esx1QghnyZ+HYng6aRnXXIsU//wweskRpIJCbRD5O2lJDepDuAGpMDcX8BHHTKh8qkN
 gJGtHBFx825WooK9etasJloPRy5MG9rlri3d2GuCRbZ5xNLEKqxnB0yak
X-Gm-Gg: AYBFou3eaD0Ob625tcJ0k8D5bRNiI9eT3pJAOkpayaAQ31HWCAWETcvoAOGwuO7OQDj
 wSVEWA5yOuJ8DrxYDIT48Ho2bsy47j19laNznyR2XPxEpyk3IHoxL4jEW0B2D992OKfFWUL7sf2
 Enk8LPJu5ReLix5oSQZ7/27oIH9fMasydBT959TlwlhNu4JtUMas3gybaZw9mzvB19QClSKko+k
 /67UTZ+niYcbi+Orb9kC7WWKAn0fNjA5nB5lnsOWClT1IMoiCwfj/b1ZBzasRA02swNnCw/HIfR
 eve/LUf0W4G/j249N3GR+Dfm0Pon76wJiyDpTEik2zknFoqoCXs6Fs8cfrP3+I3VazNw2wEqLTi
 y/YoGmzQGjuBSJFhScoz4B2Y=
X-Received: by 2002:a05:600c:3511:b0:49c:fa21:1c86 with SMTP id
 5b1f17b1804b1-49cfa211cd7mr201179115e9.27.1788773058410; 
 Mon, 07 Sep 2026 02:24:18 -0700 (PDT)
X-Received: by 2002:a05:600c:3511:b0:49c:fa21:1c86 with SMTP id
 5b1f17b1804b1-49cfa211cd7mr201178565e9.27.1788773057905; 
 Mon, 07 Sep 2026 02:24:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm402779555e9.5.2026.09.07.02.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 02:24:17 -0700 (PDT)
Date: Mon, 7 Sep 2026 05:24:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
Subject: Re: [PATCH v1 3/7] hw/pci: Add the ASPEED VGA device id
Message-ID: <20260907052308-mutt-send-email-mst@kernel.org>
References: <20260907092004.2590015-1-jamin_lin@aspeedtech.com>
 <20260907092004.2590015-4-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907092004.2590015-4-jamin_lin@aspeedtech.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 07, 2026 at 09:20:08AM +0000, Jamin Lin wrote:
> The ASPEED vendor id is already listed. Add 0x2000, the device id the
> display controller of the ASPEED BMC SoCs reports, so that the model
> added by the next patch can use it.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  include/hw/pci/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 16034aaa2c..e16d93dd13 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -292,5 +292,6 @@
>  #define PCI_VENDOR_ID_NVIDIA             0x10de
>  
>  #define PCI_VENDOR_ID_ASPEED             0x1A03
> +#define PCI_DEVICE_ID_ASPEED_VGA         0x2000
>  
>  #endif

you do not really need it, it should only be used
in one place. open-code the dev id in the implementation.
subsystem id will be copied automatically if not set.

> -- 
> 2.53.0
> 


