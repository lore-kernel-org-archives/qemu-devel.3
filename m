Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C924C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaWZ-0002EH-BF; Thu, 13 Feb 2025 09:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiaWV-0002Dq-7Q
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:49:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiaWT-0002VV-MO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739458140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dypU5xq5Xc0NlKGVIXfBBoIf/VaRXVZxKgFbdHLtOKE=;
 b=YsZAHPzRrXrFo5WtxrAFe9f6AXXO6kjzAYuyj2d485Z0+VGiMSLTbpwyhdZb00GYcN3r9P
 RHLig7RgyAbM+aMAxlise15vgopQEZJ95AZmF8oYRb5aFV64xcwOfBN4qE/JboQmWs5wZj
 DUYemD+ekHgdMxe8Uv7nyYKHMaKCclI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-iGbV4IfPOYC-Cb9Wr1Kajg-1; Thu, 13 Feb 2025 09:48:58 -0500
X-MC-Unique: iGbV4IfPOYC-Cb9Wr1Kajg-1
X-Mimecast-MFC-AGG-ID: iGbV4IfPOYC-Cb9Wr1Kajg_1739458137
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38ddee833e0so559355f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739458137; x=1740062937;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dypU5xq5Xc0NlKGVIXfBBoIf/VaRXVZxKgFbdHLtOKE=;
 b=NJlu2sfXPnDSDzxs8//8MNwzuUuiy9IQ6nhSfLMVTA87kcpPW/Q2Om1QgDhvY8UUx1
 xBKeoM5ffg8iPQAFYhElgRngbevkWBUhTHGIqpo1bKdH74THCybYnb+q/tUnIFjAipvW
 rKStcfx7WMAQSIGzEtEuuAQ/Wl23msuLXuSJZQveQWj7WOQqyernapLHGeiZYOTQYU1w
 H4dl/A081skz6clp3AlM4QSrrLQUqLY1DRYI8LwpcEhurmqSDMRBtWioKwCGCYd5SNAA
 kXFgR7CSlopfMbLt5zfNnyZ19JFqNOOESIY6n4PArlQ3L7RFgmOFjG74zl+Kvot6yQZ+
 5FtA==
X-Gm-Message-State: AOJu0YzPGXjLa0CVi0cn3pWlGJS97PPd4C3F9TWkk9Kcw1MzYD466wRL
 98ESX+RK3uO2VuEClREWKJWYwiDjFDt5KuYVLRt6PNy9FcvZnF00a4F2ei3gQKnRC6GEBxVQKaU
 aZ62ZS+uuf9KhaKJSPK7xk9D8TyaUYM7Tj4lxFxpnwuutRZB7GIud
X-Gm-Gg: ASbGncurgZAdTbQKXHnhb6pyGRgePraaGxD4p++eu8K0VwNM7JX/g1u98Os1DOLb2cc
 HAUzJ0yYsn/UPBKQOPSwPREPVpHGsgO9oMkR1AEyP0+LtDaTfv2BiJIO4t2Lz3rDGfNdRwgDOpX
 oA6sDikBbdzNCkFiTVbtTmoR3LpwhSfmjfim/BZeRcOug6dgyxAvv1+xyQljDF6m5iC72X3nDCJ
 QKKOhpoe+HmPGfpdf2L9i+gyWtHkDYN8RrftIt+6WbCmkGEJcjd3Z1sBe8obe7J2NeC/MeUMgzM
 scwuGrVkk2iNuYKArMC+WdtPLKFm1Fmcr8RA30Ls3go=
X-Received: by 2002:a5d:6d0a:0:b0:38d:e363:494b with SMTP id
 ffacd0b85a97d-38f24cfa3f1mr3850021f8f.8.1739458137457; 
 Thu, 13 Feb 2025 06:48:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUbFy9oIyVrXmue1LFN17ou5V7iaBeGSPpBEyp+gZbsKzjlBo7D4qStJcmtbU+yRwtv1re+w==
X-Received: by 2002:a5d:6d0a:0:b0:38d:e363:494b with SMTP id
 ffacd0b85a97d-38f24cfa3f1mr3849090f8f.8.1739458126230; 
 Thu, 13 Feb 2025 06:48:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d8e62sm2077598f8f.71.2025.02.13.06.48.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 06:48:45 -0800 (PST)
Message-ID: <3bf261e6-2c58-4606-ba1e-66947ca081df@redhat.com>
Date: Thu, 13 Feb 2025 15:48:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio: Add property documentation
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250213135050.1426258-1-clg@redhat.com>
 <3066bfc4-9681-9d03-cf87-e5d49b8fbc3d@eik.bme.hu>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <3066bfc4-9681-9d03-cf87-e5d49b8fbc3d@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/13/25 15:17, BALATON Zoltan wrote:
> On Thu, 13 Feb 2025, Cédric Le Goater wrote:
>> Investigate the git history to uncover when and why the VFIO
>> properties were introduced and update the models. This is mostly
>> targeting vfio-pci device, since vfio-plateform, vfio-ap and vfio-ccw
> 
> Typo: vfio-platform

French influence ! Thanks,

C.


