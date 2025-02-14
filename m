Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1ACFC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 16:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiycR-0006JV-AU; Fri, 14 Feb 2025 11:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiycP-0006JE-Ow
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiycN-0002sg-BB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739550761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YMgd0IGrQ9/HXheJqZBUOiHsVPPWWanm9OCSB6YejEo=;
 b=f3fcwz4p8dDTllHeGfZ5ygjZ8GI2Jc5enIeHWVOLhxVNBsNin0YLuY6I2Xjvr5QZin8sdo
 XraUqWbJQTMWwr5yMDODy6F+4VXRyIsEu7U01gKHZ9OTXISC9K9tcU06km7OEfpXswwHJW
 A3HzsmPGvluN6kZ0X/2/kDxirmvzQEU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-ltH4OuEwNFyos5CUHq2kfA-1; Fri, 14 Feb 2025 11:32:40 -0500
X-MC-Unique: ltH4OuEwNFyos5CUHq2kfA-1
X-Mimecast-MFC-AGG-ID: ltH4OuEwNFyos5CUHq2kfA_1739550759
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab7ee92898fso278280466b.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 08:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739550758; x=1740155558;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YMgd0IGrQ9/HXheJqZBUOiHsVPPWWanm9OCSB6YejEo=;
 b=J6XLJRXhwuOMGSe+g9hyZeKTNYR10FE0pQ30qNImMiH2srXw1qvdlGOMNOk7pKVYCz
 kEGkaj3omtVdPltJNRG+40RmK83sxcuqaAiMPb1V6j56PApK6ndCZV+Z+tdk5Xxd/gbD
 OUTrDpnKR4vx/4siyzqaCltrmXBa7jBluCTiJIeQhBYsMUSUtodM/o9Y26uEKiONLjiL
 Zkcqp23w+9tZS4cpAiBEZ0eHfYZl5A1qIPY8PQj6fUm0A+nD9+S3/b4GTI16O5nxnejj
 AnbvK+bvtqTcaGJ/TDijGLJAS8DyYfCdphilQslRED6098GLxBfMNsGBiLlxfBxq2kWn
 f3Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz+yhizmg8QVplCVwNxk808a0r8tScRT4LjLHE6Ikbm/bZmcfi0yXEiu5+ILncCqS5kbOWFOZMSen8@nongnu.org
X-Gm-Message-State: AOJu0YxJNJsGLnFtN1xpaRodNU8ebObHu5cLIdYh3lDviD6GKkVMg7Qt
 46U6qjjsttCC2qZ+6E2pltEzXlfhW6fXhfU5kjUpv3ZyDLiOCHXUtVnlX8Bj7ZQ0MuHwElPLzJN
 Xpjni0nwqt0P/f8UFHv6XF+TI2+uZ0fFLxnjJn/Qr5wazRkkaAm6dsLBewhA6tRU=
X-Gm-Gg: ASbGncts+j0uk6OpXKQOETFgnGq8TRYUPwC8Ym+qrMea2J7OEdOdqaJB5jpg6Z0BueS
 v+4ePj29wa3AR6ICRFL+GK8JYa4KKV1s9YTqHuvDtXhzsQadKsRdcsGdRnImS2ZHb/P5AngoRW+
 fyodnmOHfpsXb6Ug7nFQgS2I1Yl1fDCMN6fSyJadMVyMSqRsCYyMg5rRnb+LNrsZU2vXlKqmbHu
 +/oux9dUNZgzFEC57ACZ8X3grDkyv2TwF/izgKHA6kNUnmCovLtXLaGfkWJP5zIqdHNxt9IKOzB
 NkcUWdXLsAifrQ==
X-Received: by 2002:a17:907:940b:b0:ab6:5210:7c8b with SMTP id
 a640c23a62f3a-ab7f347c1c0mr1386387766b.37.1739550758342; 
 Fri, 14 Feb 2025 08:32:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEavSFWwGCY6sN5Kh0fugmnrcHUmZlyMVV2RozvJqIutVoegLEteYnWKY+h2J3nskTr9hCmlg==
X-Received: by 2002:a17:907:940b:b0:ab6:5210:7c8b with SMTP id
 a640c23a62f3a-ab7f347c1c0mr1386383966b.37.1739550757898; 
 Fri, 14 Feb 2025 08:32:37 -0800 (PST)
Received: from [192.168.126.123] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-aba533998e2sm371327266b.134.2025.02.14.08.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2025 08:32:37 -0800 (PST)
Message-ID: <176dd370-ee5d-4c28-8075-47dbc2bd1751@redhat.com>
Date: Fri, 14 Feb 2025 17:32:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question: how to add CLI options for custom hw model
To: Mark Nesky <thenesk@gmail.com>, qemu-devel@nongnu.org
References: <CADQ=JkR046QnzWVV2=VshuS14r86riXUzLb3eh+Qer69N1rp0Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CADQ=JkR046QnzWVV2=VshuS14r86riXUzLb3eh+Qer69N1rp0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/14/25 16:31, Mark Nesky wrote:
> Hello,
> 
> I am new to the QEMU code base and I am working on a project involving a 
> custom hardware model representing a customized ppc board.  What is the 
> best way to add command line arguments applicable to my model?
> 
> I see options in qemu-options.hx + vl.c, but I am not sure if that is 
> the right place for arguments that only apply to one model, and I am not 
> sure how to access those options from my model.

Hi,

options that apply to only a machine or device can use, respectively, 
the -machine or -device options.

For -device this is done using the DEFINE_PROP_* macros.

For -machine, which I assume is the case for you, the process is a bit 
more complex.  A good example, including a varied set of types, can be 
found in the spapr_instance_init function of hw/ppc/spapr.c.

Another possibility for -machine is to pass the option down to a 
specific device, which usually will be created at startup.  For example 
this snipped from hw/i386/pc.c adds a "-machine pcspk-audiodev" option:

     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");

Thanks,

Paolo

> I also see the function qemu_opts_create which looks like it can add 
> command line arguments at runtime, but I am not sure where to use this 
> in my model since it seems like my model code (machine state, class, and 
> instance functions) does not run when invoking "qemu-system-ppc -machine 
> mymodel -help".
> 
> If there is some good documentation or examples, please point me in the 
> right direction.
> 
> thanks for your help,
> Mark


