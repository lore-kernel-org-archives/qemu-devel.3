Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BFCCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpaI-0007LM-FC; Wed, 30 Sep 2026 04:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xBpaG-0007L3-Rz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xBpaF-00084b-CW
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790756553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dlVvmR4Xv3FTyagNaya954gZKJqWANqjSoT54ff9/wk=;
 b=SbHnklYMN5gbKgFSPTCDxPFGoOeg5snw8XIUlIrUsPmpCGDZQWA/e6dKeXJMwLk/+Kh78h
 QuJ3Rq8IKSXcv0rlPveyfYEyNRegthXe22+7Cgynmi0hiVcB/k/47lqzGpqkJ9ibWDsyIq
 0ujbZuW28wQVzVbAvP40/UIQFxEPJz8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-v76R-mBwOPGl7Hcrv3GE3A-1; Wed, 30 Sep 2026 04:22:32 -0400
X-MC-Unique: v76R-mBwOPGl7Hcrv3GE3A-1
X-Mimecast-MFC-AGG-ID: v76R-mBwOPGl7Hcrv3GE3A_1790756551
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a004b70f99so16995005e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 01:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790756551; x=1791361351; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dlVvmR4Xv3FTyagNaya954gZKJqWANqjSoT54ff9/wk=;
 b=PYHQ62bG2Ed/WBwhNNnuwGQKnTG4GmCpsHpm6fad32nZpyOFOqZPE3xOnle8zIFdvC
 6aoYLqw/uKWCYHqVsuKCZ/o0L3fZYvKDWkUJ8EGIkiLpaZdOPVofwhINTtsOBQCKdAsq
 rXowM4vzCrYX2kV+fMgVh2qHOXNpeQpGXYDVgYsid5nS3ZT62DQxAVxX9RhYO74eUxNd
 7VKeTEY/KCkEKJpJxyyDjlwXnH5QHJeUMayyCLgyR1LfGLr/ZW//KXcDEn2Usxd30f48
 cuC3F+yYmXv6YksLDV+tOElXoWxrbTOSJTG7ZZnJHeVZmhdj7dmk/fjFw57x+xHC8XMP
 TSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756551; x=1791361351;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dlVvmR4Xv3FTyagNaya954gZKJqWANqjSoT54ff9/wk=;
 b=bBse/WRpaHVru+J4TtVmMAy+FfjpLCZPUCkhLHJSqmnZp+JLMc7bKrogij7ltH+Rfe
 XXy6gHo7onAxc3FewpRUYF04i85Z7Dy9ohpUvNjbsLjdiBNl9ZPAi/vBDV76/vXAmCnQ
 D5fMAhQlmhwmQJcWEPka6nqQNCYQieVHbqktbJJxWHZmljvy/GIgib3CmrGfVTNJ6gR9
 38ixDJVsiG4fusm1pbYIMzxAzMP+7CGvc1nr2SdrDiUZxTOlprqQWIGg43x4i2fc8BfM
 mciWVwc/DeT9ez+DAp1vhGWt9HioqShr0IV/Uw2aoPNa8D+OLgORY5IzXX7msTkGvKmR
 GAyg==
X-Forwarded-Encrypted: i=1;
 AKwUvByiRVu28q7sWi6NamMGsFBqZ/aDknNehW8zHGPk63nTQCqf+GH3ziEpieIcDZw8ivfrG1wRmTQShzrC@nongnu.org
X-Gm-Message-State: AFuF++nfHZwRfaQwZI9+s3HGZa4FkoX0jIZjrtpBVs1CI4OrQMX7PMpb
 uyR8QTY3k46+rn6EDeCT992y5Nnmfj+2VEX9iKdCfVecY1nPqbMe0dy+LdBOOk/MvNgEyH56rY9
 0l9zOPmNAWNRd4s77hWfRYRNZRuEFDIY9dRa2f05AID3HfQI+8FWmt4BW
X-Gm-Gg: AYBFou1wNO1dQvaJoZUC+oTuxaAJQv3HOp7NlsZgOyv0XaaMwYmpe6BPJwnmZsBtVcm
 Mtfr5LBpsKDRTjs+y/TWY+d9lwwulHCeIHFoeKI6w0MxLF/Hj96mGNQehiflAhajzyvpgUTo40L
 mumbXHPhdW7ItB+bBSbZW0bkXOG/Wtfqg6oeIq6j2s9iTDx6FRmsYbV4yuuZN18QOpHjH1Or71P
 iM6NaUBUt4+w/iGCxz+Ivpjc/Ojyxm7CKUhYw8NIODEpp/wkVcupPPTdl1kF+Yr1jC0BEB3NaJj
 1Y8lwwCW8Uj1PM1/icjjMkntDIc2nBzZzfPL2UI8gahUKCoYZcFnE6ZN9TArDglka+n5ZfOkpW1
 7QoujyPF8U4zcsWZ/0G4MrSic86aMBj5Z2BkXrGsY
X-Received: by 2002:a05:600c:800e:b0:4a0:3c3:1ad4 with SMTP id
 5b1f17b1804b1-4a01b11de4amr9964205e9.22.1790756550893; 
 Wed, 30 Sep 2026 01:22:30 -0700 (PDT)
X-Received: by 2002:a05:600c:800e:b0:4a0:3c3:1ad4 with SMTP id
 5b1f17b1804b1-4a01b11de4amr9963795e9.22.1790756550500; 
 Wed, 30 Sep 2026 01:22:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0175161c2sm41638105e9.4.2026.09.30.01.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 01:22:29 -0700 (PDT)
Message-ID: <35b3f7ef-b73e-4226-82fc-530c65a85fae@redhat.com>
Date: Wed, 30 Sep 2026 10:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/19] hw/usb: Add a usbredir server transport and
 AST1030 UDC support
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
 <SEZPR06MB7362735328EE335AB120EC9CFC8B2@SEZPR06MB7362.apcprd06.prod.outlook.com>
 <c5895718-877f-4027-91cb-e1e5b84f3e02@kaod.org>
 <SEZPR06MB736216B99A28F03C48299E31FC8B2@SEZPR06MB7362.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SEZPR06MB736216B99A28F03C48299E31FC8B2@SEZPR06MB7362.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On 9/30/26 10:05, Jamin Lin wrote:
> Hi Cédric
> 
> Thanks for the clarification.
> 
> I will split the series into ASPEED and USB parts as suggested.
> 
> I will also take a look at the Minerva series and see where I can help with the review.

Thanks a lot.

C.


