Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6DDCA0EE8
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 08:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjwhL-0002bu-HY; Fri, 30 Aug 2024 04:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sjwhK-0002aj-5I
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 04:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sjwhI-000259-9l
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 04:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725005370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRM0z2YiEimXmzOjezTcVGa11bxpmbinpvMckbeEPP8=;
 b=CSGoHF1XOhbXYFNT66RIHaUuQD4NLyQCYjshQETtxwSCT1FY2oT96oP88Sls65ijF6uwUf
 PxxLmvXpjlZZ+whZjPhfFW8krrHSSXt2rz3T2+Pf9/5HdMibgh7b0gcT1zW9RPhLuofo1e
 TWyfMIbcvBHmJGZNJhG66pwP/V9BZuc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-kvpfcekVMyq_RheZAXz20g-1; Fri, 30 Aug 2024 04:09:28 -0400
X-MC-Unique: kvpfcekVMyq_RheZAXz20g-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6bf6d3e210eso18040036d6.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 01:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725005368; x=1725610168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cRM0z2YiEimXmzOjezTcVGa11bxpmbinpvMckbeEPP8=;
 b=sFL857PF5LYkEX1HB2Z+SVamTsp6gIKikehhNg1com1ZUQaaQC4AxxlhY35VG7bwD7
 EoHXojEZYjtaUysxWdjU4O74uK7Gbtqz5umUzluqbc5sxxyZwuNXmysF8cD1RWbAGExL
 nbXe2rqtxzGal4zhnZtjmKwQOTLQQbnBZ8IFnvGeuKLVWB6L0NkcI/qHszCGLhD1gIuB
 ZVcsXBya/RySITnu1hAkP+sn/IuzQ2j8krcEoNWZn/vmtrXKG+WCaK+gCOdXoIUkzbaa
 /9+OFzBYmWujBTCIHS7kSF0Yk8PPFz8A+896bXymvQ7EghcuRr//e6TY+oxOdPXIHsfh
 E4wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfwr/6weVsBU+lq5LYAJcfh51BKPJuOYvH+CfDlU4NMxqndgQRnp97NAcGZzYCzaS0VYDyWUbJQwzu@nongnu.org
X-Gm-Message-State: AOJu0Yym7b3d9aZllCi7a4AupJcQ3/a1Jq6AmGAQ2Eimeg+V+h9U2ziW
 wI++NVPmILQRi6M/tQp5UeZ57Q2BDWgNA64/gkyhhqxNEJChTU8NNbNze5eWfnVgYwf2DHLfvsi
 YqSOTc3I6DZKX1a4w2VkzvfQ136latjGfawfoG8sGqMOba4hBHN1G
X-Received: by 2002:a05:6214:3f90:b0:6c3:4851:36a4 with SMTP id
 6a1803df08f44-6c348513c18mr22577606d6.26.1725005368442; 
 Fri, 30 Aug 2024 01:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqaABIVu/CqmaL4q20hfk8jDsAyCFeCwyiY2/EyqorpdzpBYetk/NXc+SoiUZWqia6QyhMHw==
X-Received: by 2002:a05:6214:3f90:b0:6c3:4851:36a4 with SMTP id
 6a1803df08f44-6c348513c18mr22577436d6.26.1725005368091; 
 Fri, 30 Aug 2024 01:09:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340c00310sm12564466d6.52.2024.08.30.01.09.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 01:09:27 -0700 (PDT)
Message-ID: <bdb443f9-376e-4d4e-8c06-9ba0c5482c5e@redhat.com>
Date: Fri, 30 Aug 2024 10:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aspeed: Deprecate the tacoma-bmc machine
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240625070830.492251-1-clg@redhat.com>
 <4e04f930-e7af-4084-99a8-2a3139e2bf43@roeck-us.net>
 <5fb7342b-fa67-4cb2-b6fd-2241b7b76d03@redhat.com>
 <f70cb39f-3567-4322-b1c4-1bc5991d91fa@roeck-us.net>
 <8d1fd867-647b-4827-a2b2-a239618a7743@redhat.com>
 <014b83a8-d733-442b-ba33-a24c35e46f3f@roeck-us.net>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <014b83a8-d733-442b-ba33-a24c35e46f3f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,


>>> I solved the problem by adding support for IBM Bonnell (which instantiates
>>> the TPM chip through its devicetree file, similar to tacoma-bmc) to my local
>>> copy of qemu. 
>>
>> Hmm, did you copy the rainier-bmc machine definition ?
>>
> For aspeed_machine_bonnell_class_init(), pretty much yes, since I don't know
> the actual hardware. For I2C initialization I used the devicetree file.
> You can find the patch in the master-local or v9.1.0-local branches
> of my qemu clone at https://github.com/groeck/qemu if you are interested.

Oh nice ! Let's merge the IBM Bonnell machine. We can ask IBM to help fixing
the definitions (strapping). Enabling the PCA9554 is good to have too.

Why are you keeping the tmp105 changes ? LGTM. Same for the new tmp models,
they could be upstreamed.


Thanks,

C.


