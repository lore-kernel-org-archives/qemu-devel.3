Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0F4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4yL-0001CJ-De; Wed, 12 Aug 2026 05:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wu4yK-0001Bc-6u
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 05:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wu4yI-0001iv-Ii
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 05:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786525801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XMys7fGg9+Du+oGoQXQt3BYrsdB68Zl21vr+/B9GrVw=;
 b=Yo9jqhEuxSExeABIIiLT8AN1KVn7B3IDHOZgeO7BAQJub8U2/s2asRKkuxh6ShuSOFkkqI
 8XpVo3TVFXN3fYMrbKQiizHgJzb6tHw0LKLlioH4T102aVGSlyEVRB2Q7wkwQLpnXZWt7Q
 tgMukUGO+o2wumUYxP8VLPKIOxrCFaM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-j8B-bGALNC-wv-yKETBhqg-1; Wed, 12 Aug 2026 05:09:53 -0400
X-MC-Unique: j8B-bGALNC-wv-yKETBhqg-1
X-Mimecast-MFC-AGG-ID: j8B-bGALNC-wv-yKETBhqg_1786525792
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f835ac1aeso461106f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786525792; x=1787130592; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XMys7fGg9+Du+oGoQXQt3BYrsdB68Zl21vr+/B9GrVw=;
 b=eMmzj2y//aQnb7B/zflV9lZHIUTX/eJGRH1plOS9yhPwapsEX7O7Fo4Qj15CGQ3LUZ
 wxePEyqcFOSVxJAGDuM2D5+asN2dcmUalt76KN6sKwl2UL35em0nTzhSbxic6u4ad4ho
 a6Tm01oyYu1gyQNMRDdUXfMS62LQhOHhlwaI/jvIVDw+gK2JYLDKf4lbVTIwmlj7rKDm
 pf8pCxZMtICBUas6M9NaSvGJ5JBCJM+RUulYqrUglgTPjWaALu49x57r+qEnA79ii4R4
 bn4g47PzY8kR0rKBfdlKTEBIN4DQLY17K+3G/cTa8fphxvHj5AF3x9q/B+fN5yqshXVv
 FWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786525792; x=1787130592;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XMys7fGg9+Du+oGoQXQt3BYrsdB68Zl21vr+/B9GrVw=;
 b=dB6O4n3pTOvlJJ+efRSPBAN1SuLTuLvUmjq6r1uPNxdhJUpF03sBZXVQ0YEMLSvz2c
 gGavI8xPqsmEUdb+fy8VyqjuUzR8dJcWoW5NzaTM8uHnyBb7q2doH9ygCLHjmH7Uw3XD
 59/r/OgSKeTt5iHyOUuDkFhg8lREMhT11/GAxmEE3lzw93Om8raLeBhJBlaowWv+/9Wb
 lD0mIpulmHyV/J/lZ9SjQ+VY1AGdLCOD8Vf6CUdzE6knkcPvC0eSRdmenhB8mSfx1p4d
 FGGd2tea5Xavvba07CCNYbFa4FONHiIAS4AtcHDx3hEiF3z4MHjDzje8hAD1jhLUL29u
 wohg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpD/cAV9Mr4YppxKumHEfruWRgIpQaorY6omtkeV4DjirTwWUGsW7PxfZ0xX6Qlvr32zP/VjDvquHfk@nongnu.org
X-Gm-Message-State: AOJu0YwwtlbvrU0Wb2730FZ1EOqWjr6WGN3O4uw6+PSvBVdEkgpfRmL9
 11hCa6+qtH4Lm9E4pF6CHx5oBL3mt6EUNGox1MQYfYY2Q58l68Tr5AUwm3GHRtrR614p3LU2pYp
 pryTOEUnXgU5+fxhtYlSOSa0XuCDrM5c5+8hCEheC55EyMKhqqsVIv9o8
X-Gm-Gg: AR+sD11cYyu4pa6K1Ddt+dBf9p1bChv1iSypAJ7mVQrM+ne4PNGWPFnTTzl1qoVpMi9
 l++JuwVnoj2V9EXxwxvtNnVa6XHocldWBzq9U7B/T5vmgiobdNkKil7P+gDnblJMMGCM63f0VxH
 zCC1cOpwUoHLp2StSC5SFoLg06c88Va/5J85+lhmn/YJQ4+GNEmyy3NQzNxvn7rt19+27T5oCTf
 lc0vhTxk31JXrxVPOMS04j5d0bxQKmPPkOp/PVVZg4GAv54TGAMY8NPekNE4v8hWld4KuF5oUPp
 QVw0Cw+Tu7iPm/PulmcCwNUJvW62B5/p285WD+Uj+kATgyqKd25AXrN9M54rnzkaATcm5ypn
X-Received: by 2002:a05:600c:524c:b0:499:7410:545 with SMTP id
 5b1f17b1804b1-4997c145066mr40383125e9.12.1786525792351; 
 Wed, 12 Aug 2026 02:09:52 -0700 (PDT)
X-Received: by 2002:a05:600c:524c:b0:499:7410:545 with SMTP id
 5b1f17b1804b1-4997c145066mr40382565e9.12.1786525791962; 
 Wed, 12 Aug 2026 02:09:51 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.27]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997b353138sm36431675e9.3.2026.08.12.02.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 02:09:51 -0700 (PDT)
Message-ID: <95e5b58e-ef00-418b-97bb-9a75e6fdf1aa@redhat.com>
Date: Wed, 12 Aug 2026 11:09:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] _posts: fix 11.1 release announcement
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Michael Roth <michael.roth@amd.com>
References: <20260812083645.3830831-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260812083645.3830831-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On 12/08/2026 10.36, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   _posts/2026-08-11-qemu-11-1-0.md | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/_posts/2026-08-11-qemu-11-1-0.md b/_posts/2026-08-11-qemu-11-1-0.md
> index e2fe788..5935b00 100644
> --- a/_posts/2026-08-11-qemu-11-1-0.md
> +++ b/_posts/2026-08-11-qemu-11-1-0.md
> @@ -1,6 +1,6 @@
>   ---
>   layout: post
> -title:  "QEMU version 11.0.0 released"
> +title:  "QEMU version 11.1.0 released"
>   date:   2026-08-11 18:56:00 -0500
>   categories: [releases, 'qemu 11.1']
>   ---

Thanks, applied!

  Thomas


