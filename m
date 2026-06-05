Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A750CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWDO-0008RG-Ks; Fri, 05 Jun 2026 11:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1wVWCt-0008EM-8c
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1wVWCm-0001gd-Qt
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780672230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MENMLoT9sZnj4xS/FRnqUnwhoa9s7kqTFW+zqeiwZco=;
 b=CuScr1vYn+U2ZslqY77dEGaIVxF+7ySghC/BqyvBnuVXCfrf0CJfJqMy4znzbx7VmxJpN8
 hoMXQ3yABMOyddOta1wx7i7eS79m2peA2p4ABd3ZU9fbcCYYmZ89/NkxRnqqhP5KrH3t4q
 wUFzbG3wN/Dl2KFvxrHzWw9DnTA0MPM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-iM9MmV7VNkelmHDTuf5tdQ-1; Fri, 05 Jun 2026 11:08:15 -0400
X-MC-Unique: iM9MmV7VNkelmHDTuf5tdQ-1
X-Mimecast-MFC-AGG-ID: iM9MmV7VNkelmHDTuf5tdQ_1780672094
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b2f22ea2so21052335e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780672094; x=1781276894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MENMLoT9sZnj4xS/FRnqUnwhoa9s7kqTFW+zqeiwZco=;
 b=E+4H4LxBSAINlx+7mShZ41lumMQ468mBfTXB+AbK98lpLZ/spDS1I4sTfiKeFxWjUK
 YSOy2Y8dVnzWngvLaG41JiF1RfjqppwRvTz8ghkzpr2iNYJ338bwxEaY50XdQr0yipLa
 iyAJv+XHs0y/p5RshKHdZT/zQtKDdgdouPAdmrdyIbgjP50o2HJL3/swntgd5vV3I0dv
 FQZNlArTwCiaE/OMnvuV+pBss0sNTPZ8J/Vu6MFcSudMrI1a/7KPOj2TzHiWbooSUpWK
 LkGnfDhTn0kdc0/+L21GFQxjgjyA4vGFsrvWwS0wEKpXUZHR/c0ueBZVEd3PqIyrwbIH
 MDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780672094; x=1781276894;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MENMLoT9sZnj4xS/FRnqUnwhoa9s7kqTFW+zqeiwZco=;
 b=Qlw2S4qF/7Krc1W6vas4BTM9UWvbPcebNK69+/2gS491G6SEcK/SlHKFEmCBYcr+5O
 iFFFH1I8QhI5TurkP/5mzQ/STBDj6YL7k8LsZvkEV9oILMpoX+QCb9eek1qJjRvg2ypc
 gJ7806AWaSfxKunV2hLEzITgF6Jz9dER/NxQNeBbCeacwKIf6kBy8VmbzfmBycf4S1Xl
 Rapa+5dtujO4DsFEVrElecwJX3RZjNnLYBlBLl1WBeHtOIDV1Rv9EeM7+ARWalP37v/4
 CyD5rDxqSBztN5fZGZIMOEUvxsm0f9LAts8uP772R+TCJUGgywVngn/MZfjGbCL+GP5W
 Hi/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zKO4XrmaKSXrwiMVnBhZhzcBOOp+D2xZ0VB07LDBZrfqf0/X2eCdjGNCjurYVDyBMb1Q/6VxJOJvr@nongnu.org
X-Gm-Message-State: AOJu0YwvL2Pb+DaxQ4rzNomGixYfNfiTDMZvO18Gmwt1RU28OT9j7iMh
 fkiSJU3AB5+99g39wqsXwMfTDMXC8tvgSnsDu9V8krlMzdG/NascdBBQS8jMg2Y1Hh529636+Ki
 /bAY1MxnFDh+p5e1HkIbZqyY6/ES6Ux5ZPykgw70EjqwC9SdpA1JPNCa+
X-Gm-Gg: Acq92OHp7oHYyNGManHMx6+h2WXnCrNmhn1Gv5IZ3BLWoNKzTRH66J6pWTl3Z0iRGLS
 fDYp5nZNGFycDc7sZ+zKdKXRnWEBAV26/ZEeAUwvaabPdoRJtbgyiUI8HTc2XkvV1TwDWwxMAyh
 qwOlShbhWaWur6kitKqyzi/JdZyOrNSksJLVj/vuutwNnqDeBtJmkCdDDDPmwx/SVZRchTQRyql
 5lQnqMz6WVlc0rgqAwF0sL96/Pwzw9Q3t1KESrbGfQBCqvjvsiyxZz6kVmK076Lf1afbbNY6b0J
 4KJ/NS4N6zprBtTxvvY78whwJ4QhdIAwhimBzAo/8PJ3zR3QQt/FplF6giEvDlVq4AOGLIdvCMx
 yycfT0HAAbHggH0WS97VCxyTLPX3X53zmdOZ39a2AZP3Cuqb/I53ZFd+9QL4QWxknAxI=
X-Received: by 2002:a05:600c:828f:b0:490:b3fe:9732 with SMTP id
 5b1f17b1804b1-490c25dd6aamr60581935e9.16.1780672094129; 
 Fri, 05 Jun 2026 08:08:14 -0700 (PDT)
X-Received: by 2002:a05:600c:828f:b0:490:b3fe:9732 with SMTP id
 5b1f17b1804b1-490c25dd6aamr60581165e9.16.1780672093720; 
 Fri, 05 Jun 2026 08:08:13 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc4082c3sm154879305e9.13.2026.06.05.08.08.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 08:08:13 -0700 (PDT)
Message-ID: <b5d3db83-d9f6-44bf-a14c-80e258d6618c@redhat.com>
Date: Fri, 5 Jun 2026 17:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/14] virtio-net: Advertise UDP tunnel GSO support by
 default
From: Paolo Abeni <pabeni@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang
 <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gabriel Goller <g.goller@proxmox.com>,
 Stefan Hanreich <s.hanreich@proxmox.com>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <cover.1762698873.git.mst@redhat.com>
 <1c79ab6937ae938d3dfd4da1c01afc7eb599857e.1762698873.git.mst@redhat.com>
 <077647f6-d569-4918-9aea-c0597a6ddbc8@proxmox.com>
 <39100539-1c43-431b-886d-7d42850bc4c5@redhat.com>
Content-Language: en-US
In-Reply-To: <39100539-1c43-431b-886d-7d42850bc4c5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 6/5/26 4:54 PM, Paolo Abeni wrote:
> On 6/5/26 4:02 PM, Fiona Ebner wrote:
>> I wanted to ask if this configuration is expected to be unsupported and
>> if the management is expected to turn off the feature on the commandline
>> if the traffic might go over a physical NIC without the feature. Or if
>> this could be a kernel or NIC bug that should be investigated further?
>> In the former case, should the option really be turned on by default
>> with new machine versions?
> 
> Thank you for the detailed report. The configuration you describe is
> supported and expected to work. The fact that different results are
> obtained on top of a NIC with:
> 
> [1] tx-udp_tnl-segmentation: off [fixed]
> 
> WRT to similar setup on top of NIC with:
> 
> [2] tx-udp_tnl-segmentation: off
> 
> is indeed strange/unexpected, as the two scenarios are indistinguishable
> from the stack perspective. I suspect the issue is NIC driver dependent.
Skimming over the links you provided, it looks like multiple NICs are
affected, so possibly/likely my above suspect is just wrong. Do you have
handy a list of the NICs exposing the problem?

/P


