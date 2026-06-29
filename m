Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C8FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we5Nf-0005Ib-NQ; Mon, 29 Jun 2026 02:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1we5Nb-0005IA-Uq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 02:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1we5NZ-0004Az-HT
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 02:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782714117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4f6R0CXxBN8eUBL29prVX9w4nx5JdtEUtKzs/EhuceQ=;
 b=LdtDTHneyur8zUoWjLlcDitGg1JvQxL6psvbWo55qNEmsV2c3AKDcXqtGCr2EQKJom96V+
 CrP2KDYuZpyXm0aZU3LVEMhIYpHXM6A7HSGsX3wgdKFWGx1L/C48MHLaHKjEYd4sEWK0tI
 6qmIWYDiUuzbpL+69jdnhtd6lSqUOQE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-tnudvx-LONS2bZtg1VKX7g-1; Mon, 29 Jun 2026 02:21:54 -0400
X-MC-Unique: tnudvx-LONS2bZtg1VKX7g-1
X-Mimecast-MFC-AGG-ID: tnudvx-LONS2bZtg1VKX7g_1782714113
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-472a798fc7cso454016f8f.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782714113; x=1783318913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4f6R0CXxBN8eUBL29prVX9w4nx5JdtEUtKzs/EhuceQ=;
 b=PZH4xQ7twbvdd6bxZRh33q55Vnez4wI/LQNghe0gbPOQHwfv6IIpm4nrVHdFERv1aL
 u6iGcWE1+5FBcK1+BhABOQb1G6QOB7Wio5bLKAwxmR8JPwqmFSE0YKQrV+x2Yf+FbhWU
 NOiFStXlQSCATxgRMRoZ2yVSAECs8KNUDgsZPQUvd27UaOC5ySKdOtdNoZ0W935vHkwi
 BcTv8klPUm8oJ7EaD/sQtUszZYep2MeTIJc4Ys8y2cm+mLP+cgLGbITtPr0yKtD59CcV
 QEZM4THhHp8T7O3oMD/bbCbCMucTIgZm8SYmxL1WUJXc0oHowqj2vDJilMZlotEuMkS1
 vDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782714113; x=1783318913;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4f6R0CXxBN8eUBL29prVX9w4nx5JdtEUtKzs/EhuceQ=;
 b=U7d5rpn9rvXiLVCEVBh5N/98c5z6AiEyIUto/DiTeeKxNFpfO+3iE9SlOlns1W8OOP
 cY8XfiYqBmLhsTjgdi/vlKuJbtOkaiR7zfR7+eciV8ky0s+kCTd3WvECSiwB9Nln4DfO
 bXdPFtB+UypIt+f6wPzxHOi429bFXqiXdgLH70DRLHa1Ygj55bUgHRinL1glY65IqTPR
 u86ST5HAZBPEfAgHv51trVliSLwwVfSMxHtLLF5W2GqwXsp3tMgSVRJpZmMZ6i6kv4iC
 +ssHn02Kvh5PHh2jOWvhagv8UL/DiS5BXlT2u1IHljTyQLmZYKZLj44VdR8rDCcsVSaL
 r+8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dhqq8avT1ec1zIw7dQ8sdPFJbBEyMRNU/HqF2j+FFOIqv1b5XqAwVXCClZ7yzo8zFxm4XoCz9IXR0@nongnu.org
X-Gm-Message-State: AOJu0YxVqscKL5dMWWrGDlzblaC5WL4K3xVuoS+/+bVT/nIenslpR+nG
 2mduoprqiS5XSEQ4KWePA1l6qKqfZvsP7ZDZayq4l3DLNkYJxXsVMjQyyEtL8Aw482J7ee+r6H9
 4IaRMP7ienZFS/0qlZXVjxWO0Ee08SywJBpOiwhar5PUdKhmpOBqEjFFl
X-Gm-Gg: AfdE7cnLMvaFYJzX40MfuR8Xq1TXkmuNRGRtkj6sTvSGbR0FJ5zLn52XMJwpuaDLPu8
 3ZPrhQ7N6h81WScpXE6QlTVPd1kW+QakhywOf4PXUI0bvloeCmI8ffj9BLiZ0TczzVoMqdWfmiR
 jwOcwmrUTRDWBa9MBGtFYePUstaWxQpqtp2PiE1Ym0UFkmb7v9onqb55Oyw1m4St3ijWaptjbGI
 cN9MBzJknTClP9QknEeIkfzK6ms+JcNbqJV5P2imHKvGSmurnC9WPPDjI/ylJMZDYJiuRhR/Pom
 TFzXUqdjpW1Lur+TXUKgsLI6ZPgeSfqqybUqiDTSdrvd2kqe63lIqm5XvLK/asEG6L9Cckj9Klk
 y7N2vXjs=
X-Received: by 2002:a05:600c:3b24:b0:490:bd66:db49 with SMTP id
 5b1f17b1804b1-49266850100mr247147915e9.12.1782714113308; 
 Sun, 28 Jun 2026 23:21:53 -0700 (PDT)
X-Received: by 2002:a05:600c:3b24:b0:490:bd66:db49 with SMTP id
 5b1f17b1804b1-49266850100mr247147655e9.12.1782714112988; 
 Sun, 28 Jun 2026 23:21:52 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.50]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492690168d5sm402370205e9.14.2026.06.28.23.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 23:21:51 -0700 (PDT)
Message-ID: <5ca03dce-aae9-41ad-b05f-60835634ff38@redhat.com>
Date: Mon, 29 Jun 2026 08:21:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: new roms/ content for hexagon: h2
To: Brian Cain <bcain@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: "deller@gmx.de" <deller@gmx.de>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
References: <CH4PR02MB1068109FAF2014DE3A545D5EFB8E92@CH4PR02MB10681.namprd02.prod.outlook.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CH4PR02MB1068109FAF2014DE3A545D5EFB8E92@CH4PR02MB10681.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 28/06/2026 21.44, Brian Cain wrote:
> Hi all,
> 
> I'm working on upstreaming support for hexagon system emulation and it'd be 
> useful to add the h2 vmm to QEMU's roms/ in order to simplify booting OSs 
> like Linux.
> 
> To that end, I think the initial step in the process is to mirror the repo 
> in the qemu-project? https://github.com/qualcomm/hexagon-hypervisor/ 
> <https://github.com/qualcomm/hexagon-hypervisor/> is where the code is 
> hosted now.  And once that is done I suppose I would add QEMU patches to add 
> the build process and build output into roms/.  Can one of you do that 
> mirror step or suggest how I can do it?
> 
> Thanks,
> -Brian

  Hi Brian,

I think Stefan or Alex can most likely help here.

  Regards,
   Thomas


