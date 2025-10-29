Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9B6CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 06:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE03c-0003S4-Lk; Wed, 29 Oct 2025 02:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE03Z-0003Qj-5p
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE03Q-0002sz-UA
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761720782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bB6XHtyLnaCBhd9j2JUE3VkBWD54UKnG5MRs41CJFTU=;
 b=RQ247O4o3pfALt5OiG1iVpjUC6YrR8GQu81JGD3hX8ttZwqhJjp+G9GEg+27Q0NIIuP2Qn
 uaqOKj9pd0B6iBVsOmKBobhoOQSLci1hs51rS9s9KlH1Vt79GwlRcQdoiPgukiMyRgsGlC
 n6DncRmMVHb3Yp8jbFbCW3r+5Av62WU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-_yFohV_SPwa_0a3o5RPjFA-1; Wed, 29 Oct 2025 02:53:00 -0400
X-MC-Unique: _yFohV_SPwa_0a3o5RPjFA-1
X-Mimecast-MFC-AGG-ID: _yFohV_SPwa_0a3o5RPjFA_1761720779
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4771e696e76so4748325e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 23:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761720779; x=1762325579;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bB6XHtyLnaCBhd9j2JUE3VkBWD54UKnG5MRs41CJFTU=;
 b=D5OVgf7tomGjlXzG/2t+d1TDaIl9iPcp44cOLXBI93trtC4XeEIhwfeQfVSsuUpyMD
 7lWyrlz7AQ0IXEdGM2/fiqj5h9DmNZwz0+OFu7HV2Hio0RO4T1FDL7XcjsNFUgm2Xa5F
 Zbm3aLTR8/hV0cOlLZBQRVnWgGLzSAd91qq9tTIzgp7jigC6FhbyxC6BYlU3sIWw5TXt
 /As2BXbTYyQJPdCaL8rYTBQliqsgDS77w7ZcUfkdzNL/Epqt8kPuLtmdgQaVYllJRIvw
 5RMBNYOdq4NmENIvYGG6DcvYZFipPO6fSWNxzKthKamhKJekSxLgcAPwgzlXVHrFpPLj
 aZwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxCGm8RjEt7oi3DT4rD5zx/mjrUdSXeV/5/OosHmZJSXDhyrajLLI1q7zGHe1YAIhggGt3p1jSvWVu@nongnu.org
X-Gm-Message-State: AOJu0Yx+VH2xChEEogsWJBhuXVWj1A849YHdqtXrdhRFchtw67PQOeJF
 +1cjcz0w4hM1M1RwgnPoA9uR32/8G0QYqeDnYopOAliiKzQE9HWDX6HGXBzBp9JDrP8+WNQHumQ
 qAn3MSjTVtdwW6jY8djNto9hAGqMxdHMfR9Xi437uBib8U9ekUPdhCF4j
X-Gm-Gg: ASbGnct9kRhLJGSdoNl2iYNV+sa87cqjdW9h3JA5Izr2Q1cu5fMPYcloGEeLnK81keP
 Z7GLqPInfVD3x9z6t5BAbvlYlAvkE5JOHwNaliFtrgS0sITqu4ToGl4iDsBeGfGBTA9Lz6OGkep
 sjhTuDj2ghVJJfhuCNN70COLr/lYjJzDwvxCgAGrQlBtueNGSymvbfxrhxdDs9rzldJFm+VOQOH
 1rnveRSlJ7cMB8w6xOv8UmFjvYvZggIGJj1JM+rduS5FcBpvcPr1eGPkWkQcUI9Y05ki1+N72z4
 1oHfjDaPApSnO4rR15qMdO+JaKAYjiJFeOC9r2vBRqMtaHPNvq6bTKefuHxU6nvP+u9h3ZQ=
X-Received: by 2002:a05:6000:1445:b0:428:55c3:ceab with SMTP id
 ffacd0b85a97d-429aefafc11mr1035898f8f.35.1761720779360; 
 Tue, 28 Oct 2025 23:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQrzYzGxAjmhrQrc0/jgTpp9VmGpVlrnlTQbXUnb8QaG0JPPJByxulaYHfXSqwPb16G4ckRA==
X-Received: by 2002:a05:6000:1445:b0:428:55c3:ceab with SMTP id
 ffacd0b85a97d-429aefafc11mr1035885f8f.35.1761720778875; 
 Tue, 28 Oct 2025 23:52:58 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d3532sm25170459f8f.20.2025.10.28.23.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 23:52:57 -0700 (PDT)
Message-ID: <46ac8536-58e9-407e-9ec5-e0e6c67fd80a@redhat.com>
Date: Wed, 29 Oct 2025 07:52:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/sam460ex: Update u-boot-sam460ex
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Cornelia Huck <cohuck@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20251028151923.10DBB5972E5@zero.eik.bme.hu>
 <ee77b09f-7a12-4d52-b5f6-2d4b5b711448@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ee77b09f-7a12-4d52-b5f6-2d4b5b711448@linux.ibm.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/10/2025 07.31, Harsh Prateek Bora wrote:
> + Thomas
> 
> Hi BALATON,
> 
> I am unable to fetch it with b4 am, and I do not see it appear on lore also, 
> not sure if its due to the binary size.
> 
> harshpb:patches$ b4 am 20251028151923.10DBB5972E5@zero.eik.bme.hu
> Looking up https://lore.kernel.org/ 
> r/20251028151923.10DBB5972E5%40zero.eik.bme.hu
> Grabbing thread from lore.kernel.org/ 
> all/20251028151923.10DBB5972E5%40zero.eik.bme.hu/t.mbox.gz
> Server returned an error: 404
> harshpb:patches$
> 
> I guess you may need to send a PULL SUBSYSTEM req like Thomas did for slof:
> https://lore.kernel.org/qemu-devel/20251027074404.25758-1-thuth@redhat.com/
> 
> Hi Thomas,
> Is it a known thing to deal with binary updates ?

  Hi,

honestly, I can't remember clearly why we introduced these subsystem pull 
requests in the past ... Maybe it was related to some problems with binary 
patches, but I think it was rather meant as a staged approach for the case 
where the maintainer of the firmware is not the main maintainer of the 
architecture subsystem, so that the main maintainer gets another chance of 
doing tests before the final pull request to the master branch.

Conny, Alexey, do you remember?

  Thomas


