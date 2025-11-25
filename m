Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBE7CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 07:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNnfW-0002iL-AB; Tue, 25 Nov 2025 02:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNnfS-0002eU-KC
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:40:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNnfR-0005mc-1K
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764056452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5Qb2oR9A6eKVwI4lvhaYGfVPS/sw4k+xhK9P5Uyg9XQ=;
 b=N3XL5w19u3reLNxqS9n9kNXiPcBpXsyYG6q8nj7/C0F4ay7Ebs9Z0EgacAhGk9jDlQaSAn
 9eISC4TwgxZYAvBQsvwKP1t/vrZOnHnohs2a4xpsLJ07O/+2KS1b61EmwP09wuwYdGJqGu
 4mCA9jU0HjZcPfqzhtetDDyjP99DyEA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-crn-XVh0PcS9w8lTXpz3PQ-1; Tue, 25 Nov 2025 02:40:50 -0500
X-MC-Unique: crn-XVh0PcS9w8lTXpz3PQ-1
X-Mimecast-MFC-AGG-ID: crn-XVh0PcS9w8lTXpz3PQ_1764056449
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b2f79759bso5069866f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 23:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764056448; x=1764661248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5Qb2oR9A6eKVwI4lvhaYGfVPS/sw4k+xhK9P5Uyg9XQ=;
 b=XEnh0bdx/uDxaJXkHt+N302bcza1eR5TY+Q3vZTBIU0N6TNGZOki6HNpkHEfz4q1Z3
 ssT/joAPYQCpqQOSzcyEgYK0KeASQg637KbaqqM87RlXA9AUzfHh3IcypS56mBGEn/ak
 xZy88Aps8zkQhs4RAD6ALxN9yJg+JWPWAI+jE6Jw8btsALWNCayEJABVaFriC5x5PEHl
 9ySBp/HYye5yuhA03vq5EBeW3SoiLzH1wjhWoVsE2Vif3V/tRWrApbimGLiJcjGMVR2O
 eMex3qJWE1BCB8Wp8MBAlEO3XYYHYoywhCbIygiVpLE6ydUVPsY9T6PNSCaGLkkpnivm
 3PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764056448; x=1764661248;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Qb2oR9A6eKVwI4lvhaYGfVPS/sw4k+xhK9P5Uyg9XQ=;
 b=ObUciriymACu80hZXnKB4JkkQPAQdrJM8zm37F/15edI7WLMDHhL1Iqirbt6x57hIa
 qrdiSnXvqmCDrzbeK+zB99e4/ha+Z08npmt1tOJfqQrXbAgdD9ES9gh1+T0Ss8crI6KK
 Uev2vEvUojQLj/TIM3ommyIrJJSZm1+gb/Jx0kOEqSl0s0o6N4EbjjqEwbrD7GOJfEwd
 0TsMTWcX/3ovXDISZaBbsNnLcYGG1IH9quxFCDdbnYLXlbbLespG3Ix3F7h4G4NgQM/r
 HAj4htVXKfalADxPLsY2YEXduGLo9mq8XDIMs3wI+ypH20MAUVDpgaeXtNhyTCa+n0uc
 8VIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL6t8QoRi7FTDohQ13lLvdX2N/vWJxdRNzxdLnY1YQz8me3SSjVwI7Od3Abkfpl/dJMSUTFGxzNQAr@nongnu.org
X-Gm-Message-State: AOJu0Yxi5HCniZ/m2oV3sIeZzcuSvvoET2TH77X0YKjlmPb5szVtDwFr
 6yWadWiuF1ec5XHxFeyCxBmzbcBwEAcDe4aR1mVd6G8dbedexhAFU4cT16OYlxEOYLvaX0yfjrc
 OPeyS1cgCvuowmQPl3qqKCso5Oem3rIYdU60Ju30is2NGRJTf/O2+OTwU0Tazpnqi
X-Gm-Gg: ASbGncsFQZ3XmUImVkt0K8T0qbfWXOBjOUBH4oPaiXq+6+ikReSU2NArPl8iCwOAfLJ
 Bs9RbxtVW0KBP4M583ZZMQCnLyNIBqGv3mi+jrm52RJ8+0h0/4FXNoEd5Gr388d4UCTdjVuAkbq
 LTooLDtTX2Ql0rDQFfmZsE8WVvBjZClCWplMm6oKUySPCGvuXPe1Puh1VEZ6DYLDhCTpkbtgoKS
 HCQydjxLcQufT21/GRkpw+NAw20ioG7l/yMgye7dqUNAIIpGQEJvO6g/6eCCcTwPLs1kyHtZP7S
 JynzM6laV1DkcUu5azrKn2IK9OVAc4DKzrh9i3dkt4XeJB0fu6JnA9LcpE6e+5lzvwdJs2cyK3Q
 HsteezBHawvLwLwWVWkcPZlgBBR9JUFqvia+ZDrnN1MJlzMP9
X-Received: by 2002:a5d:64e8:0:b0:427:9e6:3a64 with SMTP id
 ffacd0b85a97d-42cc1d35629mr15983772f8f.47.1764056448595; 
 Mon, 24 Nov 2025 23:40:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZttdx2J2gqEag6BwYUgfGGV8n2QtIKEZGedNcHz5nLTgE1C6CCDCECDSFVb00xq+yX05cpg==
X-Received: by 2002:a5d:64e8:0:b0:427:9e6:3a64 with SMTP id
 ffacd0b85a97d-42cc1d35629mr15983747f8f.47.1764056448224; 
 Mon, 24 Nov 2025 23:40:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e432sm31908276f8f.9.2025.11.24.23.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 23:40:47 -0800 (PST)
Message-ID: <1c9b2503-8279-4bc1-aac4-6a72564ea168@redhat.com>
Date: Tue, 25 Nov 2025 08:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] vfio: relax the vIOMMU check
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex@shazbot.org" <alex@shazbot.org>, "mst@redhat.com" <mst@redhat.com>, 
 "jasowang@redhat.com" <jasowang@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, Xudong"
 <xudong.hao@intel.com>, "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 Rohith S R <rohith.s.r@intel.com>, "Gross, Mark" <mark.gross@intel.com>,
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <20251106042027.856594-1-zhenzhong.duan@intel.com>
 <IA3PR11MB91364009C0A6B80E2FFF425C92D4A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB91364009C0A6B80E2FFF425C92D4A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/20/25 10:29, Duan, Zhenzhong wrote:
> Hi All,
> 
> Kindly ping😊, any more comments?

Yes ! These are for QEMU 11.0 and it would be nice to have
some Acks on the remaining patches.

Thanks,

C.


