Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A52D65C7E
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 11:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBYLc-000569-AS; Thu, 14 Nov 2024 06:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1tBYLa-00055m-QY
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:49:14 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1tBYLZ-0003xX-4h
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:49:14 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f5d4939so5984a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 03:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731584951; x=1732189751; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=501jsXslFSInMb22a4IkIVmsRKR1Y9JBkjmGZehl0Zk=;
 b=boQriYt45rM8N4KdB3iueoutoy+EcOeijCg4NPbvMzS/M2HtKZvrhYnHdtiXZNcL4B
 qBt22Kdx7hKkgJ0zLdslvJhqqF3Nud5xyy0uYiL7rSaLwaSVEwdyY4hAy1VNlNrwMKIy
 F2lDFMqFmwnGKxugrJ+Q6Gib+AA/USxjBL/0zc0Xw/rAX9QvvtYNwl2RMsIfSXmaE4DH
 MrYojzbaA8a8gd3M+5JXz6nZlCpGEnbOazDlYyPm2yZIm0dzVaUquVwtyAM53Z5dP5EG
 DWQ63aKEQSm5qQqLNqbCojmYAtLgSDU5p+oUf0ionZ8p2csJlKoo3J8AR2gwfBi1NO7r
 NEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731584951; x=1732189751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=501jsXslFSInMb22a4IkIVmsRKR1Y9JBkjmGZehl0Zk=;
 b=sGhojz+7Y3dRTKYN05dOe184B3LKd4G0yt9VG5dfGqsmI+J+ALVrmFOa6Dp0I+9n/n
 PYnDLL9LyO3l6tZ7LrgejQGgZ21AwykfSrX/OqOnqUEC1OBL7J/gCEWuOuEIcu7aaiAi
 dXz7sXmzTl8xCttymmcnP6O9BQ+nUlkncnI5Thc1IgOselh9hz8onesrik7l8hIaXUKm
 vD+bPaSuwRuOrLr1cO0PdzbTYcaNTuaNdKJIcJulBbBGI4Gcd4JQv5x9IOHis2+zcOXj
 5C0khZYkfw6l2L34JQJ7M7s4kP0ap1kjR7PDvyA8IBCT0aLwFjyN8Am1i3R8kf/z9FFl
 ooiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMyidT+7jZu40U+hUV6hVsz4AgTeVXb8CobdH3R7A+AgbZZ4F+V59HpBlRBK1nX2FWV7OP67OjTCzP@nongnu.org
X-Gm-Message-State: AOJu0YzxidfspO4/NPQDntvaNzAaE9l/FFN4ASc2nV1r+5R27E3pRaJ8
 05YRCgKIyLWaCSu6b0h4WubmaDacGnrqalCrBAsPCzeJ9boHGAsCWci0nE4zZQ==
X-Gm-Gg: ASbGncu5/qDQJTlZv4e86mw/KwNEi5+IvrFkeswKzTkNYYkS+KTkb9ktKUuQAGwYX41
 Yn70iGy23dOjeI3mlRBFMCMUWKIxYeXNIBbnh33yC9a2c85fqtXxP4WH+OQNDuIxjoLbM3XxYQH
 +hjBENaJAdxhRx/wOYdZw+A2z5piXBoN+8fbpBYjY0XW/chSsbFk5o/9SdmLm8r/3pQiUdJFiii
 uJ8aABrvF9ipC7xM6bWS08EHKUU2yaq6e8KOjxR3454ufmImVLPPQCM6pW02PeJhRI2/mQBgUL0
 /xjaJlZncrO1
X-Google-Smtp-Source: AGHT+IGPSyJuSt51/AgdCLGCLUbLqkurcJW58Oj1SBMdTSitkgFMfHIHx6mlmESYNs5TIZCPQMfGOw==
X-Received: by 2002:a05:6402:1cb1:b0:5cf:7b6b:8eb6 with SMTP id
 4fb4d7f45d1cf-5cf7b6b8f0dmr103286a12.2.1731584951121; 
 Thu, 14 Nov 2024 03:49:11 -0800 (PST)
Received: from google.com (158.100.79.34.bc.googleusercontent.com.
 [34.79.100.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da29ffe9sm21305275e9.44.2024.11.14.03.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 03:49:10 -0800 (PST)
Date: Thu, 14 Nov 2024 11:49:06 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <ZzXjsvIz-ukxXi2Y@google.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <ZzTQ5Dn8ckIJjxc-@google.com>
 <200df57473694689a914e16f3db8db59@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200df57473694689a914e16f3db8db59@huawei.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=smostafa@google.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Hi Shameer,

On Thu, Nov 14, 2024 at 08:01:28AM +0000, Shameerali Kolothum Thodi wrote:
> Hi Mostafa,
> 
> > -----Original Message-----
> > From: Mostafa Saleh <smostafa@google.com>
> > Sent: Wednesday, November 13, 2024 4:17 PM
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> > nicolinc@nvidia.com; ddutile@redhat.com; Linuxarm
> > <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> > jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> > Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
> > nested SMMUv3
> > 
> > Hi Shameer,
> > 
> > On Fri, Nov 08, 2024 at 12:52:37PM +0000, Shameer Kolothum via wrote:
> > > Hi,
> > >
> > > This series adds initial support for a user-creatable "arm-smmuv3-nested"
> > > device to Qemu. At present the Qemu ARM SMMUv3 emulation is per
> > machine
> > > and cannot support multiple SMMUv3s.
> > >
> > 
> > I had a quick look at the SMMUv3 files, as now SMMUv3 supports nested
> > translation emulation, would it make sense to rename this? As AFAIU,
> > this is about virt (stage-1) SMMUv3 that is emulated to a guest.
> > Including vSMMU or virt would help distinguish the code, as now
> > some new function as smmu_nested_realize() looks confusing.
> 
> Yes. I have noticed that. We need to call it something else to avoid the 
> confusion. Not sure including "virt" is a good idea as it may indicate virt
> machine. Probably "acc" as Nicolin suggested to indicate hw accelerated. 
> I will think about a better one. Open to suggestions.

"acc" sounds good to me, also if possible we can have smmuv3-acc.c where
it has all the specific logic, and the main file just calls into it.

Thanks,
Mostafa

> 
> Thanks,
> Shameer
> 

