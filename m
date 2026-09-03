Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D65C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x23be-0007MG-G2; Thu, 03 Sep 2026 05:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x23bc-0007LT-KU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x23ba-0007wQ-Lo
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788427172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nRNNXyStV+UiVEPQdxJPIBxU3AY469YUuxMqcKr3vkk=;
 b=iPWUpBjP9pmAhdnZr/PEj7rSw0OxvfZg94bpx22AskivwS26gIfFxtZ+uzQQ374GOc0PU4
 t1FJSBbZh3EVSQ/5BffTYKigPVTxo3Jx+iLWBayiJmUcgJ/yio6lnOtXtQy9OjH6uZSSxr
 XX72Xy7M2Nq8spemM2f2bRhFssEBkaQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-MO2D_XmjN1-C8oQq0PkJ9g-1; Thu, 03 Sep 2026 05:19:30 -0400
X-MC-Unique: MO2D_XmjN1-C8oQq0PkJ9g-1
X-Mimecast-MFC-AGG-ID: MO2D_XmjN1-C8oQq0PkJ9g_1788427169
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4994cf6cdb9so15033265e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788427169; x=1789031969; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nRNNXyStV+UiVEPQdxJPIBxU3AY469YUuxMqcKr3vkk=;
 b=bM2b9WTyZJq4xgGb5+07zr9wgRMvnwj83yBzp1XBm/wlIxA20MXfPCW5lZ+S9fRtLd
 utY1suWqAK1OuHImIb+Mq3VQPUvxT+sw5YAOe8ijcvd7GHETKpp/BOc8npgXmYGqNvSF
 U+LAt3Jlt6mGiHVi6RC2n2ZFtOVOYNfDaxi9dTiDvFsOVXlwmddvrbRb3d1jFhkjI9RM
 Tb2urevhEz61L/SAVu1vMqcL3p2jrnIkBUDZYqDsUs9V/MTuepjttz+MsHjBx+qt7vKP
 vDH1JmdR/bCfOwbnN1RJDEB2VI1dRBq4pNT352ZEIB4qSl1OWZjvCw9sdSyOorhWmcGI
 g6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788427169; x=1789031969;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nRNNXyStV+UiVEPQdxJPIBxU3AY469YUuxMqcKr3vkk=;
 b=L4lNTVnxn2pUebISXzS5nQkBNk7pIwEb5T6T2opfqXqAUvyHhu4m88Ws4J4QR7ICTo
 7mjA6NPOHMP2uu9NJUEuPCKjvZjFIRR0ktdzKrSw/cTAzRr3zGwjRXtUgpDC9JHLiQHB
 Dx5fWfdlywlZD+qBdwxVtXHaxVZwDtwINtSz2f4mDN5czmYiadIgqNpMEMQjqwENA9pY
 xHwGyq5Khy5+hjw8WVej3WTxCzw4ZBSubumHZ5Z1iQqaUrcxTh1ELYk8m6NyqTJys2z7
 E5C8fZFO7sjyruMB8lNvLz5+MkLlZ8jP0NCGE3JOvXRag/mbXSS3ceNmKtb8XDw49U/p
 fFeA==
X-Forwarded-Encrypted: i=1;
 AKwUvByFiclacDDbQIjGL92OP8OnvDV+zFMxjTTZvFO6Bm+JnLYzAKV1yQPeHs/7FZX/MsWP+sTQUtRNF44n@nongnu.org
X-Gm-Message-State: AFuF++mjkVz2yMF/M8lMoykPnLN8StA823LE8bxr3yewkGAGaIYrnC7Z
 Fkdxkb1dRSja9v0qhsiZeCRxwyh/AgXC2fzG+M7XPc/wjYTKlEOL6jik69OklAobmyIyABJxyL4
 DPDaaJrUhpNJWcEI3CkogUXi30o0qBiPZa2wJmOryX9cLJMEwCT8WZAZY
