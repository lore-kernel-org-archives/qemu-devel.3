Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3A3E9B249
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 10:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vupdA-0008N0-PQ; Tue, 24 Feb 2026 05:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vupd8-0008M9-VC
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:27:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vupd6-0007xh-8D
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771928819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nD9SwYkjwny6uzn/M7JYh9ZwjmTttKkIuPhKQ1H1lNw=;
 b=TrgppnBLizYHNW7jmPkyebmk49kWa4ueNza4a+FJX8/Dxw6ZOlveE4g0E3WFUzJzNjhzjY
 Du2X44OekPBHX6qBgxHcymbpVA8H07lCm3EgLq+hZwNK0jo7r/u83CMx7RuGqlgq+Ab+Y1
 sxFkwFF8WuvPbg7atjlrYqLkBzhL2p0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-2ol9zLAWO0yNOE49snEVUg-1; Tue, 24 Feb 2026 05:26:57 -0500
X-MC-Unique: 2ol9zLAWO0yNOE49snEVUg-1
X-Mimecast-MFC-AGG-ID: 2ol9zLAWO0yNOE49snEVUg_1771928816
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so54848025e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 02:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771928816; x=1772533616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nD9SwYkjwny6uzn/M7JYh9ZwjmTttKkIuPhKQ1H1lNw=;
 b=ot0cAooMx/4kdpkBBIytxslNPRRWxONBQmxWT3h3pbWDuK+6fbrt46u0fFYeT2JkEB
 ZAD5g0zIzvdwxgJxFNzzpw6yrpGXMaDS3wmAp2WcP8rKa4BdksOPmlBiTAGh4cXhxzXU
 9P9Yzqp2zcXIONvzUgmA3scqL4Ori6mQ02myzOVLxEL0GsP8WQ9VA38C8LiDSCaeV/u/
 C8QPfFpGAistg6hWNhe05TcQlvHoO0jC325MEQdbOGQVKd/KRvO50YZtxUUgP96OAsBm
 D6jLrWR7RpZzVjmHCKZntfT36/W0a0WVIMXQh7JsK/Da2fER8ddjpYyC4CChKd9yhwVV
 n28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771928816; x=1772533616;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nD9SwYkjwny6uzn/M7JYh9ZwjmTttKkIuPhKQ1H1lNw=;
 b=cwxrG49/fvjKxPisF8I/7OSYda3Wia0lLfIWj/ubBqbdOmg1/ocIfRRgG4bBzFP+G/
 NaqKYfpJb5ckoK2w6WZ46lhDLFmeDNngtqcsKi7/MbEpz4cCIIPKBPPnTLPWiF9YAySO
 iyT4/DxkdkBBFx8Ahko1lz1LddzIMQNB/ElFKckRLzglHTUMfI3PPVAcqLbU3gKLpVL6
 8Ynt882COZQMhX3WqLbqHUBl2ar+JKeHZ27YWJJR8qvHbPJo7VzCo/5J7ZBswhArAX1A
 FQT05j02eL+gqlaL/i28b9qLi2u+NBjbRSNbu1wfWUU+bE7lbaxkOeAqn4D2TGjsOos+
 9baA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH+B0rXV1FuYNNhc4Vm1Hj/1QICpsgmGB5NPpeRBZSZ4xHF9Fjy8GX2ObdHMKheBqMjHjeC/8u3y9X@nongnu.org
X-Gm-Message-State: AOJu0YydAJDt1ioR6JBfUN7vM90vx7X88/h/fzF0lsu4f1OyyU3vL1a1
 vRzmEpCsyJ3EGJbVxxd7vBaCgD0Bj3P7t9U3PBt7W+xVhi/ox/FSwiFWa6ARxY9tpo/AxZdatP9
 7QzloBLbH0ZS0LwSpQ7Yim/oqQUrmx1QBtbEEbpIS5G7sgG30V1l6JqTH
X-Gm-Gg: AZuq6aIOplt3fnMIwOXcta01cJQDL4xfD02EFvlW9IojZGyadXiXqUo6JjpjD6e9M8M
 4qXC7N6il7mZCLiNesw1TUx/Q+0lvCgZdNRx6UwYDk5YTucK2VuFsaZ1ELncees1jTbSuUtxcOx
 3X8RnUivrJ04bgOZ1+vVJzfwqMGhWz7PMznCB3hn/4ErI6aQFpAGRjyRqeiKkUoxECPuacCWtAh
 IvQShuXnbpHzj5lmPQKoBRI8AX5O9/KAkmg8tA5Idba0lB8ZWMV19X5Ih7KwOJrP3skpkl8Q4ij
 bIyJJAwg9mNVgUQTekRwhpyR28Jg1ObbWGmzm9ETQ0CdoibVScPNpXbq9FFP2RVpHBNReg0iH0E
 dT3BIbT/GkduWg6j/tVuLbnP2wEj6wGa+GQF6hoMoqNG+pMZEfLxa65xbXw2phOGwqyIeRz5i75
 4b41qPMRXzZZj6j7n/72gPAMrkFsw=
X-Received: by 2002:a05:600d:8444:20b0:483:afbb:a086 with SMTP id
 5b1f17b1804b1-483afbba1e8mr90115955e9.29.1771928815935; 
 Tue, 24 Feb 2026 02:26:55 -0800 (PST)
X-Received: by 2002:a05:600d:8444:20b0:483:afbb:a086 with SMTP id
 5b1f17b1804b1-483afbba1e8mr90115555e9.29.1771928815420; 
 Tue, 24 Feb 2026 02:26:55 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483b87db57fsm27475165e9.3.2026.02.24.02.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 02:26:54 -0800 (PST)
Message-ID: <64858ac9-9c25-405c-983b-98c1514d795b@redhat.com>
Date: Tue, 24 Feb 2026 11:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] docs: Add Nitro Enclaves documentation
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org, philmd@linaro.org,
 berrange@redhat.com, marcandre.lureau@redhat.com,
 Cornelia Huck <cohuck@redhat.com>, mst@redhat.com,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Tyler Fanelli <tfanelli@redhat.com>, mknaust@amazon.com,
 nh-open-source@amazon.com
References: <20260218015151.4052-1-graf@amazon.com>
 <20260218015151.4052-11-graf@amazon.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260218015151.4052-11-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

On 2/18/26 02:51, Alexander Graf wrote:
> +Machine
> +-------
> +
> +The ``nitro`` machine (``-M nitro``) is a minimal, architecture-independent
> +machine that provides only what a Nitro Enclave needs:
> +
> +* RAM (huge page backed via memfd)
> +* vCPUs (defaults to ``host`` CPU type)
> +* A heartbeat device (vsock server on port 9000)
> +* A serial console bridge (vsock client, debug mode only)
> +
> +Communication to the Nitro Enclave is limited to virtio-vsock. The Enclave
> +is allocated a CID at launch at which it is reachable. The CID is available
> +as QOM property in the accelerator and as a trace event.

Maybe add a sample qom-get invocation to retrieve it?

Paolo


