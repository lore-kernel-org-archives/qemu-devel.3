Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD983C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 21:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXSIa-000462-Rq; Fri, 26 Jul 2024 17:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sXSIW-00043J-FN
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 17:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sXSIT-0003DP-Vp
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 17:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722028576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7F8ImsKbGNc5NeKHoy1SXmcW3PimF9WuzhUULHlrFxM=;
 b=em9gMqGJKdaNdtsOjg4g0J2OXvGkjNdQ007pMe7Enlew4oKqCufSfTLisk/R3pw/dI04Ia
 86f4ALt9yv7wHHFfv2nj5m0SJETzbKRWGpoiWRcVNmWjvyzzsFdItI8DbZGAODQXtRlLDI
 WJxpLMzvVbppUoWstuAckSiiJoRTlf8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-8FrfQ6HJMnSvQSJ3l0op1A-1; Fri, 26 Jul 2024 17:16:14 -0400
X-MC-Unique: 8FrfQ6HJMnSvQSJ3l0op1A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-426624f4ce3so516365e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 14:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722028573; x=1722633373;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7F8ImsKbGNc5NeKHoy1SXmcW3PimF9WuzhUULHlrFxM=;
 b=IqCO9fQe1yQZ9EE+n9VX+bC7gDW/rif1q3t6E+hysWi4L1eYPGW7NvSmwSh3wek7eE
 nP/ehAyn7TIhLs9dl7PRp+Dtwy5Hhi3ugLrXfWsSN3y5N1DdWe0pCC99eDg4B17u1uGn
 eZAoqVn8g2kHiEUVBAlDsYy2ChHP0P5zMxucrDFJCw4diC6wbZzXawMQ/8aa8zw8EAVF
 5DP0+F3H4zEDwTDp05OmyLHDZbaMsWgD0TFmDeriWK2iMRR4KW6EEqapaTAE6FFXQ06t
 EqJBMY9XGAxGl+y1M5etLdAUaIKRABMFqiVq8xcaQttWGZFVag9lZbCIK8jeveneW5q+
 uD0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm0wb2cohYwPeILug+SciwC/XSmsL8luZl/+HMPMLxKYBA4OGxf+M+uv5zkg7mtKV/+/xgFjTuTQYl4zpXM4m7iVrhol0=
X-Gm-Message-State: AOJu0Yz1yhajSP5A1BwmbvDT3Sef1vs582k4oJRObfdUMRp5QtlRpmu+
 e0WJZsCNNA7AnECARq18erTpMDJ7o36eor+Q41Yw5160RXPryRDzjRURmP630Yx6o/LpXnpXOr5
 UyP3SAfgsuDtpWbM6ncpqSHWZ2yv+JNA5Xws5QYSb1jJLTjA+HskT
X-Received: by 2002:a05:600c:1f96:b0:428:1310:b6b5 with SMTP id
 5b1f17b1804b1-4281310b8dfmr3001385e9.34.1722028573466; 
 Fri, 26 Jul 2024 14:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpSDamSUbWjNNAdbI7tIak+PUbo0F59MJAJg6t2xD+j0DyPoxwYEpP5Nm3dP5EF9ggHP0LeA==
X-Received: by 2002:a05:600c:1f96:b0:428:1310:b6b5 with SMTP id
 5b1f17b1804b1-4281310b8dfmr3001255e9.34.1722028573071; 
 Fri, 26 Jul 2024 14:16:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:a600:7ca0:23b3:d48a:97c7?
 (p200300cbc713a6007ca023b3d48a97c7.dip0.t-ipconnect.de.
 [2003:cb:c713:a600:7ca0:23b3:d48a:97c7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573edbfsm94314295e9.15.2024.07.26.14.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 14:16:12 -0700 (PDT)
Message-ID: <7744345c-964a-445d-96e3-64f71183bfba@redhat.com>
Date: Fri, 26 Jul 2024 23:16:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/s390x: move @deprecated-props to
 CpuModelExpansion Info
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com
References: <20240726203646.20279-1-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240726203646.20279-1-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On 26.07.24 22:36, Collin Walling wrote:
> The @deprecated-props array did not make any sense to be a member of the
> CpuModelInfo struct, since this field would only be populated by a
> query-cpu-model-expansion response and ignored otherwise. Move this
> field to the CpuModelExpansionInfo struct where is makes more sense.
> 
> References:
>   - https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg05996.html
>   - commit eed0e8ffa38f0695c0519508f6e4f5a3297cbd67
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
> 
> @David, the previous commit header did not align with the changes made
> here, so I tagged this as a "v1" but added the previous conversation as
> a reference.  I hope this is appropriate?

Thanks, I modified the "References" section and converted it to a "Fixes:".
It's now:

     target/s390x: move @deprecated-props to CpuModelExpansion Info
     
     The @deprecated-props array did not make any sense to be a member of the
     CpuModelInfo struct, since this field would only be populated by a
     query-cpu-model-expansion response and ignored otherwise. Move this
     field to the CpuModelExpansionInfo struct where is makes more sense.
     
     This was identified late during review [1] and we have to fix it up
     while it's not part of an official QEMU release yet.
     
     [1] https://lore.kernel.org/qemu-devel/20240719181741.35146-1-walling@linux.ibm.com/
     
     Message-ID: <20240726203646.20279-1-walling@linux.ibm.com>
     Fixes: eed0e8ffa38f ("target/s390x: filter deprecated properties based on model expansion type")
     Signed-off-by: Collin Walling <walling@linux.ibm.com>
     [ david: add "Fixes", explain why fix is required now and reference to v3 ]
     Signed-off-by: David Hildenbrand <david@redhat.com>



Can you take a quick peek at
	https://github.com/davidhildenbrand/qemu/tree/s390x-next
if everything is alright?

-- 
Cheers,

David / dhildenb


