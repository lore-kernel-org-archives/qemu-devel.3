Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16E4E8784A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJSc-0000eQ-0P; Tue, 03 Feb 2026 11:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnJSX-0000dq-PN
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:41:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnJSW-00079y-9t
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770136858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A0pomJCXLo8N8RBqYvr7+cVK1+oh+v10a+g80ZEns2o=;
 b=V//6T5+Mll25ajL6hUGXl4rr4B8NMRbR86yNjq5NAa+LqgiMU4cSi5LwoGNshoVihpowYu
 SAOxKPkbxEhwnw4a3BYueC8wlruINLYZNrBYnC6p5ZJpdbmF56XESTXa8AhgeM6ATt0f2K
 mgiewPq9ML32Xr8CLGC7lEN9OQLV74k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Xej4F8VVNS6Wn52ohT2bbQ-1; Tue, 03 Feb 2026 11:40:57 -0500
X-MC-Unique: Xej4F8VVNS6Wn52ohT2bbQ-1
X-Mimecast-MFC-AGG-ID: Xej4F8VVNS6Wn52ohT2bbQ_1770136855
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47ee33324e8so51214545e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 08:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770136855; x=1770741655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=A0pomJCXLo8N8RBqYvr7+cVK1+oh+v10a+g80ZEns2o=;
 b=c2X7fvGKGL90f0zm3h5wNiNsjJc7sWjgNBQbhJfrVd5OYW2LeDO7pG2T4cj7iPAFCf
 9q7JtKkrPnfsNc/UaYv4kkbtkcIamEpaECN5y3dXZzK/CGnDQYsxrf2WpqBqHNaIgvcE
 kEyO4GoBBoSTnxWcB4Zb1VxfvlCcGp3/wJJLEUF0ZHo5BUEg+S4kFEJr+vP+Ty0OsivL
 NU8YKz3MG7i+3akaXFksY68CoqVttVZY4fUjc/sc3BoNtwzKlgFvOzG0MJrj58yorvV1
 dB90GQ9e+jh3pNdhbVamLVMG8QKjeNjNX6VP+TleBzSL35+wyMh8blyJpDlMmsRlftmK
 BNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770136855; x=1770741655;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0pomJCXLo8N8RBqYvr7+cVK1+oh+v10a+g80ZEns2o=;
 b=hvHGlSMLLxuR4qCr5TM8OGOIl5MV3Z309bW8bpAyxjFQ9QdO7r/R8mRiAq106hzcSN
 z+xo3uF/9Hun6JNSRxbM4CC6ec/g34kuu1L3PVny+Qn/CM8/O3cdDOOFuIKpNBjfWrtl
 Nlscflob1Yd21yL7uME69GldosbEa7qDZdjVT7W7vR78Rwa1dj//4roDM69YdkDmjgru
 /NTyjdSHLYhMuemVKARvyHSPpxDJPJqtcP6NYCM7KSNms0pKpL7aFDf41P2k3KtJL9HZ
 ai40h1WAZ4/XUJ+u2tMAbo6OggS/AxSwI5iAipasNN90XVute2omPow0LjYNcXjY53eW
 v3/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2k1nmgeRZW4NbfbMkNW/ZwmgNpGltZSEmnsz7kqYh5j659oR7211zoBcJA0zwjgJEZmUTHDCb3BmD@nongnu.org
X-Gm-Message-State: AOJu0Ywa5XGZhQO+zepoa0Rq+55trvDd5Q/zcNn02GB+TTOeA/zY8T94
 dxq1TaPV2P1Js8ZfT9WSIc7lnY8KGRrODEoPhHOJJlywUgoayAOsed9d7ngFLP+k3JQxGVZsLr1
 YvW3cryM+Myal0jKPfZ4OEnrbbh1sS4bZrmgDh0HmX0mEDOx6OvGRtXUG
X-Gm-Gg: AZuq6aIpORJ2at7LBd8DtTfW6x3Re0vYapZqQlK91xf1fnTeY9LqAtVmn5qTUzcJUUA
 BIRsGzZ69Znp+PWr0KU3pFq8kW9aDwcL6ZVzDsrxD7PO+xn0MzOI5Pr5Ho0PoIlVoQ8s6V+iRsr
 HjIwhUA9TH9hWvyvh5m4gZs0hq9WbDc9ufUnvAHAkgH7olY+EuvHlHZAX/TB9boOQcNVZ08FxXQ
 FgdLNOHqGWX1RmsdCToYcsl5f2zfVXYp17q80UzdaBcBdD5+zJTZKLCoOMulAejB5yMrzHu5D+3
 Xg/E6JNO9x+Qw5ajmLxVO4mAlgXgrq/t2p39KOA1PrLV0OGni3LTIJl73EKBdwQ9p+YcVcWSSKH
 HZn0uhv5IvulH0q6uPqb3KaHrivnLiVmT4Ta4w8QTOnuy8uVf
X-Received: by 2002:a05:600c:1f08:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-4830e99b62fmr2998925e9.29.1770136855152; 
 Tue, 03 Feb 2026 08:40:55 -0800 (PST)
X-Received: by 2002:a05:600c:1f08:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-4830e99b62fmr2998555e9.29.1770136854687; 
 Tue, 03 Feb 2026 08:40:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cefdsm54322149f8f.23.2026.02.03.08.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 08:40:53 -0800 (PST)
Message-ID: <edfb39f8-9160-4a77-ba6b-a1ad7834c5cc@redhat.com>
Date: Tue, 3 Feb 2026 17:40:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] vfio/pci: Add multifunction atomic ops support
To: Manojlo Pekovic <manojlo.pekovic@amd.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, Nikola.Prica@amd.com,
 Dejan.Andjelkovic@amd.com, Manojlo Pekovic <mpekovic@amd.com>
References: <20260203154112.1668-1-manojlo.pekovic@amd.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260203154112.1668-1-manojlo.pekovic@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/3/26 16:41, Manojlo Pekovic wrote:
> From: Manojlo Pekovic <mpekovic@amd.com>
> 
> This series extends PCIe Atomic Ops completer support to multifunction
> vfio-pci devices.
> It is an update on previously discussed issues
> 
> Patch 1 refactors the existing atomic capability checking logic into
> a reusable helper function.
> 
> Patch 2 extends the support to multifunction devices by calculating
> the intersection of atomic capabilities across all functions, deferring
> configuration to machine_done time when all functions are realized.
> 
> Manojlo Pekovic (2):
>    vfio/pci: Refactor atomic capability checking
>    vfio/pci: Support multifunction atomic ops capability
> 
>   hw/vfio/pci.c | 177 +++++++++++++++++++++++++++++++++++++++++++++-----
>   hw/vfio/pci.h |   1 +
>   2 files changed, 161 insertions(+), 17 deletions(-)
> 


Hello Manojlo,

I am going to ask you to resend again. Sorry about that.

Please rebase on the HEAD, tag the series as a v2 and please
add a brief changelog in the cover letter. With that, we
should be good.

Thanks,

C.


