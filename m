Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F355CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 05:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZMb0-00042s-9V; Tue, 16 Jun 2026 01:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZMad-00040r-BB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZMaY-00070f-VJ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781588632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Z8zc84+Y8S4dKvEtmYWFQFZZlFP8XnxlBQvAP6/aQ0=;
 b=YM3mvyRAd7Myxg1+2av7XRsMkRdq7mlU7MY+lnFo/RxGfJfPzIhi2eEf+wntwODoN7awCK
 Hq/GJaOtiIhuCDqddfjQIxOAVvhPjFXgpehsgaAvNhBOZjSKpgSYjjO2PQI1yN2Qc6fo9B
 uAlZHD2yKlfmwDXfTh9FxyzPEoLV4qo=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-cmyQZaelNA6qQI83YLCq2w-1; Tue, 16 Jun 2026 01:43:51 -0400
X-MC-Unique: cmyQZaelNA6qQI83YLCq2w-1
X-Mimecast-MFC-AGG-ID: cmyQZaelNA6qQI83YLCq2w_1781588630
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-137e49e896aso3622749c88.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 22:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781588630; x=1782193430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Z8zc84+Y8S4dKvEtmYWFQFZZlFP8XnxlBQvAP6/aQ0=;
 b=jyPNBAjJ/Ci4MVq/cCDZKiW49aukavNQsmpa2AWDMQAXNTJW7CO7NxXiMtKpDfpm5K
 EyHEHibHJ0hQM7qVkdb+WWXnDkHxX5lddKEublFOQXEEimdXSO/3A3MCPp35lqhbmbBr
 6q66wxmRVnlf2Cb+xS20lTjGiHZoiFKDteHxd5rstPZCi3JRsZXNNwuIGkAGRUksyLB9
 2XOG+AhtdPLl0zqpXDfaXYsF7aHOIOBG7Pduw2jjve5x6FT60zoeW9qGqglU0vH8WDee
 jflcmK3PGx30SLRq9Zt0dxuPFiO4UkowCmHwaVPXyPqfoQBvBz36p61+haLEEayEuotX
 NyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781588630; x=1782193430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Z8zc84+Y8S4dKvEtmYWFQFZZlFP8XnxlBQvAP6/aQ0=;
 b=A1N361VbB+H6SzbamEZ22b5Spsrwcrv1lMSwOGBW4uojM4SrY+BIUhKKrQiiPaR8cQ
 PJ+Ycc1sWAvL24YgdvWCPlVL+SMnroYuL/NYtIOOAtF4+S1jV6u0iB/AGZq6jmzIbty4
 aSx7fMkCLr35Eb8+CV72iGXZ3H3+ByAi/PIG5pz7nHW0I9lfmI5kAYIqowicm32UF/c8
 p57OsjSJsWO8v89gtKoPP5Ac6BhEmXSbDTvzduRWsyYuurE2TkofYUfktB+9zx6t51l8
 1lQSFyRJak6jKqPosmJyDT8zz5RT7T+4V+0mZSMdcRWUnT0SUBg30VRIh64vQPx5dxg9
 Wtfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RF7GgMTChoZO+HoV6ke7rvS1Ejr/iOVFHdbahvwxoo2PfkSPPtyABI0yyMccEKc/q1riVI8XsWkwu@nongnu.org
X-Gm-Message-State: AOJu0YzDkhqKpL3imz9EO3gMBPv+h2Un3wRNJfFMEG7wbPuVVI5t2daw
 iJxbC0/ClRm688xqK7IWI92utZq5u2NC3EULcty/sZnDKspKrckN1PiU6D//ynv2gmcIEdKKyFC
 zkaH8qYQ1p72WgyxlkSEgK0c5+TRPggP90CrZPUkkoV1hj8znfun3isPr
X-Gm-Gg: Acq92OECgK/XqUBFm5xBtGyU7oLJNTPu8BFTn4NkH7KBGYAuxFilYMjCrEPkVuqmLa6
 igTBN8rifg1QytNPqUoKtEXKXpYNtuv7xzQqin1c1oiLyVntcDxIU8X/VFX/zy81l4qG83b7QoA
 CpZ98YzydKbq7RQ5r1ub7GzdW/VaWj6Zy1dd5yXWEnz6Hk8IcM2F69mcv3aYGkbeGkcAcNxOObG
 4pztAiGnKZf/bPEvosLZY1Duanxf3uvho4iIeNX3CG3/OGpOK/pVo7NKEk5PoiQ7VhHquTulAl1
 hQG6kehFExVGkk4JUToKdOPrq3LY3JRigbyYdgo5H29HMu0SlbH1KjQCtS5p14mTURFAr5hfxnv
 22NTu+bEv+sh2WGNW2+rq6ruscwkFLDI8xhk1kwmkenkUB33iQF7P12bm89uIt7tp
X-Received: by 2002:a05:7022:913:b0:132:133f:63a7 with SMTP id
 a92af1059eb24-139857d69f1mr1083208c88.8.1781588629772; 
 Mon, 15 Jun 2026 22:43:49 -0700 (PDT)
X-Received: by 2002:a05:7022:913:b0:132:133f:63a7 with SMTP id
 a92af1059eb24-139857d69f1mr1083193c88.8.1781588629180; 
 Mon, 15 Jun 2026 22:43:49 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b9815a6sm12822286c88.15.2026.06.15.22.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 22:43:48 -0700 (PDT)
Message-ID: <72af3afa-c4da-4060-b039-bf732ef4f4e5@redhat.com>
Date: Tue, 16 Jun 2026 15:43:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] system/memory: Make ram device region directly
 accessible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 alex@shazbot.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com
References: <20260616052552.389021-1-gshan@redhat.com>
 <20260616013359-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260616013359-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


On 6/16/26 3:36 PM, Michael S. Tsirkin wrote:
> On Tue, Jun 16, 2026 at 03:25:50PM +1000, Gavin Shan wrote:
>> All ram device regions was turned to be indirectly accessible by commit
>> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions").
> 
> 
> What is missing here is the list of issues around
> direct ram access and how we are solving them.
> 

Sorry that I saw your request for the inclusion after v3 series was
posted. They have been appended to the thread as a reply.

Thanks,
Gavin

> Thanks,


