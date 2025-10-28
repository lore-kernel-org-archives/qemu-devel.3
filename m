Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB762CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDje6-0005mn-Sq; Tue, 28 Oct 2025 09:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDje0-0005kp-R1
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDjdu-0002uV-8s
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761657697;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fA6XqgFHd59k0CDQMyi7P073g3XKZIpAOLwoui7XJc=;
 b=F9DI2lO57njmrVj3t+UNealAyUz2UM6glJxFfXdKf+rmbKUDu5CMHgJ79R+hwX2XPVbOZR
 fV7KWxNkiidfatFNxeFYy7Id87FibYCJsazymbaaZFEaa3JCUY4q5kzQlgW+jPju2FsxkT
 DvYYRoKg3zgtpsDv3p0K3/bdOLLWPw0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-7SJpHdV0MGK_6-uZN_Yfwg-1; Tue, 28 Oct 2025 09:21:35 -0400
X-MC-Unique: 7SJpHdV0MGK_6-uZN_Yfwg-1
X-Mimecast-MFC-AGG-ID: 7SJpHdV0MGK_6-uZN_Yfwg_1761657694
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso45221635e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 06:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761657694; x=1762262494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/fA6XqgFHd59k0CDQMyi7P073g3XKZIpAOLwoui7XJc=;
 b=MjzxYgOWGAXWFWbpcY1mCYh8aPxhs1arW+bfNdtPDAvClXpmx5xz+R1e5RQw0+VdC/
 T9PNgpE88e8w3vHACanRf83B+kQUfeuHONG1GJir3S0phAUdZ6JUXqRRqHGQoEfl3Qhm
 hGKWHQHARuJjyvtlLBVqhn4vRK9OSyjflOa/mcUlf0pwzEXOLYtBraQ+ALbgmDe9hE/t
 87llqJjS+RpDfZZU/kjP9/CSFHVZlYRJenPRA4+5UVGCsfaRew7dvgLTdDgU1mjGItJ6
 JjAgUaAqC6G99C5V3ytdQNfNuSrUpCPpVqLTsXuyks/YfZXO4EhdTdbl2Ha6rZMsWCmD
 TewQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIMiCjwpqL6WQQBCR8uRWbTxqjOM5oUMXshiIw1VB5koBX2EVce12hW67dxlwJoalASfMhWGoHSb0f@nongnu.org
X-Gm-Message-State: AOJu0YwU93CcyMKsiuADuSzXcup1i6AexB8uqFprYcZaDbxxJdRBCW3I
 mVpdAUCpTzOzwgf+0W11lFDVCZuox4lw6yVOG+SDK76KkvEZ4p1MdfVGMsMqZSEdjvclXlLx4zM
 E8KHazhohIYQ11LblkvvbkAEDCiEZt0kq/S+BqJcS2686l9E6rAdY4PiT
X-Gm-Gg: ASbGncs/4joH8ceO4XfOrpqR9HvUBUAjwPqgqCLhd225pRCjxyEo4guGlT05VNbFkci
 KICy6/ciAnob3xJxGrrZIPcOEbMU9KbRprZWwHD3BM1sZcxEtr0A1OebE1pUQG2pB+QK+A7YxLN
 USymSgKqiLb9pQNdYjAwNM32PXhK+uz/LXiu3kHJY3DKCghreuWUV+kUbUKZhchyDpReucDJFu4
 tUq9zm13qbWFzAYJLDsbUmNpC0I48uVNPf1rxygWKmmeBmJdRd2O1XzKBjcdIkB83oON2OPozsb
 iCIl3YKVwwIoMZ0s9BJ0sFbyQ6kEaheLFvZXNJ3aJDJv4BHtEmcPTPFq+9TBshvvXnkmW+lv0Cy
 r8jPDr9hkAhMEyWYxe21+Q/GIZ4nvp2GfwBXgv3Tbvx1uOw==
X-Received: by 2002:a05:600c:34c8:b0:471:c72:c7f8 with SMTP id
 5b1f17b1804b1-47717e4df73mr28081995e9.21.1761657694236; 
 Tue, 28 Oct 2025 06:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmjabWNvxjRhgK7uAjt58Mht1VBFYfBF36smLEnF0w9EpnY2MHrTv7vmZ0aU+XsJEAprQaMw==
X-Received: by 2002:a05:600c:34c8:b0:471:c72:c7f8 with SMTP id
 5b1f17b1804b1-47717e4df73mr28081685e9.21.1761657693824; 
 Tue, 28 Oct 2025 06:21:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd477c92sm194181615e9.2.2025.10.28.06.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 06:21:33 -0700 (PDT)
Message-ID: <9748e922-057b-4e7c-ad6b-b83f5591290a@redhat.com>
Date: Tue, 28 Oct 2025 14:21:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, ddutile@redhat.com,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-23-skolothumtho@nvidia.com>
 <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
 <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
 <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
 <aP+xhmLCRu6y0eQm@Asurada-Nvidia> <20251028121625.GF1018328@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251028121625.GF1018328@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/28/25 1:16 PM, Jason Gunthorpe wrote:
> On Mon, Oct 27, 2025 at 10:53:10AM -0700, Nicolin Chen wrote:
>
>> Hmm, that sounds a legit reason, though adding the ATS support to
>> the emulated SMMUv3 isn't seemingly a small effort...
> What is "emulated ATS" anyhow?
I guess it means implementing ATS translation requests and capability to
send ATS invalidations. something like:

https://lore.kernel.org/all/20250628180226.133285-1-clement.mathieu--drif@eviden.com/

Eric

>
> Jason
>


