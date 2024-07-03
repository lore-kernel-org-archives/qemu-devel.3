Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CDDC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvxG-0006MM-3B; Wed, 03 Jul 2024 05:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sOvxA-0006Jc-Ah
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sOvx8-0002Bf-E6
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719997619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XK2RnogXXFMHVqELY1/fjWq+hYQ5O2re9WqXfRh5bTs=;
 b=BnO4c2Cx6YWInE8yILXjLzx8j6XirvA2lPfyT5Dkr7LH3ldMxJOwY3JOZYG4SbEfdbJJ26
 MZH/pJFBrCtNyNyFpHH/0dmnYG0rYRGW2UisObna90WfQOaGCzW2PDIshT+KvmXEGruOQf
 iH0iPOSrAl5EHnFnUEI46EMJWchq8Yg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-ZuY5I-JZNASX6PvH478fIw-1; Wed, 03 Jul 2024 05:06:58 -0400
X-MC-Unique: ZuY5I-JZNASX6PvH478fIw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-363542774e1so5464419f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 02:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719997617; x=1720602417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XK2RnogXXFMHVqELY1/fjWq+hYQ5O2re9WqXfRh5bTs=;
 b=kxArdT/ObyYI1GrsGlHhpEGgllCpYOEz31mb3WBnzNd/RBjfKiYyB3G0Sibf1Mewb4
 JYa+051dhAgWxxDjOERf8F+SnWagEnlbiHWqttgcFPRx9oH0/Ku8TVlHg9SWdd8ta9R5
 gLI8IFEtD+ofTrGayRqsxbLt6SuLDSxpGRMitz95V8ru1QN+QalLcXprEoFOJKJCTDO4
 TfmskOrP8VjWMgLvvg348if7jxIGKto3fhLIBEC+f3MoDkZCUFQtxkyjs2ABQ+VPVMdV
 KYq5Vv7IZhWMUBNAVvPLxG97EX9BDyH8GV2jfmAhNpEcDMdfBqB/oDMNbsloCdlTCqx7
 TPPw==
X-Gm-Message-State: AOJu0YwnBpmStRZxlhWxKLgNX1e5PZrtl25wLqC+XaAr1pHuhcMI22/l
 KfAf1+Hb71gdliQVapTGsGTuuQ7083rdg0bvVkoHaTkFC/kszFKDe3MrPIl+uFKSLJDG+Ru5nmW
 4hpF4XJYZF33W6IEN03tI/ot9yosLFovoiCAsYw/jaLzrErGF/EDon4xUjs6kY60VauJthXeCAR
 E23KlEXIYGyWIa8g4v8ab/1L6yGX7kOMNLo4nR
X-Received: by 2002:a5d:5452:0:b0:367:955b:b8b2 with SMTP id
 ffacd0b85a97d-367955bbb3cmr619535f8f.18.1719997616769; 
 Wed, 03 Jul 2024 02:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8eZHYue1t5+/j1FqMDnZrnlpmdhunZ0j1XeyxwR2MW5JD7V9KW/+drdjanW7iJrq4YxFe6Q==
X-Received: by 2002:a5d:5452:0:b0:367:955b:b8b2 with SMTP id
 ffacd0b85a97d-367955bbb3cmr619511f8f.18.1719997616143; 
 Wed, 03 Jul 2024 02:06:56 -0700 (PDT)
Received: from [10.43.3.102] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a112a54sm15309621f8f.115.2024.07.03.02.06.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 02:06:55 -0700 (PDT)
Message-ID: <c138c88c-74ff-465d-ae98-41821bde7c98@redhat.com>
Date: Wed, 3 Jul 2024 11:06:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] i386/sev: Two trivial improvements to
 sev_get_capabilities()
To: qemu-devel@nongnu.org
References: <cover.1719218926.git.mprivozn@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <cover.1719218926.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/24/24 10:52, Michal Privoznik wrote:
> I've noticed that recent QEMU + libvirt (current HEADs, roughly) behave
> a bit different than expected. The problem is in recent change to
> 'query-sev-capabilities' command (well, sev_get_capabilities() in fact)
> which libvirt uses (see patch 2/2). The first one is trivial.
> 
> Michal Privoznik (2):
>   i386/sev: Fix error message in sev_get_capabilities()
>   i386/sev: Fallback to the default SEV device if none provided in
>     sev_get_capabilities()
> 
>  target/i386/sev.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Polite ping. Patch 2/2 is not reviewed and it causes problems to libvirt.

Michal


