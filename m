Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFA9FD5309
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 07:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvsFk-0006Cl-Oh; Fri, 27 Feb 2026 02:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vvsFj-0006CY-Dv
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:27:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vvsFi-0004bT-5R
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772177229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DMTBgWFnXQGsoyX0Qck1IFBi/fumrax5xKEwOcBNFGA=;
 b=alDefGKzuLJmrYx7U7eMOSFCDHCjPNWXe5L3iQfeOTbh+RmU9uql2tfiHykCPK9bEBp4Ct
 4NlamWxLzwVKnkfoIEAGmVHMuf+WwaRQMuPwE5GcNE343J0IJOwasXsKofN7Qf+BlFg3Wj
 arGNcEQd4SBo8pri3Dnvr2G3e7B9nxM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-Z2s2RhReMJm87fBPo3FbdQ-1; Fri, 27 Feb 2026 02:27:07 -0500
X-MC-Unique: Z2s2RhReMJm87fBPo3FbdQ-1
X-Mimecast-MFC-AGG-ID: Z2s2RhReMJm87fBPo3FbdQ_1772177226
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836ff58111so18230195e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 23:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772177226; x=1772782026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DMTBgWFnXQGsoyX0Qck1IFBi/fumrax5xKEwOcBNFGA=;
 b=BoTN39EC//ZTI1t7pgby9NvcjYAuR2c58JabUCvggNIWk+nudfcPLe8bTu9dAtD4yn
 VAmH278EfFcAv3BLtDbt4ZK/IlUQxLEcqUYaBnrOQPKQGOr3SVeBgBYAZzBpbHT3YciY
 Btbku30HxnqDCuPw+2uHzF5GBKFUuI22z3zIefeVTp58CHv2fNVxogIM1s6iapfCTOzy
 VcTSAxCZ2kyEd76FbmktRar4RhVzqc5tzaH9HwRuPIVq5r5MVmB48KpQLaykROOpT1Wc
 12oMXF82GNjBO75EG2vlSxPPOm8ugbcxZ3G4wGaweSXKLi30wfvIILrkelnfJTIRNrrp
 eNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772177226; x=1772782026;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMTBgWFnXQGsoyX0Qck1IFBi/fumrax5xKEwOcBNFGA=;
 b=aC9v6A9odaOAvQYgnBv2wFaQ/M8M/oNk0GEPKxBuvvRV8Ng/hVFG69ki7p/PG7RYKM
 y7BZ2Ay0dumoCighlkyczrH3hKW8ljml0JKW2tDX/wXUAGT1LclsFomwIyAcgQLkZLhe
 HlE+mOgPLjaPqtfroGxYRWmXWRgJNxzq6+ZpuEqsEa0m8y5HjcJ3T65vo6Ral2ksxAY9
 SOnexr7Sl32KoZj0eQFo4Qgb37Yye/4l2rh4ayWBdDHH6plwMmbEfr48XtWIhns2b1VP
 /foKpGl39bYLRg5OFtH6yOYk/5cQ8sqcJW1oJ5Brvaa2CzAJhORj7BrmN6K3YHd3ESRv
 WHNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsS0bA3a0Bh9RcoFpgS/80u0ZdWOqO6Y7Lrmgv++gGjqmKyl4l1f5V/nt/6B+efw/h/kKVLk01UHRZ@nongnu.org
X-Gm-Message-State: AOJu0Yx0mwNSGh0O6VbDFzS1uwMcblnlIWg6ODmt0swF9v2tN+QqjBUy
 U3uWiTA5O+HcI9Xum/OUJQ/ENZZm7vebpwZ42DVrNxQH3AOvLgjBTNORJftXehJSuuNfwg7CH5i
 uekpHytiz9LljIByeoHQ6z9X+DvzTbEhGFhHly/zLNW7uRr8PAAvgF2s4
X-Gm-Gg: ATEYQzyWq00mtVzt+vJv5nECyjDoJDbEURj8pgpbKNKcWnlmuW/jAtUvzTAj319fZ5v
 0PtLSd1TKQ2me/RU5FLYyit+bak+Kz+ehM7qPXfHuq8MvWiwNLeS2uLg6gw7MJaRzMj2MhWfkSG
 dxY9C5JAX7tRoXMi837kGAM5841LGRTfM5doZ1nF36sNUoIfMiSc7d2yWtQurapUi4dF3GH/NJZ
 /bgyodg0RAeQUxkZ6IiiYa2+CVVcET/S0Z7GhfL+9T3cPZEiiUL1X4+y+cy1cbj8WbyAuJ5qlEH
 oQR7+5Ovp3P4Q4BjHWDMy85qgz6t91TRcpNh5nDiBoNvdb0FM2tNvyku1hB7AVnnPwiIoPGIdxt
 cTzD8GalBEOxbSPUfdq3Y60cWzTulpeQuzg5ipnLnNhYBbCBQ4cSFF4hz6g==
X-Received: by 2002:a05:600c:c490:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-483c9bb1fb0mr23577785e9.10.1772177225943; 
 Thu, 26 Feb 2026 23:27:05 -0800 (PST)
X-Received: by 2002:a05:600c:c490:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-483c9bb1fb0mr23577485e9.10.1772177225498; 
 Thu, 26 Feb 2026 23:27:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:2c1a:3780:4e49:dfcf?
 ([2a01:e0a:165:d60:2c1a:3780:4e49:dfcf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfccff00sm56251365e9.25.2026.02.26.23.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 23:27:05 -0800 (PST)
Message-ID: <68a2ca73-f3e7-4934-a1fa-efc688c641ca@redhat.com>
Date: Fri, 27 Feb 2026 08:27:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] hw/vfio: generate new file fd for pseudo device and
 rebind existing descriptors
To: Ani Sinha <anisinha@redhat.com>, Alex Williamson <alex@shazbot.org>
Cc: pbonzini@redhat.com, ani@anisinha.ca, qemu-devel@nongnu.org
References: <20260227072445.406907-1-anisinha@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260227072445.406907-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/27/26 08:24, Ani Sinha wrote:
> Normally the vfio pseudo device file descriptor lives for the life of the VM.
> However, when the kvm VM file descriptor changes, a new file descriptor
> for the pseudo device needs to be generated against the new kvm VM descriptor.
> Other existing vfio descriptors needs to be reattached to the new pseudo device
> descriptor. This change performs the above steps.
> 
> Tested-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Thanks for the change Ani.

C.



