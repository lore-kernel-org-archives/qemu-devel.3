Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30730CCD1B3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 14:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqven-0007ng-0J; Wed, 18 Sep 2024 10:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqvek-0007jr-KK
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqvej-0006TP-04
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726669664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zvElbu+TIiFhSOG33tdgbS1aQc0qDU9Xp9BEsCvh4Ck=;
 b=D66JubictaewA4nbL+NRLWxiKGRIVc+OvBVViRcdj8nq34NNWNTZ/D232uKJR8Q2htRzzu
 LZGJ1d8v8u9eLbQFDQwqSPV52c4tA3eY0Ztaub45W1Z4ZuxseUkAuVas0wWP6iECtD3gUp
 bpSFdupPb5yCn4zAsaSVijmv/OPnTek=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-kXZIUZlLPa-fH9yj65Fw_g-1; Wed, 18 Sep 2024 10:27:42 -0400
X-MC-Unique: kXZIUZlLPa-fH9yj65Fw_g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb08ed3a6so4204505e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 07:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726669661; x=1727274461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zvElbu+TIiFhSOG33tdgbS1aQc0qDU9Xp9BEsCvh4Ck=;
 b=CGJp3Ptpsvw7726+EDBQZ1Ez+cN3GAA1ojblol7It+N2VvljYiHmsj/Qr1UAmNfN6j
 gi4/D8Zl3ECchbQM6RDiOUL7nNTNoB1Gr/Wgu2gont/P+lV2e0AFZsUyjPy1wrMsFfDZ
 MKSA0ip9a3znGmeivecNlSDa1d4zbLKIocKxGeza3cMOSudzyKgV6SRTSv44eP7rzR9k
 xhFX4athH/1omrPCUNH/tHq9Me+d6Wnk6z4fdIwyTC91STitKxXkZotGl8xVXO1TkRq5
 AGW3ME8XN6gxvkz7JlY2DgwdPa3KDPO0zHJgjTl66NCHKQ8ghG3g26vR9Sk8Se+m6+Qa
 50Ig==
X-Gm-Message-State: AOJu0Yz085AV70w9y++uF8CZmeOFWD545bSq0VX69nnLh3bl+h0BBIyG
 Cjvz0QdK6NXY2nTVv2yKOgaexu+3/lXxRoqgJ1YxAi3j31LAE7F90vr9Y5xVkUmqtsqRxy6bHz8
 WMPb1fhpbt8WXIQyyClmodhMlfzZT++6nJmK1VPjmelpNKyRBN2nf
X-Received: by 2002:a05:600c:458e:b0:42c:bd5a:9471 with SMTP id
 5b1f17b1804b1-42cbde23b7cmr182671985e9.16.1726669660819; 
 Wed, 18 Sep 2024 07:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxGn0WxBOZGvC3YeHJMepuWDnmtriejVq/xFBKWfWigl+FsqbL3bP0h85FPSXJ9XSKfFSiWA==
X-Received: by 2002:a05:600c:458e:b0:42c:bd5a:9471 with SMTP id
 5b1f17b1804b1-42cbde23b7cmr182671635e9.16.1726669660226; 
 Wed, 18 Sep 2024 07:27:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e70537c66sm18343255e9.30.2024.09.18.07.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 07:27:39 -0700 (PDT)
Message-ID: <3cc3456d-a47d-4960-9d5e-10cf1c8b4beb@redhat.com>
Date: Wed, 18 Sep 2024 16:27:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 03/13] hw/ppc/spapr_pci: Do not reject VFs created
 after a PF
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
 <20240913-reuse-v16-3-d016b4b4f616@daynix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240913-reuse-v16-3-d016b4b4f616@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Adding :

   Harsh for QEMU/PPC pseries machine,
   Shivaprasad for KVM/PPC VFIO and IOMMU support.

Thanks,

C.


On 9/13/24 05:44, Akihiko Odaki wrote:
> A PF may automatically create VFs and the PF may be function 0.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/ppc/spapr_pci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index f63182a03c41..ed4454bbf79e 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1573,7 +1573,9 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
>        * hotplug, we do not allow functions to be hotplugged to a
>        * slot that already has function 0 present
>        */
> -    if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
> +    if (plugged_dev->hotplugged &&
> +        !pci_is_vf(pdev) &&
> +        bus->devices[PCI_DEVFN(slotnr, 0)] &&
>           PCI_FUNC(pdev->devfn) != 0) {
>           error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
>                      " additional functions can no longer be exposed to guest.",
> 