X-Gm-Gg: AYBFou3elZuRFHBe5Qcz6wnPAmoh1TZ48UC70vPUhi3p+RYZMyu4sveMloepnnqiRMt
 +nNGtI4Hsqmmc9mgKP+KKGQSWtcXooUR0IB+AUa6sxZIldBYTFODhrI0MdLVU2QcUirP0c96jVh
 mozUY2l1bar6F2UIwykzN0pC/DdO4A59iktTpnebujxcMnF4r1o/EwqDgJ0S8MIO72rQTpNIMjU
 8JhS8YVGRYK+2TM/+9TxgikS2tFVH1t26exWVNObRZGGU4Hhvv+hdGiJGQkyaP+vrQBAcZaOmsa
 3kOVDMgg45nu6e8NH3QBPpKAJT8cLcxBqQwkzVVkkE9EJAP4Kzujmnn4Q3BH1m/fcyHk0Yxf8FW
 TfE+H56YZ+2SwQx+Kbrj4NyGeTrmxknp7z9anAQ0=
X-Received: by 2002:a05:600c:8012:b0:49c:d818:8764 with SMTP id
 5b1f17b1804b1-49ce5842473mr212512375e9.11.1788427169221; 
 Thu, 03 Sep 2026 02:19:29 -0700 (PDT)
X-Received: by 2002:a05:600c:8012:b0:49c:d818:8764 with SMTP id
 5b1f17b1804b1-49ce5842473mr212511605e9.11.1788427168768; 
 Thu, 03 Sep 2026 02:19:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:bf4:da16:e208:c6bd?
 ([2a01:e0a:1292:d530:bf4:da16:e208:c6bd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d6029sm56263015e9.6.2026.09.03.02.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 02:19:28 -0700 (PDT)
Message-ID: <a5dea766-1131-49cb-bd26-6a09673b176e@redhat.com>
Date: Thu, 3 Sep 2026 11:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Error recovery for zPCI passthrough devices
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, armbru@redhat.com,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260831183151.12626-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 8/31/26 20:31, Farhan Ali wrote:
> Hi,
> 
> This patch series introduces support for error recovery for passthrough PCI
> devices on System Z (s390x). This is the user space component for the Linux
> kernel patches [1]. The kernel patches were merged for 7.3 and it had some
> significant changes in VFIO API since the last QEMU series was posted. But the
> design for QEMU component is still the same.
> 
> For QEMU on eventfd notification for PCI error from vfio-pci driver we call the
> vfio error handler. We can use a per device error handler callback to override
> the default vfio error handler.  For s390x specific error handler, we retrieve
> the architecture specific PCI error information and inject the information into
> the guest. Once the guest receives the error information, the guest drivers will
> drive the error recovery.  Typically recovery involves a device reset which
> translate to CLP disable/enable cycle for the device.
> 
> I would appreciate some feedback on this patch series.

Hi Farhan,

Have you seen Shameer's kernel series for PCI error recovery [1] ?
It uses a dedicated eventfd registered via VFIO_DEVICE_FEATURE_SET,
with a self-contained handler independent of the legacy err_notifier.

The QEMU side [2] just probes the feature, installs the eventfd, and
suppresses the legacy vm_stop path with a bool flag : no callback in
generic VFIO PCI code, which is cleaner.

This is also the pattern used by the other s390 VFIO devices: vfio-ccw
has three dedicated eventfds (io_notifier, crw_notifier, req_notifier)
and vfio-ap has two (req_notifier, cfg_notifier).

For zPCI, it would mean extending VFIO_DEVICE_FEATURE_ZPCI_ERROR to
support SET with an eventfd field. The ABI is still new so the struct
can be extended, keeping the s390 error recovery code self-contained,
with no changes to generic VFIO  PCI code. I think this approach is
preferable.

Thanks,

C.

[1] https://lore.kernel.org/all/20260901093217.8539-1-skolothumtho@nvidia.com/
[2] https://github.com/shamiali2008/qemu-master/commit/e45458710cd8509fa5bd81f4376126b77b6f40be



