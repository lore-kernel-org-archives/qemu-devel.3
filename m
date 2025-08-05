Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D58AC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 22:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujQD2-0001yd-AX; Tue, 05 Aug 2025 18:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ujQD0-0001yF-IH
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 18:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ujQCy-00068W-CC
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 18:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754433151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Iwalj6RPZFWq7n+6VmxfKPS0m06OuMN65PhYjp15i3Y=;
 b=g9trH6+WDxjMBUm02SQRN/vWc9H28xPgoH8/7akq8UzeFkAWS8WZSVkI7rC8Y2sSv/KMw7
 9sk/EblE0wPJcypbxs4/I3tx2tg/454Fkl12cl0/ZE0U7qfM0FoiVeYssOFiK/n+6J1jvs
 egaPuqVC+vXLfaNUM2cC25gVCdbJLV8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-oy6hfqA5NbaKXdvdYcgsjQ-1; Tue, 05 Aug 2025 18:32:30 -0400
X-MC-Unique: oy6hfqA5NbaKXdvdYcgsjQ-1
X-Mimecast-MFC-AGG-ID: oy6hfqA5NbaKXdvdYcgsjQ_1754433149
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-459d665a87aso16818965e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 15:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754433149; x=1755037949;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iwalj6RPZFWq7n+6VmxfKPS0m06OuMN65PhYjp15i3Y=;
 b=aXI9Tzg+T63b6uaEGMrR8LOg1CS1m+jpCmxjIiNCk8ztqdfeFwbT/a1ZdVfB+URebn
 eG2Xte5oD69Oyad60d3S1g2P9yUa4R8DVWppIUWBtv3Xp/xCzwQlluuHZ1nktUs5uHLk
 uARXAwkrtEf0KyeM2RaF4bGrGDX4iJi9Mgz5dWcGBACLQ7t7Ytudc5HINYPzk5riHmVH
 PIiwJdfuOCSeBYTb0og6kn+TlsFbHUpPzMU6WC+cT4zZ4jH7NQP5uan9l9uhFPJwZPxm
 FFL4BTZ4HhzIfbIOQQ17uU5kor/PHOcnBMXELxq+DeXLf3mw5/cMo231KZ+7b27jSE0Y
 I0aA==
X-Gm-Message-State: AOJu0YyNd4sJJOAwXDsUcXgRsPkCVtwy23rerdzkPKhKbHGyGySQxld3
 Y2X7a6ezNCuwzxd1gwc97BpJliLDWqHExvJeB6JQqJfnNwxIBzIOki2qaBzbmId446u9aS4o5/s
 t0263dwEwym2K6prx3GN78xTjVpp147liTxvHYgYBxoLA9PytrtGiVKxO
X-Gm-Gg: ASbGncu9Lb+q4/djmoYeNQG6isDnBDcae2YK+EgqGunOtTx38CJOsPO3BPKxgrPjzU1
 fhynlqAFC3vCrthf+AEeDkdB/EcxUYfonI+MZmcBVsOxS+1HboRmBMVMUI29xKqTHvUtLO2vugP
 5YG9KGLl219FhHkkRgpMSV2gERwRCXs9JzITbO+ZNWvjnFDWOYOSWsawFNbpAZK4ZQR/N5QXQgz
 ZuCXpfyo81Jjf/DpOr/ZegBIGxcN1m0jVedk5DepM2DOLq/X0C9tlWysJ5arpeduN34f9FRLL2f
 rGkhAhui5idHjR+/OWeFqo8jIzd5clPH20oGwoO42C8R
X-Received: by 2002:a05:600c:3b89:b0:459:ddd6:1ca3 with SMTP id
 5b1f17b1804b1-459e73bf633mr2799045e9.0.1754433148758; 
 Tue, 05 Aug 2025 15:32:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEToJvmrwnBVxgnNRWu/mnUqFzty8xbyPP5qIIPZdTBWHzYyfGUEIcIe6atkfcaK/lbnsp2g==
X-Received: by 2002:a05:600c:3b89:b0:459:ddd6:1ca3 with SMTP id
 5b1f17b1804b1-459e73bf633mr2798895e9.0.1754433148401; 
 Tue, 05 Aug 2025 15:32:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.253.173])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-459e58554f2sm20646505e9.12.2025.08.05.15.32.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 15:32:27 -0700 (PDT)
Message-ID: <3d4e5755-8512-4b01-b941-f6e763d36386@redhat.com>
Date: Wed, 6 Aug 2025 00:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tracetool: add CHECK_TRACE_EVENT_GET_STATE
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
References: <20250804112039.16377-1-tanishdesai37@gmail.com>
 <20250804112039.16377-2-tanishdesai37@gmail.com>
 <aJJliv-xKgH4piH6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aJJliv-xKgH4piH6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/5/25 22:11, Daniel P. Berrangé wrote:
> Something here is broken with the "simple" trace backend, as the entire
> '.c' file content is no longer generated, causing link errors

I think the bug is here:

+    def generate(self, event, group, check_trace_event_get_state=False):
+        self._run_function("generate_%s", event, group, check_trace_event_get_state=check_trace_event_get_state)

The default must be None, i.e. do not filter at all, instead of False.

Paolo


