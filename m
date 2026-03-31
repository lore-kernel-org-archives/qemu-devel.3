Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED3E109B491
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7bCM-0001uk-N5; Tue, 31 Mar 2026 11:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w7bCH-0001qy-Fe
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w7bCD-0007Ge-U7
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774971599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqJXfzPbcJ8rbluJHkYLrm+wzoulqcAdHwwKCTIymUQ=;
 b=TQbXq4S5mJYVz8yzeTTGqX71BkJjUW/sJ7aDXvqYRDGHwNt6NSxmvSBPqtBADmLPspRA5t
 0xNRpyXqjgVGQT062rOp4CLibDaQkqhWsixP/pn+vJNJPLciu1ZHAdhdpiLdcEGPvJTJLq
 YMEqatQg/IacBeKfNcxBrkRKnhXHISU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-pGSbas-HNiiVOeCxti6vLw-1; Tue, 31 Mar 2026 11:39:58 -0400
X-MC-Unique: pGSbas-HNiiVOeCxti6vLw-1
X-Mimecast-MFC-AGG-ID: pGSbas-HNiiVOeCxti6vLw_1774971597
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43cf7e96d4cso2579722f8f.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774971597; x=1775576397; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZqJXfzPbcJ8rbluJHkYLrm+wzoulqcAdHwwKCTIymUQ=;
 b=MGoUolL1YfNBg5Py3QLOlvyYaSRIJfgOZk3Ue7ck1z8BZLxPNne1ewqWI48KUz/PVa
 DtsaWUW4ktk04/EdvITZ9SvUEw3uGVJbV+6+F8NAAz3wJI9o1LMX3LU2NAMySMblgGAp
 I9NfF0E/T+13BrzXfmLP4bauZJzI7XwPGrv5+A1CXz/3QOSIE9CKDc7ycMsh66+VqDbM
 tPnUURJz0Yvk8iC8vh8fOBJexejR7qDot9TUvW8bQqP2nQjjznYF5HFOKZdMDx1NCUeO
 9GUx0/0e5+CkBxvZl17kRbsyQUbPr3X5WYwA1f3adcUcyI3Qol1vRYa0TsUgPR38rrCj
 osHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774971597; x=1775576397;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZqJXfzPbcJ8rbluJHkYLrm+wzoulqcAdHwwKCTIymUQ=;
 b=TIfkAsam67TmGK/6qzAVEKrwVLtpFuBCMQY4frYQ9xU61Ylo2orQ/v6t/06xVH3wGU
 5t0UfUWMnNq3Fk5PfBtJsstY/1yr8q1PWV1csyVz5ruA0F9Q9LtyvqfT42XHhADd2Enu
 flOxQ2n+8V+woAd+tUC5UPTslhZeYjJM3WBgrMs0pxteTccU3ZE+DXerLQnpbC+07Jmd
 o1tywmm3/i2zjCIGN8Mo+CygPd3xVEW5hIc4fr3PcDI1datZqZhH9pjJCSN3TC/3YrU/
 5Or5Je0ZYbPD86InWhHE984LYJxn1WMWOqZ11FEYzQsulDHujJCBGBkXpwcHdFwNbqa8
 4u6A==
X-Gm-Message-State: AOJu0YyOS7seIcYI3Hjsl7XpRfLVW9xlDlb2+QVX8omIzRjew1OyK2Tx
 YfJnYbHHSGxhTsMhMWy9LkrZYLal12sF2CYHUU+KOCpKCSrwph1MRswVE5/Q4V+H30VBgUV9Kz+
 aOO1tb4+rAafu80BWomQbtZRfPuuUiYCq5j/9tUU+Z30OMHuTKWibuNR7
X-Gm-Gg: ATEYQzwa5nIEu5TTyeOvyNExm2vzwyPOsE4cnfAZZcm+lIWsUOmdeGyYrspoLei0ZPR
 zWFgEQexR9/C1X2XUbm3spPAYwV8c6teTBNi9SW53FzcxFnTZ7xk7VblHSDyOjMB+cftwFUGkBW
 hazhg+MHmJRnKv7PMPx2d5kotc+30WPCw/tpXOX95xjDJ6zopQIygaoOdI5J+b0Kzt4f9W5bqEU
 y44ggrWEtgChR1YZ2gu9vEY7ZsAUtyyREOypS/B/9T3AId2oPMH+kLUefruDfR/6qc4oetTJtxC
 7eAKouTOKvc1v+IuSxUnazsvvRSCSoqaQ9zhsHwjAgLZjxDfBK672XACDdT0omlg7f0wxre1k6t
 GS1BEM/yzQmo3Ko9X/nu5f4RcM87r0WOkLKsXMPOnbwR7MXAwqOgrplDGyJHsxawPGN9dCvd+I+
 /D9I5Kj8JPdOVIgf8+hRxyHhqJNkQsLwFTxx1BryK6hUBg7t3w
X-Received: by 2002:a5d:5f53:0:b0:43c:fbfa:20a3 with SMTP id
 ffacd0b85a97d-43d150de613mr132096f8f.45.1774971596758; 
 Tue, 31 Mar 2026 08:39:56 -0700 (PDT)
X-Received: by 2002:a5d:5f53:0:b0:43c:fbfa:20a3 with SMTP id
 ffacd0b85a97d-43d150de613mr132040f8f.45.1774971596249; 
 Tue, 31 Mar 2026 08:39:56 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d0a3:d82:4779:43c9:77a3?
 (p200300cfd737d0a30d82477943c977a3.dip0.t-ipconnect.de.
 [2003:cf:d737:d0a3:d82:4779:43c9:77a3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf245e4b9sm25720035f8f.20.2026.03.31.08.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 08:39:55 -0700 (PDT)
Message-ID: <a8dbada7-6b22-4e9e-9fe6-b3244832d764@redhat.com>
Date: Tue, 31 Mar 2026 17:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix crash after setting latency historygram with
 single bin
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20260331102608.60882-1-kwolf@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260331102608.60882-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

On 31.03.26 12:26, Kevin Wolf wrote:
> Passing an empty list of boundaries to block-latency-histogram-set sets
> up a state that leads to a NULL pointer dereference when the next
> request should be accounted for. This is not a useful configuration, so
> just error out if the user tries to set it.
>
> The crash can easily be reproduced with the following script:
>
>      qmp() {
>      cat <<EOF
>      {'execute':'qmp_capabilities'}
>      {'execute':'block-latency-histogram-set',
>       'arguments': {'id':'ide0','boundaries':[]}}
>      {'execute':'cont'}
>      EOF
>      }
>
>      qmp | ./qemu-system-x86_64 -S -qmp stdio \
>          -drive if=none,format=raw,file=null-co:// \
>          -device ide-hd,drive=none0,id=ide0
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/accounting.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

(Though the subject should probably say "histogram" instead of 
"historygram")


