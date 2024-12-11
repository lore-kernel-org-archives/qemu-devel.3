Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B203BE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 08:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLHfW-0004LL-TL; Wed, 11 Dec 2024 03:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tLHfV-0004Kn-76
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 03:02:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tLHfR-0001s0-Oy
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 03:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733904115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hcc+omil9zLZ86uj1io+vFVrjtyesKucHo4fjI37lzI=;
 b=ZafsEIPPNl93ydFeWLS4LKtkcjayrEZfrHXeTeEQyoiB+t4vviXEEPlp+3kIW/D0lUvBU/
 srbibpguHzsSaRQo/qHgXjTJrCgviULrmWVO6bZAM0qC5BHuK7tZ+SNeYkfrW+j3y+JKAQ
 u5EzbiFAaX3oQr1FlnGq0qb//vqTIaE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-20QWx-2tNLKHCJ3KV_ZDpA-1; Wed, 11 Dec 2024 03:01:54 -0500
X-MC-Unique: 20QWx-2tNLKHCJ3KV_ZDpA-1
X-Mimecast-MFC-AGG-ID: 20QWx-2tNLKHCJ3KV_ZDpA
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ef9dbeb848so3352867a91.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 00:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733904113; x=1734508913;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hcc+omil9zLZ86uj1io+vFVrjtyesKucHo4fjI37lzI=;
 b=iNskgWI7bufujr1BaO3NsHWfY2AYyeIKjkR/PCB8U1rEsWuj+5pK8Cjv2AsQ2LiipR
 yeHmRpYx50+4A1sdpqbb55tnOjjnBqrd2OUEHZhgLLlfBMMKMfmROoWaL2q6VUnBhyJK
 UKJA8KHvzklCbwbQWG3QYAdj/jHivAN3vCpgEyInAzvS3PXme2Bk2xJ+SxkUoIDPoa2U
 1OT7+uOVFrGxe5Mo+5mjQ/pYMjoM5j4RKKfJ01vZ7YWelTffUFz9HrDnwDO6p2aO76Zr
 yR8xgRgP8V5NhtFtDS2qSj/Xd1PuVlVqijQvs601lLfb3Z4K6y8w6Uz+MSYCk/IFvHeI
 DSCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU608USEqcKW2pHsdzy9aiVDNvFfoK2USXx39AhDKYMhDL9WNNvolDCGRrPOmDkgrqQVd9cCvT7ta5y@nongnu.org
X-Gm-Message-State: AOJu0YxaZBPXQBWQUBtsZnhWGMg8gwTYZgcQ5hyBxKD27WHb/+YvdUFl
 FV1E1s/xwwvl795dDRDfhQ2M5vkIyd1dxvtjFedzo/BZplxrjnBa3+qUQIlKSoGJAqQVCHZEcD5
 RJA5m8m2kZxT+jOO/PrijmqO8geolQrTLAX0+WCcJISM7GJl4YWYK
X-Gm-Gg: ASbGncs/mYJByhiu4OBV0cWGJygxzXc+/NNcMT5wea6A+qjxJp70iPQa2r1mMUMX8/n
 VTEcgGlRlejbrxAjO/yRR0I+9G8eYC/kc4N0IXLkpt+WXJao3Of8BqvGwosIufF5FePW9QLg4hA
 2kb3OigdomcrE/OYi95inoAlrLYSbFD7U6iWNHbCmKp85sO/q2kPMaoDZ/+7QnbjYoExxAfY4bz
 54QMSthICvjdnhiXNnCdFwA2t+v1d7C3j+WikFTjKd4EgDRclLW2w==
X-Received: by 2002:a17:90b:4d04:b0:2ee:cd83:8fd3 with SMTP id
 98e67ed59e1d1-2f12804a589mr3034321a91.33.1733904112929; 
 Wed, 11 Dec 2024 00:01:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHP245RdeeHWxkhRtJ/TD5b5MjU2WCTIsgj2TmeD8eiED8rLROm7xJFJaTG1uNSXbtOs2ZfSw==
X-Received: by 2002:a17:90b:4d04:b0:2ee:cd83:8fd3 with SMTP id
 98e67ed59e1d1-2f12804a589mr3034273a91.33.1733904112511; 
 Wed, 11 Dec 2024 00:01:52 -0800 (PST)
Received: from [10.72.112.56] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef26ff97f2sm12981054a91.11.2024.12.11.00.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 00:01:51 -0800 (PST)
Message-ID: <cd4c928d-83ea-4e63-b35f-69b71963c929@redhat.com>
Date: Wed, 11 Dec 2024 18:01:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/26] arm: Run Arm CCA VMs with KVM
From: Gavin Shan <gshan@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Gonda <pgonda@google.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <8504f92d-03fe-4a0c-a647-0003d9c8772c@redhat.com>
Content-Language: en-US
In-Reply-To: <8504f92d-03fe-4a0c-a647-0003d9c8772c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hi Jean,

On 12/11/24 1:01 PM, Gavin Shan wrote:
> On 11/26/24 5:55 AM, Jean-Philippe Brucker wrote:
>> This series enables running confidential VMs on Arm CCA. The host KVM
>> support is progressing but still under discussion [1], so there is no
>> urgency to upstream this series. I'm sending this new version to give a
>> status update, and also to discuss remote attestation below.
>>
>> Since v2 [2] I addressed comments on the QAPI patches. The support for
>> running Linux in a Realm will be in Linux v6.13 [3], so the guest-facing
>> interface is now stable. One important change since v2 is the requirement
>> to initialize the whole GPA space in RMM before boot, which we do in patch
>> 9. The 'earlycon' kernel parameter now requires an unprotected address
>> parameter (see Documentation/arch/arm64/arm-cca.rst in Linux v6.13).
>>
>> Documentation to try this series out:
>> https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/Building+an+RME+stack+for+QEMU
>>
> 
> I followed the instructions, but encountering some issues. First of all, the
> recommended TF-RMM (branch: cca/v4) fails to be built. After switching to the
> latest upstream TF-RMM, it fails to be initialized.
> 

Please ignore the issue. The RMM service can be started successfully with your
recommended tf-a/tf-rmm repositories. I don't know why tf-rmm wasn't built
successfully and all looks good after I reconnect to my x86-64 server. So
it seems the environment was corrupted.

https://git.codelinaro.org/linaro/dcap/rmm.git (branch: cca/v4)
https://git.codelinaro.org/linaro/dcap/tf-a/trusted-firmware-a.git (branch: cca/v4)

Logs from the host side
========================
INFO:    BL31: Initializing runtime services
INFO:    RMM setup done.
INFO:    BL31: Initializing RMM
INFO:    RMM init start.
Booting RMM v.0.5.0(debug) 4e2e764 Built with GCC 13.3.1
RMM-EL3 Interface v.0.4
Boot Manifest Interface v.0.3
RMI/RSI ABI v.1.0/1.0 built: Dec 11 2024 02:52:28
INFO:    RMM init end.

Thanks,
Gavin


